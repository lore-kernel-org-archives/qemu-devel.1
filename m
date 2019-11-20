Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8962C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 05:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928CA2240A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 05:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NMdJfNRU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="TZi7/vvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928CA2240A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXIUJ-0006i8-NL
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 00:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iXIT6-0006BH-RX
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 00:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iXIT0-00041N-60
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 00:23:54 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:37431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iXISw-0003xl-HD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 00:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1574227426; x=1605763426;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VUSfdXwg07QZycv9X/TDdIxhxF+6zkaGuGhTlOljB/Y=;
 b=NMdJfNRUeSyqEbvk0UVWqNu3Hx2ixMPciuMctRiKENEoGHId5EHe1Xel
 zrp0OUW8f/uNlVfRorTl3H3wgUYyucqLQqC47cxyixn0twPlvhcb90G9S
 LkMxWebUAKX538blDDIvByFKki5v8lyF2pT80MCjtIzAH67DPuH8/S2la w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Nov 2019 21:23:43 -0800
IronPort-SDR: TzRhDliOyTDpe2BrELZz7cJ2s64avjuXUxqaYB5pBEgPVDuXTfAo+HLzOy7g20MEvgb+fmGvxx
 ApxzItfr2Vwe1aKM0/0TaJ9Tl+eeZVXxw=
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 19 Nov 2019 21:23:43 -0800
Received: from NASANEXM01H.na.qualcomm.com (10.85.0.34) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 19 Nov 2019 21:23:43 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Tue, 19 Nov 2019 21:23:43 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYASPR01MB0065.namprd02.prod.outlook.com (20.179.154.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 20 Nov 2019 05:23:42 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 05:23:41 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH] Hexagon: Swap SIGRGMAX-1 and SIGRTMIN+1
Thread-Topic: [PATCH] Hexagon: Swap SIGRGMAX-1 and SIGRTMIN+1
Thread-Index: AQHVnwx8rLIAH0kQNkKw9TSsm/yDb6eS4ccAgACjlqA=
Date: Wed, 20 Nov 2019 05:23:41 +0000
Message-ID: <BYAPR02MB4886260AC9EA38A04DD36FFFDE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1574190388-12605-1-git-send-email-tsimpson@quicinc.com>
 <CAFEAcA8AeTgY+3GaN9ZUi-5XtX5jxhqpdOhr3ixYwouWhQOQ5g@mail.gmail.com>
In-Reply-To: <CAFEAcA8AeTgY+3GaN9ZUi-5XtX5jxhqpdOhr3ixYwouWhQOQ5g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31e764e3-0a8e-4e83-f912-08d76d79ce7d
x-ms-traffictypediagnostic: BYASPR01MB0065:
x-microsoft-antispam-prvs: <BYASPR01MB00658F335841EFFFD1E16C7DDE4F0@BYASPR01MB0065.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(346002)(396003)(366004)(39860400002)(13464003)(189003)(199004)(5660300002)(81166006)(33656002)(486006)(99286004)(478600001)(66946007)(11346002)(476003)(9686003)(256004)(66446008)(71190400001)(76176011)(64756008)(52536014)(66066001)(446003)(71200400001)(2906002)(7696005)(66476007)(76116006)(66556008)(55016002)(74316002)(6916009)(54906003)(6436002)(81156014)(229853002)(6506007)(7736002)(186003)(14444005)(4326008)(26005)(6246003)(8676002)(102836004)(53546011)(3846002)(86362001)(6116002)(8936002)(25786009)(316002)(305945005)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYASPR01MB0065;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C4ZUX0cXK1drzkG3iChX8yr8xRRSlTQseK5cM6cfxN+q94vlsx4xVSsTeS1PHndyidzT8ILqXGjbw4PR1qLeg7Lcmicf0uUxybHbeRgpb65xNsWcICz5lNHRyWT93BGiI0XpGcEdM9x/P6JNNk92zCYQIWVzhAVtNakMkd0T2leyLTlHdgcyZdpC01BdR65m5FxpUgq1ri5DWey64I60IGNgiQxZ5eU4wkEJOHNqWOEOmJrajDXGLNL3V4UJZqu8Z0VGSfgMWonRdsKk/Lc7eKytsOgtDxo6liI3+vn0FlLm2cUcnWtgbJ8m6ObsR3yKIxQt9M4TFlmDxC4V9WWZxdwKFMK238DascVULvjbKprr1VZ43qAGi2ivzmfznuWKKWpJXr7jzcF73ospS3RVEs/eOePRcWjq9MXxKXtAGVPFWRsup8lrNzo+W/J40dN1
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wr6d5UTI0wlKrH6jlt69VjTmJuqwusJGcqSvZ8+JI2Sz8jxTOPcyqqbwHzKgxsaqU9N8bIkeTzT4fT6q6ouEQ6wbYjbY0P5YoOVBG7VIRuAcXpv0fbNFy4lMsL6STP6bCJ2tXqpQKvQ7q01udvC6Sy8sPTXZqV7Sj0gSprK55sQppzvlfDBJzvh4e2bWvrLx2QON2LS6CdWp03br9o+uq+K2mm6Ps7M2R7Ob8K29oYbg04rGVNrqm7UKaDOtI3YPombP1yriPBBUiz8nWT3CO32UFC5GmZe9cmnJWTcQpYJF6n+K9YCCzMdY3Mju5QALjIl9KmtgnRJch+eJGtOvjg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnHVIqwXk6EXiupR8gv+vQkWstJm5cBckrAPAqmT/x8=;
 b=QemmD6uNZK9hKFqwIkp5WvM7CT3qVfLfDB7/N5Y/GtKo8aPrAvmwNvGlc1JdOCvVepCg8olK3/3G2t/T7guin7czZWcfSYGG9ecvFWdOFVeXM6FKhhJLB7xxqZglFZP0O1AjeWh6aOYOcCzoB8BfRoCHsWmQcz6HPkUpFNuesbMXnGMY/r1Y7nJM3zuZC5Oo1OdAkfjKK0s9ueYi6qwCzgXPHMFVlthLP+r2czTaAQU1pOTHFyh2B748/cMq9u0xiZ1ukT5dQ8vp10wsIv+GqOJM9R1XWaKec3p7UcPdZmakMjmdPK2ALWOuQmdmxvuYocaVQB1DEPtX9GtAuTmfPw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnHVIqwXk6EXiupR8gv+vQkWstJm5cBckrAPAqmT/x8=;
 b=TZi7/vvD2sU9WYAceQrBogl4PwmbOuqS/Oy4m2Du/eQXe1eNLSNhX4G99oGlTHCHQVqHQPQbuIxHceMEzIa7NErGWDyGNWQP6skV52yRk5v70vKhC0DHeKrFZ/1Kr3X5b/y3a+Ahv4nh9qpc6svGMoAyppP2+EnZyXKGCwXifVU=
