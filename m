Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3E4C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 12:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023F02225F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 12:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KnhkAWgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023F02225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWIDe-00026j-20
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 08:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kWICR-0001AH-SX
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 07:59:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38784
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kWICP-0004i1-92
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 07:59:07 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09OBWFI5030444; Sat, 24 Oct 2020 07:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SrHFH0SvFjh+xCKzcgPGVMymFkTR2WlGotvsXXlG9L8=;
 b=KnhkAWgywD59Jeg/kGDCA+1OgJvHA4sTouE3SRgXhgGFtyzDC8nqL1jtXpSHFLhVRiOx
 1EyIzbHfRa7DM9qbU4kODCk0CzChEGezIv9G6dyEIthlgcMKr7na/j/WenleIsj3p6tm
 AkWnHAQnZf2sIid6slw9AdkxEASDelmF84n4W+28eIjCw/8+P/Zre+4+4J6R60nfRoKn
 2kB7QxsOx7qXE59d8dYXF5qCuOcbiIJJMARpXnwj81ow8gMpuaLv1n3za4wB1SgfFOA3
 j5UQ2eSirDLMCyKBUuNfxYvB5/vzhL8zqyhOkGCJsXLbrXOJFaICr3Ty6IpiYB/cJT9Q Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34cjvw8w63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Oct 2020 07:59:03 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09OBg8Gh051281;
 Sat, 24 Oct 2020 07:59:02 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34cjvw8w61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Oct 2020 07:59:02 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09OBwCSv006949;
 Sat, 24 Oct 2020 11:59:02 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma03dal.us.ibm.com with ESMTP id 34cbw8audj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Oct 2020 11:59:02 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09OBx0Av49742096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 24 Oct 2020 11:59:00 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAFB66A047;
 Sat, 24 Oct 2020 11:59:00 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 150756A04D;
 Sat, 24 Oct 2020 11:58:59 +0000 (GMT)
Received: from [9.160.36.16] (unknown [9.160.36.16])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 24 Oct 2020 11:58:59 +0000 (GMT)
Subject: Re: [PATCH v2 0/6] Add support for Control-Flow Integrity
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <947e698f-a582-956d-5b42-1dee6442f15d@redhat.com>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <ca8020e4-53ac-9713-51d1-d80ca75a22e2@linux.vnet.ibm.com>
Date: Sat, 24 Oct 2020 07:58:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <947e698f-a582-956d-5b42-1dee6442f15d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-24_09:2020-10-23,
 2020-10-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010240082
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 07:59:04
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/2020 4:33 PM, Eric Blake wrote:
> On 10/23/20 3:06 PM, Daniele Buono wrote:
>> v2: Several months (and structural changes in QEMU) have passed since v1.
>> While the spirit of the patch is similar, the implementation is changed
>> in multiple points, and should address most if not all the comments
>> received in v1.
> 
>> 5) Most of the logic to enable CFI goes in the configure, since it's
>> just a matter of checking for dependencies and incompatible options.
>> However, I had to disable CFI checks for a few TCG functions.
>> This can only be done through a blacklist file. I added a file in the
>> root of QEMU, called cfi-blacklist.txt for such purpose. I am open to
>> suggestions on where the file should go, and I am willing to become the
>> maintainer of it, if deemed necessary.
> 
> In the meantime, we have commits like:
> 
> commit b199c682f1f0aaee22b2170a5fb885250057eec2
> Author: Philippe Mathieu-Daudé <philmd@redhat.com>
> Date:   Thu Sep 10 09:01:31 2020 +0200
> 
>      target/i386/kvm: Rename host_tsx_blacklisted() as host_tsx_broken()
> 
>      In order to use inclusive terminology, rename host_tsx_blacklisted()
>      as host_tsx_broken().
> 
> which may help you in coming up with a more appropriate name for the new
> file.
> 
>>
>>   MAINTAINERS                   |   5 +
>>   accel/tcg/cpu-exec.c          |   9 ++
>>   configure                     | 214 ++++++++++++++++++++++++++++++++++
>>   include/qemu/sanitizers.h     |  22 ++++
>>   meson.build                   |   3 +
>>   plugins/core.c                |  25 ++++
>>   plugins/loader.c              |   5 +
>>   tcg/tci.c                     |   5 +
>>   tests/check-block.sh          |  18 +--
>>   tests/qtest/fuzz/fork_fuzz.ld |  12 +-
>>   util/main-loop.c              |   9 ++
>>   util/oslib-posix.c            |   9 ++
>>   12 files changed, 328 insertions(+), 8 deletions(-)
>>   create mode 100644 include/qemu/sanitizers.h
> 
> although I don't see a new file by that name here, so perhaps the v1
> overview is now stale?
> 
Correct, the v1 overview is stale on that regard. V2 is not using a
"broken" file anymore. CFI is now disabled by using an attribute
directly on the code.

 From the v2 overview:
* Instead of disabling CFI in specific functions by using a filter file,
   disable cfi by using a new decorator to be prefixed to the function
   definition.

Beside the removal of a non-inclusive term, I believe this is a better
way to track functions, since it is directly inside the code so everyone
working on those functions will see it immediately. It's safer with
regards of function naming changes and, hopefully, this will make
maintaining cfi easier.

