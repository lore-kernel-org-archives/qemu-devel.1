Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21C6C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 14:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C8F20708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 14:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lE/2DawX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="K+M63aHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C8F20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1WeY-0007fH-VF
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 09:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1j1Wdw-0007EB-NF
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1j1Wdv-0007uL-6F
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:36:04 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:2496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1j1Wdu-0007tm-Pz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581431762; x=1612967762;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=05H5HTzB4lGumT+L2/qJWtyNhuDpQpVOjLMxhkfHWDg=;
 b=lE/2DawXJYXf6QinEFGQW6nmJiA7/bp6R4lr8JLZw1KOiQy3W3HJ3yTG
 aoTagy9L9ig+7KCUiCfHyND4XmD4duM7+J90KlqldRoYGMbXAzHpL6B9T
 GUzsicLhY+Pz5jIfxbjUo4XHNgSJzG2HU0DNYcYOp0iuCgJtHJxSifz9C g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Feb 2020 06:36:00 -0800
Received: from nasanexm01e.na.qualcomm.com ([10.85.0.31])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 11 Feb 2020 06:36:00 -0800
Received: from apsanexr02a.ap.qualcomm.com (10.85.0.26) by
 NASANEXM01E.na.qualcomm.com (10.85.0.31) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 11 Feb 2020 06:36:00 -0800
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 apsanexr02a.ap.qualcomm.com (10.85.0.26) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 11 Feb 2020 06:35:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Tue, 11 Feb 2020 06:35:58 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4920.namprd02.prod.outlook.com (52.135.233.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Tue, 11 Feb 2020 14:35:56 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 14:35:56 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH 55/66] Hexagon HVX import instruction encodings
Thread-Topic: [RFC PATCH 55/66] Hexagon HVX import instruction encodings
Thread-Index: AQHV4HP9grFIBrxZ7kyhBZw1Wr97eqgVkWuAgAB9zyA=
Date: Tue, 11 Feb 2020 14:35:56 +0000
Message-ID: <BYAPR02MB48865F7264F3F5B2D8735385DE180@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-56-git-send-email-tsimpson@quicinc.com>
 <fd38e134-8314-f206-9a04-0e41119105f6@redhat.com>
