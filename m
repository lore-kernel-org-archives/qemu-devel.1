Received: from eggs.gnu.org ([209.51.188.92]:41532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hAzKf-0001eu-SC
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hAzKe-00037H-4w
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:58:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hAzKd-00036t-Ps
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:58:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so12776867wrd.3
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 08:58:43 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
In-Reply-To: <DF798996-57F7-405A-93D8-F77244B38553@oracle.com>
References: <20190401133659.20421-1-vkuznets@redhat.com>
	<DF798996-57F7-405A-93D8-F77244B38553@oracle.com>
Date: Mon, 01 Apr 2019 17:58:40 +0200
Message-ID: <87a7h91zv3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Liran Alon <liran.alon@oracle.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Liran Alon <liran.alon@oracle.com> writes:

>> On 1 Apr 2019, at 16:36, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> 
>> It was found that Hyper-V 2016 on KVM in some configurations (q35 machine +
>> piix4-usb-uhci) hangs on boot. Trace analysis led us to the conclusion that
>> it is mishandling level-triggered interrupt performing EOI without fixing
>> the root cause.
>
> I would rephrase as:
> It was found that Hyper-V 2016 on KVM in some configurations (q35 machine + piix4-usb-uhci) hangs on boot.
> Root-cause was that one of Hyper-V level-triggered interrupt handler performs EOI before fixing the root-cause.
> This results in IOAPIC keep re-raising the level-triggered interrupt
> after EOI because irq-line remains asserted.

Ok, thanks for the suggestion.

>
>> This causes immediate re-assertion and L2 VM (which is
>> supposedly expected to fix the cause of the interrupt) is not making any
>> progress.
>
> I don’t know why you assume this.
> From the trace we have examined, it seems that the EOI is performed by Hyper-V and not it’s guest
> This means that the handler for this level-triggered interrupt is on
> Hyper-V and not it’s guest.

If you let it run (with e.g. this patch or by setting preemtion timer >
0) you'll see that MMIO write fixing the cause of the interrupt is
happening from L2:

(qemu) info pci:

  Bus  0, device   4, function 0:
    USB controller: PCI device 8086:7112
      PCI subsystem 1af4:1100
      IRQ 23.
      BAR4: I/O at 0x6060 [0x607f].
      id ""

...
  538597.212494: kvm_exit:             reason VMRESUME rip 0xfffff80004250115 info 0 0
  538597.212499: kvm_entry:            vcpu 0
  538597.212506: kvm_exit:             reason IO_INSTRUCTION rip 0xfffff80e02ac6a27 info 60620009 0
  538597.212507: kvm_nested_vmexit:    rip fffff80e02ac6a27 reason IO_INSTRUCTION info1 60620009 info2 0 int_info 0 int_info_err 0
  538597.212509: kvm_fpu:              unload
  538597.212511: kvm_userspace_exit:   reason KVM_EXIT_IO (2)
  538597.212516: kvm_fpu:              load
  538597.212518: kvm_pio:              pio_read at 0x6062 size 2 count 1 val 0x1 
  538597.212519: kvm_entry:            vcpu 0
  538597.212523: kvm_exit:             reason IO_INSTRUCTION rip 0xfffff80e02ac6a61 info 60640009 0
  538597.212523: kvm_nested_vmexit:    rip fffff80e02ac6a61 reason IO_INSTRUCTION info1 60640009 info2 0 int_info 0 int_info_err 0
  538597.212524: kvm_fpu:              unload
  538597.212525: kvm_userspace_exit:   reason KVM_EXIT_IO (2)
  538597.212528: kvm_fpu:              load
  538597.212528: kvm_pio:              pio_read at 0x6064 size 2 count 1 val 0xf 
...

and this happens after EOI from L1.

>
>> 
>> Gory details: https://urldefense.proofpoint.com/v2/url?u=https-3A__www.spinics.net_lists_kvm_msg184484.html&d=DwIDAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=Jk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=Q0Ico0Nb_DGRDrDgXkjkRr-xjzIbOLteVOhDJXBD_pU&s=d_H4_-qzqGvyi8X7g_KA0hZ5a8zjfHQhe1BhLPIokcA&e=
>
> Maybe worth to note that one should read the entire thread to understand the analysis.
>

Sure.

>> 
>> Turns out we were dealing with similar issues before; in-kernel IOAPIC
>> implementation has commit 184564efae4d ("kvm: ioapic: conditionally delay
>> irq delivery duringeoi broadcast") which describes a very similar issue.
>> 
>> Steal the idea from the above mentioned commit for IOAPIC implementation in
>> QEMU. SUCCESSIVE_IRQ_MAX_COUNT, delay and the comment are borrowed as well.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> hw/intc/ioapic.c                  | 43 ++++++++++++++++++++++++++++++-
>> hw/intc/trace-events              |  1 +
>> include/hw/i386/ioapic_internal.h |  3 +++
>> 3 files changed, 46 insertions(+), 1 deletion(-)
>> 
>> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
>> index 9d75f84d3b..daf45cc8a8 100644
>> --- a/hw/intc/ioapic.c
>> +++ b/hw/intc/ioapic.c
>> @@ -139,6 +139,15 @@ static void ioapic_service(IOAPICCommonState *s)
>>    }
>> }
>> 
>> +#define SUCCESSIVE_IRQ_MAX_COUNT 10000
>> +
>> +static void ioapic_timer(void *opaque)
>> +{
>> +    IOAPICCommonState *s = opaque;
>> +
>> +    ioapic_service(s);
>> +}
>> +
>> static void ioapic_set_irq(void *opaque, int vector, int level)
>> {
>>    IOAPICCommonState *s = opaque;
>> @@ -227,7 +236,28 @@ void ioapic_eoi_broadcast(int vector)
>>                trace_ioapic_clear_remote_irr(n, vector);
>>                s->ioredtbl[n] = entry & ~IOAPIC_LVT_REMOTE_IRR;
>
> This clear of remote-irr should happen only for level-triggered interrupts.
> So we can make the code here more structured like KVM’s __kvm_ioapic_update_eoi().
> It also have an extra-value of not advancing "s->irq_reassert[vector]” for vectors which are edge-triggered which is a bit misleading.
>
>>                if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 << n))) {
>> -                    ioapic_service(s);
>> +                    bool level = ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1)
>> +                        == IOAPIC_TRIGGER_LEVEL;
>
> Nit: I would declare variable “trig_mode” and compare it later
> explicitly to IOAPIC_TRIGGER_LEVEL.

