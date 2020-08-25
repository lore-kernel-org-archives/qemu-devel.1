Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A09EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D90420786
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UmrxwhJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D90420786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaDC-0004PC-Ea
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1kAaCZ-0003qr-Jl; Tue, 25 Aug 2020 10:45:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33032
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1kAaCX-0007mY-2l; Tue, 25 Aug 2020 10:45:31 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07PEVmMv037185; Tue, 25 Aug 2020 10:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=reply-to : subject : to
 : cc : references : from : message-id : date : mime-version : in-reply-to
 : content-type : content-transfer-encoding; s=pp1;
 bh=NZFx2nyBHJBaurVAiPKC9DFUP/zPSDe62Gk5caZIyfI=;
 b=UmrxwhJThM9GGQdv9+Kx3mr8ZmRhk7wYTvLiBJW8XtkjrUgRpV0xa4jm+YMDtFpou/5k
 /ywTwUKq98F+dNCse981qszczqfZJva7GOntyX2C1lAf1okXEzpQYHZnD+h27jaSL23R
 2hPeA9B3acupEar7G6XWcSMSESKNj4R839gzr1S5w9jQt1VBP4qMLDlLGnjvkl6D+xB7
 Kd0MC5wbpzOgCgdJ5Itne4fh9UShfu+8K5hTkfmkrUUpYsmckumML6x0OZU+jGzLr6uN
 g67R4t8ci80nELbSwAIIsT3VCv0D0BOuSgOHSdiMe/euYgKTHlDxtmGTaD4HmEa/ciLU Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3353trt5qv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2020 10:45:25 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07PEW1nl038364;
 Tue, 25 Aug 2020 10:45:25 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3353trt5qh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2020 10:45:25 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07PEj1DK028290;
 Tue, 25 Aug 2020 14:45:24 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma05wdc.us.ibm.com with ESMTP id 332uw7a3mr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2020 14:45:24 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07PEjIvW65864094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2020 14:45:18 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E5E0C66DB;
 Tue, 25 Aug 2020 14:45:23 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8F90C66D8;
 Tue, 25 Aug 2020 14:45:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.204.105])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 25 Aug 2020 14:45:22 +0000 (GMT)
Subject: Re: [PATCH] pc-bios: s390x: Only set lowcore iplb address on
 list-directed IPL
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20200817141734.5109-1-jjherne@linux.ibm.com>
 <20200817183048.30cb6f9e.cohuck@redhat.com>
 <f232a187-c989-cf77-52e5-2e31678e5bed@linux.ibm.com>
 <173257e9-a6cb-48a5-62ed-794c060e3900@linux.ibm.com>
 <20200819114538.7485d580.cohuck@redhat.com>
 <81d2ca24-538a-56ba-04de-079d28a16cb3@linux.ibm.com>
 <133e6840-d10a-0d8d-b555-dcbe40c554f8@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Organization: IBM
Message-ID: <bbaba98a-6f5c-cafd-2744-20526ad7568b@linux.ibm.com>
Date: Tue, 25 Aug 2020 10:45:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <133e6840-d10a-0d8d-b555-dcbe40c554f8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-25_04:2020-08-25,
 2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250107
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 07:40:49
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: jjherne@linux.ibm.com
Cc: qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 7:38 AM, Thomas Huth wrote:
> On 19/08/2020 12.46, Janosch Frank wrote:
>> On 8/19/20 11:45 AM, Cornelia Huck wrote:
>>> On Wed, 19 Aug 2020 11:32:34 +0200
>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>
>>>> On 8/17/20 7:51 PM, Jason J. Herne wrote:
>>>>> On 8/17/20 12:30 PM, Cornelia Huck wrote:
>>>>>> On Mon, 17 Aug 2020 10:17:34 -0400
>>>>>> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
>>>>>>   
>>>>>>> The POP states that the IPLB location is only written to 0x14 for
>>>>>>> list-directed IPL. Some operating systems expect 0x14 to not change on
>>>>>>> boot and will fail IPL if it does change.
>>>>>>>
>>>>>>> Fixes: 9bfc04f9ef6802fff0
>>>>>>
>>>>>> Should be
>>>>>>
>>>>>> Fixes: 9bfc04f9ef68 ("pc-bios: s390x: Save iplb location in lowcore")
>>>>>>   
>>>>>>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>>>>>>> Reviewed-by: Janosch Frank <frankja@de.ibm.com>
>>>>>>> ---
>>>>>>>    pc-bios/s390-ccw/jump2ipl.c | 5 ++++-
>>>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
>>>>>>> index 767012bf0c..5e3e13f4b0 100644
>>>>>>> --- a/pc-bios/s390-ccw/jump2ipl.c
>>>>>>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>>>>>>> @@ -33,7 +33,10 @@ void jump_to_IPL_code(uint64_t address)
>>>>>>>    {
>>>>>>>        /* store the subsystem information _after_ the bootmap was loaded */
>>>>>>>        write_subsystem_identification();
>>>>>>> -    write_iplb_location();
>>>>>>> +
>>>>>>> +    if (iplb.pbt != S390_IPL_TYPE_CCW) {
>>>>>>> +            write_iplb_location();
>>>>>>> +    }
>>>>>>
>>>>>> What happens for ipl types other than CCW and FCP? IOW, should that
>>>>>> rather be a positive check for S390_IPL_TYPE_FCP?
>>>>>>   
>>>>>>>    
>>>>>>>        /* prevent unknown IPL types in the guest */
>>>>>>>        if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
>>>>>>   
>>>>>
>>>>> Based on my (admittedly limited) understanding of the architecture and
>>>>> code, I believe write_iplb_location() should be called at least for
>>>>> S390_IPL_TYPE_FCP but I'm not 100% sure on S390_IPL_TYPE_QEMU_SCSI.
>>>>> Perhaps Janosch has an idea?
>>>>>
>>>>> It was originally unconditional, and my new conditional excludes vfio
>>>>> CCW which is definitely a step in the right direction, in any case :).
>>>>
>>>> If I remember correctly the problem was that ZIPL used the IPLB lowcore
>>>> ptr without checking how it was booted (CCW or FCP). That was fixed in
>>>> mid of July by testing if diag308 gives back a config or not.
>>>
>>> So we have the problem that old zipl relies on the presence of a value
>>> that must not be there if you follow the architecture? Nasty.
>>>
>>> (Is it really "must not change" vs "don't expect anything here"? Not
>>> sure if I'm looking at the right part of the documentation.)
>>
>> Well if the loaded program overwrites absolute 0x0, we shouldn't modify
>> it if we are not explicitly allowed to, no?
>>
>> We already talked about saving the exception new addresses and restoring
>> them before jumping to the new kernel. I think we might need to go a
>> step further and use a non zero prefix for the bios to avoid any changes
>> to absolute 0x0.
>>
>> However that wouldn't fix this dilemma.
> 
> Sorry, I'm just back from summer vacation ... so what's the conclusion
> for Jason's patch here? Should it be included as-is now or do we rather
> neeed another rework here instead?
> 
>   Thomas
> 

After some discussion we've decided to keep this internal for now. As it turns out, 
Janosch plans on making some changes here that will remove the need for this fix. So we'll 
just use it internally for our own testing purposes until that time.

Sorry for the noise :)

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)

