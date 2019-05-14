Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F917C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE2121537
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cBrn83hG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE2121537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48596 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQXvE-00063A-Lq
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 09:56:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQXu3-0005BH-2E
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:55:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQXu2-0006EU-0I
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:55:35 -0400
Received: from mail-eopbgr150109.outbound.protection.outlook.com
	([40.107.15.109]:50035
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hQXty-00063f-Ct; Tue, 14 May 2019 09:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Ha9v/mj7CFKfQE2RMbNIRPym71vuoqL6gmzlwemIDdg=;
	b=cBrn83hGXjOz5t8r1FQk8bO8YnhPd6cwW8wKFx5wkLqDC06/yaIvp9soas8n7TytkkECwaxrGJHY7QKCwNESF0o1WBYW8B8oDReg9cr0sARPEV9EdSWaBvZHDf3s364+CV61CFI97VwIDvmnRYj1q1tpUnaa+OLgIYVKZz6L/ag=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
	VI1PR08MB3117.eurprd08.prod.outlook.com (52.133.15.22) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.22; Tue, 14 May 2019 13:55:26 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900]) by VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900%3]) with mapi id 15.20.1878.024;
	Tue, 14 May 2019 13:55:26 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH] iotest 134: test cluster-misaligned encrypted write
Thread-Index: AQHVClyuZmHg12OSEkK/joUO9Y+YdA==
Date: Tue, 14 May 2019 13:55:26 +0000
Message-ID: <20190514135515.34355-1-anton.nefedov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0002.eurprd02.prod.outlook.com
	(2603:10a6:3:8c::12) To VI1PR08MB4078.eurprd08.prod.outlook.com
	(2603:10a6:803:e5::28)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ea2bc3a-8d5b-4776-8203-08d6d873d15c
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:VI1PR08MB3117; 
x-ms-traffictypediagnostic: VI1PR08MB3117:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR08MB31177B5CB73DB98A95C13C8FF8080@VI1PR08MB3117.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(366004)(376002)(346002)(136003)(39850400004)(189003)(199004)(478600001)(316002)(68736007)(54906003)(86362001)(66066001)(1076003)(36756003)(5660300002)(6436002)(6116002)(2906002)(3846002)(6486002)(64756008)(66446008)(66476007)(73956011)(66946007)(66556008)(5640700003)(71190400001)(71200400001)(2501003)(44832011)(476003)(2616005)(486006)(8936002)(81166006)(386003)(14454004)(99286004)(6506007)(53936002)(966005)(81156014)(107886003)(6512007)(4326008)(6306002)(52116002)(2351001)(8676002)(14444005)(256004)(102836004)(25786009)(7736002)(6916009)(186003)(50226002)(305945005)(26005)(21314003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3117;
	H:VI1PR08MB4078.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NCVFCk7DH0ttWlQ1I8xqros937yXKEMmTsmlQIYcoMxd9pZYVT9ve9ccxZgHWONBIiCmxzUH7FwFxliNg5rSAvjkAEFIsJzitjtMmiitmQltaSxRpE761qWyg7fu+P20QNHGmPw7avKfLmHhTPV+Ru0dL+0WKn8dkTvFSvv7ENRTAkkL6XonCIdDQiJXz7zTfX1RSN+3d9tODRidJlDxD/yTPvRNTXwjMI+FxtHjLLzjiC3SvJ9wLYNdYprGbLmCdAwf1Dn4rDHNmN1oW34P4rVjSMmRam0aDbfZTMhVH0Q7m/DAT9nI7yjcjXcppfnga+/WHJ9PlmJV1nIk1PKu0Kq8b9Eeu6me2QyBn6fdYSYDyFY212fcJ45jJsemlgaVEY9pkfq0JbwNmZ5qCDf6U08eLj5Rg308s9RqdGhY7d0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea2bc3a-8d5b-4776-8203-08d6d873d15c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 13:55:26.6584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3117
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.109
Subject: [Qemu-devel] [PATCH] iotest 134: test cluster-misaligned encrypted
 write
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
	Anton Nefedov <anton.nefedov@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Q09XIChldmVuIGVtcHR5L3plcm8pIGFyZWFzIHJlcXVpcmUgZW5jcnlwdGlvbiB0b28NCg0KU2ln
bmVkLW9mZi1ieTogQW50b24gTmVmZWRvdiA8YW50b24ubmVmZWRvdkB2aXJ0dW96em8uY29tPg0K
UmV2aWV3ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KUmV2aWV3ZWQtYnk6
IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQpSZXZpZXdlZC1ieTogQWxiZXJ0byBHYXJj
aWEgPGJlcnRvQGlnYWxpYS5jb20+DQotLS0NCnVzZWQgdG8gYmUgYSBwYXJ0IG9mICdxY293Mjog
Y2x1c3RlciBzcGFjZSBwcmVhbGxvY2F0aW9uJyBzZXJpZXMNCmh0dHA6Ly9saXN0cy5ub25nbnUu
b3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDEvbXNnMDI3NjkuaHRtbA0KDQogdGVz
dHMvcWVtdS1pb3Rlc3RzLzEzNCAgICAgfCAgOSArKysrKysrKysNCiB0ZXN0cy9xZW11LWlvdGVz
dHMvMTM0Lm91dCB8IDEwICsrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8xMzQgYi90ZXN0cy9xZW11
LWlvdGVzdHMvMTM0DQppbmRleCBlOWUzZTg0YzJhLi5mNWZkM2I3ZjM0IDEwMDc1NQ0KLS0tIGEv
dGVzdHMvcWVtdS1pb3Rlc3RzLzEzNA0KKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzEzNA0KQEAg
LTU3LDYgKzU3LDE1IEBAIGVjaG8NCiBlY2hvICI9PSByZWFkaW5nIHdob2xlIGltYWdlID09Ig0K
ICRRRU1VX0lPIC0tb2JqZWN0ICRTRUNSRVQgLWMgInJlYWQgMCAkc2l6ZSIgLS1pbWFnZS1vcHRz
ICRJTUdTUEVDIHwgX2ZpbHRlcl9xZW11X2lvIHwgX2ZpbHRlcl90ZXN0ZGlyDQogDQorZWNobw0K
K2VjaG8gIj09IHJld3JpdGluZyBjbHVzdGVyIHBhcnQgPT0iDQorJFFFTVVfSU8gLS1vYmplY3Qg
JFNFQ1JFVCAtYyAid3JpdGUgLVAgMHhiIDUxMiA1MTIiIC0taW1hZ2Utb3B0cyAkSU1HU1BFQyB8
IF9maWx0ZXJfcWVtdV9pbyB8IF9maWx0ZXJfdGVzdGRpcg0KKw0KK2VjaG8NCitlY2hvICI9PSB2
ZXJpZnkgcGF0dGVybiA9PSINCiskUUVNVV9JTyAtLW9iamVjdCAkU0VDUkVUIC1jICJyZWFkIC1Q
IDAgMCA1MTIiICAtLWltYWdlLW9wdHMgJElNR1NQRUMgfCBfZmlsdGVyX3FlbXVfaW8gfCBfZmls
dGVyX3Rlc3RkaXINCiskUUVNVV9JTyAtLW9iamVjdCAkU0VDUkVUIC1jICJyZWFkIC1QIDB4YiA1
MTIgNTEyIiAgLS1pbWFnZS1vcHRzICRJTUdTUEVDIHwgX2ZpbHRlcl9xZW11X2lvIHwgX2ZpbHRl
cl90ZXN0ZGlyDQorDQogZWNobw0KIGVjaG8gIj09IHJld3JpdGluZyB3aG9sZSBpbWFnZSA9PSIN
CiAkUUVNVV9JTyAtLW9iamVjdCAkU0VDUkVUIC1jICJ3cml0ZSAtUCAweGEgMCAkc2l6ZSIgLS1p
bWFnZS1vcHRzICRJTUdTUEVDIHwgX2ZpbHRlcl9xZW11X2lvIHwgX2ZpbHRlcl90ZXN0ZGlyDQpk
aWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzEzNC5vdXQgYi90ZXN0cy9xZW11LWlvdGVz
dHMvMTM0Lm91dA0KaW5kZXggOTcyYmU0OWQ5MS4uMDlkNDZmNmIxNyAxMDA2NDQNCi0tLSBhL3Rl
c3RzL3FlbXUtaW90ZXN0cy8xMzQub3V0DQorKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMTM0Lm91
dA0KQEAgLTUsNiArNSwxNiBAQCBGb3JtYXR0aW5nICdURVNUX0RJUi90LklNR0ZNVCcsIGZtdD1J
TUdGTVQgc2l6ZT0xMzQyMTc3MjggZW5jcnlwdGlvbj1vbiBlbmNyeXB0Lg0KIHJlYWQgMTM0MjE3
NzI4LzEzNDIxNzcyOCBieXRlcyBhdCBvZmZzZXQgMA0KIDEyOCBNaUIsIFggb3BzOyBYWDpYWDpY
WC5YIChYWFggWVlZL3NlYyBhbmQgWFhYIG9wcy9zZWMpDQogDQorPT0gcmV3cml0aW5nIGNsdXN0
ZXIgcGFydCA9PQ0KK3dyb3RlIDUxMi81MTIgYnl0ZXMgYXQgb2Zmc2V0IDUxMg0KKzUxMiBieXRl
cywgWCBvcHM7IFhYOlhYOlhYLlggKFhYWCBZWVkvc2VjIGFuZCBYWFggb3BzL3NlYykNCisNCis9
PSB2ZXJpZnkgcGF0dGVybiA9PQ0KK3JlYWQgNTEyLzUxMiBieXRlcyBhdCBvZmZzZXQgMA0KKzUx
MiBieXRlcywgWCBvcHM7IFhYOlhYOlhYLlggKFhYWCBZWVkvc2VjIGFuZCBYWFggb3BzL3NlYykN
CityZWFkIDUxMi81MTIgYnl0ZXMgYXQgb2Zmc2V0IDUxMg0KKzUxMiBieXRlcywgWCBvcHM7IFhY
OlhYOlhYLlggKFhYWCBZWVkvc2VjIGFuZCBYWFggb3BzL3NlYykNCisNCiA9PSByZXdyaXRpbmcg
d2hvbGUgaW1hZ2UgPT0NCiB3cm90ZSAxMzQyMTc3MjgvMTM0MjE3NzI4IGJ5dGVzIGF0IG9mZnNl
dCAwDQogMTI4IE1pQiwgWCBvcHM7IFhYOlhYOlhYLlggKFhYWCBZWVkvc2VjIGFuZCBYWFggb3Bz
L3NlYykNCi0tIA0KMi4xNy4xDQoNCg==

