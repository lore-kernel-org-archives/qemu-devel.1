Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D98C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117E820843
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EZLnJ4oB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117E820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47445 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQWRg-0003gS-Cs
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 08:22:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGy-0003YP-Qi
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGw-0002C8-Hz
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:11:08 -0400
Received: from mail-eopbgr10128.outbound.protection.outlook.com
	([40.107.1.128]:12999
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hQWGq-00020g-Po; Tue, 14 May 2019 08:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=lYLyh+9bxLXOkoak9kC6UGRcqlEZ9Oc04EES8GyG2Aw=;
	b=EZLnJ4oBQaIasSMZMqKIOMnxvSWZJWXnZCHBmWsMvpCuP96ZE8dLJhKkLmF4Rq8RSweYhJGe91UTGt5lCpC1Wc8f1uORt8E9nolsVJ0FUZ8h9KaRtocp2JeVvnPOf/2u0iyKMANp0Y7ruIGXYbmoEUhCO9/qU/Wq86JzoiohqWw=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
	VI1PR08MB4573.eurprd08.prod.outlook.com (20.178.126.206) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Tue, 14 May 2019 12:10:49 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900]) by VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900%3]) with mapi id 15.20.1878.024;
	Tue, 14 May 2019 12:10:49 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v7 8/9] file-posix: account discard operations
