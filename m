Received: from eggs.gnu.org ([2001:4830:134:3::10]:54710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dY7x2-0007lp-FE
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dY7x0-0001k9-TM
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:40:56 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:36028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dY7x0-0001ju-Fr
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:40:54 -0400
Received: by mail-lf0-x241.google.com with SMTP id l200so1283802lfb.3
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 02:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <1500541371-24788-1-git-send-email-sf@sfritsch.de>
	<1500541371-24788-5-git-send-email-sf@sfritsch.de>
In-Reply-To: <1500541371-24788-5-git-send-email-sf@sfritsch.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 20 Jul 2017 09:40:42 +0000
Message-ID: <CAJ+F1CKya87e_LuUEN-DDRJpqNuXOuwOOUYqHz7zcVmrQd96Mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/8] usb-ccid: Fix ATR parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Fritsch <sf@sfritsch.de>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Thu, Jul 20, 2017 at 11:05 AM Stefan Fritsch <sf@sfritsch.de> wrote:

> From: Stefan Fritsch <stefan_fritsch@genua.de>
>
> - The number of parameter set TA_i...TD_i is unlimited. The list ends
>   if TD_i is not present or the high nibble is zero.
> - If at least one protocol in any of the TD bytes is non-zero, the
>   ATR must have a checksum.
> - Add a missing length check before accessing TD.
> - Fixup a wrong checksum but accept the ATR.
>
>
Could this patch be splitted to help review / bisect? Ideally, I would also
try to write tests for it. Thanks


> Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
> Signed-off-by: Christian Ehrhardt <christian_ehrhardt@genua.de>
> ---
>  hw/usb/ccid-card-passthru.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index 45d96b03c6..e2e94ac1ba 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -146,8 +146,7 @@ static void ccid_card_vscard_handle_init(
>
>  static int check_atr(PassthruState *card, uint8_t *data, int len)
>  {
> -    int historical_length, opt_bytes;
> -    int td_count =3D 0;
> +    int historical_length, opt_bytes, tck =3D 0;
>      int td;
>
>      if (len < 2) {
> @@ -160,10 +159,8 @@ static int check_atr(PassthruState *card, uint8_t
> *data, int len)
>                  data[0]);
>          return 0;
>      }
> -    td_count =3D 0;
>      td =3D data[1] >> 4;
> -    while (td && td_count < 2 && opt_bytes + historical_length + 2 < len=
)
> {
> -        td_count++;
> +    while (td && opt_bytes + historical_length + 2 < len) {
>          if (td & 0x1) {
>              opt_bytes++;
>          }
> @@ -175,16 +172,37 @@ static int check_atr(PassthruState *card, uint8_t
> *data, int len)
>          }
>          if (td & 0x8) {
>              opt_bytes++;
> -            td =3D data[opt_bytes + 2] >> 4;
> +            if (opt_bytes + 1 >=3D len) {
> +                break;
> +            }
> +            /* Checksum byte must be present if T!=3D0 */
> +            if (data[opt_bytes + 1] & 0xf) {
> +                tck =3D 1;
> +            }
> +            td =3D data[opt_bytes + 1] >> 4;
> +        } else {
> +            td =3D 0;
>          }
>      }
> -    if (len < 2 + historical_length + opt_bytes) {
> +    if (len < 2 + historical_length + opt_bytes + tck) {
>          DPRINTF(card, D_WARN,
>              "atr too short: len %d, but historical_len %d, T1 0x%X\n",
>              len, historical_length, data[1]);
>          return 0;
>      }
> -    if (len > 2 + historical_length + opt_bytes) {
> +    if (tck) {
> +        int i;
> +        uint8_t cksum =3D 0;
> +        for (i =3D 1; i < 2 + historical_length + opt_bytes; ++i) {
> +            cksum ^=3D data[i];
> +        }
> +        if (cksum !=3D data[i]) {
> +            DPRINTF(card, D_WARN, "atr has bad checksum: "
> +                "real=3D0x%x should be 0x%x (FIXED)\n", cksum, data[i]);
> +            data[i] =3D cksum;
> +        }
> +    }
> +    if (len > 2 + historical_length + opt_bytes + tck) {
>          DPRINTF(card, D_WARN,
>              "atr too long: len %d, but hist/opt %d/%d, T1 0x%X\n",
>              len, historical_length, opt_bytes, data[1]);
> --
> 2.11.0
>
>
> --
Marc-Andr=C3=A9 Lureau
