Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B211BC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CECA208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XniCoD4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CECA208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQWNZ-0000SG-Nk
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 08:17:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGu-0003TD-2a
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGr-00026u-3B
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:11:02 -0400
Received: from mail-eopbgr10128.outbound.protection.outlook.com
	([40.107.1.128]:12999
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hQWGl-00020g-CV; Tue, 14 May 2019 08:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Pzck4rLP/X0t3KVWctGsX2zK+4JgrCX/03+50mc/gCU=;
	b=XniCoD4yZ06WEvR14eXwFvFzsGw5/T6WZZyXLiiJjvOum3dnwei7sWMjzD0xv1sWXZ/9V6aVRnkhDQ2YmjCrqYUGGLWK4zGN+vrHIBIfPghPpuP+EP30DnXJWfmSmTmoyhcqhZdqBvWWx3TrrrBd46/HpAzAQOHUdAD6wMSitTc=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
	VI1PR08MB4573.eurprd08.prod.outlook.com (20.178.126.206) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Tue, 14 May 2019 12:10:47 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900]) by VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900%3]) with mapi id 15.20.1878.024;
	Tue, 14 May 2019 12:10:47 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v7 6/9] scsi: move unmap error checking to the complete
	callback
Thread-Index: AQHVCk4Q89Y0ADlSmECDOCwW3DOS2A==
Date: Tue, 14 May 2019 12:10:47 +0000
Message-ID: <20190514121015.32190-7-anton.nefedov@virtuozzo.com>
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
x-ms-office365-filtering-correlation-id: 7647bbc3-256f-4dbe-ef18-08d6d8653277
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:VI1PR08MB4573; 
x-ms-traffictypediagnostic: VI1PR08MB4573:
x-microsoft-antispam-prvs: <VI1PR08MB4573F340D23728C88AC531C0F8080@VI1PR08MB4573.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:130;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(386003)(6506007)(102836004)(305945005)(5640700003)(6436002)(66946007)(26005)(316002)(7736002)(6512007)(64756008)(66446008)(66556008)(107886003)(66476007)(73956011)(76176011)(11346002)(446003)(2906002)(6486002)(476003)(2616005)(3846002)(6916009)(25786009)(4326008)(2351001)(186003)(53936002)(6116002)(44832011)(486006)(86362001)(71190400001)(71200400001)(52116002)(50226002)(256004)(14444005)(66066001)(2501003)(1076003)(5660300002)(68736007)(8676002)(99286004)(14454004)(478600001)(36756003)(8936002)(81156014)(81166006)(54906003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4573;
	H:VI1PR08MB4078.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oFlNo9fbPAFnLvuqFwcqSk5V53R9AQS6HfjZfdVQnHrnAWUHZeC4rCd/YIrutsCO7fvd4LR5s5b/vZo7DWBHSXi0Uo3V/p7FJh+VOhPNK394WZJ5VYnm6KgSLRzu7QD9aSgb9l4mmspyUu0lk8RHA4REIL2/bDU/UnRtOh6gvFXUGBEx4gg1NOUl+ABWq3HW2WCQILKX4fQxxm9hw9ZwSQQ64L31W/Eh518N6Ezoxnqp1RulBHpCMLzw2k9kuoAaOGu5ysW+2wioTbFsbalthgUK5rWM6zO0SG/6+vykfyz4EUiCH8nophficwS0Uns761VPa0070ap/Z9yzzm400QE/yAKJdNIEGr9erqVvbRzoGRyFwxMTsmz1WeN5GM35p/XE6lA0MESaFkR6/TEO2dICDYNcZK/IcNtS3/cYRQU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7647bbc3-256f-4dbe-ef18-08d6d8653277
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 12:10:47.2603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4573
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.128
Subject: [Qemu-devel] [PATCH v7 6/9] scsi: move unmap error checking to the
 complete callback
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

VGhpcyB3aWxsIGhlbHAgdG8gYWNjb3VudCB0aGUgb3BlcmF0aW9uIGluIHRoZSBmb2xsb3dpbmcg
Y29tbWl0Lg0KDQpUaGUgZGlmZmVyZW5jZSBpcyB0aGF0IHdlIGRvbid0IGNhbGwgc2NzaV9kaXNr
X3JlcV9jaGVja19lcnJvcigpIGJlZm9yZQ0KdGhlIDFzdCBkaXNjYXJkIGl0ZXJhdGlvbiBhbnlt
b3JlLiBUaGF0IGZ1bmN0aW9uIGFsc28gY2hlY2tzIGlmDQp0aGUgcmVxdWVzdCBpcyBjYW5jZWxs
ZWQsIGhvd2V2ZXIgaXQgc2hvdWxkbid0IGdldCBjYW5jZWxlZCB1bnRpbCBpdA0KeWllbGRzIGlu
IGJsa19haW8oKSBmdW5jdGlvbnMgYW55d2F5Lg0KU2FtZSBhcHByb2FjaCBpcyBhbHJlYWR5IHVz
ZWQgZm9yIGVtdWxhdGVfd3JpdGVfc2FtZS4NCg0KU2lnbmVkLW9mZi1ieTogQW50b24gTmVmZWRv
diA8YW50b24ubmVmZWRvdkB2aXJ0dW96em8uY29tPg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NClJldmlld2VkLWJ5
OiBBbGJlcnRvIEdhcmNpYSA8YmVydG9AaWdhbGlhLmNvbT4NCi0tLQ0KIGh3L3Njc2kvc2NzaS1k
aXNrLmMgfCAxMCArKysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2h3L3Njc2kvc2NzaS1kaXNrLmMgYi9ody9z
Y3NpL3Njc2ktZGlzay5jDQppbmRleCBiNDMyNTQxMDNjLi42ZWZmNDk2YjU0IDEwMDY0NA0KLS0t
IGEvaHcvc2NzaS9zY3NpLWRpc2suYw0KKysrIGIvaHcvc2NzaS9zY3NpLWRpc2suYw0KQEAgLTE2
MDQsOSArMTYwNCw2IEBAIHN0YXRpYyB2b2lkIHNjc2lfdW5tYXBfY29tcGxldGVfbm9pbyhVbm1h
cENCRGF0YSAqZGF0YSwgaW50IHJldCkNCiAgICAgU0NTSURpc2tTdGF0ZSAqcyA9IERPX1VQQ0FT
VChTQ1NJRGlza1N0YXRlLCBxZGV2LCByLT5yZXEuZGV2KTsNCiANCiAgICAgYXNzZXJ0KHItPnJl
cS5haW9jYiA9PSBOVUxMKTsNCi0gICAgaWYgKHNjc2lfZGlza19yZXFfY2hlY2tfZXJyb3Iociwg
cmV0LCBmYWxzZSkpIHsNCi0gICAgICAgIGdvdG8gZG9uZTsNCi0gICAgfQ0KIA0KICAgICBpZiAo
ZGF0YS0+Y291bnQgPiAwKSB7DQogICAgICAgICByLT5zZWN0b3IgPSBsZHFfYmVfcCgmZGF0YS0+
aW5idWZbMF0pOw0KQEAgLTE2NDIsNyArMTYzOSwxMiBAQCBzdGF0aWMgdm9pZCBzY3NpX3VubWFw
X2NvbXBsZXRlKHZvaWQgKm9wYXF1ZSwgaW50IHJldCkNCiAgICAgci0+cmVxLmFpb2NiID0gTlVM
TDsNCiANCiAgICAgYWlvX2NvbnRleHRfYWNxdWlyZShibGtfZ2V0X2Fpb19jb250ZXh0KHMtPnFk
ZXYuY29uZi5ibGspKTsNCi0gICAgc2NzaV91bm1hcF9jb21wbGV0ZV9ub2lvKGRhdGEsIHJldCk7
DQorICAgIGlmIChzY3NpX2Rpc2tfcmVxX2NoZWNrX2Vycm9yKHIsIHJldCwgZmFsc2UpKSB7DQor
ICAgICAgICBzY3NpX3JlcV91bnJlZigmci0+cmVxKTsNCisgICAgICAgIGdfZnJlZShkYXRhKTsN
CisgICAgfSBlbHNlIHsNCisgICAgICAgIHNjc2lfdW5tYXBfY29tcGxldGVfbm9pbyhkYXRhLCBy
ZXQpOw0KKyAgICB9DQogICAgIGFpb19jb250ZXh0X3JlbGVhc2UoYmxrX2dldF9haW9fY29udGV4
dChzLT5xZGV2LmNvbmYuYmxrKSk7DQogfQ0KIA0KLS0gDQoyLjE3LjENCg0K

