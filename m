Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FF1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53D520A8B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Zf337Q6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53D520A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBxm-0007Sv-VX
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jlBwk-0006wu-Kf
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:48:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:52002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jlBwi-0001iR-Fr
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:48:14 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05GDdlMp015605; Tue, 16 Jun 2020 06:47:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=ypyQk8j482ekX4dx6I5PPgRN0beVixXsd/w1lG0bRxo=;
 b=Zf337Q6pCf5RPlB4j2ZcWg9pIF0vp2faMDnNcUBqGNeWyhdig2TXLerFS0Mu91VPv/g+
 CoqApvRiT6RQ7+Fi7Zl2zDw8NI8HH61AbErJFhqLeysH1/jhXw41i/bA4T+4rfX+jRGI
 fr4BX7d23+UT3N44HBr2+gqzwo1XtuvwPkeqcqOqj8f/Vm0zk5ys2OdkwF4DI9oL5Bnt
 Fg8BGuu2JeXjKmBYMXwQtAKa5cKOQo50ilXk8m9w8XQQJBM5LykXCFjdPbS+3yqr1g0S
 SSFMvNnfbCzyr2ncE8dlemSOOKBFOLuOw/RBc03EII8pE2N9FBwolx00RoHVwH+erRFJ qg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-002c1b01.pphosted.com with ESMTP id 31p041ukyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2020 06:47:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdKS4hx6FNWg/MfFFvxX94OFY9/RmRPsGhru/PBVDgZixff7/RztaYG4uXHjhJ1EmJaVF/wKFgTm/H6AoTVSu8QirMUN1krOiLyAbca3pzHwrclI7I1tzDMzKXuO1x2VqhosVc67k9M1W9YsW4aABtTRQOt5wABI4POOipOyg8nBifafIlkFHTzg9HGoLG9a36qLvU7uJM2p4bW0JXGla+a20kaz82zRiOZWVpEixewO3V2IICKnCgMHm3ev+TbUGtgy18wjKhxyHeZc2qUFQWSzbFvT5SxI6eS4tyHOKzrCbO5u8C9Nd7/m2nD1bSsT+L2kODYJBOA2vTtIuhsPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypyQk8j482ekX4dx6I5PPgRN0beVixXsd/w1lG0bRxo=;
 b=gkI/40JW6RTzN4+Kq09rADEljJnP+3lYV1XUNWP8WjmnI0U9XLm8LMUoGEIV78sDHPf04vLceylXXa35LKyHTvTdSPpsy9BcMAG2zddNEU1n79t6VMoaXQsYS6C9H5vPwBX3Pnv0Q0nBHEVXfgz0rXk7kOx4gbk/58/YA3hqvjuQ76RI4CNlpZXdQGqgaeJBhyZbIrclbNNgLPb1Zys8+QvBkW0DEpYFTgf//Uv26Kc0ET0htkN+yWBzN7p4xom9fWTnYzTtQNZGuxzaPOJQU7x0iQ8ZUAIyk/tJFVBQ2Xmi9RcpQog6dNgDYIzL7ZtcpLhnC3cSgbTHWYXlzxOaNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB5997.namprd02.prod.outlook.com (2603:10b6:208:117::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Tue, 16 Jun
 2020 13:47:54 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::317d:683f:b2:fa01]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::317d:683f:b2:fa01%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 13:47:54 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH V3] Rename use_acpi_pci_hotplug to more appropriate
 use_acpi_hotplug_bridge
Thread-Topic: [PATCH V3] Rename use_acpi_pci_hotplug to more appropriate
 use_acpi_hotplug_bridge
