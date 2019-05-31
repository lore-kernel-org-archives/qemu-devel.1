Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AC5C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54F826B47
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XKisCamk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54F826B47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWk8v-0007aN-0I
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 12:12:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWk4o-0004GD-HQ
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWjvb-0002Cl-R6
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:58:48 -0400
Received: from mail-eopbgr10094.outbound.protection.outlook.com
	([40.107.1.94]:62247
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hWjvY-0002A4-Kv; Fri, 31 May 2019 11:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=nVTb6/VuY3N49ZQH9jpwtAqMHoMeW6bpFrIqHp9jAz4=;
	b=XKisCamki0uYfN08aTxzGd0RIzXPBER5ucqJbZ9JdKoROuVuW5QERarOXoSKFcHauMg2/YP8tNVQ/C7N0O3Gu3+ThTl5f3BUH/NTCKRLgF3gAJpSSSf27O+3y7IKu5X364GiQ0O6RZHvFtbJB7Uvrk6eI2XTGfDp2TDml+v5Do0=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB4323.eurprd08.prod.outlook.com (20.179.33.141) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.16; Fri, 31 May 2019 15:58:40 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1943.018;
	Fri, 31 May 2019 15:58:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH 2/2] block/io: refactor padding
Thread-Index: AQHVF57GDAlVf4H2S0esbxHLYKgnbqaFeDCA///pcACAAAKNAA==
Date: Fri, 31 May 2019 15:58:40 +0000
Message-ID: <57dbb68c-653c-063a-15aa-33e15af42c7a@virtuozzo.com>
References: <20190528084544.183558-1-vsementsov@virtuozzo.com>
	<20190528084544.183558-3-vsementsov@virtuozzo.com>
	<20190531105101.GB29868@stefanha-x1.localdomain>
	<6cddd33f-9d09-cff0-b8dd-c2c0e8696e69@virtuozzo.com>
	<20190531154930.GF9842@localhost.localdomain>
