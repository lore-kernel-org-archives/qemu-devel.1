Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FCFC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FB0217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FB0217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itw3R-0003qE-Jv
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjrosato@linux.ibm.com>) id 1itw2V-0003Gy-Bx
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjrosato@linux.ibm.com>) id 1itw2T-0001av-Ud
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:06:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjrosato@linux.ibm.com>)
 id 1itw2T-0001Yi-O4; Tue, 21 Jan 2020 11:06:01 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00LFqESr125946; Tue, 21 Jan 2020 11:06:00 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xkwq81bsr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jan 2020 11:05:52 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00LFqLpO126669;
 Tue, 21 Jan 2020 11:05:42 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xkwq81beb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jan 2020 11:05:40 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00LG2kJF029789;
 Tue, 21 Jan 2020 16:05:20 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma01wdc.us.ibm.com with ESMTP id 2xksn6cwky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jan 2020 16:05:20 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00LG5Jpo38797640
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2020 16:05:19 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B145C6471;
 Tue, 21 Jan 2020 16:05:19 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADD8EC646B;
 Tue, 21 Jan 2020 16:05:18 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.85.144.147])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 21 Jan 2020 16:05:18 +0000 (GMT)
Subject: Re: [PATCH v3] target/s390x/kvm: Enable adapter interruption
 suppression again
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20200120132441.11884-1-thuth@redhat.com>
 <20200120182747.5135fea8.cohuck@redhat.com>
 <95fa3c7d-8879-1401-6847-c5fa82a0cd3c@linux.ibm.com>
 <20200121154608.0b043233.cohuck@redhat.com>
 <6eceafc9-afb5-05a7-0713-2295886f6917@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <91bed750-8b12-4f9a-ff57-57fd23fc11ca@linux.ibm.com>
Date: Tue, 21 Jan 2020 11:05:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <6eceafc9-afb5-05a7-0713-2295886f6917@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-21_04:2020-01-21,
 2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210127
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 10:22 AM, Thomas Huth wrote:
> On 21/01/2020 15.46, Cornelia Huck wrote:
>> On Tue, 21 Jan 2020 09:33:02 -0500
>> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
>>
>>> On 1/20/20 12:27 PM, Cornelia Huck wrote:
>>>> On Mon, 20 Jan 2020 14:24:41 +0100
>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>    
>>>>> The AIS feature has been disabled late in the v2.10 development cycle since
>>>>> there were some issues with migration (see commit 3f2d07b3b01ea61126b -
>>>>> "s390x/ais: for 2.10 stable: disable ais facility"). We originally wanted
>>>>> to enable it again for newer machine types, but apparently we forgot to do
>>>>> this so far. Let's do it for the new s390-ccw-virtio-5.0 machine now.
>>>>>
>>>>> While at it, also add a more verbose comment why we need the *_allowed()
>>>>> wrappers in s390-virtio-ccw.c.
>>>>>
>>>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
>>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>    v3: Moved "s390mc->kvm_ais_allowed = false" to the end of the function
>>>>>
>>>>>    hw/s390x/s390-virtio-ccw.c         | 20 +++++++++++++++++---
>>>>>    include/hw/s390x/s390-virtio-ccw.h |  3 +++
>>>>>    target/s390x/kvm.c                 |  9 ++++++---
>>>>>    3 files changed, 26 insertions(+), 6 deletions(-)
>>>>    
>>>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>>>> index 15260aeb9a..cf4fb4f2d9 100644
>>>>> --- a/target/s390x/kvm.c
>>>>> +++ b/target/s390x/kvm.c
>>>>> @@ -365,10 +365,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>>>>        /*
>>>>>         * The migration interface for ais was introduced with kernel 4.13
>>>>>         * but the capability itself had been active since 4.12. As migration
>>>>> -     * support is considered necessary let's disable ais in the 2.10
>>>>> -     * machine.
>>>>> +     * support is considered necessary, we only try to enable this for
>>>>> +     * newer machine types if KVM_CAP_S390_AIS_MIGRATION is available.
>>>>>         */
>>>>> -    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
>>>>> +    if (kvm_ais_allowed() &&
>>>>> +        kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
>>>>
>>>> Hnm, we actually need a kernel irqchip with the kvm flic to get ais to
>>>> work; else we'll fail with
>>>>
>>>> qemu-system-s390x: Failed to inject airq with AIS supported
>>>>
>>>> in the kernel_irqchip=off case, as we won't have an I/O adapter
>>>> registered.
>>>>
>>>> Adding 'kvm_kernel_irqchip_required() &&' seems to do the trick;
>>>> comments?
>>>>    
>>>
>>> In spirit, I agree with this idea.  But, a quick test shows that putting
>>> this check here results in ais=off for the 'none' machine case (libvirt
>>> capabilities detection).  I think we have to only look at
>>> kvm_kernel_irqchip_required() when working with a real machine.
>>
>> Sigh, I think you're right again. We need to check for the 'none'
>> machine here; but I can't think of a non-ugly way to do so...
> 
> I think it might work when using kvm_kernel_irqchip_allowed() instead of
> kvm_kernel_irqchip_required() ... Matthew, could you please give it a
> try with this patch on top of mine:
> 

Sure.

Libvirt detection works with this patch.

Alternatively, if I run qemu with kernel_irqchip=off and ais=true, I get:
qemu-system-s390x: Some features requested in the CPU model are not 
available in the configuration: ais

Which was the same result as Connie's proposal.

It reads a bit odd to me at first, but looking at the code quick I think 
this is the right answer - kvm_kernel_irqchip_allowed() will only return 
false when kernel_irqchip has been forced off as above, whereas 
kernel_irqchip_required will also return false in the case where no 
setting was specified (this is what tripped libvirt up).

Looks good to me, thanks Thomas.

