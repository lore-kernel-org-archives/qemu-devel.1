Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8454DC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508EB20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dcKhC1wC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="IgYtkVNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508EB20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1vBU-0006Qm-H9
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1j1v5d-0004yz-Vx
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1j1v5c-0002s2-G1
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:42:17 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:54655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1j1v5c-0002o0-0N
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581525736; x=1613061736;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MngNjPpuZ8LMm4C/KfjVsfAiMb/T2IhJwmc5aqrnsV8=;
 b=dcKhC1wCnq7+Y/Usz6wr1UgzyUtKbaoTTisEAW9dYGSryjyyMnCsW/je
 7Ez6ZtKkxCU73HLRlDHmbHptsKLRZEFpOt2Z/AFnKQQemLTvbiWc4B6KP
 X/Kb3bAJx8M21JJ2PJzu4uSoGAKsoixQflFd1QokFLbUAG8u8GiMts6AW Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Feb 2020 08:42:14 -0800
Received: from nasanexm03b.na.qualcomm.com ([10.85.0.98])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 12 Feb 2020 08:42:14 -0800
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 12 Feb 2020 08:42:14 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Wed, 12 Feb 2020 08:42:14 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4277.namprd02.prod.outlook.com (52.135.237.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Wed, 12 Feb 2020 16:42:13 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 16:42:13 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 0/4] linux-user: fix use of SIGRTMIN
Thread-Topic: [PATCH v3 0/4] linux-user: fix use of SIGRTMIN
Thread-Index: AQHV4aQAI8ElQXE8CEKfgmR6Uf7pZKgXw1iA
Date: Wed, 12 Feb 2020 16:42:12 +0000
Message-ID: <BYAPR02MB48860D7D29C1C09D45A4187CDE1B0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200212125658.644558-1-laurent@vivier.eu>
In-Reply-To: <20200212125658.644558-1-laurent@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3f868e3-c177-483f-d0a3-08d7afda82ea
x-ms-traffictypediagnostic: BYAPR02MB4277:
x-microsoft-antispam-prvs: <BYAPR02MB4277DC997167A326BAC51FC8DE1B0@BYAPR02MB4277.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(9686003)(52536014)(55016002)(8676002)(8936002)(66476007)(64756008)(26005)(7696005)(66556008)(478600001)(5660300002)(66946007)(66446008)(86362001)(81166006)(186003)(81156014)(53546011)(33656002)(71200400001)(110136005)(54906003)(6506007)(4326008)(76116006)(316002)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4277;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ra3RGUVZAdXBxhlNIlfkn0boKn26CSKm1i2oiuajJa/PjiyyzqfnFZZaKEUWiBEpm2gdLkkS0r8ANw85fYNRKrurUcJiPqyhJX0/owgawPZyEH8QU4ppNAAYxVNtDiWQAcGMkmqD6maUJKgKqa2w1eyFKJFqbWx08RZrd9q87WRnqTZ7DiKxWxxHGYr46GT7jl7HV64twmXXuVq800lEiK82umCNwfILnf7kxOWk6lBO0E/VtmrNbFFVdXBTJ3FyOCGylNRDj+Q9ObpuA+H61ZpI5oIpM054oO2PGbJQtsjvi5+aYUqkYO3LNj7CdOk9IGPHlqUbXMA1YqM+B1yVSidyB2ZtC672dFy1bPihAi4L6H+M6KCLCy04Nry8bpl9k20iuNHD4RC+z51wMOHUSfsNVIgqjDIwZnKdlOzpKflJ6kM9r3FVO32mibiolyqf
x-ms-exchange-antispam-messagedata: ZIQb6/zs19cPc9GFbGbtCMd4Wj0AxiykaWiLmtVw+NUvISf/5OSGFcfjsCvidAFq9r4ei9hr/fc+R3C8T8eaYL62S8FQoQhc/geWW3WV9ibfACq8iHOKK7eiV60T5GP+sy46W2D7HO8S41RAMi/qHQ==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4Lo++FdstCgX9Veyz9San2potAk3tU2kkTCzGdUBTsii+DiynRsojcB0lzKSkZmIhIJlB2McC75eY3KcdAqL8NBlIvSCFLYRtgnunN4kLWDZR5lYjXUrkinVPwIwTwDV7flqhqT7v5ikB4/L8/Fc+trwwb6HxDRhklBBA5cb28NLiwAaSLdYgiOL/xoddhQBYX4LiAK3Pm7JoFeQzQtsuWbkBbbg4eDsWEysGvMC48LVsJPrCxNeTi3STDOQRZr+kLNL2xNCPApcRsG/k7h3/x0uII8ZRa809DLIAakX4ar+WdOQgQdYJSy3dzyHU6seuvJQKxlqUA8PbBUALHrPA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp9A7L6Bssa/RnBXl4w7knNJ+RXSJxfNbZ3t4LhX42E=;
 b=lv8pN+z9ZSxE30glaPVyhMhcHqnYYd5Exfwamt7hZbwKClN2kAMsWBJ39JuvlTcdJV6Gc+LzEwZV8DKi+/rPzxS80iBnO8kHKaQ7VQrU6lw4ElPhg4Yek5YUn5eONCXdLKeU/bzOkJXlV5WEgkvnR2MRoWt+1z4QC/U+YbLm115VPF2QuJboIkH0Z6mUFYS+bQDBXdG82aZjXb200kpKP3In3G9txchVv9WhwL5AU9TlGhL+XKtpxRUhA3E7A7vGccvPGFK7j1OZHDdud79XE+wJktDXlaWa0eZcLrAe3FtqkC9od3pc86khZ93DDVGKqvTGcEQ7bB9n9BuhCmCTag==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp9A7L6Bssa/RnBXl4w7knNJ+RXSJxfNbZ3t4LhX42E=;
 b=IgYtkVNUNZ/dLao5V9iZCtScC/OjWqHvN2ruwkXAVXRlOi+qkCOrxVLjyUQRzycKEBOTD4Br9FzDCHbNSJ3zYV9/dEeeXJVtQ7Pm6dlSmDMorksA8cdrOklv0nsQZhtwAaPoJW/fm4IXXkoj7ajdbWwr73Xev3EFPyKWAP48EZU=
