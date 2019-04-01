Received: from eggs.gnu.org ([209.51.188.92]:54924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hB0Sv-0006ZO-41
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hB0St-0005va-36
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:11:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hB0Ss-0005ub-LB
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:11:19 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <87a7h91zv3.fsf@vitty.brq.redhat.com>
Date: Mon, 1 Apr 2019 20:11:11 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <85937523-29B7-4D0B-820A-F28376D4D9F3@oracle.com>
References: <20190401133659.20421-1-vkuznets@redhat.com>
	<DF798996-57F7-405A-93D8-F77244B38553@oracle.com>
	<87a7h91zv3.fsf@vitty.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ioapic: allow buggy guests mishandling
 level-triggered interrupts to make progress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>



> On 1 Apr 2019, at 18:58, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>=20
> Liran Alon <liran.alon@oracle.com> writes:
>=20
>>> On 1 Apr 2019, at 16:36, Vitaly Kuznetsov <vkuznets@redhat.com> =
wrote:
>>>=20
>>> It was found that Hyper-V 2016 on KVM in some configurations (q35 =
machine +
>>> piix4-usb-uhci) hangs on boot. Trace analysis led us to the =
conclusion that
>>> it is mishandling level-triggered interrupt performing EOI without =
fixing
>>> the root cause.
>>=20
>> I would rephrase as:
>> It was found that Hyper-V 2016 on KVM in some configurations (q35 =
machine + piix4-usb-uhci) hangs on boot.
>> Root-cause was that one of Hyper-V level-triggered interrupt handler =
performs EOI before fixing the root-cause.
>> This results in IOAPIC keep re-raising the level-triggered interrupt
>> after EOI because irq-line remains asserted.
>=20
> Ok, thanks for the suggestion.
>=20
>>=20
>>> This causes immediate re-assertion and L2 VM (which is
>>> supposedly expected to fix the cause of the interrupt) is not making =
any
>>> progress.
>>=20
>> I don=E2=80=99t know why you assume this.
>> =46rom the trace we have examined, it seems that the EOI is performed =
by Hyper-V and not it=E2=80=99s guest
>> This means that the handler for this level-triggered interrupt is on
>> Hyper-V and not it=E2=80=99s guest.
>=20
> If you let it run (with e.g. this patch or by setting preemtion timer =
>
> 0) you'll see that MMIO write fixing the cause of the interrupt is
> happening from L2:
>=20
> (qemu) info pci:
>=20
>  Bus  0, device   4, function 0:
>    USB controller: PCI device 8086:7112
>      PCI subsystem 1af4:1100
>      IRQ 23.
>      BAR4: I/O at 0x6060 [0x607f].
>      id ""
>=20
> ...
>  538597.212494: kvm_exit:             reason VMRESUME rip =
0xfffff80004250115 info 0 0
>  538597.212499: kvm_entry:            vcpu 0
>  538597.212506: kvm_exit:             reason IO_INSTRUCTION rip =
0xfffff80e02ac6a27 info 60620009 0
>  538597.212507: kvm_nested_vmexit:    rip fffff80e02ac6a27 reason =
IO_INSTRUCTION info1 60620009 info2 0 int_info 0 int_info_err 0
>  538597.212509: kvm_fpu:              unload
>  538597.212511: kvm_userspace_exit:   reason KVM_EXIT_IO (2)
>  538597.212516: kvm_fpu:              load
>  538597.212518: kvm_pio:              pio_read at 0x6062 size 2 count =
1 val 0x1=20
>  538597.212519: kvm_entry:            vcpu 0
>  538597.212523: kvm_exit:             reason IO_INSTRUCTION rip =
0xfffff80e02ac6a61 info 60640009 0
>  538597.212523: kvm_nested_vmexit:    rip fffff80e02ac6a61 reason =
IO_INSTRUCTION info1 60640009 info2 0 int_info 0 int_info_err 0
>  538597.212524: kvm_fpu:              unload
>  538597.212525: kvm_userspace_exit:   reason KVM_EXIT_IO (2)
>  538597.212528: kvm_fpu:              load
>  538597.212528: kvm_pio:              pio_read at 0x6064 size 2 count =
1 val 0xf=20
> ...
>=20
> and this happens after EOI from L1.

I see that the L2 guest is doing I/O read to the device BAR4 but do =
these reads lower the irq-line?
I would expect a write to lower the irq-line.

Looking at uhci_port_read(), it seems that offset 0x02 and 0x04 just =
return a value. Doesn=E2=80=99t lower irq-line.
(Even though offset 0x04 returns the "interrupt enable register=E2=80=9D).=

In contrast, looking at uhci_port_write(), it seems that writing to =
either offset 0x02 or 0x04 could lower the irq-line.
So you should look for pio_write to port 0x6062 or 0x6064 to see who is =
actually responsible for lowering the irq-line.

Having said that, it does make sense that the layer (L1/L2) who =
interacts in any way with the device=E2=80=99s BAR is probably
also the one who lowers the irq-line.
I just fine it hard to believe that on a real physical hardware with =
this device, that there will be no issue. i.e. That hardware IOAPIC
will delay the re-injection of the level-triggered interrupt (since the =
IOAPIC EOI) by so much that Hyper-V can make it to resume into it=E2=80=99=
s guest before it is injected.
Maybe Hyper-V was never tested with such a real device? ;)

>=20
>>=20
>>>=20
>>> Gory details: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.spinics.net_lis=
ts_kvm_msg184484.html&d=3DDwIDAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65ea=
pI_JnE&r=3DJk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3DQ0Ico0Nb_DGRDrD=
gXkjkRr-xjzIbOLteVOhDJXBD_pU&s=3Dd_H4_-qzqGvyi8X7g_KA0hZ5a8zjfHQhe1BhLPIok=
cA&e=3D
>>=20
>> Maybe worth to note that one should read the entire thread to =
understand the analysis.
>>=20
>=20
> Sure.
>=20
>>>=20
>>> Turns out we were dealing with similar issues before; in-kernel =
IOAPIC
>>> implementation has commit 184564efae4d ("kvm: ioapic: conditionally =
delay
>>> irq delivery duringeoi broadcast") which describes a very similar =
issue.
>>>=20
>>> Steal the idea from the above mentioned commit for IOAPIC =
implementation in
>>> QEMU. SUCCESSIVE_IRQ_MAX_COUNT, delay and the comment are borrowed =
as well.
>>>=20
>>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>> ---
>>> hw/intc/ioapic.c                  | 43 =
++++++++++++++++++++++++++++++-
>>> hw/intc/trace-events              |  1 +
>>> include/hw/i386/ioapic_internal.h |  3 +++
>>> 3 files changed, 46 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
>>> index 9d75f84d3b..daf45cc8a8 100644
>>> --- a/hw/intc/ioapic.c
>>> +++ b/hw/intc/ioapic.c
>>> @@ -139,6 +139,15 @@ static void ioapic_service(IOAPICCommonState =
*s)
>>>   }
>>> }
>>>=20
>>> +#define SUCCESSIVE_IRQ_MAX_COUNT 10000
>>> +
>>> +static void ioapic_timer(void *opaque)
>>> +{
>>> +    IOAPICCommonState *s =3D opaque;
>>> +
>>> +    ioapic_service(s);
>>> +}
>>> +
>>> static void ioapic_set_irq(void *opaque, int vector, int level)
>>> {
>>>   IOAPICCommonState *s =3D opaque;
>>> @@ -227,7 +236,28 @@ void ioapic_eoi_broadcast(int vector)
>>>               trace_ioapic_clear_remote_irr(n, vector);
>>>               s->ioredtbl[n] =3D entry & ~IOAPIC_LVT_REMOTE_IRR;
>>=20
>> This clear of remote-irr should happen only for level-triggered =
interrupts.
>> So we can make the code here more structured like KVM=E2=80=99s =
__kvm_ioapic_update_eoi().
>> It also have an extra-value of not advancing =
"s->irq_reassert[vector]=E2=80=9D for vectors which are edge-triggered =
which is a bit misleading.
>>=20
>>>               if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 << =
n))) {
>>> -                    ioapic_service(s);
>>> +                    bool level =3D ((entry >> =
IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1)
>>> +                        =3D=3D IOAPIC_TRIGGER_LEVEL;
>>=20
>> Nit: I would declare variable =E2=80=9Ctrig_mode=E2=80=9D and compare =
it later
>> explicitly to IOAPIC_TRIGGER_LEVEL.
>=20
> Ok.
>=20
>>=20
>>> +
>>> +                    ++s->irq_reassert[vector];
>>=20
>> Nit: I would rename =E2=80=9Cirq_reassert=E2=80=9D to =E2=80=9Cirq_eoi=E2=
=80=9D as it is named in KVM
>> IOAPIC code.
>=20
> Honestly, I did this change on purpose: we're counting how many times =
the
> irq was re-asserted on eoi and 'irq_eoi' sounds more like an EOI flag =
to
> me.=20

Ok. :)

>=20
>>=20
>>> +                    if (!level ||
>>> +                        s->irq_reassert[vector] < =
SUCCESSIVE_IRQ_MAX_COUNT) {
>>> +                        ioapic_service(s);
>>> +                    } else {
>>> +                        /*
>>> +                         * Real hardware does not deliver the =
interrupt
>>> +                         * immediately during eoi broadcast, and =
this lets a
>>> +                         * buggy guest make slow progress even if =
it does not
>>> +                         * correctly handle a level-triggered =
interrupt. Emulate
>>> +                         * this behavior if we detect an interrupt =
storm.
>>> +                         */
>>> +                        trace_ioapic_eoi_delayed_reassert(vector);
>>> +                        timer_mod(s->timer,
>>> +                                  =
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>>> +                                  NANOSECONDS_PER_SECOND / 100);
>>=20
>> You need to zero here s->irq_reassert[vector].
>> I think you would avoid these kind of little mistakes if you will
>> attempt to follow KVM=E2=80=99s commit code structure.
>=20
> Oh, I borrowed the idea for the commit and you'd like me to borrow the
> commit itself :-)

Yep :P

>=20
> We can, of couse, zero s->irq_reassert[vector] here, however, that =
would
> change the behavior: with my patch we will be delaying all =
re-assertions
> after SUCCESSIVE_IRQ_MAX_COUNT until the line is lowered, not just
> one. I'm not sure which is better.
>=20
> Anyway, I checked and the issue is gone even if we delay once and =
you're
> right that there's no reason to differ from kernel commit. Will fix in
> v2, thanks!

Thanks,
-Liran

>=20
>>=20
>>> +                    }
>>> +                } else {
>>> +                    s->irq_reassert[vector] =3D 0;
>>>               }
>>>           }
>>>       }
>>> @@ -401,6 +431,8 @@ static void ioapic_realize(DeviceState *dev, =
Error **errp)
>>>   memory_region_init_io(&s->io_memory, OBJECT(s), &ioapic_io_ops, s,
>>>                         "ioapic", 0x1000);
>>>=20
>>> +    s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, ioapic_timer, s);
>>> +
>>>   qdev_init_gpio_in(dev, ioapic_set_irq, IOAPIC_NUM_PINS);
>>>=20
>>>   ioapics[ioapic_no] =3D s;
>>> @@ -408,6 +440,14 @@ static void ioapic_realize(DeviceState *dev, =
Error **errp)
>>>   qemu_add_machine_init_done_notifier(&s->machine_done);
>>> }
>>>=20
>>> +static void ioapic_unrealize(DeviceState *dev, Error **errp)
>>> +{
>>> +    IOAPICCommonState *s =3D IOAPIC_COMMON(dev);
>>> +
>>> +    timer_del(s->timer);
>>> +    timer_free(s->timer);
>>> +}
>>> +
>>> static Property ioapic_properties[] =3D {
>>>   DEFINE_PROP_UINT8("version", IOAPICCommonState, version, =
IOAPIC_VER_DEF),
>>>   DEFINE_PROP_END_OF_LIST(),
>>> @@ -419,6 +459,7 @@ static void ioapic_class_init(ObjectClass =
*klass, void *data)
>>>   DeviceClass *dc =3D DEVICE_CLASS(klass);
>>>=20
>>>   k->realize =3D ioapic_realize;
>>> +    k->unrealize =3D ioapic_unrealize;
>>>   /*
>>>    * If APIC is in kernel, we need to update the kernel cache after
>>>    * migration, otherwise first 24 gsi routes will be invalid.
>>> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
>>> index a28bdce925..90c9d07c1a 100644
>>> --- a/hw/intc/trace-events
>>> +++ b/hw/intc/trace-events
>>> @@ -25,6 +25,7 @@ apic_mem_writel(uint64_t addr, uint32_t val) =
"0x%"PRIx64" =3D 0x%08x"
>>> ioapic_set_remote_irr(int n) "set remote irr for pin %d"
>>> ioapic_clear_remote_irr(int n, int vector) "clear remote irr for pin =
%d vector %d"
>>> ioapic_eoi_broadcast(int vector) "EOI broadcast for vector %d"
>>> +ioapic_eoi_delayed_reassert(int vector) "delayed reassert on EOI =
broadcast for vector %d"
>>> ioapic_mem_read(uint8_t addr, uint8_t regsel, uint8_t size, uint32_t =
val) "ioapic mem read addr 0x%"PRIx8" regsel: 0x%"PRIx8" size 0x%"PRIx8" =
retval 0x%"PRIx32
>>> ioapic_mem_write(uint8_t addr, uint8_t regsel, uint8_t size, =
uint32_t val) "ioapic mem write addr 0x%"PRIx8" regsel: 0x%"PRIx8" size =
0x%"PRIx8" val 0x%"PRIx32
>>> ioapic_set_irq(int vector, int level) "vector: %d level: %d"
>>> diff --git a/include/hw/i386/ioapic_internal.h =
b/include/hw/i386/ioapic_internal.h
>>> index 9848f391bb..e0ee88db40 100644
>>> --- a/include/hw/i386/ioapic_internal.h
>>> +++ b/include/hw/i386/ioapic_internal.h
>>> @@ -96,6 +96,7 @@ typedef struct IOAPICCommonClass {
>>>   SysBusDeviceClass parent_class;
>>>=20
>>>   DeviceRealize realize;
>>> +    DeviceUnrealize unrealize;
>>>   void (*pre_save)(IOAPICCommonState *s);
>>>   void (*post_load)(IOAPICCommonState *s);
>>> } IOAPICCommonClass;
>>> @@ -111,6 +112,8 @@ struct IOAPICCommonState {
>>>   uint8_t version;
>>>   uint64_t irq_count[IOAPIC_NUM_PINS];
>>>   int irq_level[IOAPIC_NUM_PINS];
>>> +    int irq_reassert[IOAPIC_NUM_PINS];
>>> +    QEMUTimer *timer;
>>> };
>>>=20
>>> void ioapic_reset_common(DeviceState *dev);
>>> --=20
>>> 2.20.1
>>>=20
>>=20
>=20
> --=20
> Vitaly
