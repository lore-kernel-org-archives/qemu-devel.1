Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE679C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 04:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0E02077B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 04:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0E02077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ietPW-0001Vy-P8
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 23:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sbhat@linux.ibm.com>) id 1ietOK-0000eX-Se
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 23:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1ietOJ-0008R4-AS
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 23:14:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1ietOJ-0008O2-16
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 23:14:23 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBB4BtbY035262
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 23:14:20 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wsm2f31sg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 23:14:19 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Wed, 11 Dec 2019 04:14:17 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 11 Dec 2019 04:14:14 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBB4EDSV8323128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2019 04:14:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FE61AE053;
 Wed, 11 Dec 2019 04:14:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1B45AE045;
 Wed, 11 Dec 2019 04:14:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.229])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 11 Dec 2019 04:14:11 +0000 (GMT)
Subject: Re: [PATCH v3 2/3] spapr: Add NVDIMM device support
To: David Gibson <david@gibson.dropbear.id.au>,
 Bharata B Rao <bharata.rao@gmail.com>
References: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
 <157107826404.27733.10134514695430511105.stgit@lep8c.aus.stglabs.ibm.com>
 <20191122043045.GD5582@umbus.fritz.box>
 <CAGZKiBo4bdTTbJ82YV92RtTqbhuj_-GRxt6GceWyPbWdr9LGFA@mail.gmail.com>
 <20191206015255.GL5031@umbus.fritz.box>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Date: Wed, 11 Dec 2019 09:44:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20191206015255.GL5031@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19121104-0012-0000-0000-00000373AE31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121104-0013-0000-0000-000021AF8323
Message-Id: <1c24857f-64d4-a14d-1b66-cae2113d53a2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_08:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 mlxscore=0 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110035
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com,
 Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/06/2019 07:22 AM, David Gibson wrote:
> On Wed, Nov 27, 2019 at 09:50:54AM +0530, Bharata B Rao wrote:
>> On Fri, Nov 22, 2019 at 10:42 AM David Gibson
>> <david@gibson.dropbear.id.au> wrote:
>>> Ok.  A number of queries about this.
>>>
>>> 1) The PAPR spec for ibm,dynamic-memory-v2 says that the first word in
>>> each entry is the number of LMBs, but for NVDIMMs you use the
>>> not-necessarily-equal scm_block_size instead.  Does the NVDIMM
>>> amendment for PAPR really specify to use different block sizes for
>>> these cases?  (In which case that's a really stupid spec decision, but
>>> that wouldn't surprise me at this point).
>> SCM block sizes can be different from LMB sizes, but here we enforce
>> that SCM device size (excluding metadata) to multiple of LMB size so
>> that we don't end up memory range that is not aligned to LMB size.
> Right, but it still doesn't make sense to use scm_block_size when you
> create the dynamic-memory-v2 property.

Right, I should use LMB size here as I will be creating holes here to 
disallow DIMMs
to claim those LMBs marking them INVALID as Bharata Suggested before.

>   As far as the thing
> interpreting that goes, it *must* be LMB size, not SCM block size.  If
> those are required to be the same at this point, you should use an
> assert().

SCM block size should be a multiple for LMB size, need not be equal. 
I'll add an assert
for that, checking if equal. There is no benefit I see as of now having 
higher
SCM block size as the bind/unbind are already done before the bind hcall.

>>> 2) Similarly, the ibm,dynamic-memory-v2 description says that the
>>> memory block described by the entry has a whole batch of contiguous
>>> DRCs starting at the DRC index given and continuing for #LMBs DRCs.
>>> For NVDIMMs it appears that you just have one DRC for the whole
>>> NVDIMM.  Is that right?
>> One NVDIMM has one DRC, In our case, we need to mark the LMBs
>> corresponding to that address range in ibm,dynamic-memory-v2 as
>> reserved and invalid.
> Ok, that fits very weirdly with the DRC allocation for the rest of
> pluggable memory, but I suppose that's PAPR for you.
>
> Having these in together is very inscrutable though, and relies on a
> heap of non-obvious constraints about placement of DIMMs and NVDIMMs
> relative to each other.  I really wonder if it would be better to have
> a completely different address range for the NVDIMMs.

The backend object for both DIMM and NVDIMM are memory-backend-*
and they use the address from the same space. Separating it would mean
using/introducing different backend object. I dont think we have a 
choice here.

>
>>> 3) You're not setting *any* extra flags on the entry.  How is the
>>> guest supposed to know which are NVDIMM entries and which are regular
>>> DIMM entries?  AFAICT in this version the NVDIMM slots are
>>> indistinguishable from the unassigned hotplug memory (which makes the
>>> difference in LMB and DRC numbering even more troubling).
>> For NVDIMM case, this patch should populate the LMB set in
>> ibm,dynamic-memory-v2 something like below:
>>              elem = spapr_get_drconf_cell(size /lmb_size, addr,
>>                                           0, -1,
>> SPAPR_LMB_FLAGS_RESERVED | SPAPR_LMB_FLAGS_DRC_INVALID);
>>
>> This will ensure that the NVDIMM range will never be considered as
>> valid memory range for memory hotplug.
> Hrm.  Ok so we already have code that does that for any gaps between
> DIMMs.  I don't think there's actually anything that that code will do
> differently than the code you have for NVDIMMs, so you could just skip
> over the NVDIMMs here and it should do the right thing.
>
> The *interpretation* of those entries will become different: for space
> into which a regular DIMM is later inserted, we'll assume the DRC
> index given is a base and there are more DRCs following it, but for
> NVDIMMs we'll assume the same DRC throughout.  This is nuts, but IIUC
> that's what PAPR says and we can't do much about it.

My current patch is buggy as Bharata pointed out. The NVDIMM DRCs
are not to be populated here, but mark the LMB DRCs as RESERVED and INVALID
so that no malicious attempts to online those LMBs at those NVDIMM address
ranges are attempted.

>
>>> 4) AFAICT these are _present_ NVDIMMs, so why is
>>> SPAPR_LMB_FLAGS_ASSIGNED not set for them?  (and why is the node
>>> forced to -1, regardless of di->node).
>>>
>>>>           QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
>>>>           nr_entries++;
>>>>           cur_addr = addr + size;
>>>> @@ -1261,6 +1273,85 @@ static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
>>>>       }
>>>>   }
>>>>
>>>> +static void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
>>>> +{
>>>> +    MachineState *machine = MACHINE(spapr);
>>>> +    int i;
>>>> +
>>>> +    for (i = 0; i < machine->ram_slots; i++) {
>>>> +        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i);
>>> What happens if you try to plug an NVDIMM to one of these slots, but a
>>> regular DIMM has already taken it?
>> NVDIMM hotplug won't get that occupied slot.
> Ok.
>


