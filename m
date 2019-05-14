Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B10C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392432147A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CdSmBJgO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SujS0qSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392432147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36794 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQLC4-0005gA-Du
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:21:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=030720ae1=Alistair.Francis@wdc.com>)
	id 1hQL7f-0002wt-Dx
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=030720ae1=Alistair.Francis@wdc.com>)
	id 1hQL0C-0007Z9-Og
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:14:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=030720ae1=Alistair.Francis@wdc.com>)
	id 1hQL01-00074y-Kb; Mon, 13 May 2019 20:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1557792581; x=1589328581;
	h=from:to:cc:subject:date:message-id:
	content-transfer-encoding:mime-version;
	bh=afuVLgZaiBnpomTLzlFQq/fFd7yFufaMgh/JKiVySpI=;
	b=CdSmBJgOmANC0HNAfn3BlCskRtofBVT80fzMGq0bt+8M51po7KuoKeJi
	rrl4Q+07fj3bseDRnWy50TBk1WFJiUklzwndVULMfJe+3OWJQF0ElbGhT
	6ghPWMQjLewWHfyTVTaWruQGkxR4SnvGUGsbfp1wquPlpRZGLcvbrTrVY
	MW9xK+s494GCvcmC7yQqR4sYyxksDCgDd1xQllhRF80bTGquwL2TT3g4H
	Sp6QWtP7RyPkfYHa5ZdOV7HSzvCwinGWpkZF2yAG3bzFO8SGm1T+f6IE6
	FAWH1aE0QWmp7ioLmBdBvuql1EurGWzoFXKyrfdIdJEcgdZ11X5wFNTKs Q==;
X-IronPort-AV: E=Sophos;i="5.60,466,1549900800"; d="scan'208";a="207564701"
Received: from mail-co1nam05lp2059.outbound.protection.outlook.com (HELO
	NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.59])
	by ob1.hgst.iphmx.com with ESMTP; 14 May 2019 08:09:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=afuVLgZaiBnpomTLzlFQq/fFd7yFufaMgh/JKiVySpI=;
	b=SujS0qSXVl07RlkYnUtkCKwTMOIZew6rOGsh+hyG5TzLODpi1HB1/oB+q5DjfrzZI7yGdbhchSKisR9koSo6RmfAMhuj6l4BXVl8HXoWuSt/3PvNfznWPHfZJmQwCRZxe159KiiUNzJnsdakpyQpYv7bpwI/UOEuF2imoQO/Q20=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB4151.namprd04.prod.outlook.com (20.176.250.29) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.22; Tue, 14 May 2019 00:08:34 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::9583:df9e:7ef5:44b7]) by
	BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::9583:df9e:7ef5:44b7%4]) with mapi id 15.20.1878.022;
	Tue, 14 May 2019 00:08:34 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
	<qemu-arm@nongnu.org>
Thread-Topic: [PATCH v1 1/1] target/arm: Fix vector operation segfault
Thread-Index: AQHVCekrcCo9rwpap0a2zukCh/2qOA==
Date: Tue, 14 May 2019 00:08:34 +0000
Message-ID: <ed7713d9b6c523d1c453ed7ac5de5501ef8cf405.1557792121.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR07CA0042.namprd07.prod.outlook.com
	(2603:10b6:a03:60::19) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93edf739-3ee3-485c-dc91-08d6d8004ddc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB4151; 
x-ms-traffictypediagnostic: BYAPR04MB4151:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4151352EE4030A8EFF675EF990080@BYAPR04MB4151.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(256004)(54906003)(110136005)(118296001)(26005)(71190400001)(71200400001)(476003)(86362001)(486006)(186003)(44832011)(2616005)(66946007)(73956011)(66476007)(66446008)(64756008)(66556008)(2501003)(36756003)(478600001)(72206003)(6512007)(14454004)(6486002)(316002)(6436002)(305945005)(7736002)(68736007)(25786009)(5660300002)(53936002)(4326008)(8936002)(50226002)(8676002)(81156014)(81166006)(102836004)(99286004)(66066001)(6116002)(3846002)(386003)(2906002)(6506007)(52116002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4151;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tqAiPZjC6dO8OiITXnrp64Y9SCi1+aJBCOMnxq7n19CXhhW4ej2ZRAJhBLPm98sAqncMSuwUoczDg4AutPWpz1h8cjNwBqN2uoFJribhgbq2fsOZ3OopzGTx5iucqZjJOk1czYk7djHr8PJQXxkhaAvW+PLajEJNFPjP20Sad/bghMVoXnrgN4gYhW+n4sc0+QDR/yJAXizoRXpiSDQU7NQb1s6gfO6jR70J0Au4AnPTTW70cOADG/++k8gmZZ/ayFPzQvrNorVSFPWcqxRHfTNlfZhnSZnkSshqTuoeP21NYYwT7Y8Q4dEZKCTDMWxDM4BVqAm25bY8qtfT+VMypGr2JpY1hyOdnESgb3ezTN8h1xVyIp2gwin8bM1cMDJZGZ1nN1rncIypGobtGNcn+yTjHrUiWgtpR+OLljfhW7k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93edf739-3ee3-485c-dc91-08d6d8004ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 00:08:34.0781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4151
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 1/1] target/arm: Fix vector operation
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
c3dpdGNoDQpjYXNlIGluIGRpc2FzX25lb25fZGF0YV9pbnNuKCkuIFdlIGhpdCB0aGUgc2Vjb25k
IHN3aXRjaCBjYXNlIGFzDQpORU9OXzNSX1ZRQUREIGFuZCBORU9OXzNSX1ZRU1VCIGRvbid0IHJl
dHVybiBmcm9tIHRoZSBmdW5jdGlvbiBpbiB0aGUNCmZpcnN0IHN3aXRjaCBjYXNlLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQot
LS0NCiB0YXJnZXQvYXJtL3RyYW5zbGF0ZS5jIHwgMyArKysNCiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS90YXJnZXQvYXJtL3RyYW5zbGF0ZS5jIGIvdGFy
Z2V0L2FybS90cmFuc2xhdGUuYw0KaW5kZXggMTBiYzUzZjkxYy4uY2JiMzI3NTdlOSAxMDA2NDQN
Ci0tLSBhL3RhcmdldC9hcm0vdHJhbnNsYXRlLmMNCisrKyBiL3RhcmdldC9hcm0vdHJhbnNsYXRl
LmMNCkBAIC02NzQ5LDYgKzY3NDksOSBAQCBzdGF0aWMgaW50IGRpc2FzX25lb25fZGF0YV9pbnNu
KERpc2FzQ29udGV4dCAqcywgdWludDMyX3QgaW5zbikNCiAgICAgICAgICAgICB0bXAyID0gbmVv
bl9sb2FkX3JlZyhybSwgcGFzcyk7DQogICAgICAgICB9DQogICAgICAgICBzd2l0Y2ggKG9wKSB7
DQorICAgICAgICBjYXNlIE5FT05fM1JfVlFBREQ6DQorICAgICAgICBjYXNlIE5FT05fM1JfVlFT
VUI6DQorICAgICAgICAgICAgYnJlYWs7DQogICAgICAgICBjYXNlIE5FT05fM1JfVkhBREQ6DQog
ICAgICAgICAgICAgR0VOX05FT05fSU5URUdFUl9PUChoYWRkKTsNCiAgICAgICAgICAgICBicmVh
azsNCi0tIA0KMi4yMS4wDQoNCg==

