Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4531C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FDC20829
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GGehs10D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FDC20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHiAt-0007LO-Aj
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 02:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kHiAH-0006vM-49; Mon, 14 Sep 2020 02:40:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kHiAD-00067A-T2; Mon, 14 Sep 2020 02:40:36 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08E6XVhE062025; Mon, 14 Sep 2020 02:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GIy6mz3+A3PXzu4bhygSvTwWkrqPCtfiQOXJoTn4hxA=;
 b=GGehs10DDBVJnEGbpPYt2+2kJ76K/+gJ5GZ6yhiqFrgr3meJwL3QDtGt+v4/GHfR6C7K
 NqCI3YKzxM6q8zRgS/nSpPZP0jEChExG4E/+tNU3hUikMojvoNazr9s171fH0i3L3KjH
 rbPzkgH78nssMn+ZgiBbPK6ORDqjMcihDtFrylfhgJOS2nLpsfHEbazKq4ujo8cj3L86
 TKf7+QYbxOCJ/AUVh92Sob1DgKAZ6pXCdXdN7gc4dnNnOHxHi+rRUnV+0lsqTzmBWP/N
 SP4Wa6uFm9e6wFUWeMMrU9Y+dn8m2a+ocCH3FJfwFgVeAF25kV/tOOKguRLAeQawAxj8 /w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33hyapdg2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2020 02:40:30 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08E6XhVe062853;
 Mon, 14 Sep 2020 02:40:30 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33hyapdg03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2020 02:40:30 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08E6NvFx020744;
 Mon, 14 Sep 2020 06:40:27 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma02fra.de.ibm.com with ESMTP id 33gny8102m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2020 06:40:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 08E6ePXq15401302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2020 06:40:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5089E4204F;
 Mon, 14 Sep 2020 06:40:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D44EB42042;
 Mon, 14 Sep 2020 06:40:22 +0000 (GMT)
Received: from [9.65.222.171] (unknown [9.65.222.171])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2020 06:40:22 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] hw/timer/hpet: Fix DPRINTF format string
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200910135852.516809-1-philmd@redhat.com>
 <20200910135852.516809-3-philmd@redhat.com>
 <9db297fa-02c0-aadb-e0c7-555d3578b7b3@linux.vnet.ibm.com>
 <3dbac311-dc90-0eda-10c2-13ab28407a6a@redhat.com>
From: Dov Murik <dovmurik@linux.vnet.ibm.com>
Message-ID: <00747ce4-c714-cfca-464c-6999edfede3a@linux.vnet.ibm.com>
Date: Mon, 14 Sep 2020 09:40:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <3dbac311-dc90-0eda-10c2-13ab28407a6a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-13_09:2020-09-10,
 2020-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 clxscore=1011 spamscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140054
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dovmurik@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:01:13
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 13/09/2020 14:40, Philippe Mathieu-Daudé wrote:
> On 9/12/20 7:40 PM, Dov Murik wrote:
>> Hi Phil,
>>
>> On 10/09/2020 16:58, Philippe Mathieu-Daudé wrote:
>>> Fix building with HPET_DEBUG enabled:
>>>
>>>     hw/timer/hpet.c:512:73: error: format specifies type 'unsigned int'
>>> but the argument has type 'uint64_t' (aka 'unsigned long')
>>> [-Werror,-Wformat]
>>>         DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#x\n",
>>> addr, value);
>>>                                                              
>>> ~~~           ^~~~~
>>>                                                               %#lx
>>>     hw/timer/hpet.c:655:21: error: format specifies type 'unsigned int'
>>> but the argument has type 'uint64_t' (aka 'unsigned long')
>>> [-Werror,-Wformat]
>>>                         value, s->hpet_counter);
>>>                         ^~~~~
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>    hw/timer/hpet.c | 9 ++++++---
>>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
>>> index b683f64f1d3..20bd0388740 100644
>>> --- a/hw/timer/hpet.c
>>> +++ b/hw/timer/hpet.c
>>> @@ -495,7 +495,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>>>        HPETState *s = opaque;
>>>        uint64_t old_val, new_val, val, index;
>>>
>>> -    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#x\n",
>>> addr, value);
>>> +    DPRINTF("qemu: Enter hpet_ram_writel at %#" HWADDR_PRIx " =
>>> %#"PRIx64"\n",
>>> +            addr, value);
>>
>> You still use "#" in the format string; but qemu's CODING_STYLE.rst says:
>>
>> //////////////
>>
>> '#' printf flag
>> ---------------
>>
>> Do not use printf flag '#', like '%#x'.
>>
>> Rationale: there are two ways to add a '0x' prefix to printed number:
>> '0x%...'
>> and '%#...'. For consistency the only one way should be used. Arguments for
>> '0x%' are:
>>
>> * it is more popular
>> * '%#' omits the 0x for the value 0 which makes output inconsistent
> 
> Yes you are right, I missed that.
> 
> Do you mind adding that check to ./checkpatch?

Fix to checkpatch sent in another patch:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg740065.html

-Dov

