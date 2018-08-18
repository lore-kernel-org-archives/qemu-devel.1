Received: from eggs.gnu.org ([2001:4830:134:3::10]:40892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqyAh-0007V2-Jq
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqxxo-00064F-PP
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 05:56:10 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqxxm-000638-Tx
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 05:56:07 -0400
Received: by mail-oi0-x243.google.com with SMTP id n21-v6so18158087oig.3
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 02:56:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <39365f2c-e947-3530-ee8f-9062bbb1264f@amsat.org>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
	<20180809130115.28951-7-peter.maydell@linaro.org>
	<39365f2c-e947-3530-ee8f-9062bbb1264f@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Aug 2018 10:55:45 +0100
Message-ID: <CAFEAcA_ZOjNHVkqk1ww5VOLq7EhPJjAEjfHHdk2kjBGdy-MqdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 06/16] hw/misc/iotkit: Wire up
 the system control element
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 18 August 2018 at 01:00, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> Hi Peter,
>
> On 08/09/2018 10:01 AM, Peter Maydell wrote:
>> Wire up the system control element's register banks.
>>
>> This is the last of the previously completely unimplemented
>> components in the IoTKit.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  include/hw/arm/iotkit.h |  4 +++-
>>  hw/arm/iotkit.c         | 19 +++++++++++--------
>>  2 files changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/hw/arm/iotkit.h b/include/hw/arm/iotkit.h
>> index 0f5c5101708..1ffa31d521b 100644
>> --- a/include/hw/arm/iotkit.h
>> +++ b/include/hw/arm/iotkit.h
>> @@ -58,7 +58,7 @@
>>  #include "hw/timer/cmsdk-apb-timer.h"
>>  #include "hw/timer/cmsdk-apb-dualtimer.h"
>>  #include "hw/watchdog/cmsdk-apb-watchdog.h"
>> -#include "hw/misc/unimp.h"
>> +#include "hw/misc/iotkit-sysctl.h"
>>  #include "hw/or-irq.h"
>>  #include "hw/core/split-irq.h"
>>
>> @@ -97,6 +97,8 @@ typedef struct IoTKit {
>>      CMSDKAPBWatchdog nswatchdog;
>>      CMSDKAPBWatchdog swatchdog;
>>
>> +    IoTKitSysCtl sysctl;
>> +
>>      MemoryRegion container;
>>      MemoryRegion alias1;
>>      MemoryRegion alias2;
>> diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
>> index cb0ec456f39..5d59ed5489f 100644
>> --- a/hw/arm/iotkit.c
>> +++ b/hw/arm/iotkit.c
>> @@ -16,7 +16,6 @@
>>  #include "hw/sysbus.h"
>>  #include "hw/registerfields.h"
>>  #include "hw/arm/iotkit.h"
>> -#include "hw/misc/unimp.h"
>>  #include "hw/arm/arm.h"
>>
>>  /* Clock frequency in HZ of the 32KHz "slow clock" */
>> @@ -151,6 +150,8 @@ static void iotkit_init(Object *obj)
>>                            sizeof(s->nswatchdog), TYPE_CMSDK_APB_WATCHDO=
G);
>>      sysbus_init_child_obj(obj, "swatchdog", &s->swatchdog,
>>                            sizeof(s->swatchdog), TYPE_CMSDK_APB_WATCHDOG=
);
>> +    sysbus_init_child_obj(obj, "iotkit-sysctl", &s->sysctl, sizeof(s->s=
ysctl),
>> +                          TYPE_IOTKIT_SYSCTL);
>>      object_initialize_child(obj, "nmi-orgate", &s->nmi_orgate,
>>                              sizeof(s->nmi_orgate), TYPE_OR_IRQ,
>>                              &error_abort, NULL);
>> @@ -516,13 +517,15 @@ static void iotkit_realize(DeviceState *dev, Error=
 **errp)
>>                            qdev_get_gpio_in_named(dev_apb_ppc1,
>>                                                   "cfg_sec_resp", 0));
>>
>> -    /* Using create_unimplemented_device() maps the stub into the
>> -     * system address space rather than into our container, but the
>> -     * overall effect to the guest is the same.
>> -     */
>> -    create_unimplemented_device("SYSINFO", 0x40020000, 0x1000);
>> -
>> -    create_unimplemented_device("SYSCONTROL", 0x50021000, 0x1000);
>> +    object_property_set_bool(OBJECT(&s->sysctl), true, "realized", &err=
);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +    /* System information registers */
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctl), 0, 0x40020000);
>
> What about the Secure access?
>
>        sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctl), 0, 0x50020000);

That should be handled by the general alias set up earlier
    make_alias(s, &s->alias3, "alias 3", 0x50000000, 0x10000000, 0x40000000=
);
which maps all of the 0x5... space to 0x4... if there's nothing
higher priority mapped there.


thanks
-- PMM
