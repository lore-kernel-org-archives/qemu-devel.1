Received: from eggs.gnu.org ([2001:4830:134:3::10]:49844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dSsFX-0007Y3-Hv
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dSsFU-0004tu-Si
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:54:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dSsFU-0004tX-IM
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:54:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v65LsEsx006456
	for <qemu-devel@nongnu.org>; Wed, 5 Jul 2017 17:54:14 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bgtyfv3aw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 17:54:08 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 5 Jul 2017 18:54:05 -0300
References: <20170621091848.28256-1-david@gibson.dropbear.id.au>
	<f89c6897-9555-100a-7252-a705fcbc8ee6@linux.vnet.ibm.com>
	<20170705110414.GN2180@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 5 Jul 2017 18:53:57 -0300
MIME-Version: 1.0
In-Reply-To: <20170705110414.GN2180@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <0e4deabe-58e9-6c15-5910-cda9f8e63f9b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/5] spapr: DRC cleanups (part
 VI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mdroth@linux.vnet.ibm.com, lvivier@redhat.com, sursingh@redhat.com, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com



On 07/05/2017 08:04 AM, David Gibson wrote:
> On Tue, Jul 04, 2017 at 06:13:31PM -0300, Daniel Henrique Barboza wrote:
>> I just tested this patch set on top of current ppc-for-2.10 branch (which
>> contains
>> the patches from part V). It applied cleanly but required a couple of
>> trivial
>> fixes to build probably because it was made on top of an older code base.
> Right, I fixed that up locally already, but haven't gotten around to
> reposting yet.  You can look at the 'drcVI' branch on my github tree,
> if you're interested.
>
>> The trivial migration test worked fine. The libvirt scenario (attaching a
>> device on
>> target before migration, try to unplug after migration) isn't working as
>> expected
>> but we have a different result with this series. Instead of silently failing
>> to unplug
>> with error messages on dmesg, the hot unplug works on QEMU level:
> Thanks for testing.  Just to clarify what you're saying here, you
> haven't spotted a regression with this series, but there is a case
> which was broken and is still broken with slightly different
> symptoms.  Yes?
In my opinion, yes. It is debatable if the patch series made it worse 
because
the guest is now misbehaving, but the feature per se wasn't working
prior to it.

>
>> (qemu) device_del core1
>> (qemu)
>> (qemu) info cpus
>> * CPU #0: nip=0xc0000000000a3e0c thread_id=86162
>> (qemu) info hotpluggable-cpus
>> Hotpluggable CPUs:
>>    type: "host-spapr-cpu-core"
>>    vcpus_count: "1"
>>    CPUInstance Properties:
>>      core-id: "3"
>>    type: "host-spapr-cpu-core"
>>    vcpus_count: "1"
>>    CPUInstance Properties:
>>      core-id: "2"
>>    type: "host-spapr-cpu-core"
>>    vcpus_count: "1"
>>    CPUInstance Properties:
>>      core-id: "1"
>>    type: "host-spapr-cpu-core"
>>    vcpus_count: "1"
>>    qom_path: "/machine/unattached/device[0]"
>>    CPUInstance Properties:
>>      core-id: "0"
>> (qemu)
>>
>>
>> However, any operation on the guest afterwards (tried with lscpu and dmesg)
>> seems
>> to hung the guest. This is what I got when trying to do a dmesg after the
>> hot unplug:
> Ouch.  That's bad.  I'll have to look into it.
>
> I have rather a lot on my plate at the moment - if you get a chance to
> work out which of the patches in the series causes this behaviour,
> that could be handy.

***long post warning***

With the current master and current HEAD of ppc-for-2.10, the behavior in
the Libvirt scenario (device_add in both source and target before migration,
hot unplug after migration is completed) is that QEMU fails to hot 
unplug the
CPU from the guest OS. lscpu reports the same # of cpus even after 
device_del,
dmesg shows an error like this:

[  108.182291] pseries-hotplug-cpu: CPU with drc index 10000008 already 
exists


WIth this patch series, QEMU removes the CPU but the guest misbehaves 
like I said
in my previous message.

With the current HEAD of drcVI branch, I rolled back until I found the 
patch that was
causing this new symptom. The patch is the very first of the series:

b752844 spapr: Remove 'awaiting_allocation' DRC flag

In short, adding this single patch into the HEAD of ppc-for-2.10 is 
causing this new
behavior I saw in my tests. This is the retrieved kernel log after the 
failed unplug:

[  176.434099] random: crng init done
[  461.182729] pseries-hotplug-cpu: CPU with drc index 10000008 already 
exists
[  604.707369] INFO: task kworker/0:2:920 blocked for more than 120 seconds.
[  604.707666]       Not tainted 4.10.0-26-generic #30-Ubuntu
[  604.707881] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  604.708194] kworker/0:2     D    0   920      2 0x00000800
[  604.708248] Workqueue: events vmstat_shepherd
[  604.708251] Call Trace:
[  604.708265] [c0000000055a7830] [c000000001492090] 
sysctl_sched_migration_cost+0x0/0x4 (unreliable)
[  604.708271] [c0000000055a7a00] [c00000000001b770] __switch_to+0x2c0/0x450
[  604.708286] [c0000000055a7a60] [c000000000b51238] __schedule+0x2f8/0x990
[  604.708289] [c0000000055a7b40] [c000000000b51918] schedule+0x48/0xc0
[  604.708292] [c0000000055a7b70] [c000000000b51e40] 
schedule_preempt_disabled+0x20/0x30
[  604.708295] [c0000000055a7b90] [c000000000b54598] 
__mutex_lock_slowpath+0x208/0x380
[  604.708310] [c0000000055a7c10] [c0000000000e2ec8] 
get_online_cpus+0x58/0xa0
[  604.708312] [c0000000055a7c40] [c0000000002a5a18] 
vmstat_shepherd+0x38/0x160
[  604.708316] [c0000000055a7c90] [c0000000001061a0] 
process_one_work+0x2b0/0x5a0
[  604.708319] [c0000000055a7d20] [c000000000106538] 
worker_thread+0xa8/0x650
[  604.708322] [c0000000055a7dc0] [c00000000010f0a4] kthread+0x164/0x1b0
[  604.708326] [c0000000055a7e30] [c00000000000b4e8] 
ret_from_kernel_thread+0x5c/0x74
[  604.708341] INFO: task kworker/u8:0:3068 blocked for more than 120 
seconds.
[  604.708601]       Not tainted 4.10.0-26-generic #30-Ubuntu
[  604.708809] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  604.709107] kworker/u8:0    D    0  3068      2 0x00000800
[  604.709114] Workqueue: pseries hotplug workque pseries_hp_work_fn
[  604.709116] Call Trace:
[  604.709118] [c00000000589b3c0] [000fffffffffffff] 0xfffffffffffff 
(unreliable)
[  604.709122] [c00000000589b590] [c00000000001b770] __switch_to+0x2c0/0x450
[  604.709125] [c00000000589b5f0] [c000000000b51238] __schedule+0x2f8/0x990
[  604.709128] [c00000000589b6d0] [c000000000b51918] schedule+0x48/0xc0
[  604.709131] [c00000000589b700] [c000000000b566b4] 
schedule_timeout+0x274/0x470
[  604.709134] [c00000000589b7f0] [c000000000b528ec] 
wait_for_common+0xec/0x250
[  604.709137] [c00000000589b870] [c0000000000e3320] 
cpuhp_kick_ap_work+0x90/0x210
[  604.709140] [c00000000589b8d0] [c00000000026f57c] _cpu_down+0xdc/0x1b0
[  604.709143] [c00000000589b930] [c0000000000e44b4] do_cpu_down+0x64/0xb0
[  604.709157] [c00000000589b970] [c0000000007541b4] 
cpu_subsys_offline+0x24/0x40
[  604.709160] [c00000000589b990] [c00000000074bc04] 
device_offline+0xf4/0x130
[  604.709163] [c00000000589b9d0] [c0000000000ae4bc] 
dlpar_cpu_remove+0x24c/0x350
[  604.709166] [c00000000589bab0] [c0000000000ae6bc] 
dlpar_cpu_remove_by_index+0xfc/0x130
[  604.709169] [c00000000589bb40] [c0000000000af838] dlpar_cpu+0x78/0x540
[  604.709172] [c00000000589bbf0] [c0000000000a98a0] 
handle_dlpar_errorlog+0xf0/0x170
[  604.709174] [c00000000589bc60] [c0000000000a99b4] 
pseries_hp_work_fn+0x94/0xa0
[  604.709177] [c00000000589bc90] [c0000000001061a0] 
process_one_work+0x2b0/0x5a0
[  604.709180] [c00000000589bd20] [c000000000106538] 
worker_thread+0xa8/0x650
[  604.709183] [c00000000589bdc0] [c00000000010f0a4] kthread+0x164/0x1b0
[  604.709186] [c00000000589be30] [c00000000000b4e8] 
ret_from_kernel_thread+0x5c/0x74


