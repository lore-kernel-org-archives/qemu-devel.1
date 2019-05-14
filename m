Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F67BC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC285208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T/DAOnFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC285208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47275 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQWJc-0005Sf-2c
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 08:13:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGn-0003Hi-GI
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGl-00021I-31
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:10:57 -0400
Received: from mail-eopbgr10138.outbound.protection.outlook.com
	([40.107.1.138]:29223
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hQWGh-0001va-1D; Tue, 14 May 2019 08:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=8Vuro0sVpR0xlJmaNRlVzc6rhupoWU7IJROEwWQ3Whw=;
	b=T/DAOnFazV5NCDkRuLmRQneQGFhadI2tuyveLTkBSHuGLlLOye28kXS+6RP1cTx4Z7V4U5PXg4pzKw7PbilDsJwOOpyaYWkqIc1LdIGrq1q70KRu/bslEZZAQs1CiZX7FFUA7NgNumTBwSpdsVO4TooXH6KD0iQ1+xKhT3hGJOY=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
	VI1PR08MB4573.eurprd08.prod.outlook.com (20.178.126.206) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Tue, 14 May 2019 12:10:46 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900]) by VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900%3]) with mapi id 15.20.1878.024;
	Tue, 14 May 2019 12:10:46 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v7 5/9] scsi: store unmap offset and nb_sectors in
	request struct
