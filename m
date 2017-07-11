Received: from eggs.gnu.org ([2001:4830:134:3::10]:55921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dUvjT-0000pL-23
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dUvjQ-0006z6-D4
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:01:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50496
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dUvjQ-0006yp-6D
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:01:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6BDwtbT052058
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:01:39 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bmykghb8a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:01:38 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 11 Jul 2017 11:01:36 -0300
References: <20170707212037.24642-1-danielhb@linux.vnet.ibm.com>
	<20170710063910.GB4083@umbus.fritz.box>
	<eeb7b4a2-ebe4-be28-6efd-071e7ab53625@linux.vnet.ibm.com>
	<20170711130047.GI4083@umbus.fritz.box>
	<20170711134143.GK4083@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 11 Jul 2017 11:01:31 -0300
MIME-Version: 1.0
In-Reply-To: <20170711134143.GK4083@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <16563a30-08d7-1953-2e57-37e9926cf14b@linux.vnet.ibm.com>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com



On 07/11/2017 10:41 AM, David Gibson wrote:
> On Tue, Jul 11, 2017 at 11:00:47PM +1000, David Gibson wrote:
>> On Mon, Jul 10, 2017 at 05:37:31PM -0300, Daniel Henrique Barboza wrote:
>>>
>>> On 07/10/2017 03:39 AM, David Gibson wrote:
>>>> On Fri, Jul 07, 2017 at 06:20:37PM -0300, Daniel Henrique Barboza wrote:
>>>>> "spapr: Remove 'awaiting_allocation' DRC flag" removed the flag that
>>>>> was originally was being used to prevent a race condition between
>>>>> hot unplug and hotplug. The DRC code base got simplified and more
>>>>> robust over time, eliminating the conditions that led to this race.
>>>>> Thus the awaiting_allocation existence wasn't justifiable anymore.
>>>>>
>>>>> A side effect of the flag removal was seen when testing the Libvirt
>>>>> hotplug-migration-unplug scenario, where a device is hotplugged in both
>>>>> source and target using device_add prior to the migration, then the
>>>>> device is removed after migration in the target. Before that cleanup, the
>>>>> hot unplug at the target fails in both QEMU and guest kernel because
>>>>> the DRC state at the target is inconsistent. After removing that flag,
>>>>> the hot unplug works at QEMU but the guest kernel hungs on the middle
>>>>> of the unplug process.
>>>>>
>>>>> It turns out that the awaiting_allocation logic was preventing the hot
>>>>> unplug from happening at the target because the DRC state, at this specific
>>>>> hot unplug scenario, was matching the race condition the flag was
>>>>> originally designed to avoid. Removing the flag allowed the device
>>>>> to be removed from QEMU, leading to this new behavior.
>>>>>
>>>>> The root cause of those problems is, in fact, the inconsistent state of the
>>>>> target DRCs after migration is completed. Doing device_add in the
>>>>> INMIGRATE status leaves the DRC in a state that isn't recognized as a
>>>>> valid hotplugged device in the guest OS.
>>>>>
>>>>> This patch fixes the problem by using the recently modified 'drc_reset'
>>>>> function, that now forces the DRC to a known state by checking its device
>>>>> status, to reset all DRCs in the pre_load hook of the migration. Resetting
>>>>> the DRCs in pre_load allows the DRCs to be in a predictable state when
>>>>> we load the migration at the target, allowing for hot unplugs to work
>>>>> as expected.
>>>>>
>>>>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>>>> Ok, so the fact this works is pretty promising.  However, I'm still
>>>> trying to fully understand what's going on here.  I have a suspicion
>>>> that this is only necessary because something isn't quite right with
>>>> the reset / inmigrate sequencing in the generic code, which we should
>>>> fix instead of hacking around.
>>> Agreed.
>>>
>>>> IIUC, in the problem case, on the source the hotplug has fully
>>>> completed, so the DRC will be in CONFIGURED state.  Since the device
>>>> is CONFIGURED and attached, no DRC info is sent in the migration
>>>> stream.  On the destination what seems to be happening is:
>>>>
>>>> 1. qemu is started with "-incoming defer", and cpu *not* present
>>>>
>>>>       DRC is uninitialized
>>>>
>>>> 2. qemu_system_reset() is called in vl.c
>>>>
>>>>       DRC is in UNALLOCATED / detached state
>>>>
>>>> 3. libvirt device_adds the cpu
>>>>
>>>>       DRC is in UNALLOCATED / attached state
>>>>
>>>> 4. libvirt initiates incoming migration
>>>>
>>>>       DRC remains in UNALLOCATED / attached state
>>>>
>>>> 5. Guest resumes on the destination
>>>>
>>>>       DRC still in UNALLOCATED / attached state
>>>>
>>>> Which mismatches what we had on the source so => bug.
>>>>
>>>> BUT, AFAIK the libvirt coldplug case below *is* working.  Which
>>>> tracing through the code I'd expect:
>>>>
>>>> 1. qemu is started with -S and cpu not present
>>>>
>>>>      DRC is uninitialized
>>>>
>>>> 2. qemu_system_reset() is called in vl.c
>>>>
>>>>      DRC is in UNALLOCATED / detached state
>>>>
>>>> 3. libvirt device_adds in prelaunch phase
>>>>
>>>>      DRC is in UNALLOCATED / attached state
>>>>
>>>> 4. Guest is started
>>>>
>>>>      DRC is in UNALLOCATED / attached state
>>>>
>>>> Which is also incorrect: the device was present when the guest
>>>> started, so it should be in CONFIGURED state.  IIUC this case is
>>>> working, so I think it is must actually be in CONFIGURED state.
>>> Just did a test here and the device isn't present when the guest starts in
>>> the second
>>> example you mentioned,  Tested with current qemu master. QEMU shows the
>>> extra
>>> CPU as 'halted' always, even after the guest starts and OS boots up:
>>>
>>> danielhb@louis:~/qemu/build/ppc64-softmmu$ sudo ./qemu-system-ppc64 -name
>>> migrate_qemu -boot strict=on --enable-kvm -device
>>> nec-usb-xhci,id=usb,bus=pci.0,addr=0xf -device
>>> spapr-vscsi,id=scsi0,reg=0x2000 -smp 1,maxcpus=4,sockets=4,cores=1,threads=1
>>> --machine pseries,accel=kvm,usb=off,dump-guest-core=off -m
>>> 4G,slots=32,maxmem=32G -drive file=/home/danielhb/vm_imgs/ubuntu1704.qcow2,format=qcow2,if=none,id=drive-virtio-disk0,cache=none
>>> -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x2,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1
>>> -nographic -S
>>> QEMU 2.9.50 monitor - type 'help' for more information
>>>
>>> <<<<< at this point qemu_system_reset is called, as expected >>>>>
>>>
>>> (qemu) device_add host-spapr-cpu-core,id=core1,core-id=1
>>> (qemu) info cpus
>>> * CPU #0: nip=0x0000000000000100 thread_id=16523
>>>    CPU #1: nip=0x0000000000000000 (halted) thread_id=16598
>>> (qemu) cont
>>>
>>> --- guest boots up ----
>>>
>>> (qemu) info cpus
>>> * CPU #0: nip=0xc0000000000a3e0c thread_id=16523
>>>    CPU #1: nip=0x0000000000000000 (halted) thread_id=16598
>>>
>>> danielhb@ubuntu1704:~$ lscpu
>>> Architecture:          ppc64le
>>> Byte Order:            Little Endian
>>> CPU(s):                1
>>> On-line CPU(s) list:   0
>>> Thread(s) per core:    1
>>> Core(s) per socket:    1
>>> Socket(s):             1
>>> NUMA node(s):          1
>>> Model:                 2.1 (pvr 004b 0201)
>>> Model name:            POWER8E (raw), altivec supported
>>> Hypervisor vendor:     horizontal
>>> Virtualization type:   full
>>> L1d cache:             64K
>>> L1i cache:             32K
>>> NUMA node0 CPU(s):     0
>>> danielhb@ubuntu1704:~$ (qemu)
>>> (qemu) device_del core1
>>> (qemu) info cpus
>>> * CPU #0: nip=0xc0000000000a3e0c thread_id=16523
>>>    CPU #1: nip=0x0000000000000000 (halted) thread_id=16598
>>>
>>> danielhb@ubuntu1704:~$ lscpu
>>> Architecture:          ppc64le
>>> Byte Order:            Little Endian
>>> CPU(s):                1
>>> On-line CPU(s) list:   0
>>> Thread(s) per core:    1
>>> Core(s) per socket:    1
>>> Socket(s):             1
>>> NUMA node(s):          1
>>> Model:                 2.1 (pvr 004b 0201)
>>> Model name:            POWER8E (raw), altivec supported
>>> Hypervisor vendor:     horizontal
>>> Virtualization type:   full
>>> L1d cache:             64K
>>> L1i cache:             32K
>>> NUMA node0 CPU(s):     0
>>> danielhb@ubuntu1704:~$ dmesg | tail -n 5
>>> [    6.307988] audit: type=1400 audit(1499705034.060:10): apparmor="STATUS"
>>> operation="profile_load" profile="unconfined" name="/usr/bin/lxc-start"
>>> pid=2212 comm="apparmor_parser"
>>> [    6.318556] audit: type=1400 audit(1499705034.068:11): apparmor="STATUS"
>>> operation="profile_load" profile="unconfined"
>>> name="/usr/lib/snapd/snap-confine" pid=2213 comm="apparmor_parser"
>>> [    7.087170] cgroup: new mount options do not match the existing
>>> superblock, will be ignored
>>> [   88.093598] pseries-hotplug-cpu: Failed to acquire DRC, rc: -22, drc
>>> index: 10000008
>>> [   88.093606] pseries-hotplug-cpu: Cannot find CPU (drc index 10000008) to
>>> remove
>>> danielhb@ubuntu1704:~$
>>>
>>>
>>> Debugging it a little I see that device_adding a CPU while the VM isn't
>>> started yet is being considered
>>> "hotplugged" by spapr_core_plug (dev->hotplugged is True). Also, there is a
>>> note in 'spapr_cpu_reset'
>>> saying:
>>>
>>>      /* All CPUs start halted.  CPU0 is unhalted from the machine level
>>>       * reset code and the rest are explicitly started up by the guest
>>>       * using an RTAS call */
>>>      cs->halted = 1;
>>>
>>> And yeah, the guest isn't calling 'start-cpu' and the CPU remains halted.
>>> When comparing to
>>> a scenario where I start the VM with 2 cpus in the command line, the first
>>> one is started by the
>>> machine reset and the other one by the RTAS call 'start-cpu', as expected
>>> I'll investigate why this
>>> is happening - starting with 2 coldplugged CPUs versus one coldplugged CPU
>>> and a second one
>>> attached with device_add with while on -S should yield the same outcome.
>>>
>>>
>>> All this said, I am not sure if this behavior has the same root cause as the
>>> migration problem
>>> this patch solves with the reset on pre_load though. Hopefully I'll know
>>> more in these next days.
>> Ah! So it's broken for the prelaunch case as well, though in a
>> slightly different way.  Actually for me the breakage is less obvious
>> - if I plug the cpu at prelaunch, I *do* get 2 cpus appearing in the
>> running system.  But tracing through, that's because the hotplug
>> message was queued and gets processed during boot.  That gets to the
>> right place in the end, but it's kind of silly going through the
>> hotplug logic.
>>
>> I thought there was a system reset after the prelaunch phase, but I
>> was mistaken.
>>
>> I can see two ways to address this:
>>    1) add in a DRC reset before starting up the machine, for both the
>>       prelaunch and inmigrate cases.  Your draft patch does the second,
>>       but I don't see an obvious place to put a hook for the first
>>
>>    2) Change the plug (and unplug) paths to skip the notification and
>>       gradual state change, and just immediately jump to the completed
>>       state when called in the prelaunch or inmigrate. (Easiest way
>>       would be just to call the drc reset function instead of queueing
>>       an event).
>>
>> (2) is basically the approach Laurent proposed in a patch a little
>> while ago, defining an spapr_hotplugged() function that always
>> returned false in prelaunch or inmigrate states.
>>
>> At the time I was dubious about that approach, because I thought we
>> had a natural reset point after that.  After more careful
>> investigation, I think that's not the case however, so I'm inclined to
>> go with approach (2), polish up Laurent's patch and apply that.
>
> Uh.. wait, realised this approach is wrong for the non-migration
> case.  For the hotplug-during-prelaunch, it's not sufficient to just
> reset the DRCs.  For the device to be truly coldplugged - with the DRC
> going straight to CONFIGURED state, it must also appear in the base
> device tree, and that requires a full system reset.  Well... or CAS,
> which complicates matters again.

I was looking into this code yesterday and wondered why aren't we 
putting the
pre-launch hotplugged CPU in the base DT. I guess that's the reason then.

>
> Ok, now I'm torn between options (1) and (2) again - we basically have
> a patch for each approach (yours for 1, and Laurent's for 2).
>

In theory we can find a good enough place to reset all the DRCs if the 
machine is
started with -S (and only in this case preferably). I am not sure how we 
can solve
the DT problem that goes with option (2).
