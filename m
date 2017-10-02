Received: from eggs.gnu.org ([2001:4830:134:3::10]:52595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dz1ti-0002l3-Rr
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dz1tf-0003rP-E2
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:40:42 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:45188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dz1tf-0003qZ-0X
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:40:39 -0400
Received: by mail-wm0-x22c.google.com with SMTP id q124so11071733wmb.0
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 07:40:38 -0700 (PDT)
References: <20170928165414.7339-1-richard.henderson@linaro.org>
	<20170928165414.7339-5-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170928165414.7339-5-richard.henderson@linaro.org>
Date: Mon, 02 Oct 2017 15:40:36 +0100
Message-ID: <87zi99zk7v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 4/9] disas: Support the Capstone
 disassembler library
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> If configured, prefer this over our rather dated copy of the
> GPLv2-only binutils.  This will be especially apparent with
> the proposed vector extensions to TCG, as disas/i386.c does
> not handle AVX.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/disas/bfd.h      |   4 +
>  include/disas/capstone.h |  38 ++++++++
>  disas.c                  | 219 ++++++++++++++++++++++++++++++++++++++++++++---
>  configure                |  26 ++++++
>  4 files changed, 274 insertions(+), 13 deletions(-)
>  create mode 100644 include/disas/capstone.h
>
> diff --git a/include/disas/bfd.h b/include/disas/bfd.h
> index b01e002b4c..0f4ecdeb88 100644
> --- a/include/disas/bfd.h
> +++ b/include/disas/bfd.h
> @@ -377,6 +377,10 @@ typedef struct disassemble_info {
>    /* Command line options specific to the target disassembler.  */
>    char * disassembler_options;
>
> +  /* Options for Capstone disassembly.  */
> +  int cap_arch;
> +  int cap_mode;
> +
>  } disassemble_info;
>
>  

