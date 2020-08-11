Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B32C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6E6204FD
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="coztNhbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6E6204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5VLi-0003rX-NY
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@linux.vnet.ibm.com>)
 id 1k5UQ7-0006I5-FY; Tue, 11 Aug 2020 09:34:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45726
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@linux.vnet.ibm.com>)
 id 1k5UQ5-0004QC-60; Tue, 11 Aug 2020 09:34:27 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07BDWIab142957; Tue, 11 Aug 2020 09:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HdwaIGASccXjOQVyzIwRjVEA94azmBIosBWHWtfBMmQ=;
 b=coztNhbiG/Myi+lBxXCOZSLiPV0x3FfNynCHaaw6PEnQRcZkvcb/vsdEg9w0T17YSXd2
 ccj82Rhm7DUZGjnSkxr0D2+WPV0nWQFH+RzdBqxLl3Pft/thxQjz9pkXySJ1ENY8vZEe
 ObUg7QyLos3U69DYqcd2D3JheE1fMOEltIoapblPP3oJgvTgas+dOdsfuTCYl990/Ypm
 bRyjjcTgJf+HOZ4pJcP0vOyj8BGq1/VkQe4edbsS8EWvCENbF3+sk4BkWYDmMfKCBqGJ
 UD+aRJolyS7zN9Zy45VbTyq7p8ZI3p5CG9+gyt0ENYjZK65T/y+MqeRLiOO49x/dbGwk Xg== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32sr7nrx1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2020 09:33:07 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07BDTs1o007682;
 Tue, 11 Aug 2020 13:33:06 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma02wdc.us.ibm.com with ESMTP id 32skp91rgk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2020 13:33:06 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07BDX6Nc53150112
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2020 13:33:06 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 109BEAC060;
 Tue, 11 Aug 2020 13:33:06 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F216FAC05B;
 Tue, 11 Aug 2020 13:33:04 +0000 (GMT)
Received: from oc6336877782.ibm.com (unknown [9.80.200.46])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2020 13:33:04 +0000 (GMT)
Subject: Re: [PATCH] target/ppc: Integrate icount to purr, vtb, and tbu40
To: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gromero@linux.ibm.com>
References: <20200811012759.16329-1-gromero@linux.ibm.com>
 <CAFEAcA9U9Q9QCm+Pk+ktnxxRGrC3F3UdQwp-bvGBZ6x2EY1oMw@mail.gmail.com>
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Message-ID: <3c978275-f4b4-5032-6f79-6e08a1ff3fe3@linux.vnet.ibm.com>
Date: Tue, 11 Aug 2020 10:33:04 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9U9Q9QCm+Pk+ktnxxRGrC3F3UdQwp-bvGBZ6x2EY1oMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-11_13:2020-08-11,
 2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008110091
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=gromero@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 09:33:21
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 11 Aug 2020 10:30:35 -0400
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 8/11/20 6:31 AM, Peter Maydell wrote:
> On Tue, 11 Aug 2020 at 02:29, Gustavo Romero <gromero@linux.ibm.com> wrote:
>>
>> Currently if option '-icount auto' is passed to the QEMU TCG to enable
>> counting instructions the VM crashes with the following error report when
>> Linux runs on it:
>>
>> qemu-system-ppc64: Bad icount read
>>
>> This happens because read/write access to the SPRs PURR, VTB, and TBU40
>> is not integrated to the icount framework.
>>
>> This commit fixes that issue by making the read/write access of these
>> SPRs aware of icount framework, adding the proper gen_io_start/end() calls
>> before/after calling the helpers to load/store these SPRs in TCG.
>>
>> Signed-off-by: Gustavo Romero <gromero@linux.ibm.com>
>> @@ -284,12 +284,26 @@ static void spr_write_atbu(DisasContext *ctx, int sprn, int gprn)
>>   ATTRIBUTE_UNUSED
>>   static void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
>>   {
>> +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
>> +        gen_io_start();
>> +    }
>>       gen_helper_load_purr(cpu_gpr[gprn], cpu_env);
>> +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
>> +        gen_io_end();
>> +        gen_stop_exception(ctx);
>> +    }
> 
> You don't want to call gen_io_end; you just need to ensure that
> you end the TB immediately after this insn. See
> docs/devel/tcg-icount.rst.

I understand that to ensure that TB ends immediately after these
instructions (I understood you meant all the cases, not just the
spr_read_purr case, right?), the instructions should be a branch
or change CPU state in a way that cannot be deduced at translation
time, and I don't know how to ensure that in these cases, they
are neither, specially for the read access, which doesn't change
any CPU state specifically afaics.

If I remove the gen_io_end() from all these cases the VM gets
stuck at apparently random points of execution (I'm digging
into details right now trying to understand why).

Thanks a lot.


Cheers,
Gustavo

