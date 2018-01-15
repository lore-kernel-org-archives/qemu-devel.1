Received: from eggs.gnu.org ([2001:4830:134:3::10]:52625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaukF-0006hV-Cq
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 21:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaukE-0001iG-1y
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 21:43:31 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAKmqyKOJ2eL--7o2UyptujNDxHwVVbmG50K39rZAA+VJgxML8w@mail.gmail.com>
References: <20180111205626.23291-1-f4bug@amsat.org>
	<20180111205626.23291-9-f4bug@amsat.org>
	<CAKmqyKOJ2eL--7o2UyptujNDxHwVVbmG50K39rZAA+VJgxML8w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 14 Jan 2018 23:43:28 -0300
Message-ID: <CAAdtpL6MzwtBYiPhx3zO12u1NVQkFsywbP473zBVySvycOAQcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 08/21] sdhci: add v3 capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?Q?Gr=C3=A9gory_Estrade?= <gregory.estrade@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Clement Deschamps <clement.deschamps@antfield.fr>, Andrew Baumann <Andrew.Baumann@microsoft.com>

On Fri, Jan 12, 2018 at 9:08 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Thu, Jan 11, 2018 at 12:56 PM, Philippe Mathieu-Daud=C3=A9
> <f4bug@amsat.org> wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  hw/sd/sdhci-internal.h | 21 +++++++++++++++++++++
>>  include/hw/sd/sdhci.h  |  2 ++
>>  hw/sd/sdhci.c          | 22 ++++++++++++++++++++--
>>  3 files changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
>> index 4ed9727ec3..ac4704eb61 100644
>> --- a/hw/sd/sdhci-internal.h
>> +++ b/hw/sd/sdhci-internal.h
>> @@ -43,6 +43,7 @@
>>  #define SDHC_TRNS_DMA                  0x0001
>>  #define SDHC_TRNS_BLK_CNT_EN           0x0002
>>  #define SDHC_TRNS_ACMD12               0x0004
>> +#define SDHC_TRNS_ACMD23               0x0008 /* since v3 */
>>  #define SDHC_TRNS_READ                 0x0010
>>  #define SDHC_TRNS_MULTI                0x0020
>>  #define SDHC_TRNMOD_MASK               0x0037
>> @@ -183,12 +184,23 @@ FIELD(SDHC_ACMD12ERRSTS, TIMEOUT_ERR,  1, 1);
>>  FIELD(SDHC_ACMD12ERRSTS, CRC_ERR,      2, 1);
>>  FIELD(SDHC_ACMD12ERRSTS, INDEX_ERR,    4, 1);
>>
>> +/* Host Control Register 2 (since v3) */
>> +#define SDHC_HOSTCTL2                  0x3E
>
> Why not use the REG() macro here?

Because this is a 16-bit register, and I don't want to confuse with REG32()

Although the A_ address is correct, the R_ index only works if all
REG() are from the same size.

We should add some alignment check, I was thinking about using
_Static_assert() in the macros.

>
> Besides that the patch looks good.
>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks!

