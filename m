Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A32C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1469E20658
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="uItSI/14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1469E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJffN-0007t8-98
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 11:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thanos.makatos@nutanix.com>) id 1jJfcw-0004cj-3J
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thanos.makatos@nutanix.com>) id 1jJfct-00011a-9L
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:50:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:44978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thanos.makatos@nutanix.com>)
 id 1jJfct-0000yJ-45
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:49:59 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 031FnlDP014375; Wed, 1 Apr 2020 08:49:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=WEcmV9OcijZma6uhtByiR7uuaTBflmRrpy98RnlfYf4=;
 b=uItSI/14SpHyI5Si7FeWfz40/2ZgVw/WpkxOPGwSgTFJpI5yAQM6n2NChqW6Objqzfgt
 X6iE65NUf32EaR0Hmt2XJBlWcLPE8BFUCQAi2xud40sfcSLZRO2yrGPMQh8fbYcPM8UI
 Ux25J2L7nrsOJFYbNKWUOGa1z5SgQQ+z3Mze0YCEJ4pou9QnCdHNM7XeqSLvnY4SpIEf
 cCDhR4mBPUQ+U1SmJGIJw1IqA8Sd2BUwXDQLRHDlpN235oM61J1h/ZYbDuFS5VPvLd43
 +iouAHbO6UZbeVAHqkzh4nwPh1vh73hYrV2donWG5Q1lRGFXYcYduBgvgzEVl9m31QAs YQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30244a8nwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2020 08:49:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFFK1ttja+qC2CJoGDc103lKNh6L356k+2FG93YzoZaRdgSTj70wgorxS27a8GlzMjBsYomB1JxOkOnSY1ioH4nA7GI1fy/1n8se6EPVdNq/I6iG8LqdMFaK4LyFJ7rUlZkW4wEnzZgTjRoaK5OCH0WgOOQla+iJ2q1+SzsJtvqr1A8wxe/nPMTnSiK/MkqQ+OaX7vcEw0CDAelaX8OV+02UNCaq/V3Tuvgn6wEp+YVAMHyidgaN7gMllyQaZeBqoO5YAJvaDUc3xfA6k1mHjWT/WAzUTftiRaeAPXVS31ljQxd2HCt52s1WyMRyC8J2v4gqz0zx3l6x8FLAm1BZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEcmV9OcijZma6uhtByiR7uuaTBflmRrpy98RnlfYf4=;
 b=JiQr4FkAWqi24r+qB5f0jpKauFiu73Wu6VRYiurwx8ZDdglM3fICVRTarTr8+n5e0cNpK6cPAdj3acGZQtZaP5Oh1s1u3510J+J+4dOQacEQz5XdBa/E+NFPWgvwt6wcBVDX/U/lTq4gmHcE6aTpg3vvfhgLUAGi9sh2QrVnNGcY6K06RJm/0pSHPWGR/Sl7OOdYi6c6VERf94+B+R37Xy8w/pYgEqF5JnDm2KfU4iZqBxs28mVGlxnPvUSGy3EawAlLCbrxg8W2DxR72wyf1Gz6yiSaDwOXvSwZH5HqohUMWPIzl6cnIJJAjVDQMvqF9H410A1yC4IHQWpSGRTL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB6205.namprd02.prod.outlook.com (2603:10b6:208:1bf::17)
 by MN2PR02MB5981.namprd02.prod.outlook.com (2603:10b6:208:11e::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 15:49:49 +0000
Received: from MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::b05b:f3e9:4d12:f4a9]) by MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::b05b:f3e9:4d12:f4a9%5]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 15:49:49 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: RE: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Thread-Topic: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Thread-Index: AdYDU20BI9Of/G6jR7ONy5zZTB1T9QEsuagAAA2ct3A=
Date: Wed, 1 Apr 2020 15:49:49 +0000
Message-ID: <MN2PR02MB620500A5010B71F1C0D8695E8BC90@MN2PR02MB6205.namprd02.prod.outlook.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
In-Reply-To: <20200401091712.GA221892@stefanha-x1.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.29.225.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e95abfd9-f3ac-4909-baed-08d7d6544f9a
x-ms-traffictypediagnostic: MN2PR02MB5981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB59813527E5265799FBBB7ACB8BC90@MN2PR02MB5981.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB6205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(396003)(39860400002)(366004)(136003)(346002)(376002)(86362001)(966005)(26005)(186003)(76116006)(66556008)(66946007)(478600001)(9686003)(4326008)(64756008)(66476007)(66446008)(44832011)(6916009)(81166006)(54906003)(5660300002)(71200400001)(81156014)(7696005)(33656002)(7416002)(52536014)(2906002)(8936002)(8676002)(6506007)(55016002)(316002);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bVX3u0JX/94FzOsVXimCVlEar4k8LK7p3cKVYg8w2wJnAezsP2ZQWKP6mGNwvSw/adHosVOxEST8l64Oy/C20Exoyp1hCPih2O6iT/DY5zn10HQ93Ccuyw/vGnHcirEnutm217rndLd2pbNSmQ0UgU/UHT51yjg1spisTSssCzoesdfRTYDBkrPiApqyc0YQWSuTWxxcKS/59YvvgH0wV+IO2qer0Vl2+Ob5J9120+qCnL+g7ZuSMm9kzxwOUFP9K3KPcusx6Kxle4xrQAQbRbJE0MOFKnhXlNwN2XJn5ZYCrh5Q6Qu+p8xpM4Q9Chwkq8zwuPu3WRvkdH5Xu8aMv5LgeNmLvnu1f9MDF+tM1OVVSRGjalM8qqhaM2RdioAED9qSqVvLZ7GXWMAG6Rpyu+o18/d35s9E3pcbIWE3S0072rAxlza0b+FKmaSD+13ObMldzfjatF+hN/tlgLwvckP1YOBv9dG96ExS4NvN2X5LnO+qf35q+3fb8FhkqQKIkq/8QpSR/0vjOfXVLK6W0w==
x-ms-exchange-antispam-messagedata: rFz8LOuzkm4Q9bsuDSsVY/ReVCAQ0aOsi/YqPB0r4SjFJv13ISsoGiUIIokQfZXN9wN5sBglGtxILVS8BEz6H0T6HFM+ItdIsAyBT+wrMDcwkE/lOjYs8aGWg2pDZ97VNj+Pmy5KuWnGIdKwTI/mxA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95abfd9-f3ac-4909-baed-08d7d6544f9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 15:49:49.5003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+P3ZbpYML+vRGcGUsI3+ygVJOE12HC1RlBcIc2LWNapcZR+rn8Q+mQoAgtoBfSdLJVzMGa61QCoEG2GwNcd1Bq34ckhA/P6/0vJ93p+rCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5981
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-01_01:2020-03-31,
 2020-03-31 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Jag Raman <jag.raman@oracle.com>, "Harris, 
 James R" <james.r.harris@intel.com>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> On Thu, Mar 26, 2020 at 09:47:38AM +0000, Thanos Makatos wrote:
