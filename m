Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFDCC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 10:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A319D2166E
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 10:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="PdM4XBBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A319D2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46710 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSJCm-0000df-NV
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 06:38:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hSJBr-0000ID-GA
	for qemu-devel@nongnu.org; Sun, 19 May 2019 06:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hSJBq-0002rk-2t
	for qemu-devel@nongnu.org; Sun, 19 May 2019 06:37:15 -0400
Received: from mail-eopbgr820101.outbound.protection.outlook.com
	([40.107.82.101]:21093
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hSJBp-0002qw-O8; Sun, 19 May 2019 06:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=6EBCuBHt2MSgrby0GKEs7yBzU5Hj5PrRe7GeL4mxeL0=;
	b=PdM4XBByaKBQo7CaQoTCT+BWMosXP4twdmxV29IJipnhrSteOhy5BKQcEfDvUd2yb0TygwT13WSK09Tsmec35oK96O5l4fm3CIczk38SvJdR11ML2+PQtM6CCywRawUpeXDu0jDbX2nvCsN2XMYA33+tQJNAis5TYBRhok54v84=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1091.namprd22.prod.outlook.com (10.174.90.158) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Sun, 19 May 2019 10:37:06 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8%8]) with mapi id 15.20.1900.020;
	Sun, 19 May 2019 10:37:05 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
	=?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Thread-Topic: [PATCH v2 00/16] hw: Use object_initialize_child for correct
	reference counting
Thread-Index: AQHVBPLEpwIZPqjpZ0yi9E6eCEd9HKZvLbQAgAB8EYCAAqguFw==
Date: Sun, 19 May 2019 10:37:05 +0000
Message-ID: <BN6PR2201MB12515EFFABCEAE4D13409F81C6050@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190507163416.24647-1-philmd@redhat.com>
	<cfd72da5-720a-0684-f3c5-e0ea1360bef3@redhat.com>,
	<20190517175621.GK4189@habkost.net>
In-Reply-To: <20190517175621.GK4189@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c4b4dd9-0f0f-4b23-e430-08d6dc45f030
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1091; 
x-ms-traffictypediagnostic: BN6PR2201MB1091:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BN6PR2201MB1091FF0B4E478D5749DD3954C6050@BN6PR2201MB1091.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 00429279BA
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(346002)(396003)(136003)(39830400003)(189003)(199004)(54164003)(9686003)(71200400001)(102836004)(71190400001)(4326008)(256004)(6306002)(14444005)(6116002)(3846002)(26005)(6246003)(7696005)(446003)(229853002)(55016002)(6436002)(55236004)(6506007)(99286004)(53546011)(25786009)(76176011)(11346002)(186003)(316002)(966005)(476003)(14454004)(486006)(68736007)(33656002)(8676002)(110136005)(478600001)(54906003)(81156014)(81166006)(66476007)(66556008)(64756008)(66446008)(8936002)(7736002)(66946007)(86362001)(73956011)(76116006)(5660300002)(7416002)(53936002)(305945005)(74316002)(2906002)(52536014)(66066001)(66574012);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1091;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zFgg6E16c9cnROIOZIC2+trst7WQehyialv3ZzwQA0ikSndQeUeiwAw1bTRsELgDIYDbVXivbTXw9kXWa+XznXCGEl4QzQH0uB1+NVJ1Ef8urfgtS7J34TozTLGeK7tJtB1BRfXmxIQ+MBS4HyXKsd1VA611EWyS9nlTx/s9BNmRAdNtJRUbrLS0KI4lBOF9kI9o6t37hm+aYdypPAc81hLYDTnKTWMqs0Fut/B7fLZdLN77JueXRXue3efOeBd/64UYi34ALoWnPlV/YO07bx32/q2vLwo/zknHW6Ob1Axiwd2X4be0qTqrtjs1EMlwJEuXWvGBl7JPf6IRCQ/+EyeZfsHgpHOiSWS+LbWGwyZdqhoiOIn6j72MdBYW0RYPL8VBB9eRBSJt6P4eQGS3VVSnexzMBujCGVWPB/X/N28=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4b4dd9-0f0f-4b23-e430-08d6dc45f030
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2019 10:37:05.6551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1091
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.101
Subject: Re: [Qemu-devel] [PATCH v2 00/16] hw: Use object_initialize_child
 for correct reference counting
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S.
	Tsirkin" <mst@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Paul Burton <pburton@wavecomp.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Markus Armbruster <armbru@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	=?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	=?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	"qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> > On 5/7/19 6:34 PM, Philippe Mathieu-Daud=E9 wrote:
