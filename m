Received: from eggs.gnu.org ([2001:4830:134:3::10]:41755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euHgS-0008D9-SD
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:03:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euHgO-0004DA-SB
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:03:40 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euHgO-0004Ai-JI
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:03:36 -0500
Received: by mail-wm0-x241.google.com with SMTP id t6so3762800wmt.5
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 05:03:36 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-24-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <968be638-272d-24b3-58b7-6309356bf648@amsat.org>
Date: Fri, 9 Mar 2018 14:03:32 +0100
MIME-Version: 1.0
In-Reply-To: <1519998711-73430-24-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 23/23] RISC-V Build Infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 03/02/2018 02:51 PM, Michael Clark wrote:
> This adds RISC-V into the build system enabling the following targets:
> 
> - riscv32-softmmu
> - riscv64-softmmu
> - riscv32-linux-user
> - riscv64-linux-user
> 
> This adds defaults configs for RISC-V, enables the build for the RISC-V
> CPU core, hardware, and Linux User Emulation. The 'qemu-binfmt-conf.sh'
> script is updated to add the RISC-V ELF magic.
> 
> Expected checkpatch errors for consistency reasons:
> 
> ERROR: line over 90 characters
> FILE: scripts/qemu-binfmt-conf.sh
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  arch_init.c                            |  2 ++
>  configure                              | 13 +++++++++++++
>  cpus.c                                 |  6 ++++++
>  default-configs/riscv32-linux-user.mak |  1 +
>  default-configs/riscv32-softmmu.mak    |  4 ++++
>  default-configs/riscv64-linux-user.mak |  1 +
>  default-configs/riscv64-softmmu.mak    |  4 ++++
>  hw/riscv/Makefile.objs                 | 11 +++++++++++
>  include/sysemu/arch_init.h             |  1 +
>  qapi-schema.json                       | 17 ++++++++++++++++-
>  scripts/qemu-binfmt-conf.sh            | 13 ++++++++++++-
>  target/riscv/Makefile.objs             |  1 +
>  12 files changed, 72 insertions(+), 2 deletions(-)
>  create mode 100644 default-configs/riscv32-linux-user.mak
>  create mode 100644 default-configs/riscv32-softmmu.mak
>  create mode 100644 default-configs/riscv64-linux-user.mak
>  create mode 100644 default-configs/riscv64-softmmu.mak
>  create mode 100644 hw/riscv/Makefile.objs
>  create mode 100644 target/riscv/Makefile.objs
> 
> diff --git a/arch_init.c b/arch_init.c
> index 4c36f2b..e157619 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -71,6 +71,8 @@ int graphic_depth = 32;
>  #define QEMU_ARCH QEMU_ARCH_OPENRISC
>  #elif defined(TARGET_PPC)
>  #define QEMU_ARCH QEMU_ARCH_PPC
> +#elif defined(TARGET_RISCV)
> +#define QEMU_ARCH QEMU_ARCH_RISCV
>  #elif defined(TARGET_S390X)
>  #define QEMU_ARCH QEMU_ARCH_S390X
>  #elif defined(TARGET_SH4)
> diff --git a/configure b/configure
> index 00c4b63..a3240a8 100755
> --- a/configure
> +++ b/configure
> @@ -6801,6 +6801,16 @@ case "$target_name" in
>      echo "TARGET_ABI32=y" >> $config_target_mak
>      gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
>    ;;
> +  riscv32)
> +    TARGET_BASE_ARCH=riscv
> +    TARGET_ABI_DIR=riscv
> +    mttcg=yes
> +  ;;
> +  riscv64)
> +    TARGET_BASE_ARCH=riscv
> +    TARGET_ABI_DIR=riscv
> +    mttcg=yes
> +  ;;
>    sh4|sh4eb)
>      TARGET_ARCH=sh4
>      bflt="yes"
> @@ -6970,6 +6980,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>    ppc*)
>      disas_config "PPC"
>    ;;
> +  riscv)
> +    disas_config "RISCV"
> +  ;;
>    s390*)
>      disas_config "S390"
>    ;;
> diff --git a/cpus.c b/cpus.c
> index af67826..407c3f8 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -2094,6 +2094,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
>  #elif defined(TARGET_SPARC)
>          SPARCCPU *sparc_cpu = SPARC_CPU(cpu);
>          CPUSPARCState *env = &sparc_cpu->env;
> +#elif defined(TARGET_RISCV)
> +        RISCVCPU *riscv_cpu = RISCV_CPU(cpu);
> +        CPURISCVState *env = &riscv_cpu->env;
>  #elif defined(TARGET_MIPS)
>          MIPSCPU *mips_cpu = MIPS_CPU(cpu);
>          CPUMIPSState *env = &mips_cpu->env;
> @@ -2133,6 +2136,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
>  #elif defined(TARGET_S390X)
>          info->value->arch = CPU_INFO_ARCH_S390;
>          info->value->u.s390.cpu_state = env->cpu_state;
> +#elif defined(TARGET_RISCV)
> +        info->value->arch = CPU_INFO_ARCH_RISCV;
> +        info->value->u.riscv.pc = env->pc;
>  #else
>          info->value->arch = CPU_INFO_ARCH_OTHER;
>  #endif
> diff --git a/default-configs/riscv32-linux-user.mak b/default-configs/riscv32-linux-user.mak
> new file mode 100644
> index 0000000..865b362
> --- /dev/null
> +++ b/default-configs/riscv32-linux-user.mak
> @@ -0,0 +1 @@
> +# Default configuration for riscv-linux-user
> diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
> new file mode 100644
> index 0000000..f9e7421
> --- /dev/null
> +++ b/default-configs/riscv32-softmmu.mak
> @@ -0,0 +1,4 @@
> +# Default configuration for riscv-softmmu
> +
> +CONFIG_SERIAL=y
> +CONFIG_VIRTIO=y
> diff --git a/default-configs/riscv64-linux-user.mak b/default-configs/riscv64-linux-user.mak
> new file mode 100644
> index 0000000..865b362
> --- /dev/null
> +++ b/default-configs/riscv64-linux-user.mak
> @@ -0,0 +1 @@
> +# Default configuration for riscv-linux-user
> diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
> new file mode 100644
> index 0000000..f9e7421
> --- /dev/null
> +++ b/default-configs/riscv64-softmmu.mak
> @@ -0,0 +1,4 @@
> +# Default configuration for riscv-softmmu
> +
> +CONFIG_SERIAL=y
> +CONFIG_VIRTIO=y
> diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> new file mode 100644
> index 0000000..1dde01d
> --- /dev/null
> +++ b/hw/riscv/Makefile.objs
> @@ -0,0 +1,11 @@
> +obj-y += riscv_htif.o
> +obj-y += riscv_hart.o
> +obj-y += sifive_e.o
> +obj-y += sifive_clint.o
> +obj-y += sifive_prci.o
> +obj-y += sifive_plic.o
> +obj-y += sifive_test.o
> +obj-y += sifive_u.o
> +obj-y += sifive_uart.o
> +obj-y += spike.o
> +obj-y += virt.o
> diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
> index d40d882..ef52ae0 100644
> --- a/include/sysemu/arch_init.h
> +++ b/include/sysemu/arch_init.h
> @@ -24,6 +24,7 @@ enum {
>      QEMU_ARCH_TRICORE = (1 << 16),
>      QEMU_ARCH_NIOS2 = (1 << 17),
>      QEMU_ARCH_HPPA = (1 << 18),
> +    QEMU_ARCH_RISCV = (1 << 19),
>  };
>  
>  extern const uint32_t arch_type;
> diff --git a/qapi-schema.json b/qapi-schema.json
> index cd98a94..0ff2ed3 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -412,10 +412,12 @@
>  #
>  # @s390: since 2.12
>  #
> +# @riscv: since 2.12
> +#
>  # Since: 2.6
>  ##
>  { 'enum': 'CpuInfoArch',
> -  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 's390', 'other' ] }
> +  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 's390', 'riscv', 'other' ] }
>  
>  ##
>  # @CpuInfo:
> @@ -455,6 +457,7 @@
>              'mips': 'CpuInfoMIPS',
>              'tricore': 'CpuInfoTricore',
>              's390': 'CpuInfoS390',
> +            'riscv': 'CpuInfoRISCV',
>              'other': 'CpuInfoOther' } }
>  
>  ##
> @@ -515,6 +518,17 @@
>  { 'struct': 'CpuInfoTricore', 'data': { 'PC': 'int' } }
>  
>  ##
> +# @CpuInfoRISCV:
> +#
> +# Additional information about a virtual RISCV CPU
> +#
> +# @pc: the instruction pointer
> +#
> +# Since 2.12
> +##
> +{ 'struct': 'CpuInfoRISCV', 'data': { 'pc': 'int' } }
> +
> +##
>  # @CpuInfoOther:
>  #
>  # No additional information is available about the virtual CPU
> @@ -625,6 +639,7 @@
>              'mips': 'CpuInfoOther',
>              'tricore': 'CpuInfoOther',
>              's390': 'CpuInfoS390',
> +            'riscv': 'CpuInfoRISCV',
>              'other': 'CpuInfoOther' } }
>  
>  ##
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index ea5a748..bdb21bd 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -4,7 +4,7 @@
>  
>  qemu_target_list="i386 i486 alpha arm armeb sparc32plus ppc ppc64 ppc64le m68k \
>  mips mipsel mipsn32 mipsn32el mips64 mips64el \
> -sh4 sh4eb s390x aarch64 aarch64_be hppa"
> +sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64"
>  
>  i386_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'
>  i386_mask='\xff\xff\xff\xff\xff\xfe\xfe\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
> @@ -100,6 +100,14 @@ hppa_magic='\x7f\x45\x4c\x46\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00
>  hppa_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
>  hppa_family=hppa
>  
> +riscv32_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xf3\x00'
> +riscv32_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
> +riscv32_family=riscv
> +
> +riscv64_magic='\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xf3\x00'
> +riscv64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
> +riscv64_family=riscv
> +
>  qemu_get_family() {
>      cpu=${HOST_ARCH:-$(uname -m)}
>      case "$cpu" in
> @@ -124,6 +132,9 @@ qemu_get_family() {
>      sparc*)
>          echo "sparc"
>          ;;
> +    riscv*)
> +        echo "riscv"
> +        ;;
>      *)
>          echo "$cpu"
>          ;;
> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
> new file mode 100644
> index 0000000..abd0a7c
> --- /dev/null
> +++ b/target/riscv/Makefile.objs
> @@ -0,0 +1 @@
> +obj-y += translate.o op_helper.o helper.o cpu.o fpu_helper.o gdbstub.o pmp.o
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
