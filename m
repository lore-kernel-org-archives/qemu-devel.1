Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B79C04AB4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 00:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75BA2084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 00:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ln2mrsRs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RkcpJ8kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75BA2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56837 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQhgw-0003cC-1J
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 20:22:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=031fa55fa=Alistair.Francis@wdc.com>)
	id 1hQhg0-0003Fo-6f
	for qemu-devel@nongnu.org; Tue, 14 May 2019 20:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=031fa55fa=Alistair.Francis@wdc.com>)
	id 1hQhfz-0002Na-0M
	for qemu-devel@nongnu.org; Tue, 14 May 2019 20:21:44 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58755)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=031fa55fa=Alistair.Francis@wdc.com>)
	id 1hQhfy-0002DV-5L; Tue, 14 May 2019 20:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1557879702; x=1589415702;
	h=from:to:cc:subject:date:message-id:
	content-transfer-encoding:mime-version;
	bh=bEXl0lNBk+H7euQ14dFlwNR9T30XjwU3iU6BGCxDsGU=;
	b=ln2mrsRsxLtpl2z3k/0ibJvyFgkpT4+pHGTiIlkCy42vlXck9L9zikk6
	N38HmdfNNwoHFlkurwh04rRNmE5ty1YPa2LoMMzh5nUflHPJ/MrjH5t8X
	htSwniZ1/h/Ph2eDHGE2c0wU9LgDO+uKfyPKMVLdUH6iXwoWsipnqv/vh
	oumtZrLAwKVayESK1KYF4WhSkTHGdu9UVavoRlvOMuMxbMOO60A2LnZVa
	E9pIPXn5AS++VbYQd5OMaL2M5TY+ai08S7HenpymkTThoy7pYxUNjsYEa
	0WVV5ffjH1GdyckxBAEby3Ptmfp33ygZdy0L6jXu8qLSpQj/tUKSbTTvQ g==;
X-IronPort-AV: E=Sophos;i="5.60,470,1549900800"; d="scan'208";a="109507454"
Received: from mail-sn1nam01lp2059.outbound.protection.outlook.com (HELO
	NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.59])
	by ob1.hgst.iphmx.com with ESMTP; 15 May 2019 08:21:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=bEXl0lNBk+H7euQ14dFlwNR9T30XjwU3iU6BGCxDsGU=;
	b=RkcpJ8kjtgr78sqr4lQmJzgynmWDbrwcbZ4uT1g+88hxyi2Flm4zxSbtt7T1NpVYAz/kRdaVBs5g09MvccVbnQwfGe5n6mkwz1Wf4CZnfkDr2+tWEnWgBggTZ1uX+OYlgl/nmJz8jbNMDVoblXj0VG+f7n3+i52xjUhgEyoM+M8=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB6229.namprd04.prod.outlook.com (20.178.235.87) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.22; Wed, 15 May 2019 00:21:34 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::9583:df9e:7ef5:44b7]) by
	BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::9583:df9e:7ef5:44b7%4]) with mapi id 15.20.1900.010;
	Wed, 15 May 2019 00:21:34 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
	<qemu-arm@nongnu.org>
Thread-Topic: [PATCH v2 1/1] target/arm: Fix vector operation segfault
Thread-Index: AQHVCrQmh+Ko5HkmvEGc3iReziFjOw==
Date: Wed, 15 May 2019 00:21:33 +0000
Message-ID: <78cf484c4d991e899d0065b2dab3a2e204ce8723.1557879499.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR11CA0081.namprd11.prod.outlook.com
	(2603:10b6:a03:f4::22) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75c026aa-8733-4196-bae3-08d6d8cb491b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB6229; 
