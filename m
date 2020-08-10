Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343E2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F082020782
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EmaxQA9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F082020782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5D4x-00019L-5q
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1k5D4L-0000ik-Od
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:02:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19270
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1k5D4J-00082O-05
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:02:49 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07AJ09df174888; Mon, 10 Aug 2020 15:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mK/zIp3Kg+HIuB9vvZmwLys1s+zR3s/XZV7hmPB+zes=;
 b=EmaxQA9KwYkEQc8XRo5Qzhnp9YG/dfZchi3hE94HhU7OkbtPZXXHthBAwmDVS7DCKeVU
 LnT+eVcM13k5RVsGXg3T3pybhlhbmi0KiUdpp0QqALsWAlnveF52PXgJOk9qVrHzglZr
 xOUD7yQghtps4EQ2uJfqHHZW+MqvKvvp45O8HPSWaFf9Qhwv7z10dSwEPQGSKgMVsek2
 qrzDxNlj5x5hRa6g4iQ88hIrOif/uC0136YsIHlRAIruyxtQGwaebZLvD60o4uBc7gwT
 fn436yyS1+3+n0UaBEjm+rWu++dB3zvXzwz+746juCAWx0Es8EV/8tP+8OHIaD6/pCj5 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32sr7uww7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2020 15:01:42 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07AJ0IOF176017;
 Mon, 10 Aug 2020 15:01:42 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32sr7uww6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2020 15:01:42 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07AIk8Fc022667;
 Mon, 10 Aug 2020 19:01:40 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma01dal.us.ibm.com with ESMTP id 32skp90mhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2020 19:01:40 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07AJ1daA51904780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Aug 2020 19:01:39 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77D176A04D;
 Mon, 10 Aug 2020 19:01:39 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB1AD6A057;
 Mon, 10 Aug 2020 19:01:38 +0000 (GMT)
Received: from [9.160.0.152] (unknown [9.160.0.152])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 10 Aug 2020 19:01:38 +0000 (GMT)
Subject: Re: [PATCH 2/2] configure: add support for Control-Flow Integrity
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200702054948.10257-1-dbuono@linux.vnet.ibm.com>
 <20200702054948.10257-3-dbuono@linux.vnet.ibm.com>
 <20200702095252.GF1888119@redhat.com>
 <0ed44c55-1f5d-6866-9555-82134ef628fb@linux.vnet.ibm.com>
 <c81befdd-979c-6060-c0a3-15ea1b142d25@redhat.com>
 <20200702133830.f3mlqli2bxtvk2z4@mozz.bu.edu>
 <f3cf9017-3da5-d6d4-f463-3864ab1f43c6@linux.vnet.ibm.com>
Message-ID: <b2fc75ef-f6ae-d776-bead-4e6e6de10207@linux.vnet.ibm.com>
Date: Mon, 10 Aug 2020 15:01:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f3cf9017-3da5-d6d4-f463-3864ab1f43c6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-10_15:2020-08-06,
 2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100126
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 15:01:43
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex, Paolo
Hitting a small issue while adding support for lto (and therefore cfi) 
to the fuzzer.

The fuzzer requires a modified linker script to place all of the stuff 
that needs to persist across fuzzing runs into a contiguous section of 
memory.

It does that by inserting three new sections after the .data section of 
the binary. Instead of rewriting a full linker script, it's using the 
*INSERT* keyword to add this to the default linker script.

Now, LTO with LLVM requires to use the gold linker, which does not have 
a default linker script and therefore does not support the *INSERT* keyword.
This can be fixed by taking the default script from the bdf linker, 
adding the additional sections and ask gold to use the full script.

However, I don't like the idea of replacing the small, self-contained 
script snippet that is currently used, with a full script (which is 
probably also dependent on the bfd/os version). So I'm thinking of 
adding a check in configure. If gold is the linker, automatically create 
(somehow, still working on it) the full link script by obtaining the 
default bfd script and add the required parts. Would that work for you?

Cheers,
Daniele

On 7/2/2020 11:43 AM, Daniele Buono wrote:
> Hey Alex!
> 
> I agree, in most cases (possibly all of them), a wrong indirect function 
> call will end up with something that is catched by ASan or UBSan.
> This way, however, you may catch it earlier and it may make debug easier 
> (especially with --enable-cfi-debug which is printing an error with the 
> calling and, most times, the called function).
> 
> UBSan does have a similar feature, -fsanitize=function, but 
> unfortunately it works only on C++ code, and therefore is not good in 
> the QEMU case.
> 
> And, of course, it will also be used to weed out missing functions in 
> the CFI filter.
> 
> On 7/2/2020 9:38 AM, Alexander Bulekov wrote:
>> Can't wait to try this out!
>>
>> On 200702 1459, Paolo Bonzini wrote:
>>> On 02/07/20 14:50, Daniele Buono wrote:
>>>> I also wonder if this is something that could be put in the fuzzing
>>>> environment. It would probably also help in finding coding error in
>>>> corner cases quicker.
>>>
>>> Yes, fuzzing and tests/docker/test-debug should enable CFI.  Also,
>>> tests/docker/test-clang should enable LTO.
>>>
>>> Paolo
>>
>> I believe CFI is most-useful as an active defensive measure. I can't
>> think of many cases where a fuzzer/test could raise a CFI alert that
>> wouldn't also be caught by something like canaries, ASan or UBsan,
>> though maybe I'm missing something. Maybe testing/fuzzing with CFI could
>> be useful to weed out any errors due to e.g. an incomplete
>> cfi-blacklist.txt
>>
>> -Alex
>>
> 

