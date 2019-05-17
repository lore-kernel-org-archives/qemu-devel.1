Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE77C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05212206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Y5xvWCf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05212206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44113 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRXtF-00041L-6J
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:06:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hRXs1-00031w-Vg
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hRXs0-0005G3-TA
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:05:37 -0400
Received: from mail-eopbgr20132.outbound.protection.outlook.com
	([40.107.2.132]:4356
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hRXrw-0005EN-QT; Fri, 17 May 2019 04:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=VE1MxDWBcnO1+fuFN9974KGvzd0LqwifvTyIJ0iy65A=;
	b=Y5xvWCf/iHpQ4luzMAUBitFDfkjuklhqDsx7ierDszoK6q8lHiRX5FKmxCKuLbOWAcoYxzGnCMov5eaffKv0zuDbToqzWvzunX5sWP7eaL0cD+Qss22wXEvssroglaLj1QI5X58WjdueqSO8S2m52GvGeev3XT0XdYr96BKD/ic=
Received: from AM6PR08MB4899.eurprd08.prod.outlook.com (10.255.99.74) by
	AM6PR08MB4981.eurprd08.prod.outlook.com (10.255.120.203) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.24; Fri, 17 May 2019 08:05:27 +0000
Received: from AM6PR08MB4899.eurprd08.prod.outlook.com
	([fe80::998:b814:8925:8b7c]) by AM6PR08MB4899.eurprd08.prod.outlook.com
	([fe80::998:b814:8925:8b7c%7]) with mapi id 15.20.1878.024;
	Fri, 17 May 2019 08:05:27 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
	"kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
	<mreitz@redhat.com>
Thread-Topic: [Qemu-block] [PATCH v1] [RFC] qcow2: add compression type feature
Thread-Index: AQHVDD6oioy5+bRD60yYcxdLxqGuHKZu9hOA
Date: Fri, 17 May 2019 08:05:27 +0000
Message-ID: <3a4c358f-673b-c123-772d-da02ce9a4b71@virtuozzo.com>
References: <20190516134844.3683-1-dplotnikov@virtuozzo.com>
	<aff325ca-ebea-126e-aca5-84a5ef431845@redhat.com>
In-Reply-To: <aff325ca-ebea-126e-aca5-84a5ef431845@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0050.eurprd09.prod.outlook.com
	(2603:10a6:7:3c::18) To AM6PR08MB4899.eurprd08.prod.outlook.com
	(2603:10a6:20b:ce::10)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff622bd3-85d3-4af4-e7fb-08d6da9e6c02
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB4981; 
x-ms-traffictypediagnostic: AM6PR08MB4981:
x-microsoft-antispam-prvs: <AM6PR08MB4981D1ABF5532E5357F323A3CF0B0@AM6PR08MB4981.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(14444005)(7736002)(36756003)(102836004)(486006)(14454004)(5660300002)(6506007)(31686004)(478600001)(3846002)(53546011)(66066001)(386003)(71190400001)(2201001)(71200400001)(31696002)(86362001)(6116002)(53936002)(52116002)(229853002)(81166006)(6512007)(316002)(8676002)(81156014)(256004)(107886003)(25786009)(2616005)(73956011)(8936002)(64756008)(66446008)(66946007)(476003)(68736007)(54906003)(446003)(2501003)(305945005)(99286004)(11346002)(110136005)(26005)(2906002)(6246003)(66556008)(66476007)(186003)(76176011)(6486002)(4326008)(6436002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4981;
	H:AM6PR08MB4899.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gJCGuxt6+BK93kIFdrPugSsM51bBod3VqjEhdNffnavVm5x/TpP3l9mN0/PokJKHkmxSVFRmcIEV5wM7QPHp5RFbD0qZ7oWZBpZM6sQDCjhoSkBvQqDKRSZE71R7IlRsq42JnQgDSjX3cyzWnYihBozn15nRxKmuRAH0mIvAn6vQlR82MUW8/9+/mSHsTID7grJWsRZQ9abiN4FbcZRiRWnAe6zMlUWcgqjSEFpvIMQqNN9ntRft0SD/p0472GMqbzL1Rd0eNoXdfHgEQUn/UO6NaRLnt8JfwJbsbO9meNGYM4u0pWPeTt5E988gjwwOCjSuzyeqgSVzugJ+ahpF5r+lB/fdutkKdumrMz7mIIIRmYbMo/dSJ75Ml9Ll6TyuDr24nWOxbqC2/5T6/MJOp3nelQUD9FrMKwj5nDj3Yug=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FF0A27A621B274684C363FC7A62A8F5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff622bd3-85d3-4af4-e7fb-08d6da9e6c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 08:05:27.4529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4981
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.132
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v1] [RFC] qcow2: add
 compression type feature
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE3LjA1LjIwMTkgMjoyNSwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDUv
MTYvMTkgOTo0OCBBTSwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPj4gVGhlIHBhdGNoIGFkZHMg
c29tZSBwcmVwYXJhdGlvbiBwYXJ0cyBmb3IgaW5jb21wYXRpYmxlIGNvbXByZXNzaW9uIHR5cGUN
Cj4+IGZlYXR1cmUgaW50byBRQ09XMiBoZWFkZXIgdGhhdCBpbmRpY2F0ZXMgdGhhdCAqYWxsKiBj
b21wcmVzc2VkIGNsdXN0ZXJzDQo+PiBtdXN0IGJlIChkZSljb21wcmVzc2VkIHVzaW5nIGEgY2Vy
dGFpbiBjb21wcmVzc2lvbiB0eXBlLg0KPj4NCj4+IEl0IGlzIGltcGxpZWQgdGhhdCB0aGUgY29t
cHJlc3Npb24gdHlwZSBpcyBzZXQgb24gdGhlIGltYWdlIGNyZWF0aW9uIGFuZA0KPj4gY2FuIGJl
IGNoYW5nZWQgb25seSBsYXRlciBieSBpbWFnZSBjb252ZXJzaW9uLCB0aHVzIHRoZSBvbmx5IGNv
bXByZXNzaW9uDQo+PiBhbGdvcml0aG0gaXMgdXNlZCBmb3IgdGhlIGltYWdlLg0KPj4NCj4+IFRo
ZSBwbGFuIGlzIHRvIGFkZCBzdXBwb3J0IGZvciBaU1REIGFuZCB0aGVuIG1heSBiZSBzb21ldGhp
bmcgbW9yZSBlZmZlY3RpdmUNCj4+IGluIHRoZSBmdXR1cmUuDQo+Pg0KPj4gWlNURCBjb21wcmVz
c2lvbiBhbGdvcml0aG0gY29uc3VtZXMgMy01IHRpbWVzIGxlc3MgQ1BVIHBvd2VyIHdpdGggYQ0K
Pj4gY29tcGFyYWJsZSBjb21wcmVzc2lvbiByYXRpbyB3aXRoIHpsaWIuIEl0IHdvdWxkIGJlIHdp
c2UgdG8gdXNlIGl0IGZvcg0KPj4gZGF0YSBjb21wcmVzc2lvbiBlLmcuIGZvciBiYWNrdXBzLg0K
Pj4NCj4+IFRoZSBkZWZhdWx0IGNvbXByZXNzaW9uIGlzIFpMSUIuDQo+Pg0KPiANCj4gKE1lcmVs
eSBhIGN1cmlvc2l0eTopDQo+IA0KPiBTaW5jZSB0aGlzIGlzIGNvbWluZyBmcm9tIFZpcnR1b3p6
bywgSSB0cnVzdCB0aGF0IHlvdSd2ZSBoYWQgZ29vZCBsdWNrDQo+IHdpdGggWlNURCBhbHJlYWR5
IGluIFImRC4gV2hhdCBkbyB0aGUgY29tcHJlc3Npb24gcmF0aW9zIGxvb2sgbGlrZSBpbg0KPiBw
cmFjdGljZT8gSXQncyB0b3V0ZWQgYXMgImNvbXBhcmFibGUgdG8gemxpYiIgd2hpY2ggY2VydGFp
bmx5IGRvZXMgc291bmQNCj4gcXVpdGUgbmljZSBmb3Igc3RyZWFtaW5nIGNvbXByZXNzaW9uIG9m
IGJhY2t1cHMuDQo+IA0KPiBJIHN1cHBvc2UgaW4gdGhlIHdvcnN0IGNhc2UgaXQgb3VnaHQgdG8g
YmUgZmFzdGVyIHRoYW4gYmFuZHdpZHRoIHNwZWVkcywNCj4gc28gbm8gaGFybSBpbiB1dGlsaXpp
bmcgaXQuDQpZZXMsIHdlIGRpZCBzb21lIHJlc2VhcmNoIG9uIGl0LiBBY3R1YWxseSwgdGhlcmUg
aXMgYSBwYXRjaCBpbiB0aGUgDQptYWlsaW5nIGxpc3QgKHBsZWFzZSwgdGFrZSBhIGxvb2s6ICkg
d2hpY2ggYXBwbGllcyBaU1REIGNvbXByZXNzaW9uIGluIA0KdGhlIG1pZ3JhdGlvbi4NCkhlcmUg
YXJlIHRoZSBudW1iZXJzIGZyb20gdGhlcmU6DQoNCmhvc3Q6IGk3LTQ3OTAgOHhDUFUgQCAzLjYw
R0h6LCAxNkcgUkFNDQptaWdyYXRpb24gdG8gdGhlIHNhbWUgaG9zdA0KVk06IDJ4VkNQVSwgOEcg
UkFNIHRvdGFsDQo1RyBSQU0gdXNlZCwgbWVtb3J5IHBvcHVsYXRlZCB3aXRoIHBvc3RncmVxc2wg
ZGF0YQ0KcHJvZHVjZWQgYnkgcGdiZW5jaCBwZXJmb3JtYW5jZSBiZW5jaG1hcmsNCg0KVGhyZWFk
czogMSBjb21wcmVzcyDigJMgMSBkZWNvbXByZXNzDQoNCnpzdGQgcHJvdmlkZXMgc2xpZ2h0bHkg
bGVzcyBjb21wcmVzc2lvbiByYXRpbyB3aXRoIGFsbW9zdCB0aGUgc2FtZQ0KQ1BVIHVzYWdlIGJ1
dCBjb3BlcyB3aXRoIFJBTSBjb21wcmVzc2lvbiByb3VnaGx5IDIgdGltZXMgZmFzdGVyDQoNCmNv
bXByZXNzaW9uIHR5cGUgICAgICAgICAgICAgIHpsaWIgICAgICAgfCAgICAgIHpzdGQNCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KY29t
cHJlc3Npb24gbGV2ZWwgICAgICAgICAgMSAgICAgICA1ICAgICB8ICAgMSAgICAgICA1DQpjb21w
cmVzc2lvbiByYXRpbyAgICAgICAgICA2LjkyICAgIDcuMDUgIHwgICA2LjY5ICAgIDYuODkNCmNw
dSBpZGxlLCAlICAgICAgICAgICAgICAgIDgyICAgICAgODMgICAgfCAgIDg2ICAgICAgODANCnRp
bWUsIHNlYyAgICAgICAgICAgICAgICAgIDQ5ICAgICAgNzEgICAgfCAgIDI2ICAgICAgMzENCnRp
bWUgZGlmZiB0byB6bGliLCBzZWMgICAgICAgICAgICAgICAgICAgfCAgLTI1ICAgICAtNDENCnRp
bWUgZGlmZiB0byB6bGliLCAlICAgICAgICAgICAgICAgICAgICAgfCAgLTQ3JSAgICAtNTYlDQoN
CkkgZ2VuZXJhbCBaU1REIHByb3ZpZGVzIGJldHRlciBjb21wcmVzc2lvbiByYXRpbyBvbiBiaWcg
ZGVwZW5kZW50IGNodW5rcyANCm9mIGRhdGEuIFRoYW4gYmlnZ2VyIHRoZSBkYXRhIHNpemUgdGhl
biBiZXR0ZXIgWlNURCBpdCBjb21wcmVzc2VzLg0KDQpTaW5jZSwgaW4gb3VyIGNhc2VzIChtaWdy
YXRpb246IDRLIFJBTSBibG9jaywgcWNvdzI6IGNsdXN0ZXIpIHdlDQpoYXZlIHRvIGNvbXByZXNz
IGluZGVwZW5kZW50IGNodW5rcyB0aGUgYWJpbGl0eSBvZiBaU1REIHRvIGZpbmQgYmV0dGVyIA0K
Y29tcHJlc3Npb24gc29sdXRpb24gaXMgcmVzdHJpY3RlZC4NCg0KQWx0aG91Z2gsIHRoZSBjb21w
cmVzc2lvbiByYXRpbyBpcyBwcmV0dHkgbXVjaCB0aGUgc2FtZSBpbiBib3RoIGNhc2VzIA0KdGhl
IGV4cGVyaW1lbnRzIHNob3duIHRoYXQgWlNURCBkb2VzIHRoZSBjb21wcmVzc2lvbiBtdWNoIGZh
c3RlciAoeDIpLg0KDQpXaGljaCBpcyBvYnZpb3VzbHkgZ29vZCBmb3IgdXMuDQoNCkhlcmUgaXMg
b3RoZXIgY29tcGFyaXNvbiBvZiBaTElCIHZzIFpTVEQgd2l0aG91dCBhbnkgYXBwbGljYXRpb24g
aW4gcWVtdSANCndoaWNoIHNob3dzIHRoYXQgWlNURCB3b3JrcyBmYXN0ZXINCg0KemxpYiA9IG1h
eCBjb21wcmVzc2lvbiBsZXZlbA0KenN0ZCA9IGNvbXByZXNzaW9uIGxldmVsIDUgKG1heCAyMikN
Cg0KY3ljbGVzIGNvbnN1bWVkIGZvciBjb21wcmVzc2lvbjoNCgkJCQkJCQ0KCTRrIHR4dAk0SyBy
YW0JNEsgYmluCTY0SyB0eHQJIDY0SyByYW0gIDY0SyBiaW4NCnpsaWIJICA0MDBLCSAgMzQ0Swkg
IDEuM00JICAgIDEzTSAgICAgICA1TSAgICA5Mi4zTQ0KenN0ZCAJICAzNTBLCSAgMjM1SwkgIDMx
MksJICAgMy4zTSAgICAgMS4zTSAgICAgMi40TQ0KRGlmZiwlCSAgIC0xMgkgICAtMzIJICAgLTc3
CSAgICAtNzUgICAgICAtNzMgICAgICAtOTcNCgkJCQkJCQ0Kc2l6ZSBhZnRlciBjb21wcmVzc2lv
biBpbiBieXRlczoNCg0KCTRrIHR4dAk0SyByYW0JNEsgYmluCTY0SyB0eHQJIDY0SyByYW0gIDY0
SyBiaW4NCnpsaWIJICAxNTQyCSAgMzU5OQkgIDE0MDMJMTczODYJICA2NDczNQkgICAgMjA2MDkN
CnpzdGQgCSAgMTU2OAkgIDM1NDAJICAxMjUwCTE3NjU2CSAgNjU1NDYJICAgIDIwMDIzDQpEaWZm
LCUJICAgIC0yCSAgICAgMgkgICAgMTEJICAgLTIJICAgICAtMQkgICAgICAgIDMNCg0KRGF0YSBz
b3VyY2VzIGZvciB0ZXN0IGZpbGVzIFt3ZSB0b29rIDRLIGFuZCA2NEsgY2h1bmtzIGZyb20gdGhl
cmVdOg0KDQp0eHQgPSBsaW51eC9Eb2N1bWVudGF0aW9uL21lbW9yeS1iYXJyaWVycy50eHQNCnJh
bSA9IC9ib290L2luaXRyYW1mcy00LjIwLjAtcmM2Ky5pbWcNCmJpbiA9IHg4Nl82NC1zb2Z0bW11
L3FlbXUtc3lzdGVtLXg4Nl82NA0KDQpJbmNyZWFzaW5nIG9mIFpTVEQgY29tcHJlc3Npb24gcmF0
aW8gZGlkbid0IGdpdmUgYW55IHNpZ25pZmljYW50IA0KaW1wcm92ZW1lbnRzIG9mIHRoZSBvdXQg
c2l6ZSBidXQgc2xvd2VkIGRvd24gdGhlIHBhY2Ugb2YgWlNURA0KDQpEZW5pcw0KDQo+IA0KPj4g
U2lnbmVkLW9mZi1ieTogRGVuaXMgUGxvdG5pa292IDxkcGxvdG5pa292QHZpcnR1b3p6by5jb20+
DQoNCi0tIA0KQmVzdCwNCkRlbmlzDQo=