Thread-Index: AQHVCk4RAFKe40evC0O/XAe8I3+ubQ==
Date: Tue, 14 May 2019 12:10:49 +0000
Message-ID: <20190514121015.32190-9-anton.nefedov@virtuozzo.com>
References: <20190514121015.32190-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190514121015.32190-1-anton.nefedov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0057.eurprd07.prod.outlook.com
	(2603:10a6:3:9e::25) To VI1PR08MB4078.eurprd08.prod.outlook.com
	(2603:10a6:803:e5::28)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7fa40454-adb8-4570-22da-08d6d86533d7
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:VI1PR08MB4573; 
x-ms-traffictypediagnostic: VI1PR08MB4573:
x-microsoft-antispam-prvs: <VI1PR08MB45735C5337E840B6D86DA176F8080@VI1PR08MB4573.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(386003)(6506007)(102836004)(305945005)(5640700003)(6436002)(66946007)(26005)(316002)(7736002)(6512007)(64756008)(66446008)(66556008)(107886003)(66476007)(73956011)(76176011)(11346002)(446003)(2906002)(6486002)(476003)(2616005)(3846002)(6916009)(25786009)(4326008)(2351001)(186003)(53936002)(6116002)(44832011)(486006)(86362001)(71190400001)(71200400001)(52116002)(50226002)(256004)(14444005)(66066001)(2501003)(1076003)(5660300002)(15650500001)(68736007)(8676002)(99286004)(14454004)(478600001)(36756003)(8936002)(81156014)(81166006)(54906003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4573;
	H:VI1PR08MB4078.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VbwZ32X7XDw+sDBOobjBho2CTTV6kfdFUp1CpWqNveb7iiUuHuFi3NHsfGUjyHhowtAi0nzy9ORGQ8Nm15OqxrtFs5cfgMRrk0jqo+5ZdG049m8nm1Kk0JYgS664tt6WxNf/fQ/0Sjby6QUBHTOIstllUgrlerobx1fAAeWs25YACUzEFzOdmt/DgPhY3Qr5GSGT1Q5+iSPAcE4cyvR6CysmB/S9WeLl+kdd0/OzIV3sjHOw/WAg2/GpZf3GbB9soF/9qIkc6iSxtWPjjULJoArD5G6rwERKD2OT2fIRpJGymFUkxHYXlKu4gRvyGa8pu53mJVj4CLUFynVQGA+HdqKLzyweS335wPJQd6nbffCqiGAVAHuStDk9uO/4yrOXBFW5KoPHCjCmn6mk0+UgHd/oEVON8iFS9h5tqhMVNHU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa40454-adb8-4570-22da-08d6d86533d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 12:10:49.5239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4573
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.128
Subject: [Qemu-devel] [PATCH v7 8/9] file-posix: account discard operations
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	Anton Nefedov <anton.nefedov@virtuozzo.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyB3aWxsIGhlbHAgdG8gaWRlbnRpZnkgaG93IG1hbnkgb2YgdGhlIHVzZXItaXNzdWVkIGRp
c2NhcmQgb3BlcmF0aW9ucw0KKGFjY291bnRlZCBvbiBhIGRldmljZSBsZXZlbCkgaGF2ZSBhY3R1
YWxseSBzdWNlZWRlZCBkb3duIG9uIHRoZSBob3N0IGZpbGUNCihldmVuIHRob3VnaCB0aGUgbnVt
YmVycyB3aWxsIG5vdCBiZSBleGFjdGx5IHRoZSBzYW1lIGlmIG5vbi1yYXcgZm9ybWF0DQpkcml2
ZXIgaXMgdXNlZCAoZS5nLiBxY293MiBzZW5kaW5nIG1ldGFkYXRhIGRpc2NhcmRzKSkuDQoNCk5v
dGUgdGhhdCB0aGVzZSBudW1iZXJzIHdpbGwgbm90IGluY2x1ZGUgZGlzY2FyZHMgdHJpZ2dlcmVk
IGJ5DQp3cml0ZS16ZXJvZXMgKyBNQVlfVU5NQVAgY2FsbHMuDQoNClNpZ25lZC1vZmYtYnk6IEFu
dG9uIE5lZmVkb3YgPGFudG9uLm5lZmVkb3ZAdmlydHVvenpvLmNvbT4NCi0tLQ0KIGJsb2NrL2Zp
bGUtcG9zaXguYyB8IDIyICsrKysrKysrKysrKysrKysrKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwg
MjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvYmxvY2svZmls
ZS1wb3NpeC5jIGIvYmxvY2svZmlsZS1wb3NpeC5jDQppbmRleCAxY2Y0ZWU0OWViLi43NmQ1NGIz
YTg1IDEwMDY0NA0KLS0tIGEvYmxvY2svZmlsZS1wb3NpeC5jDQorKysgYi9ibG9jay9maWxlLXBv
c2l4LmMNCkBAIC0xNTksNiArMTU5LDExIEBAIHR5cGVkZWYgc3RydWN0IEJEUlZSYXdTdGF0ZSB7
DQogICAgIGJvb2wgbmVlZHNfYWxpZ25tZW50Ow0KICAgICBib29sIGRyb3BfY2FjaGU7DQogICAg
IGJvb2wgY2hlY2tfY2FjaGVfZHJvcHBlZDsNCisgICAgc3RydWN0IHsNCisgICAgICAgIGludDY0
X3QgZGlzY2FyZF9uYl9vazsNCisgICAgICAgIGludDY0X3QgZGlzY2FyZF9uYl9mYWlsZWQ7DQor
ICAgICAgICBpbnQ2NF90IGRpc2NhcmRfYnl0ZXNfb2s7DQorICAgIH0gc3RhdHM7DQogDQogICAg
IFBSTWFuYWdlciAqcHJfbWdyOw0KIH0gQkRSVlJhd1N0YXRlOw0KQEAgLTI2MzAsMTEgKzI2MzUs
MjIgQEAgc3RhdGljIHZvaWQgY29yb3V0aW5lX2ZuIHJhd19jb19pbnZhbGlkYXRlX2NhY2hlKEJs
b2NrRHJpdmVyU3RhdGUgKmJzLA0KICNlbmRpZiAvKiAhX19saW51eF9fICovDQogfQ0KIA0KK3N0
YXRpYyB2b2lkIHJhd19hY2NvdW50X2Rpc2NhcmQoQkRSVlJhd1N0YXRlICpzLCB1aW50NjRfdCBu
Ynl0ZXMsIGludCByZXQpDQorew0KKyAgICBpZiAocmV0KSB7DQorICAgICAgICBzLT5zdGF0cy5k
aXNjYXJkX25iX2ZhaWxlZCsrOw0KKyAgICB9IGVsc2Ugew0KKyAgICAgICAgcy0+c3RhdHMuZGlz
Y2FyZF9uYl9vaysrOw0KKyAgICAgICAgcy0+c3RhdHMuZGlzY2FyZF9ieXRlc19vayArPSBuYnl0
ZXM7DQorICAgIH0NCit9DQorDQogc3RhdGljIGNvcm91dGluZV9mbiBpbnQNCiByYXdfZG9fcGRp
c2NhcmQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGludDY0X3Qgb2Zmc2V0LCBpbnQgYnl0ZXMsIGJv
b2wgYmxrZGV2KQ0KIHsNCiAgICAgQkRSVlJhd1N0YXRlICpzID0gYnMtPm9wYXF1ZTsNCiAgICAg
UmF3UG9zaXhBSU9EYXRhIGFjYjsNCisgICAgaW50IHJldDsNCiANCiAgICAgYWNiID0gKFJhd1Bv
c2l4QUlPRGF0YSkgew0KICAgICAgICAgLmJzICAgICAgICAgICAgID0gYnMsDQpAQCAtMjY0OCw3
ICsyNjY0LDkgQEAgcmF3X2RvX3BkaXNjYXJkKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBpbnQ2NF90
IG9mZnNldCwgaW50IGJ5dGVzLCBib29sIGJsa2RldikNCiAgICAgICAgIGFjYi5haW9fdHlwZSB8
PSBRRU1VX0FJT19CTEtERVY7DQogICAgIH0NCiANCi0gICAgcmV0dXJuIHJhd190aHJlYWRfcG9v
bF9zdWJtaXQoYnMsIGhhbmRsZV9haW9jYl9kaXNjYXJkLCAmYWNiKTsNCisgICAgcmV0ID0gcmF3
X3RocmVhZF9wb29sX3N1Ym1pdChicywgaGFuZGxlX2Fpb2NiX2Rpc2NhcmQsICZhY2IpOw0KKyAg
ICByYXdfYWNjb3VudF9kaXNjYXJkKHMsIGJ5dGVzLCByZXQpOw0KKyAgICByZXR1cm4gcmV0Ow0K
IH0NCiANCiBzdGF0aWMgY29yb3V0aW5lX2ZuIGludA0KQEAgLTMyNjMsMTAgKzMyODEsMTIgQEAg
c3RhdGljIGludCBmZF9vcGVuKEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0KIHN0YXRpYyBjb3JvdXRp
bmVfZm4gaW50DQogaGRldl9jb19wZGlzY2FyZChCbG9ja0RyaXZlclN0YXRlICpicywgaW50NjRf
dCBvZmZzZXQsIGludCBieXRlcykNCiB7DQorICAgIEJEUlZSYXdTdGF0ZSAqcyA9IGJzLT5vcGFx
dWU7DQogICAgIGludCByZXQ7DQogDQogICAgIHJldCA9IGZkX29wZW4oYnMpOw0KICAgICBpZiAo
cmV0IDwgMCkgew0KKyAgICAgICAgcmF3X2FjY291bnRfZGlzY2FyZChzLCBieXRlcywgcmV0KTsN
CiAgICAgICAgIHJldHVybiByZXQ7DQogICAgIH0NCiAgICAgcmV0dXJuIHJhd19kb19wZGlzY2Fy
ZChicywgb2Zmc2V0LCBieXRlcywgdHJ1ZSk7DQotLSANCjIuMTcuMQ0KDQo=

