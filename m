Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079B6C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 12:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7F8206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 12:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CcyJajJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7F8206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGM6r-0005fe-CX
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 08:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kGM5F-000568-O5
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 08:53:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kGM5D-0003UQ-Mk
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 08:53:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08ACliG5046329
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 08:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nNGRKF90hFzrz5Xe3Mu2NWqjfW5sHByxjUFYF+wf25U=;
 b=CcyJajJa6sngTjeujDzOKdFSoFF/it37LO3a7RVnk69YnI2YctQzjQtF9hodZ/nIgcI7
 pIl9UsICgbkdFmno4gZt2FcItM0B86NNjJlPXZE0/tO5F9QImew6KYiHMkHSjzusBpaE
 CI2kxkzn+CLKSVv4UlAT+GVsQJiptil/40n9gQKqm8iTE8V7axpgk6ML30pln3HI6+QI
 sf9MbQHXhgLcezEXz2Qxigb8+HifeBp3T03KxO3/InTY0LqlrPLiQYI/JeoUu8vc21il
 HUAjSLrRqenfLwOmTYt650OE1Zia7MjJnpWDKRFOT23bAkmdMscQ8H8fsM8IYE3d2Lj5 +w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fm2ts9jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 08:53:44 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08AClnIJ046864
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 08:53:44 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fm2ts9hy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 08:53:44 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08ACqtki009043;
 Thu, 10 Sep 2020 12:53:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma03ams.nl.ibm.com with ESMTP id 33c2a861s7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 12:53:42 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08ACreJ036700470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2020 12:53:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 785D2A4059;
 Thu, 10 Sep 2020 12:53:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80CF8A4040;
 Thu, 10 Sep 2020 12:53:38 +0000 (GMT)
Received: from [9.65.222.171] (unknown [9.65.222.171])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 10 Sep 2020 12:53:38 +0000 (GMT)
Subject: Re: [PATCH 0/2] hw/timer/hpet: Fix compiler errors with -DHPET_DEBUG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200909083650.46771-1-dovmurik@linux.vnet.ibm.com>
 <8d9ae068-77cc-6152-7b90-a51bf70648a0@redhat.com>
From: Dov Murik <dovmurik@linux.vnet.ibm.com>
Message-ID: <4918b958-dbd4-bd18-bb75-da7386124886@linux.vnet.ibm.com>
Date: Thu, 10 Sep 2020 15:53:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <8d9ae068-77cc-6152-7b90-a51bf70648a0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-10_03:2020-09-10,
 2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100112
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dovmurik@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:53:45
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.576,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/2020 20:24, Philippe Mathieu-Daudé wrote:
> On 9/9/20 10:36 AM, Dov Murik wrote:
>> Fix several compiler errors when compiling withe -DHPET_DEBUG.
>>
>> Steps to reproduce the issue:
>>
>>      mkdir build
>>      cd build
>>      ../configure --target-list=x86_64-softmmu --extra-cflags=-DHPET_DEBUG
>>      make
>>
>> Dov Murik (2):
>>    hw/timer/hpet: Remove unused functions hpet_ram_readb, hpet_ram_readw
>>    hw/timer/hpet: Fix debug format strings
>>
>>   hw/timer/hpet.c | 27 +++++++--------------------
>>   1 file changed, 7 insertions(+), 20 deletions(-)
>>
> 
> I sent almost the same patches last week :)
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg736836.html

Oops, missed that. You're right.

> You seem to fix a 4th format, can you rebase on top? (As these
> patches have already been queued).

Actually there's a small issue in one of your suggested fixes: you added 
"0x" but kept the "%#".  I think it should be without the "#" (also 
according to the coding style document).

I suggest you fix this small issue, and also add any changes you wish 
from this patchset; then we can throw my patchset to the bin.

-Dov