Digging around in the kernel code reported in the trace and reading the 
commit message
of the patch that is causing it, my first guess is that there is some 
confusion left
in the DRC state management that, at this moment, is being fixed by the
'awaiting_allocation' flag. One potentially relevant use of this flag 
that was removed was this
piece of code:

(inside spapr_drc_detach)

-    if (drc->awaiting_allocation) {
-        drc->awaiting_release = true;
-        trace_spapr_drc_awaiting_allocation(spapr_drc_index(drc));
-        return;
-    }


Speculating a little, perhaps the guest is trying to release a DRC that 
isn't ready to be released
yet (inconsistent state probably) and this code was preventing it from 
doing so. I'll
know more when I dig further.


>
>> danielhb@ubuntu1704:~$
>> danielhb@ubuntu1704:~$
>> danielhb@ubuntu1704:~$ dmesg | tail -n 5
>> ^C
>>
>> [  362.749693] INFO: task kworker/u8:1:30 blocked for more than 120 seconds.
>> [  362.749819]       Not tainted 4.10.0-26-generic #30-Ubuntu
>> [  362.749892] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
>> this message.
>> [  362.750224] INFO: task kworker/0:3:1887 blocked for more than 120
>> seconds.
>> [  362.750320]       Not tainted 4.10.0-26-generic #30-Ubuntu
>> [  362.750394] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
>> this message.
>> [  483.568842] INFO: task kworker/u8:1:30 blocked for more than 120 seconds.
>> [  483.568997]       Not tainted 4.10.0-26-generic #30-Ubuntu
>> [  483.569067] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
>> this message.
>> [  483.569364] INFO: task kworker/0:3:1887 blocked for more than 120
>> seconds.
>> (...)
>>
>>
>> I am not sure if it was intended for this scenario to work with this patch
>> set already. Figured
>> it can serve as a FYI for the next series.
> This might be due to a problem I've discussed previously with
> Laurent.  libvirt uses device_add on the destination's monitor before
> sending the migration stream, rather than starting the destination
> with already-hotplugged devices as -device.
>
> To my surprise, there doesn't seem to be a system reset between that
> device_add phase and processing the incoming stream, which means DRCs
> for those devices might be in the wrong state.
>
> I might need to explicitly trigger a reset of DRC state at incoming
> migration time to handle this.

