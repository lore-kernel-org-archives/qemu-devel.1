Received: from eggs.gnu.org ([2001:4830:134:3::10]:44051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWJL0-0006ST-DQ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWJKy-0001wb-3X
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:30:42 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:41326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWJKx-0001wM-LJ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:30:40 -0400
Received: by mail-ot0-x242.google.com with SMTP id d19-v6so6960489oti.8
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 03:30:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612005145.3375-13-richard.henderson@linaro.org>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
	<20180612005145.3375-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 11:30:18 +0100
Message-ID: <CAFEAcA_TvTydOEJOmfFA8x2vgRnd+Su8osz3hRuGabWtu5ybHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 12/19] linux-user: Setup split syscall
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 12 June 2018 at 01:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Defines a unified structure for implementation and strace.
> Supplies a generator script to build the declarations and
> the lookup function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.h           | 178 +++++++++++++++
>  linux-user/strace.c            | 386 ++++++++++++++++++++++++---------
>  linux-user/syscall.c           | 113 ++++------
>  linux-user/Makefile.objs       |  10 +
>  linux-user/gen_syscall_list.py |  82 +++++++
>  5 files changed, 595 insertions(+), 174 deletions(-)
>  create mode 100644 linux-user/syscall.h
>  create mode 100644 linux-user/gen_syscall_list.py
>
> diff --git a/linux-user/syscall.h b/linux-user/syscall.h
> new file mode 100644
> index 0000000000..7eb078c3e5
> --- /dev/null
> +++ b/linux-user/syscall.h
> @@ -0,0 +1,178 @@
> +/*
> + *  Linux syscalls internals
> + *  Copyright (c) 2018 Linaro, Limited.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +typedef struct SyscallDef SyscallDef;
> +
> +/* This hook extracts max 6 arguments from max 8 input registers.
> + * In the process, register pairs that store 64-bit arguments are merged.
> + * Finally, syscalls are demultipliexed; e.g. the hook for socketcall will

"demultiplexed"

> + * return the SyscallDef for bind, listen, etc.  In the process the hook
> + * may need to read from guest memory, or otherwise validate operands.
> + * On failure, set errno (to a host value) and return NULL;
> + * the (target adjusted) errno will be returned to the guest.
> + */
> +typedef const SyscallDef *SyscallArgsFn(const SyscallDef *, int64_t out[6],
> +                                        abi_long in[8]);
> +
> +/* This hook implements the syscall.  */
> +typedef abi_long SyscallImplFn(CPUArchState *, int64_t, int64_t, int64_t,
> +                               int64_t, int64_t, int64_t);
> +
> +/* This hook prints the arguments to the syscall for strace.  */
> +typedef void SyscallPrintFn(const SyscallDef *, int64_t arg[6]);
> +
> +/* This hook print the return value from the syscall for strace.  */
> +typedef void SyscallPrintRetFn(const SyscallDef *, abi_long);
> +
> +/* These flags describe the arguments for the generic fallback to
> + * SyscallPrintFn.  ARG_NONE indicates that the argument is not present.
> + */
> +typedef enum {
> +    ARG_NONE = 0,
> +
> +    /* These print as numbers of abi_long.  */
> +    ARG_DEC,
> +    ARG_HEX,
> +    ARG_OCT,
> +
> +    /* These print as sets of flags.  */
> +    ARG_ATDIRFD,
> +    ARG_MODEFLAG,
> +    ARG_OPENFLAG,
> +
> +    /* These are interpreted as pointers.  */
> +    ARG_PTR,
> +    ARG_STR,
> +    ARG_BUF,
> +
> +    /* For a 32-bit host, force printing as a 64-bit operand.  */
> +#if TARGET_ABI_BITS == 32
> +    ARG_DEC64,
> +#else
> +    ARG_DEC64 = ARG_DEC,
> +#endif
> +} SyscallArgType;
> +
> +struct SyscallDef {
> +    const char *name;
> +    SyscallArgsFn *args;
> +    SyscallImplFn *impl;
> +    SyscallPrintFn *print;
> +    SyscallPrintRetFn *print_ret;

Are all these hook functions mandatory, or can a syscall
implementation leave some of them NULL for a default behaviour?

> +    SyscallArgType arg_type[6];
> +};
> +
> +void print_syscall_def(const SyscallDef *def, int64_t args[6]);
> +void print_syscall_def_ret(const SyscallDef *def, abi_long ret);
> +void print_syscall_ptr_ret(const SyscallDef *def, abi_long ret);
> +
> +/* Emit the signature for a SyscallArgsFn.  */
> +#define SYSCALL_ARGS(NAME) \
> +    static const SyscallDef *args_##NAME(const SyscallDef *def, \
> +                                         int64_t out[6], abi_long in[8])
> +
> +/* Emit the signature for a SyscallImplFn.  */
> +#define SYSCALL_IMPL(NAME) \
> +    static abi_long impl_##NAME(CPUArchState *cpu_env, int64_t arg1, \
> +                                int64_t arg2, int64_t arg3, int64_t arg4, \
> +                                int64_t arg5, int64_t arg6)
> +
> +/* Emit the definition for a "simple" syscall.  Such does not use
> + * SyscallArgsFn and only uses arg_type for strace.
> + */
> +#define SYSCALL_DEF(NAME, ...) \
> +    const SyscallDef def_##NAME = { \
> +        .name = #NAME, .impl = impl_##NAME, .arg_type = { __VA_ARGS__ } \
> +    }
> +
> +/* Emit the definition for a syscall that also has an args hook,
> + * and uses arg_type for strace.
> + */
> +#define SYSCALL_DEF_ARGS(NAME, ...) \
> +    const SyscallDef def_##NAME = { \
> +        .name = #NAME, .args = args_##NAME, .impl = impl_##NAME, \
> +        .arg_type = { __VA_ARGS__ } \
> +    }
> +

> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index bd897a3f20..6375feb747 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -10,6 +10,7 @@
>  #include <linux/if_packet.h>
>  #include <sched.h>
>  #include "qemu.h"
> +#include "syscall.h"
>
>  int do_strace=0;
>
> @@ -796,7 +797,7 @@ UNUSED static struct flags unlinkat_flags[] = {
>      FLAG_END,
>  };
>
> -UNUSED static struct flags mode_flags[] = {
> +static struct flags const mode_flags[] = {
>      FLAG_GENERIC(S_IFSOCK),
>      FLAG_GENERIC(S_IFLNK),
>      FLAG_GENERIC(S_IFREG),
> @@ -807,14 +808,14 @@ UNUSED static struct flags mode_flags[] = {
>      FLAG_END,
>  };
>
> -UNUSED static struct flags open_access_flags[] = {
> +static struct flags const open_access_flags[] = {
>      FLAG_TARGET(O_RDONLY),
>      FLAG_TARGET(O_WRONLY),
>      FLAG_TARGET(O_RDWR),
>      FLAG_END,
>  };
>
> -UNUSED static struct flags open_flags[] = {
> +static struct flags const open_flags[] = {
>      FLAG_TARGET(O_APPEND),
>      FLAG_TARGET(O_CREAT),
>      FLAG_TARGET(O_DIRECTORY),
> @@ -989,84 +990,86 @@ get_comma(int last)
>      return ((last) ? "" : ",");
>  }
>
> +static int add_flags(char *buf, int size, const struct flags *f,
> +                     int flags, bool octal)
> +{
> +    const char *sep = "";
> +    int off = 0;
> +
> +    if (flags == 0 && f->f_value == 0) {
> +        return snprintf(buf, size, "%s", f->f_string);
> +    }
> +
> +    for (; f->f_string != NULL; f++) {
> +        if (f->f_value != 0 && (flags & f->f_value) == f->f_value) {
> +            off += snprintf(buf + off, size - off, "%s%s", sep, f->f_string);
> +            flags &= ~f->f_value;
> +            sep = "|";
> +        }
> +    }
> +
> +    /* Print rest of the flags as numeric.  */
> +    if (flags) {
> +        if (octal) {
> +            off += snprintf(buf + off, size - off, "%s%#o", sep, flags);
> +        } else {
> +            off += snprintf(buf + off, size - off, "%s%#x", sep, flags);
> +        }
> +    }
> +    return off;
> +}
> +
>  static void
>  print_flags(const struct flags *f, abi_long flags, int last)
>  {
> -    const char *sep = "";
> -    int n;
> +    char buf[256];
> +    add_flags(buf, sizeof(buf), f, flags, false);
> +    gemu_log("%s%s", buf, get_comma(last));
> +}

All this refactoring of the strace functions feels like it
should have been in a separate patch...

>
> -    if ((flags == 0) && (f->f_value == 0)) {
> -        gemu_log("%s%s", f->f_string, get_comma(last));
> -        return;
> -    }
> -    for (n = 0; f->f_string != NULL; f++) {
> -        if ((f->f_value != 0) && ((flags & f->f_value) == f->f_value)) {
> -            gemu_log("%s%s", sep, f->f_string);
> -            flags &= ~f->f_value;
> -            sep = "|";
> -            n++;
> -        }
> -    }
> -
> -    if (n > 0) {
> -        /* print rest of the flags as numeric */
> -        if (flags != 0) {
> -            gemu_log("%s%#x%s", sep, (unsigned int)flags, get_comma(last));
> -        } else {
> -            gemu_log("%s", get_comma(last));
> -        }


> @@ -12412,12 +12353,18 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      return ret;
>  }
>
> +/* Include the generated syscall lookup function.  */
> +#include "syscall_list.inc.c"
> +
>  abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>                      abi_long arg2, abi_long arg3, abi_long arg4,
>                      abi_long arg5, abi_long arg6, abi_long arg7,
>                      abi_long arg8)
>  {
>      CPUState *cpu = ENV_GET_CPU(cpu_env);
> +    const SyscallDef *def, *orig_def;
> +    abi_long raw_args[8] = { arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 };
> +    int64_t  out_args[6] = { arg1, arg2, arg3, arg4, arg5, arg6 };
>      abi_long ret;
>
>  #ifdef DEBUG_ERESTARTSYS
> @@ -12437,16 +12384,44 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>      trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
>                               arg5, arg6, arg7, arg8);
>
> -    if (unlikely(do_strace)) {
> -        print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> -        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> -                          arg5, arg6, arg7, arg8);
> -        print_syscall_ret(num, ret);
> -    } else {
> -        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> -                          arg5, arg6, arg7, arg8);
> +    orig_def = def = syscall_table(num);
> +    if (def == NULL) {
> +        /* Unconverted.  */
> +        if (unlikely(do_strace)) {
> +            print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> +            ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> +                              arg5, arg6, arg7, arg8);
> +            print_syscall_ret(num, ret);
> +        } else {
> +            ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> +                              arg5, arg6, arg7, arg8);
> +        }
> +        goto fini;
>      }
>
> +    if (def->args) {
> +        def = def->args(def, out_args, raw_args);
> +        if (unlikely(def == NULL)) {
> +            ret = -host_to_target_errno(errno);
> +            if (unlikely(do_strace)) {
> +                print_syscall_def(orig_def, out_args);
> +                print_syscall_def_ret(orig_def, ret);
> +            }
> +            goto fini;
> +        }
> +    }
> +
> +    if (unlikely(do_strace)) {
> +        print_syscall_def(def, out_args);
> +        ret = def->impl(cpu_env, out_args[0], out_args[1], out_args[2],
> +                        out_args[3], out_args[4], out_args[5]);
> +        print_syscall_def_ret(def, ret);
> +    } else {
> +        ret = def->impl(cpu_env, out_args[0], out_args[1], out_args[2],
> +                        out_args[3], out_args[4], out_args[5]);
> +    }
> +
> + fini:
>      trace_guest_user_syscall_ret(cpu, num, ret);
>      return ret;
>  }
> diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
> index 59a5c17354..afa69ed6d2 100644
> --- a/linux-user/Makefile.objs
> +++ b/linux-user/Makefile.objs
> @@ -7,3 +7,13 @@ obj-$(TARGET_HAS_BFLT) += flatload.o
>  obj-$(TARGET_I386) += vm86.o
>  obj-$(TARGET_ARM) += arm/nwfpe/
>  obj-$(TARGET_M68K) += m68k-sim.o
> +
> +GEN_SYSCALL_LIST = $(SRC_PATH)/linux-user/gen_syscall_list.py
> +SYSCALL_LIST = linux-user/syscall_list.h linux-user/syscall_list.inc.c
> +
> +$(SYSCALL_LIST): $(GEN_SYSCALL_LIST)
> +       $(call quiet-command,\
> +         $(PYTHON) $(GEN_SYSCALL_LIST) $@, "GEN", $(TARGET_DIR)$@)
> +
> +linux-user/syscall.o \
> +linux-user/strace.o: $(SYSCALL_LIST)
> diff --git a/linux-user/gen_syscall_list.py b/linux-user/gen_syscall_list.py
> new file mode 100644
> index 0000000000..2e0fc39100
> --- /dev/null
> +++ b/linux-user/gen_syscall_list.py
> @@ -0,0 +1,82 @@
> +#
> +# Linux syscall table generator
> +# Copyright (c) 2018 Linaro, Limited.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +from __future__ import print_function
> +import sys
> +
> +# These are sets of all syscalls that have been converted.
> +# The lists are in collation order with '_' ignored.
> +
> +# These syscalls are supported by all targets.
> +# Avoiding ifdefs for these can diagnose typos in $cpu/syscall_nr.h
> +unconditional_syscalls = [
> +]
> +
> +# These syscalls are only supported by some target or abis.
> +conditional_syscalls = [
> +]
> +
> +
> +def header(f):
> +    # Do not ifdef the declarations -- their use may be complicated.
> +    all = unconditional_syscalls + conditional_syscalls
> +    all.sort()
> +    for s in all:
> +        print("extern const SyscallDef def_", s, ";", sep = '', file = f)
> +
> +
> +def def_syscall(s, f):
> +    print("    case TARGET_NR_", s, ": return &def_", s, ";",
> +          sep = '', file = f);
> +
> +
> +def source(f):
> +    print("static const SyscallDef *syscall_table(int num)",
> +          "{",
> +          "    switch (num) {",
> +          sep = '\n', file = f)
> +
> +    for s in unconditional_syscalls:
> +        def_syscall(s, f)
> +    for s in conditional_syscalls:
> +        print("#ifdef TARGET_NR_", s, sep = '', file = f)
> +        def_syscall(s, f)
> +        print("#endif", file = f)
> +
> +    print("    }",
> +          "    return NULL;",
> +          "}",
> +          sep = '\n', file = f);
> +
> +
> +def main():
> +    p = sys.argv[1]
> +    f = open(p, "w")
> +
> +    print("/* This file is autogenerated by gensyscall.py.  */\n\n",
> +          file = f)
> +
> +    if p[len(p) - 1] == 'h':
> +        header(f)
> +    else:
> +        source(f)
> +
> +    f.close();
> +
> +
> +main()

Codegen looks good to me.

thanks
-- PMM
