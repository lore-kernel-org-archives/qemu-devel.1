Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED81AC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB91C26979
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="cbnu9o1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB91C26979
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43659 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWhkm-0003q8-0i
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 09:39:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thanos.makatos@nutanix.com>) id 1hWhj9-0002Ps-DE
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thanos.makatos@nutanix.com>) id 1hWheG-0003aL-A3
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:32:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:40022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thanos.makatos@nutanix.com>)
	id 1hWheF-0003Rk-AC
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:32:44 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4VDOo0V012959
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:32:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
	h=from : to : cc :
	subject : date : message-id : content-type : content-transfer-encoding
	: mime-version; s=proofpoint20171006;
	bh=sAkoea4q13g3EzEOpxJY/TRD7JgIcH+BkWYIVcjd8DI=;
	b=cbnu9o1SR6NQSCeLhVSkDI44VrpvQvtLhwcSPdGsHZkXGxaUVQZJWBQXvlpSShnp3e6F
	5zM0u/bl6PR0mI0h6A1yrHwWdVxQy2jYGOWYMfTX4AlIZCRfJ+ZoAhIFd3DbzdnNPbx/
	XTIVDkrNTjAcLUgUzhXfi8FoXa3q64Ss0o0mMncwbtgt40O7QxXVuUXk/xEhcBXDtP4A
	eUzSOffmZ1GFMN1CFCb/WivJfNRKf5ul1vTlzf8pxeLVERlBXgY64vFXVaAcgFSw8tp4
	uZrxaRjv9WsLRY4LTt0M2+IcGc+3W+GlycTwaKWnCQAw/eA5NY0XHTiv91/2dN/GkPuP
	ug== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com
	(mail-bl2nam02lp2056.outbound.protection.outlook.com [104.47.38.56])
	by mx0b-002c1b01.pphosted.com with ESMTP id 2ssd3twbt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:32:31 -0700
Received: from MN2PR02MB6205.namprd02.prod.outlook.com (52.132.174.26) by
	MN2PR02MB6464.namprd02.prod.outlook.com (52.132.175.221) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.18; Fri, 31 May 2019 13:32:29 +0000
Received: from MN2PR02MB6205.namprd02.prod.outlook.com
	([fe80::25d5:60b3:a680:7ebd]) by
	MN2PR02MB6205.namprd02.prod.outlook.com
	([fe80::25d5:60b3:a680:7ebd%3]) with mapi id 15.20.1922.021;
	Fri, 31 May 2019 13:32:29 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: QEMU tries to register to VFIO memory that is not RAM
Thread-Index: AdUXtUBrTZM56mQoR86m4RxpHSXlmQ==
Date: Fri, 31 May 2019 13:32:29 +0000
Message-ID: <MN2PR02MB62053CE40CA6B4A97B32FA048B190@MN2PR02MB6205.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2fa6641-b41d-452f-ae1d-08d6e5cc6dde
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:MN2PR02MB6464; 
x-ms-traffictypediagnostic: MN2PR02MB6464:
x-proofpoint-crosstenant: true
x-microsoft-antispam-prvs: <MN2PR02MB6464F64D40AA1F8CA9A6D5458B190@MN2PR02MB6464.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(39860400002)(396003)(346002)(376002)(136003)(189003)(199004)(33656002)(8676002)(486006)(5660300002)(3846002)(6116002)(68736007)(81156014)(81166006)(186003)(66066001)(107886003)(316002)(99286004)(2501003)(54906003)(476003)(6436002)(8936002)(6916009)(305945005)(14444005)(74316002)(6506007)(256004)(7696005)(53936002)(55016002)(558084003)(9686003)(5640700003)(7736002)(76116006)(52536014)(64756008)(71200400001)(66446008)(71190400001)(26005)(44832011)(25786009)(86362001)(4326008)(2906002)(14454004)(66476007)(73956011)(478600001)(66556008)(66946007)(2351001)(102836004)(64030200001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB6464;
	H:MN2PR02MB6205.namprd02.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z8oMsqKaidcEIJKXjGZ/5pEQlIMp6SLVUd6eVkfhMTPnTavQ9AI/+1gFM3YdVPK9ncguljKb1dXW5wNm4A3KTUYPVIISUjMuWRnplBcG4yLegIEBfQ0nCOinCFhScoao0u8/FZAeodNp9zEGPsbjcPyEXI0bJOJO4sriHMSTUxM3DNlIyXiwCHaeX1IiBGD576w3Z4QdCBKusDoO19Sy9Ok2l/eUyhApuzAHyObIBeg2qztgOz1YU9His77RPeufqMMBgV7Anp0xM4FzjRty79GZioAh5j0D7Nia2RqWqyb0v6I0+7qSsM/dh3Dm7n1XroPGibQ7JYge98Uy73GDJFbEanAiFHFAxk9IAJYedJPOSYD7lG/4u88BtzAx7WuFMJrRM23XI/7ZrH2sCxTZsHGm+qLNtv0rFX/dL+fLCgs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fa6641-b41d-452f-ae1d-08d6e5cc6dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 13:32:29.7843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thanos.makatos@nutanix.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6464
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-31_08:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.155.12
Subject: [Qemu-devel] QEMU tries to register to VFIO memory that is not RAM
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
Cc: Swapnil Ingle <swapnil.ingle@nutanix.com>,
	Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When configuring device pass-through via VFIO to a VM, I noticed that QEMU =
tries to register (DMA_MAP) all memory regions of a guest (not only RAM). T=
hat includes firmware regions like "pc.rom". Would a physical device ever n=
eed access to those? Am I missing something?