Worth a try. I'll see if I can make a POC of this DRC reset at incoming
migration time.


Daniel

>
>> Given that hotplug/unplug without migration still works and on the
>> assumption that
>> we'll look more into this libvirt scenario in the next spins, +1.
>>
>>
>> Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
>>
>>
>>
>> On 06/21/2017 06:18 AM, David Gibson wrote:
>>> This sixth set of DRC cleanup patches (to be applied on top of the
>>> patches from part V) is a complete rework of DRC state management.  We
>>> stop tracking some unnecessary things, and change the basic state
>>> representation to a simpler and more robust model.
>>>
>>> Most of the patches in this set "break" migration from earlier git
>>> snapshots, but not from any released qemu version.  The previous
>>> migration stream format had multiple problems, so better to fix them
>>> now, before 2.10 is out.
>>>
>>> David Gibson (5):
>>>     spapr: Remove 'awaiting_allocation' DRC flag
>>>     spapr: Refactor spapr_drc_detach()
>>>     spapr: Cleanups relating to DRC awaiting_release field
>>>     spapr: Consolidate DRC state variables
>>>     spapr: Remove sPAPRConfigureConnectorState sub-structure
>>>
>>>    hw/ppc/spapr.c             |   9 +-
>>>    hw/ppc/spapr_drc.c         | 321 +++++++++++++++++++++------------------------
>>>    hw/ppc/spapr_pci.c         |  13 +-
>>>    hw/ppc/trace-events        |   3 +-
>>>    include/hw/ppc/spapr_drc.h |  53 +++++---
>>>    5 files changed, 187 insertions(+), 212 deletions(-)
>>>
