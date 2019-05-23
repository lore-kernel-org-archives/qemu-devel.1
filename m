Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700DDC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2866D20862
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C9KHl+NO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2866D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33728 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlUi-0003JU-Dn
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:02:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hTlN9-0005H5-2h
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hTlN7-0004ua-Lf
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:54:54 -0400
Received: from mail-eopbgr10111.outbound.protection.outlook.com
	([40.107.1.111]:47693
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1hTlN6-0004rv-Vz
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=5dG8ZjdUTTrH2EUOGNc9iCD4YPcVF71jqGSB4UceVx8=;
	b=C9KHl+NOHQF9XCMSXvv2uLHBRIFTgH1c8vCO22MRojOD9TsuC4sSz29au443siURmU1WPoqHC4AnIroge7suWTzWRMZWaOJwUl1gVJpXJWvfEXNZdiKKWHOT6R9Tu8sqWtm6aUpJi6zIY015sNKYveXkJsDEXpLKNA3FFpcoCcM=
Received: from DBBPR08MB4854.eurprd08.prod.outlook.com (20.179.46.205) by
	DBBPR08MB4425.eurprd08.prod.outlook.com (20.179.43.13) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.16; Thu, 23 May 2019 10:54:49 +0000
Received: from DBBPR08MB4854.eurprd08.prod.outlook.com
	([fe80::4d46:2c95:d6e:ab3f]) by DBBPR08MB4854.eurprd08.prod.outlook.com
	([fe80::4d46:2c95:d6e:ab3f%7]) with mapi id 15.20.1900.010;
	Thu, 23 May 2019 10:54:49 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH 2/2] cpus-common: assert BQL nesting within
	cpu-exclusive sections
