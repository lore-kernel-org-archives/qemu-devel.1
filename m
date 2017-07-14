Received: from eggs.gnu.org ([2001:4830:134:3::10]:33349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVt5g-0004cN-48
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 01:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVt5d-0004ug-18
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 01:24:36 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVt5c-0004uK-RT
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 01:24:32 -0400
Received: by mail-qt0-x241.google.com with SMTP id v31so8766655qtb.3
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 22:24:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
	<1499238885-26161-25-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d42dd796-70c1-55c9-ff6c-9318b7d2a33a@amsat.org>
Date: Fri, 14 Jul 2017 02:24:29 -0300
MIME-Version: 1.0
In-Reply-To: <1499238885-26161-25-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 24/42] configure: add --disable-tcg
 configure option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Anthony Liguori <aliguori@us.ibm.com>

Hi Paolo,

trying "./configure --disable-docs --disable-tcg" I get:

   CC      x86_64-softmmu/exec.o
qemu/exec.c: In function ‘breakpoint_invalidate’:
qemu/exec.c:797:9: error: implicit declaration of function 
‘tb_invalidate_phys_addr’ [-Werror=implicit-function-declaration]
          tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
          ^~~~~~~~~~~~~~~~~~~~~~~
qemu/exec.c:797:9: error: nested extern declaration of 
‘tb_invalidate_phys_addr’ [-Werror=nested-externs]
cc1: all warnings being treated as errors
qemu/rules.mak:66: recipe for target 'exec.o' failed
make[1]: *** [exec.o] Error 1
Makefile:328: recipe for target 'subdir-x86_64-softmmu' failed
make: *** [subdir-x86_64-softmmu] Error 2

due to include/exec/exec-all.h:

#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr);
#else
...

On 07/05/2017 04:14 AM, Paolo Bonzini wrote:
> This lets you build without TCG (hardware accelerationor qtest only).  When
> this flag is passed to configure, it will automatically filter out the target
> list to only those that support KVM or Xen or HAX.
> 
> Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure | 26 +++++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/configure b/configure
> index ae69e96..806658c 100755
> --- a/configure
> +++ b/configure
> @@ -232,7 +232,12 @@ supported_target() {
>               return 1
>               ;;
>       esac
> -    return 0
> +    test "$tcg" = "yes" && return 0
> +    supported_kvm_target "$1" && return 0
> +    supported_xen_target "$1" && return 0
> +    supported_hax_target "$1" && return 0
> +    print_error "TCG disabled, but hardware accelerator not available for '$target'"
> +    return 1
>   }
>   
>   # default parameters
> @@ -296,6 +301,7 @@ cap_ng=""
>   attr=""
>   libattr=""
>   xfs=""
> +tcg="yes"
>   
>   vhost_net="no"
>   vhost_scsi="no"
> @@ -1033,6 +1039,10 @@ for opt do
>     ;;
>     --enable-cap-ng) cap_ng="yes"
>     ;;
> +  --disable-tcg) tcg="no"
> +  ;;
> +  --enable-tcg) tcg="yes"
> +  ;;
>     --disable-spice) spice="no"
>     ;;
>     --enable-spice) spice="yes"
> @@ -5195,7 +5205,6 @@ echo "module support    $modules"
>   echo "host CPU          $cpu"
>   echo "host big endian   $bigendian"
>   echo "target list       $target_list"
> -echo "tcg debug enabled $debug_tcg"
>   echo "gprof enabled     $gprof"
>   echo "sparse enabled    $sparse"
>   echo "strip binaries    $strip_opt"
> @@ -5250,8 +5259,12 @@ echo "ATTR/XATTR support $attr"
>   echo "Install blobs     $blobs"
>   echo "KVM support       $kvm"
>   echo "HAX support       $hax"
> +echo "TCG support       $tcg"
> +if test "$tcg" = "yes" ; then
> +    echo "TCG debug enabled $debug_tcg"
> +    echo "TCG interpreter   $tcg_interpreter"
> +fi
>   echo "RDMA support      $rdma"
> -echo "TCG interpreter   $tcg_interpreter"
>   echo "fdt support       $fdt"
>   echo "preadv support    $preadv"
>   echo "fdatasync         $fdatasync"
> @@ -5694,8 +5707,11 @@ fi
>   if test "$signalfd" = "yes" ; then
>     echo "CONFIG_SIGNALFD=y" >> $config_host_mak
>   fi
> -if test "$tcg_interpreter" = "yes" ; then
> -  echo "CONFIG_TCG_INTERPRETER=y" >> $config_host_mak
> +if test "$tcg" = "yes"; then
> +  echo "CONFIG_TCG=y" >> $config_host_mak
> +  if test "$tcg_interpreter" = "yes" ; then
> +    echo "CONFIG_TCG_INTERPRETER=y" >> $config_host_mak
> +  fi
>   fi
>   if test "$fdatasync" = "yes" ; then
>     echo "CONFIG_FDATASYNC=y" >> $config_host_mak
> 
