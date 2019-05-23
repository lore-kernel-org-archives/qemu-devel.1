Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760BCC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DEC420868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Hmj3nhEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEC420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33642 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlQc-0008GI-Dh
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:58:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hTlN7-0005FQ-Ja
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hTlN6-0004sd-3y
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:54:53 -0400
Received: from mail-eopbgr80108.outbound.protection.outlook.com
	([40.107.8.108]:34195
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1hTlN5-0004qs-CN
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=EDyQPjCSBOpacGlKqNWOmQ/h/gpLlI3lmI0MqsAgJBo=;
	b=Hmj3nhEpz80NFYcjp32b1FfxUyIurrCiAEGiWpw/3POj84uG/Phgkh5pe3VICOHxQJCE9XJlwefGPB/fj/yXffZDzo2P8Emc07XPS85qs6SwyZ1GnWT5XUcDgM2U0j+6pQbcaVCeDnz6UjqRWFxb0tq+SJAA66zOeyKfhPYwuZQ=
Received: from DBBPR08MB4854.eurprd08.prod.outlook.com (20.179.46.205) by
	DBBPR08MB4760.eurprd08.prod.outlook.com (10.255.79.215) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.24; Thu, 23 May 2019 10:54:48 +0000
Received: from DBBPR08MB4854.eurprd08.prod.outlook.com
	([fe80::4d46:2c95:d6e:ab3f]) by DBBPR08MB4854.eurprd08.prod.outlook.com
	([fe80::4d46:2c95:d6e:ab3f%7]) with mapi id 15.20.1900.010;
	Thu, 23 May 2019 10:54:48 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH 0/2] establish nesting rule of BQL vs cpu-exclusive
