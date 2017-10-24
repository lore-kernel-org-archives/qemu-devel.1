Received: from eggs.gnu.org ([2001:4830:134:3::10]:53477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e72Kj-0003kZ-1D
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e72Kf-0005pb-3C
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:45:41 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:54215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e72Ke-0005pO-UH
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:45:37 -0400
Received: by mail-qt0-x241.google.com with SMTP id n61so31219981qte.10
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 09:45:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171022004621.28372-1-richard.henderson@linaro.org>
	<20171022004621.28372-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <14d023ad-e635-3a56-533b-2575a03266c4@amsat.org>
Date: Tue, 24 Oct 2017 13:45:07 -0300
MIME-Version: 1.0
In-Reply-To: <20171022004621.28372-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 11/11] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Hi Richard,

On 10/21/2017 09:46 PM, Richard Henderson wrote:
> Do not require the submodule, but use it if present.  Allow the
> command-line to override system or git submodule either way.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  Makefile    | 13 +++++++++++++
>  .gitmodules |  3 +++
>  capstone    |  1 +
>  configure   | 60 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
>  4 files changed, 66 insertions(+), 11 deletions(-)
>  create mode 160000 capstone
> 
> diff --git a/Makefile b/Makefile
> index 9372742f86..beecc85bee 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -383,6 +383,19 @@ subdir-dtc: .git-submodule-status dtc/libfdt dtc/tests
>  dtc/%: .git-submodule-status
>  	mkdir -p $@
>  
> +# Overriding CFLAGS causes us to lose defines added in the sub-makefile.
> +# Not overriding CFLAGS leads to mis-matches between compilation modes.
> +# Therefore we replicate some of the logic in the sub-makefile.

I'm having plenty of "missing-prototypes" warnings:

arch/X86/X86IntelInstPrinter.c:354:6: warning: no previous prototype for
‘printSrcIdx8’ [-Wmissing-prototypes]
 void printSrcIdx8(MCInst *MI, unsigned OpNo, SStream *O)
      ^~~~~~~~~~~~
arch/X86/X86IntelInstPrinter.c:361:6: warning: no previous prototype for
‘printSrcIdx16’ [-Wmissing-prototypes]
 void printSrcIdx16(MCInst *MI, unsigned OpNo, SStream *O)
      ^~~~~~~~~~~~~
arch/X86/X86IntelInstPrinter.c:368:6: warning: no previous prototype for
‘printSrcIdx32’ [-Wmissing-prototypes]
 void printSrcIdx32(MCInst *MI, unsigned OpNo, SStream *O)
      ^~~~~~~~~~~~~
arch/X86/X86IntelInstPrinter.c:375:6: warning: no previous prototype for
‘printSrcIdx64’ [-Wmissing-prototypes]
 void printSrcIdx64(MCInst *MI, unsigned OpNo, SStream *O)
      ^~~~~~~~~~~~~
arch/X86/X86IntelInstPrinter.c:382:6: warning: no previous prototype for
‘printDstIdx8’ [-Wmissing-prototypes]
 void printDstIdx8(MCInst *MI, unsigned OpNo, SStream *O)
      ^~~~~~~~~~~~
arch/X86/X86IntelInstPrinter.c:389:6: warning: no previous prototype for
‘printDstIdx16’ [-Wmissing-prototypes]
 void printDstIdx16(MCInst *MI, unsigned OpNo, SStream *O)
      ^~~~~~~~~~~~~
arch/X86/X86IntelInstPrinter.c:396:6: warning: no previous prototype for
‘printDstIdx32’ [-Wmissing-prototypes]
 void printDstIdx32(MCInst *MI, unsigned OpNo, SStream *O)
      ^~~~~~~~~~~~~
arch/X86/X86IntelInstPrinter.c:403:6: warning: no previous prototype for
‘printDstIdx64’ [-Wmissing-prototypes]
 void printDstIdx64(MCInst *MI, unsigned OpNo, SStream *O)
      ^~~~~~~~~~~~~
arch/X86/X86IntelInstPrinter.c:494:6: warning: no previous prototype for
‘X86_Intel_printInst’ [-Wmissing-prototypes]
 void X86_Intel_printInst(MCInst *MI, SStream *O, void *Info)
      ^~~~~~~~~~~~~~~~~~~
arch/ARM/ARMModule.c:63:6: warning: no previous prototype for
‘ARM_enable’ [-Wmissing-prototypes]
 void ARM_enable(void)
      ^~~~~~~~~~
