Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F7AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A5C2063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s9sY4lG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A5C2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7jIe-0007uE-MM
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 13:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1k7jHz-0007SE-QS; Mon, 17 Aug 2020 13:51:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1k7jHx-00087H-R8; Mon, 17 Aug 2020 13:51:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07HHY7Nd102511; Mon, 17 Aug 2020 13:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=reply-to : subject : to
 : cc : references : from : message-id : date : mime-version : in-reply-to
 : content-type : content-transfer-encoding; s=pp1;
 bh=bC7EjNMuEc6YnGhgMMKwHqvCZQd81H8FwubaRz/wGe0=;
 b=s9sY4lG9TefTUg0GrLPZIxJE3l0lL1Y5vjx4m3ofwTJy26GO1M+/bzoUggTZtlQ3WmaV
 V4DxUArGuGZjgjQ1J7KTFMz4FSXmdUTot8tpPQJgFUWRg581C6d7MG/hM9Xd+jdcn/uB
 Ln1zGN57+g3CR442ZX96T+XGBDyOrnDJ19ajIhFijyVAsBLwEKp//rWggWb1BrEily2C
 wPoMqJrmHWFJvUrQ4nComSDD/IIl3njN8NHbLVaedbzrN5ttR3B8L1mKJ21JmZ29gRCd
 Qpq4HjHo8AoKVXiFeeAFx4JdjVvRKN/tnQ1/HCFyMyW5phSF74kX9sva1wz9tWacnpy+ Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32ywg1j5c5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2020 13:51:15 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07HHZFFl106851;
 Mon, 17 Aug 2020 13:51:15 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32ywg1j5bs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2020 13:51:15 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07HHnDRC032461;
 Mon, 17 Aug 2020 17:51:14 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma04dal.us.ibm.com with ESMTP id 32x7b9yfca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2020 17:51:14 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07HHpDwx54329602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2020 17:51:13 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9781A28058;
 Mon, 17 Aug 2020 17:51:13 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 709D32805E;
 Mon, 17 Aug 2020 17:51:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.160.29])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2020 17:51:13 +0000 (GMT)
Subject: Re: [PATCH] pc-bios: s390x: Only set lowcore iplb address on
 list-directed IPL
To: Cornelia Huck <cohuck@redhat.com>
References: <20200817141734.5109-1-jjherne@linux.ibm.com>
 <20200817183048.30cb6f9e.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Organization: IBM
Message-ID: <f232a187-c989-cf77-52e5-2e31678e5bed@linux.ibm.com>
Date: Mon, 17 Aug 2020 13:51:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200817183048.30cb6f9e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-17_13:2020-08-17,
 2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170127
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 13:51:16
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 12:30 PM, Cornelia Huck wrote:
> On Mon, 17 Aug 2020 10:17:34 -0400
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> The POP states that the IPLB location is only written to 0x14 for
>> list-directed IPL. Some operating systems expect 0x14 to not change on
>> boot and will fail IPL if it does change.
>>
>> Fixes: 9bfc04f9ef6802fff0
> 
> Should be
> 
> Fixes: 9bfc04f9ef68 ("pc-bios: s390x: Save iplb location in lowcore")
> 
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Reviewed-by: Janosch Frank <frankja@de.ibm.com>
>> ---
>>   pc-bios/s390-ccw/jump2ipl.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
>> index 767012bf0c..5e3e13f4b0 100644
>> --- a/pc-bios/s390-ccw/jump2ipl.c
>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>> @@ -33,7 +33,10 @@ void jump_to_IPL_code(uint64_t address)
>>   {
>>       /* store the subsystem information _after_ the bootmap was loaded */
>>       write_subsystem_identification();
>> -    write_iplb_location();
>> +
>> +    if (iplb.pbt != S390_IPL_TYPE_CCW) {
>> +            write_iplb_location();
>> +    }
> 
> What happens for ipl types other than CCW and FCP? IOW, should that
> rather be a positive check for S390_IPL_TYPE_FCP?
> 
>>   
>>       /* prevent unknown IPL types in the guest */
>>       if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
> 

Based on my (admittedly limited) understanding of the architecture and
code, I believe write_iplb_location() should be called at least for
S390_IPL_TYPE_FCP but I'm not 100% sure on S390_IPL_TYPE_QEMU_SCSI.
Perhaps Janosch has an idea?

It was originally unconditional, and my new conditional excludes vfio
CCW which is definitely a step in the right direction, in any case :).


-- 
-- Jason J. Herne (jjherne@linux.ibm.com)

