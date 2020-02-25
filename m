Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AD2C35DFB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B7920714
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B7920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6XOW-0001Wy-On
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jjherne@linux.ibm.com>) id 1j6XNq-0000uE-3T
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jjherne@linux.ibm.com>) id 1j6XNn-0005VS-RO
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:24:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64822
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
 id 1j6XNn-0005UL-Ml; Tue, 25 Feb 2020 05:24:07 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01PAKFdS120316; Tue, 25 Feb 2020 05:24:05 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yaxt88fck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2020 05:24:04 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01PAKNil121186;
 Tue, 25 Feb 2020 05:24:04 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yaxt88fa1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2020 05:24:04 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01PAA33j025288;
 Tue, 25 Feb 2020 10:23:58 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma03wdc.us.ibm.com with ESMTP id 2yaux6b24b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2020 10:23:58 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01PANvpi49873384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2020 10:23:57 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36EF56E054;
 Tue, 25 Feb 2020 10:23:57 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEA276E04C;
 Tue, 25 Feb 2020 10:23:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.188.183])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 25 Feb 2020 10:23:56 +0000 (GMT)
Subject: Re: [PATCH] pc-bios/s390x: Pack ResetInfo struct
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, cohuck@redhat.com
References: <20200205182126.13010-1-jjherne@linux.ibm.com>
 <e3baa1e0-e1d3-d67c-cca9-a626d42c5489@de.ibm.com>
 <bf3f44b5-f0fe-59f4-9152-54edd8c9822e@linux.ibm.com>
 <941cc201-4c33-0ad3-ecc8-eab2709d350d@de.ibm.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Organization: IBM
Message-ID: <91910082-ffeb-c588-7434-3de5fbfcbfa6@linux.ibm.com>
Date: Tue, 25 Feb 2020 05:23:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <941cc201-4c33-0ad3-ecc8-eab2709d350d@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-25_02:2020-02-21,
 2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250083
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id 01PAKFdS120316
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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

On 2/13/20 1:24 PM, Christian Borntraeger wrote:
...
>>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.=
c
>>> index da13c43cc0..8839226803 100644
>>> --- a/pc-bios/s390-ccw/jump2ipl.c
>>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>>> @@ -18,6 +18,7 @@
>>>  =C2=A0 typedef struct ResetInfo {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t ipl_psw;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t ipl_continue;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t pad;
>>>  =C2=A0 } ResetInfo;
>>>  =C2=A0 =C2=A0 static ResetInfo save;
>>>
>>>
>>> also work? If yes, both variants are valid. Either packed or explicit=
 padding.
>>>
>>
>> I don't believe this will work. I think the problem is that we're over=
writing too much memory when we cast address 0 as a ResetInfo and then ov=
erwrite it (*current =3D save). I think we need the struct to be sized at=
 12-bytes instead of 16.
>>
>=20
> The idea of the code is that we _save_ the original content from addres=
s 0 to save and _restore_ it before jumping into final code. I do not yet=
 understand why this does not work.
>=20

I've found the real problem here. Legacy operating systems that expect to=
 start
in 32-bit addressing mode can fail if we leave junk in the high halves of=
 our
64-bit registers. This is because some instructions (LA for example) are
bi-modal and operate differently depending on the machine's current addre=
ssing
mode.

In the case where we pack the struct, the compiler happens to use the mvc
instruction to load/store the current/save memory areas.

       *current =3D save;
   1fc:	e3 10 b0 a8 00 04 	lg	%r1,168(%r11)
   202:	c0 20 00 00 00 00 	larl	%r2,202 <jump_to_IPL_2+0x32>
			204: R_390_PC32DBL	.bss+0x2
   208:	d2 0b 10 00 20 00 	mvc	0(12,%r1),0(%r2)

Everything works as expected here, our legacy OS boots without issue.
However, in the case where we've packed this struct the compiler optimize=
s the
code and uses lmg/stmg instead of mvc to copy the data:

       *current =3D save;
   1fc:	e3 10 b0 a8 00 04 	lg	%r1,168(%r11)
   202:	c0 20 00 00 00 00 	larl	%r2,202 <jump_to_IPL_2+0x32>
			204: R_390_PC32DBL	.bss+0x2
   208:	eb 23 20 00 00 04 	lmg	%r2,%r3,0(%r2)
   20e:	eb 23 10 00 00 24 	stmg	%r2,%r3,0(%r1)

Depending on the data being copied, the high halves of the registers may =
contain
non-zero values. Example:

     r2             0x108000080000780        74309395999098752
     r3             0x601001800004368        432627142283510632

So, by sheer luck of the generated assembler, the patch happens to "fix" =
the
problem.  A real fix might be to insert inline assembler that clears the =
high
halves of the registers before we call ipl() in jump_to_IPL_2(). Can we t=
hink of
a better way to do that than 15 LLGTR instructions? :) Let me know your
thoughts.

jump_to_IPL_2 for easy reference:
     static void jump_to_IPL_2(void)
     {
         ResetInfo *current =3D 0;

         void (*ipl)(void) =3D (void *) (uint64_t) current->ipl_continue;
         *current =3D save;
         ipl(); /* should not return */
     }


--=20
-- Jason J. Herne (jjherne@linux.ibm.com)

