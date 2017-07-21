Received: from eggs.gnu.org ([2001:4830:134:3::10]:42596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dYW1e-0007iE-02
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dYW1Y-0002Hp-UQ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:23:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36163
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dYW1Y-0002HV-Of
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:23:12 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6LBJZMo009036
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 07:23:11 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bucu3h5g8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 07:23:11 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 21 Jul 2017 08:23:09 -0300
References: <1500612666-19521-1-git-send-email-bharata@linux.vnet.ibm.com>
	<20170721065736.GD3717@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 21 Jul 2017 08:23:02 -0300
MIME-Version: 1.0
In-Reply-To: <20170721065736.GD3717@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <6fc11647-997b-114c-e7ef-a8e9d72eb361@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [FIX PATCH v2] spapr: Fix QEMU abort
 during memory unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org



On 07/21/2017 03:57 AM, David Gibson wrote:
> On Fri, Jul 21, 2017 at 10:21:06AM +0530, Bharata B Rao wrote:
>> Commit 0cffce56 (hw/ppc/spapr.c: adding pending_dimm_unplugs to
>> sPAPRMachineState) introduced a new way to track pending LMBs of DIMM
>> device that is marked for removal. Since this commit we can hit the
>> assert in spapr_pending_dimm_unplugs_add() in the following situation:
>>
>> - DIMM device removal fails as the guest doesn't allow the removal.
>> - Subsequent attempt to remove the same DIMM would hit the assert
>>    as the corresponding sPAPRDIMMState is still part of the
>>    pending_dimm_unplugs list.
>>
>> Fix this by removing the assert and conditionally adding the
>> sPAPRDIMMState to pending_dimm_unplugs list only when it is not
>> already present.
>>
>> Fixes: 0cffce56ae3501c5783d779f97993ce478acf856
>> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Applied to ppc-for-2.10.
>
>> ---
>> Changes in v2:
>> - sPAPRDIMMState is now allocated within spapr_pending_dimm_unplugs_add()
>>    itself (David Gibson)
>> - spapr_recover_pending_dimm_state() should never return a NULL sPAPRDIMMState,
>>    added an assert for the same.
>>
>>   hw/ppc/spapr.c | 37 +++++++++++++++++++++----------------
>>   1 file changed, 21 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 1cb09e7..2465b27 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2850,11 +2850,25 @@ static sPAPRDIMMState *spapr_pending_dimm_unplugs_find(sPAPRMachineState *s,
>>       return dimm_state;
>>   }
>>   
>> -static void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
>> -                                           sPAPRDIMMState *dimm_state)
>> +static sPAPRDIMMState *spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
>> +                                                      uint32_t nr_lmbs,
>> +                                                      PCDIMMDevice *dimm)
>>   {
>> -    g_assert(!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm));
>> -    QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
>> +    sPAPRDIMMState *ds = NULL;
>> +
>> +    /*
>> +     * If this request is for a DIMM whose removal had failed earlier
>> +     * (due to guest's refusal to remove the LMBs), we would have this
>> +     * dimm already in the pending_dimm_unplugs list. In that
>> +     * case don't add again.
>> +     */
>> +    if (!spapr_pending_dimm_unplugs_find(spapr, dimm)) {
>> +        ds = g_malloc0(sizeof(sPAPRDIMMState));
>> +        ds->nr_lmbs = nr_lmbs;
>> +        ds->dimm = dimm;
>> +        QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, ds, next);
>> +    }
>> +    return ds;
In case unplugs_find() founds a DIMM state (the condition this patch is 
trying to fix), ds is
returned as NULL. This is working because unplug_request() does not use 
the return value
of unplugs_add() and because recover() is only called if find() returns 
NULL. Still not
so pretty.

What makes sense here is something like:

     ds = spapr_pending_dimm_unplugs_find(spapr, dimm);
     if (!ds) {
         (...)
     }
     return ds;

I think this is not worth sending a v3, David can amend it in the tree. 
After amending feel
free to add my

Reviewed-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>




>>   }
>>   
>>   static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
>> @@ -2875,7 +2889,6 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
>>       uint32_t avail_lmbs = 0;
>>       uint64_t addr_start, addr;
>>       int i;
>> -    sPAPRDIMMState *ds;
>>   
>>       addr_start = object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP,
>>                                            &error_abort);
>> @@ -2891,11 +2904,7 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
>>           addr += SPAPR_MEMORY_BLOCK_SIZE;
>>       }
>>   
>> -    ds = g_malloc0(sizeof(sPAPRDIMMState));
>> -    ds->nr_lmbs = avail_lmbs;
>> -    ds->dimm = dimm;
>> -    spapr_pending_dimm_unplugs_add(ms, ds);
>> -    return ds;
>> +    return spapr_pending_dimm_unplugs_add(ms, avail_lmbs, dimm);
>>   }
>>   
>>   /* Callback to be called during DRC release. */
>> @@ -2911,6 +2920,7 @@ void spapr_lmb_release(DeviceState *dev)
>>        * during the unplug process. In this case recover it. */
>>       if (ds == NULL) {
>>           ds = spapr_recover_pending_dimm_state(spapr, PC_DIMM(dev));
>> +        g_assert(ds);
>>           /* The DRC being examined by the caller at least must be counted */
>>           g_assert(ds->nr_lmbs);
>>       }
>> @@ -2942,18 +2952,13 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
>>       uint64_t addr_start, addr;
>>       int i;
>>       sPAPRDRConnector *drc;
>> -    sPAPRDIMMState *ds;
>> -
>>       addr_start = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
>>                                            &local_err);
>>       if (local_err) {
>>           goto out;
>>       }
>>   
>> -    ds = g_malloc0(sizeof(sPAPRDIMMState));
>> -    ds->nr_lmbs = nr_lmbs;
>> -    ds->dimm = dimm;
>> -    spapr_pending_dimm_unplugs_add(spapr, ds);
>> +    spapr_pending_dimm_unplugs_add(spapr, nr_lmbs, dimm);
>>   
>>       addr = addr_start;
>>       for (i = 0; i < nr_lmbs; i++) {
