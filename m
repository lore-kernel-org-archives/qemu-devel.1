Received: from eggs.gnu.org ([2001:4830:134:3::10]:48971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1ciR8z-0001rr-J0
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1ciR8v-0002a8-LK
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:39:37 -0500
Received: from mail-out.m-online.net ([2001:a60:0:28:0:1:25:1]:35031)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1ciR8v-0002Zs-B8
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:39:33 -0500
References: <20170226164815.26799-1-marex@denx.de>
	<20170227133713.3ae9d820@nial.brq.redhat.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <a6e74fc1-76f6-afc3-4d3a-6d2cd4c54298@denx.de>
Date: Mon, 27 Feb 2017 20:39:17 +0100
MIME-Version: 1.0
In-Reply-To: <20170227133713.3ae9d820@nial.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nios2: iic: Convert CPU prop to qom link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Jeff Da Silva <jdasilva@altera.com>, Chris Wulff <crwulff@gmail.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Ley Foon Tan <lftan@altera.com>, Richard Henderson <rth@twiddle.net>

On 02/27/2017 01:37 PM, Igor Mammedov wrote:
> On Sun, 26 Feb 2017 17:48:15 +0100
> Marek Vasut <marex@denx.de> wrote:
> 
>> Add a const qom link between the CPU and the IIC instead
>> of passing the CPU link through a qom property.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Alexander Graf <agraf@suse.de>
>> Cc: Chris Wulff <crwulff@gmail.com>
>> Cc: Jeff Da Silva <jdasilva@altera.com>
>> Cc: Ley Foon Tan <lftan@altera.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Sandra Loosemore <sandra@codesourcery.com>
>> Cc: Yves Vandervennet <yvanderv@altera.com>
>> ---
>>  hw/intc/nios2_iic.c       | 13 ++++---------
>>  hw/nios2/10m50_devboard.c |  3 ++-
>>  2 files changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/intc/nios2_iic.c b/hw/intc/nios2_iic.c
>> index 818ab1b315..70550ef8c1 100644
>> --- a/hw/intc/nios2_iic.c
>> +++ b/hw/intc/nios2_iic.c
>> @@ -62,17 +62,15 @@ static void altera_iic_init(Object *obj)
>>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &pv->parent_irq);
>>  }
>>  
>> -static Property altera_iic_properties[] = {
>> -    DEFINE_PROP_PTR("cpu", AlteraIIC, cpu),
>> -    DEFINE_PROP_END_OF_LIST(),
>> -};
>> -
>>  static void altera_iic_realize(DeviceState *dev, Error **errp)
>>  {
>>      struct AlteraIIC *pv = ALTERA_IIC(dev);
>> +    Error *err = NULL;
>>  
>> +    pv->cpu = object_property_get_link(OBJECT(dev), "cpu", &err);
>>      if (!pv->cpu) {
>> -        error_setg(errp, "altera,iic: CPU not connected");
>> +        error_setg(errp, "altera,iic: CPU link not found: %s",
>> +                   error_get_pretty(err));
>>          return;
>>      }
>>  }
>> @@ -81,9 +79,6 @@ static void altera_iic_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>>  
>> -    dc->props = altera_iic_properties;
>> -    /* Reason: pointer property "cpu" */
> 
>> -    dc->cannot_instantiate_with_device_add_yet = true;
> this device is still not device_add creatable
> since object_property_add_const_link() is basically the same
> as DEFINE_PROP_PTR("cpu", AlteraIIC, cpu), so drop this hunk.
> 
> otherwise patch is still improvement as it removes an instance
> of obsoleted DEFINE_PROP_PTR

Got it, thanks

>>      dc->realize = altera_iic_realize;
>>  }
>>  
>> diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
>> index 0d8b9aa58f..c18e0b2a17 100644
>> --- a/hw/nios2/10m50_devboard.c
>> +++ b/hw/nios2/10m50_devboard.c
>> @@ -83,7 +83,8 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
>>  
>>      /* Register: Internal Interrupt Controller (IIC) */
>>      dev = qdev_create(NULL, "altera,iic");
>> -    qdev_prop_set_ptr(dev, "cpu", cpu);
>> +    object_property_add_const_link(OBJECT(dev), "cpu", OBJECT(cpu),
>> +                                   &error_abort);
>>      qdev_init_nofail(dev);
>>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irq[0]);
>>      for (i = 0; i < 32; i++) {
> 


-- 
Best regards,
Marek Vasut
