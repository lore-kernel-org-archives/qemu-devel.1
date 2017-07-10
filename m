Received: from eggs.gnu.org ([2001:4830:134:3::10]:32826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dUfRE-0007W7-Cw
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dUfRA-0008Vc-0j
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:37:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dUfR9-0008UU-Mk
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:37:43 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6AKSjWg067738
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 16:37:42 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bmc3ftdvg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 16:37:41 -0400
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 10 Jul 2017 17:37:38 -0300
References: <20170707212037.24642-1-danielhb@linux.vnet.ibm.com>
	<20170710063910.GB4083@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 10 Jul 2017 17:37:31 -0300
MIME-Version: 1.0
In-Reply-To: <20170710063910.GB4083@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <eeb7b4a2-ebe4-be28-6efd-071e7ab53625@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC drcVI PATCH] spapr: reset DRCs on
 migration pre_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com



On 07/10/2017 03:39 AM, David Gibson wrote:
> On Fri, Jul 07, 2017 at 06:20:37PM -0300, Daniel Henrique Barboza wrote:
>> "spapr: Remove 'awaiting_allocation' DRC flag" removed the flag that
>> was originally was being used to prevent a race condition between
>> hot unplug and hotplug. The DRC code base got simplified and more
>> robust over time, eliminating the conditions that led to this race.
>> Thus the awaiting_allocation existence wasn't justifiable anymore.
>>
>> A side effect of the flag removal was seen when testing the Libvirt
>> hotplug-migration-unplug scenario, where a device is hotplugged in both
>> source and target using device_add prior to the migration, then the
>> device is removed after migration in the target. Before that cleanup, the
>> hot unplug at the target fails in both QEMU and guest kernel because
>> the DRC state at the target is inconsistent. After removing that flag,
>> the hot unplug works at QEMU but the guest kernel hungs on the middle
>> of the unplug process.
>>
>> It turns out that the awaiting_allocation logic was preventing the hot
>> unplug from happening at the target because the DRC state, at this specific
>> hot unplug scenario, was matching the race condition the flag was
>> originally designed to avoid. Removing the flag allowed the device
>> to be removed from QEMU, leading to this new behavior.
>>
>> The root cause of those problems is, in fact, the inconsistent state of the
>> target DRCs after migration is completed. Doing device_add in the
>> INMIGRATE status leaves the DRC in a state that isn't recognized as a
>> valid hotplugged device in the guest OS.
>>
>> This patch fixes the problem by using the recently modified 'drc_reset'
>> function, that now forces the DRC to a known state by checking its device
>> status, to reset all DRCs in the pre_load hook of the migration. Resetting
>> the DRCs in pre_load allows the DRCs to be in a predictable state when
>> we load the migration at the target, allowing for hot unplugs to work
>> as expected.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> Ok, so the fact this works is pretty promising.  However, I'm still
> trying to fully understand what's going on here.  I have a suspicion
> that this is only necessary because something isn't quite right with
> the reset / inmigrate sequencing in the generic code, which we should
> fix instead of hacking around.

Agreed.

>
> IIUC, in the problem case, on the source the hotplug has fully
> completed, so the DRC will be in CONFIGURED state.  Since the device
> is CONFIGURED and attached, no DRC info is sent in the migration
> stream.  On the destination what seems to be happening is:
>
> 1. qemu is started with "-incoming defer", and cpu *not* present
>
>      DRC is uninitialized
>
> 2. qemu_system_reset() is called in vl.c
>
>      DRC is in UNALLOCATED / detached state
>
> 3. libvirt device_adds the cpu
>
>      DRC is in UNALLOCATED / attached state
>
> 4. libvirt initiates incoming migration
>
>      DRC remains in UNALLOCATED / attached state
>
> 5. Guest resumes on the destination
>
>      DRC still in UNALLOCATED / attached state
>
> Which mismatches what we had on the source so => bug.
>
> BUT, AFAIK the libvirt coldplug case below *is* working.  Which
> tracing through the code I'd expect:
>
> 1. qemu is started with -S and cpu not present
>
>     DRC is uninitialized
>
> 2. qemu_system_reset() is called in vl.c
>
>     DRC is in UNALLOCATED / detached state
>
> 3. libvirt device_adds in prelaunch phase
>
>     DRC is in UNALLOCATED / attached state
>
> 4. Guest is started
>
>     DRC is in UNALLOCATED / attached state
>
> Which is also incorrect: the device was present when the guest
> started, so it should be in CONFIGURED state.  IIUC this case is
> working, so I think it is must actually be in CONFIGURED state.