x-ms-exchange-crosstenant-network-message-id: e3f868e3-c177-483f-d0a3-08d7afda82ea
x-ms-exchange-crosstenant-originalarrivaltime: 12 Feb 2020 16:42:12.8543 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: /ZkfKbyLbviTDeMV4U71qHpgnYJkNIkSbWuLi7QASWawyMWAdFIK7nxDW7wXjX4crj6k4HyxqB0RnnGGZQo4yg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4277
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Matus Kysel <mkysel@tachyum.com>,
 "milos.stojanovic@rt-rk.com" <milos.stojanovic@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGVzdGVkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+DQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF1cmVudCBWaXZpZXIgPGxhdXJlbnRA
dml2aWVyLmV1Pg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDEyLCAyMDIwIDY6NTcgQU0N
Cj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQWxla3NhbmRhciBNYXJrb3ZpYyA8
YWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20+OyBMYXVyZW50IFZpdmllcg0KPiA8bGF1cmVu
dEB2aXZpZXIuZXU+OyBNYXR1cyBLeXNlbCA8bWt5c2VsQHRhY2h5dW0uY29tPjsNCj4gbWlsb3Mu
c3RvamFub3ZpY0BydC1yay5jb207IFJpa3UgVm9pcGlvIDxyaWt1LnZvaXBpb0Bpa2kuZmk+OyBK
b3NoIEt1bnoNCj4gPGprekBnb29nbGUuY29tPjsgVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1
aWNpbmMuY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsg
TWFybGllcyBSdWNrIDxtYXJsaWVzLnJ1Y2tAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gg
djMgMC80XSBsaW51eC11c2VyOiBmaXggdXNlIG9mIFNJR1JUTUlODQo+DQo+IFRoaXMgc2VyaWVz
IGZpeGVzIHRoZSBwcm9ibGVtIG9mIHRoZSBmaXJzdCByZWFsLXRpbWUgc2lnbmFscyBhbHJlYWR5
DQo+IGluIHVzZSBieSB0aGUgZ2xpYmMgdGhhdCBhcmUgbm90IGF2YWlsYWJsZSBmb3IgdGhlIHRh
cmdldCBnbGliYy4NCj4NCj4gSW5zdGVhZCBvZiByZXZlcnRpbmcgdGhlIGZpcnN0IGFuZCBsYXN0
IHJlYWwtdGltZSBzaWduYWxzIHdlIHJlbHkgb24NCj4gdGhlIHZhbHVlIHByb3ZpZGVkIGJ5IHRo
ZSBnbGliYyAoU0lHUlRNSU4pIHRvIGtub3cgdGhlIGZpcnN0IGF2YWlsYWJsZQ0KPiBzaWduYWwg
YW5kIHdlIG1hcCBhbGwgdGhlIHNpZ25hbHMgZnJvbSB0aGlzIHZhbHVlIHRvIFNJR1JUTUFYIG9u
IHRvcA0KPiBvZiBUQVJHRVRfU0lHUlRNSU4uIFNvIHRoZSBjb25zZXF1ZW5jZSBpcyB3ZSBoYXZl
IGxlc3MgYXZhaWxhYmxlIHNpZ25hbHMNCj4gaW4gdGhlIHRhcmdldCAoZ2VuZXJhbGx5IDIpIGJ1
dCBhbGwgc2VlbXMgZmluZSBhcyBhdCBsZWFzdCAzMCBzaWduYWxzIGFyZQ0KPiBzdGlsbCBhdmFp
bGFibGUuDQo+DQo+IFRoaXMgaGFzIGJlZW4gdGVzdGVkIHdpdGggR28gKGdvbGFuZyAxLjEwLjEg
bGludXgvYXJtNjQsIGJpb25pYykgb24geDg2XzY0DQo+IGZlZG9yYSAzMS4gV2UgY2FuIGF2b2lk
IHRoZSBmYWlsdXJlIGluIHRoaXMgY2FzZSBhbGxvd2luZyB0aGUgdW5zdXBwb3J0ZWQNCj4gc2ln
bmFscyB3aGVuIHdlIGRvbid0IHByb3ZpZGUgdGhlICJhY3QiIHBhcmFtZXRlcnMgdG8gc2lnYWN0
aW9uLCBvbmx5IHRoZQ0KPiAib2xkYWN0IiBvbmUuIEkgaGF2ZSBhbHNvIHJ1biB0aGUgTFRQIHN1
aXRlIHdpdGggc2V2ZXJhbCB0YXJnZXQgYW5kIGRlYmlhbg0KPiBiYXNlZCBkaXN0cm9zLg0KPg0K
PiB2MzogdXNlIHRyYWNlX2V2ZW50X2dldF9zdGF0ZV9iYWNrZW5kcygpDQo+ICAgICB1cGRhdGUg
Y29tbWVudHMNCj4gICAgIEFkZCBSLWINCj4NCj4gdjI6IHRlc3RlZCB3aXRoIGdvbGFuZyAxLjEy
LjEwIGxpbnV4L2FybTY0LCBlb2FuKQ0KPiAgICAgSWdub3JlIHVuc3VwcG9ydGVkIHNpZ25hbHMg
cmF0aGVyIHRoYW4gcmV0dXJuaW5nIGFuIGVycm9yDQo+ICAgICByZXBsYWNlIGksIGogYnkgdGFy
Z2V0X3NpZywgaG9zdF9zaWcNCj4NCj4gTGF1cmVudCBWaXZpZXIgKDQpOg0KPiAgIGxpbnV4LXVz
ZXI6IGFkZCBtaXNzaW5nIFRBUkdFVF9TSUdSVE1JTiBmb3IgaHBwYQ0KPiAgIGxpbnV4LXVzZXI6
IGNsZWFudXAgc2lnbmFsLmMNCj4gICBsaW51eC11c2VyOiBmaXggVEFSR0VUX05TSUcgYW5kIF9O
U0lHIHVzZXMNCj4gICBsaW51eC11c2VyOiBmaXggdXNlIG9mIFNJR1JUTUlODQo+DQo+ICBsaW51
eC11c2VyL2hwcGEvdGFyZ2V0X3NpZ25hbC5oIHwgICAxICsNCj4gIGxpbnV4LXVzZXIvc2lnbmFs
LmMgICAgICAgICAgICAgfCAxMzQgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4g
IGxpbnV4LXVzZXIvdHJhY2UtZXZlbnRzICAgICAgICAgfCAgIDMgKw0KPiAgMyBmaWxlcyBjaGFu
Z2VkLCAxMDYgaW5zZXJ0aW9ucygrKSwgMzIgZGVsZXRpb25zKC0pDQo+DQo+IC0tDQo+IDIuMjQu
MQ0KDQo=

