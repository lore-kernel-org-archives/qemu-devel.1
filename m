Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9333CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A663620684
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="G+cSDemV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A663620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMSdV-0001LY-Ky
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 04:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iMSc8-0000tu-Iz
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iMSc6-0003y6-8K
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:00:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:20190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iMSc6-0003x7-1b
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:00:26 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x9L7t1G2029797; Mon, 21 Oct 2019 01:00:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=SWjUzbIcDxuMz4ut8QVHxsnBXc4r/9hhg9vdq2MjmlA=;
 b=G+cSDemVuf/QMWhrNmcn3Mq631glwmUY2gjus9QR066MpKS+ZTQO9LjS6fayVNnVww2H
 5zLxhEF6BBqDNgnYYgLs40dWzxD99Wb8NIpspWbkXAerSAm2C6MLXcrWAbS/0wmnWLLA
 NzDpoR6pPHQPI8bfvaaNN8soLvrzZIbTBEf6DmF74JLopHVa/ClRY/jagFkVydAedHof
 siVDPYHU6wEZyTmayPvishtMKWRzzs0X5KTB1u7XdFvBlnY0T8y87LLzPrIwdp3Je9zl
 DYee2EuuwbwVfX2+rQ6UUMGywsUXok1k8sE0GF9arLQR4otbu23mIG5YgHpZvwMoIlQq Vw== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com
 (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2vr0kj2qb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2019 01:00:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIauZVk7628+s9bJ8MKt10J/0QNMy6/i4L2d2hOkS/R9E+BacaGZidHfbYuhzdBY9cPkGuihTFVy306sLbDj8hsyAiZRmr0PRWc0LRwKGSuGLaZw/et47kaQpX6BIIHdzXf3SL1EWHO7IKKZY9yH1G85M8LnR8GW3udn7cchL4W4WpadV0ziPOLxvL4pucwDU/viA0bwtbUorZAYoYtwP7lqSpqhfoqpXkHHJlhITmUMJK55fB4pz5aLyTFaFIvMnV9BKFUZOLAyxmAJEpzUq7w0inEfZlciF83ZjPBXIgwO0BHE3xHGJxRYxS4PGhF5miG6iqOXFiHfH/71hndTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWjUzbIcDxuMz4ut8QVHxsnBXc4r/9hhg9vdq2MjmlA=;
 b=MOdD31/scw3aP55EvPSOLv4AkC/GcfMPWtHQjS1+9S7E06zGdL5seuPQEGoplYtIRRpYsbwA9lixMrjWpaX1o009nQq9Mc2YPudA12LJSgJ1pm9EPKvy7ZYWNOyMxkKLr3sbQCGCfcRCDNc2+qCyYXEXLu/JoKZRq0g2J11mAZCn2DYpmNcNXIv3boRa1ycJjqdsqVjYaX2AH2GK+V2R4rjeuIebBnEPmhHHxJsGhPA8hFxXzT7ANKfA9NLfL5MQgqkTDHn6Pm/fIt+NqE+v92sDwG8vsj2kz/q6vlQL4oyuP/JLFKyll64QffU2kzUgsqol1Tlj7GPzQqPpEfFTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2654.namprd02.prod.outlook.com (10.168.206.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 21 Oct 2019 08:00:18 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::7ca0:95fd:4b35:3435]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::7ca0:95fd:4b35:3435%6]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 08:00:18 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Yongji Xie <elohimes@gmail.com>, Changpeng Liu <changpeng.liu@intel.com>
Subject: Re: [PATCH] vhost-user-scsi: implement handle_output
Thread-Topic: [PATCH] vhost-user-scsi: implement handle_output
Thread-Index: AQHVhQl71p+KRszYckq7k3pyTpDK5adftgOAgACKQACABD4KgIAAQsUA
Date: Mon, 21 Oct 2019 08:00:17 +0000
Message-ID: <B53729BD-5A55-4D27-88BE-F8ED2A39D41F@nutanix.com>
References: <20191017163859.23184-1-felipe@nutanix.com>
 <CAONzpcbR+OjcrfavTnFXVopG-YsTdnFCT=no0eFei4oanfmj1Q@mail.gmail.com>
 <17B5A7A6-F790-4D10-8921-06A83DA18077@nutanix.com>
 <CAONzpcYDDUde0PLVtGYuwGm79RvU-VubXqDs=4F_8yp+-pz-Zg@mail.gmail.com>
