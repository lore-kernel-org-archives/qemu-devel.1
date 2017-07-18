Received: from eggs.gnu.org ([2001:4830:134:3::10]:57733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXP8O-0005lp-QW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXP8L-0005VZ-HJ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:49:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXP8L-0005VE-6Y
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:49:37 -0400
Date: Tue, 18 Jul 2017 10:49:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170718094931.GE11927@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1500055451-14041-1-git-send-email-longpeng.mike@gmail.com>
	<1500055451-14041-13-git-send-email-longpeng.mike@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1500055451-14041-13-git-send-email-longpeng.mike@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 12/18] crypto: introduce some common
 functions for af_alg backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: longpeng.mike@gmail.com
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, weidong.huang@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

On Fri, Jul 14, 2017 at 02:04:05PM -0400, longpeng.mike@gmail.com wrote:
> From: "Longpeng(Mike)" <longpeng2@huawei.com>
> 
> The AF_ALG socket family is the userspace interface for linux
> crypto API, this patch adds af_alg family support and some common
> functions for af_alg backend. It'll be used by afalg-backend crypto
> latter.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  configure            |  30 +++++++++++++
>  crypto/Makefile.objs |   1 +
>  crypto/afalg.c       | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  crypto/afalgpriv.h   |  54 ++++++++++++++++++++++++
>  4 files changed, 201 insertions(+)
>  create mode 100644 crypto/afalg.c
>  create mode 100644 crypto/afalgpriv.h
> 
> diff --git a/configure b/configure
> index 902653a..4beab2a 100755
> --- a/configure
> +++ b/configure
> @@ -375,6 +375,7 @@ libnfs=""
>  coroutine=""
>  coroutine_pool=""
>  debug_stack_usage="no"
> +crypto_afalg="no"
>  seccomp=""
>  glusterfs=""
>  glusterfs_xlator_opt="no"
> @@ -1124,6 +1125,8 @@ for opt do
>    ;;
>    --enable-debug-stack-usage) debug_stack_usage="yes"
>    ;;
> +  --enable-crypto-afalg) crypto_afalg="yes"
> +  ;;

We should have an --disable flag too for consistency, even though it is
the default currently.

>    --disable-docs) docs="no"
>    ;;
>    --enable-docs) docs="yes"
> @@ -1443,6 +1446,8 @@ Advanced options (experts only):
>                             xen pv domain builder
>    --enable-debug-stack-usage
>                             track the maximum stack usage of stacks created by qemu_alloc_stack
> +  --enable-crypto-afalg
> +                           enable afalg-backend crypto and try to use it first.
>  
>  Optional features, enabled with --enable-FEATURE and
>  disabled with --disable-FEATURE, default is enabled if available:
> @@ -4834,6 +4839,24 @@ if compile_prog "" "" ; then
>      have_af_vsock=yes
>  fi
>  
> +##########################################
> +# check for usable AF_ALG environment
> +hava_af_alg=no

typo s/af_alg/afalg/

> +cat > $TMPC << EOF
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <linux/if_alg.h>
> +int main(void) {
> +    int sock;
> +    sock = socket(AF_ALG, SOCK_SEQPACKET, 0);
> +    return sock;
> +}
> +EOF
> +if compile_prog "" "" ; then
> +    have_afalg=yes
> +fi

If the user requests afalg and the compile test fails, we should
report an error.

> +
>  #################################################
>  # Sparc implicitly links with --relax, which is
>  # incompatible with -r, so --no-relax should be
> @@ -5300,6 +5323,7 @@ echo "seccomp support   $seccomp"
>  echo "coroutine backend $coroutine"
>  echo "coroutine pool    $coroutine_pool"
>  echo "debug stack usage $debug_stack_usage"
> +echo "crypto afalg      $crypto_afalg"
>  echo "GlusterFS support $glusterfs"
>  echo "gcov              $gcov_tool"
>  echo "gcov enabled      $gcov"
> @@ -5811,6 +5835,12 @@ if test "$debug_stack_usage" = "yes" ; then
>    echo "CONFIG_DEBUG_STACK_USAGE=y" >> $config_host_mak
>  fi
>  
> +if test "$crypto_afalg" = "yes" ; then
> +  if test "$have_afalg" = "yes" ; then

The check for have_afalg=yes is redundant if we report an error
earlier

> +    echo "CONFIG_AF_ALG=y" >> $config_host_mak
> +  fi
> +fi
> +
>  if test "$open_by_handle_at" = "yes" ; then
>    echo "CONFIG_OPEN_BY_HANDLE=y" >> $config_host_mak
>  fi

These are minor points, so I'm going to squash the following into your
change when merging:

diff --git a/configure b/configure
index 83e6f9772f..9237b50b99 100755
--- a/configure
+++ b/configure
@@ -1127,6 +1127,8 @@ for opt do
   ;;
   --enable-crypto-afalg) crypto_afalg="yes"
   ;;
+  --disable-crypto-afalg) crypto_afalg="no"
+  ;;
   --disable-docs) docs="no"
   ;;
   --enable-docs) docs="yes"
@@ -1446,8 +1448,6 @@ Advanced options (experts only):
                            xen pv domain builder
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks created by qemu_alloc_stack
-  --enable-crypto-afalg
-                           enable afalg-backend crypto and try to use it first.
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -1523,6 +1523,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   qom-cast-debug  cast debugging support
   tools           build qemu-io, qemu-nbd and qemu-image tools
   vxhs            Veritas HyperScale vDisk backend support
+  crypto-afalg    Linux AF_ALG crypto backend driver
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -4841,7 +4842,7 @@ fi
 
 ##########################################
 # check for usable AF_ALG environment
-hava_af_alg=no
+hava_afalg=no
 cat > $TMPC << EOF
 #include <errno.h>
 #include <sys/types.h>
@@ -4856,6 +4857,14 @@ EOF
 if compile_prog "" "" ; then
     have_afalg=yes
 fi
+if test "$crypto_afalg" = "yes"
+then
+    if test "$have_afalg" != "yes"
+    then
+       error_exit "AF_ALG requested but could not be detected"
+    fi
+fi
+
 
 #################################################
 # Sparc implicitly links with --relax, which is
@@ -5836,9 +5845,7 @@ if test "$debug_stack_usage" = "yes" ; then
 fi
 
 if test "$crypto_afalg" = "yes" ; then
-  if test "$have_afalg" = "yes" ; then
-    echo "CONFIG_AF_ALG=y" >> $config_host_mak
-  fi
+  echo "CONFIG_AF_ALG=y" >> $config_host_mak
 fi
 
 if test "$open_by_handle_at" = "yes" ; then


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