x-ms-traffictypediagnostic: BYAPR04MB6229:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB6229EA24F83D80CB861E6EB190090@BYAPR04MB6229.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(199004)(189003)(66066001)(2616005)(110136005)(44832011)(7736002)(476003)(305945005)(6486002)(486006)(54906003)(186003)(99286004)(6512007)(2906002)(316002)(6436002)(68736007)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(26005)(53936002)(2501003)(36756003)(71200400001)(50226002)(478600001)(4326008)(81156014)(14454004)(5660300002)(72206003)(71190400001)(81166006)(8676002)(86362001)(8936002)(25786009)(118296001)(52116002)(6116002)(3846002)(386003)(256004)(6506007)(102836004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB6229;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U6aXCKGtFX8KmiTtgRgOkdXyFbzANUc8718N0zGyV94gEkOcAqdTR/0uBcNqrQbbIETzV0dTFnEbTb8X8UBEZXw/G9QFhb1ysFrWNCNqPI82S3WHOA0BMjyNHiKNN7ffg0KFgcdIalOBtK4HBvCqTJFIGSjx3u89BH7hQH6sIDp+dS1NhtRhHSWOt5dWRsXwQhNTWgrcLYXDSLb0uPNtfp6HMA2Ku9N6J2GY74DeE/NllmHsJzsFGeo7HfGnGrCuMGt+Z6c1GNziYvJGZ3kkxACqt+khKsxMe8AhvMx9oBnN1z8q6SLM6KI2uuscWw8NeXIy6kOSFvIG3VDj68DRWZuBLGsshz6MIj0+4nh9YvoWNS7Rv+sZHlbEHw3BrkdTeFNImhBp4Qg+VojQpaMwDLSoTGQAHsahw9zjd7VTTN8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c026aa-8733-4196-bae3-08d6d8cb491b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 00:21:33.8757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6229
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v2 1/1] target/arm: Fix vector operation
 segfault
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Q29tbWl0IDg5ZTY4YjU3NSAidGFyZ2V0L2FybTogVXNlIHZlY3RvciBvcGVyYXRpb25zIGZvciBz
YXR1cmF0aW9uIg0KY2F1c2VzIHRoaXMgYWJvcnQoKSB3aGVuIGJvb3RpbmcgUUVNVSBBUk0gd2l0
aCBhIENvcnRleC1BMTU6DQoNCjAgIDB4MDAwMDdmZmZmNGMyMzgyZiBpbiByYWlzZSAoKSBhdCAv
dXNyL2xpYi9saWJjLnNvLjYNCjEgIDB4MDAwMDdmZmZmNGMwZTY3MiBpbiBhYm9ydCAoKSBhdCAv
dXNyL2xpYi9saWJjLnNvLjYNCjIgIDB4MDAwMDU1NTU1NTljMTgzOSBpbiBkaXNhc19uZW9uX2Rh
dGFfaW5zbiAoaW5zbj08b3B0aW1pemVkIG91dD4sIHM9PG9wdGltaXplZCBvdXQ+KSBhdCAuL3Rh
cmdldC9hcm0vdHJhbnNsYXRlLmM6NjY3Mw0KMyAgMHgwMDAwNTU1NTU1OWMxODM5IGluIGRpc2Fz
X25lb25fZGF0YV9pbnNuIChzPTxvcHRpbWl6ZWQgb3V0PiwgaW5zbj08b3B0aW1pemVkIG91dD4p
IGF0IC4vdGFyZ2V0L2FybS90cmFuc2xhdGUuYzo2Mzg2DQo0ICAweDAwMDA1NTU1NTU5Y2Q4YTQg
aW4gZGlzYXNfYXJtX2luc24gKGluc249NDA4MTEwNzA2OCwgcz0weDdmZmZlNTlhOTUxMCkgYXQg
Li90YXJnZXQvYXJtL3RyYW5zbGF0ZS5jOjkyODkNCjUgIDB4MDAwMDU1NTU1NTljZDhhNCBpbiBh
cm1fdHJfdHJhbnNsYXRlX2luc24gKGRjYmFzZT0weDdmZmZlNTlhOTUxMCwgY3B1PTxvcHRpbWl6
ZWQgb3V0PikgYXQgLi90YXJnZXQvYXJtL3RyYW5zbGF0ZS5jOjEzNjEyDQo2ICAweDAwMDA1NTU1
NTU4ZDFkMzkgaW4gdHJhbnNsYXRvcl9sb29wIChvcHM9MHg1NTU1NTYxY2M1ODAgPGFybV90cmFu
c2xhdG9yX29wcz4sIGRiPTB4N2ZmZmU1OWE5NTEwLCBjcHU9MHg1NTU1NTY4NmEyZjAsIHRiPTxv
cHRpbWl6ZWQgb3V0PiwgbWF4X2luc25zPTxvcHRpbWl6ZWQgb3V0PikgYXQgLi9hY2NlbC90Y2cv
dHJhbnNsYXRvci5jOjk2DQo3ICAweDAwMDA1NTU1NTU5ZDEwZDQgaW4gZ2VuX2ludGVybWVkaWF0
ZV9jb2RlIChjcHU9Y3B1QGVudHJ5PTB4NTU1NTU2ODZhMmYwLCB0Yj10YkBlbnRyeT0weDdmZmZk
Nzg0MDA4MCA8Y29kZV9nZW5fYnVmZmVyKzEyNjA5MTM0Nz4sIG1heF9pbnNucz1tYXhfaW5zbnNA
ZW50cnk9NTEyKSBhdCAuL3RhcmdldC9hcm0vdHJhbnNsYXRlLmM6MTM5MDENCjggIDB4MDAwMDU1
NTU1NThkMDZiOSBpbiB0Yl9nZW5fY29kZSAoY3B1PWNwdUBlbnRyeT0weDU1NTU1Njg2YTJmMCwg
cGM9MzA2NzA5NjIxNiwgY3NfYmFzZT0wLCBmbGFncz0xOTIsIGNmbGFncz0tMTYyNTI5MjgsIGNm
bGFnc0BlbnRyeT01MjQyODgpIGF0IC4vYWNjZWwvdGNnL3RyYW5zbGF0ZS1hbGwuYzoxNzM2DQo5
ICAweDAwMDA1NTU1NTU4Y2U0NjcgaW4gdGJfZmluZCAoY2ZfbWFzaz01MjQyODgsIHRiX2V4aXQ9
MSwgbGFzdF90Yj0weDdmZmZkNzgzZTY0MCA8Y29kZV9nZW5fYnVmZmVyKzEyNjA4NDYyNz4sIGNw
dT0weDEpIGF0IC4vYWNjZWwvdGNnL2NwdS1leGVjLmM6NDA3DQoxMCAweDAwMDA1NTU1NTU4Y2U0
NjcgaW4gY3B1X2V4ZWMgKGNwdT1jcHVAZW50cnk9MHg1NTU1NTY4NmEyZjApIGF0IC4vYWNjZWwv
dGNnL2NwdS1leGVjLmM6NzI4DQoxMSAweDAwMDA1NTU1NTU4OGIwY2YgaW4gdGNnX2NwdV9leGVj
IChjcHU9MHg1NTU1NTY4NmEyZjApIGF0IC4vY3B1cy5jOjE0MzENCjEyIDB4MDAwMDU1NTU1NTg4
ZDIyMyBpbiBxZW11X3RjZ19jcHVfdGhyZWFkX2ZuIChhcmc9MHg1NTU1NTY4NmEyZjApIGF0IC4v
Y3B1cy5jOjE3MzUNCjEzIDB4MDAwMDU1NTU1NTg4ZDIyMyBpbiBxZW11X3RjZ19jcHVfdGhyZWFk
X2ZuIChhcmc9YXJnQGVudHJ5PTB4NTU1NTU2ODZhMmYwKSBhdCAuL2NwdXMuYzoxNzA5DQoxNCAw
eDAwMDA1NTU1NTVkMjYyOWEgaW4gcWVtdV90aHJlYWRfc3RhcnQgKGFyZ3M9PG9wdGltaXplZCBv
dXQ+KSBhdCAuL3V0aWwvcWVtdS10aHJlYWQtcG9zaXguYzo1MDINCjE1IDB4MDAwMDdmZmZmNGRi
OGE5MiBpbiBzdGFydF90aHJlYWQgKCkgYXQgL3Vzci9saWIvbGlicHRocmVhZC4NCg0KVGhpcyBw
YXRjaCBlbnN1cmVzIHRoYXQgd2UgZG9uJ3QgaGl0IHRoZSBhYm9ydCgpIGluIHRoZSBzZWNvbmQg
c3dpdGNoDQpjYXNlIGluIGRpc2FzX25lb25fZGF0YV9pbnNuKCkgYXMgd2Ugd2lsbCByZXR1cm4g
ZnJvbSB0aGUgZmlyc3QgY2FzZS4NCg0KU2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8
YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KLS0tDQogdGFyZ2V0L2FybS90cmFuc2xhdGUuYyB8
IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS90YXJnZXQvYXJtL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2FybS90cmFu
c2xhdGUuYw0KaW5kZXggZGQwNTNjODBkNi4uMjk4YzI2MjgyNSAxMDA2NDQNCi0tLSBhL3Rhcmdl
dC9hcm0vdHJhbnNsYXRlLmMNCisrKyBiL3RhcmdldC9hcm0vdHJhbnNsYXRlLmMNCkBAIC02NTk4
LDEzICs2NTk4LDEzIEBAIHN0YXRpYyBpbnQgZGlzYXNfbmVvbl9kYXRhX2luc24oRGlzYXNDb250
ZXh0ICpzLCB1aW50MzJfdCBpbnNuKQ0KICAgICAgICAgICAgIHRjZ19nZW5fZ3ZlY180KHJkX29m
cywgb2Zmc2V0b2YoQ1BVQVJNU3RhdGUsIHZmcC5xYyksDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcm5fb2ZzLCBybV9vZnMsIHZlY19zaXplLCB2ZWNfc2l6ZSwNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAodSA/IHVxYWRkX29wIDogc3FhZGRfb3ApICsgc2l6ZSk7DQotICAgICAg
ICAgICAgYnJlYWs7DQorICAgICAgICAgICAgcmV0dXJuIDA7DQogDQogICAgICAgICBjYXNlIE5F
T05fM1JfVlFTVUI6DQogICAgICAgICAgICAgdGNnX2dlbl9ndmVjXzQocmRfb2ZzLCBvZmZzZXRv
ZihDUFVBUk1TdGF0ZSwgdmZwLnFjKSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBybl9v
ZnMsIHJtX29mcywgdmVjX3NpemUsIHZlY19zaXplLA0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICh1ID8gdXFzdWJfb3AgOiBzcXN1Yl9vcCkgKyBzaXplKTsNCi0gICAgICAgICAgICBicmVh
azsNCisgICAgICAgICAgICByZXR1cm4gMDsNCiANCiAgICAgICAgIGNhc2UgTkVPTl8zUl9WTVVM
OiAvKiBWTVVMICovDQogICAgICAgICAgICAgaWYgKHUpIHsNCi0tIA0KMi4yMS4wDQoNCg==

