Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F9BC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712B82080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="HAXxznB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712B82080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyeHg-0004a1-LS
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iyeGy-0003bh-E6
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iyeGw-0002tu-0v
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:08:27 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:31978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iyeGv-0002sH-R2
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:08:25 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 013G4Bnp016250; Mon, 3 Feb 2020 08:08:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=lvmCNF/1hw2ribxFadvRCRQNpi/J8hQoOmAxjc+bmdw=;
 b=HAXxznB4P1baBrPVJ2pnfKMemDY6kyrhlHVYpgRz4vb1AjNTKlDje0j0Xe0CTn5ph2Ee
 3PuCyZeijOG5RlKut2tvT4zGK/GPv6pI6A2obAKBneOqKV9ljXBwn6Mi3LGgZBvSaiCN
 iVO5xgPabGrtn8JvOw0kBdflWBHCn7wHS9tOuvsK7poMwmMIshJOZhi9aBHx+382mp40
 U+OaDTB/81lJ0uyhCbAur2EfLdbpY8HJjyEzN4Uhu75M4cqUnK7riWTJmk8bAz1tmvpx
 0R6XfnZ8NNxIr+HqIdjWlO+63SUY1ASj6kXYKQhWDyCLujvxxkg+gx7x67FvWIyay2n2 AQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2xx3ejsy09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2020 08:08:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQaTTL7JZAlZ7HjG4X8K3c7VIrwAhfEDrW8ktqtb13uSBS11qya/xHMESu2O9YocxBs2r5uQaoxH57ZDNyQuSjI2m6txBQ4H1DYiLAmBHbs0+E+rI+DT5ffhftZ2icyjQIlGS5CNBJW+9Pb8KyQSF191rNUwbxYIKwybcC5yFEBj0QAso59Wav7tNBknrrCekvza0zuH82urUUjdc5+qtElHy1LpaxXpPn5nVEeYlJ9VAo5j9V24bSZfkZgSrNpYHOH1m1ajwUNVFCLvgI4DQ+oCxQLtHNTdoa2TM4oCl3ZnWA0Q/tIiN+uw0uAfjJq4Eu8siKJ/CVFTrIfliyLitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvmCNF/1hw2ribxFadvRCRQNpi/J8hQoOmAxjc+bmdw=;
 b=Z0u9ngPHSvs/r/196ph0D1y2PvR+0vGMfIj9QAfzp+r2EKl6/m1tQh90ksN7bxSY4NflJkJUO6EAPdyYb8bLnFuFj+Cfd7fx53vftKuQmicl+iHLAQcon0o/LgaD7RQsVsr5DQRNIjXHaLw5+0wUoCJVS3YQZ8jTFycMxsar94/8qdysC70MAyzom9kQ1xvwxixt6YZ6tDPgV0Ya0bvfXbGYgtRAUJ1yQN4TFjo0Ksk5HhrGG8PFyPNV/xsW4zObwAX18iVYx4RJiBNaiQNm6RY74L4H6t5cfhQh3xlpBzdvoNOq3Fpunr6P9I5Kd1sEHFeUu7yX0+OYXcVoe5rgFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB3295.namprd02.prod.outlook.com (10.164.133.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 16:08:21 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b%6]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 16:08:21 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 0/4] Improve default object property_add uint helpers
