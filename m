Received: from eggs.gnu.org ([2001:4830:134:3::10]:37537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSJBv-00028W-Mq
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSJBr-0000pM-O7
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:28:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dSJBr-0000oX-EJ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:28:11 -0400
Date: Tue, 4 Jul 2017 09:28:05 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170704082805.GA3135@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-2-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499099693-22903-2-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/22] configure: factor out list of
 supported Xen/KVM/HAX targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

On Mon, Jul 03, 2017 at 06:34:32PM +0200, Paolo Bonzini wrote:
> This will be useful when the functions are called, early in the configure
> process, to filter out targets that do not support hardware acceleration.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure | 90 ++++++++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 55 insertions(+), 35 deletions(-)
> 
> diff --git a/configure b/configure
> index c571ad1..0f14e79 100755
> --- a/configure
> +++ b/configure
> @@ -163,6 +163,50 @@ have_backend () {
>      echo "$trace_backends" | grep "$1" >/dev/null
>  }
>  
> +glob() {
> +    eval test -z '"${1#'"$2"'}"'
> +}
> +
> +supported_hax_target() {
> +    test "$hax" = "yes" || return 1
> +    glob "$1" "*-softmmu" || return 1
> +    case "${1%-softmmu}" in
> +        i386|x86_64)
> +            return 0
> +        ;;
> +    esac
> +    return 1
> +}
> +
> +supported_kvm_target() {
> +    test "$kvm" = "yes" || return 1
> +    glob "$1" "*-softmmu" || return 1
> +    case "${1%-softmmu}:$cpu" in
> +        arm:arm | aarch64:aarch64 | \
> +        i386:i386 | i386:x86_64 | i386:x32 | \
> +        x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \

IIUC, 'x86_64:i386' is claiming that you can run x86_64
KVM guests on an i386 host. I thought that was impossible,
only 32-on-64 being allowed not 64-on-32.


> +        mips:mips | mipsel:mips | \
> +        ppc:ppc | ppcemb:ppc | ppc64:ppc | \
> +        ppc:ppc64 | ppcemb:ppc64 | ppc64:ppc64 | \

Same question here with ppc64:ppc suggesting you can
run 64-bit guest with KVM on a 32-bit host ?

> +        s390x:s390x)
> +            return 0
> +        ;;
> +    esac
> +    return 1
> +}
> +
> +supported_xen_target() {
> +    test "$xen" = "yes" || return 1
> +    glob "$1" "*-softmmu" || return 1
> +    case "${1%-softmmu}:$cpu" in
> +        arm:arm | aarch64:aarch64 | \
> +        i386:i386 | i386:x86_64 | x86_64:i386 | x86_64:x86_64)

This again is claiming support for 64-bit guests with Xen on a
32-bit host, which AFAIK is impossible.

> +            return 0
> +        ;;
> +    esac
> +    return 1
> +}

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