Thread-Index: AQHWQ9oY/vhYOtq2AE2Ak/9M4Bsvz6jbOUuAgAAAvICAAAVyAIAAAjiA
Date: Tue, 16 Jun 2020 13:47:54 +0000
Message-ID: <C3E1DE2E-3537-4E35-B505-969FA8234533@nutanix.com>
References: <1592310699-58916-1-git-send-email-ani.sinha@nutanix.com>
 <20200616151735.17a84340@redhat.com>
 <CAARzgwwKwdYW0BK4-W2=q=g3cN4BZfPN6p8QqvgAsqJ7tifHtA@mail.gmail.com>
 <20200616153942.79155fe8@redhat.com>
In-Reply-To: <20200616153942.79155fe8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [115.110.205.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa5459d0-68fc-4d3d-3e74-08d811fbde9e
x-ms-traffictypediagnostic: MN2PR02MB5997:
x-microsoft-antispam-prvs: <MN2PR02MB5997A1CB9600A20EFF0C14ADF19D0@MN2PR02MB5997.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JycsHCeG+BAAE3ZrRTfnzQzDiCl/WoMu7n9tPaO5QfFQGGhE7dUb4sCKh7fxoRBQGhxcQIih+Tl3XqmB/6FGO3fE7Z6wUuni0RdVvsYRswoR/iUdVLKsfrI4syDilVS0tvCO4PspsJuyhizEW3GJmuFjPgYUUBWAEDExJUHM3NfhCOOInr9MOel2eaHS3fMgEHtHVr+dhd0tkabWvBMcfw2X2d1tsUvygLrw80QfX2m9D/fhuDyqABRwfTgifreY/nmlxvJJppSNngKydXFh5hlaO6nLGov8IjRNDGkZLByF9VfXd42vjg1YL0uh2qO38nMPmJu7gRfO2w8rKfST7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(366004)(136003)(39860400002)(346002)(396003)(8936002)(6512007)(8676002)(33656002)(36756003)(91956017)(76116006)(6506007)(53546011)(6916009)(4326008)(6486002)(66556008)(64756008)(66946007)(86362001)(2906002)(66446008)(66476007)(558084003)(54906003)(478600001)(186003)(71200400001)(316002)(5660300002)(26005)(2616005)(44832011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: mcRvOEtJjigDgmFEwEDDpPUGq1ngzCcJjwXTLfpcSXYwKZL8gZvvQJY8sHUpBMtRqFJZPC5Jz1rsogN5wLBwjbk9jNuY0UoZ6Z6sCAkGujfmAPjSNGm4z5wu2sJKal024KeAZdtuEkCLx2U1sinDCr2S2f+x7qEFDQsspJNSW00/R8DARQDVCZEMXa9uyCVx3cayI/EzYateUBIEkFZwcUitTOISwN3HFs79/CS/mhhqB4qOiklN8Z9Stj0fIW6IS1awat7jUr7JCQU90z5X8SFhGYV1yO4bRxxcRFJ6buWx+OcxblyvsyF+RW3j3JUvMTXOT/9O3Jth+X4e2ig97P19B3A4lswws5EjxpuKwHgXsiXsTau5jQBiv3zKGiankUqTWf7CorWjqhmrEO3E23wQxsHl8VLD+Sm+mwKIXE5osAiFGNooeJdePP+Y4X33lzCSAW3hBpLvMDikEJn1NkapG7fI9fX1fUSGtdreu1ZWiKSB4n+PpbydS+0PQiOl
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <451A83A6B7F48B4AB154473CA3BD3FC5@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5459d0-68fc-4d3d-3e74-08d811fbde9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 13:47:54.0522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6xGputKXm3h747YwiCs3qvtR4Y/01ktwyLij1h8/R4c5SpChlfzgplDXWV3ng4nzOo2u4VGb0l2aOB4dX82dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5997
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-16_04:2020-06-16,
 2020-06-16 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=ani.sinha@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 09:48:09
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Ani Sinha <ani@anisinha.ca>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jun 16, 2020, at 7:09 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> I've meant something like:
>=20
> Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
> ---
> vX: - I might be blind and don't see changelog .

Ah right. I was thinking you were referring to diff stat.

I will add changeling next time.

ani