Ok.

>
>> +
>> +                    ++s->irq_reassert[vector];
>
> Nit: I would rename “irq_reassert” to “irq_eoi” as it is named in KVM
> IOAPIC code.

Honestly, I did this change on purpose: we're counting how many times the
irq was re-asserted on eoi and 'irq_eoi' sounds more like an EOI flag to
me. 

>
>> +                    if (!level ||
>> +                        s->irq_reassert[vector] < SUCCESSIVE_IRQ_MAX_COUNT) {
>> +                        ioapic_service(s);
>> +                    } else {
>> +                        /*
>> +                         * Real hardware does not deliver the interrupt
>> +                         * immediately during eoi broadcast, and this lets a
>> +                         * buggy guest make slow progress even if it does not
>> +                         * correctly handle a level-triggered interrupt. Emulate
>> +                         * this behavior if we detect an interrupt storm.
>> +                         */
>> +                        trace_ioapic_eoi_delayed_reassert(vector);
>> +                        timer_mod(s->timer,
>> +                                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>> +                                  NANOSECONDS_PER_SECOND / 100);
>
> You need to zero here s->irq_reassert[vector].
> I think you would avoid these kind of little mistakes if you will
> attempt to follow KVM’s commit code structure.

Oh, I borrowed the idea for the commit and you'd like me to borrow the
commit itself :-)

We can, of couse, zero s->irq_reassert[vector] here, however, that would
change the behavior: with my patch we will be delaying all re-assertions
after SUCCESSIVE_IRQ_MAX_COUNT until the line is lowered, not just
one. I'm not sure which is better.

Anyway, I checked and the issue is gone even if we delay once and you're
right that there's no reason to differ from kernel commit. Will fix in
v2, thanks!

