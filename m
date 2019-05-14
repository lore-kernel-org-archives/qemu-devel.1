Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342B4C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E268F208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LUbazGVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E268F208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47383 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQWQ9-0002Il-5M
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 08:20:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGx-0003Wj-5f
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGu-00029c-1d
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:11:05 -0400
Received: from mail-eopbgr10128.outbound.protection.outlook.com
	([40.107.1.128]:12999
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hQWGo-00020g-ST; Tue, 14 May 2019 08:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ixGQ0ZT3JiaGoKxFRNxEP+ryXJN0//iy+zU6kNk4OTk=;
	b=LUbazGVZ/FB4gdgTfifo46WNHO8sYIrdRR1QQH4G0KgiC/yiiLmYR7nvwL1Ps3kh/Rhe8AfwHljwM2ltJ2wLu7580c0mhBDgi56xz6kIs6PmqVC2Tfca1tJiSWaehYgjJYNz7h0cdOS4nthLGpk0uSDx2rZpMLX/ZTIJ/3i9zdQ=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
	VI1PR08MB4573.eurprd08.prod.outlook.com (20.178.126.206) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Tue, 14 May 2019 12:10:48 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900]) by VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900%3]) with mapi id 15.20.1878.024;
	Tue, 14 May 2019 12:10:48 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v7 7/9] scsi: account unmap operations
