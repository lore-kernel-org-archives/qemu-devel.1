Received: from eggs.gnu.org ([2001:4830:134:3::10]:59419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXUHk-0005EF-KV
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXUHj-0000O9-Sn
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:24:12 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXUHj-0000Nl-OI
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:24:11 -0400
Received: by mail-oi0-x242.google.com with SMTP id e8-v6so13077257oii.2
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:24:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625160658.7315-1-pbonzini@redhat.com>
References: <20180625160658.7315-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 17:23:50 +0100
Message-ID: <CAFEAcA-8aTBLEm+ZmyffVzVdbBjqbJ4rbGg5kz7dUwNEBNz3Jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] osdep: work around Coverity parsing errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 25 June 2018 at 17:06, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Coverity does not like the new _Float* types that are used by
> recent glibc, and croaks on every single file that includes
> stdlib.h.  Add dummy typedefs to please it.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         I've been using this patch for a couple months, and Peter pointed
>         out that other projects are doing similar hacks.  So it's probably
>         time to send it upstream.
>
>         Note that this is a parse error, so it cannot be fixed in the
>         model file.
>
>  include/qemu/osdep.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 9ed62423c0..0084f3fa71 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -33,6 +33,14 @@
>  #else
>  #include "exec/poison.h"
>  #endif
> +#ifdef __COVERITY__
> +typedef float _Float32;
> +typedef double _Float32x;
> +typedef double _Float64;
> +typedef __float80 _Float64x;
> +typedef __float128 _Float128;
> +#endif

I think it would help to repeat the rationale in a comment here,
to avoid the necessity to dig it out of the git log.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
