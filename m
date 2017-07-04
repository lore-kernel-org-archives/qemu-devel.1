Received: from eggs.gnu.org ([2001:4830:134:3::10]:59344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dSLVU-0005TN-5N
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 06:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dSLVR-0008CL-3m
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 06:56:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34286
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dSLVQ-0008Bx-TO
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 06:56:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v64Are4s136350
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 06:56:31 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bfjk5bm61-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 06:56:31 -0400
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 4 Jul 2017 07:56:29 -0300
References: <149909367669.21100.17690903693542179077.stgit@bahia.lan>
	<69bd5d32-3f59-b28a-38e8-25952fecee10@linux.vnet.ibm.com>
	<20170704094252.7dc1cac5@bahia.lan>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 4 Jul 2017 07:56:20 -0300
MIME-Version: 1.0
In-Reply-To: <20170704094252.7dc1cac5@bahia.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <2966d97d-67fc-824a-2ccb-679f764ef32d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr: fix memory hotplug
 error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>



On 07/04/2017 04:42 AM, Greg Kurz wrote:
> On Mon, 3 Jul 2017 14:03:07 -0300
> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> wrote:
>
>> On 07/03/2017 11:54 AM, Greg Kurz wrote:
>>> QEMU shouldn't abort if spapr_add_lmbs()->spapr_drc_attach() fails.
>>> Let's propagate the error instead, like it is done everywhere else
>>> where spapr_drc_attach() is called.
>>>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>> ---
>>> Changes in v2: - added rollback code
>>> ---
>>>    hw/ppc/spapr.c |   26 ++++++++++++++++++++++----
>>>    1 file changed, 22 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 70b3fd374e2b..ba8f57a5a054 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -2601,6 +2601,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>>>        int i, fdt_offset, fdt_size;
>>>        void *fdt;
>>>        uint64_t addr = addr_start;
>>> +    Error *local_err = NULL;
>>>
>>>        for (i = 0; i < nr_lmbs; i++) {
>>>            drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
>>> @@ -2611,7 +2612,18 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>>>            fdt_offset = spapr_populate_memory_node(fdt, node, addr,
>>>                                                    SPAPR_MEMORY_BLOCK_SIZE);
>>>
>>> -        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
>>> +        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
>>> +        if (local_err) {
>>> +            while (addr > addr_start) {
>>> +                addr -= SPAPR_MEMORY_BLOCK_SIZE;
>>> +                drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
>>> +                                      addr / SPAPR_MEMORY_BLOCK_SIZE);
>>> +                spapr_drc_detach(drc, dev, NULL);
>> Question: why pass NULL instead of '&local_err' in detach() ?
> local_err already contains the error returned by spapr_drc_attach(), it
> cannot be used anymore.
>
>> Can we ignore any
>> any error that happens in detach() because you're propagating the
>> local_err set
>> in spapr_drc_attach() already?
>>
> This is a rollback path: the best we can do is to try to undo the
> already attached DRCs...
>
>> ps: I am aware that ATM detach() does not propagate anything to the errp
>> being
>> passed. I don't think it's wise to write new code based on this
>> assumption though.
>>
> ... and indeed detach() cannot fail with the current code base. :)
>
> David was even planning to drop the errp argument in the "spapr:
> Refactor spapr_drc_detach()" patch.

Dropping it would be good. There are places in the code that are
passing non-null pointers tof the Errp parameter of detach().

>
> Otherwise, maybe pass &error_abort since failing to rollback is
> likely to be a bug ?

It would be saner for the reader but in reality it would be of no avail, 
given
this info that detach() will probably never make use of it. AFAIC you 
can leave
it as NULL. If you end up sending a v3 for other reasons then you can 
change it
for &error_abort in the process.


Reviewed-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>

>
> Cheers,
>
> --
> Greg
>
>> Thanks,
>>
>>
>> Daniel
>>
>>> +            }
>>> +            g_free(fdt);
>>> +            error_propagate(errp, local_err);
>>> +            return;
>>> +        }
>>>            addr += SPAPR_MEMORY_BLOCK_SIZE;
>>>        }
>>>        /* send hotplug notification to the
>>> @@ -2651,14 +2663,20 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>        addr = object_property_get_uint(OBJECT(dimm),
>>>                                        PC_DIMM_ADDR_PROP, &local_err);
>>>        if (local_err) {
>>> -        pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
>>> -        goto out;
>>> +        goto out_unplug;
>>>        }
>>>
>>>        spapr_add_lmbs(dev, addr, size, node,
>>>                       spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
>>> -                   &error_abort);
>>> +                   &local_err);
>>> +    if (local_err) {
>>> +        goto out_unplug;
>>> +    }
>>> +
>>> +    return;
>>>
>>> +out_unplug:
>>> +    pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
>>>    out:
>>>        error_propagate(errp, local_err);
>>>    }
>>>
>>>   
