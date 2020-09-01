Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A1DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FED2067C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lB/n4Svk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FED2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5zx-00009s-Ep
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1kD5vo-0002GJ-Gx; Tue, 01 Sep 2020 09:02:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1kD5vm-0003VP-AF; Tue, 01 Sep 2020 09:02:36 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 081CWmoW126741; Tue, 1 Sep 2020 09:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=reply-to : subject : to
 : references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=l98Ap7g/+P+Gfsqv+10R2fd9rDdA4JpDZZ6cblYzFG8=;
 b=lB/n4Svk+x1HOhHErlYoZ6ibD8qnk90lgR6OBY2icW+U/RyWrkH5rhmzljm4RJ3CfAkd
 V05xROnmlpIY7jrLZ1Tgjvxhb00IrZdF9SD0TsEtlj9+V3z+s4PixPumNhQrvrM7HaCO
 MWPOeW9d3VX0JSe3szg9wgLaTz242RugHzNsyl9RKS4jdg7fYSwOCDJGNtJDu12mvnk1
 7DVPbBpikCMVpt+O7Dr4rs8K7i+rYYBS+cInNax650gr/irvQdysQ5Ha6eE29zBDq6NA
 JoUsiQb1jWhlMCL4Y62G7spOZ5O70dNx73VFxeEhqM1w1+lOSMycBm6EZdrdnb5r9KRG dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 339n1ebngn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2020 09:02:31 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 081CWq5k127131;
 Tue, 1 Sep 2020 09:02:30 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 339n1ebng1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2020 09:02:30 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 081CrHbT001338;
 Tue, 1 Sep 2020 13:02:29 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma02wdc.us.ibm.com with ESMTP id 337en9fysh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2020 13:02:29 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 081D2SPO55312688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Sep 2020 13:02:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D043DB2064;
 Tue,  1 Sep 2020 13:02:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D60BB2066;
 Tue,  1 Sep 2020 13:02:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.189.250])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Sep 2020 13:02:28 +0000 (GMT)
Subject: Re: [PATCH] pc-bios/s390x: Pack ResetInfo struct
To: Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, cohuck@redhat.com
References: <20200205182126.13010-1-jjherne@linux.ibm.com>
 <e3baa1e0-e1d3-d67c-cca9-a626d42c5489@de.ibm.com>
 <896302f7-ec21-6108-6dde-f5a7439d87ab@redhat.com>
 <caefcdbf-e68c-ba05-2ec4-17f127109434@de.ibm.com>
 <d9891265-2254-ee64-c009-0105f7a8b02b@linux.ibm.com>
 <12e6fb00-bf1c-268b-baee-ccf1eb73bece@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Organization: IBM
Message-ID: <c5c3abb3-4279-7f4e-4a3c-6346b785fc61@linux.ibm.com>
Date: Tue, 1 Sep 2020 09:02:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <12e6fb00-bf1c-268b-baee-ccf1eb73bece@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-01_08:2020-09-01,
 2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=908
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010109
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 09:02:31
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 6:07 AM, Thomas Huth wrote:
> On 07/02/2020 15.02, Jason J. Herne wrote:
>> On 2/7/20 6:28 AM, Christian Borntraeger wrote:
>>> Jason,
>>>
>>> can you run objdump -Sdr on jump2ipl.o on a broken variant?
>>>
>>>
>> To keep the volume lower, I've only pasted the output that I think
>> you're interested in. If you want to see the entire thing just let me know.
>>
>> static void jump_to_IPL_2(void)
>> {
>>   1d0:    eb bf f0 58 00 24     stmg    %r11,%r15,88(%r15)
>>   1d6:    a7 fb ff 50           aghi    %r15,-176
>>   1da:    b9 04 00 bf           lgr    %r11,%r15
>>      ResetInfo *current = 0;
>>   1de:    a7 19 00 00           lghi    %r1,0
>>   1e2:    e3 10 b0 a8 00 24     stg    %r1,168(%r11)
>>
>>      void (*ipl)(void) = (void *) (uint64_t) current->ipl_continue;
>>   1e8:    e3 10 b0 a8 00 04     lg    %r1,168(%r11)
>>   1ee:    58 10 10 08           l    %r1,8(%r1)
>>   1f2:    b9 16 00 11           llgfr    %r1,%r1
>>   1f6:    e3 10 b0 a0 00 24     stg    %r1,160(%r11)
>>      *current = save;
>>   1fc:    e3 10 b0 a8 00 04     lg    %r1,168(%r11)
>>   202:    c0 20 00 00 00 00     larl    %r2,202 <jump_to_IPL_2+0x32>
>>              204: R_390_PC32DBL    .bss+0x2
>>   208:    eb 23 20 00 00 04     lmg    %r2,%r3,0(%r2)
>>   20e:    eb 23 10 00 00 24     stmg    %r2,%r3,0(%r1)
>>      ipl(); /* should not return */
>>   214:    e3 10 b0 a0 00 04     lg    %r1,160(%r11)
>>   21a:    0d e1                 basr    %r14,%r1
>> }
>>   21c:    18 00                 lr    %r0,%r0
>>   21e:    eb bf b1 08 00 04     lmg    %r11,%r15,264(%r11)
>>   224:    07 fe                 br    %r14
>>   226:    07 07                 nopr    %r7
> 
> I'm currently looking through the past s390-ccw bios patches that still
> might need attention ... was there ever a follow up on this discussion?
> Do we need to clear the registers before jumping to the OS?
> And looking at the disassembly, should we declar the ipl function
> pointer with __attribute__((noreturn)) ?
> 

Janosch has done some cleanup work that has not hit master yet. This work, if accepted, 
would fix this problem and eliminate the need for this patch. So I think we should wait to 
see how that plays out before we revisit this.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)

