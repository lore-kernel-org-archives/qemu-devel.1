Received: from eggs.gnu.org ([2001:4830:134:3::10]:46919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d8u5l-0002MN-Dw
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d8u5i-0006NO-6s
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:49:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45057
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d8u5h-0006N0-VW
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:49:38 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4BJn3hT115447
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 15:49:36 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2acrqh05p4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 15:49:35 -0400
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 11 May 2017 16:49:34 -0300
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
	<f1b6a40d-3094-2896-6e50-699243813526@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 11 May 2017 16:48:58 -0300
MIME-Version: 1.0
In-Reply-To: <f1b6a40d-3094-2896-6e50-699243813526@redhat.com>
Content-Language: en-US
Message-Id: <a95f97a9-37df-f7ba-657e-6a35de892ba6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v9 0/6] migration/ppc: migrating
 DRC, ccs_list and pending_events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, david@gibson.dropbear.id.au

Hi Laurent,

To easily reproduce the error scenario:

1 - start QEMU in both source and target host with the same devices 
(target qemu
with the extra --incoming to accept the migration)

2 - in both QEMU instances add one or more cpus with device add:

device_add host-spapr-cpu-core,id=core1,core-id=1

3 - execute the migration

4 - after the migration is completed try to detach the cpu(s) you added 
in the target QEMU:

device_del core1

There will be no errors thrown in the QEMU console but you'll notice in the
VM that the cpus will still be there. dmesg will show something like this:

[  +0.482307] cgroup: new mount options do not match the existing 
superblock, will be ignored
[Apr19 14:47] random: crng init done
[Apr19 14:51] pseries-hotplug-cpu: CPU with drc index 10000008 already 
exists
[  +0.020319] cpu 1 (hwid 8) Ready to die...
[  +0.020550] pseries-hotplug-cpu: Failed to release drc (10000008) for 
CPU <NULL>, rc: -1
[Apr19 14:56] cpu 1 (hwid 8) Ready to die...
[  +0.014549] pseries-hotplug-cpu: Failed to release drc (10000008) for 
CPU <NULL>, rc: -1


The bug was originally reproduced using virsh:

# virsh setvcpus avocado-vt-vm1-migration 64 --live

# virsh -c 'qemu:///system' migrate --live --domain 
avocado-vt-vm1-migration --desturi qemu+ssh://<target_ip>/system 
--timeout 60

# virsh -c 'qemu+ssh://<target_ip>/system' setvcpus 
avocado-vt-vm1-migration 8 --live
error: operation failed: vcpu unplug request timed out


This happens because virsh is hot plugging the CPUs in both source and 
target
QEMUs and then migrating the VM, instead of starting the target QEMU 
with the
extra CPUs. When trying to hot unplug the CPUs after the migration, it 
fails because
these hot plugged CPUs at the target didn't pass the DRC state changes that
happened in the source.

This patch series aims to solve this scenario by migrating the relevant 
DRC states
to allow for proper device removal after a migration.


You can see more info in this launchpad bug:

https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1677552


Thanks,


Daniel


