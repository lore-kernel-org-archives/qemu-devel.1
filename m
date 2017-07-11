Received: from eggs.gnu.org ([2001:4830:134:3::10]:50830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUrsz-0000mT-Jg
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUrsu-0008Oc-TH
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:55:17 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:32956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUrsu-0008Mt-Mz
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:55:12 -0400
Received: by mail-wr0-f176.google.com with SMTP id r103so175905130wrb.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 02:55:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170711082326.12990-1-pbonzini@redhat.com>
References: <20170711082326.12990-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 10:53:49 +0100
Message-ID: <CAFEAcA_JuAm-xamF4Jc6UGqQ8YQyyJqEg8SYtoetawhVJVKq+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build: disable Xen on ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>

On 11 July 2017 at 09:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
> While ARM could present the xenpv machine, it does not and trying to enab=
le
> it breaks compilation.
>
> Fixes: 3b6b75506de44c5070639943c30a0ad5850f5d02
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/configure b/configure
> index a2bec60a97..97b02244fe 100755
> --- a/configure
> +++ b/configure
> @@ -203,7 +203,6 @@ supported_xen_target() {
>      test "$xen" =3D "yes" || return 1
>      glob "$1" "*-softmmu" || return 1
>      case "${1%-softmmu}:$cpu" in
> -        arm:arm | aarch64:aarch64 | \
>          i386:i386 | i386:x86_64 | x86_64:i386 | x86_64:x86_64)
>              return 0
>          ;;

Does this actually do the right thing? It's still testing
target-cpu:guest-cpu, if I'm reading it correctly, whereas
previously we only looked at target-cpu to decide whether
to set CONFIG_XEN.

In particular, I thought that for aarch64/arm Xen setups
we would end up building an i386-softmmu target on an
arm/aarch64 host and wanted CONFIG_XEN to be set in that
setup ?  (I could be wrong there -- cc'ing Stefan and
Anthony to check.)

thanks
-- PMM
