Received: from eggs.gnu.org ([2001:4830:134:3::10]:33444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dxAur-00082G-Rt
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dxAun-00037L-Co
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:54:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1dxAun-00036V-3x
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:54:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8RBrEac127395
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 07:54:04 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d88eea4dd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 07:54:03 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Wed, 27 Sep 2017 05:54:03 -0600
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
	<150287474187.9760.12052550430995757993.stgit@aravinda>
	<20170817013934.GC5509@umbus.fritz.box>
	<555e187e-38af-d897-85b7-f08364b264fd@linux.vnet.ibm.com>
	<20170822020854.GY12356@umbus.fritz.box>
	<98ef38a4-9c09-adec-6f0c-b280e5349d64@linux.vnet.ibm.com>
	<20170927071508.GP12504@umbus>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Wed, 27 Sep 2017 17:23:51 +0530
MIME-Version: 1.0
In-Reply-To: <20170927071508.GP12504@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <bcc42ba6-6c71-d8d0-a196-7588a4d4a0d2@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com



On Wednesday 27 September 2017 12:45 PM, David Gibson wrote:
> On Thu, Sep 21, 2017 at 02:39:06PM +0530, Aravinda Prasad wrote:
>>
>>
>> On Tuesday 22 August 2017 07:38 AM, David Gibson wrote:
>>
>> [ . . . ]
>>
>>>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>>>>> index 46012b3..eee8d33 100644
>>>>>> --- a/include/hw/ppc/spapr.h
>>>>>> +++ b/include/hw/ppc/spapr.h
>>>>>> @@ -123,6 +123,12 @@ struct sPAPRMachineState {
>>>>>>       * occurs during the unplug process. */
>>>>>>      QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
>>>>>>  
>>>>>> +    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls */
>>>>>> +    target_ulong guest_machine_check_addr;
>>>>>> +    bool mc_in_progress;
>>>>>> +    int mc_cpu;
>>>>>
>>>>> mc_cpu isn't actually used yet in this patch.  In any case it and
>>>>> mc_in_progress could probably be folded together, no?
>>>>
>>>> It is possible to fold mc_cpu and mc_in_progress together with the
>>>> convention that if it is set to -1 mc is not in progress otherwise it is
>>>> set to the CPU handling the mc.
>>>>
>>>>>
>>>>> These values will also need to be migrated, AFAICT.
>>>>
>>>> I am thinking of how to handle the migration when machine check handling
>>>> is in progress. Probably wait for machine check handling to complete
>>>> before migrating as the error could be irrelevant once migrated to a new
>>>> hardware. If that is the case we don't need to migrate these values.
>>>
>>> Ok.
>>
>> This is what I think about handling machine check during migration based
>> on my understanding of the VM migration code.
>>
>> There are two possibilities here. First, migration can be initiated
>> while the machine check handling is in progress. Second, A machine check
>> error can happen when the migration is in progress.
>>
>> To handle the first case we can add migrate_add_blocker() call when we
>> start handling the machine check error and issue migrate_del_blocker()
>> when done. I think this should solve the issue.
>>
>> The second case is bit tricky. The migration has already started and
>> hence migrate_add_blocker() call will fail. We also cannot wait till the
>> completion of the migration to handle machine check error as the VM's
>> data could be corrupt.
>>
>> Machine check errors should not be an issue when the migration is in the
>> RAM copy phase as VM is still active with vCPUs running. The problem is
>> when we hit a machine check when the migration is about to complete. For
>> example,
>>
>> 1. vCPU2 hits a machine check error during migration.
>>
>> 2. KVM causes VM exit on vCPU2 and the NIP of vCPU2 is changed to the
>> guest registered machine check handler.
>>
>> 3. The migration_completion() issues vm_stop() and hence either vCPU2 is
>> never scheduled again on the source hardware or vCPU2 is preempted while
>> executing the machine check handler.
>>
>> 4. vCPU2 is resumed on the target hardware and either starts or
>> continues processing the machine check error. This could be a problem as
>> these errors are specific to the source hardware. For instance, when the
>> the guest issues memory poisoning upon such error, a clean page on the
>> target hardware is poisoned while the corrupt page on source hardware is
>> not poisoned.
>>
>> The second case of hitting machine check during the final phase of
>> migration is rare but wanted to check what others think about it.
> 
> So, I've had a bit of a think about this.  I don't recall if these
> fwnmi machine checks are expected on guest RAM, or guest IO addresses.

It is expected on guest RAM. I am not sure about guest IO address.

> 
> 1) If RAM
> 
>   What exactly is the guest's notification for?  Even without
>   migration, the host's free to move guest memory around in host
>   memory, so it seems any hardware level poking should be done on the
>   host side.

If the error is a correctable error, then host takes care of it by
moving the page to a different location, the guest need not be and will
not be notified. Guest will be notified if host is not able to fully
recover. Hence we hit FWNMI in guest when RAM errors are not recovered
by the host.

> 
>   Is it just to notify the guest that we weren't able to fully recover
>   on the host side and that page may contain corrupted data?  If
>   that's so then it seems resuming the handling on the destination is
>   still right.  It may be new good RAM, but the contents we migrated
>   could still be corrupt from the machine check event on the source.

Yes. This is what I am doing in my v5 patch set which I am about to
post. Additionally I block migration when processing machine check errors.

> 
> 2) If IO
> 
>   AFAICT this could only happen with VFIO passthrough devices.. but it
>   shouldn't be possible to migrate if there are any of those.
> 

I am not very sure about IO errors.

Regards,
Aravinda

> Or have I missed something..
> 

-- 
Regards,
Aravinda