On 05/11/2017 03:38 PM, Laurent Vivier wrote:
> Hi Daniel,
>
> I'd like to test your patch series: is there a way to generate easily
> the problem your series wants to fix?
>
> Thanks,
> Laurent
>
> On 05/05/2017 22:47, Daniel Henrique Barboza wrote:
>> v9:
>> - patch 1 (*new*): added a qtail in sPAPRMachineState called pending_dimm_unplugs
>> that stores the DIMM LMB state during the unplug process.
>> - patch 2 (*new*): merged v8-patch1 and v8-patch2: removing detach_cb and
>> detach_cb_opaque.
>> - patch 3:
>>      * removed dk->vmsd entry. We're using vmstate_register instead
>>      * added 'awaiting_allocation' flag in the DRC migration
>> - patch 4 (*new*): migrating spapr->pending_dimm_unplugs qtailq to allow
>> for an ongoing PCDIMM unplug to continue after a migration.
>>
>> v8:
>> - new patch added: 'removing spapr_drc_detach_cb opaques'. This new patch removes
>> the need for the detach_cb_opaques inside the removal callback functions. See
>> the commit message of the patch for more info.
>>
>> v7:
>> - removed the first patch. DRC registration is now done by vmstate_register
>> in patch 2.
>> - added a new patch that changes spapr_dr_connector_new to receive as argument
>> the detach_cb.
>> - removed the callback logic of patch 2 since there is no need to restore the
>> detach_cb on post-load due to the detach_cb on spapr_dr_connector_new change.
>> - added word separators in the VMSD names of patch 3 and 4.
>>
>> v6: - Rebased with QEMU master after 6+ months.
>>      - Simplified the logic in patch 1.
>>      - Reworked patch 2: added CPU DRC migration, removed a function pointer from DRC
>> class and minor improvements.
>>      - Added clarifications from the previous v5 discussions in the commit messages.
>>
>> v5: - Rebased to David's ppc-for-2.8.
>>
>> v4: - Introduce a way to set customized instance_id in SaveStateEntry. Use it
>>        to set instance_id for DRC using its unique index to address David
>>        Gibson's concern.
>>      - Rename VMS_CSTM to VMS_LINKED based on Paolo Bonzini's suggestions.
>>      - Clean up qjson stuff in put_qtailq.
>>      - Add trace for put_qtailq and get_qtailq based on David Gilbert's
>>        suggestion.
>>
>>      - Based on David's ppc-for-2.7.
>>
>> v3: - Simplify overall design followng discussion with Paolo. No longer need
>>        metadata to migrate QTAILQ.
>>      - Extend VMStateInfo instead of adding similar fields to VMStateField.
>>      - Clean up macros in qemu/queue.h.
>> (link: https://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg05695.html)
>>
>> v2: - Introduce a general approach to migrate QTAILQ in qemu/queue.h.
>>      - Migrate signalled field in the DRC state.
>>      - Put the newly added migrating fields in subsections so that backward
>>        migration is not broken.
>>      - Set detach_cb field right after migration so that a migrated hot-unplug
>>        event could finish its course.
>> (link: https://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg04188.html)
>>
>> v1: - Inital version.
>> (link: https://lists.nongnu.org/archive/html/qemu-devel/2016-04/msg02601.html)
>>
>>
>> To make guest devices (PCI, CPU and memory) hotplug work together
>> with guest migration, spapr drc state needs be transmitted in
>> migration. This patch defines the VMStateDescription struct for
>> spapr drc state to enable it.
>>
>> To fix the potential racing between hotplug events on guest and
>> guest migration, ccs_list and pending_events of spapr state need be
>> transmitted in migration. This patch set also takes care of it.
>>
>>
>>
>> Daniel Henrique Barboza (4):
>>    hw/ppc/spapr.c: adding pending_dimm_unplugs to sPAPRMachineState
>>    hw/ppc: removing drc->detach_cb and drc->detach_cb_opaque
>>    hw/ppc: migrating the DRC state of hotplugged devices
>>    hw/ppc/spapr.c: migrate pending_dimm_unplugs of spapr state
>>
>> Jianjun Duan (2):
>>    migration: spapr: migrate ccs_list in spapr state
>>    migration: spapr: migrate pending_events of spapr state
>>
>>   hw/ppc/spapr.c              | 158 +++++++++++++++++++++++++++++++++++++++++---
>>   hw/ppc/spapr_drc.c          |  97 ++++++++++++++++++++++-----
>>   hw/ppc/spapr_events.c       |  24 ++++---
>>   hw/ppc/spapr_pci.c          |   5 +-
>>   include/hw/pci-host/spapr.h |   3 +
>>   include/hw/ppc/spapr.h      |  24 ++++++-
>>   include/hw/ppc/spapr_drc.h  |   8 +--
>>   7 files changed, 273 insertions(+), 46 deletions(-)
>>
>
>
