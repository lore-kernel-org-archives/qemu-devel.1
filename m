Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E8AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBAC20782
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KqaFdNJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBAC20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Vux-0001pG-SM
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@linux.vnet.ibm.com>)
 id 1k5VuI-0001J3-IJ; Tue, 11 Aug 2020 11:09:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@linux.vnet.ibm.com>)
 id 1k5VuG-0008AB-K4; Tue, 11 Aug 2020 11:09:42 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07BF97s9163284; Tue, 11 Aug 2020 11:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZjBqR+iCLuxnGk1ZYgJAnxjO5KS8Ywbrf2MfQUV/7Ao=;
 b=KqaFdNJMmUMiVTaMjFpe9GB6VzC5rHkN36ISnwfXRQIQuZyvduPrAYboTSN6WYWB3tQw
 TgTChgf2N69r9vT6iU1YH0mCMRHgKnX3E7M//P/0MvxkwKTWHIc2O7qsp5GnqTBWKbOr
 D1bPoajRmAMWzjzTuwZDsm1uOB/HrccAr17djxD9hJ7VeqHjlwv25x4+Ne9cpzYnN5Id
 ZwjcX47lKYKLFmciOsho28MdPfZzk+96kxWpnNtCdatBHEFTjseXho62ZWE9bzdBnS4d
 PvV56c7BC/B0F9Gd4Nbu2zpCPPan7qErr+a3DWwcWdicgtraf7rVy+QYiyj10GPdXC5p 1Q== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32t93rcset-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2020 11:09:24 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07BF5Ees023315;
 Tue, 11 Aug 2020 15:09:07 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma02dal.us.ibm.com with ESMTP id 32skp98yan-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2020 15:09:07 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07BF92St38666696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2020 15:09:02 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0C8BBE056;
 Tue, 11 Aug 2020 15:09:06 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 492B1BE051;
 Tue, 11 Aug 2020 15:09:05 +0000 (GMT)
Received: from oc6336877782.ibm.com (unknown [9.80.200.46])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2020 15:09:04 +0000 (GMT)
Subject: Re: [PATCH] target/ppc: Integrate icount to purr, vtb, and tbu40
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200811012759.16329-1-gromero@linux.ibm.com>
 <CAFEAcA9U9Q9QCm+Pk+ktnxxRGrC3F3UdQwp-bvGBZ6x2EY1oMw@mail.gmail.com>
 <3c978275-f4b4-5032-6f79-6e08a1ff3fe3@linux.vnet.ibm.com>
 <CAFEAcA80NQXiHaNcsJqkH4aoeH-G=0dbpwanjjPjfS-Mqs-DHA@mail.gmail.com>
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Message-ID: <7c9ddd92-fb99-bd46-38f7-4c318be5e79e@linux.vnet.ibm.com>
Date: Tue, 11 Aug 2020 12:09:04 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA80NQXiHaNcsJqkH4aoeH-G=0dbpwanjjPjfS-Mqs-DHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-11_14:2020-08-11,
 2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008110105
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=gromero@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 09:33:21
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
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
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/20 11:24 AM, Peter Maydell wrote:
> On Tue, 11 Aug 2020 at 14:33, Gustavo Romero <gromero@linux.vnet.ibm.com> wrote:
>> On 8/11/20 6:31 AM, Peter Maydell wrote:
>>> You don't want to call gen_io_end; you just need to ensure that
>>> you end the TB immediately after this insn. See
>>> docs/devel/tcg-icount.rst.
>>
>> I understand that to ensure that TB ends immediately after these
>> instructions (I understood you meant all the cases, not just the
>> spr_read_purr case, right?), the instructions should be a branch
>> or change CPU state in a way that cannot be deduced at translation
>> time, and I don't know how to ensure that in these cases, they
>> are neither, specially for the read access, which doesn't change
>> any CPU state specifically afaics.
> 
> No, you have that the wrong way around. *If* an instruction
> is a branch or a state-changing one, *then* it must end
> the TB. That doesn't mean that *only* those kinds of insn
> can end the TB -- other things also can end a TB. (It also
> doesn't mean that a branch etc will automatically end the
> TB -- it means that if you're writing the bit of target
> code that generates code for a branch/etc then you must
> specifically ensure that you end the TB.)

ah, ok. I got it now :) Thanks for the explanation.


>> If I remove the gen_io_end() from all these cases the VM gets
>> stuck at apparently random points of execution (I'm digging
>> into details right now trying to understand why).
> 
> Probably because you're not ending the TB after the insn.
> 
> PowerPC seems to be doing something slightly weird in this area --
> it classifies "stop translation" as a kind of exception
> (POWERPC_EXCP_STOP) rather than just using the common-code
> is_jmp machinery and setting it to DISAS_EXIT. So you'll
> need a ppc expert to say what the right thing is, but my
> guess is you want to call gen_stop_exception() -- compare
> gen_darn().

Right, if I change the code to call gen_stop_exception() like
in gen_darn() everything goes fine.

So, I'll send a v2 based on your review then PPC64 folks can
probably take a look at it. Could I add:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

to v2?


Cheers,
Gustavo