Thread-Index: AQHVCk4PBXRkD3MHw0CKqzQxcpy1IA==
Date: Tue, 14 May 2019 12:10:46 +0000
Message-ID: <20190514121015.32190-6-anton.nefedov@virtuozzo.com>
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
x-ms-office365-filtering-correlation-id: 5f137c87-cc61-4028-66a0-08d6d86531c9
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:VI1PR08MB4573; 
x-ms-traffictypediagnostic: VI1PR08MB4573:
x-microsoft-antispam-prvs: <VI1PR08MB4573BD1A6F17F8C875040E3FF8080@VI1PR08MB4573.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:224;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(386003)(6506007)(102836004)(305945005)(5640700003)(6436002)(66946007)(26005)(316002)(7736002)(6512007)(64756008)(66446008)(66556008)(107886003)(66476007)(73956011)(76176011)(11346002)(446003)(2906002)(6486002)(476003)(2616005)(3846002)(6916009)(25786009)(4326008)(2351001)(186003)(53936002)(6116002)(44832011)(486006)(86362001)(71190400001)(71200400001)(52116002)(50226002)(256004)(66066001)(2501003)(1076003)(5660300002)(68736007)(8676002)(99286004)(14454004)(478600001)(36756003)(8936002)(81156014)(81166006)(54906003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4573;
	H:VI1PR08MB4078.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lE1RdAmIzg8rAR9+r9WryU2oqWiPLR+9PixaTv4InZMS9ajgxxUeWpUtuXjFOD2BzMR7EHpytevJOVSoY9mCtouxI/bN7F3tSkuEgdaikymIC+2zAbgTdxVnfM6GV4XNLw7AWtzmlcYRv63MTnRt/INeroFO3hFVmNeIF8luBUPcPzFPsHQUhSHF3yesod83BRqKRtjcIGSM9pzsT0KPONv1yRDoUqVjv4qobtLeoOf6EAfamgdb1gQ/JBI2zi9NKh6TbDiJXvMAroLpIbSkaYH5mmq7tjNivtn2Kgh4UYqv2tYMF7s3cQ6go1yY3zxpFzwR5KgUSQPU+rYDvohYxEevcc2htmuOETB2nHcv6+qyUdZy3QyH+RtcwUBTog04CWKAORfO2SM9c+B+iVk372sYoIYd5bsbz1QV3BGmiqU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f137c87-cc61-4028-66a0-08d6d86531c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 12:10:46.0814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4573
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.138
Subject: [Qemu-devel] [PATCH v7 5/9] scsi: store unmap offset and nb_sectors
 in request struct
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

aXQgYWxsb3dzIHRvIHJlcG9ydCBpdCBpbiB0aGUgZXJyb3IgaGFuZGxlcg0KDQpTaWduZWQtb2Zm
LWJ5OiBBbnRvbiBOZWZlZG92IDxhbnRvbi5uZWZlZG92QHZpcnR1b3p6by5jb20+DQpSZXZpZXdl
ZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPg0KUmV2aWV3ZWQtYnk6IEFsYmVydG8gR2FyY2lhIDxiZXJ0b0BpZ2FsaWEuY29tPg0KLS0t
DQogaHcvc2NzaS9zY3NpLWRpc2suYyB8IDEyICsrKysrLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9zY3Np
L3Njc2ktZGlzay5jIGIvaHcvc2NzaS9zY3NpLWRpc2suYw0KaW5kZXggZTdlODY1YWIzYi4uYjQz
MjU0MTAzYyAxMDA2NDQNCi0tLSBhL2h3L3Njc2kvc2NzaS1kaXNrLmMNCisrKyBiL2h3L3Njc2kv
c2NzaS1kaXNrLmMNCkBAIC0xNjAyLDggKzE2MDIsNiBAQCBzdGF0aWMgdm9pZCBzY3NpX3VubWFw
X2NvbXBsZXRlX25vaW8oVW5tYXBDQkRhdGEgKmRhdGEsIGludCByZXQpDQogew0KICAgICBTQ1NJ
RGlza1JlcSAqciA9IGRhdGEtPnI7DQogICAgIFNDU0lEaXNrU3RhdGUgKnMgPSBET19VUENBU1Qo
U0NTSURpc2tTdGF0ZSwgcWRldiwgci0+cmVxLmRldik7DQotICAgIHVpbnQ2NF90IHNlY3Rvcl9u
dW07DQotICAgIHVpbnQzMl90IG5iX3NlY3RvcnM7DQogDQogICAgIGFzc2VydChyLT5yZXEuYWlv
Y2IgPT0gTlVMTCk7DQogICAgIGlmIChzY3NpX2Rpc2tfcmVxX2NoZWNrX2Vycm9yKHIsIHJldCwg
ZmFsc2UpKSB7DQpAQCAtMTYxMSwxNiArMTYwOSwxNiBAQCBzdGF0aWMgdm9pZCBzY3NpX3VubWFw
X2NvbXBsZXRlX25vaW8oVW5tYXBDQkRhdGEgKmRhdGEsIGludCByZXQpDQogICAgIH0NCiANCiAg
ICAgaWYgKGRhdGEtPmNvdW50ID4gMCkgew0KLSAgICAgICAgc2VjdG9yX251bSA9IGxkcV9iZV9w
KCZkYXRhLT5pbmJ1ZlswXSk7DQotICAgICAgICBuYl9zZWN0b3JzID0gbGRsX2JlX3AoJmRhdGEt
PmluYnVmWzhdKSAmIDB4ZmZmZmZmZmZVTEw7DQotICAgICAgICBpZiAoIWNoZWNrX2xiYV9yYW5n
ZShzLCBzZWN0b3JfbnVtLCBuYl9zZWN0b3JzKSkgew0KKyAgICAgICAgci0+c2VjdG9yID0gbGRx
X2JlX3AoJmRhdGEtPmluYnVmWzBdKTsNCisgICAgICAgIHItPnNlY3Rvcl9jb3VudCA9IGxkbF9i
ZV9wKCZkYXRhLT5pbmJ1Zls4XSkgJiAweGZmZmZmZmZmVUxMOw0KKyAgICAgICAgaWYgKCFjaGVj
a19sYmFfcmFuZ2Uocywgci0+c2VjdG9yLCByLT5zZWN0b3JfY291bnQpKSB7DQogICAgICAgICAg
ICAgc2NzaV9jaGVja19jb25kaXRpb24ociwgU0VOU0VfQ09ERShMQkFfT1VUX09GX1JBTkdFKSk7
DQogICAgICAgICAgICAgZ290byBkb25lOw0KICAgICAgICAgfQ0KIA0KICAgICAgICAgci0+cmVx
LmFpb2NiID0gYmxrX2Fpb19wZGlzY2FyZChzLT5xZGV2LmNvbmYuYmxrLA0KLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZWN0b3JfbnVtICogcy0+cWRldi5ibG9ja3Np
emUsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5iX3NlY3RvcnMg
KiBzLT5xZGV2LmJsb2Nrc2l6ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgci0+c2VjdG9yICogcy0+cWRldi5ibG9ja3NpemUsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHItPnNlY3Rvcl9jb3VudCAqIHMtPnFkZXYuYmxvY2tzaXpl
LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzY3NpX3VubWFwX2Nv
bXBsZXRlLCBkYXRhKTsNCiAgICAgICAgIGRhdGEtPmNvdW50LS07DQogICAgICAgICBkYXRhLT5p
bmJ1ZiArPSAxNjsNCi0tIA0KMi4xNy4xDQoNCg==

