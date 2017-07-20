Received: from eggs.gnu.org ([2001:4830:134:3::10]:53783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dY7rY-0005eM-GY
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dY7rX-0004Jj-0m
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:35:16 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dY7rW-0004IP-Kk
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:35:14 -0400
Received: by mail-lf0-x244.google.com with SMTP id p11so1281522lfd.1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 02:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <1500541371-24788-1-git-send-email-sf@sfritsch.de>
	<1500541371-24788-4-git-send-email-sf@sfritsch.de>
In-Reply-To: <1500541371-24788-4-git-send-email-sf@sfritsch.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 20 Jul 2017 09:35:02 +0000
Message-ID: <CAJ+F1CK3zYyFFm7b7PnNq7GYwMXGmO=cvdPWUOitboWdeGtsXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/8] usb-ccid: Set protocol parameters
 based on card ATR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Fritsch <sf@sfritsch.de>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Thu, Jul 20, 2017 at 11:11 AM Stefan Fritsch <sf@sfritsch.de> wrote:

> From: Stefan Fritsch <stefan_fritsch@genua.de>
>
> For the ATR interface bytes encoding see ISO/IEC 7816-3. For the
> interpretation of the protocol parameter block see the CCID
> specification.
>
> - Values that are not present in the ATR default to zero.
> - TA_1 is used to fill bmFindexDindex.
> - The high nibble of bmTCCKST0 must be the protocol (T=3D0 or T=3D1).
> - For T=3D0 the bWaitingInteger can be found in the global byte TC_2,
>   for T=3D1 the waiting integer is in TB_3 and bIFSC is in TA_3.
>
> Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
> Signed-off-by: Christian Ehrhardt <christian_ehrhardt@genua.de>
> ---
>  hw/usb/dev-smartcard-reader.c | 66
> +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 54 insertions(+), 12 deletions(-)
>
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
> index 49791492ea..769949144b 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -801,7 +801,7 @@ static void ccid_write_parameters(USBCCIDState *s,
> CCID_Header *recv)
>          return;
>      }
>      h->b.hdr.bMessageType =3D CCID_MESSAGE_TYPE_RDR_to_PC_Parameters;
> -    h->b.hdr.dwLength =3D 0;
> +    h->b.hdr.dwLength =3D (s->bProtocolNum =3D=3D 1) ? 7 : 5;
>      h->b.hdr.bSlot =3D recv->bSlot;
>      h->b.hdr.bSeq =3D recv->bSeq;
>      h->b.bStatus =3D ccid_calc_status(s);
> @@ -871,6 +871,49 @@ static uint8_t atr_get_protocol_num(const uint8_t
> *atr, uint32_t len)
>      return atr[i] & 0x0f;
>  }
>
> +/*
> + * Get a specific interface byte TX_y (X=3D'A'..'D' y=3D1..3)
> + * See ISO/IEC 7816-3:2006 Chapter 8 for details.
> + */
> +static uint8_t atr_get_TXY(const uint8_t *atr, uint32_t len, char x, int
> y)
> +{
> +    int pos;
> +    uint8_t t0, ti, i;
> +
> +    if (x < 'A' || x > 'D') {
> +        return 0;
> +    }
>

or you could assert it, since it's compile time constant

(I have vague memories of parsing ATR, but the rest looks ok, it might be
worth to include tests for that function though)


> +    x -=3D 'A';
> +
> +    if (len < 2) {
> +        return 0;
> +    }
> +    t0 =3D atr[1] >> 4;
> +    pos =3D 2;
> +    ti =3D 1;
> +    /* Skip TA_i..TD_i if present while not at requested index y */
> +    while (ti < y) {
> +        pos +=3D !!(t0 & 0x01) + !!(t0 & 0x02) + !!(t0 & 0x04);
> +        if (pos >=3D len || !(t0 & 0x08)) {
> +            return 0;
> +        }
> +        t0 =3D atr[pos++] >> 4;
> +        ti++;
> +    }
> +    if (!(t0 & 0x01 << x)) {
> +        return 0;
> +    }
> +    for (i =3D 0; i < x; ++i) {
> +        if (t0 & (1 << i)) {
> +            pos++;
> +        }
> +    }
> +    if (pos >=3D len) {
> +        return 0;
> +    }
> +    return atr[pos];
> +}
> +
>  static void ccid_write_data_block_atr(USBCCIDState *s, CCID_Header *recv=
)
>  {
>      const uint8_t *atr =3D NULL;
> @@ -890,21 +933,20 @@ static void ccid_write_data_block_atr(USBCCIDState
> *s, CCID_Header *recv)
>                                               : s->bProtocolNum);
>      switch (atr_protocol_num) {
>      case 0:
> -        /* TODO: unimplemented ATR T0 parameters */
> -        t0->bmFindexDindex =3D 0;
> -        t0->bmTCCKST0 =3D 0;
> +        t0->bmFindexDindex =3D atr_get_TXY(atr, len, 'A', 1);
> +        t0->bmTCCKST0 =3D 0;      /* T0 */
>          t0->bGuardTimeT0 =3D 0;
> -        t0->bWaitingIntegerT0 =3D 0;
> +        t0->bWaitingIntegerT0 =3D atr_get_TXY(atr, len, 'C', 2);
>          t0->bClockStop =3D 0;
>          break;
>      case 1:
> -        /* TODO: unimplemented ATR T1 parameters */
> -        t1->bmFindexDindex =3D 0;
> -        t1->bmTCCKST1 =3D 0;
> -        t1->bGuardTimeT1 =3D 0;
> -        t1->bWaitingIntegerT1 =3D 0;
> -        t1->bClockStop =3D 0;
> -        t1->bIFSC =3D 0;
> +        /* NOTE: If present TD2 should specify protocl T=3D1 */
> +        t1->bmFindexDindex =3D atr_get_TXY(atr, len, 'A', 1);
> +        t1->bmTCCKST1 =3D 0x10;   /* T1 */
> +        t1->bGuardTimeT1 =3D atr_get_TXY(atr, len, 'C', 1);
> +        t1->bWaitingIntegerT1 =3D atr_get_TXY(atr, len, 'B', 3);
> +        t1->bClockStop =3D 0x00;
> +        t1->bIFSC =3D atr_get_TXY(atr, len, 'A', 3);
>          t1->bNadValue =3D 0;
>          break;
>      default:
> --
> 2.11.0
>
>
> --
Marc-Andr=C3=A9 Lureau