Just did a test here and the device isn't present when the guest starts 
in the second
example you mentioned,  Tested with current qemu master. QEMU shows the 
extra
CPU as 'halted' always, even after the guest starts and OS boots up:

danielhb@louis:~/qemu/build/ppc64-softmmu$ sudo ./qemu-system-ppc64 
-name migrate_qemu -boot strict=on --enable-kvm -device 
nec-usb-xhci,id=usb,bus=pci.0,addr=0xf -device 
spapr-vscsi,id=scsi0,reg=0x2000 -smp 
1,maxcpus=4,sockets=4,cores=1,threads=1 --machine 
pseries,accel=kvm,usb=off,dump-guest-core=off -m 4G,slots=32,maxmem=32G 
-drive 
file=/home/danielhb/vm_imgs/ubuntu1704.qcow2,format=qcow2,if=none,id=drive-virtio-disk0,cache=none 
-device 
virtio-blk-pci,scsi=off,bus=pci.0,addr=0x2,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 
-nographic -S
QEMU 2.9.50 monitor - type 'help' for more information

<<<<< at this point qemu_system_reset is called, as expected >>>>>

(qemu) device_add host-spapr-cpu-core,id=core1,core-id=1
(qemu) info cpus
* CPU #0: nip=0x0000000000000100 thread_id=16523
   CPU #1: nip=0x0000000000000000 (halted) thread_id=16598
(qemu) cont

--- guest boots up ----

(qemu) info cpus
* CPU #0: nip=0xc0000000000a3e0c thread_id=16523
   CPU #1: nip=0x0000000000000000 (halted) thread_id=16598

danielhb@ubuntu1704:~$ lscpu
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                1
On-line CPU(s) list:   0
Thread(s) per core:    1
Core(s) per socket:    1
Socket(s):             1
NUMA node(s):          1
Model:                 2.1 (pvr 004b 0201)
Model name:            POWER8E (raw), altivec supported
Hypervisor vendor:     horizontal
Virtualization type:   full
L1d cache:             64K
L1i cache:             32K
NUMA node0 CPU(s):     0
danielhb@ubuntu1704:~$ (qemu)
(qemu) device_del core1
(qemu) info cpus
* CPU #0: nip=0xc0000000000a3e0c thread_id=16523
   CPU #1: nip=0x0000000000000000 (halted) thread_id=16598

danielhb@ubuntu1704:~$ lscpu
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                1
On-line CPU(s) list:   0
Thread(s) per core:    1
Core(s) per socket:    1
Socket(s):             1
NUMA node(s):          1
Model:                 2.1 (pvr 004b 0201)
Model name:            POWER8E (raw), altivec supported
Hypervisor vendor:     horizontal
Virtualization type:   full
L1d cache:             64K
L1i cache:             32K
NUMA node0 CPU(s):     0
danielhb@ubuntu1704:~$ dmesg | tail -n 5
[    6.307988] audit: type=1400 audit(1499705034.060:10): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/bin/lxc-start" pid=2212 comm="apparmor_parser"
[    6.318556] audit: type=1400 audit(1499705034.068:11): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/lib/snapd/snap-confine" pid=2213 comm="apparmor_parser"
[    7.087170] cgroup: new mount options do not match the existing 
superblock, will be ignored
[   88.093598] pseries-hotplug-cpu: Failed to acquire DRC, rc: -22, drc 
index: 10000008
[   88.093606] pseries-hotplug-cpu: Cannot find CPU (drc index 10000008) 
to remove
danielhb@ubuntu1704:~$


Debugging it a little I see that device_adding a CPU while the VM isn't 
started yet is being considered
"hotplugged" by spapr_core_plug (dev->hotplugged is True). Also, there 
is a note in 'spapr_cpu_reset'
saying:

     /* All CPUs start halted.  CPU0 is unhalted from the machine level
      * reset code and the rest are explicitly started up by the guest
      * using an RTAS call */
     cs->halted = 1;

