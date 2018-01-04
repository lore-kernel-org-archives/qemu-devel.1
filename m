Received: from eggs.gnu.org ([2001:4830:134:3::10]:56940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXBJY-0007ce-K5
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXBJU-0001UA-I9
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:36:32 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXBJU-0001TN-CN
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 14:36:28 -0500
Received: by mail-qk0-x243.google.com with SMTP id g81so3296424qke.1
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 11:36:28 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180103183418.23730-1-f4bug@amsat.org>
	<20180103183418.23730-2-f4bug@amsat.org>
	<CAKmqyKOPccW5Ug+2DvWaB1TXvbd3JpPwhY7LMqa3pECfM98NAw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7138da0b-5837-f42c-bf1f-f051d1651159@amsat.org>
Date: Thu, 4 Jan 2018 16:36:24 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOPccW5Ug+2DvWaB1TXvbd3JpPwhY7LMqa3pECfM98NAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 01/25] sdhci: add a spec_version property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 01/04/2018 02:51 PM, Alistair Francis wrote:
> On Wed, Jan 3, 2018 at 10:33 AM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> default to Spec v2.00
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/sd/sdhci-internal.h |  4 ++--
>>  include/hw/sd/sdhci.h  |  3 +++
>>  hw/sd/sdhci.c          | 19 +++++++++++++++++--
>>  3 files changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
>> index b7475a1b7b..cf4a055159 100644
>> --- a/hw/sd/sdhci-internal.h
>> +++ b/hw/sd/sdhci-internal.h
>> @@ -212,9 +212,9 @@ FIELD(SDHC_PRNSTS, WRITE_PROTECT,      19, 1);
>>  /* Slot interrupt status */
>>  #define SDHC_SLOT_INT_STATUS            0xFC
>>
>> -/* HWInit Host Controller Version Register 0x0401 */
>> +/* HWInit Host Controller Version Register */
>>  #define SDHC_HCVER                      0xFE
>> -#define SD_HOST_SPECv2_VERS             0x2401
>> +#define SDHC_HCVER_VENDOR               0x24
>>
>>  #define SDHC_REGISTERS_MAP_SIZE         0x100
>>  #define SDHC_INSERTION_DELAY            (NANOSECONDS_PER_SECOND)
>> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
>> index 2aea20f1d8..ddd5040410 100644
>> --- a/include/hw/sd/sdhci.h
>> +++ b/include/hw/sd/sdhci.h
>> @@ -91,6 +91,8 @@ typedef struct SDHCIState {
>>      uint64_t capareg;      /* Capabilities Register */
>>      /* 0x48 */
>>      uint64_t maxcurr;      /* Maximum Current Capabilities Register */
>> +    /* 0xfe */
>> +    uint16_t version;      /* Host Controller Version Register */
>>
>>      uint8_t  *fifo_buffer; /* SD host i/o FIFO buffer */
>>      uint32_t buf_maxsz;
>> @@ -99,6 +101,7 @@ typedef struct SDHCIState {
>>      bool     pending_insert_state;
>>      /* Configurable properties */
>>      bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
>> +    uint8_t spec_version;
>>  } SDHCIState;
>>
>>  #define TYPE_PCI_SDHCI "sdhci-pci"
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index b080950f80..ae8ddf4e3b 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -169,7 +169,8 @@ static void sdhci_reset(SDHCIState *s)
>>
>>      timer_del(s->insert_timer);
>>      timer_del(s->transfer_timer);
>> -    /* Set all registers to 0. Capabilities registers are not cleared
>> +
>> +    /* Set all registers to 0. Capabilities/Version registers are not cleared
>>       * and assumed to always preserve their value, given to them during
>>       * initialization */
>>      memset(&s->sdmasysad, 0, (uintptr_t)&s->capareg - (uintptr_t)&s->sdmasysad);
>> @@ -923,7 +924,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
>>          ret = (uint32_t)(s->admasysaddr >> 32);
>>          break;
>>      case SDHC_SLOT_INT_STATUS:
>> -        ret = (SD_HOST_SPECv2_VERS << 16) | sdhci_slotint(s);
>> +        ret = (s->version << 16) | sdhci_slotint(s);
>>          break;
>>      default:
>>          qemu_log_mask(LOG_UNIMP, "SDHC rd_%ub @0x%02" HWADDR_PRIx " "
>> @@ -1178,6 +1179,15 @@ static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
>>      }
>>  }
>>
>> +static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
>> +{
>> +    if (s->spec_version < 1) {
>> +        error_setg(errp, "spec version invalid");
> 
> Can we tell the user that the version must be greater then 1?

Good idea.

I started this at v1 to start verifying v1 features expected to be
working for v2, but we don't have v1-only HCI, so I'll see to have this
default to v2 directly.

> 
>> +        return;
>> +    }
>> +    s->version = (SDHC_HCVER_VENDOR << 8) | (s->spec_version - 1);
>> +}
>> +
>>  static void sdhci_initfn(SDHCIState *s)
>>  {
>>      qbus_create_inplace(&s->sdbus, sizeof(s->sdbus),
>> @@ -1190,6 +1200,10 @@ static void sdhci_initfn(SDHCIState *s)
>>
>>  static void sdhci_common_realize(SDHCIState *s, Error **errp)
>>  {
>> +    sdhci_init_readonly_registers(s, errp);
>> +    if (errp && *errp) {
>> +        return;
>> +    }
>>      s->buf_maxsz = sdhci_get_fifolen(s);
>>      s->fifo_buffer = g_malloc0(s->buf_maxsz);
>>
>> @@ -1290,6 +1304,7 @@ const VMStateDescription sdhci_vmstate = {
>>  /* Capabilities registers provide information on supported features of this
>>   * specific host controller implementation */
>>  static Property sdhci_properties[] = {
>> +    DEFINE_PROP_UINT8("sd-spec-version", SDHCIState, spec_version, 1),
> 
> This changes what we used to report to the guest. This at least needs
> to be mentioned in the commit message.

Yes you right, I'll use a default v2 to avoid this guest change.

>>      DEFINE_PROP_UINT64("capareg", SDHCIState, capareg,
>>              SDHC_CAPAB_REG_DEFAULT),
>>      DEFINE_PROP_UINT64("maxcurr", SDHCIState, maxcurr, 0),
>> --
>> 2.15.1
>>
>>