arch/AArch64/AArch64Disassembler.c:260:6: warning: no previous prototype
for ‘AArch64_getInstruction’ [-Wmissing-prototypes]
 bool AArch64_getInstruction(csh ud, const uint8_t *code, size_t code_len,
      ^~~~~~~~~~~~~~~~~~~~~~
arch/AArch64/AArch64Disassembler.c:1658:6: warning: no previous
prototype for ‘AArch64_init’ [-Wmissing-prototypes]
 void AArch64_init(MCRegisterInfo *MRI)
      ^~~~~~~~~~~~
arch/AArch64/AArch64Module.c:44:6: warning: no previous prototype for
‘AArch64_enable’ [-Wmissing-prototypes]
 void AArch64_enable(void)
      ^~~~~~~~~~~~~~
arch/PowerPC/PPCDisassembler.c:368:6: warning: no previous prototype for
‘PPC_getInstruction’ [-Wmissing-prototypes]
 bool PPC_getInstruction(csh ud, const uint8_t *code, size_t code_len,
      ^~~~~~~~~~~~~~~~~~
arch/PowerPC/PPCDisassembler.c:381:6: warning: no previous prototype for
‘PPC_init’ [-Wmissing-prototypes]
 void PPC_init(MCRegisterInfo *MRI)
      ^~~~~~~~
arch/PowerPC/PPCModule.c:48:6: warning: no previous prototype for
‘PPC_enable’ [-Wmissing-prototypes]
 void PPC_enable(void)
      ^~~~~~~~~~
...

> +CAP_CFLAGS = $(subst -Werror,,$(CFLAGS) $(QEMU_CFLAGS))

missing-prototypes is the only problem I currently see with capstone
(not having header declaring prototypes and accessing them declared
extern...)

If this is enough we could use:

CAP_CFLAGS = $(CFLAGS) $(QEMU_CFLAGS) -Wno-error -Wno-missing-prototypes

Or if we believe upstream capstone is perfect :)

CAP_CFLAGS = $(CFLAGS) $(QEMU_CFLAGS) -w

Whichever you prefer:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
> +CAP_CFLAGS += -DCAPSTONE_HAS_ARM
> +CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
> +CAP_CFLAGS += -DCAPSTONE_HAS_POWERPC
> +CAP_CFLAGS += -DCAPSTONE_HAS_X86
> +
> +subdir-capstone: .git-submodule-status
> +	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" CC="$(CC)" AR="$(AR)" LD="$(LD)" CFLAGS="$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/libcapstone.a)
> +
>  $(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
>  	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
>  
> diff --git a/.gitmodules b/.gitmodules
> index 7c981a42b6..1500579638 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -37,3 +37,6 @@
>  [submodule "ui/keycodemapdb"]
>  	path = ui/keycodemapdb
>  	url = git://git.qemu.org/keycodemapdb.git
> +[submodule "capstone"]
> +	path = capstone
> +	url = git://git.qemu.org/capstone.git
> diff --git a/capstone b/capstone
> new file mode 160000
> index 0000000000..a279481dbf
> --- /dev/null
> +++ b/capstone
> @@ -0,0 +1 @@
> +Subproject commit a279481dbfd54bb1e2336d771e89978cc6d43176
> diff --git a/configure b/configure
> index 26e5ce7787..2807569f9f 100755
> --- a/configure
> +++ b/configure
> @@ -1299,6 +1299,10 @@ for opt do
>    ;;
>    --enable-capstone) capstone="yes"
>    ;;
> +  --enable-capstone=git) capstone="git"
> +  ;;
> +  --enable-capstone=system) capstone="system"
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -4419,18 +4423,49 @@ fi
>  ##########################################
>  # capstone
>  
> -if test "$capstone" != no; then
> -  if $pkg_config capstone; then
> -    capstone=yes
> +case "$capstone" in
> +  "" | yes)
> +    if $pkg_config capstone; then
> +      capstone=system
> +    elif test -e "${source_path}/.git" ; then
> +      capstone=git
> +    elif test -e "${source_path}/capstone/Makefile" ; then
> +      capstone=internal
> +    elif test -z "$capstone" ; then
> +      capstone=no
> +    else
> +      feature_not_found "capstone" "Install capstone devel or git submodule"
> +    fi
> +    ;;
> +
> +  system)
> +    if ! $pkg_config capstone; then
> +      feature_not_found "capstone" "Install capstone devel"
> +    fi
> +    ;;
> +esac
> +
> +case "$capstone" in
> +  git | internal)
> +    if test "$capstone" = git; then
> +      git_submodules="${git_submodules} capstone"
> +    fi
> +    mkdir -p capstone
> +    QEMU_CFLAGS="$QEMU_CFLAGS -I\$(SRC_PATH)/capstone/include"
> +    LIBS="\$(BUILD_DIR)/capstone/libcapstone.a $LIBS"
> +    ;;
> +
> +  system)
>      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags capstone)"
>      LIBS="$($pkg_config --libs capstone) $LIBS"
> -  else
> -    if test "$capstone" = yes; then
> -      feature_not_found capstone
> -    fi
> -    capstone=no
> -  fi
> -fi
> +    ;;
> +
> +  no)
> +    ;;
> +  *)
> +    error_exit "Unknown state for capstone: $capstone"
> +    ;;
> +esac
>  
>  ##########################################
>  # check if we have fdatasync
> @@ -6165,7 +6200,7 @@ fi
>  if test "$ivshmem" = "yes" ; then
>    echo "CONFIG_IVSHMEM=y" >> $config_host_mak
>  fi
> -if test "$capstone" = "yes" ; then
> +if test "$capstone" != "no" ; then
>    echo "CONFIG_CAPSTONE=y" >> $config_host_mak
>  fi
>  
> @@ -6650,6 +6685,9 @@ done # for target in $targets
>  if [ "$dtc_internal" = "yes" ]; then
>    echo "config-host.h: subdir-dtc" >> $config_host_mak
>  fi
> +if [ "$capstone" = "git" -o "$capstone" = "internal" ]; then
> +  echo "config-host.h: subdir-capstone" >> $config_host_mak
> +fi
>  
>  if test "$numa" = "yes"; then
>    echo "CONFIG_NUMA=y" >> $config_host_mak
> 