> diff --git a/include/disas/capstone.h b/include/disas/capstone.h
> new file mode 100644
> index 0000000000..84e214956d
> --- /dev/null
> +++ b/include/disas/capstone.h
> @@ -0,0 +1,38 @@
> +#ifndef QEMU_CAPSTONE_H
> +#define QEMU_CAPSTONE_H 1
> +
> +#ifdef CONFIG_CAPSTONE
> +
> +#include <capstone.h>
> +
> +#else
> +
> +/* Just enough to allow backends to init without ifdefs.  */
> +
> +#define CS_ARCH_ARM     -1
> +#define CS_ARCH_ARM64   -1
> +#define CS_ARCH_MIPS    -1
> +#define CS_ARCH_X86     -1
> +#define CS_ARCH_PPC     -1
> +#define CS_ARCH_SPARC   -1
> +#define CS_ARCH_SYSZ    -1
> +
> +#define CS_MODE_LITTLE_ENDIAN    0
> +#define CS_MODE_BIG_ENDIAN       0
> +#define CS_MODE_ARM              0
> +#define CS_MODE_16               0
> +#define CS_MODE_32               0
> +#define CS_MODE_64               0
> +#define CS_MODE_THUMB            0
> +#define CS_MODE_MCLASS           0
> +#define CS_MODE_V8               0
> +#define CS_MODE_MICRO            0
> +#define CS_MODE_MIPS3            0
> +#define CS_MODE_MIPS32R6         0
> +#define CS_MODE_MIPSGP64         0
> +#define CS_MODE_V9               0
> +#define CS_MODE_MIPS32           0
> +#define CS_MODE_MIPS64           0
> +
> +#endif /* CONFIG_CAPSTONE */
> +#endif /* QEMU_CAPSTONE_H */
> diff --git a/disas.c b/disas.c
> index ad675dc361..746d76c07d 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -6,6 +6,7 @@
>
>  #include "cpu.h"
>  #include "disas/disas.h"
> +#include "disas/capstone.h"
>
>  typedef struct CPUDebug {
>      struct disassemble_info info;
> @@ -171,6 +172,192 @@ static int print_insn_od_target(bfd_vma pc, disassemble_info *info)
>      return print_insn_objdump(pc, info, "OBJD-T");
>  }
>
> +#ifdef CONFIG_CAPSTONE
> +/* Temporary storage for the capstone library.  This will be alloced via
> +   malloc with a size private to the library; thus there's no reason not
> +   to share this across calls and across host vs target disassembly.  */
> +static __thread cs_insn *cap_insn;
> +
> +/* Initialize the Capstone library.  */
> +/* ??? It would be nice to cache this.  We would need one handle for the
> +   host and one for the target.  For most targets we can reset specific
> +   parameters via cs_option(CS_OPT_MODE, new_mode), but we cannot change
> +   CS_ARCH_* in this way.  Thus we would need to be able to close and
> +   re-open the target handle with a different arch for the target in order
> +   to handle AArch64 vs AArch32 mode switching.  */
> +static cs_err cap_disas_start(disassemble_info *info, csh *handle)
> +{
> +    cs_mode cap_mode = info->cap_mode;
> +    cs_err err;
> +
> +    cap_mode += (info->endian == BFD_ENDIAN_BIG ? CS_MODE_BIG_ENDIAN
> +                 : CS_MODE_LITTLE_ENDIAN);
> +
> +    err = cs_open(info->cap_arch, cap_mode, handle);
> +    if (err != CS_ERR_OK) {
> +        return err;
> +    }
> +
> +    /* ??? There probably ought to be a better place to put this.  */
> +    if (info->cap_arch == CS_ARCH_X86) {
> +        /* We don't care about errors (if for some reason the library
> +           is compiled without AT&T syntax); the user will just have
> +           to deal with the Intel syntax.  */
> +        cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
> +    }
> +
> +    /* "Disassemble" unknown insns as ".byte W,X,Y,Z".  */
> +    cs_option(*handle, CS_OPT_SKIPDATA, CS_OPT_ON);
> +
> +    /* Allocate temp space for cs_disasm_iter.  */
> +    if (cap_insn == NULL) {
> +        cap_insn = cs_malloc(*handle);
> +        if (cap_insn == NULL) {

if (!cap_insn)?

> +            cs_close(handle);
> +            return CS_ERR_MEM;
> +        }
> +    }
> +    return CS_ERR_OK;
> +}
> +
> +/* Disassemble SIZE bytes at PC for the target.  */
> +static bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size)
> +{
> +    uint8_t cap_buf[1024];
> +    csh handle;
> +    cs_insn *insn;
> +    size_t csize = 0;
> +
> +    if (cap_disas_start(info, &handle) != CS_ERR_OK) {
> +        return false;
> +    }
> +    insn = cap_insn;
> +
> +    while (1) {
> +        size_t tsize = MIN(sizeof(cap_buf) - csize, size);
> +        const uint8_t *cbuf = cap_buf;
> +
> +        target_read_memory(pc + csize, cap_buf + csize, tsize, info);
> +        csize += tsize;
> +        size -= tsize;
> +
> +        while (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
> +            (*info->fprintf_func)(info->stream,
> +                                  "0x%08" PRIx64 ":  %-12s %s\n",
> +                                  insn->address, insn->mnemonic,
> +                                  insn->op_str);
> +        }
> +
> +        /* If the target memory is not consumed, go back for more... */
> +        if (size != 0) {
> +            /* ... taking care to move any remaining fractional insn
> +               to the beginning of the buffer.  */
> +            if (csize != 0) {

Given we are moving stuff and both size/csize are of size_t wouldn't if
(size > 0) be clearer here?

> +                memmove(cap_buf, cbuf, csize);
> +            }
> +            continue;
> +        }
> +
> +        /* Since the target memory is consumed, we should not have
> +           a remaining fractional insn.  */
> +        if (csize != 0) {

And here

> +            (*info->fprintf_func)(info->stream,
> +                "Disassembler disagrees with translator "
> +                "over instruction decoding\n"
> +                "Please report this to qemu-devel@nongnu.org\n");
> +        }
> +        break;
> +    }
> +
> +    cs_close(&handle);
> +    return true;
> +}
> +
> +/* Disassemble SIZE bytes at CODE for the host.  */
> +static bool cap_disas_host(disassemble_info *info, void *code, size_t size)
> +{
> +    csh handle;
> +    const uint8_t *cbuf;
> +    cs_insn *insn;
> +    uint64_t pc;
> +
> +    if (cap_disas_start(info, &handle) != CS_ERR_OK) {
> +        return false;
> +    }
> +    insn = cap_insn;
> +
> +    cbuf = code;
> +    pc = (uintptr_t)code;
> +
> +    while (cs_disasm_iter(handle, &cbuf, &size, &pc, insn)) {
> +        (*info->fprintf_func)(info->stream,
> +                              "0x%08" PRIx64 ":  %-12s %s\n",
> +                              insn->address, insn->mnemonic,
> +                              insn->op_str);
> +    }
> +    if (size != 0) {
> +        (*info->fprintf_func)(info->stream,
> +            "Disassembler disagrees with TCG over instruction encoding\n"
> +            "Please report this to qemu-devel@nongnu.org\n");
> +    }
> +
> +    cs_close(&handle);
> +    return true;
> +}
> +
> +#if !defined(CONFIG_USER_ONLY)
> +/* Disassemble COUNT insns at PC for the target.  */
> +static bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
> +{
> +    uint8_t cap_buf[32];
> +    csh handle;
> +    cs_insn *insn;
> +    size_t csize = 0;
> +
> +    if (cap_disas_start(info, &handle) != CS_ERR_OK) {
> +        return false;
> +    }
> +    insn = cap_insn;
> +
> +    while (1) {
> +        /* We want to read memory for one insn, but generically we do not
> +           know how much memory that is.  We have a small buffer which is
> +           known to be sufficient for all supported targets.  Try to not
> +           read beyond the page, Just In Case.  For even more simplicity,
> +           ignore the actual target page size and use a 1k boundary.  If
> +           that turns out to be insufficient, we'll come back around the
> +           loop and read more.  */
> +        uint64_t epc = QEMU_ALIGN_UP(pc + csize + 1, 1024);
> +        size_t tsize = MIN(sizeof(cap_buf) - csize, epc - pc);
> +        const uint8_t *cbuf = cap_buf;
> +
> +        /* Make certain that we can make progress.  */
> +        assert(tsize != 0);
> +        info->read_memory_func(pc, cap_buf + csize, tsize, info);
> +        csize += tsize;
> +
> +        if (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
> +            (*info->fprintf_func)(info->stream,
> +                                  "0x%08" PRIx64 ":  %-12s %s\n",
> +                                  insn->address, insn->mnemonic,
> +                                  insn->op_str);
> +            if (--count <= 0) {
> +                break;
> +            }
> +        }
> +        memmove(cap_buf, cbuf, csize);
> +    }
> +
> +    cs_close(&handle);
> +    return true;
> +}
> +#endif /* !CONFIG_USER_ONLY */
> +#else
> +# define cap_disas_target(i, p, s)  false
> +# define cap_disas_host(i, p, s)  false
> +# define cap_disas_monitor(i, p, c)  false
> +#endif /* CONFIG_CAPSTONE */
> +
>  /* Disassemble this for me please... (debugging).  */
>  void target_disas(FILE *out, CPUState *cpu, target_ulong code,
>                    target_ulong size)
> @@ -188,6 +375,8 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
>      s.info.buffer_vma = code;
>      s.info.buffer_length = size;
>      s.info.print_address_func = generic_print_address;
> +    s.info.cap_arch = -1;
> +    s.info.cap_mode = 0;
>
>  #ifdef TARGET_WORDS_BIGENDIAN
>      s.info.endian = BFD_ENDIAN_BIG;
> @@ -199,6 +388,10 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
>          cc->disas_set_info(cpu, &s.info);
>      }
>
> +    if (s.info.cap_arch >= 0 && cap_disas_target(&s.info, code, size)) {
> +        return;
> +    }
> +
>      if (s.info.print_insn == NULL) {
>          s.info.print_insn = print_insn_od_target;
>      }
> @@ -206,18 +399,6 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
>      for (pc = code; size > 0; pc += count, size -= count) {
>  	fprintf(out, "0x" TARGET_FMT_lx ":  ", pc);
>  	count = s.info.print_insn(pc, &s.info);
> -#if 0
> -        {
> -            int i;
> -            uint8_t b;
> -            fprintf(out, " {");
> -            for(i = 0; i < count; i++) {
> -                target_read_memory(pc + i, &b, 1, &s.info);
> -                fprintf(out, " %02x", b);
> -            }
> -            fprintf(out, " }");
> -        }
> -#endif
>  	fprintf(out, "\n");
>  	if (count < 0)
>  	    break;
> @@ -245,6 +426,8 @@ void disas(FILE *out, void *code, unsigned long size)
>      s.info.buffer = code;
>      s.info.buffer_vma = (uintptr_t)code;
>      s.info.buffer_length = size;
> +    s.info.cap_arch = -1;
> +    s.info.cap_mode = 0;
>
>  #ifdef HOST_WORDS_BIGENDIAN
>      s.info.endian = BFD_ENDIAN_BIG;
> @@ -282,6 +465,11 @@ void disas(FILE *out, void *code, unsigned long size)
>  #elif defined(__hppa__)
>      print_insn = print_insn_hppa;
>  #endif
> +
> +    if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size)) {
> +        return;
> +    }
> +
>      if (print_insn == NULL) {
>          print_insn = print_insn_od_host;
>      }
> @@ -344,8 +532,9 @@ void monitor_disas(Monitor *mon, CPUState *cpu,
>      monitor_disas_is_physical = is_physical;
>      s.info.read_memory_func = monitor_read_memory;
>      s.info.print_address_func = generic_print_address;
> -
>      s.info.buffer_vma = pc;
> +    s.info.cap_arch = -1;
> +    s.info.cap_mode = 0;
>
>  #ifdef TARGET_WORDS_BIGENDIAN
>      s.info.endian = BFD_ENDIAN_BIG;
> @@ -357,6 +546,10 @@ void monitor_disas(Monitor *mon, CPUState *cpu,
>          cc->disas_set_info(cpu, &s.info);
>      }
>
> +    if (s.info.cap_arch >= 0 && cap_disas_monitor(&s.info, pc, nb_insn)) {
> +        return;
> +    }
> +
>      if (!s.info.print_insn) {
>          monitor_printf(mon, "0x" TARGET_FMT_lx
>                         ": Asm output not supported on this arch\n", pc);
> diff --git a/configure b/configure
> index 6587e8014b..3777db91b6 100755
> --- a/configure
> +++ b/configure
> @@ -367,6 +367,7 @@ opengl_dmabuf="no"
>  cpuid_h="no"
>  avx2_opt="no"
>  zlib="yes"
> +capstone=""
>  lzo=""
>  snappy=""
>  bzip2=""
> @@ -1286,6 +1287,10 @@ for opt do
>            error_exit "vhost-user isn't available on win32"
>        fi
>    ;;
> +  --disable-capstone) capstone="no"
> +  ;;
> +  --enable-capstone) capstone="yes"
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1533,6 +1538,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    vxhs            Veritas HyperScale vDisk backend support
>    crypto-afalg    Linux AF_ALG crypto backend driver
>    vhost-user      vhost-user support
> +  capstone        capstone disassembler support
>
>  NOTE: The object files are built at the place where configure is launched
>  EOF
> @@ -4371,6 +4377,22 @@ EOF
>  fi
>
>  ##########################################
> +# capstone
> +
> +if test "$capstone" != no; then
> +  if $pkg_config capstone; then
> +    capstone=yes
> +    QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags capstone)"
> +    LIBS="$($pkg_config --libs capstone) $LIBS"
> +  else
> +    if test "$capstone" = yes; then
> +      feature_not_found capstone
> +    fi
> +    capstone=no
> +  fi
> +fi
> +
> +##########################################
>  # check if we have fdatasync
>
>  fdatasync=no
> @@ -5423,6 +5445,7 @@ echo "jemalloc support  $jemalloc"
>  echo "avx2 optimization $avx2_opt"
>  echo "replication support $replication"
>  echo "VxHS block device $vxhs"
> +echo "capstone          $capstone"
>
>  if test "$sdl_too_old" = "yes"; then
>  echo "-> Your SDL version is too old - please upgrade to have SDL support"
> @@ -6088,6 +6111,9 @@ fi
>  if test "$ivshmem" = "yes" ; then
>    echo "CONFIG_IVSHMEM=y" >> $config_host_mak
>  fi
> +if test "$capstone" = "yes" ; then
> +  echo "CONFIG_CAPSTONE=y" >> $config_host_mak
> +fi
>
>  # Hold two types of flag:
>  #   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the name on

Other than those minor nits:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