Thread-Index: AQHVCk4Q8nj0UfWiUE6OdglBhWEhaQ==
Date: Tue, 14 May 2019 12:10:48 +0000
Message-ID: <20190514121015.32190-8-anton.nefedov@virtuozzo.com>
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
x-ms-office365-filtering-correlation-id: 1520ac6f-a204-4b3c-a86e-08d6d865332b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:VI1PR08MB4573; 
x-ms-traffictypediagnostic: VI1PR08MB4573:
x-microsoft-antispam-prvs: <VI1PR08MB4573B37B58838626D7CA8E79F8080@VI1PR08MB4573.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:40;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(386003)(6506007)(102836004)(305945005)(5640700003)(6436002)(66946007)(26005)(316002)(7736002)(6512007)(64756008)(66446008)(66556008)(107886003)(66476007)(73956011)(76176011)(11346002)(446003)(2906002)(6486002)(476003)(2616005)(3846002)(6916009)(25786009)(4326008)(2351001)(186003)(53936002)(6116002)(44832011)(486006)(86362001)(71190400001)(71200400001)(52116002)(50226002)(256004)(14444005)(66066001)(2501003)(1076003)(5660300002)(68736007)(8676002)(99286004)(14454004)(478600001)(36756003)(8936002)(81156014)(81166006)(54906003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4573;
	H:VI1PR08MB4078.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TkqkSXad+ywWq7Uloy7HlPusuwWGKf/+FjOF5e3EReZfs00G7dL7RdgZZQnMG0htxecDexkfnmiATaxiqa3N/Uk88XL/h0it2uMUxbDLK1w3TQ9jCY0ck758aT67LUgOWDkiagGcWz7REDGYkTWF6vudGvgfgbkC7UvZDUb1S1Vvto/v77Xem9CxDf1L7tm7vMK74pKBOUgAKHThvtP6ZKmL6HpIi3tcJZvBDsLibx6+wd9GkqGDj4XShfNNm1Hy/bUsbjd3jO6UGtBRFpGY8UFQPJcd9dqcCe/5PuLtAyDz2l4PS1zCG2Bj3gT0RaMwlPWqgqJ8C1XePsZ2z1V4CFpsLLJ58NWgDxA04qqzkeWmY+OdsCtnJLD8XbsBhrpgPS97OV0ydZ8qjABL0mbYcuFsvnQookWswq+E6iWrhYA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1520ac6f-a204-4b3c-a86e-08d6d865332b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 12:10:48.3771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4573
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.128
Subject: [Qemu-devel] [PATCH v7 7/9] scsi: account unmap operations
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

U2lnbmVkLW9mZi1ieTogQW50b24gTmVmZWRvdiA8YW50b24ubmVmZWRvdkB2aXJ0dW96em8uY29t
Pg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZA
dmlydHVvenpvLmNvbT4NCi0tLQ0KIGh3L3Njc2kvc2NzaS1kaXNrLmMgfCAxMiArKysrKysrKysr
Ky0NCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpk
aWZmIC0tZ2l0IGEvaHcvc2NzaS9zY3NpLWRpc2suYyBiL2h3L3Njc2kvc2NzaS1kaXNrLmMNCmlu
ZGV4IDZlZmY0OTZiNTQuLjVjNzc5ODFkNjAgMTAwNjQ0DQotLS0gYS9ody9zY3NpL3Njc2ktZGlz
ay5jDQorKysgYi9ody9zY3NpL3Njc2ktZGlzay5jDQpAQCAtMTYwOSwxMCArMTYwOSwxNiBAQCBz
dGF0aWMgdm9pZCBzY3NpX3VubWFwX2NvbXBsZXRlX25vaW8oVW5tYXBDQkRhdGEgKmRhdGEsIGlu
dCByZXQpDQogICAgICAgICByLT5zZWN0b3IgPSBsZHFfYmVfcCgmZGF0YS0+aW5idWZbMF0pOw0K
ICAgICAgICAgci0+c2VjdG9yX2NvdW50ID0gbGRsX2JlX3AoJmRhdGEtPmluYnVmWzhdKSAmIDB4
ZmZmZmZmZmZVTEw7DQogICAgICAgICBpZiAoIWNoZWNrX2xiYV9yYW5nZShzLCByLT5zZWN0b3Is
IHItPnNlY3Rvcl9jb3VudCkpIHsNCisgICAgICAgICAgICBibG9ja19hY2N0X2ludmFsaWQoYmxr
X2dldF9zdGF0cyhzLT5xZGV2LmNvbmYuYmxrKSwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgQkxPQ0tfQUNDVF9VTk1BUCk7DQogICAgICAgICAgICAgc2NzaV9jaGVja19jb25kaXRp
b24ociwgU0VOU0VfQ09ERShMQkFfT1VUX09GX1JBTkdFKSk7DQogICAgICAgICAgICAgZ290byBk
b25lOw0KICAgICAgICAgfQ0KIA0KKyAgICAgICAgYmxvY2tfYWNjdF9zdGFydChibGtfZ2V0X3N0
YXRzKHMtPnFkZXYuY29uZi5ibGspLCAmci0+YWNjdCwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgci0+c2VjdG9yX2NvdW50ICogcy0+cWRldi5ibG9ja3NpemUsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgIEJMT0NLX0FDQ1RfVU5NQVApOw0KKw0KICAgICAgICAgci0+cmVxLmFpb2NiID0g
YmxrX2Fpb19wZGlzY2FyZChzLT5xZGV2LmNvbmYuYmxrLA0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICByLT5zZWN0b3IgKiBzLT5xZGV2LmJsb2Nrc2l6ZSwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgci0+c2VjdG9yX2NvdW50ICogcy0+
cWRldi5ibG9ja3NpemUsDQpAQCAtMTYzOSwxMCArMTY0NSwxMSBAQCBzdGF0aWMgdm9pZCBzY3Np
X3VubWFwX2NvbXBsZXRlKHZvaWQgKm9wYXF1ZSwgaW50IHJldCkNCiAgICAgci0+cmVxLmFpb2Ni
ID0gTlVMTDsNCiANCiAgICAgYWlvX2NvbnRleHRfYWNxdWlyZShibGtfZ2V0X2Fpb19jb250ZXh0
KHMtPnFkZXYuY29uZi5ibGspKTsNCi0gICAgaWYgKHNjc2lfZGlza19yZXFfY2hlY2tfZXJyb3Io
ciwgcmV0LCBmYWxzZSkpIHsNCisgICAgaWYgKHNjc2lfZGlza19yZXFfY2hlY2tfZXJyb3Iociwg
cmV0LCB0cnVlKSkgew0KICAgICAgICAgc2NzaV9yZXFfdW5yZWYoJnItPnJlcSk7DQogICAgICAg
ICBnX2ZyZWUoZGF0YSk7DQogICAgIH0gZWxzZSB7DQorICAgICAgICBibG9ja19hY2N0X2RvbmUo
YmxrX2dldF9zdGF0cyhzLT5xZGV2LmNvbmYuYmxrKSwgJnItPmFjY3QpOw0KICAgICAgICAgc2Nz
aV91bm1hcF9jb21wbGV0ZV9ub2lvKGRhdGEsIHJldCk7DQogICAgIH0NCiAgICAgYWlvX2NvbnRl
eHRfcmVsZWFzZShibGtfZ2V0X2Fpb19jb250ZXh0KHMtPnFkZXYuY29uZi5ibGspKTsNCkBAIC0x
Njc0LDYgKzE2ODEsNyBAQCBzdGF0aWMgdm9pZCBzY3NpX2Rpc2tfZW11bGF0ZV91bm1hcChTQ1NJ
RGlza1JlcSAqciwgdWludDhfdCAqaW5idWYpDQogICAgIH0NCiANCiAgICAgaWYgKGJsa19pc19y
ZWFkX29ubHkocy0+cWRldi5jb25mLmJsaykpIHsNCisgICAgICAgIGJsb2NrX2FjY3RfaW52YWxp
ZChibGtfZ2V0X3N0YXRzKHMtPnFkZXYuY29uZi5ibGspLCBCTE9DS19BQ0NUX1VOTUFQKTsNCiAg
ICAgICAgIHNjc2lfY2hlY2tfY29uZGl0aW9uKHIsIFNFTlNFX0NPREUoV1JJVEVfUFJPVEVDVEVE
KSk7DQogICAgICAgICByZXR1cm47DQogICAgIH0NCkBAIC0xNjg5LDEwICsxNjk3LDEyIEBAIHN0
YXRpYyB2b2lkIHNjc2lfZGlza19lbXVsYXRlX3VubWFwKFNDU0lEaXNrUmVxICpyLCB1aW50OF90
ICppbmJ1ZikNCiAgICAgcmV0dXJuOw0KIA0KIGludmFsaWRfcGFyYW1fbGVuOg0KKyAgICBibG9j
a19hY2N0X2ludmFsaWQoYmxrX2dldF9zdGF0cyhzLT5xZGV2LmNvbmYuYmxrKSwgQkxPQ0tfQUND
VF9VTk1BUCk7DQogICAgIHNjc2lfY2hlY2tfY29uZGl0aW9uKHIsIFNFTlNFX0NPREUoSU5WQUxJ
RF9QQVJBTV9MRU4pKTsNCiAgICAgcmV0dXJuOw0KIA0KIGludmFsaWRfZmllbGQ6DQorICAgIGJs
b2NrX2FjY3RfaW52YWxpZChibGtfZ2V0X3N0YXRzKHMtPnFkZXYuY29uZi5ibGspLCBCTE9DS19B
Q0NUX1VOTUFQKTsNCiAgICAgc2NzaV9jaGVja19jb25kaXRpb24ociwgU0VOU0VfQ09ERShJTlZB
TElEX0ZJRUxEKSk7DQogfQ0KIA0KLS0gDQoyLjE3LjENCg0K

