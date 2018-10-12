Received: from eggs.gnu.org ([2001:4830:134:3::10]:57838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gB2MQ-0003vu-LI
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gB2ML-0001OR-2I
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:40:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gB2MJ-0001Nm-7l
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:40:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so14450068wrw.12
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 11:40:23 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20181012083008.29027-1-maozhongyi@cmss.chinamobile.com>
	<20181012083008.29027-3-maozhongyi@cmss.chinamobile.com>
	<cfadc8a6-ae1c-367a-a6f1-6e711a6e79f4@redhat.com>
	<f55ae5b1-2dbf-8c6e-c787-0f088fa491a9@cmss.chinamobile.com>
	<2eecebee-de1f-5985-9420-4adcd1767c29@redhat.com>
Message-ID: <61bb828a-dc72-5bb2-44b0-2dc9bd737fc4@redhat.com>
Date: Fri, 12 Oct 2018 20:40:20 +0200
MIME-Version: 1.0
In-Reply-To: <2eecebee-de1f-5985-9420-4adcd1767c29@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] audio: use object link instead
 ofqdev property to pass wm8750 reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: maozy <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Jan Kiszka <jan.kiszka@web.de>, Gerd Hoffmann <kraxel@redhat.com>

Hi Mao,

On 12/10/2018 14:30, Philippe Mathieu-Daudé wrote:
> Cc'ing Eduardo and Thomas.
> 
> On 12/10/2018 13:51, maozy wrote:
>> Hi, Philippe
>>
>> On 10/12/18 5:53 PM, Philippe Mathieu-Daudé wrote:
>>> Hi Mao,
>>>
>>> On 12/10/2018 10:30, Mao Zhongyi wrote:
>>>> According to qdev-properties.h, properties of pointer type should
>>>> be avoided, it seems a link type property is a good substitution.
>>>>
>>>> Cc: Jan Kiszka <jan.kiszka@web.de>
>>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>> To: qemu-arm@nongnu.org
>>>>
>>>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>>>> ---
>>>>   hw/arm/musicpal.c          |  3 ++-
>>>>   hw/audio/marvell_88w8618.c | 14 ++++++--------
>>>>   2 files changed, 8 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
>>>> index 3dafb41b0b..ac266f9253 100644
>>>> --- a/hw/arm/musicpal.c
>>>> +++ b/hw/arm/musicpal.c
>>>> @@ -1695,7 +1695,8 @@ static void musicpal_init(MachineState *machine)
>>>>       wm8750_dev = i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
>>>>       dev = qdev_create(NULL, "mv88w8618_audio");
>>>>       s = SYS_BUS_DEVICE(dev);
>>>> -    qdev_prop_set_ptr(dev, TYPE_WM8750, wm8750_dev);
>>>> +    object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
>>>> +                             TYPE_WM8750, NULL);
>>>>       qdev_init_nofail(dev);
>>>>       sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
>>>>       sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
>>>> diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
>>>> index cf6ce6979b..baab4a3d53 100644
>>>> --- a/hw/audio/marvell_88w8618.c
>>>> +++ b/hw/audio/marvell_88w8618.c
>>>> @@ -15,6 +15,7 @@
>>>>   #include "hw/i2c/i2c.h"
>>>>   #include "hw/audio/wm8750.h"
>>>>   #include "audio/audio.h"
>>>> +#include "qapi/error.h"
>>>>     #define MP_AUDIO_SIZE           0x00001000
>>>>   @@ -252,6 +253,11 @@ static void mv88w8618_audio_init(Object *obj)
>>>>       memory_region_init_io(&s->iomem, obj, &mv88w8618_audio_ops, s,
>>>>                             "audio", MP_AUDIO_SIZE);
>>>>       sysbus_init_mmio(dev, &s->iomem);
>>>> +
>>>> +    object_property_add_link(OBJECT(dev), "mv88w8618", TYPE_WM8750,
>>>> +                             (Object **) &s->wm,
>>>> +                             qdev_prop_allow_set_link_before_realize,
>>>> +                             0, &error_abort);
>>>>   }
>>>>     static void mv88w8618_audio_realize(DeviceState *dev, Error **errp)
>>>> @@ -279,11 +285,6 @@ static const VMStateDescription
>>>> mv88w8618_audio_vmsd = {
>>>>       }
>>>>   };
>>>>   -static Property mv88w8618_audio_properties[] = {
>>>> -    DEFINE_PROP_PTR(TYPE_WM8750, mv88w8618_audio_state, wm),
>>>> -    {/* end of list */},
>>>> -};
>>>> -
>>>>   static void mv88w8618_audio_class_init(ObjectClass *klass, void *data)
>>>>   {
>>>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>>> @@ -291,9 +292,6 @@ static void
>>>> mv88w8618_audio_class_init(ObjectClass *klass, void *data)
>>>>       dc->realize = mv88w8618_audio_realize;
>>>>       dc->reset = mv88w8618_audio_reset;
>>>>       dc->vmsd = &mv88w8618_audio_vmsd;
>>>> -    dc->props = mv88w8618_audio_properties;
>>>> -    /* Reason: pointer property "wm8750" */
>>>> -    dc->user_creatable = false;
>>>
>>> Having a link property isn't it the same restriction?
>>
>> This task can found in
>> https://wiki.qemu.org/Contribute/BiteSizedTasks#Device_models
>>
>> Convert qdev pointer properties (defined with DEFINE_PROP_PTR) to QOM
>> links. Example: commit 873b4d3.
> 
> I agree with the QOM conversion (the rest of this patch), what I'm
> wondering is if declaring this device now user_creatable is correct. I
> don't think we can set link property from command line, but maybe I'm
> wrong because I never investigate/tried to do it.
> 
> Maybe devices having link property are automatically marked as
> user_creatable = false, then your change would be correct (except you
> should explicit that in the commit message).
> 
> I'll post another mail on the list to ask about that.

On https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02531.html

Peter answered:

  I think whether a device with a link property is
  user creatable might depend on what the property is
  for and whether the device has a useful fallback for
  "link not connected".

So if you look the realize function, there is no check on the linked object:

    static void mv88w8618_audio_realize(DeviceState *dev, Error **errp)
    {
        mv88w8618_audio_state *s = MV88W8618_AUDIO(dev);

        wm8750_data_req_set(s->wm, mv88w8618_audio_callback, s);
    }

Then the called function dereference the WM8750State:

    void wm8750_data_req_set(DeviceState *dev, data_req_cb *data_req,
                             void *opaque)
    {
        WM8750State *s = WM8750(dev);

        s->data_req = data_req;
        s->opaque = opaque;
    }

So this patch is incorrect. You should either keep the
'dc->user_creatable = false' line, or add a check in the realize()
function, as here:

    static void bcm2836_realize(DeviceState *dev, Error **errp)
    {
        Object *obj;
        Error *err = NULL;

        obj = object_property_get_link(OBJECT(dev), "ram", &err);
        if (obj == NULL) {
            error_setg(errp, "%s: required ram link not found: %s",
                       __func__, error_get_pretty(err));
            return;
        }
        ...

Regards,

Phil.

> 
> Regards,
> 
> Phil.
> 
>>
>> Thanks,
>> Mao
>>
>>>
>>>>   }
>>>>     static const TypeInfo mv88w8618_audio_info = {
>>>>
>>>
>>
>>
