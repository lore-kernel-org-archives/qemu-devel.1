Received: from eggs.gnu.org ([2001:4830:134:3::10]:50682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoroo-0000u7-U6
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eorol-00010R-1M
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:25:54 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:45822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eorok-0000zk-SR
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:25:50 -0500
Received: by mail-ot0-x244.google.com with SMTP id f11so4731791otj.12
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 06:25:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215221325.7611-20-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
	<20180215221325.7611-20-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 14:25:29 +0000
Message-ID: <CAFEAcA-fFV+JVWvqQCPfhFK5J-=Ad6c2mubqZAmg5Ce5VwANMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 19/20] sdcard: add a 'uhs' property,
 update the OCR register ACCEPT_SWITCH_1V8 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

On 15 February 2018 at 22:13, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sd.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index ada96f5574..b9429b06ca 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -93,6 +93,7 @@ struct SDState {
>      /* Configurable properties */
>      BlockBackend *blk;
>      bool spi;
> +    uint8_t uhs_supported;
>
>      uint32_t mode;    /* current card mode, one of SDCardModes */
>      int32_t state;    /* current card state, one of SDCardStates */
> @@ -292,6 +293,8 @@ static void sd_set_ocr(SDState *sd)
>  {
>      /* All voltages OK */
>      sd->ocr =3D R_OCR_VDD_VOLTAGE_WIN_HI_MASK;
> +
> +    sd->ocr =3D FIELD_DP32(sd->ocr, OCR, ACCEPT_SWITCH_1V8, !!sd->uhs_su=
pported);
>  }
>
>  static void sd_ocr_powerup(void *opaque)
> @@ -2189,6 +2192,7 @@ static Property sd_properties[] =3D {
>       * board to ensure that ssi transfers only occur when the chip selec=
t
>       * is asserted.  */
>      DEFINE_PROP_BOOL("spi", SDState, spi, false),
> +    DEFINE_PROP_UINT8("uhs", SDState, uhs_supported, UHS_NOT_SUPPORTED),
>      DEFINE_PROP_END_OF_LIST()
>  };

The field name and the use of the value suggest that this is just
a boolean flag, so why define it as a PROP_UINT8 rather than PROP_BOOL ?

thanks
-- PMM
