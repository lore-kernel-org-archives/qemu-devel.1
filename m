Received: from eggs.gnu.org ([2001:4830:134:3::10]:56182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cY9T5-0003B8-TW
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cY9T4-00020h-Mb
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:45:51 -0500
References: <1485422381-29019-1-git-send-email-eric.auger@redhat.com>
	<1485422381-29019-4-git-send-email-eric.auger@redhat.com>
	<87vasw29jy.fsf@emacs.mitica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <21a261aa-15ac-d24f-8318-ec1a659fc293@redhat.com>
Date: Mon, 30 Jan 2017 11:45:38 +0100
MIME-Version: 1.0
In-Reply-To: <87vasw29jy.fsf@emacs.mitica>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 3/4] hw/intc/arm_gicv3_its: Implement state
 save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: peter.maydell@linaro.org, drjones@redhat.com, vijay.kilari@gmail.com, qemu-devel@nongnu.org, peterx@redhat.com, Vijaya.Kumar@cavium.com, qemu-arm@nongnu.org, shannon.zhao@linaro.org, dgilbert@redhat.com, christoffer.dall@linaro.org, eric.auger.pro@gmail.com

Hi Juan,

On 30/01/2017 10:15, Juan Quintela wrote:
> Eric Auger <eric.auger@redhat.com> wrote:
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
> 
> Hi
> 
> 
>> + * vm_change_state_handler - VM change state callback aiming at flushing
>> + * ITS tables into guest RAM
>> + *
>> + * The tables get flushed to guest RAM whenever the VM gets stopped.
>> + */
>> +static void vm_change_state_handler(void *opaque, int running,
>> +                                    RunState state)
>> +{
>> +    GICv3ITSState *s = (GICv3ITSState *)opaque;
> 
> Cast is unneeded.
> 
>> +
>> +    if (running) {
>> +        return;
>> +    }
>> +    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_TABLES,
>> +                      0, NULL, false);
> 
> As you are adding it to do everytime that we stop the guest, how
> expensive/slow is that?

This is highly dependent on the number of devices using MSIs and number
of allocated MSIs on guest. The number of bytes to transfer basically is:

(#nb_vcpus + #nb_devices_using_MSI_on_guest  +  2 *
nb_allocated_guest_MSIs bytes ) * 8 bytes

So I would say < 10 kB in real life case. In my virtio-pci test case it
is just 440 Bytes.

For live migration I could hook a callback at RUN_STATE_FINISH_MIGRATE.
However this does not work with virsh save/restore use case since the
notifier is not called (the VM being already paused), hence that choice.

Thanks

Eric

> 
> Thanks, Juan.
> 
