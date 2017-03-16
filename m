Received: from eggs.gnu.org ([2001:4830:134:3::10]:49337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1coXIu-0002Zy-F5
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1coXIt-0002mk-1h
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:27:04 -0400
References: <1488800894-22421-1-git-send-email-eric.auger@redhat.com>
	<1488800894-22421-3-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-wjjQgqx=Ojkq8TFhF_YLrOY1UtsC=5cHh++idrcefKg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3625917f-dee5-4aaf-0a48-45e8761fdde8@redhat.com>
Date: Thu, 16 Mar 2017 16:26:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-wjjQgqx=Ojkq8TFhF_YLrOY1UtsC=5cHh++idrcefKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 2/3] hw/intc/arm_gicv3_its: Implement
 state save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Vijay Kilari <vijay.kilari@gmail.com>, "Kumar, Vijaya" <Vijaya.Kumar@cavium.com>, Andrew Jones <drjones@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>

Hi Peter,

On 13/03/2017 18:58, Peter Maydell wrote:
> On 6 March 2017 at 12:48, Eric Auger <eric.auger@redhat.com> wrote:
>> We need to handle both registers and ITS tables. While
>> register handling is standard, ITS table handling is more
>> challenging since the kernel API is devised so that the
>> tables are flushed into guest RAM and not in vmstate buffers.
>>
>> Flushing the ITS tables on device pre_save() is too late
>> since the guest RAM had already been saved at this point.
>>
>> Table flushing needs to happen when we are sure the vcpus
>> are stopped and before the last dirty page saving. The
>> right point is RUN_STATE_FINISH_MIGRATE but sometimes the
>> VM gets stopped before migration launch so let's simply
>> flush the tables each time the VM gets stopped.
>>
>> For regular ITS registers we just can use vmstate pre_save
>> and post_load callbacks.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> ---
>>  hw/intc/arm_gicv3_its_common.c         |  8 ++++
>>  hw/intc/arm_gicv3_its_kvm.c            | 86 ++++++++++++++++++++++++++++++++++
>>  include/hw/intc/arm_gicv3_its_common.h |  6 +++
>>  3 files changed, 100 insertions(+)
>>
>> diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
>> index 9d67c5c..75b9f04 100644
>> --- a/hw/intc/arm_gicv3_its_common.c
>> +++ b/hw/intc/arm_gicv3_its_common.c
>> @@ -49,6 +49,14 @@ static const VMStateDescription vmstate_its = {
>>      .pre_save = gicv3_its_pre_save,
>>      .post_load = gicv3_its_post_load,
>>      .unmigratable = true,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT32(ctlr, GICv3ITSState),
>> +        VMSTATE_UINT64(cbaser, GICv3ITSState),
>> +        VMSTATE_UINT64(cwriter, GICv3ITSState),
>> +        VMSTATE_UINT64(creadr, GICv3ITSState),
>> +        VMSTATE_UINT64_ARRAY(baser, GICv3ITSState, 8),
> 
> Should we also migrate GITS_IIDR and GITS_TYPER ?

> 
> (For instance the ITT_entry_size field in GITS_IIDR 
s/GITS_IIDR/GITS_TYPER
will
> be needed if we want to distinguish "8 bytes per entry" from
> a future "16 bytes per entry" new format.)
Yes I think it makes sense following our discussion on GICv4 feature update
> 
>> +        VMSTATE_END_OF_LIST()
>> +    },
>>  };
>>
>>  static MemTxResult gicv3_its_trans_read(void *opaque, hwaddr offset,
>> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
>> index bd4f3aa..45e57d6 100644
>> --- a/hw/intc/arm_gicv3_its_kvm.c
>> +++ b/hw/intc/arm_gicv3_its_kvm.c
>> @@ -53,6 +53,24 @@ static int kvm_its_send_msi(GICv3ITSState *s, uint32_t value, uint16_t devid)
>>      return kvm_vm_ioctl(kvm_state, KVM_SIGNAL_MSI, &msi);
>>  }
>>
>> +/**
>> + * vm_change_state_handler - VM change state callback aiming at flushing
>> + * ITS tables into guest RAM
>> + *
>> + * The tables get flushed to guest RAM whenever the VM gets stopped.
>> + */
>> +static void vm_change_state_handler(void *opaque, int running,
>> +                                    RunState state)
>> +{
>> +    GICv3ITSState *s = (GICv3ITSState *)opaque;
>> +
>> +    if (running) {
>> +        return;
>> +    }
>> +    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_TABLES,
>> +                      0, NULL, false);
>> +}
>> +
>>  static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
>>  {
>>      GICv3ITSState *s = ARM_GICV3_ITS_COMMON(dev);
>> @@ -89,6 +107,8 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
>>      kvm_msi_use_devid = true;
>>      kvm_gsi_direct_mapping = false;
>>      kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
>> +
>> +    qemu_add_vm_change_state_handler(vm_change_state_handler, s);
>>  }
>>
>>  static void kvm_arm_its_init(Object *obj)
>> @@ -102,6 +122,70 @@ static void kvm_arm_its_init(Object *obj)
>>                               &error_abort);
>>  }
>>
>> +/**
>> + * kvm_arm_its_get - handles the saving of ITS registers.
>> + * ITS tables, being flushed into guest RAM needs to be saved before
>> + * the pre_save() callback, hence the migration state change notifiers
>> + */
> 
> I find this comment a little cryptic -- can you rephrase/expand
> it a bit, please?
definitively this does not mean anything!

