Received: from eggs.gnu.org ([209.51.188.92]:53262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gubzl-0003Cx-Mr
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:49:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gubzk-0006UB-K6
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:49:29 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gubzk-0006Tq-EX
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:49:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id p25so10218420qtb.3
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 03:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20190214201939.494-1-philmd@redhat.com>
	<20190214201939.494-7-philmd@redhat.com>
In-Reply-To: <20190214201939.494-7-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Feb 2019 12:49:16 +0100
Message-ID: <CAMxuvazU9Zh9ebRH-FjZ_t=4k5eOLBORRpd9AZrNCeMqCB25iQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/9] ccid-card-passthru: Simplify the
 if() condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Hi
On Thu, Feb 14, 2019 at 9:20 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Simplify the if() condition so we can remove an indent layer
> and the code is easier to review.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/usb/ccid-card-passthru.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index ccc3ffa7fa..6cb8b2d26b 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -338,19 +338,17 @@ static void passthru_realize(CCIDCardState *base, E=
rror **errp)
>  {
>      PassthruState *card =3D PASSTHRU_CCID_CARD(base);
>
> -    card->vscard_in_pos =3D 0;
> -    card->vscard_in_hdr =3D 0;

The 0 assignment are needless too (objects are memset 0), but not a
problem either.

> -    if (qemu_chr_fe_backend_connected(&card->cs)) {
> -        DPRINTF(card, D_INFO, "ccid-card-passthru: initing chardev");
> -        qemu_chr_fe_set_handlers(&card->cs,
> -            ccid_card_vscard_can_read,
> -            ccid_card_vscard_read,
> -            ccid_card_vscard_event, NULL, card, NULL, true);
> -        ccid_card_vscard_send_init(card);
> -    } else {
> +    if (!qemu_chr_fe_backend_connected(&card->cs)) {
>          error_setg(errp, "missing chardev");
>          return;
>      }
> +    card->vscard_in_pos =3D 0;
> +    card->vscard_in_hdr =3D 0;
> +    DPRINTF(card, D_INFO, "ccid-card-passthru: initing chardev");
> +    qemu_chr_fe_set_handlers(&card->cs, ccid_card_vscard_can_read,
> +                             ccid_card_vscard_read, ccid_card_vscard_eve=
nt,
> +                             NULL, card, NULL, true);
> +    ccid_card_vscard_send_init(card);
>      card->debug =3D parse_debug_env("QEMU_CCID_PASSTHRU_DEBUG", D_VERBOS=
E,
>                                    card->debug);
>      memcpy(card->atr, DEFAULT_ATR, sizeof(DEFAULT_ATR));
> --
> 2.20.1
>