>
>> +                    }
>> +                } else {
>> +                    s->irq_reassert[vector] = 0;
>>                }
>>            }
>>        }
>> @@ -401,6 +431,8 @@ static void ioapic_realize(DeviceState *dev, Error **errp)
>>    memory_region_init_io(&s->io_memory, OBJECT(s), &ioapic_io_ops, s,
>>                          "ioapic", 0x1000);
>> 
>> +    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ioapic_timer, s);
>> +
>>    qdev_init_gpio_in(dev, ioapic_set_irq, IOAPIC_NUM_PINS);
>> 
>>    ioapics[ioapic_no] = s;
>> @@ -408,6 +440,14 @@ static void ioapic_realize(DeviceState *dev, Error **errp)
>>    qemu_add_machine_init_done_notifier(&s->machine_done);
>> }
>> 
>> +static void ioapic_unrealize(DeviceState *dev, Error **errp)
>> +{
>> +    IOAPICCommonState *s = IOAPIC_COMMON(dev);
>> +
>> +    timer_del(s->timer);
>> +    timer_free(s->timer);
>> +}
>> +
>> static Property ioapic_properties[] = {
>>    DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF),
>>    DEFINE_PROP_END_OF_LIST(),
>> @@ -419,6 +459,7 @@ static void ioapic_class_init(ObjectClass *klass, void *data)
>>    DeviceClass *dc = DEVICE_CLASS(klass);
>> 
>>    k->realize = ioapic_realize;
>> +    k->unrealize = ioapic_unrealize;
>>    /*
>>     * If APIC is in kernel, we need to update the kernel cache after
>>     * migration, otherwise first 24 gsi routes will be invalid.
>> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
>> index a28bdce925..90c9d07c1a 100644
>> --- a/hw/intc/trace-events
>> +++ b/hw/intc/trace-events
>> @@ -25,6 +25,7 @@ apic_mem_writel(uint64_t addr, uint32_t val) "0x%"PRIx64" = 0x%08x"
>> ioapic_set_remote_irr(int n) "set remote irr for pin %d"
>> ioapic_clear_remote_irr(int n, int vector) "clear remote irr for pin %d vector %d"
>> ioapic_eoi_broadcast(int vector) "EOI broadcast for vector %d"
>> +ioapic_eoi_delayed_reassert(int vector) "delayed reassert on EOI broadcast for vector %d"
>> ioapic_mem_read(uint8_t addr, uint8_t regsel, uint8_t size, uint32_t val) "ioapic mem read addr 0x%"PRIx8" regsel: 0x%"PRIx8" size 0x%"PRIx8" retval 0x%"PRIx32
>> ioapic_mem_write(uint8_t addr, uint8_t regsel, uint8_t size, uint32_t val) "ioapic mem write addr 0x%"PRIx8" regsel: 0x%"PRIx8" size 0x%"PRIx8" val 0x%"PRIx32
>> ioapic_set_irq(int vector, int level) "vector: %d level: %d"
>> diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_internal.h
>> index 9848f391bb..e0ee88db40 100644
>> --- a/include/hw/i386/ioapic_internal.h
>> +++ b/include/hw/i386/ioapic_internal.h
>> @@ -96,6 +96,7 @@ typedef struct IOAPICCommonClass {
>>    SysBusDeviceClass parent_class;
>> 
>>    DeviceRealize realize;
>> +    DeviceUnrealize unrealize;
>>    void (*pre_save)(IOAPICCommonState *s);
>>    void (*post_load)(IOAPICCommonState *s);
>> } IOAPICCommonClass;
>> @@ -111,6 +112,8 @@ struct IOAPICCommonState {
>>    uint8_t version;
>>    uint64_t irq_count[IOAPIC_NUM_PINS];
>>    int irq_level[IOAPIC_NUM_PINS];
>> +    int irq_reassert[IOAPIC_NUM_PINS];
>> +    QEMUTimer *timer;
>> };
>> 
>> void ioapic_reset_common(DeviceState *dev);
>> -- 
>> 2.20.1
>> 
>

-- 
Vitaly
