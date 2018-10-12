Received: from eggs.gnu.org ([2001:4830:134:3::10]:58331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAx9S-00017I-N3
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAx9P-0002Op-C7
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:06:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAx9P-0002Ni-2y
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:06:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id y144-v6so12805100wmd.4
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 06:06:42 -0700 (PDT)
References: <b41a233c-988c-19bb-0d4b-b17655912839@redhat.com>
	<CAFEAcA-TeU8SRPrZU_6=97yyL8UkMO_61P8oK4Xz2q0DweeBQA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <11e90911-c0f2-7710-2e7f-9dc856f9fe4b@redhat.com>
Date: Fri, 12 Oct 2018 15:06:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-TeU8SRPrZU_6=97yyL8UkMO_61P8oK4Xz2q0DweeBQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] QOM: Can devices having link properties be
 user-creatable?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

On 12/10/2018 15:01, Peter Maydell wrote:
> On 12 October 2018 at 13:47, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> While looking at Mao's series
>> (https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02519.html) I
>> wondered if devices having link properties can be user-creatable.
>>
>> Using the following patch (I don't think this is correct to put qdev
>> code into qobject, but I used this as PoC):
>>
>> -- >8 --
>> diff --git a/qom/object.c b/qom/object.c
>> index 547dcf97c3..2dd3a25531 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -16,4 +16,5 @@
>>  #include "qom/object_interfaces.h"
>>  #include "qemu/cutils.h"
>> +#include "qemu/error-report.h"
>>  #include "qapi/visitor.h"
>>  #include "qapi/string-input-visitor.h"
>> @@ -1662,4 +1663,11 @@ void object_property_add_link(Object *obj, const
>> char *name,
>>      gchar *full_type;
>>      ObjectProperty *op;
>> +    ObjectClass *klass = object_get_class(obj);
>> +
>> +    if (klass && object_dynamic_cast(obj, TYPE_DEVICE) &&
>> +                 DEVICE_CLASS(klass)->user_creatable == false) {
>> +        warn_report("Device type '%s' is user_creatable "
>> +                    "(linked property: '%s')", type, name);
>> +    }
>>
>>      prop->child = child;
>> ---
>>
>> I get:
>>
>> $ aarch64-softmmu/qemu-system-aarch64 -M virt
>> qemu-system-aarch64: warning: Device type 'bus' is user_creatable
>> (linked property: 'parent_bus')
>> qemu-system-aarch64: warning: Device type 'qemu:memory-region' is
>> user_creatable (linked property: 'memory')
> 
> Is your warning printing the wrong thing? "bus", "irq",
> etc don't seem like names of devices...

Oh indeed I inverted (type, name) :)

> I think whether a device with a link property is
> user creatable might depend on what the property is
> for and whether the device has a useful fallback for
> "link not connected".

OK it now makes sens, reading this example:

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

Thanks!

Phil.