Thread-Topic: [PATCH 0/4] Improve default object property_add uint helpers
Thread-Index: AQHV2qpB4YOPAuNSFkKomvr5MQ1voKgJoviA
Date: Mon, 3 Feb 2020 16:08:21 +0000
Message-ID: <22DFA157-0F41-4657-A165-D625210B87A7@nutanix.com>
References: <20200203155412.7706-1-felipe@nutanix.com>
In-Reply-To: <20200203155412.7706-1-felipe@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6674fb0c-3239-4d7f-ccb3-08d7a8c34a37
x-ms-traffictypediagnostic: MWHPR02MB3295:
x-microsoft-antispam-prvs: <MWHPR02MB32958E72EBE4ADFBDCFA7A30D7000@MWHPR02MB3295.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(189003)(199004)(53546011)(6512007)(6506007)(6486002)(316002)(6916009)(8676002)(26005)(186003)(4326008)(36756003)(478600001)(33656002)(2906002)(54906003)(81156014)(8936002)(81166006)(966005)(86362001)(66946007)(76116006)(71200400001)(91956017)(66446008)(66556008)(66476007)(5660300002)(64756008)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB3295;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C9NLMxSbUW4lnP49ILoG8ls1/o6raUCCwYgN3r7BWWrK/UbtGHRM9WltzpcQOTjzDWjB5b3/U0ssLkH3NDLs2r22B1hGIJ+wrqZgHYw/6bzt3+9y2F4aMuPd4LEGjD4P3WXK1hUyPhjA4bkR22uXPfrzA18rVkAtk3vFr8q4Id1RbuS2BJITUDmucaq6JHEJYNC5GPMQQLxmu1T9Asy8JToyVOOlT9EB3si0fCW+QoT5KTxdQMNbz8urbMCbeWS9m9nQ0qVccO+Iyyda45tePXfV6NhGDZoWnYoLZU0kH9PTOBmdWbdn3aXoVMTBHJSGX+5CN0rxplBR5wIS8Q60KWd86qtlCKOi2CtqZ1qkxhTbnAKfZmmr0CmZq2XXGM4v9RnVYGdVx+YQhxFv5x8nxIkb4WYk7ZHOlpe+9jXKM+d/paTOFbSjpJev1dd6/6qRwSCbSt5ON/ZW+VhwX0HBH2vIO/+pyJ6MMoEtT5P4cb7g3VbUoc8l7OkktxomYpTB5zQjBOvJlY6LSbCcfvuNEA==
x-ms-exchange-antispam-messagedata: 7AiDE31UQhmzJUS1ZGfoPo33QPvgomBzgq72Fa4volE3Md6tp4LoxSZBv+Bzj1XqJGSO7Drc5m0G/KF1jXnu+qffXUNe8Ebb3glcRwelnFej9wbFwrHSbPxOqNlkHhBNsltbz7pCAzym5Jv43JVyAA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17F9772454BAA141839A5885DBAE6428@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6674fb0c-3239-4d7f-ccb3-08d7a8c34a37
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 16:08:21.2165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Wm5laDvxU4PuUlJMFs4zvziPsS+qGQm1XIFBR+6lcu3UMqIoWlrhz25bXqO33utPXEjxy4xs+u8DcY1UA+duL9dCCTDMwkoJDoraKZqc3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3295
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-03_05:2020-02-02,
 2020-02-03 signatures=0
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Oops, I completely forgot to add a "v5" on the subject line.

(The changelog is there.)

Let me know if I should resend.

F.

> On Feb 3, 2020, at 3:54 PM, Felipe Franciosi <felipe@nutanix.com> wrote:
>=20
> This improves the family of object_property_add_uintXX_ptr helpers by ena=
bling
> a default getter/setter only when desired. To prevent an API behavioural =
change
> (from clients that already used these helpers and did not want a setter),=
 we
> add a OBJ_PROP_FLAG_READ flag that allow clients to only have a getter. P=
atch 1
> enhances the API and modify current users.
>=20
> While modifying the clients of the API, a couple of improvement opportuni=
ties
> were observed in ich9. These were added in separate patches (2 and 3).
>=20
> Patch 4 cleans up a lot of existing code by moving various objects to the
> enhanced API. Previously, those objects had their own getters/setters tha=
t only
> updated the values without further checks. Some of them actually lacked a=
 check
> for setting overflows, which could have resulted in undesired values bein=
g set.
> The new default setters include a check for that, not updating the values=
 in
> case of errors (and propagating them). If they did not provide an error
> pointer, then that behaviour was maintained.
>=20
> Felipe Franciosi (4):
>  qom/object: enable setter for uint types
>  ich9: fix getter type for sci_int property
>  ich9: Simplify ich9_lpc_initfn
>  qom/object: Use common get/set uint helpers
>=20
> hw/acpi/ich9.c       |  99 ++------------------
> hw/acpi/pcihp.c      |   7 +-
> hw/acpi/piix4.c      |  12 +--
> hw/isa/lpc_ich9.c    |  27 ++----
> hw/misc/edu.c        |  13 +--
> hw/pci-host/q35.c    |  14 +--
> hw/ppc/spapr.c       |  18 +---
> hw/ppc/spapr_drc.c   |   3 +-
> include/qom/object.h |  48 ++++++++--
> memory.c             |  15 +--
> qom/object.c         | 214 ++++++++++++++++++++++++++++++++++++++-----
> target/arm/cpu.c     |  22 +----
> target/i386/sev.c    | 106 ++-------------------
> ui/console.c         |   4 +-
> 14 files changed, 283 insertions(+), 319 deletions(-)
>=20
> --=20
> 2.20.1
>=20
> Changelog:
> v1->v2:
> - Update sci_int directly instead of using stack variable
> - Defining an enhanced ObjectPropertyFlags instead of just 'readonly'
> - Erroring out directly (instead of using gotos) on default setters
> - Retaining lack of errp passing when it wasn't there
> v2->v3:
> - Rename flags _RD to _READ and _WR to _WRITE
> - Add a convenience _READWRITE flag
> - Drop the usage of UL in the bit flag definitions
> v3->v4:
> - Drop changes to hw/vfio/pci-quirks.c
> v4->v5:
> - Rebase on latest master
> - Available here: https://github.com/franciozzy/qemu/tree/autosetters