Thread-Index: AQHVEVXxmQM6pQZQ6EOMQW2xqwR+sg==
Date: Thu, 23 May 2019 10:54:49 +0000
Message-ID: <20190523105440.27045-3-rkagan@virtuozzo.com>
References: <20190523105440.27045-1-rkagan@virtuozzo.com>
In-Reply-To: <20190523105440.27045-1-rkagan@virtuozzo.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0901CA0058.eurprd09.prod.outlook.com
	(2603:10a6:3:45::26) To DBBPR08MB4854.eurprd08.prod.outlook.com
	(2603:10a6:10:da::13)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 831b6e39-52ee-47ef-ecdc-08d6df6d1359
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DBBPR08MB4425; 
x-ms-traffictypediagnostic: DBBPR08MB4425:
x-microsoft-antispam-prvs: <DBBPR08MB4425534C833B6A1FE4D15280C9010@DBBPR08MB4425.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(136003)(39840400004)(366004)(376002)(396003)(199004)(189003)(81166006)(81156014)(8676002)(8936002)(50226002)(7736002)(2501003)(305945005)(36756003)(53936002)(386003)(6506007)(102836004)(52116002)(6486002)(14454004)(316002)(76176011)(1076003)(478600001)(99286004)(86362001)(6512007)(11346002)(2616005)(476003)(446003)(186003)(66066001)(68736007)(2906002)(26005)(256004)(71200400001)(110136005)(25786009)(66946007)(64756008)(14444005)(71190400001)(66476007)(66556008)(73956011)(5660300002)(3846002)(6436002)(66446008)(486006)(6116002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4425;
	H:DBBPR08MB4854.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aq/9XU/d3rSV3dXma8TF9AIF8h8T/SIyI2wkCI124H+iTpY8SmJyMqz+LksOV87TvDtWydfAlDgyjojN881adHNKmqwdLVKabIM1dWWWst0nsTsO3pCbq14adfmxqiBWs46P4AdfYnvyCWpu7QZ312NAbOwVbj/SsZGahj1eQmxKBQR+/h4MsWHGHwX9XiFjC2KmvtDhln/vgawbem53iexjzdHIsK//Z/oMTA4ItjoArbO9A+IRN1rkYReK5LZhqP6NInAzTJF1Z24ZkX1SpKNcdGo40LX8INwGBXhaY1fbuFgUe8ssAw51PUZ+ZZnDY9dbqr7FqSJfQ7xWRZDr6SzJKBhZ8ce8nw16oQya2IwDqp/18xHnOivJS52Fl87RCLjot8zTA1pI76ssDX0LBGbgQFDqVTrxni6oxHkynQo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831b6e39-52ee-47ef-ecdc-08d6df6d1359
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 10:54:49.1342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4425
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.111
Subject: [Qemu-devel] [RFC PATCH 2/2] cpus-common: assert BQL nesting within
 cpu-exclusive sections
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QXNzZXJ0IHRoYXQgdGhlIGNwdS1leGNsdXNpdmUgc2VjdGlvbnMgYXJlIG5ldmVyIGVudGVyZWQv
bGVmdCB3aXRoIHRoZQ0KQlFMIHRha2VuLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb21hbiBLYWdhbiA8
cmthZ2FuQHZpcnR1b3p6by5jb20+DQotLS0NCiBjcHVzLWNvbW1vbi5jIHwgNCArKysrDQogMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvY3B1cy1jb21tb24u
YyBiL2NwdXMtY29tbW9uLmMNCmluZGV4IDAyM2NmZWJmYTMuLjlhYTc1ZmUxYmEgMTAwNjQ0DQot
LS0gYS9jcHVzLWNvbW1vbi5jDQorKysgYi9jcHVzLWNvbW1vbi5jDQpAQCAtMTc0LDYgKzE3NCw3
IEBAIHZvaWQgc3RhcnRfZXhjbHVzaXZlKHZvaWQpDQogICAgIENQVVN0YXRlICpvdGhlcl9jcHU7
DQogICAgIGludCBydW5uaW5nX2NwdXM7DQogDQorICAgIGFzc2VydCghcWVtdV9tdXRleF9pb3Ro
cmVhZF9sb2NrZWQoKSk7DQogICAgIHFlbXVfbXV0ZXhfbG9jaygmcWVtdV9jcHVfbGlzdF9sb2Nr
KTsNCiAgICAgZXhjbHVzaXZlX2lkbGUoKTsNCiANCkBAIC0yMDUsNiArMjA2LDcgQEAgdm9pZCBz
dGFydF9leGNsdXNpdmUodm9pZCkNCiAvKiBGaW5pc2ggYW4gZXhjbHVzaXZlIG9wZXJhdGlvbi4g
ICovDQogdm9pZCBlbmRfZXhjbHVzaXZlKHZvaWQpDQogew0KKyAgICBhc3NlcnQoIXFlbXVfbXV0
ZXhfaW90aHJlYWRfbG9ja2VkKCkpOw0KICAgICBxZW11X211dGV4X2xvY2soJnFlbXVfY3B1X2xp
c3RfbG9jayk7DQogICAgIGF0b21pY19zZXQoJnBlbmRpbmdfY3B1cywgMCk7DQogICAgIHFlbXVf
Y29uZF9icm9hZGNhc3QoJmV4Y2x1c2l2ZV9yZXN1bWUpOw0KQEAgLTIxNCw2ICsyMTYsNyBAQCB2
b2lkIGVuZF9leGNsdXNpdmUodm9pZCkNCiAvKiBXYWl0IGZvciBleGNsdXNpdmUgb3BzIHRvIGZp
bmlzaCwgYW5kIGJlZ2luIGNwdSBleGVjdXRpb24uICAqLw0KIHZvaWQgY3B1X2V4ZWNfc3RhcnQo
Q1BVU3RhdGUgKmNwdSkNCiB7DQorICAgIGFzc2VydCghcWVtdV9tdXRleF9pb3RocmVhZF9sb2Nr
ZWQoKSk7DQogICAgIGF0b21pY19zZXQoJmNwdS0+cnVubmluZywgdHJ1ZSk7DQogDQogICAgIC8q
IFdyaXRlIGNwdS0+cnVubmluZyBiZWZvcmUgcmVhZGluZyBwZW5kaW5nX2NwdXMuICAqLw0KQEAg
LTI1NSw2ICsyNTgsNyBAQCB2b2lkIGNwdV9leGVjX3N0YXJ0KENQVVN0YXRlICpjcHUpDQogLyog
TWFyayBjcHUgYXMgbm90IGV4ZWN1dGluZywgYW5kIHJlbGVhc2UgcGVuZGluZyBleGNsdXNpdmUg
b3BzLiAgKi8NCiB2b2lkIGNwdV9leGVjX2VuZChDUFVTdGF0ZSAqY3B1KQ0KIHsNCisgICAgYXNz
ZXJ0KCFxZW11X211dGV4X2lvdGhyZWFkX2xvY2tlZCgpKTsNCiAgICAgYXRvbWljX3NldCgmY3B1
LT5ydW5uaW5nLCBmYWxzZSk7DQogDQogICAgIC8qIFdyaXRlIGNwdS0+cnVubmluZyBiZWZvcmUg
cmVhZGluZyBwZW5kaW5nX2NwdXMuICAqLw0KLS0gDQoyLjIxLjANCg0K

