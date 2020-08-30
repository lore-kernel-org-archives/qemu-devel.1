Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4BDC433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 19:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A90420757
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 19:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NJAnGU4V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Wu45J9No"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A90420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCTPE-0006RH-Iy
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 15:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCTOP-00061t-T7
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 15:53:33 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:12083)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCTOO-0007Vx-3j
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 15:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598817212; x=1630353212;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eo97FYZi0goB5SruzD/2eNP6sMql9KxgcernWSeHKRM=;
 b=NJAnGU4VjvwTyq+0MpRy3ZeZx/vutpTQUHnbgV5jfnv0PV7sXT6w12qN
 92yJBgz2/f/eB5WD2j3qKcxQjVAsAf8W1OSZsXEA9r4fNnSlIQgTfd1jQ
 xSVfvMD3XK67eeKN/yWx55U3lYQy56G7llH33i6HBu8+6VFWt8ovMQh/7 A=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Aug 2020 12:53:30 -0700
Received: from nasanexm01a.na.qualcomm.com ([10.85.0.81])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Aug 2020 12:53:30 -0700
Received: from APSANEXR01A.ap.qualcomm.com (10.85.0.36) by
 nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 Aug 2020 12:53:30 -0700
Received: from nasanexm03b.na.qualcomm.com (10.85.0.98) by
 APSANEXR01A.ap.qualcomm.com (10.85.0.36) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 Aug 2020 12:53:30 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sun, 30 Aug 2020 12:53:29 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4006.namprd02.prod.outlook.com (2603:10b6:a02:f9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Sun, 30 Aug
 2020 19:53:28 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Sun, 30 Aug 2020
 19:53:28 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 28/34] Hexagon (target/hexagon) TCG generation
 helpers
Thread-Topic: [RFC PATCH v3 28/34] Hexagon (target/hexagon) TCG generation
 helpers
Thread-Index: AQHWdXdfKU0DqHwuJkSki+Uj5hpxmqlOYhMAgALARqA=
Date: Sun, 30 Aug 2020 19:53:28 +0000
Message-ID: <BYAPR02MB488611B00AC7D19989B57FB4DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-29-git-send-email-tsimpson@quicinc.com>
 <4c1cefd2-5e45-db8c-ec0f-917fcbbd3376@linaro.org>
