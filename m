Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F694C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 12:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B60207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 12:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KxCbXBQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B60207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46018 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haJaM-0008Pz-4e
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 08:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34365)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haJZq-0007xJ-UW
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haJZq-0002wi-0w
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:39:06 -0400
Received: from mail-eopbgr10102.outbound.protection.outlook.com
 ([40.107.1.102]:6467 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1haJZn-0002p2-6f; Mon, 10 Jun 2019 08:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CroH/0gfcOfmmTtnynSCL7MK3NJ+yf2o2rKtw3rEcs=;
 b=KxCbXBQbc22SolDhqeoJ5thSUhg7Juy7oi/NrrjaPGO5L2taf5kdANGgl0aUPv9x4nGZIbeZ9vaFwmTLW/jpBpyEafXOIej2QC33iLDMcae7qE+oaJ3FdwbhWBShtAauLlI9JhdPqZWKYg0fP9CeIEHCaGCzuI22qHJ+ROuX9qE=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB5235.eurprd08.prod.outlook.com (20.179.39.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 10 Jun 2019 12:38:49 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 12:38:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 6/7] block/nbd-client: nbd reconnect
Thread-Index: AQHU8IvOU96perqu+EiRV82H4T/8KaaP3geAgAVTxoA=
Date: Mon, 10 Jun 2019 12:38:49 +0000
Message-ID: <76780fdb-4c00-a8bd-4323-15bdd403fbaf@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-7-vsementsov@virtuozzo.com>
 <0b64cff5-33fa-0945-504c-b1bdd004c42a@redhat.com>
In-Reply-To: <0b64cff5-33fa-0945-504c-b1bdd004c42a@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0312.eurprd05.prod.outlook.com
 (2603:10a6:7:93::43) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190610153847101
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 943e7b42-84a9-4e80-0da5-08d6eda09668
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB5235; 
x-ms-traffictypediagnostic: AM0PR08MB5235:
x-microsoft-antispam-prvs: <AM0PR08MB5235B27159FE4150414702C1C1130@AM0PR08MB5235.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(396003)(366004)(376002)(136003)(189003)(199004)(8936002)(71190400001)(36756003)(71200400001)(25786009)(305945005)(31686004)(7736002)(6512007)(68736007)(256004)(2616005)(486006)(186003)(2501003)(81166006)(6436002)(478600001)(6486002)(8676002)(81156014)(6246003)(476003)(4326008)(11346002)(229853002)(107886003)(73956011)(53936002)(66446008)(64756008)(66556008)(66946007)(66476007)(99286004)(446003)(2201001)(26005)(66066001)(52116002)(3846002)(76176011)(102836004)(2906002)(110136005)(14454004)(31696002)(5660300002)(54906003)(86362001)(6506007)(386003)(6116002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5235;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CSVedDK6U+8HMZ9/JSKOj70euXNehJKLiGqYUpcNZF5BzksAmgDZz9WRPRQwy4VLmhjofQgoqNggf0sqb8+FAcs/iMBPihlrxgGafDaPVzlfhflGP/dBDUnNE+Z80VzeRxXS2GtHFLfB5wc6ul8rYy72qv2D9Yv+2FxYYSk++S7xRz7L4BbaBMY0bEMGa+Zab60X9ANZTo1n5ZSae1HdorZ4grGWeGQjbzuQNnqO1DvpYDB6e6jhUypsgbMqQuEBH4ngze4cOtAaYJCp+m1CC1bk9uDEg7E8GveQ9ZVEvQ0l4furKVSIbdeGLKDWLpgZMt4fY3Su19JX52ZI1QRcYIlEBPQE+USM7hTbzc+rG8NkpRhdaVp2aLBb2NIC25/6XTg7Bwi+bjDelvrlH+vNp+v/J+BC66j+lQGTSxtJ5ZY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3927E1F7264980489884393FF9F57FA0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943e7b42-84a9-4e80-0da5-08d6eda09668
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 12:38:49.6903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5235
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.102
Subject: Re: [Qemu-devel] [PATCH v6 6/7] block/nbd-client: nbd reconnect
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMDYuMjAxOSA2OjE3LCBFcmljIEJsYWtlIHdyb3RlOg0KPj4gK3R5cGVkZWYgc3RydWN0IE5C
RENvbm5lY3Rpb24gew0KPj4gKyAgICBCbG9ja0RyaXZlclN0YXRlICpiczsNCj4+ICsgICAgU29j
a2V0QWRkcmVzcyAqc2FkZHI7DQo+PiArICAgIGNvbnN0IGNoYXIgKmV4cG9ydDsNCj4+ICsgICAg
UUNyeXB0b1RMU0NyZWRzICp0bHNjcmVkczsNCj4+ICsgICAgY29uc3QgY2hhciAqaG9zdG5hbWU7
DQo+PiArICAgIGNvbnN0IGNoYXIgKnhfZGlydHlfYml0bWFwOw0KPj4gK30gTkJEQ29ubmVjdGlv
bjsNCj4gQ2FuIHdlIHB1dCB0aGlzIHR5cGUgaW4gYSBoZWFkZXIsIGFuZCB1c2UgaXQgaW5zdGVh
ZCBvZiBwYXNzaW5nIGxvdHMgb2YNCj4gaW5kaXZpZHVhbCBwYXJhbWV0ZXJzIHRvIG5iZF9jbGll
bnRfY29ubmVjdCgpPyAgUHJvYmFibHkgYXMgYSBzZXBhcmF0ZQ0KPiBwcmUtcmVxdWlzaXRlIGNs
ZWFudXAgcGF0Y2guDQo+IA0KDQoNCkhtbSwgYW5kIHRoZW4sIGluY2x1ZGUgaXQgaW50byBCRFJW
TkJEU3RhdGU/IEkgZG9uJ3QgcmVtZW1iZXIgd2h5IGRpZG4ndCBkbw0KaXQsIGFuZCBub3cgSSBk
b24ndCBzZWUgYW55IHJlYXNvbiBmb3IgaXQuIFdlIHN0b3JlIHRoaXMgaW5mb3JtYXRpb24gYW55
d2F5DQpmb3IgdGhlIHdob2xlIGxpZmUgb2YgdGhlIGRyaXZlci4uDQoNClNvLCBpZiBJJ20gZ29p
bmcgdG8gcmVmYWN0b3IgaXQsIEkgaGF2ZSBhIHF1ZXN0aW9uOiBpcyB0aGVyZSBhIHJlYXNvbiBm
b3INCmxheWVyZWQgQkRSVk5CRFN0YXRlOg0KDQp0eXBlZGVmIHN0cnVjdCBCRFJWTkJEU3RhdGUg
ew0KICAgICBOQkRDbGllbnRTZXNzaW9uIGNsaWVudDsNCg0KICAgICAvKiBGb3IgbmJkX3JlZnJl
c2hfZmlsZW5hbWUoKSAqLw0KICAgICBTb2NrZXRBZGRyZXNzICpzYWRkcjsNCiAgICAgY2hhciAq
ZXhwb3J0LCAqdGxzY3JlZHNpZDsNCn0gQkRSVk5CRFN0YXRlOw0KDQphbmQgdXNlIG5iZF9nZXRf
Y2xpZW50X3Nlc3Npb24gZXZlcnl3aGVyZSBpbnN0ZWFkIG9mIHNpbXBsZSBjb252ZXJ0aW5nIHZv
aWQgKm9wYXF1ZQ0KdG8gU3RhdGUgcG9pbnRlciBsaWtlIGluIHFjb3cyIGZvciBleGFtcGxlPw0K
DQpUaGUgb25seSByZWFzb24gSSBjYW4gaW1hZ2luZSBpcyBub3QgdG8gc2hhcmUgdGhlIHdob2xl
IEJEUlZOQkRTdGF0ZSwgYW5kIGtlZXANCnRoaW5ncyB3ZSBhcmUgdXNpbmcgb25seSBpbiBuYmQu
YyB0byBiZSBhdmFpbGFibGUgb25seSBpbiBuYmQuYy4uIEJ1dCBJJ3ZlIHB1dA0Kc2FkZHIgYW5k
IGV4cG9ydCB0byBOQkRDb25uZWN0aW9uIHRvIGJlIHVzZWQgaW4gbmJkLWNsaWVudC5jIGFueXdh
eS4gU28sIEkgdGhpbmsNCml0J3MgYSBnb29kIG1vbWVudCB0byBmbGF0dGVuIGFuZCBzaGFyZSBC
RFJWTkJEU3RhdGUgYW5kIGRyb3AgbmJkX2dldF9jbGllbnRfc2Vzc2lvbi4NCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

