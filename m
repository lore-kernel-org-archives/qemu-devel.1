Received: from eggs.gnu.org ([2001:4830:134:3::10]:34348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOoja-0005Cc-2Y
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOojY-0000WD-Se
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:52:50 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOojY-0000Vn-LE
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:52:48 -0500
Received: by mail-oi0-x242.google.com with SMTP id l6so14564811oih.11
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 09:52:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171211213007.7353-13-andrew.smirnov@gmail.com>
References: <20171211213007.7353-1-andrew.smirnov@gmail.com>
	<20171211213007.7353-13-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2017 17:52:27 +0000
Message-ID: <CAFEAcA_6R61208pZ5rchSG0Oy4c_2eSGD+dO-LQs3Dncjnpf-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/13] sdhci: Add i.MX specific subtype of
 SDHCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 11 December 2017 at 21:30, Andrey Smirnov <andrew.smirnov@gmail.com> wro=
te:
> IP block found on several generations of i.MX family does not use
> vanilla SDHCI implementation and it comes with a number of quirks.
>
> Introduce i.MX SDHCI subtype of SDHCI block to add code necessary to
> support unmodified Linux guest driver.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---

> +    case ESDHC_DLL_CTRL:
> +    case ESDHC_TUNE_CTRL_STATUS:
> +    case 0x6c:

Isn't there a name we can give 0x6c ?

> +    case ESDHC_TUNING_CTRL:
> +    case ESDHC_VENDOR_SPEC:
> +    case ESDHC_MIX_CTRL:
> +    case ESDHC_WTMK_LVL:
> +        ret =3D 0;
> +        break;
> +    }
> +
> +    return ret;
> +}
> +
> +static void
> +usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +{
> +    SDHCIState *s =3D SYSBUS_SDHCI(opaque);
> +    uint8_t hostctl;
> +    uint32_t value =3D (uint32_t)val;
> +
> +    switch (offset) {
> +    case ESDHC_DLL_CTRL:
> +    case ESDHC_TUNE_CTRL_STATUS:
> +    case 0x6c:
> +    case ESDHC_TUNING_CTRL:
> +    case ESDHC_WTMK_LVL:
> +    case ESDHC_VENDOR_SPEC:
> +        break;
> +
> +    case SDHC_HOSTCTL:
> +        /*
> +         * Here's What ESDHCI has at offset 0x28 (SDHC_HOSTCTL)
> +         *
> +         *       7         6     5      4      3      2        1      0
> +         * |-----------+--------+--------+-----------+----------+-------=
--|
> +         * | Card      | Card   | Endian | DATA3     | Data     | Led   =
  |
> +         * | Detect    | Detect | Mode   | as Card   | Transfer | Contro=
l |
> +         * | Signal    | Test   |        | Detection | Width    |       =
  |
> +         * | Selection | Level  |        | Pin       |          |       =
  |
> +         * |-----------+--------+--------+-----------+----------+-------=
--|
> +         *
> +         * and 0x29
> +         *
> +         *  15      10 9    8
> +         * |----------+------|
> +         * | Reserved | DMA  |
> +         * |          | Sel. |
> +         * |          |      |
> +         * |----------+------|
> +         *
> +         * and here's what SDCHI spec expects those offsets to be:
> +         *
> +         * 0x28 (Host Control Register)
> +         *
> +         *     7        6         5       4  3      2         1        0
> +         * |--------+--------+----------+------+--------+----------+----=
-----|
> +         * | Card   | Card   | Extended | DMA  | High   | Data     | LED=
     |
> +         * | Detect | Detect | Data     | Sel. | Speed  | Transfer | Con=
trol |
> +         * | Signal | Test   | Transfer |      | Enable | Width    |    =
     |
> +         * | Sel.   | Level  | Width    |      |        |          |    =
     |
> +         * |--------+--------+----------+------+--------+----------+----=
-----|
> +         *
> +         * and 0x29 (Power Control Register)
> +         *
> +         * |----------------------------------|
> +         * | Power Control Register           |
> +         * |                                  |
> +         * | Description omitted,             |
> +         * | since it has no analog in ESDHCI |
> +         * |                                  |
> +         * |----------------------------------|
> +         *
> +         * Since offsets 0x2A and 0x2B should be compatible between
> +         * both IP specs we only need to reconcile least 16-bit of the
> +         * word we've been given.
> +         */

Thanks for this explanation, it's very helpful in figuring out what's
going on.

> +    case SDHC_BLKSIZE:
> +        /*
> +         * ESDHCI does not implement "Host SDMA Buffer Boundary", and
> +         * Linux driver will try to zero this field out which will
> +         * break the rest of SDHCI emulation.
> +         *
> +         * Linux defaults to maximum possible setting (512K boundary)
> +         * and it seems to be the only option that i.MX IP implements,
> +         * so we artificially set it to that value.
> +         */
> +        val |=3D 0x7 << 12;
> +        /* FALLTHROUGH */

We generally write this lowercase: /* fallthrough */

> +    default:
> +        sdhci_write(opaque, offset, val, size);
> +        break;
> +    }
> +}

> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index 0f0c3f1e64..dc1856a33d 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -39,6 +39,7 @@ typedef struct SDHCIState {
>      };
>      SDBus sdbus;
>      MemoryRegion iomem;
> +    const MemoryRegionOps *io_ops;
>
>      QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
>      QEMUTimer *transfer_timer;
> @@ -83,8 +84,13 @@ typedef struct SDHCIState {
>      /* Force Event Auto CMD12 Error Interrupt Reg - write only */
>      /* Force Event Error Interrupt Register- write only */
>      /* RO Host Controller Version Register always reads as 0x2401 */
> +
> +    unsigned long quirks;

I asked for this not to be unsigned long in the last round of review.

>  } SDHCIState;
>
> +/* Controller does not provide transfer-complete interrupt when not busy=
 */
> +#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)

I asked for a comment saying we're following the Linux kernel's
quirk bit numbering in the last round of review.

> +
>  #define TYPE_PCI_SDHCI "sdhci-pci"
>  #define PCI_SDHCI(obj) OBJECT_CHECK(SDHCIState, (obj), TYPE_PCI_SDHCI)
>
> @@ -92,4 +98,6 @@ typedef struct SDHCIState {
>  #define SYSBUS_SDHCI(obj)                               \
>       OBJECT_CHECK(SDHCIState, (obj), TYPE_SYSBUS_SDHCI)
>
> +#define TYPE_IMX_USDHC "imx-usdhc"
> +
>  #endif /* SDHCI_H */
> --
> 2.14.3

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
