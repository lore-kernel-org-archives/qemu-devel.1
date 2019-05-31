Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67236C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E9E26B91
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="pY+h/9/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E9E26B91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45239 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWjSo-0000nn-FT
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 11:29:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thanos.makatos@nutanix.com>) id 1hWjS2-0000V9-7H
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thanos.makatos@nutanix.com>) id 1hWjS1-0001Sh-3R
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:28:14 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:41424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thanos.makatos@nutanix.com>)
	id 1hWjS0-0001QI-Ms
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:28:13 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4VFN4to018173; Fri, 31 May 2019 08:28:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
	h=from : to : cc :
	subject : date : message-id : references : in-reply-to : content-type :
	content-transfer-encoding : mime-version; s=proofpoint20171006;
	bh=3cIGREHCXGjIe4zDXshovQ8m/tDGYim1WcqlPVqEtdY=;
	b=pY+h/9/Hq6HuwQ0jpvEjdq2awdrURJc3xt/FKtZ1CHUKFfCQXYu9HCMF7QuRAx0eqksr
	b74VZL/LeiG0XnFKa/W3Gz3AORWDvdaaJVsZ/Qwy7T6WKCXOMFH+4SzsPD0om8lC3cxj
	VanNcs46Dv40uBRCyntW/F7dZxUXVINDBwQwZQrxD1V1OcrWrn+j8vTzT8zJ7jgmkkXs
	sVg6Bbtc93rQEEaJbd4egEewEEM+MgorE7yu2FkoRrNUFwUfikMv03Vm8LwlPBia8viN
	ttNZJyO8Xx+XNYi/ippTF7Eyp7a3/28C8yMLJ+evb9+oaAdGxCeMjTzCsEmwFjWWw5vh
	pQ== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com
	(mail-sn1nam01lp2058.outbound.protection.outlook.com [104.47.32.58])
	by mx0a-002c1b01.pphosted.com with ESMTP id 2styhxrn9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 31 May 2019 08:28:09 -0700
Received: from MN2PR02MB6205.namprd02.prod.outlook.com (52.132.174.26) by
	MN2PR02MB6399.namprd02.prod.outlook.com (52.132.175.208) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.18; Fri, 31 May 2019 15:28:08 +0000
Received: from MN2PR02MB6205.namprd02.prod.outlook.com
	([fe80::25d5:60b3:a680:7ebd]) by
	MN2PR02MB6205.namprd02.prod.outlook.com
	([fe80::25d5:60b3:a680:7ebd%3]) with mapi id 15.20.1922.021;
	Fri, 31 May 2019 15:28:08 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Alex Williamson <alex.williamson@redhat.com>
Thread-Topic: [Qemu-devel] QEMU tries to register to VFIO memory that is not
	RAM
Thread-Index: AdUXtUBrTZM56mQoR86m4RxpHSXlmQACSDQAAAGm+pA=
Date: Fri, 31 May 2019 15:28:07 +0000
Message-ID: <MN2PR02MB620549D68EB53487C6FCF51F8B190@MN2PR02MB6205.namprd02.prod.outlook.com>
References: <MN2PR02MB62053CE40CA6B4A97B32FA048B190@MN2PR02MB6205.namprd02.prod.outlook.com>
	<20190531083732.37ecbb1e@x1.home>
In-Reply-To: <20190531083732.37ecbb1e@x1.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb1ae5e8-fc46-45b6-3a21-08d6e5dc955d
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:MN2PR02MB6399; 
x-ms-traffictypediagnostic: MN2PR02MB6399:
x-proofpoint-crosstenant: true
x-microsoft-antispam-prvs: <MN2PR02MB6399A4CE3CFDFB3BBC5760A08B190@MN2PR02MB6399.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(14444005)(8936002)(81166006)(8676002)(81156014)(7736002)(99286004)(76176011)(55016002)(53936002)(9686003)(305945005)(68736007)(26005)(256004)(52536014)(71200400001)(74316002)(86362001)(229853002)(7696005)(6436002)(71190400001)(5660300002)(66066001)(6246003)(486006)(446003)(73956011)(2906002)(102836004)(6916009)(6506007)(476003)(76116006)(107886003)(33656002)(186003)(66946007)(4326008)(66446008)(54906003)(44832011)(66556008)(3846002)(14454004)(6116002)(25786009)(478600001)(64756008)(316002)(11346002)(66476007)(64030200001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB6399;
	H:MN2PR02MB6205.namprd02.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fEr+kH5cG0lVN/DE0/0dn30dVeUYUdM5XtklZYdeuunURl6pKB8jLwow6WbWmuQ+fLS3AQfl7WxDhYfzzX+w29tfqL6Bo4sYX8kY8Y1VhdmVXt3pNpXjCevAxogRj4yi2RkOpd6m+pe6KhTHQ8QIPx7htjVkX9tyuQvTYmBqGSGGLp/MACf2hT5NfQSwzPE/2TZ5NQMtpY/rkJTQPLuFDTmJwp4avQc+/Yhw/8B8wi3EkEBS3MmR4skR3nNNyoRtRsJi/rX+CGZ8cBSVLfhq5e/I9SDgGOHCdljHBgZ8cLChUpKKkeUUEj1bP76F5+JvFuNrp6edItCetmSUjB/lzccfBA+ZPO1aRk6H+I1zRH4F6TZgGRAU23ft6T3oI9xd7HZg8H+RutMPfDUyd/kNf+74/IRMPVcajp3GXvfyqus=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1ae5e8-fc46-45b6-3a21-08d6e5dc955d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 15:28:07.9825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thanos.makatos@nutanix.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6399
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-31_10:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.151.68
Subject: Re: [Qemu-devel] QEMU tries to register to VFIO memory that is not
 RAM
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Swapnil Ingle <swapnil.ingle@nutanix.com>,
	Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > When configuring device pass-through via VFIO to a VM, I noticed that
> > QEMU tries to register (DMA_MAP) all memory regions of a guest (not
                > > only RAM). That includes firmware regions like "pc.rom"=
. Would a
> > physical device ever need access to those?
>
> Probably not, but are those things not in the address space of the
> device on a physical system?

They are. I'm wondering whether it makes sense in a virtualized environment=
.

>
> > Am I missing something?
>
> Does this cause a problem?

It does in my use case. We're experimenting with devices backed by another
userspace application. We can configure QEMU to allocate shared memory
(MAP_SHARED) for guest RAM (which we can register in the other process) but=
 not
for anything else.

>  It's not always easy to identify regions
> that should not be mapped to a device, clearly we're not going to
> create a whitelist based on the name of the region.  Thanks,

Indeed. Could we decide whether or not to register an address space with
VFIO in a more intelligent manner? E.g. the following simplistic patch solv=
es
our problem:

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4374cc6176..d9d3b1277a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -430,6 +430,9 @@ static void vfio_listener_region_add(MemoryListener *li=
stener,
     VFIOHostDMAWindow *hostwin;
     bool hostwin_found;

+    if (!section->mr->ram_device)
+        return;
+
     if (vfio_listener_skipped_section(section)) {
         trace_vfio_listener_region_add_skip(
                 section->offset_within_address_space,

