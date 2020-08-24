Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5D3C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 23:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B87322074D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 23:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qCX7wymh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87322074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAM0i-0006gx-1a
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 19:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1kALzd-0005Tc-O7; Mon, 24 Aug 2020 19:35:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1kALzc-0001lI-3n; Mon, 24 Aug 2020 19:35:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07ONVMqL157169; Mon, 24 Aug 2020 19:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=AGsSv3Q5943UkrMsUV6z9Q8Hz/NQt6erlplFz3Tw54M=;
 b=qCX7wymh3uuvLDRSB1Q6gKKgM15X2L4UiRjpZEfy/cFlAGoW9iAkkwxRcUsvrrZhu/Uv
 wJ/xlyXITb+TXiBASibURiSkuUALcbcZjizpxsb6ym5T6uwQLfwm6DkAGF+tETdONf/9
 SyjEL4Zq4Q6Vnitr5V0hQsZuLy4A2BwOat2OpfS0IRRWvSHFnLJ0I8wXRpKaY8MI2keb
 shlbKmDvWh6OzPII0QT2QhDwe2XVR9pGMt5xe9+TiRUOssMLjrlRuiGac7DuGdidmfAF
 +Qxh11QmZ2NvXYGNFGWuxMY2WZxsC4jl2ooLWyLJPA3ZjE1bjQb815v657xYLtfPDrF5 Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 334p8yhhb0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2020 19:34:47 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07ONXLGh162186;
 Mon, 24 Aug 2020 19:34:47 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 334p8yhhan-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2020 19:34:46 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07ONQkWx004908;
 Mon, 24 Aug 2020 23:34:46 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma05wdc.us.ibm.com with ESMTP id 332uw751bx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2020 23:34:46 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07ONYect37618166
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2020 23:34:40 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32FABBE06A;
 Mon, 24 Aug 2020 23:34:45 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30C6FBE05F;
 Mon, 24 Aug 2020 23:34:40 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.25.204])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 24 Aug 2020 23:34:39 +0000 (GMT)
References: <20200819164306.625357-1-bauerman@linux.ibm.com>
 <20200819164306.625357-5-bauerman@linux.ibm.com>
 <3dd050ad-147e-c365-883a-3384130b0d2f@kaod.org>
 <2fee9e37-f420-c0d0-dc57-c0ce273a1882@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 4/8] ppc/e500: Use start-powered-off CPUState property
In-reply-to: <2fee9e37-f420-c0d0-dc57-c0ce273a1882@redhat.com>
Date: Mon, 24 Aug 2020 20:34:36 -0300
Message-ID: <87ft8b4nzn.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-24_12:2020-08-24,
 2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008240180
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=bauerman@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 22:50:45
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>,
 qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 8/22/20 10:59 AM, C=C3=A9dric Le Goater wrote:
>> Hello,
>>=20
>> On 8/19/20 6:43 PM, Thiago Jung Bauermann wrote:
>>> Instead of setting CPUState::halted to 1 in ppce500_cpu_reset_sec(), use
>>> the start-powered-off property which makes cpu_common_reset() initializ=
e it
>>> to 1 in common code.
>>>
>>> Also change creation of CPU object from cpu_create() to object_new() and
>>> qdev_realize_and_unref() because cpu_create() realizes the CPU and it's=
 not
>>> possible to set a property after the object is realized.
>>>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>>=20
>>=20
>> This is breaking make check :=20
>>=20
>>     tests/qtest/libqtest.c:175: kill_qemu() detected QEMU death from sig=
nal 11 (Segmentation fault) (core dumped)
>>     ERROR boot-serial-test - too few tests run (expected 7, got 0)
>>     make: *** [/home/legoater/work/qemu/qemu-powernv-5.2.git/tests/Makef=
ile.include:650: check-qtest-ppc64] Error 1
>>     make: *** Waiting for unfinished jobs....
>>=20=20=20=20=20
>>=20=20=20=20=20
>>     gdb --args build/ppc64-softmmu/qemu-system-ppc64  -display none   -M=
 ppce500
>>     ...
>>     Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fau=
lt.
>>     0x000055555596ebf2 in ppce500_init (machine=3D0x5555567aa6e0)
>>         at /home/legoater/work/qemu/qemu-powernv-5.2.git/hw/ppc/e500.c:8=
80
>>     880	        irqs[i].irq[OPENPIC_OUTPUT_INT] =3D input[PPCE500_INPUT_=
INT];
>>=20=20
>>=20=20=20=20=20
>>     AFAIUI, 'input is not initialized since the CPU is not yet realized.
>
> Thiago, see ad938fc1d53 ("hw/arm/palm.c: Encapsulate misc GPIO handling
> in a device") and eventually f8a865d36dc ("hw/arm/allwinner-a10:
> Simplify by passing IRQs with qdev_pass_gpios") to get an idea how you
> can fix that.

Thanks for the references, those are very useful.

--=20
Thiago Jung Bauermann
IBM Linux Technology Center