In-Reply-To: <fd38e134-8314-f206-9a04-0e41119105f6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [2605:6000:ee9b:a300:acf6:5767:3c09:8906]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bb5c3a0-b391-40b7-287f-08d7aeffb46e
x-ms-traffictypediagnostic: BYAPR02MB4920:
x-microsoft-antispam-prvs: <BYAPR02MB49205D69A19FFD3FAD0A717CDE180@BYAPR02MB4920.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(478600001)(316002)(54906003)(4326008)(110136005)(9686003)(55016002)(7696005)(8676002)(81166006)(8936002)(81156014)(76116006)(33656002)(52536014)(2906002)(64756008)(66946007)(66476007)(5660300002)(66446008)(66556008)(71200400001)(53546011)(6506007)(86362001)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4920;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p3gG/IKWQpZ3R01GLVhCSsjJVXSfdOpVoiTwUh1Gjsu7KiwA1tfSGzO2D42oOoID8q100+fugvkwdGAMuBp8wUhEU9WgTc0naVLC/cwx2EYobBQwbV+ZqkEXspuhiop8C/302Eb4i8Z39or67rGod4nNEWrfgkwmPFbRJUTZoNS0dJY5wM8Lnngrfnh8A9JpWgUkBpQ5Ucy3MvdTrH45VRMv5ZKiZBN1wv+gw7pZlyjytJUx7zxZqHWOj0KDhIJM/MPyXzOWLKZ1uv+48b2tocGvC22EclAPqJHIC5Fe0QBaDDlGXcZxqA2wxviXcVRnwYXXjoQqSajVzfvLnHwcflYcYI1U901fpNy3vIqU+GoVMfIoTiXGbCOeZPdxsWZcmVQsMQGeDWSFD1telH0o6K0Q4wHUb6Ll2BH5qJ58XOrPQujc+kpFELlBKL2NBmVK
x-ms-exchange-antispam-messagedata: dCwF6AKEhZYlbXspqFsXNvS35+2OxAobkoUnJeaSt+2avOEqqccJX8hgH1RECHf17bcECzJjjRcDZU1AQ4cofrp1ksIM0MgiI2Ba5qQEJHPv0gPeK2zigtpVNdH/mPfg82NLPBVCduB973NavuD1o5q5h4bX1TXL3OCD7SjwEnR8NRzNBZBVycK4gz4ucoKFqphitpcIglg+7CXEv1Pv4g==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJqrzHszlQ5fQbNIN/c/D2ogREhxCnB3CKP+HKaWbF+nvSgk7ElHV2R28eq1kXkV4P3cjIyoYKvPz4aFuNKCb7thAz3kUct7ruVj62v7YnTvs/SdyiikK2rQbhr2SJYEe5XgAOhMnZAooS2/2JcMZuLjCv0q1NoJXfsNWpHuzP858r1uW7KuAO8CpAVO9CRc1Wj/TnntdWFwqjRkCadrYNDJHnDHnVz9CSXg/VEXmVDbZ478r5FEo+GvOwFHApRxFLognMpoFvOf+/oZ1EzA9FqXwgOx7tH9/r6nKfH8szQGNdMccI9EScCo8qafshhCZfJBooXYux1Ql2TFqwsZSQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Peo6a915KNb30kApyJCa6ScBZPtuPHiNl0nSYEyOek=;
 b=XuLAjp34KOqToqSfraZTm/v3ZDk9pSTSC+IFV/7+Fnz/0b9daeM1AtJk9/bgQ+0FiaJBudVKePCVVR86LKm8PuRd+mYDMFIqOLm4k08pvOhs60PWMNnzbc10qevRsm65DqFeXolOPusGX3P5FC4rfqj7GPB7+VZiH/WYi0egrvUTQ94BJ/ToXJxbRJjtVyNqoM7H66rXFMHX1XcrZTo9Fb8+vU0cPAbvmP+/pet6hQlaf2aR32mgYjuL1rb+qf7O5moQm4mMz4jnvcuBjO/CxX35OLFMgQAxXtR9/M0IwIAiuROZJqn0gRBewWOSFgTmVB91pnhJfFgfqieX77bwGQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Peo6a915KNb30kApyJCa6ScBZPtuPHiNl0nSYEyOek=;
 b=K+M63aHQ5TK7D42tleZyVMQdvhsOAfi2IqwpXy/OLFEg1Wfz5dR7GYhABQ35mP47cEtEr0DjUKWolJdceQbl5S1g/+hVIxrCqG3C1nn4165qY96M6uV+/nZs6/4h1D49OrOMTcIJF+3XLxiXs7wPPFAE/IWGtN8zUNcs5UCN19o=