In-Reply-To: <4c1cefd2-5e45-db8c-ec0f-917fcbbd3376@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c2703bc-c42c-4a80-92de-08d84d1e5d89
x-ms-traffictypediagnostic: BYAPR02MB4006:
x-microsoft-antispam-prvs: <BYAPR02MB4006E4D8B39450C0E1B235A6DE500@BYAPR02MB4006.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j3t4ce6ljvZq6TeTOk4MMPLRtigrCoT8dHUwog8/I9XbNJolY9imlRYJgLjwz2QYDvMoISZKCnuJWVB0iBhHJIGqaGZb+5VvvTT12RKUDZfFYx9jlpmOBHPlvPCJZhofhWhsEG2cGrimMpjFo2FktizamK8iSh3PyI1XEYX1v3R7Kkt6ASAN5kMMIDSBe98n+IGQN+35rxeHYm0UIAFEEUQtlRVYA2lCT5P7ng3ByxNnsvmR3esS2pN5t0bpxLZZzPIIcqikSbgwJbUQ6lx1slREl0Pi1YNRcyPcdjZ+XeGpvkzyWdxq2nQ5EApIhklWSAwK/badr01NekQieRNTLA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(346002)(376002)(136003)(39850400004)(366004)(2906002)(4326008)(52536014)(110136005)(55016002)(478600001)(7696005)(6506007)(86362001)(5660300002)(53546011)(8676002)(71200400001)(186003)(66946007)(9686003)(64756008)(66556008)(66476007)(26005)(54906003)(316002)(8936002)(66446008)(76116006)(33656002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 4xrvGBEs9Tmi6P4rPFNMsuVl7GVBCjBR3T3y0t7epaxpAIOAj1OOXQX+MJGPvpoTun4opajZX9QkGO/TE3jroctCTLV0QjjOw4oWJwL/FSVCJMouhlKA468aIi5okHHUsbHySnE1UMrIXBQLoU1qLAZTrGjdIvbz2eoAT4p85t4NSjpCBJArIP4nig0ZvzX1uodHUQH2BF7bJPQ5moCWDFEPhUQTkGt7KvMdhFP7oLUPPCOTQvG45Bjp/WNZ+6IZrXOewhCbmoqF824CWnvFF6pN2BVbrAzj/IbpOVRfGhptngZ7+hEWX7WEJc2L8+PtnqWAgu9iPwIaBBLeW76fdzqgihK00aPgeCvfbR9Tt2BA9R3SM37A9XMFVXnUSl3CxBtoySwEizzgSZ0RFlmoQDC1LBNTSlMe4z4eigln0I2BNqAAGGHoeJyRq9OsG0OD2lTksMW9F7YiqZHtSMJ3z6NRzdTjjmDTvdUkaqy+7Dw+eRYy2eLHv5lkQgfmRmPMOZ+FfGGC/6m0gATmgpSHmZ9veLFd7W7qN+dVe+2mvOrkpbvn0xMZ59vwWJoXD2GSNv8uyiD0XR94cigR/QLNS80X1ViyqpPzY5C8WF/uBoKSFprCx06ESNKhjKue4r4uhQ4DKE4oLIwzGtOPo8LNQw==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anR9JiH/A63QmEGnWh/66GvLBCWqRkCfEAljcWOXL32cH1fXEn6J8FEgZH7xWyVE1Ot/9RNjG8H+Vab59I4AW9rfXo1d30MuhKq/o8QDEFhXeFMLrVGxK/HMQhcKuMT/sDBuojzc/ZI5xWTEWpk9BlfUfwxsrSgdv4qAJVisT2FMFErU1UqoLxYUy2i87KWYSIxH0mGyrZEglR7+9aH9uDCR3OD32yvwzPzvOswznMWtlFVjmwXbq5rinAg9o5+YrbiscpHABuhO4yL35aIVeQqvS7/YKxnBY7ze4VhJs1XjC/1D5+s4xbdRiKucsKCKUpFhWloAHb5/JqHbx+8A3Q==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFORb5Ppz9Zbezd9RTKe/aZe6G81O1LiBAR8yU6rDqo=;
 b=BJsRUoQ3FAuEG5G7/Fcmv5AUG+inMrJsoTi3gim+fFotGiB7pqkPVPd0z/qBsZo4UcJe8BLHpUdmE3hCmOdsz0HNhDYKit5uJTawIrFeDy8DdUFXIDsvDSZORVyCQsXwAmyqJ29PRWNycFlsJCHuite0l4jtKiOe1DGPJtai5TtB/Q3KblqxjzM7xyFgz+wH3iE6v75YPxZSOTNAjruiRaTqoNdKnrkZfbaS/kM5kxB2KFsVkp2NAVckGesQqRWpA5U9SkNImfGGrNR4jeWgawyS28TwLGeh4I5sYIGKvsrhyBZnhsNA0qikbZMSF0PxFCSFqmP+3srZmOls14y0lg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFORb5Ppz9Zbezd9RTKe/aZe6G81O1LiBAR8yU6rDqo=;
 b=Wu45J9NoRErubmuUDHf6CXiSXpUBIkZ51v0Tpu6CSJIsFaVfQC9fG93ULUYeXMVj+z6Qfb7PEXf9e3ZKQ72S3xCpLTFeVSt+ZIEsgPteG8lzPxU8gYSNS0cZUZfMlem0zyK8uS0uLWbKnIZAKNtnROFGJHQ87IOjn6iO6/b0BHg=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 4c2703bc-c42c-4a80-92de-08d84d1e5d89
x-ms-exchange-crosstenant-originalarrivaltime: 30 Aug 2020 19:53:28.5780 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 3P2+NFrWVABPAOWgDbvt8zrzAAbvcFz0vsm+dvxXgw34kUWK4xMjh5CKwx3ktA6VS3Q3O/Ryc2kW6rq5WPNyEA==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4006
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 15:48:04
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0
IDI4LCAyMDIwIDc6NDkgUE0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207IGxh
dXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5tYWls
QGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAyOC8z
NF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIFRDRw0KPiBnZW5lcmF0aW9uIGhlbHBlcnMNCj4N
Cj4gT24gOC8xOC8yMCA4OjUwIEFNLCBUYXlsb3IgU2ltcHNvbiB3cm90ZToNCj4gPiBIZWxwZXJz
IGZvciByZWFkaW5nIGFuZCB3cml0aW5nIHJlZ2lzdGVycw0KPiA+IEhlbHBlcnMgZm9yIGxvYWQt
bG9ja2VkL3N0b3JlLWNvbmRpdGlvbmFsDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUYXlsb3Ig
U2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+DQo+ID4gLS0tDQo+ID4gIHRhcmdldC9oZXhh
Z29uL2dlbnB0cl9oZWxwZXJzLmggfCAyNDQNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgIHwgIDE4
ICsrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDI2MiBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9nZW5wdHJfaGVscGVycy5oDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyX2hlbHBlcnMuaA0KPiBiL3RhcmdldC9o
ZXhhZ29uL2dlbnB0cl9oZWxwZXJzLmgNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGlu
ZGV4IDAwMDAwMDAuLmZmY2IxZTMNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvdGFyZ2V0
L2hleGFnb24vZ2VucHRyX2hlbHBlcnMuaA0KPiA+IEBAIC0wLDAgKzEsMjQ0IEBADQo+ID4gKw0K
PiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX2xvZ19yZWdfd3JpdGUoaW50IHJudW0sIFRDR3Yg
dmFsLCBpbnQgc2xvdCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGludCBpc19wcmVkaWNhdGVkKQ0KPg0KPiBUaGVzZSBhcmUgcXVpdGUgbGFyZ2UuICBXaHkgYXJl
IHRoZXkgbWFya2VkIGlubGluZT8NCg0KU2luY2UgdGhpcyBpcyBhIGhlYWRlciBmaWxlLCBpdCBw
cmV2ZW50cyB0aGUgY29tcGlsZXIgZnJvbSBjb21wbGFpbmluZyB3aGVuIHRoZXkgYXJlbid0IHVz
ZWQuDQoNCj4NCj4gPiArICAgICAgICAvKiBMb3cgd29yZCAqLw0KPiA+ICsgICAgICAgIHRjZ19n
ZW5fZXh0cmxfaTY0X2kzMih2YWwzMiwgdmFsKTsNCj4gPiArICAgICAgICB0Y2dfZ2VuX21vdl90
bChoZXhfbmV3X3ZhbHVlW3JudW1dLCB2YWwzMik7DQo+DQo+IFdoeSBhcmUgeW91IGV4dHJhY3Rp
bmcgaW50byBhIHRlbXBvcmFyeT8NCj4gVGhpcyBjb3VsZCBiZSBkb25lIHdpdGgNCj4NCj4gICAg
IHRjZ19nZW5fZXh0cl9pNjRfaTMyKGhleF9uZXdfdmFsdWVbcm51bV0sDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICBoZXhfbmV3X3ZhbHVlW3JudW0gKyAxXSwgdmFsKTsNCg0KT0sNCg0KPiA+
ICtzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX3JlYWRfcDNfMChUQ0d2IGNvbnRyb2xfcmVnKQ0KPiA+
ICt7DQo+ID4gKyAgICBUQ0d2IHB2YWwgPSB0Y2dfdGVtcF9uZXcoKTsNCj4gPiArICAgIGludCBp
Ow0KPiA+ICsgICAgdGNnX2dlbl9tb3ZpX3RsKGNvbnRyb2xfcmVnLCAwKTsNCj4gPiArICAgIGZv
ciAoaSA9IE5VTV9QUkVHUyAtIDE7IGkgPj0gMDsgaS0tKSB7DQo+ID4gKyAgICAgICAgdGNnX2dl
bl9zaGxpX3RsKGNvbnRyb2xfcmVnLCBjb250cm9sX3JlZywgOCk7DQo+ID4gKyAgICAgICAgdGNn
X2dlbl9hbmRpX3RsKHB2YWwsIGhleF9wcmVkW2ldLCAweGZmKTsNCj4gPiArICAgICAgICB0Y2df
Z2VuX29yX3RsKGNvbnRyb2xfcmVnLCBjb250cm9sX3JlZywgcHZhbCk7DQo+DQo+IHRjZ19nZW5f
ZGVwb3NpdF90bChjb250cm9sX3JlZywgY29udHJvbF9yZWcsDQo+ICAgICAgICAgICAgICAgICAg
ICBoZXhfcHJlZFtpXSwgaSAqIDgsIDgpOw0KDQpPSw0KDQo+ID4gKyAgICBmb3IgKGkgPSAwOyBp
IDwgTlVNX1BSRUdTOyBpKyspIHsNCj4gPiArICAgICAgICB0Y2dfZ2VuX2FuZGlfdGwocHJlZF92
YWwsIGNvbnRyb2xfcmVnLCAweGZmKTsNCj4gPiArICAgICAgICB0Y2dfZ2VuX21vdl90bChoZXhf
cHJlZFtpXSwgcHJlZF92YWwpOw0KPiA+ICsgICAgICAgIHRjZ19nZW5fc2hyaV90bChjb250cm9s
X3JlZywgY29udHJvbF9yZWcsIDgpOw0KPg0KPiB0Y2dfZ2VuX2V4dHJhY3RfdGwoaGV4X3ByZWRb
aV0sIGNvbnRyb2xfcmVnLCBpICogOCwgOCk7DQoNCk9LDQoNCj4gPiArc3RhdGljIGlubGluZSB2
b2lkIGxvZ19zdG9yZTMyKENQVUhleGFnb25TdGF0ZSAqZW52LCB0YXJnZXRfdWxvbmcgYWRkciwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludDMyX3QgdmFsLCBpbnQgd2lk
dGgsIGludCBzbG90KQ0KPiA+ICt7DQo+ID4gKyAgICBIRVhfREVCVUdfTE9HKCJsb2dfc3RvcmUl
ZCgweCV4LCAlZCBbMHgleF0pXG4iLCB3aWR0aCwgYWRkciwgdmFsLA0KPiB2YWwpOw0KPiA+ICsg
ICAgZW52LT5tZW1fbG9nX3N0b3Jlc1tzbG90XS52YSA9IGFkZHI7DQo+ID4gKyAgICBlbnYtPm1l
bV9sb2dfc3RvcmVzW3Nsb3RdLndpZHRoID0gd2lkdGg7DQo+ID4gKyAgICBlbnYtPm1lbV9sb2df
c3RvcmVzW3Nsb3RdLmRhdGEzMiA9IHZhbDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGlu
bGluZSB2b2lkIGxvZ19zdG9yZTY0KENQVUhleGFnb25TdGF0ZSAqZW52LCB0YXJnZXRfdWxvbmcg
YWRkciwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludDY0X3QgdmFsLCBp
bnQgd2lkdGgsIGludCBzbG90KQ0KPiA+ICt7DQo+ID4gKyAgICBIRVhfREVCVUdfTE9HKCJsb2df
c3RvcmUlZCgweCV4LCAlbGQgWzB4JWx4XSlcbiIsIHdpZHRoLCBhZGRyLA0KPiB2YWwsIHZhbCk7
DQo+ID4gKyAgICBlbnYtPm1lbV9sb2dfc3RvcmVzW3Nsb3RdLnZhID0gYWRkcjsNCj4gPiArICAg
IGVudi0+bWVtX2xvZ19zdG9yZXNbc2xvdF0ud2lkdGggPSB3aWR0aDsNCj4gPiArICAgIGVudi0+
bWVtX2xvZ19zdG9yZXNbc2xvdF0uZGF0YTY0ID0gdmFsOw0KPiA+ICt9DQo+DQo+IC4uLiBvciBm
b2xkIHRoaXMgcmUtYWRkaXRpb24gYmFjayBpbnRvIHdoZXJlIGl0IHdhcyBhY2NpZGVudGFsbHkg
cmVtb3ZlZC4gIDstKQ0KDQpDb3VsZCB5b3UgZWxhYm9yYXRlPw0KDQo=

