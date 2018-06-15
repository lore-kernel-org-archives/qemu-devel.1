Received: from eggs.gnu.org ([2001:4830:134:3::10]:51925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1fTjR9-0003K8-PE
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1fTjR8-0008UL-Nt
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:46:23 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:33121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1fTjR8-0008Tl-IE
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:46:22 -0400
Received: by mail-it0-x241.google.com with SMTP id k17-v6so4436570ita.0
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 00:46:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e31dfa59-6c9a-8ef0-6fb7-88cc578ca592@redhat.com>
References: <1522920750-11020-1-git-send-email-thuth@redhat.com>
	<e31dfa59-6c9a-8ef0-6fb7-88cc578ca592@redhat.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 15 Jun 2018 09:46:01 +0200
Message-ID: <CACXAS8Dp4A1jmmSvtpzN+xnumPoYF5CxOBk5T4JX31YEtSnf2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/sparc64/sun4u: Fix introspection by
 converting prom instance_init to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Fri, Jun 15, 2018 at 7:16 AM, Thomas Huth <thuth@redhat.com> wrote:
> On 05.04.2018 11:32, Thomas Huth wrote:
>> The instance_init function of devices should always succeed to be able
>> to introspect the device. However, the instance_init function of the
>> "openprom" device can currently fail, for example like this:
>>
>> $ echo "{'execute':'qmp_capabilities'}"\
>>        "{'execute':'device-list-properties',"\
>>        " 'arguments':{'typename':'openprom'}}" \
>>        | sparc64-softmmu/qemu-system-sparc64 -M sun4v,accel=qtest -qmp stdio
>> {"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
>>  "package": "build-all"}, "capabilities": []}}
>> {"return": {}}
>> RAMBlock "sun4u.prom" already registered, abort!
>> Aborted (core dumped)
>>
>> This should not happen. Fix this problem by moving the affected code from
>> instance_init into a realize function instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/sparc64/sun4u.c | 18 ++++++++++++------
>>  1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index 2044a52..d62f5a2 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -425,13 +425,19 @@ static void prom_init(hwaddr addr, const char *bios_name)
>>      }
>>  }
>>
>> -static void prom_init1(Object *obj)
>> +static void prom_realize(DeviceState *ds, Error **errp)
>>  {
>> -    PROMState *s = OPENPROM(obj);
>> -    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
>> +    PROMState *s = OPENPROM(ds);
>> +    SysBusDevice *dev = SYS_BUS_DEVICE(ds);
>> +    Error *local_err = NULL;
>> +
>> +    memory_region_init_ram_nomigrate(&s->prom, OBJECT(ds), "sun4u.prom",
>> +                                     PROM_SIZE_MAX, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>>
>> -    memory_region_init_ram_nomigrate(&s->prom, obj, "sun4u.prom", PROM_SIZE_MAX,
>> -                           &error_fatal);
>>      vmstate_register_ram_global(&s->prom);
>>      memory_region_set_readonly(&s->prom, true);
>>      sysbus_init_mmio(dev, &s->prom);
>> @@ -446,6 +452,7 @@ static void prom_class_init(ObjectClass *klass, void *data)
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>>
>>      dc->props = prom_properties;
>> +    dc->realize = prom_realize;
>>  }
>>
>>  static const TypeInfo prom_info = {
>> @@ -453,7 +460,6 @@ static const TypeInfo prom_info = {
>>      .parent        = TYPE_SYS_BUS_DEVICE,
>>      .instance_size = sizeof(PROMState),
>>      .class_init    = prom_class_init,
>> -    .instance_init = prom_init1,
>>  };
>
> Ping!

Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>

Mark, can you please take this one too?

Artyom



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