In-Reply-To: <CAONzpcYDDUde0PLVtGYuwGm79RvU-VubXqDs=4F_8yp+-pz-Zg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08774767-a4e7-404e-47bd-08d755fcb69e
x-ms-traffictypediagnostic: MWHPR02MB2654:
x-microsoft-antispam-prvs: <MWHPR02MB2654A4702D89710DE70ED63FD7690@MWHPR02MB2654.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(64756008)(66446008)(33656002)(25786009)(66556008)(91956017)(76116006)(66476007)(66946007)(36756003)(14454004)(71190400001)(71200400001)(5660300002)(54906003)(110136005)(478600001)(316002)(53546011)(102836004)(186003)(6486002)(2906002)(66066001)(26005)(6436002)(6246003)(81156014)(7736002)(305945005)(81166006)(8936002)(86362001)(76176011)(6506007)(6512007)(99286004)(8676002)(229853002)(4326008)(446003)(2616005)(486006)(3846002)(256004)(6116002)(14444005)(11346002)(476003)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2654;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nfq/Q5BPDCoAHgMcvjtYn9/lQi4B2hdHtnw+KFmc+HymOdmdsASdAaWNOduaG17H7jkuj3ArX5IL2iD3rrOfO5M8UHzQnKq7FpHtSdJnOMp/pZviJTKt8mwJXNiQWdI8gTvwkxjwt2HkC0Ch+XsaR8nZ4lItvJlxbQO2BEiGkFp/JaELBXUWny9pM/YVcdci3wJW153jwPJKCglLp/saoiD0Exus2IiPZ7huztrUSb7Pad68TdlAF9qeevAQe8k1RA6gJnmsbM0e2XTDHQHSSswiVkut3M3JoShDR81VKSRULFWvu0qXdtKJbTjcmDYRY6+Ql7mFc7gZYQb2h41LCqKDAKvNnlLBKWsKDh3kyVn9GwKK1fmdYlkjO0vAa92+yqVjsSkZVJMxBYkKXnY7lamtiUpQjU8yu/eemU5UiGlkJFQc2Hv/VbEToCvJToxN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AEB5ABB79BB398489627BBE23BADF8F3@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08774767-a4e7-404e-47bd-08d755fcb69e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 08:00:17.7621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7cg7pOo/VSYKFw89qHEjnxzfzTgODj/ZXJelJxZBW4YflarTIiSCmmpC2p2m9KTKJSvagMd/AOrgmEv5OMm0YGl6EXZCQZNJHcbXfM7k64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2654
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-21_02:2019-10-18,2019-10-21 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.155.12
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Oct 21, 2019, at 5:01 AM, Yongji Xie <elohimes@gmail.com> wrote:
>=20
> On Fri, 18 Oct 2019 at 19:14, Felipe Franciosi <felipe@nutanix.com> wrote=
:
>>=20
>>=20
>>=20
>>> On Oct 18, 2019, at 3:59 AM, Yongji Xie <elohimes@gmail.com> wrote:
>>>=20
>>> On Fri, 18 Oct 2019 at 01:17, Felipe Franciosi <felipe@nutanix.com> wro=
te:
>>>>=20
>>>> Originally, vhost-user-scsi did not implement a handle_output callback
>>>> as that didn't seem necessary. Turns out it is.
>>>>=20
>>>> Depending on which other devices are presented to a VM, SeaBIOS may
>>>> decide to map vhost-user-scsi devices on the 64-bit range of the addre=
ss
>>>> space. As a result, SeaBIOS will kick VQs via the config space. Those
>>>> land on Qemu (not the vhost backend) and are missed, causing the VM no=
t
>>>> to boot. This fixes the issue by getting Qemu to post the notification=
.
>>>>=20
>>> Should we fix this in vhost-user-blk too?
>>=20
>> I'm not sure vhost-user-blk suffers from the same problem. Certainly
>=20
> Actually I found vhost-user-blk has the same problem in a mutilple
> GPUs passthough environment.

Let's Cc Changpeng for comments. I'm not familiar with that code.

In any case, I still think we should merge this and fix other
implementations separately. That allows us to revert patches
individually if anything else breaks.

F.

>=20
> Thanks,
> Yongji