And yeah, the guest isn't calling 'start-cpu' and the CPU remains 
halted. When comparing to
a scenario where I start the VM with 2 cpus in the command line, the 
first one is started by the
machine reset and the other one by the RTAS call 'start-cpu', as 
expected I'll investigate why this
is happening - starting with 2 coldplugged CPUs versus one coldplugged 
CPU and a second one
attached with device_add with while on -S should yield the same outcome.


All this said, I am not sure if this behavior has the same root cause as 
the migration problem
this patch solves with the reset on pre_load though. Hopefully I'll know 
more in these next days.


>
> So, I'm trying to understand why we get different results in these two
> cases.
>
> [Aside:
>
> If we do need to manually trigger a reset, code like the below is
> basically what we need.  Just putting a reset in each DRC's pre_load
> looks neater, but won't work - the pre_load won't be called unless the
> object actually appears in the migration stream, and IIUC the case
> which isn't working is exactly the case where the object is omitted
> from the migration stream.]

Yeah, I have thought about it before sending this RFC patch and I 
couldn't find anywhere
else to hook this reset code, given that the pre_load hook requires the 
object to
be migrated. And, as you said, if the DRC is being migrated the problem 
doesn't
happen anyway.


Daniel

>
>> ---
>>   hw/ppc/spapr.c             |  7 +++++++
>>   hw/ppc/spapr_drc.c         | 17 +++++++++++++++++
>>   include/hw/ppc/spapr_drc.h |  1 +
>>   3 files changed, 25 insertions(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 089d41d..aea85b0 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1473,6 +1473,12 @@ static bool spapr_vga_init(PCIBus *pci_bus, Error **errp)
>>       }
>>   }
>>   
>> +static int spapr_pre_load(void *opaque)
>> +{
>> +    spapr_reset_all_drcs();
>> +    return 0;
>> +}
>> +
>>   static int spapr_post_load(void *opaque, int version_id)
>>   {
>>       sPAPRMachineState *spapr = (sPAPRMachineState *)opaque;
>> @@ -1598,6 +1604,7 @@ static const VMStateDescription vmstate_spapr = {
>>       .name = "spapr",
>>       .version_id = 3,
>>       .minimum_version_id = 1,
>> +    .pre_load = spapr_pre_load,
>>       .post_load = spapr_post_load,
>>       .fields = (VMStateField[]) {
>>           /* used to be @next_irq */
>> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
>> index 63637d8..74f3957 100644
>> --- a/hw/ppc/spapr_drc.c
>> +++ b/hw/ppc/spapr_drc.c
>> @@ -449,6 +449,23 @@ static void drc_reset(void *opaque)
>>       drc->ccs_depth = -1;
>>   }
>>   
>> +void spapr_reset_all_drcs(void)
>> +{
>> +    Object *drc_container, *obj;
>> +    ObjectProperty *prop;
>> +    ObjectPropertyIterator iter;
>> +
>> +    drc_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
>> +    object_property_iter_init(&iter, drc_container);
>> +    while ((prop = object_property_iter_next(&iter))) {
>> +        if (!strstart(prop->type, "link<", NULL)) {
>> +            continue;
>> +        }
>> +        obj = object_property_get_link(drc_container, prop->name, NULL);
>> +        drc_reset(SPAPR_DR_CONNECTOR(obj));
>> +    }
>> +}
>> +
>>   static bool spapr_drc_needed(void *opaque)
>>   {
>>       sPAPRDRConnector *drc = (sPAPRDRConnector *)opaque;
>> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
>> index 4c54864..c7553e6 100644
>> --- a/include/hw/ppc/spapr_drc.h
>> +++ b/include/hw/ppc/spapr_drc.h
>> @@ -250,4 +250,5 @@ static inline bool spapr_drc_unplug_requested(sPAPRDRConnector *drc)
>>       return drc->unplug_requested;
>>   }
>>   
>> +void spapr_reset_all_drcs(void);
>>   #endif /* HW_SPAPR_DRC_H */
