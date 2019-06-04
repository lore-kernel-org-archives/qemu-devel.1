Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B171C28CC6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2F220843
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="izbCG2Tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2F220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54748 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYC03-00078X-6Y
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:09:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thanos.makatos@nutanix.com>) id 1hYBz8-0006hA-Qw
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thanos.makatos@nutanix.com>) id 1hYBz7-0004UL-R5
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:08:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:36486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thanos.makatos@nutanix.com>)
	id 1hYBz7-0004JY-E8
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:08:25 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x54Ft8WX002250; Tue, 4 Jun 2019 09:08:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
	h=from : to : cc :
	subject : date : message-id : references : in-reply-to : content-type :
	content-transfer-encoding : mime-version; s=proofpoint20171006;
	bh=TQOhbG3FNjIs/OxBupjb9adLoWhnS79ahDFs0qiuHK4=;
	b=izbCG2TxObjlaAY+nSQr7bFR917iRiffKVdznn6Z4vrsMqGZUit9oy4Z3ckIj5BBWevy
	y8EtcdbHz6vqG4A4XQSfZLjAtkCgnewk2fXDRNr9sD3MRzzWC8dj6+eEPJpysEMY/D4Z
	pZN3rfOdMECpAJrxTIxye4dEWCyZauY+Tbft8zMx14mPf7ZxJFyMRAbSK6pH54fH1EBp
	b5fb6WV6RoG0gkEhzKhG36mZMrDKdhx5Oh4sd9W4kD5btDPiJWiX7VYX9ngnAQjZf5NE
	gtArpiK3XIKMEi5ki+lKJTGxp9GDLFTmXaBjq77TdcAVfeQV5OEtdorQ82kBfEs72SOa
	SQ== 
Received: from nam03-by2-obe.outbound.protection.outlook.com
	(mail-by2nam03lp2058.outbound.protection.outlook.com [104.47.42.58])
	by mx0a-002c1b01.pphosted.com with ESMTP id 2swge3s34v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Tue, 04 Jun 2019 09:08:14 -0700
Received: from MN2PR02MB6205.namprd02.prod.outlook.com (52.132.174.26) by
	MN2PR02MB6366.namprd02.prod.outlook.com (52.132.175.151) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Tue, 4 Jun 2019 16:08:13 +0000
Received: from MN2PR02MB6205.namprd02.prod.outlook.com
	([fe80::25d5:60b3:a680:7ebd]) by
	MN2PR02MB6205.namprd02.prod.outlook.com
	([fe80::25d5:60b3:a680:7ebd%3]) with mapi id 15.20.1943.018;
	Tue, 4 Jun 2019 16:08:13 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Alex Williamson <alex.williamson@redhat.com>
Thread-Topic: [Qemu-devel] QEMU tries to register to VFIO memory that is not
	RAM
Thread-Index: AdUXtUBrTZM56mQoR86m4RxpHSXlmQACSDQAAAGm+pAAAIfRAADKIYpQ
Date: Tue, 4 Jun 2019 16:08:13 +0000
Message-ID: <MN2PR02MB6205917DCA53968D8F50D27E8B150@MN2PR02MB6205.namprd02.prod.outlook.com>
References: <MN2PR02MB62053CE40CA6B4A97B32FA048B190@MN2PR02MB6205.namprd02.prod.outlook.com>
	<20190531083732.37ecbb1e@x1.home>
	<MN2PR02MB620549D68EB53487C6FCF51F8B190@MN2PR02MB6205.namprd02.prod.outlook.com>
	<20190531094002.29030716@x1.home>
In-Reply-To: <20190531094002.29030716@x1.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0bda7ac-39a1-4ef0-9b00-08d6e906d8b4
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:MN2PR02MB6366; 
x-ms-traffictypediagnostic: MN2PR02MB6366:
x-proofpoint-crosstenant: true
x-microsoft-antispam-prvs: <MN2PR02MB63664F692C7CE9D2BB57D15D8B150@MN2PR02MB6366.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39860400002)(366004)(376002)(396003)(346002)(136003)(199004)(189003)(6916009)(53936002)(476003)(25786009)(6116002)(11346002)(102836004)(44832011)(446003)(5660300002)(66946007)(76116006)(76176011)(3846002)(6506007)(486006)(86362001)(7696005)(316002)(99286004)(81166006)(66476007)(81156014)(66446008)(26005)(66556008)(54906003)(7736002)(74316002)(8936002)(8676002)(64756008)(73956011)(305945005)(2906002)(186003)(229853002)(68736007)(52536014)(478600001)(4326008)(66066001)(14454004)(9686003)(256004)(33656002)(6246003)(71190400001)(6436002)(107886003)(55016002)(71200400001)(64030200001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB6366;
	H:MN2PR02MB6205.namprd02.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8VrTK74pf0g+/sIyye5Gk0Jv1Nk7MH1rBfhIcmffJ6QpDCY0kFn8dWeFWCVeRC93ojugVquhSX1t/LKPtSUxdVgEUL3K2CWI0l4ywY2iYeM79x+ZEYTH1cyo4PDRHuG2ZICm5JeVvPQfTnlOckowpugyPENa1xb2U7B1bF9w9jnmXOICG7C2u2tMpWL3n3OSZZpK90gS0G9mjjXFjTkjNP1pdHESGoFeZBNFwQ1pbJAndXUmSyT0npc7ULQrDVQjWIfm3J1VqXbQsL3IS899touKWLvPmKLzhsoNfN1DZdFSaHxweuf/JPdW2SSCIh7o4eMsLVtH0QW0RqRnXZlu2wRK+hAJu62hGVY2TaPioQhezCWl/ZiNgyin/JHAzSKCEwIkzTpd60usVPhEPgU1qu+BwL/MQohxb6irJYyQBnU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bda7ac-39a1-4ef0-9b00-08d6e906d8b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 16:08:13.3444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thanos.makatos@nutanix.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6366
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-06-04_10:, , signatures=0
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

> > Indeed. Could we decide whether or not to register an address space wit=
h
> > VFIO in a more intelligent manner? E.g. the following simplistic patch =
solves
> > our problem:
> >
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index 4374cc6176..d9d3b1277a 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -430,6 +430,9 @@ static void
> vfio_listener_region_add(MemoryListener *listener,
> >      VFIOHostDMAWindow *hostwin;
> >      bool hostwin_found;
> >
> > +    if (!section->mr->ram_device)
> > +        return;
> > +
>=20
> Nope, this would prevent IOMMU mapping of assigned device MMIO
> regions
> which would prevent peer-to-peer DMA between assigned devices.  Thanks,

Understood.

Is there a strong reason why QEMU allocates memory for these address spaces=
 without MAP_SHARED? In our use case it would solve our problem if we could=
 make QEMU use MAP_SHARED. I understand that this isn't strictly correct, s=
o would it be acceptable to enable this behavior with a command-line option=
 or an #ifdef?