x-ms-exchange-crosstenant-network-message-id: 31e764e3-0a8e-4e83-f912-08d76d79ce7d
x-ms-exchange-crosstenant-originalarrivaltime: 20 Nov 2019 05:23:41.7568 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 78kk6c6PhUc5zTMOn6XP8eyzkoNo97g1UyIQIYqLDBZ86g23V5zSlQ1Yw6Exhtx1Yj4oPxu4DJbCASN1uMOVyQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYASPR01MB0065
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGV0ZXIsDQoNClllYWgsIEkgd2FzIHN1cnByaXNlZCBub3QgdG8gc2VlIG90aGVyIHRhcmdldHMg
ZW5jb3VudGVyaW5nIHRoaXMgcHJvYmxlbS4gIEhvd2V2ZXIsIEkgZG9uJ3QgdW5kZXJzdGFuZCBo
b3cgc29tZXRoaW5nIHVuZGVyICNpZmRlZiBUQVJHRVRfSEVYQUdPTiBjYW4gYnJlYWsgYW55dGhp
bmcgZWxzZS4NCg0KQ291bGQgeW91IHBvaW50IG1lIHRvIHRoZSBwYXRjaCBzZXQgeW91IG1lbnRp
b24/DQoNCk9uZSBnZW5lcmljIHNvbHV0aW9uIEkgY2FuIHRoaW5rIG9mIGlzIHRvIHJlZmVyZW5j
ZSBhIHRhcmdldC1kZWZpbmVkIG1hY3JvIGluIGxpbnV4LXVzZXIvc2lnbmFsLmMgYW5kIGxldCB0
YXJnZXRzIG9wdGlvbmFsbHkgZGVmaW5lIGl0IGluIHRoZWlyIHRhcmdldF9zaWduYWwuaC4gIFNv
LCBpdCB3b3VsZCBsb29rIHNvbWV0aGluZyBsaWtlIHRoaXMNCj4gQEAgLTcyLDYgKzcyLDE0IEBA
IHN0YXRpYyB1aW50OF90IGhvc3RfdG9fdGFyZ2V0X3NpZ25hbF90YWJsZVtfTlNJR10gPSB7DQo+
ICAgICAgICAgb3ZlciBhIHNpbmdsZSBob3N0IHNpZ25hbC4gICovDQo+ICAgICAgW19fU0lHUlRN
SU5dID0gX19TSUdSVE1BWCwNCj4gICAgICBbX19TSUdSVE1BWF0gPSBfX1NJR1JUTUlOLA0KPiAr
I2lmZGVmIFRBUkdFVF9TSUdOQUxfVEFCTEVfTU9ESUZZDQo+ICsgICAgVEFSR0VUX1NJR05BTF9U
QUJMRV9NT0RJRlkNCg0KVGhhbmtzLA0KVGF5bG9yDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NClNl
bnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE5LCAyMDE5IDE6MzEgUE0NClRvOiBUYXlsb3IgU2ltcHNv
biA8dHNpbXBzb25AcXVpY2luYy5jb20+DQpDYzogUmlrdSBWb2lwaW8gPHJpa3Uudm9pcGlvQGlr
aS5maT47IExhdXJlbnQgVml2aWVyIDxsYXVyZW50QHZpdmllci5ldT47IFFFTVUgRGV2ZWxvcGVy
cyA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gSGV4YWdvbjog
U3dhcCBTSUdSR01BWC0xIGFuZCBTSUdSVE1JTisxDQoNCg0KT24gVHVlLCAxOSBOb3YgMjAxOSBh
dCAxOTowNywgVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPiB3cm90ZToNCj4N
Cj4gU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPg0K
PiAtLS0NCj4gIGxpbnV4LXVzZXIvc2lnbmFsLmMgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9saW51eC11c2VyL3NpZ25h
bC5jIGIvbGludXgtdXNlci9zaWduYWwuYyBpbmRleA0KPiA1Y2E2ZDYyLi5jZTNkMjdmIDEwMDY0
NA0KPiAtLS0gYS9saW51eC11c2VyL3NpZ25hbC5jDQo+ICsrKyBiL2xpbnV4LXVzZXIvc2lnbmFs
LmMNCj4gQEAgLTcyLDYgKzcyLDE0IEBAIHN0YXRpYyB1aW50OF90IGhvc3RfdG9fdGFyZ2V0X3Np
Z25hbF90YWJsZVtfTlNJR10gPSB7DQo+ICAgICAgICAgb3ZlciBhIHNpbmdsZSBob3N0IHNpZ25h
bC4gICovDQo+ICAgICAgW19fU0lHUlRNSU5dID0gX19TSUdSVE1BWCwNCj4gICAgICBbX19TSUdS
VE1BWF0gPSBfX1NJR1JUTUlOLA0KPiArI2lmZGVmIFRBUkdFVF9IRVhBR09ODQo+ICsgICAgLyoN
Cj4gKyAgICAgKiBIZXhhZ29uIHVzZXMgdGhlIHNhbWUgc2lnbmFsIGZvciBwdGhyZWFkIGNhbmNl
bCBhcyB0aGUgaG9zdCBwdGhyZWFkcywNCj4gKyAgICAgKiBzbyBjYW5ub3QgYmUgb3ZlcnJpZGRl
bi4NCj4gKyAgICAgKiBUaGVyZWZvcmUsIHdlIG1hcCBIZXhhZ29uIHNpZ25hbCB0byBhIGRpZmZl
cmVudCBob3N0IHNpZ25hbC4NCj4gKyAgICAgKi8NCj4gKyAgICBbX19TSUdSVE1BWCAtIDFdID0g
X19TSUdSVE1JTiArIDEsICNlbmRpZg0KPiAgfTsNCg0KVGhpcyBicmVha3Mgb3RoZXIgc3R1ZmYs
IHVuZm9ydHVuYXRlbHksIGxpa2UgR28gYmluYXJpZXMuDQooQWxzbywgeW91IG5vdyBoYXZlIHR3
byBob3N0IHNpZ25hbHMgbWFwcGVkIHRvIHRoZSBzYW1lIHRhcmdldCBzaWduYWw7IG5vdGljZSB0
aGF0IHRoZSBleGlzdGluZyBSVE1BWC9SVE1JTiBpcyBhIHN3YXAgb2YgdGhlIHR3byBzbG90cy4p
DQoNCldlIG5lZWQgYSBnZW5lcmljIHNvbHV0aW9uIGZvciB0aGlzLCBIZXhhZ29uIGlzIG5vdCB0
aGUgb25seSBvbmUgd2l0aCB0aGUgcHJvYmxlbS4gVGhlcmUncyBhIHBhdGNoc2V0IG9uIGxpc3Qg
ZnJvbSBhZ2VzIGJhY2sgdGhhdCBoYWQgYSBzdWdnZXN0ZWQgYXBwcm9hY2gsIGJ1dCBpdCBuZWVk
ZWQgcmV2aWV3IGFuZCB3b3JrLg0KDQp0aGFua3MNCi0tIFBNTQ0K

