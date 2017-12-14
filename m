Received: from eggs.gnu.org ([2001:4830:134:3::10]:53109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePU7E-0006a0-Cl
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePU79-0006eW-Ue
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:04:00 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_6R61208pZ5rchSG0Oy4c_2eSGD+dO-LQs3Dncjnpf-Q@mail.gmail.com>
References: <20171211213007.7353-1-andrew.smirnov@gmail.com>
	<20171211213007.7353-13-andrew.smirnov@gmail.com>
	<CAFEAcA_6R61208pZ5rchSG0Oy4c_2eSGD+dO-LQs3Dncjnpf-Q@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 14 Dec 2017 06:03:39 -0800
Message-ID: <CAHQ1cqHhN=hLun2mzqvg0N3NkxEbPpBU1iEf5-mAdnHqEs3KYg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Tue, Dec 12, 2017 at 9:52 AM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> On 11 December 2017 at 21:30, Andrey Smirnov <andrew.smirnov@gmail.com> w=
rote:
>> IP block found on several generations of i.MX family does not use
>> vanilla SDHCI implementation and it comes with a number of quirks.
>>
>> Introduce i.MX SDHCI subtype of SDHCI block to add code necessary to
>> support unmodified Linux guest driver.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>
>> +    case ESDHC_DLL_CTRL:
>> +    case ESDHC_TUNE_CTRL_STATUS:
>> +    case 0x6c:
>
> Isn't there a name we can give 0x6c ?
>

Unfortunately, not that I know of. It's a mystery register not listed
in RM and the only place I can found it being mentioned is in Linux
driver as a part of errata ESDHC_FLAG_ERR004536 fix, where it is used
nameless as well.

>> +    case ESDHC_TUNING_CTRL:
>> +    case ESDHC_VENDOR_SPEC:
>> +    case ESDHC_MIX_CTRL:
>> +    case ESDHC_WTMK_LVL:
>> +        ret =3D 0;
>> +        break;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static void
>> +usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>> +{
>> +    SDHCIState *s =3D SYSBUS_SDHCI(opaque);
>> +    uint8_t hostctl;
>> +    uint32_t value =3D (uint32_t)val;
>> +
>> +    switch (offset) {
>> +    case ESDHC_DLL_CTRL:
>> +    case ESDHC_TUNE_CTRL_STATUS:
>> +    case 0x6c:
>> +    case ESDHC_TUNING_CTRL:
>> +    case ESDHC_WTMK_LVL:
>> +    case ESDHC_VENDOR_SPEC:
>> +        break;
>> +
>> +    case SDHC_HOSTCTL:
>> +        /*
>> +         * Here's What ESDHCI has at offset 0x28 (SDHC_HOSTCTL)
>> +         *
>> +         *       7         6     5      4      3      2        1      0
>> +         * |-----------+--------+--------+-----------+----------+------=
---|
>> +         * | Card      | Card   | Endian | DATA3     | Data     | Led  =
   |
>> +         * | Detect    | Detect | Mode   | as Card   | Transfer | Contr=
ol |
>> +         * | Signal    | Test   |        | Detection | Width    |      =
   |
>> +         * | Selection | Level  |        | Pin       |          |      =
   |
>> +         * |-----------+--------+--------+-----------+----------+------=
---|
>> +         *
>> +         * and 0x29
>> +         *
>> +         *  15      10 9    8
>> +         * |----------+------|
>> +         * | Reserved | DMA  |
>> +         * |          | Sel. |
>> +         * |          |      |
>> +         * |----------+------|
>> +         *
>> +         * and here's what SDCHI spec expects those offsets to be:
>> +         *
>> +         * 0x28 (Host Control Register)
>> +         *
>> +         *     7        6         5       4  3      2         1        =
0
>> +         * |--------+--------+----------+------+--------+----------+---=
------|
>> +         * | Card   | Card   | Extended | DMA  | High   | Data     | LE=
D     |
>> +         * | Detect | Detect | Data     | Sel. | Speed  | Transfer | Co=
ntrol |
>> +         * | Signal | Test   | Transfer |      | Enable | Width    |   =
      |
>> +         * | Sel.   | Level  | Width    |      |        |          |   =
      |
>> +         * |--------+--------+----------+------+--------+----------+---=
------|
>> +         *
>> +         * and 0x29 (Power Control Register)
>> +         *
>> +         * |----------------------------------|
>> +         * | Power Control Register           |
>> +         * |                                  |
>> +         * | Description omitted,             |
>> +         * | since it has no analog in ESDHCI |
>> +         * |                                  |
>> +         * |----------------------------------|
>> +         *
>> +         * Since offsets 0x2A and 0x2B should be compatible between
>> +         * both IP specs we only need to reconcile least 16-bit of the
>> +         * word we've been given.
>> +         */
>
> Thanks for this explanation, it's very helpful in figuring out what's
> going on.
>
>> +    case SDHC_BLKSIZE:
>> +        /*
>> +         * ESDHCI does not implement "Host SDMA Buffer Boundary", and
>> +         * Linux driver will try to zero this field out which will
>> +         * break the rest of SDHCI emulation.
>> +         *
>> +         * Linux defaults to maximum possible setting (512K boundary)
>> +         * and it seems to be the only option that i.MX IP implements,
>> +         * so we artificially set it to that value.
>> +         */
>> +        val |=3D 0x7 << 12;
>> +        /* FALLTHROUGH */
>
> We generally write this lowercase: /* fallthrough */
>

OK, will fix in v2.

>> +    default:
>> +        sdhci_write(opaque, offset, val, size);
>> +        break;
>> +    }
>> +}
>
>> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
>> index 0f0c3f1e64..dc1856a33d 100644
>> --- a/include/hw/sd/sdhci.h
>> +++ b/include/hw/sd/sdhci.h
>> @@ -39,6 +39,7 @@ typedef struct SDHCIState {
>>      };
>>      SDBus sdbus;
>>      MemoryRegion iomem;
>> +    const MemoryRegionOps *io_ops;
>>
>>      QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
>>      QEMUTimer *transfer_timer;
>> @@ -83,8 +84,13 @@ typedef struct SDHCIState {
>>      /* Force Event Auto CMD12 Error Interrupt Reg - write only */
>>      /* Force Event Error Interrupt Register- write only */
>>      /* RO Host Controller Version Register always reads as 0x2401 */
>> +
>> +    unsigned long quirks;
>
> I asked for this not to be unsigned long in the last round of review.
>

Ugh, missed this one, sorry about that. Will fix in v2.

>>  } SDHCIState;
>>
>> +/* Controller does not provide transfer-complete interrupt when not bus=
y */
>> +#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)
>
> I asked for a comment saying we're following the Linux kernel's
> quirk bit numbering in the last round of review.
>

My bad, will fix in v 2.

Thanks,
Andrey Smirnov
