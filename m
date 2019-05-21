Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CE1C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE4A21479
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FbPC9Soi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE4A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1FR-0005n0-8L
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 05:39:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hT1EW-0005QV-0t
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hT1EV-0005bV-7I
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:38:56 -0400
Received: from mail-am5eur02on0700.outbound.protection.outlook.com
	([2a01:111:f400:fe07::700]:65251
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hT1ES-0005Z2-PO; Tue, 21 May 2019 05:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=/3eBWs6f8bqcbiMVtxPsPs76Y7CIQSios09ZUNhB/NE=;
	b=FbPC9SoiNoNPT3Po52pHbMcxhbIKqfCdGc5PDEd3yCEzTHeVF7ZuG0TzyiICn9ZM5vOzruhqwn7l9m3Qy4vzEagcczZUJsM2YBb1T5OHSznNYRDcf8GEk30CVQ4K7RKITNjuBsceGQbgXVNllm55SRAMKjf0NGPX7ZzhnYmv9js=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB3031.eurprd08.prod.outlook.com (52.135.163.140) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.15; Tue, 21 May 2019 09:38:50 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Tue, 21 May 2019 09:38:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 0/3] Fix overflow bug in qcow2 discard
Thread-Index: AQHU+dQTIRtQy84OJ0+wrrxOKT4l3aZ1flGA
Date: Tue, 21 May 2019 09:38:49 +0000
Message-ID: <4d40c6f9-36c3-076e-16e2-84b8344704b1@virtuozzo.com>
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190423125706.26989-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0136.eurprd05.prod.outlook.com
	(2603:10a6:7:28::23) To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190521123847277
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7723d20-2255-4624-a0ab-08d6ddd020e2
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB3031; 
x-ms-traffictypediagnostic: AM6PR08MB3031:
x-microsoft-antispam-prvs: <AM6PR08MB30315035108D568A8E3E7610C1070@AM6PR08MB3031.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(136003)(366004)(376002)(346002)(39850400004)(199004)(189003)(66446008)(5660300002)(64756008)(66476007)(66556008)(31686004)(4744005)(256004)(31696002)(66066001)(478600001)(86362001)(14454004)(446003)(11346002)(186003)(26005)(486006)(66946007)(73956011)(476003)(2616005)(316002)(99286004)(3846002)(6116002)(6512007)(6246003)(7736002)(2501003)(54906003)(53936002)(305945005)(110136005)(8676002)(2906002)(6486002)(102836004)(6436002)(6506007)(386003)(25786009)(229853002)(4326008)(8936002)(81156014)(68736007)(76176011)(52116002)(71200400001)(71190400001)(81166006)(36756003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3031;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sfdA7SQhyDnMaCZBx4gQYo/lThyBvPUXFr3E2LKJRxBUWGL219pEw4Z7HnwJWWJoH5KXRPCRB+hDfGu0RFndT98bdfP0L1anbrmb55jGCo/y1Qs3/g+saFhOXtwx3mdBMH/otueGd26XrDNitbNqEZxxToUGWoIEIB96DBRfmDS35Z//n1yq4fQmXFsgAf9sleIY0KVjJralQSsh5a+OFUkAoIa9oaKPKKNVAgx1Cj1UzKikXlBLR35NoQK0bvBUH6ss3D1i4R5fJ618awMBNFF5FRSe1cYGoVnjqJaX//55kfSFZYac3SPQkDwBZJ4laXKOYpEnJYOtWYX4VCj1AUEYVE/n1tzlZb93WotyOPdSrvxOc9+mvPhbXz6vYCC6BqFU4+zCxXXSREPo9OF6gtegfwJJddXk4TO3duQYCT4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4471156A33B99F41B2FF572741361821@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7723d20-2255-4624-a0ab-08d6ddd020e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 09:38:49.8609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3031
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::700
Subject: Re: [Qemu-devel] [PATCH v5 0/3] Fix overflow bug in qcow2 discard
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQoyMy4wNC4yMDE5IDE1OjU3LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiB2NTogYnkgS2V2aW4ncyBjb21tZW50cw0KPiAwMjogYWRkIGNoZWNrIGZvciBpbnZh
bGlkIEBieXRlcyBwYXJhbWV0ZXIsIGRyb3Agci1iDQo+IDAzOiBtb3ZlIGZyb20gcWVtdS1pbWcg
aW5mbyB0byBxZW11LWltZyBtYXAgLWYgcmF3LCBkcm9wIHItYiBhbmQgdC1iDQo+IA0KPiBWbGFk
aW1pciBTZW1lbnRzb3YtT2dpZXZza2l5ICgzKToNCj4gICAgYmxvY2svcWNvdzItcmVmY291bnQ6
IGFkZCB0cmFjZS1wb2ludCB0byBxY293Ml9wcm9jZXNzX2Rpc2NhcmRzDQo+ICAgIGJsb2NrL2lv
OiBiZHJ2X3BkaXNjYXJkOiBzdXBwb3J0IGludDY0X3QgYnl0ZXMgcGFyYW1ldGVyDQo+ICAgIGlv
dGVzdHM6IHRlc3QgYmlnIHFjb3cyIHNocmluaw0KPiANCj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2Nr
LmggICAgICB8ICA0ICstLQ0KPiAgIGJsb2NrL2lvLmMgICAgICAgICAgICAgICAgIHwgMTYgKysr
Ky0tLS0tDQo+ICAgYmxvY2svcWNvdzItcmVmY291bnQuYyAgICAgfCAgNyArKystDQo+ICAgYmxv
Y2svdHJhY2UtZXZlbnRzICAgICAgICAgfCAgMyArKw0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8y
NTAgICAgIHwgNzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICB0
ZXN0cy9xZW11LWlvdGVzdHMvMjUwLm91dCB8IDIzICsrKysrKysrKysrKw0KPiAgIHRlc3RzL3Fl
bXUtaW90ZXN0cy9ncm91cCAgIHwgIDEgKw0KPiAgIDcgZmlsZXMgY2hhbmdlZCwgMTE2IGluc2Vy
dGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9x
ZW11LWlvdGVzdHMvMjUwDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3FlbXUtaW90ZXN0
cy8yNTAub3V0DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

