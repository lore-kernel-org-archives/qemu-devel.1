Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5902C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 04:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B27521973
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 04:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="U9pYptn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B27521973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQ19P-0006UH-JT
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 00:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jQ18W-0005zz-KO
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 00:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jQ18S-00024l-3C
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 00:00:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:18584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jQ18R-00021W-Cz
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 00:00:47 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03J40CF2014765; Sat, 18 Apr 2020 21:00:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=rghC2poQvs4dWrqS4/e614iorXOHjGoVEwTyAq7MGtw=;
 b=U9pYptn9HYpwOYTfePfTOpSHJB5F/EzUvbykyJTA1eqUILktQKrRK0af47BQh/U8gW57
 d64h2jGmNpzu0h4sl6Ka1EaDfUB3ZQBXWAtvf3I9EVAEVhGksoIrWfjGSGBtNqY9HLj2
 gdPm58Fb64LJJO+26GAsmKxUzXJkVOHiHTV7qlplhNhUiS30axrnQjpzTLmUgESQ/75z
 n+27Wqql8V0rMX5Oq6OdlC8nIWCLo3eyT1W6Eu7ZMa3VddB41PiGgvfGo3VPos3Zr1th
 ugPEL55kq1Lyn/wFv0Dh4XdUwn6GlAMkyzVknBPWurEY7rwLawkgN7poXZsUPLTfP0LB 5Q== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30fy39s30h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Apr 2020 21:00:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2vRATPkfZcEZStflrjO9tk9GFn/bwFbCDlG4dLlMjKsV3Nd/8cLkVSt0I5e1orS1offezFIGHAS4xaUYxGYNfWVR5JBNiH3MeOSA8bf4prM12tWd1CtjTnt2gjn4UKjuCk+YzqqEExzuwp9r5JQHMAEtVoAK+oZz8wK0Lu5Kbyr15TZWU3+2kFRUtFHJa/s14g1FUiPJnhHhN8g8K3ei8u/2YTjkUboWNm8tLk5/X+1ciR0uzM7Ud6pZfPAsy88srsWWciRmPTouzYvYcVF7lUyRGYxuXB8wc6FZ/ifGO4YWB9E5tIxDNMEeoZdQLRRjl0H3eDT/xMXrcg8QtxVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rghC2poQvs4dWrqS4/e614iorXOHjGoVEwTyAq7MGtw=;
 b=mY27X9FPOQB7ZfG/XOqK+M9rUdG5Tv0i22nfmmwY60+bVHqcOtmLodoMcHyNSiY+io7ZhZNRA+i8zN6HE2e5iz1Kvw9ojIL+djmFdd1jYwEYsu11CEWQtVLisk7/HEmfPtUXoBfP5H8fNw6WO51h5CP6ul1QA++5r+M2F9seGa7L0vNcMl4Ffujj6bBRdch0NICyZyBTQQYdj3lOr4MjqDC1hHUbjYSuAVpLdGbpq3yeyj6Py0Fc/ynIVsIaQ5Iq6DQuAM6ofj3Z2pmIUPbELw68JJC1AnO7XR87xDp0AWJc2CzuSgnqGhswUzOr4zI8GqTkXtGtY66MEPjWhPQKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB7006.namprd02.prod.outlook.com (2603:10b6:208:203::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Sun, 19 Apr
 2020 04:00:41 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2921.027; Sun, 19 Apr 2020
 04:00:41 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Index: AQHWFMrLeCs/JzKNrUaCDY3Nn1YJmqh9b9kAgAACaICAAAksAIAAB0KAgABZuwCAAFwZAIAAnSIAgAD+6oA=
Date: Sun, 19 Apr 2020 04:00:41 +0000
Message-ID: <A02464B1-9204-4116-B18A-BE9DA130EC77@nutanix.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <56B4E13C-DCAA-4E40-A821-6C043844A253@nutanix.com>
 <0e15c8e7-7b32-985e-c182-2868273a1bd7@redhat.com>
 <AFEDBC1F-8536-4354-9C5E-9829C258B6E3@nutanix.com>
 <67ca69f6-8d6b-8be0-72f2-b30a67edf200@gmail.com>
In-Reply-To: <67ca69f6-8d6b-8be0-72f2-b30a67edf200@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [115.96.105.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20999ef2-15c6-483a-b477-08d7e4163a59
x-ms-traffictypediagnostic: MN2PR02MB7006:
x-microsoft-antispam-prvs: <MN2PR02MB7006089C97A82428F7448411F1D70@MN2PR02MB7006.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0378F1E47A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(39850400004)(346002)(396003)(376002)(136003)(366004)(6512007)(86362001)(36756003)(6486002)(91956017)(6916009)(4326008)(316002)(478600001)(186003)(54906003)(7416002)(966005)(8936002)(8676002)(81156014)(71200400001)(53546011)(6506007)(66476007)(66556008)(64756008)(26005)(76116006)(66946007)(33656002)(44832011)(5660300002)(66446008)(2616005)(2906002);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vNLsf8kwVGyw7WuI/W2Y3nacvj5Y35D3/ZTYkZfy7c//z+f/145OxFDaXwkztTHt1vGAljgoyJjgJsblIcqyJaBmZ33/MLEmCvHGyGePV1qW70PlAzywYu++ae3bZyAE0wNQn6R7CvfEggT8tcZ24zqmNXFuH6p9qYmfCZ1vlUXN/pAFW8EUd3BMTfIz+gTdEzeSVGkZ+mO0Sa2o3qcrwggn/+zC1mz70A1sJLogl2/SGYp1UEjgB8oCPoTfQ4oxhwZzzeLHVZb35oLY7/GbRl9tmxManoFE0v3aysNABYcc4pNkJMDSnShgfmv4kibdeQane7vVi8kSFwycak6CtnRr/cgPd/ToAt9CKKZsTf7yDKYSR+djRnebHui7vaxfD/vUipYd2Wbcka1peFIFEAgXn3IlEkkKac9l9cVTjOdKrEKNUPCfQg/ycNp0R+/zJ4tiQkSCMp/x8lcYtd8RYLz+6z8mxAqUjuqBpF00OGNKV3Sa2KUldvoX7RwBqAfRRZNyOli6+yBkXpEKcRrqRg==
x-ms-exchange-antispam-messagedata: ycV+pKs79CoYLSKIx47hFyRNx15WN+JElC4QlDHJod1eeQnNAMChXeSytepfzhltg75vYed6JFgpV8PLKGIsAX6m91CvO6RglzOFxLN0PdKMvpWM0r+2pKT6xIlKnor+CFMl3krJpXMIjyZM80vLHQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EAC81F1240DE9479AE280C945F2BAAD@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20999ef2-15c6-483a-b477-08d7e4163a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2020 04:00:41.2607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opC4aD6pJazbmH9MSmYHGUpI8TMe7d1ZjsjIck9pWdOlvfkGPs7D2xCckZ3/v933xQDgiuEpzBJ09yMJGDyjbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7006
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-18_10:2020-04-17,
 2020-04-18 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=ani.sinha@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: Linux 3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Ani Sinha <ani@anirban.org>,
 Laine Stump <laine@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gQXByIDE4LCAyMDIwLCBhdCA2OjE4IFBNLCBNYXJjZWwgQXBmZWxiYXVtIDxtYXJj
ZWwuYXBmZWxiYXVtQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBBbmksDQo+IA0KPiBPbiA0
LzE4LzIwIDY6MjUgQU0sIEFuaSBTaW5oYSB3cm90ZToNCj4+ICtKdWxpYSB3aG8gaW1wbGVtZW50
ZWQgaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19w
YXRjaHdvcmsua2VybmVsLm9yZ19wYXRjaF8xMTM4ODg4MV8mZD1Ed0lDYVEmYz1zODgzR3BVQ09D
aEtPSGlvY1l0R2NnJnI9SUlVeEl5UndHNFJHeTU3eTJudk1OWWNEa3FXLU5Ib3paMlIzOFZZY2c1
VSZtPWNwakhvUWV5bHRaZlJXYTdhNWFVdXhNXzUteDZfWVpaQ0diNFVpeGh2aUUmcz1iRWM4RnNU
aHFJYTlXMXB6eWgzVnVPQ0lDd1RXd1ppa0VDRDE5TU9tdHRnJmU9IA0KPj4gDQo+Pj4gT24gQXBy
IDE4LCAyMDIwLCBhdCAzOjI2IEFNLCBMYWluZSBTdHVtcCA8bGFpbmVAcmVkaGF0LmNvbT4gd3Jv
dGU6DQo+Pj4gDQo+Pj4gT24gNC8xNy8yMCAxMjozNSBQTSwgQW5pIFNpbmhhIHdyb3RlOg0KPj4+
PiArTGFpbmUNCj4+Pj4+IE9uIEFwciAxNywgMjAyMCwgYXQgOTozOSBQTSwgTWljaGFlbCBTLiBU
c2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IFByb2JsZW0gaXMs
IEkgdGhpbmsgdGhpcyBpcyBub3Qgc29tZXRoaW5nIHdlIGNhbiBzdXBwb3J0IHdpdGggcGNpZSBv
ciBzaHBjLg0KPj4+Pj4gSSdtIHJlbHVjdGFudCB0byBhZGQgZmVhdHVyZXMgdGhhdCBvbmx5IEFD
UEkgY2FuIHN1cHBvcnQsDQo+Pj4+PiB3ZSBhcmUgdHJ5aW5nIHRvIHBoYXNlIHRoYXQgb3V0Lg0K
Pj4+PiBIbW0uIEkgc2VlLiBXZSB1c2UgY29udmVudGlvbmFsIFBDSSBhbmQgaGVuY2Ugd2FzIGxv
b2tpbmcgZm9yIHByb3ZpZGluZyB0aGlzIGZlYXR1cmUgZm9yIGNvbnZlbnRpb25hbCBQQ0kgb25s
eS4gTGFpbmUgbWlnaHQgYmUgYWJsZSB0byB0aHJvdyBzb21lIGxpZ2h0cyBhcyB0byBmZWFzaWJp
bGl0eSBvZiB0aGUgaW4gUENJRSB3b3JsZC4NCj4+PiBTb3JyeSwgbXkga25vd2xlZGdlIGRvZXNu
J3QgZ28gdGhhdCBsb3cuIElmIHRoZXJlJ3MgYSBxZW11IG9wdGlvbiBJIGNhbiBleHBvc2UgaXQg
aW4gbGlidmlydCwgYnV0IGFtIGJ5IG5vIG1lYW5zIGFuIGV4cGVydCBvZiBxZW11IGludGVybmFs
cyBvciB0aGUgcGNpL3BjaWUgc3BlY3MgOi0pDQo+Pj4gDQo+Pj4gKEJUVywgSSB0aGluayBpbiB0
aGUgcGFzdCBwZW9wbGUgaGF2ZSBwcmV2ZW50ZWQgZW5hYmxpbmcgaG90LXVucGx1ZyBieSB1bnBy
aXZpbGVnZWQgdXNlcnMgaW4gV2luZG93cyB3aXRoIHNvbWUgc29ydCBvZiBhICJzeXN0ZW0gcG9s
aWN5IiBpbiBXaW5kb3dzLiAod2hhdGV2ZXIgdGhhdCBpcyAtIEkgZG9uJ3QgdXNlIFdpbmRvd3Ms
IGFuZCBoYXZlIGp1c3QgaGVhcmQgdGhpcyBmcm9tIG90aGVycyB3aGVuIGRpc2N1c3NpbmcgdGhl
IHByb2JsZW0pLg0KPj4+IA0KPiANCj4gQSBQQ0llIFJvb3QgUG9ydCBvciBhIFBDSSBzbG90IGNh
biBvciBjYW5ub3Qgc3VwcG9ydCBob3QtcGx1Z2dpbmcuIEFueXRoaW5nIGluIHRoZSBtaWRkbGUg
Y2FuJ3QgYmUgZG9uZSBhdCBQQ0llL1BDSSBsZXZlbCAoYXMgZmFyIGFzIEkga25vdykuDQo+IEkg
dGhpbmsgdGhlIGFuc3dlciBjYW4gYmUgYXQgdGhlIG1vZGVsbGluZyBsZXZlbC4gVXNlIG5vbiBo
b3QtcGx1Z2dhYmxlIHNsb3RzIChvciBQQ0llIFJvb3QgUG9ydHMgd2l0aG91dCBob3QtcGx1ZyBz
dXBwb3J0KSBmb3IgdGhlIGRldmljZXMNCj4geW91IGRvbid0IHdhbnQgaG90LXVucGx1Z2dlZCwg
bGVhdmUgYW4gZW1wdHkgUENJIEJyaWRnZSAob3Igc29tZSBQQ0llIFJvb3QgUG9ydHMgd2l0aCBo
b3QtcGx1ZyBzdXBwb3J0KSB0byBiZSBhYmxlIHRvIGhvdC1wbHVnIGRldmljZXMuDQoNClllcywg
dGhpcyBpcyBleGFjdGx5IHRoZSBtb2RlbGluZyBJIHdhcyBnb2luZyB3aXRoIHRvIHByZXZlbnQg
dXNlcnMgZnJvbSB3aXRoaW4gV2luZG93cyBndWVzdHMgdG8gaG90LXVucGx1ZyBhIGRldmljZS4g
VGhlbiBJIHJlYWxpemVkIHRoYXQgaWYgd2UgcGx1ZyBpbiBhIGRldmljZSBpbnRvIGEgc2xvdCB3
aGVyZSBob3QgcGx1Z2dpbmcgaXMgZGlzYWJsZWQgd2l0aCBhbiBpbnRlbnRpb24gdG8gZGlzYWJs
ZSBob3QgdW5wbHVnZ2luZywgd2UgY2Fu4oCZdCBldmVuIGhvdCBwbHVnIGEgZGV2aWNlIGludG8g
dGhhdCBzbG90LiBXaGVuIHdlIHBsdWcgaW4gYSBkZXZpY2UgaW50byBhIHNsb3Qgd2hlcmUgaG90
IHBsdWdnaW5nIGlzIGVuYWJsZWQsIGJvdGggcGx1Z2dpbmcgaW4gYW5kIHVucGx1Z2dpbmcgaXMg
cG9zc2libGUuIEluIG90aGVyIHdvcmRzLCB0aGUgYmVoYXZpb3IgaXMgc3ltbWV0cmljIGluIHRl
cm1zIG9mIGJvdGggcGx1Z2dpbmcgYW5kIHVucGx1Z2dpbmcuIEhlbmNlIGZvciBjb252ZW50aW9u
YWwgUENJIEkgY29va2VkIHVwIHRoaXMgcGF0Y2ggd2hlcmUgSSBkaXNhYmxlIOKAnF9FSjDigJ0g
QUNQSSBmdW5jdGlvbnMgZnJvbSBwY2ktcGNpIGJyaWRnZSB0byBvcmRlciB0byBlbmFibGUgaG90
IHBsdWdnaW5nIGJ1dCBwcmV2ZW50IGhvdCB1bnBsdWdnaW5nIGludG8gdGhlIHNsb3RzIG9mIHRo
YXQgYnJpZGdlLiBJIHRlc3RlZCB0aGlzIG9uIFdpbmRvd3MgZ3Vlc3RzIGFuZCBpdCBzZWVtcyB0
byB3b3JrLiBTbyBteSBuZXh0IHF1ZXN0aW9uIGlzLCBmb3IgUENJRSwgaXMgdGhlcmUgc29tZXRo
aW5nIGVxdWl2YWxlbnQgdGhhdCBjYW4gYmUgZG9uZT8gTXkga25vd2xlZGdlIGlzIGxpbWl0ZWQg
aW4gdGhhdCBzcGFjZS4NCg0KdGhhbmtzDQphbmkNCg0K

