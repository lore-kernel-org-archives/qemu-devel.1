Received: from eggs.gnu.org ([2001:4830:134:3::10]:58113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkTv-0004Jx-Vv
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkTv-0001yf-50
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:01:36 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZkTu-0001xc-SU
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:01:35 -0400
Received: by mail-wm0-x231.google.com with SMTP id m85so27192737wma.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:01:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-33-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-33-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 22:01:11 +0100
Message-ID: <CAFEAcA9d5SE-+=YxJ_dwjvkpxs2R0QJszESExGoG2y+Bnyk2aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 32/35] timer/pxa2xx: silent
 warning about out-of-bound memory access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 24 July 2017 at 19:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Unlikely to happen.
>
> hw/timer/pxa2xx_timer.c:145:19: warning: Out of bound memory access (acce=
ssed memory precedes memory block)
>         counter =3D counters[n];
>                   ^~~~~~~~~~~
>
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/timer/pxa2xx_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
> index 68ba5a70b3..d47f463636 100644
> --- a/hw/timer/pxa2xx_timer.c
> +++ b/hw/timer/pxa2xx_timer.c
> @@ -139,7 +139,7 @@ static void pxa2xx_timer_update4(void *opaque, uint64=
_t now_qemu, int n)
>      if (s->tm4[n].control & (1 << 7))
>          counter =3D n;
>      else
> -        counter =3D counters[n];
> +        counter =3D counters[n & 7];
>
>      if (!s->tm4[counter].freq) {
>          timer_del(s->tm4[n].tm.qtimer);
> --

This looks rather odd, because we use a mask to guard
the counters[] array index, but we do an access into
another 8-element array with n both immediately
above and immediately below that.

It's not actually possible to call this function
with n not between 0 and 7 -- if the static
analyser can't figure that out does adding an
assert at the top of the function help it out?

thanks
-- PMM
