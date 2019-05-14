Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE3C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2247A20879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 13:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GdsnM6YI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2247A20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48544 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQXt7-0004Fo-H2
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 09:54:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQXrk-0003PC-BR
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQXrj-0000vK-5g
	for qemu-devel@nongnu.org; Tue, 14 May 2019 09:53:12 -0400
Received: from mail-db5eur03on0724.outbound.protection.outlook.com
	([2a01:111:f400:fe0a::724]:21377
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hQXrg-0000oa-1A; Tue, 14 May 2019 09:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Eum1UMLP8GQRjog3i3FY0l4Nm/f3c97bMIJbis6dmqs=;
	b=GdsnM6YIlSxntXFXx3buNL2dBAvg9SqP/e/IpdqO9F1tDWyeAc7FUdsh/XcM0oz6dgtW+/0xJs7U1sTJoITRhclT69TqflssNWZTfNvOJEhJLdazyQYNJ+hoQAF616wvMWLQQeXk0I949D2Bf3wT/2mCB224psKnN6OcSXDxD70=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
	VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.22; Tue, 14 May 2019 13:53:03 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900]) by VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900%3]) with mapi id 15.20.1878.024;
	Tue, 14 May 2019 13:53:03 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v13 0/1] qcow2: cluster space preallocation
Thread-Index: AQHVClxZLAmdZM7mYka0TPufP1BHSg==
Date: Tue, 14 May 2019 13:53:03 +0000
Message-ID: <20190514135248.34146-1-anton.nefedov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0064.eurprd09.prod.outlook.com
	(2603:10a6:3:45::32) To VI1PR08MB4078.eurprd08.prod.outlook.com
	(2603:10a6:803:e5::28)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ae49eda-fa80-40f5-ae7e-08d6d8737c2e
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:VI1PR08MB4223; 
x-ms-traffictypediagnostic: VI1PR08MB4223:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <VI1PR08MB4223EBD57C81EB259CD24FDCF8080@VI1PR08MB4223.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(346002)(376002)(39840400004)(396003)(136003)(199004)(189003)(6116002)(64756008)(86362001)(66946007)(66476007)(66446008)(66556008)(2616005)(8676002)(476003)(6436002)(3846002)(8936002)(14444005)(1076003)(50226002)(73956011)(2351001)(6486002)(256004)(5640700003)(44832011)(2906002)(2501003)(6306002)(5660300002)(305945005)(966005)(7736002)(486006)(14454004)(478600001)(107886003)(71200400001)(71190400001)(66066001)(186003)(68736007)(102836004)(26005)(25786009)(6512007)(54906003)(6916009)(4326008)(53936002)(386003)(36756003)(81156014)(99286004)(6506007)(81166006)(52116002)(316002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4223;
	H:VI1PR08MB4078.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NXxdjOr+dLYEFnny5dj/0vXwqSM/tG9/fvdutxCcC7JU3k0Hi/cGBHTU7A4CLeHyZ+hyW3z/6ATxSTytpoHUBIZxOlknkCtSF7LlVnzowqsfVwmDVemaJyDjldHkqw0kovHyNnbQldgl/PCd+AlAvJ0TOgXLTIRjmmkrMUVuigYaNYKEMvgOt0J/gCK4GNr1V/FRq7uh972pufRJJUI4uVDI5EN8SgLGs0cDnDBxXF3z28cxhfQWIyM4NyItH308OEEFA491h+rMCxrDC+37XyVAiBS4WLaL+SQlJkLmG7rDZCEYQlF9szyjlvXuWOuuQg6Y8Zr5xvsUb+Wp+gP103nocf/D5lZV/Cd7BkH+VTFG3chkMmiU3t5xC9zQ6movMIapZFL9pUXHX+PD2cvOxDUIpb8l+UJcKSXUyZlNNqg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae49eda-fa80-40f5-ae7e-08d6d8737c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 13:53:03.7768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4223
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0a::724
Subject: [Qemu-devel] [PATCH v13 0/1] qcow2: cluster space preallocation
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
	Anton Nefedov <anton.nefedov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

aGksDQoNCnRoaXMgdXNlZCB0byBiZSBhIGxhcmdlIDEwLXBhdGNoZXMgc2VyaWVzLCBidXQgbm93
IHRoYW5rcyB0byBLZXZpbidzDQpCRFJWX1JFUV9OT19GQUxMQkFDSyBzZXJpZXMNCihodHRwOi8v
bGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTAzL21zZzA2Mzg5
Lmh0bWwpDQp0aGUgY29yZSBibG9jayBsYXllciBmdW5jdGlvbmFsaXR5IGlzIGFscmVhZHkgaW4g
cGxhY2U6IHRoZSBleGlzdGluZyBmbGFnDQpjYW4gYmUgcmV1c2VkLg0KDQpBIGZldyBhY2NvbXBh
bnlpbmcgcGF0Y2hlcyB3ZXJlIGFsc28gZHJvcHBlZCBmcm9tIHRoZSBzZXJpZXMgYXMgdGhvc2Ug
Y2FuDQpiZSBwcm9jZXNzZWQgc2VwYXJhdGVseS4NCg0KU28sDQoNCm5ldyBpbiB2MTM6DQogICAt
IHBhdGNoIDEgKHdhcyBwYXRjaCA5KSByZWJhc2VkIHRvIHVzZSBzLT5kYXRhX2ZpbGUgcG9pbnRl
cg0KICAgLSBjb21tZW50cyBmaXhlZC9hZGRlZA0KICAgLSBvdGhlciBwYXRjaGVzIGRyb3BwZWQg
OykNCg0KdjEyOiBodHRwOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZl
bC8yMDE5LTAxL21zZzAyNzYxLmh0bWwNCnYxMTogaHR0cDovL2xpc3RzLm5vbmdudS5vcmcvYXJj
aGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOC0xMi9tc2cwNDM0Mi5odG1sDQp2MTA6IGh0dHA6Ly9s
aXN0cy5ub25nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTgtMTIvbXNnMDAxMjEu
aHRtbA0KDQotLS0tDQoNClRoaXMgcHVsbCByZXF1ZXN0IGlzIHRvIHN0YXJ0IHRvIGltcHJvdmUg
YSBmZXcgcGVyZm9ybWFuY2UgcG9pbnRzIG9mDQpxY293MiBmb3JtYXQ6DQoNCiAgMS4gbm9uIGNs
dXN0ZXItYWxpZ25lZCB3cml0ZSByZXF1ZXN0cyAodG8gdW5hbGxvY2F0ZWQgY2x1c3RlcnMpIGV4
cGxpY2l0bHkNCiAgICAgcGFkIGRhdGEgd2l0aCB6ZXJvZXMgaWYgdGhlcmUgaXMgbm8gYmFja2lu
ZyBkYXRhLg0KICAgICBSZXN1bHRpbmcgaW5jcmVhc2UgaW4gb3BzIG51bWJlciBhbmQgcG90ZW50
aWFsIGNsdXN0ZXIgZnJhZ21lbnRhdGlvbg0KICAgICAob24gdGhlIGhvc3QgZmlsZSkgaXMgYWxy
ZWFkeSBzb2x2ZWQgYnk6DQogICAgICAgZWUyMmE5ZCBxY293MjogTWVyZ2UgdGhlIHdyaXRpbmcg
b2YgdGhlIENPVyByZWdpb25zIHdpdGggdGhlIGd1ZXN0IGRhdGENCiAgICAgSG93ZXZlciwgaW4g
Y2FzZSBvZiB6ZXJvIENPVyByZWdpb25zLCB0aGF0IGNhbiBiZSBhdm9pZGVkIGF0IGFsbA0KICAg
ICBidXQgdGhlIHdob2xlIGNsdXN0ZXJzIGFyZSBwcmVhbGxvY2F0ZWQgYW5kIHplcm9lZCBpbiBh
IHNpbmdsZQ0KICAgICBlZmZpY2llbnQgd3JpdGVfemVyb2VzKCkgb3BlcmF0aW9uDQoNCiAgMi4g
bW9yZW92ZXIsIGVmZmljaWVudCB3cml0ZV96ZXJvZXMoKSBvcGVyYXRpb24gY2FuIGJlIHVzZWQg
dG8gcHJlYWxsb2NhdGUNCiAgICAgc3BhY2UgbWVnYWJ5dGVzICgqY29uZmlndXJhYmxlIG51bWJl
cikgYWhlYWQgd2hpY2ggZ2l2ZXMgbm90aWNlYWJsZQ0KICAgICBpbXByb3ZlbWVudCBvbiBzb21l
IHN0b3JhZ2UgdHlwZXMgKGUuZy4gZGlzdHJpYnV0ZWQgc3RvcmFnZSkNCiAgICAgd2hlcmUgdGhl
IHNwYWNlIGFsbG9jYXRpb24gb3BlcmF0aW9uIG1pZ2h0IGJlIGV4cGVuc2l2ZSkNCiAgICAgKE5v
dCBpbmNsdWRlZCBpbiB0aGlzIHBhdGNoc2V0IHNpbmNlIHY2KS4NCg0KICAzLiB0aGlzIHdpbGwg
YWxzbyBhbGxvdyB0byBlbmFibGUgc2ltdWx0YW5lb3VzIHdyaXRlcyB0byB0aGUgc2FtZSB1bmFs
bG9jYXRlZA0KICAgICBjbHVzdGVyIGFmdGVyIHRoZSBzcGFjZSBoYXMgYmVlbiBhbGxvY2F0ZWQg
JiB6ZXJvZWQgYnV0IGJlZm9yZQ0KICAgICB0aGUgZmlyc3QgZGF0YSBpcyB3cml0dGVuIGFuZCB0
aGUgY2x1c3RlciBpcyBsaW5rZWQgdG8gTDIuDQogICAgIChOb3QgaW5jbHVkZWQgaW4gdGhpcyBw
YXRjaHNldCkuDQoNCkVmZmljaWVudCB3cml0ZV96ZXJvZXMgdXN1YWxseSBpbXBsaWVzIHRoYXQg
dGhlIGJsb2NrcyBhcmUgbm90IGFjdHVhbGx5DQp3cml0dGVuIHRvIGJ1dCBvbmx5IHJlc2VydmVk
IGFuZCBtYXJrZWQgYXMgemVyb2VkIGJ5IHRoZSBzdG9yYWdlLg0KRXhpc3RpbmcgYmRydl93cml0
ZV96ZXJvZXMoKSBmYWxscyBiYWNrIHRvIHdyaXRpbmcgemVybyBidWZmZXJzIGlmDQp3cml0ZV96
ZXJvZXMgaXMgbm90IHN1cHBvcnRlZCBieSB0aGUgZHJpdmVyLCBzbyBCRFJWX1JFUV9OT19GQUxM
QkFDSyBpcyB1c2VkLg0KDQpzaW1wbGUgcGVyZiB0ZXN0Og0KDQogIHFlbXUtaW1nIGNyZWF0ZSAt
ZiBxY293MiB0ZXN0LmltZyA0RyAmJiBcDQogIHFlbXUtaW1nIGJlbmNoIC1jICQoKDEwMjQqMTAy
NCkpIC1mIHFjb3cyIC1uIC1zIDRrIC10IG5vbmUgLXcgdGVzdC5pbWcNCg0KdGVzdCByZXN1bHRz
IChzZWNvbmRzKToNCg0KICAgICstLS0tLS0tLS0tLSstLS0tLS0tKy0tLS0tLSstLS0tLS0tKy0t
LS0tLSstLS0tLS0rDQogICAgfCAgIGZpbGUgICAgfCAgICBiZWZvcmUgICAgfCAgICAgYWZ0ZXIg
ICAgfCBnYWluIHwNCiAgICArLS0tLS0tLS0tLS0rLS0tLS0tLSstLS0tLS0rLS0tLS0tLSstLS0t
LS0rLS0tLS0tKw0KICAgIHwgICAgc3NkICAgIHwgICAgICA2MS4xNTMgIHwgICAgICAzNi4zMTMg
IHwgIDQxJSB8DQogICAgfCAgICBoZGQgICAgfCAgICAgMTEyLjY3NiAgfCAgICAgMTIyLjA1NiAg
fCAgLTglIHwNCiAgICArLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0r
LS0tLS0tKw0KDQpBbnRvbiBOZWZlZG92ICgxKToNCiAgcWNvdzI6IHNraXAgd3JpdGluZyB6ZXJv
IGJ1ZmZlcnMgdG8gZW1wdHkgQ09XIGFyZWFzDQoNCiBxYXBpL2Jsb2NrLWNvcmUuanNvbiAgICAg
ICB8ICA0ICstDQogYmxvY2svcWNvdzIuaCAgICAgICAgICAgICAgfCAgNiArKysNCiBibG9jay9x
Y293Mi1jbHVzdGVyLmMgICAgICB8ICAyICstDQogYmxvY2svcWNvdzIuYyAgICAgICAgICAgICAg
fCA5MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KIGJsb2NrL3RyYWNl
LWV2ZW50cyAgICAgICAgIHwgIDEgKw0KIHRlc3RzL3FlbXUtaW90ZXN0cy8wNjAgICAgIHwgIDcg
KystDQogdGVzdHMvcWVtdS1pb3Rlc3RzLzA2MC5vdXQgfCAgNSArLQ0KIDcgZmlsZXMgY2hhbmdl
ZCwgMTEyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4xNy4xDQoNCg==

