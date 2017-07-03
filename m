Received: from eggs.gnu.org ([2001:4830:134:3::10]:60492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dRyTT-0007dQ-Sl
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dRyTQ-000655-2L
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:20:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dRyTP-00062x-Pv
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:20:55 -0400
Date: Mon, 3 Jul 2017 11:20:43 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170703102043.GE5663@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
	<1499076743-15477-2-git-send-email-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499076743-15477-2-git-send-email-yang.zhong@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/15] configure: add the disable-tcg
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, qemu-devel@nongnu.org, a.rigo@virtualopensystems.com

On Mon, Jul 03, 2017 at 06:12:09PM +0800, Yang Zhong wrote:
> Add the disable-tcg option into configure and echo CONFIG_TCG=y into
> $config_target_mak. The default tcg is enabled for all build, only i386
> and x86_64 softmmu option can be disabled. This operation do not make
> big change with the older build command.
> 
> The new configure build command like below
> (1)./configure
>    tcg is defaultly enabled
> 
> (2)./configure --disable-tcg --target-list=x86_64-softmmu
>    tcg is disabled in x86_64-softmmu
> 
> (3)./configure --disable-tcg --target-list=i386-softmmu
>    tcg is disabled in i386-softmmu
> 
> If the --target-list include other softmmus or user options, the configure
> command will report error and configure is aborted.
> The error as:
> ERROR: The current aarch64-softmmu can't support disable-tcg,
>     only i386-softmmu|x86_64-softmmu support disable-tcg
> or
> ERROR: The user build can't support disable-tcg,
>     only i386-softmmu|x86_64-softmmu support disable-tcg
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  configure | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index c571ad1..61ce514 100755
> --- a/configure
> +++ b/configure
> @@ -224,6 +224,7 @@ cap_ng=""
>  attr=""
>  libattr=""
>  xfs=""
> +tcg="yes"
>  
>  vhost_net="no"
>  vhost_scsi="no"
> @@ -953,6 +954,10 @@ for opt do
>    ;;
>    --enable-hax) hax="yes"
>    ;;
> +  --disable-tcg) tcg="no"
> +  ;;
> +  --enable-tcg) tcg="yes"
> +  ;;
>    --disable-tcg-interpreter) tcg_interpreter="no"
>    ;;
>    --enable-tcg-interpreter) tcg_interpreter="yes"
> @@ -1715,6 +1720,24 @@ case " $target_list " in
>    ;;
>  esac
>  
> +if test "$tcg" = "no"; then
> +   for target in $target_list; do
> +      if test "$softmmu" = "yes"; then
> +        case $target in
> +           i386-softmmu|x86_64-softmmu)
> +           ;;
> +        *)
> +           error_exit "The current $target can't support disable-tcg,"\
> +              "only i386-softmmu|x86_64-softmmu support disable-tcg"
> +           ;;

This looks too simplistic in its logic.

You can disable TCG, if-and-only-if the system emulator supports KVM.

KVM is supported on many architectures, not only x86-64 & i386.

KVM is only supported if the guest emulator architecture matches the
host build target architecture.

ie if you are building an x86_64 system emulator on a PPC64 host,
then you can't disable TCG.

So this needs rewriting to *not* special case x86_64 / i386. Instead
you need to compare & match build target / system emulator architectures,
across all architectures supporting KVM.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
