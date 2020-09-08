Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3255DC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50DEC23C8E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="joMsO4wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DEC23C8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFfJu-0005H4-Fq
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 11:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1kFfJ4-0004Gk-9b; Tue, 08 Sep 2020 11:13:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1kFfJ2-0005xM-9I; Tue, 08 Sep 2020 11:13:13 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 088F25xR053121; Tue, 8 Sep 2020 11:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Yc9sgLtx9/g8AdTL2IXbCzGXbB0gvm8L/0R+2kOWok4=;
 b=joMsO4wfPx/BKLbtuYv2kKU4Ci0LGXmVl/b30LBuiXiIuiJUaTu5jzmVqk90TgHwhXLK
 BLVlYT9NTy0VV9IIJJni9frvpYArNBDYwaUxJph2Ku9hOSFkp/r0zaCkV0AE0XtT1nQj
 v9I/WYID3nGvQXRkE3viiPa6bNrgJgZnNbk/hRa4TkO3SkqXuai77gSeyMAPw3IPld3L
 m6UoPL/sWVwinTdSGpX76VrtdzWjDFCL2wqW1dAwcNaOumXm/LJZSdI37B+nlFTZdu53
 D0LC2Lvp4gD1EkEgW2YpmQgEu9yG9GDQ3EjR/wyefJPwd8YhomhoDkbqlj7kXcTv3cFu 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33e9egyuvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2020 11:12:56 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 088F2GKq054068;
 Tue, 8 Sep 2020 11:12:56 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33e9egyuux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2020 11:12:56 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 088FC6VM019702;
 Tue, 8 Sep 2020 15:12:55 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma04dal.us.ibm.com with ESMTP id 33c2a9674n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2020 15:12:55 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 088FCs4F15860164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Sep 2020 15:12:54 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 552EA11206F;
 Tue,  8 Sep 2020 15:12:54 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFF3E11206E;
 Tue,  8 Sep 2020 15:12:50 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.89.54])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
 Tue,  8 Sep 2020 15:12:50 +0000 (GMT)
References: <20200904034719.673626-1-david@gibson.dropbear.id.au>
 <CAFEAcA8xCpRBcsCaozEXnCuM5SqWr5ZEDrwLjs+8va=316_70Q@mail.gmail.com>
 <20200907023800.GJ341806@yekko.fritz.box>
 <675253df-b750-1a0a-5447-9dadef1accba@redhat.com>
 <7c287125-70b3-4330-fd5c-8e644e1c347d@redhat.com>
 <ffee957d-0428-d167-c1ab-3fe67b4d8c7c@redhat.com>
 <20200907165132.683d2880.cohuck@redhat.com>
 <f93673f9-3e83-ef5f-9628-819b25908e43@redhat.com>
 <77b63a31-48a8-c77f-9956-7511db170594@redhat.com>
 <0bca4e6e-f4ba-2108-ecaf-c3daaadbdb26@redhat.com>
 <20200908081123.048f7534.cohuck@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.1
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PULL 00/30] ppc-for-5.2 queue 20200904
In-reply-to: <20200908081123.048f7534.cohuck@redhat.com>
Date: Tue, 08 Sep 2020 12:12:47 -0300
Message-ID: <878sdkqp3k.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-08_07:2020-09-08,
 2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080138
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 11:13:09
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>




Cornelia Huck <cohuck@redhat.com> writes:

> On Mon, 7 Sep 2020 21:46:28 +0200
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>
>> On 9/7/20 7:26 PM, Laurent Vivier wrote:
>>
>> > We can't add a "#ifdef CONFIG_USER_ONLY" in hw/core/cpu.c to set halted
>> > to 0 because it is in the common files, but we can do:
>> >=20
>> > diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> > index 73d7d6007e8e..749cd548f0f3 100644
>> > --- a/target/s390x/cpu.c
>> > +++ b/target/s390x/cpu.c
>> > @@ -291,9 +291,9 @@ static void s390_cpu_initfn(Object *obj)
>> >      S390CPU *cpu =3D S390_CPU(obj);
>> >=20
>> >      cpu_set_cpustate_pointers(cpu);
>> > -    cs->start_powered_off =3D true;
>> >      cs->exception_index =3D EXCP_HLT;
>> >  #if !defined(CONFIG_USER_ONLY)
>> > +    cs->start_powered_off =3D true;
>> >      object_property_add(obj, "crash-information", "GuestPanicInformat=
ion",
>> >                          s390_cpu_get_crash_info_qom, NULL, NULL, NULL=
);
>> >      cpu->env.tod_timer =3D=20=20
>>=20
>> This looks like the correct fix indeed :)
>> (Maybe worth adding a comment around).
>
> Agreed on both counts.
>
>> Thanks for investigating!
>
> And here as well :)

Thank you very much for investigating and fixing this problem, Laurent!

Sorry for not working on this issue. I was out on an extended weekend
and just came back.

--=20
Thiago Jung Bauermann
IBM Linux Technology Center