> > > Hi,
> > >
> > > This series looks at Eduardo suggestions from [1]
> > > and Thomas commit aff39be0ed97 to replace various
> > > object_initialize + qdev_set_parent_bus calls by
> > > sysbus_init_child_obj().
> >
> > Do you think you can take this series?
> > Else, via which tree it should go?
>
> I was expecting the maintainers of each architecture to apply the
> patches for their areas.  But I'd be glad to merge it through my
> tree if it makes it easier for everybody.
>
> Are the arm, microblaze, mips, and ppc maintainers OK with that?

Hello, Eduardo.

I am OK with two patches applicable to MIPS. Moreover, I am going
to apply them to my pull request scheduled to be sent today. Sorry
if that makes your part more difficult (you will have to skip two
patches from this series). The reason for my urgency is that we in
Wave start regression testing for QEMU 4.1 in MIPS environments, and
we wanted these two patches integrated sooner rather than later.

Thanks to everyone involved!

Aleksandar

________________________________________
From: Eduardo Habkost <ehabkost@redhat.com>
Sent: Friday, May 17, 2019 7:56:21 PM
To: Philippe Mathieu-Daud=E9
Cc: Markus Armbruster; Thomas Huth; qemu-devel@nongnu.org; Peter Maydell; P=
hilippe Mathieu-Daud=E9; qemu-arm@nongnu.org; Aleksandar Markovic; Andrew J=
effery; Peter Chubb; Alistair Francis; C=E9dric Le Goater; Aurelien Jarno; =
David Gibson; Paul Burton; Antony Pavlov; Andrew Baumann; Joel Stanley; Mic=
hael S. Tsirkin; Mark Cave-Ayland; qemu-ppc@nongnu.org; Edgar E. Iglesias; =
Aleksandar Rikalo; Jean-Christophe Dubois
Subject: Re: [PATCH v2 00/16] hw: Use object_initialize_child for correct r=
eference counting

On Fri, May 17, 2019 at 12:32:18PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Eduardo,
>
> On 5/7/19 6:34 PM, Philippe Mathieu-Daud=E9 wrote:
> > Hi,
> >
> > This series looks at Eduardo suggestions from [1]
> > and Thomas commit aff39be0ed97 to replace various
> > object_initialize + qdev_set_parent_bus calls by
> > sysbus_init_child_obj().
>
> Do you think you can take this series?
> Else, via which tree it should go?

I was expecting the maintainers of each architecture to apply the
patches for their areas.  But I'd be glad to merge it through my
tree if it makes it easier for everybody.

Are the arm, microblaze, mips, and ppc maintainers OK with that?

>
> Thanks!
>
> Phil.
>
> >
> > Important comment from Eduardo:
> >
> >   It's possible, but we need a volunteer to review each
> >   hunk because the existing code might be (correctly)
> >   calling object_unref() (either immediately or when
> >   parent is finalized).
> >
> > I tried to split it enough to make the review process
> > easier.
> >
> > Regards,
> >
> > Phil.
> >
> > [*] https://patchwork.ozlabs.org/patch/943333/#1953608
> > v1: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05931.html
> >
> > Philippe Mathieu-Daud=E9 (16):
> >   hw/ppc/pnv: Use object_initialize_child for correct reference countin=
g
> >   hw/misc/macio: Use object_initialize_child for correct ref. counting
> >   hw/virtio: Use object_initialize_child for correct reference counting
> >   hw/arm/bcm2835: Use TYPE_PL011 instead of hardcoded string
> >   hw/arm/bcm2835: Use object_initialize() on PL011State
> >   hw/arm/bcm2835: Use object_initialize_child for correct ref. counting
> >   hw/arm/aspeed: Use object_initialize_child for correct ref. counting
> >   hw/arm: Use object_initialize_child for correct reference counting
> >   hw/mips: Use object_initialize() on MIPSCPSState
> >   hw/mips: Use object_initialize_child for correct reference counting
> >   hw/microblaze/zynqmp: Move the IPI state into the PMUSoC state
> >   hw/microblaze/zynqmp: Let the SoC manage the IPI devices
> >   hw/microblaze/zynqmp: Use object_initialize_child for correct ref.
> >     counting
> >   hw/microblaze/zynqmp: Use object_initialize_child for correct ref.
> >     counting
> >   hw/arm/mps2: Use object_initialize_child for correct reference
> >     counting
> >   hw/intc/nvic: Use object_initialize_child for correct reference
> >     counting

--
Eduardo