Thread-Index: AQHVEVXwLFxTyUznOk6fV4juQbW3Hw==
Date: Thu, 23 May 2019 10:54:47 +0000
Message-ID: <20190523105440.27045-1-rkagan@virtuozzo.com>
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
x-ms-office365-filtering-correlation-id: 9b63f334-e4ee-4264-62be-08d6df6d1288
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DBBPR08MB4760; 
x-ms-traffictypediagnostic: DBBPR08MB4760:
x-microsoft-antispam-prvs: <DBBPR08MB4760B936B0D4C9994B31ABF5C9010@DBBPR08MB4760.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39840400004)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(256004)(14444005)(486006)(52116002)(2616005)(66066001)(68736007)(3846002)(6486002)(64756008)(6116002)(71190400001)(66946007)(66556008)(73956011)(186003)(71200400001)(110136005)(305945005)(66446008)(66476007)(99286004)(476003)(53936002)(6436002)(25786009)(6512007)(478600001)(316002)(2906002)(8936002)(26005)(81166006)(81156014)(8676002)(7736002)(36756003)(50226002)(86362001)(5660300002)(2501003)(102836004)(6506007)(14454004)(386003)(1076003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4760;
	H:DBBPR08MB4854.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w8KxG5nJubNciR66L9d9EB8oJb598GmrYm8GqwlK3B4K80DiytuNFDoNQQABUKPNnX9QJvD57kS2fshwzTPAj4Az82UhFi+qAh3pcTJBuSaMlwtVSWLXNccoQRCBk2yfqBeSE9yBAAx8mDyRsDezHzxB2k8MSi0C/2kzNJWiTsMP4DYfRS+KOeXFPjRMqF2h/PpO+TG5BuBL30KH7LEkYt3Z/hQrYtKZm/WnSfwbdHRCRwV2zGYSnHqXgVBMYnV9/hDslEWxBIfnMQ4UY6+NKZkJ0ZQxUwPPRbQedU9+2hEaHQXegJrke3EM7VnyX6aUmkAx3llmMwc4S3EkipTfDPoKZ8e0mq11AauOD6Kqb7deMaCHXL4a89tjNG4jJ1X4dOadQm7puuWvGca/Cto+CPsqHrNHMoNHplsVKryPG/o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b63f334-e4ee-4264-62be-08d6df6d1288
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 10:54:47.9208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4760
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.108
Subject: [Qemu-devel] [RFC PATCH 0/2] establish nesting rule of BQL vs
 cpu-exclusive
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

SSBjYW1lIGFjcm9zcyB0aGUgZm9sbG93aW5nIEFCLUJBIGRlYWRsb2NrOg0KDQogICAgdkNQVSB0
aHJlYWQgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1haW4gdGhyZWFkDQogICAgLS0tLS0t
LS0tLS0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tLS0tLS0tLS0tDQphc3luY19zYWZl
X3J1bl9vbl9jcHUoc2VsZiwNCiAgICAgICAgICAgICAgICAgICAgICBhc3luY19zeW5pY191cGRh
dGUpDQouLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtjcHUgaG90
LWFkZF0NCnByb2Nlc3NfcXVldWVkX2NwdV93b3JrKCkNCiAgcWVtdV9tdXRleF91bmxvY2tfaW90
aHJlYWQoKQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbZ3Jh
YiBCUUxdDQogIHN0YXJ0X2V4Y2x1c2l2ZSgpICAgICAgICAgICAgICAgICAgICAgICAgIGNwdV9s
aXN0X2FkZCgpDQogIGFzeW5jX3N5bmljX3VwZGF0ZSgpICAgICAgICAgICAgICAgICAgICAgICAg
ZmluaXNoX3NhZmVfd29yaygpDQogICAgcWVtdV9tdXRleF9sb2NrX2lvdGhyZWFkKCkgICAgICAg
ICAgICAgICAgICBjcHVfZXhlY19zdGFydCgpDQoNCkFUTSBhc3luY19zeW5pY191cGRhdGUgc2Vl
bXMgdG8gYmUgdGhlIG9ubHkgYXN5bmMgc2FmZSB3b3JrIGl0ZW0gdGhhdA0KZ3JhYnMgQlFMLiAg
SG93ZXZlciBpdCBpc24ndCBxdWl0ZSBvYnZpb3VzIHRoYXQgaXQgc2hvdWxkbid0OyBpbiB0aGUN
CnBhc3QgdGhlcmUgd2VyZSBtb3JlIGV4YW1wbGVzIG9mIHRoaXMgKGUuZy4NCm1lbW9yeV9yZWdp
b25fZG9faW52YWxpZGF0ZV9tbWlvX3B0cikuDQoNCkl0IGxvb2tzIGxpa2UgdGhlIHByb2JsZW0g
aXMgZ2VuZXJhbGx5IGluIHRoZSBsYWNrIG9mIHRoZSBuZXN0aW5nIHJ1bGUNCmZvciBjcHUtZXhj
bHVzaXZlIHNlY3Rpb25zIGFnYWluc3QgQlFMLCBzbyBJIHRob3VnaHQgSSB3b3VsZCB0cnkgdG8N
CmFkZHJlc3MgdGhhdC4gIFRoaXMgcGF0Y2hzZXQgaXMgbXkgZmVlYmxlIGF0dGVtcHQgYXQgdGhp
czsgSSdtIG5vdCBzdXJlDQpJIGZ1bGx5IGNvbXByZWhlbmQgYWxsIHRoZSBjb25zZXF1ZW5jZXMg
KHJhdGhlciwgSSdtIHN1cmUgSSBkb24ndCkgaGVuY2UNClJGQy4NCg0KUm9tYW4gS2FnYW4gKDIp
Og0KICBjcHVzLWNvbW1vbjogbnVrZSBmaW5pc2hfc2FmZV93b3JrDQogIGNwdXMtY29tbW9uOiBh
c3NlcnQgQlFMIG5lc3Rpbmcgd2l0aGluIGNwdS1leGNsdXNpdmUgc2VjdGlvbnMNCg0KIGNwdXMt
Y29tbW9uLmMgfCAxMiArKysrLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA4IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjEuMA0KDQo=