I wanted to say that the pre_save() cannot handle the flush of the ITS
table into guest RAM since it is too late as the RAM has already been
copied my migration code.
> 
>> +static void kvm_arm_its_get(GICv3ITSState *s)
>> +{
>> +    uint64_t reg;
>> +    int i;
>> +
>> +    for (i = 0; i < 8; i++) {
>> +        kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>> +                          GITS_BASER + i * 8, &s->baser[i], false);
>> +    }
>> +
>> +    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>> +                      GITS_CTLR, &reg, false);
>> +    s->ctlr = extract64(reg, 0, 32);
> 
> The kernel will write 0s to the top 32 bits of 'reg', right?
> So you can just say "s->ctlr = reg;"
yes
> 
> (I wondered about suggesting making s->ctlr 64 bits, but that's
> harder to justify than for a system register, because it really
> is only 4 bytes in the ITS register map. So it being 64 bits in
> the KVM ABI is not an architectural thing, and we should thus
> leave it as uint32_t in QEMU.)
yep
> 
>> +
>> +    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>> +                      GITS_CBASER, &s->cbaser, false);
>> +
>> +    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>> +                      GITS_CREADR, &s->creadr, false);
>> +
>> +    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>> +                      GITS_CWRITER, &s->cwriter, false);
>> +}
>> +
>> +/**
>> + * kvm_arm_its_put - Restore both the ITS registers and guest RAM tables
>> + * ITS tables, being flushed into guest RAM needs to be saved before
>> + * the pre_save() callback.
> 
> Cut and paste error? This is about restore, not save.
definitively
> 
>> The restoration order matters since there
>> + * are dependencies between register settings, as specified by the
>> + * architecture specification
>> + */
>> +static void kvm_arm_its_put(GICv3ITSState *s)
>> +{
>> +    uint64_t reg;
>> +    int i;
>> +
>> +    /* must be written before GITS_CREADR since it resets this latter*/
> 
> "later", or do you mean something I don't understand ?
> 
>> +    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>> +                      GITS_CBASER, &s->cbaser, true);
>> +
>> +    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>> +                      GITS_CREADR, &s->creadr, true);
>> +
>> +    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>> +                      GITS_CWRITER, &s->cwriter, true);
>> +
>> +    for (i = 0; i < 8; i++) {
>> +        kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>> +                          GITS_BASER + i * 8, &s->baser[i], true);
>> +    }
>> +
>> +    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_TABLES,
>> +                      0, NULL, true);
>> +
>> +    reg = s->ctlr;
>> +    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>> +                      GITS_CTLR, &reg, true);
>> +}
>> +
>>  static void kvm_arm_its_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>> @@ -109,6 +193,8 @@ static void kvm_arm_its_class_init(ObjectClass *klass, void *data)
>>
>>      dc->realize = kvm_arm_its_realize;
>>      icc->send_msi = kvm_its_send_msi;
>> +    icc->pre_save = kvm_arm_its_get;
>> +    icc->post_load = kvm_arm_its_put;
> 
> Oh, those were pre_save and post_load functions? Can
> you name them kvm_arm_its_pre_save and kvm_arm_its_post_load,
> please, so that it's clearer what they are?
yes I will rename those functions.

Thanks

Eric
> 
>>  }
>>
>>  static const TypeInfo kvm_arm_its_info = {
>> diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
>> index 1ba1894..ed5d6df 100644
>> --- a/include/hw/intc/arm_gicv3_its_common.h
>> +++ b/include/hw/intc/arm_gicv3_its_common.h
>> @@ -28,6 +28,12 @@
>>  #define ITS_TRANS_SIZE   0x10000
>>  #define ITS_SIZE         (ITS_CONTROL_SIZE + ITS_TRANS_SIZE)
>>
>> +#define GITS_CTLR        0x0
>> +#define GITS_CBASER      0x80
>> +#define GITS_CWRITER     0x88
>> +#define GITS_CREADR      0x90
>> +#define GITS_BASER       0x100
>> +
>>  struct GICv3ITSState {
>>      SysBusDevice parent_obj;
>>
>> --
>> 2.5.5
> 
> thanks
> -- PMM
> 