> > Build MUSER with vfio-over-socket:
> >
> >         git clone --single-branch --branch vfio-over-socket
> git@github.com:tmakatos/muser.git
> >         cd muser/
> >         git submodule update --init
> >         make
> >
> > Run device emulation, e.g.
> >
> >         ./build/dbg/samples/gpio-pci-idio-16 -s <N>
> >
> > Where <N> is an available IOMMU group, essentially the device ID, which
> must not
> > previously exist in /dev/vfio/.
> >
> > Run QEMU using the vfio wrapper library and specifying the MUSER device=
:
> >
> >         LD_PRELOAD=3Dmuser/build/dbg/libvfio/libvfio.so qemu-system-x86=
_64
> \
> >                 ... \
> >                 -device vfio-pci,sysfsdev=3D/dev/vfio/<N> \
> >                 -object memory-backend-file,id=3Dram-node0,prealloc=3Dy=
es,mem-
> path=3Dmem,share=3Dyes,size=3D1073741824 \
> >                 -numa node,nodeid=3D0,cpus=3D0,memdev=3Dram-node0
> >
> > Bear in mind that since this is just a PoC lots of things can break, e.=
g. some
> > system call not intercepted etc.
>=20
> Cool, I had a quick look at libvfio and how the transport integrates
> into libmuser.  The integration on the libmuser side is nice and small.
>=20
> It seems likely that there will be several different implementations of
> the vfio-over-socket device side (server):
> 1. libmuser
> 2. A Rust equivalent to libmuser
> 3. Maybe a native QEMU implementation for multi-process QEMU (I think JJ
>    has been investigating this?)
>=20
> In order to interoperate we'll need to maintain a protocol
> specification.  Mayb You and JJ could put that together and CC the vfio,
> rust-vmm, and QEMU communities for discussion?

Sure, I can start by drafting a design doc and share it.

> It should cover the UNIX domain socket connection semantics (does a
> listen socket only accept 1 connection at a time?  What happens when the
> client disconnects?  What happens when the server disconnects?), how
> VFIO structs are exchanged, any vfio-over-socket specific protocol
> messages, etc.  Basically everything needed to write an implementation
> (although it's not necessary to copy the VFIO struct definitions from
> the kernel headers into the spec or even document their semantics if
> they are identical to kernel VFIO).
>=20
> The next step beyond the LD_PRELOAD library is a native vfio-over-socket
> client implementation in QEMU.  There is a prototype here:
> https://github.com/elmarco/qemu/blob/wip/vfio-user/hw/vfio/libvfio-
> user.c
>=20
> If there are any volunteers for working on that then this would be a
> good time to discuss it.
>=20
> Finally, has anyone looked at CrosVM's out-of-process device model?  I
> wonder if it has any features we should consider...
>=20
> Looks like a great start to vfio-over-socket!