In-Reply-To: <20190531154930.GF9842@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0307.eurprd05.prod.outlook.com
	(2603:10a6:7:93::38) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190531185838151
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51c414fd-90e5-44e3-ddd2-08d6e5e0d93a
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB4323; 
x-ms-traffictypediagnostic: AM0PR08MB4323:
x-microsoft-antispam-prvs: <AM0PR08MB4323E7E8B6E3CEB7D094C977C1190@AM0PR08MB4323.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(39850400004)(346002)(396003)(376002)(136003)(199004)(189003)(102836004)(6246003)(26005)(86362001)(25786009)(53936002)(71190400001)(229853002)(31696002)(316002)(5660300002)(76176011)(4326008)(7736002)(68736007)(478600001)(36756003)(71200400001)(52116002)(305945005)(99286004)(8676002)(446003)(186003)(2616005)(6486002)(54906003)(6116002)(3846002)(14454004)(66066001)(66946007)(2906002)(8936002)(31686004)(14444005)(66476007)(81156014)(6916009)(66556008)(6512007)(73956011)(66446008)(476003)(81166006)(6436002)(11346002)(256004)(386003)(64756008)(486006)(6506007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4323;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gkf4dbnlz5J3cAjBwmckUYmtWhkMkP1D/SetP2dL+YXEYRvZ2ihPGqxwvZlf9dIYDTebzWKGgzKakl0rndfTGyN8TRV24nwQpzU01AjIUWDoUPmw9ntPalcbPyEwE3NEamHjFYuoX4IM/44AvCdOtl3/2yw+lOLSSaNusDlyA+Oer0HMHMtXBBbq8j5NoyjNt6CMbUu0QVsfVENwl7/noHr0XDvrOE3hEdWlhg3p9iO61ZIptSy3r9bI4kKTQDHc3uvA1pmP7Yt3vw4r8S6aP7GSUF00pkTUQsDYFhcd4GMZKhQb5l/3nYeHPO21mg16m32lY3RzcAvKpR5hRoTLg/aRjfWdEetfVeegIhAXywu2S86Eu9nwgZbBl45nzeLiix4zM5rRxS7MDeZ26Kj5vioL8axPbmI0XKgZUhpBB2A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB750648805E4443BD5E10E464B3036D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c414fd-90e5-44e3-ddd2-08d6e5e0d93a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 15:58:40.2270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4323
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.94
Subject: Re: [Qemu-devel] [PATCH 2/2] block/io: refactor padding
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
Cc: "fam@euphon.net" <fam@euphon.net>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzEuMDUuMjAxOSAxODo0OSwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMzEuMDUuMjAxOSB1bSAx
NjoxMCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDMx
LjA1LjIwMTkgMTM6NTEsIFN0ZWZhbiBIYWpub2N6aSB3cm90ZToNCj4+PiBPbiBUdWUsIE1heSAy
OCwgMjAxOSBhdCAxMTo0NTo0NEFNICswMzAwLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
IHdyb3RlOg0KPj4+PiBXZSBoYXZlIHNpbWlsYXIgcGFkZGluZyBjb2RlIGluIGJkcnZfY29fcHdy
aXRldiwNCj4+Pj4gYmRydl9jb19kb19wd3JpdGVfemVyb2VzIGFuZCBiZHJ2X2NvX3ByZWFkdi4g
TGV0J3MgY29tYmluZSBhbmQgdW5pZnkNCj4+Pj4gaXQuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNv
bT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGJsb2NrL2lvLmMgfCAzNDQgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pg0KPj4+IEhtbW0uLi50aGlz
IGFkZHMgbW9yZSBsaW5lcyB0aGFuIGl0IHJlbW92ZXMuICBPX28NCj4+DQo+PiBJdCdzIG5lYXIg
dG8gYmUgdGhlIHNhbWUgc2l6ZSwgYW5kIGtlZXAgaW4gbWluZCBiaWcgY29tbWVudC4NCj4gDQo+
IElmIHlvdSB0YWtlIHRoZSB3aG9sZSBzZXJpZXMgaW50byBhY2NvdW50LCBpdCBsb29rcyBldmVu
IGxlc3MNCj4gZmF2b3VyYWJsZSwgZGVzcGl0ZSBzb21lIGNvbW1lbnRzOg0KPiANCj4gMyBmaWxl
cyBjaGFuZ2VkLCAyNzMgaW5zZXJ0aW9ucygrKSwgMTY1IGRlbGV0aW9ucygtKQ0KPiANCj4+Pg0K
Pj4+IE1lcmdpbmcgYSBjaGFuZ2UgbGlrZSB0aGlzIGNhbiBzdGlsbCBiZSB1c2VmdWwgYnV0IHRo
ZXJlJ3MgYSByaXNrIG9mDQo+Pj4gbWFraW5nIHRoZSBjb2RlIGhhcmRlciB0byB1bmRlcnN0YW5k
IGR1ZSB0byB0aGUgYWRkaXRpb25hbCBsYXllcnMgb2YNCj4+PiBhYnN0cmFjdGlvbi4NCj4+DQo+
PiBJdCdzIGEgcHJlcGFyYXRpb24gZm9yIGFkZGluZyBxaW92X29mZnNldCBwYXJhbWV0ZXIgdG8g
cmVhZC93cml0ZSBwYXRoLiBTZWVtcw0KPj4gY29ycmVjdCB0byB1bmlmeSBzaW1pbGFyIHRoaW5n
cywgd2hpY2ggSSdtIGdvaW5nIHRvIGNoYW5nZS4gQW5kIEkgcmVhbGx5IHdhbnQNCj4+IHRvIG1h
a2UgY29kZSBtb3JlIHVuZGVyc3RhbmRhYmxlIHRoYW4gaXQgd2FzLi4gQnV0IG15IHZpZXcgaXMg
bm90IGdlbmVyYWwNCj4+IG9mIGNvdXJzZS4NCj4gDQo+IERlcGVuZGluZyBvbiB0aGUgY2hhbmdl
cyB5b3UncmUgZ29pbmcgdG8gbWFrZSAoZS5nLiBhZGRpbmcgbW9yZSB1c2VycyBvZg0KPiB0aGUg
c2FtZSBmdW5jdGlvbmFsaXR5LCBvciBtYWtpbmcgdGhlIGR1cGxpY2F0ZWQgY29kZSBtdWNoIGxh
cmdlciksIHRoaXMNCj4gY2FuIGJlIGEgZ29vZCBqdXN0aWZpY2F0aW9uIGV2ZW4gaWYgdGhlIGNv
ZGUgc2l6ZSBpbmNyZWFzZXMuDQo+IA0KPiBJJ2Qgc3VnZ2VzdCB0byBhZGQgdGhlIGV4cGxhbmF0
aW9uIChsaWtlICdUaGlzIGlzIGluIHByZXBhcmF0aW9uIGZvcg0KPiAuLi4nKSB0byB0aGUgY29t
bWl0IG1lc3NhZ2UgdGhlbi4NCj4gDQo+IEtldmluDQo+IA0KDQpJIHRoaW5rLCBJJ2xsIHJlc2Vu
ZCB0aGUgd2hvbGUgc2VyaWVzIHdpdGggdGhpcyBwcmVwYXJhdGlvbiBuZXh0IHdlZWsuDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

