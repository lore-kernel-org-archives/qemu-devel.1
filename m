Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D374C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D374620786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D374620786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJ3G-0005hO-1B
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJJ27-0004La-Mc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jJJ25-0003MZ-PG
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:42:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jJJ25-0003Lr-Eq
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:42:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02VFXEt4012743
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 11:42:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3022qyamn4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 11:42:28 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Tue, 31 Mar 2020 16:42:12 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 31 Mar 2020 16:42:09 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02VFgLYs50135254
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2020 15:42:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68E0F52050;
 Tue, 31 Mar 2020 15:42:21 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.66.74])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7779E5204E;
 Tue, 31 Mar 2020 15:42:20 +0000 (GMT)
Subject: Re: [PATCH v1] s390x: Reject unaligned RAM sizes
To: David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20200327152930.66636-1-david@redhat.com>
 <64cefab8-f1e0-fbc7-27d3-4f28758c595a@de.ibm.com>
 <d8fb50c1-639a-826c-0dce-e2ddc26ae5e1@redhat.com>
 <24681aa0-9053-238f-89da-8ce08d34241d@de.ibm.com>
 <20200327174620.06b9c324@redhat.com>
 <4c5e56fd-a5e2-efe0-9a1a-99acb91aaf71@redhat.com>
 <20200327231303.30d76ddf@redhat.com>
 <9ba133fd-603e-a8e1-7a3c-2c05c8653c15@de.ibm.com>
 <20200331173358.2b195178@redhat.com>
 <7961ef4f-9bbc-8ac5-f4ff-b4acbd896c99@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date: Tue, 31 Mar 2020 17:42:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7961ef4f-9bbc-8ac5-f4ff-b4acbd896c99@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20033115-0016-0000-0000-000002FBBC4F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033115-0017-0000-0000-0000335F7C4A
Message-Id: <4b707594-5e73-5710-caba-a24a11185406@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-31_05:2020-03-31,
 2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310141
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 31.03.20 17:39, David Hildenbrand wrote:
> On 31.03.20 17:33, Igor Mammedov wrote:
>> On Tue, 31 Mar 2020 13:17:38 +0200
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> On 27.03.20 23:13, Igor Mammedov wrote:
>>>> On Fri, 27 Mar 2020 17:53:39 +0100
>>>> David Hildenbrand <david@redhat.com> wrote:
>>>>   
>>>>> On 27.03.20 17:46, Igor Mammedov wrote:  
>>>>>> On Fri, 27 Mar 2020 17:05:34 +0100
>>>>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>>>>     
>>>>>>> On 27.03.20 17:01, David Hildenbrand wrote:    
>>>>>>>> On 27.03.20 16:34, Christian Borntraeger wrote:      
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 27.03.20 16:29, David Hildenbrand wrote:      
>>>>>>>>>> Historically, we fixed up the RAM size (rounded it down), to fit into
>>>>>>>>>> storage increments. Since commit 3a12fc61af5c ("390x/s390-virtio-ccw: use
>>>>>>>>>> memdev for RAM"), we no longer consider the fixed-up size when
>>>>>>>>>> allcoating the RAM block - which will break migration.
>>>>>>>>>>
>>>>>>>>>> Let's simply drop that manual fixup code and let the user supply sane
>>>>>>>>>> RAM sizes. This will bail out early when trying to migrate (and make
>>>>>>>>>> an existing guest with e.g., 12345 MB non-migratable), but maybe we
>>>>>>>>>> should have rejected such RAM sizes right from the beginning.
>>>>>>>>>>
>>>>>>>>>> As we no longer fixup maxram_size as well, make other users use ram_size
>>>>>>>>>> instead. Keep using maxram_size when setting the maximum ram size in KVM,
>>>>>>>>>> as that will come in handy in the future when supporting memory hotplug
>>>>>>>>>> (in contrast, storage keys and storage attributes for hotplugged memory
>>>>>>>>>>  will have to be migrated per RAM block in the future).
>>>>>>>>>>
>>>>>>>>>> This fixes (or rather rejects early):
>>>>>>>>>>
>>>>>>>>>> 1. Migrating older QEMU to upstream QEMU (e.g., with "-m 1235M"), as the
>>>>>>>>>>    RAM block size changed.      
>>>>>>>>>
>>>>>>>>> Not sure I like this variant. Instead of breaking migration (that was 
>>>>>>>>> accidentially done by Igors changes) we now reject migration from older
>>>>>>>>> QEMUs to 5.0. This is not going to help those that still have such guests
>>>>>>>>> running and want to migrate.       
>>>>>>>>
>>>>>>>> As Igor mentioned on another channel, you most probably can migrate an
>>>>>>>> older guest by starting it on the target with a fixed-up size.
>>>>>>>>
>>>>>>>> E.g., migrate an old QEMU "-m 1235M" to a new QEMU "-m 1234M"      
>>>>>>>
>>>>>>> Yes, that should probably work.    
>>>>>> I'm in process of testing it.  
>>>>
>>>> it works
>>>>   
>>>>>>     
>>>>>>>> Not sure how many such weird-size VMs we actually do have in practice.      
>>>>>>>
>>>>>>> I am worried about some automated deployments where tooling has created
>>>>>>> these sizes for dozens or hundreds of containers in VMS and so.    
>>>>>
>>>>> IIRC, e.g., Kata usually uses 2048MB. Not sure about others, but I'd be
>>>>> surprised if it's not multiples of, say, 128MB.
>>>>>  
>>>>>> Yep, it's possible but then that tooling/configs should be fixed to work with
>>>>>> new QEMU that validates user's input.
>>>>>>     
>>>>>
>>>>> Yeah, and mention it in the cover letter, +eventually a "fixup" table
>>>>> (e.g., old_size < X, has to be aligned to Y).
>>>>>
>>>>> One alternative is to have an early fixup hack in QEMU, that fixes up
>>>>> the sizes as we did before (and eventually warns the user). Not sure if
>>>>> we really want/need that.  
>>>> That would require at least a callback at machine level, 
>>>> also practice shows warnings are of no use.  
>>>
>>> I would strongly prefer to not break setups that used to work and do an early fixup
>>> (a machine callback). I will have a look.
>>
>> If it were breaking migration stream or guest ABI,
>> I'd agree with you but it isn't.
>>
>> So in this case, it's a bug that qemu wasn't checking
>> size for alignment and making workaround to keep the bug
>> around looks wrong to me.
>> It is fixable on user side (one has to fix VM's config),
>> so it should be fixed there and not in QEMU.
>> And any automatic tooling that generates invalid size
>> should be fixed as well. 
>> (I think it's not QEMU's job to mask users errors and
>> doing something that user not asked for)
> 
> Dave G mentioned, that e.g., via Cockpit it can be fairly easy to
> produce weird RAM sizes (via a slider). So I guess this "issue" could be
> more widespread than I initially thought.
> 
> I agree that it's a BUG that we didn't bail out but instead decided to
> fix it up.

It was a decision back than. Likely a wrong one.
Now insisting on "lets breaking user setups because it violates my feeling
of perfection" is not the right answer though.