x-ms-exchange-crosstenant-network-message-id: 3bb5c3a0-b391-40b7-287f-08d7aeffb46e
x-ms-exchange-crosstenant-originalarrivaltime: 11 Feb 2020 14:35:56.1427 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: pG88txJiDl8IbBpnx58LL3UvX1DjR2pCe6n1/UgCr46tVuQ8RGMehy9NKUe5CEzSBcnCFex0re6i63x3QFxz2Q==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4920
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
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
Cc: "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGhpbGlwcGUsDQoNClRoYW5rcyBmb3IgYWxsIHlvdXIgZmVlZGJhY2suICBJJyBnZXQgeW91
ciBjb21tZW50cyBhZGRyZXNzZWQgc29vbi4NCg0KSSdtIHNvcnJ5IHlvdSBoYWQgdHJvdWJsZSBh
cHBseWluZyB0aGlzIHBhdGNoLiAgVGhlIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2VuY29kZS5k
ZWYgc2hvdWxkIGhhdmUgYmVlbiBjcmVhdGVkIGJ5IHBhdGNoIDE3LiAgRGlkIHlvdSBhcHBseSB0
aGF0IG9uZT8NCg0KVGF5bG9yDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gU2Vu
dDogVHVlc2RheSwgRmVicnVhcnkgMTEsIDIwMjAgMTowMiBBTQ0KPiBUbzogVGF5bG9yIFNpbXBz
b24gPHRzaW1wc29uQHF1aWNpbmMuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBy
aWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOyBsYXVyZW50QHZpdmllci5ldTsgcmlrdS52b2lw
aW9AaWtpLmZpOw0KPiBhbGVrc2FuZGFyLm0ubWFpbEBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6
IFtSRkMgUEFUQ0ggNTUvNjZdIEhleGFnb24gSFZYIGltcG9ydCBpbnN0cnVjdGlvbiBlbmNvZGlu
Z3MNCj4NCj4gPiArI2RlZmluZSBFWFROQU1FIG1tdmVjDQo+ID4gKyNpbmNsdWRlICJtbXZlYy9l
bmNvZGVfZXh0LmRlZiINCj4gPiArI3VuZGVmIEVYVE5BTUUNCj4gPiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vaW1wb3J0ZWQvZW5jb2RlLmRlZg0KPiBiL3RhcmdldC9oZXhhZ29uL2ltcG9y
dGVkL2VuY29kZS5kZWYNCj4gPiBpbmRleCAzM2MzMzk2Li5kMWIzNTEwIDEwMDY0NA0KPiA+IC0t
LSBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2VuY29kZS5kZWYNCj4gPiArKysgYi90YXJnZXQv
aGV4YWdvbi9pbXBvcnRlZC9lbmNvZGUuZGVmDQo+ID4gQEAgLTcxLDYgKzcxLDcgQEANCj4gPg0K
PiA+ICAgI2luY2x1ZGUgImVuY29kZV9wcC5kZWYiDQo+ID4gICAjaW5jbHVkZSAiZW5jb2RlX3N1
Ymluc24uZGVmIg0KPiA+ICsjaW5jbHVkZSAiYWxsZXh0ZW5jLmRlZiINCj4gPg0KPiA+ICAgI2lm
ZGVmIF9fU0VMRl9ERUZfRklFTEQzMg0KPiA+ICAgI3VuZGVmIF9fU0VMRl9ERUZfRklFTEQzMg0K
Pg0KPiBJIGhhZCBhIHByb2JsZW0gYXBwbHlpbmcgdGhpcyBvbmU6DQo+DQo+IEFwcGx5aW5nOiBI
ZXhhZ29uIEhWWCBpbXBvcnQgaW5zdHJ1Y3Rpb24gZW5jb2RpbmdzDQo+IGVycm9yOiB0YXJnZXQv
aGV4YWdvbi9pbXBvcnRlZC9lbmNvZGUuZGVmOiBkb2VzIG5vdCBleGlzdCBpbiBpbmRleA0KPiBQ
YXRjaCBmYWlsZWQgYXQgMDA1NCBIZXhhZ29uIEhWWCBpbXBvcnQgaW5zdHJ1Y3Rpb24gZW5jb2Rp
bmdzDQo+IGhpbnQ6IFVzZSAnZ2l0IGFtIC0tc2hvdy1jdXJyZW50LXBhdGNoJyB0byBzZWUgdGhl
IGZhaWxlZCBwYXRjaA0KPiBXaGVuIHlvdSBoYXZlIHJlc29sdmVkIHRoaXMgcHJvYmxlbSwgcnVu
ICJnaXQgYW0gLS1jb250aW51ZSIuDQo+IElmIHlvdSBwcmVmZXIgdG8gc2tpcCB0aGlzIHBhdGNo
LCBydW4gImdpdCBhbSAtLXNraXAiIGluc3RlYWQuDQo+IFRvIHJlc3RvcmUgdGhlIG9yaWdpbmFs
IGJyYW5jaCBhbmQgc3RvcCBwYXRjaGluZywgcnVuICJnaXQgYW0gLS1hYm9ydCIuDQo+DQo+IFJl
c29sdmVkIGJ5IGRvaW5nOg0KPg0KPiAocmV2aWV3L2hleGFnb258QU0gNTQvNjUpJCB0b3VjaCB0
YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNvZGUuZGVmDQo+IChyZXZpZXcvaGV4YWdvbnxBTSA1
NC82NSkkIGdpdCBhZGQgdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvZW5jb2RlLmRlZg0KPiAocmV2
aWV3L2hleGFnb258QU0gNTQvNjUpJCBnaXQgYW0gLS1jb250aW51ZQ0KPiBBcHBseWluZzogSGV4
YWdvbiBIVlggaW1wb3J0IGluc3RydWN0aW9uIGVuY29kaW5ncw0KPiBBcHBseWluZzogSGV4YWdv
biBIVlggaW1wb3J0IHNlbWFudGljcw0KPiAuLi4NCg0K