>
> Alistair
>
>
>> +FIELD(SDHC_HOSTCTL2, UHS_MODE_SEL,     0, 3);
>> +FIELD(SDHC_HOSTCTL2, V18_ENA,          3, 1); /* UHS-I only */
>> +FIELD(SDHC_HOSTCTL2, DRIVER_STRENGTH,  4, 2); /* UHS-I only */
>> +FIELD(SDHC_HOSTCTL2, EXECUTE_TUNING,   6, 1); /* UHS-I only */
>> +FIELD(SDHC_HOSTCTL2, SAMPLING_CLKSEL,  7, 1); /* UHS-I only */
>> +FIELD(SDHC_HOSTCTL2, ASYNC_INT,       14, 1);
>> +FIELD(SDHC_HOSTCTL2, PRESET_ENA,      15, 1);
>> +
>>  /* HWInit Capabilities Register 0x05E80080 */
>>  #define SDHC_CAPAB                     0x40
>>  FIELD(SDHC_CAPAB, TOCLKFREQ,           0, 6);
>>  FIELD(SDHC_CAPAB, TOUNIT,              7, 1);
>>  FIELD(SDHC_CAPAB, BASECLKFREQ,         8, 8);
>>  FIELD(SDHC_CAPAB, MAXBLOCKLENGTH,     16, 2);
>> +FIELD(SDHC_CAPAB, EMBEDDED_8BIT,      18, 1); /* since v3 */
>>  FIELD(SDHC_CAPAB, ADMA2,              19, 1); /* since v2 */
>>  FIELD(SDHC_CAPAB, ADMA1,              20, 1); /* v1 only? */
>>  FIELD(SDHC_CAPAB, HIGHSPEED,          21, 1);
>> @@ -198,6 +210,15 @@ FIELD(SDHC_CAPAB, V33,                24, 1);
>>  FIELD(SDHC_CAPAB, V30,                25, 1);
>>  FIELD(SDHC_CAPAB, V18,                26, 1);
>>  FIELD(SDHC_CAPAB, BUS64BIT,           28, 1); /* since v2 */
>> +FIELD(SDHC_CAPAB, ASYNC_INT,          29, 1); /* since v3 */
>> +FIELD(SDHC_CAPAB, SLOT_TYPE,          30, 2); /* since v3 */
>> +FIELD(SDHC_CAPAB, BUS_SPEED,          32, 3); /* since v3 */
>> +FIELD(SDHC_CAPAB, DRIVER_STRENGTH,    36, 3); /* since v3 */
>> +FIELD(SDHC_CAPAB, DRIVER_TYPE_A,      36, 1); /* since v3 */
>> +FIELD(SDHC_CAPAB, DRIVER_TYPE_C,      37, 1); /* since v3 */
>> +FIELD(SDHC_CAPAB, DRIVER_TYPE_D,      38, 1); /* since v3 */
>> +FIELD(SDHC_CAPAB, TIMER_RETUNNING,    40, 4); /* since v3 */
>> +FIELD(SDHC_CAPAB, SDR50_TUNNING,      45, 1); /* since v3 */
>>
>>  /* HWInit Maximum Current Capabilities Register 0x0 */
>>  #define SDHC_MAXCURR                   0x48
>> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
>> index 26b50583af..f45e911065 100644
>> --- a/include/hw/sd/sdhci.h
>> +++ b/include/hw/sd/sdhci.h
>> @@ -104,6 +104,8 @@ typedef struct SDHCIState {
>>          /* v2 */
>>          bool adma1, adma2;
>>          bool bus64;
>> +        /* v3 */
>> +        uint8_t slot_type, sdr, strength;
>>      } cap;
>>  } SDHCIState;
>>
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index ab4ffeca1d..773eb68fd6 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -63,6 +63,18 @@ static void sdhci_init_capareg(SDHCIState *s, Error *=
*errp)
>>      uint32_t val;
>>
>>      switch (s->spec_version) {
>> +    case 3:
>> +        val =3D FIELD_EX64(capareg, SDHC_CAPAB, SLOT_TYPE);
>> +        if (val) {
>> +            error_setg(errp, "slot-type not supported");
>> +            return;
>> +        }
>> +        capareg =3D FIELD_DP64(capareg, SDHC_CAPAB, SLOT_TYPE, val);
>> +        capareg =3D FIELD_DP64(capareg, SDHC_CAPAB, BUS_SPEED, s->cap.s=
dr);
>> +        capareg =3D FIELD_DP64(capareg, SDHC_CAPAB, DRIVER_STRENGTH,
>> +                             s->cap.strength);
>> +
>> +    /* fallback */
>>      case 2: /* default version */
>>          capareg =3D FIELD_DP64(capareg, SDHC_CAPAB, ADMA1, s->cap.adma1=
);
>>          capareg =3D FIELD_DP64(capareg, SDHC_CAPAB, ADMA2, s->cap.adma2=
);
>> @@ -1169,8 +1181,11 @@ static inline unsigned int sdhci_get_fifolen(SDHC=
IState *s)
>>
>>  static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
>>  {
>> -    if (s->spec_version !=3D 2) {
>> -        error_setg(errp, "Only Spec v2 is supported");
>> +    switch (s->spec_version) {
>> +    case 2 ... 3:
>> +        break;
>> +    default:
>> +        error_setg(errp, "Only Spec v2/v3 are supported");
>>          return;
>>      }
>>      s->version =3D (SDHC_HCVER_VENDOR << 8) | (s->spec_version - 1);
>> @@ -1319,6 +1334,9 @@ static Property sdhci_properties[] =3D {
>>      DEFINE_PROP_BOOL("1v8", SDHCIState, cap.v18, false),
>>
>>      DEFINE_PROP_BOOL("64bit", SDHCIState, cap.bus64, false),
>> +    DEFINE_PROP_UINT8("slot-type", SDHCIState, cap.slot_type, 0),
>> +    DEFINE_PROP_UINT8("bus-speed", SDHCIState, cap.sdr, 0),
>> +    DEFINE_PROP_UINT8("driver-strength", SDHCIState, cap.strength, 0),
>>
>>      /* capareg: deprecated */
>>      DEFINE_PROP_UINT64("capareg", SDHCIState, capareg, UINT64_MAX),
>> --
>> 2.15.1
>>
>>
