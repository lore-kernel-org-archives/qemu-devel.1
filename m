Received: from eggs.gnu.org ([209.51.188.92]:52323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gubvb-0008MS-AC
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gubvU-00032T-AA
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:45:06 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gubvQ-0002wJ-1t
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:45:02 -0500
Received: by mail-qt1-f196.google.com with SMTP id j36so10459744qta.7
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 03:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20190214201939.494-1-philmd@redhat.com>
	<20190214201939.494-6-philmd@redhat.com>
In-Reply-To: <20190214201939.494-6-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Feb 2019 12:44:46 +0100
Message-ID: <CAMxuvawp4uYL=bS3Sr_Pgi3cw=cGuNVJd=bsaRc+vibvx-qv6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/9] ccid-card-passthru: Replace
 assert() by QEMU_BUILD_BUG_ON()
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

On Thu, Feb 14, 2019 at 9:20 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/usb/ccid-card-passthru.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index ba7c285ded..ccc3ffa7fa 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -29,6 +29,9 @@ do {                                                   =
 \
>  #define D_MORE_INFO 3
>  #define D_VERBOSE 4
>
> +/* maximum size of ATR - from 7816-3 */
> +#define MAX_ATR_SIZE        40
> +
>  /* TODO: do we still need this? */
>  static const uint8_t DEFAULT_ATR[] =3D {
>  /*
> @@ -41,10 +44,9 @@ static const uint8_t DEFAULT_ATR[] =3D {
>   0x13, 0x08
>  };
>
> -#define VSCARD_IN_SIZE      (64 * KiB)
> +QEMU_BUILD_BUG_ON(sizeof(DEFAULT_ATR) > MAX_ATR_SIZE);
>
> -/* maximum size of ATR - from 7816-3 */
> -#define MAX_ATR_SIZE        40
> +#define VSCARD_IN_SIZE      (64 * KiB)
>
>  typedef struct PassthruState PassthruState;
>
> @@ -351,7 +353,6 @@ static void passthru_realize(CCIDCardState *base, Err=
or **errp)
>      }
>      card->debug =3D parse_debug_env("QEMU_CCID_PASSTHRU_DEBUG", D_VERBOS=
E,
>                                    card->debug);
> -    assert(sizeof(DEFAULT_ATR) <=3D MAX_ATR_SIZE);
>      memcpy(card->atr, DEFAULT_ATR, sizeof(DEFAULT_ATR));
>      card->atr_length =3D sizeof(DEFAULT_ATR);
>  }
> --
> 2.20.1
>
