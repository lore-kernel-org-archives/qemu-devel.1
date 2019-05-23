Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687A6C282E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DEF20879
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UveNd70E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DEF20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35640 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnIy-0005Sv-BA
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 08:58:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hTnGe-0003hW-R3
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hTn6X-00047e-5S
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:45:54 -0400
Received: from mail-eopbgr40130.outbound.protection.outlook.com
	([40.107.4.130]:51622
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hTn6W-00046I-It; Thu, 23 May 2019 08:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=s81QRFFX5rdz0qXgC0FwAS+zMsqGgZe+XhOi8zof3hE=;
	b=UveNd70Ex8l4r6DlThfb1JxIg1X5B6c60Cmvc+SGdW95tDilndz8oKnbFr0rm00BNk4ym7EF9nEsVXi4cP+jmCRP6YxMEv63UvPK29ceeX0tPX9Lvv9pEEPPY9FNJTs11sZlFH40kd9vES4M6i9iVcSD0eKjkz11GwU4rK9T+vs=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
	VI1PR08MB2894.eurprd08.prod.outlook.com (10.170.239.150) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.17; Thu, 23 May 2019 12:45:49 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::48f:a107:e2ac:a28f]) by VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::48f:a107:e2ac:a28f%7]) with mapi id 15.20.1922.016;
	Thu, 23 May 2019 12:45:49 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v14 1/1] qcow2: skip writing zero buffers to empty COW
	areas
Thread-Index: AQHVC/OSFPCpJ9xch0mEH4QuyCsa5aZ3pScAgAEN0wA=
Date: Thu, 23 May 2019 12:45:48 +0000
Message-ID: <1e496e24-eb8e-e988-9e5d-ed9efeddaa53@virtuozzo.com>
References: <20190516142749.81019-1-anton.nefedov@virtuozzo.com>
	<20190516142749.81019-2-anton.nefedov@virtuozzo.com>
	<6fe54054-899a-48d6-c2db-d43e242f20b3@redhat.com>
In-Reply-To: <6fe54054-899a-48d6-c2db-d43e242f20b3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::12)
	To VI1PR08MB4078.eurprd08.prod.outlook.com
	(2603:10a6:803:e5::28)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2550b7a-95dc-4925-7fd3-08d6df7c94e6
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:VI1PR08MB2894; 
x-ms-traffictypediagnostic: VI1PR08MB2894:
x-microsoft-antispam-prvs: <VI1PR08MB28947E267F299CC0E4FA65DBF8010@VI1PR08MB2894.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(39830400003)(396003)(346002)(366004)(136003)(199004)(189003)(3846002)(6116002)(229853002)(107886003)(478600001)(7736002)(305945005)(4326008)(6486002)(6436002)(25786009)(73956011)(66946007)(6246003)(54906003)(8936002)(66446008)(81156014)(81166006)(8676002)(64756008)(66556008)(5660300002)(66476007)(53936002)(2501003)(110136005)(2906002)(486006)(36756003)(256004)(52116002)(76176011)(71190400001)(99286004)(71200400001)(44832011)(186003)(316002)(6506007)(53546011)(6512007)(66066001)(31686004)(14454004)(386003)(26005)(446003)(68736007)(2616005)(102836004)(86362001)(476003)(31696002)(11346002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB2894;
	H:VI1PR08MB4078.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 30kbKN9ZxOmtnt+NFUnTxGb9Ou3fmMjDTzLbmPRdIiG4FQ/1yCnZ1lnjY38OM8ZPVu7pM9DIqDGNLJ15Mn6lwpXoCAjUmULZ/ffnCu1Z/41zQF7yh40mhvWzxk1TgjKLHIOh6SCdEKIiQfm02RMbGXr/sZfAjWpwN7uENd0nF8AM5noxqsh5GyM2el6ANakHbvX0jqwNQw4xlxUyEMWLPxCiJW/ntC0kfxeHyVwudlF9/Fyq9ASMSjRl0WK8wIlMWO57Z6TwYta2EeFyMf+bVqgSX5/hjN5yQCdAZfHgkpmvji61mHZnUNNBG0YghkeyYQ1Mr36OqHYRzoQlCUhf82xjtsEAo6bR8YTnmb+S8B0sfJVsD+pdz/LT4gsYkmv05rsuXuqeUUvu7OiuYgCbsJhwKI+gn7wgZuCcXetj9xg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0EA27074397F24FA7A5643F3A641F30@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2550b7a-95dc-4925-7fd3-08d6df7c94e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 12:45:48.9494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2894
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.130
Subject: Re: [Qemu-devel] [PATCH v14 1/1] qcow2: skip writing zero buffers
 to empty COW areas
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
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMjIvNS8yMDE5IDExOjQwIFBNLCBNYXggUmVpdHogd3JvdGU6DQo+IE9uIDE2LjA1LjE5IDE2
OjI3LCBBbnRvbiBOZWZlZG92IHdyb3RlOg0KPj4gSWYgQ09XIGFyZWFzIG9mIHRoZSBuZXdseSBh
bGxvY2F0ZWQgY2x1c3RlcnMgYXJlIHplcm9lcyBvbiB0aGUgYmFja2luZw0KPj4gaW1hZ2UsIGVm
ZmljaWVudCBiZHJ2X3dyaXRlX3plcm9lcyhmbGFncz1CRFJWX1JFUV9OT19GQUxMQkFDSykgY2Fu
IGJlDQo+PiB1c2VkIG9uIHRoZSB3aG9sZSBjbHVzdGVyIGluc3RlYWQgb2Ygd3JpdGluZyBleHBs
aWNpdCB6ZXJvIGJ1ZmZlcnMgbGF0ZXINCj4+IGluIHBlcmZvcm1fY293KCkuDQo+Pg0KPj4gaW90
ZXN0IDA2MDoNCj4+IHdyaXRlIHRvIHRoZSBkaXNjYXJkZWQgY2x1c3RlciBkb2VzIG5vdCB0cmln
Z2VyIENPVyBhbnltb3JlLg0KPj4gVXNlIGEgYmFja2luZyBpbWFnZSBpbnN0ZWFkLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IEFudG9uIE5lZmVkb3YgPGFudG9uLm5lZmVkb3ZAdmlydHVvenpvLmNv
bT4NCj4+IC0tLQ0KPj4gICBxYXBpL2Jsb2NrLWNvcmUuanNvbiAgICAgICB8ICA0ICstDQo+PiAg
IGJsb2NrL3Fjb3cyLmggICAgICAgICAgICAgIHwgIDYgKysrDQo+PiAgIGJsb2NrL3Fjb3cyLWNs
dXN0ZXIuYyAgICAgIHwgIDIgKy0NCj4+ICAgYmxvY2svcWNvdzIuYyAgICAgICAgICAgICAgfCA5
MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4gICBibG9jay90cmFj
ZS1ldmVudHMgICAgICAgICB8ICAxICsNCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzA2MCAgICAg
fCAgNyArKy0NCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzA2MC5vdXQgfCAgNSArLQ0KPj4gICA3
IGZpbGVzIGNoYW5nZWQsIDExMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4g
Wy4uLl0NCj4gDQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzIuYyBiL2Jsb2NrL3Fjb3cyLmMN
Cj4+IGluZGV4IDhlMDI0MDA3ZGIuLmU2YjEyOTNkZGYgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9x
Y293Mi5jDQo+PiArKysgYi9ibG9jay9xY293Mi5jDQo+IA0KPiBbLi4uXQ0KPiANCj4+IEBAIC0y
MTQ1LDYgKzIxNTAsODAgQEAgc3RhdGljIGJvb2wgbWVyZ2VfY293KHVpbnQ2NF90IG9mZnNldCwg
dW5zaWduZWQgYnl0ZXMsDQo+PiAgICAgICByZXR1cm4gZmFsc2U7DQo+PiAgIH0NCj4+ICAgDQo+
PiArc3RhdGljIGJvb2wgaXNfdW5hbGxvY2F0ZWQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGludDY0
X3Qgb2Zmc2V0LCBpbnQ2NF90IGJ5dGVzKQ0KPj4gK3sNCj4+ICsgICAgaW50NjRfdCBucjsNCj4+
ICsgICAgcmV0dXJuICFieXRlcyB8fA0KPj4gKyAgICAgICAgKCFiZHJ2X2lzX2FsbG9jYXRlZF9h
Ym92ZShicywgTlVMTCwgb2Zmc2V0LCBieXRlcywgJm5yKSAmJiBuciA9PSBieXRlcyk7DQo+IA0K
PiBJdCdzIGEgcGl0eSB0aGF0IHRoaXMgYmRydl9pc19hbGxvY2F0ZWQoKSB0aHJvd3MgYXdheSBC
RFJWX0JMT0NLX1pFUk8NCj4gaW5mb3JtYXRpb24uICBJZiBzb21ldGhpbmcgaW4gdGhlIGJhY2tp
bmcgY2hhaW4gaGFzIGV4cGxpY2l0IHplcm8NCj4gY2x1c3RlcnMgdGhlcmUsIHdlIGNvdWxkIGdl
dCB0aGUgaW5mb3JtYXRpb24gZm9yIGZyZWUsIGJ1dCB0aGlzIHdpbGwNCj4gY29uc2lkZXIgaXQg
YWxsb2NhdGVkLg0KPiANCj4gV291bGRuJ3QgaXQgbWFrZSBzZW5zZSB0byBtYWtlIGJkcnZfY29f
YmxvY2tfc3RhdHVzX2Fib3ZlKCkgcHVibGljIGFuZA0KPiB0aGVuIHVzZSB0aGF0ICh3aXRoIHdh
bnRfemVybyA9PSBmYWxzZSk/DQo+IA0KPiAoQnV0IHRoYXQgY2FuIGJlIGRvbmUgbGF0ZXIsIHRv
bywgb2YgY291cnNlLikNCj4gDQoNCm9yIHNvbWV0aGluZyBsaWtlIGJkcnZfaGFzX25vbl96ZXJv
X2RhdGEoKSwgd2l0aCB0aGUgYXJndW1lbnQNCndhbnRfemVybyAobWF5YmUgY2FsbCBpdCBjaGVj
a19maWxlIGluIHRoaXMgY2FzZSkuDQoNClllcywgSSdkIHJhdGhlciBpbXBsZW1lbnQgaXQgc2Vw
YXJhdGVseS4NCg0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgYm9vbCBpc196ZXJvX2NvdyhCbG9j
a0RyaXZlclN0YXRlICpicywgUUNvd0wyTWV0YSAqbSkNCj4+ICt7DQo+PiArICAgIC8qDQo+PiAr
ICAgICAqIFRoaXMgY2hlY2sgaXMgZGVzaWduZWQgZm9yIG9wdGltaXphdGlvbiBzaG9ydGN1dCBz
byBpdCBtdXN0IGJlDQo+PiArICAgICAqIGVmZmljaWVudC4NCj4+ICsgICAgICogSW5zdGVhZCBv
ZiBpc196ZXJvKCksIHVzZSBpc191bmFsbG9jYXRlZCgpIGFzIGl0IGlzIGZhc3RlciAoYnV0IG5v
dA0KPj4gKyAgICAgKiBhcyBhY2N1cmF0ZSBhbmQgY2FuIHJlc3VsdCBpbiBmYWxzZSBuZWdhdGl2
ZXMpLg0KPj4gKyAgICAgKi8NCj4+ICsgICAgcmV0dXJuIGlzX3VuYWxsb2NhdGVkKGJzLCBtLT5v
ZmZzZXQgKyBtLT5jb3dfc3RhcnQub2Zmc2V0LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgbS0+Y293X3N0YXJ0Lm5iX2J5dGVzKSAmJg0KPj4gKyAgICAgICAgICAgaXNfdW5hbGxvY2F0
ZWQoYnMsIG0tPm9mZnNldCArIG0tPmNvd19lbmQub2Zmc2V0LA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgbS0+Y293X2VuZC5uYl9ieXRlcyk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRp
YyBpbnQgaGFuZGxlX2FsbG9jX3NwYWNlKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBRQ293TDJNZXRh
ICpsMm1ldGEpDQo+PiArew0KPj4gKyAgICBCRFJWUWNvdzJTdGF0ZSAqcyA9IGJzLT5vcGFxdWU7
DQo+PiArICAgIFFDb3dMMk1ldGEgKm07DQo+PiArDQo+PiArICAgIGlmICghKHMtPmRhdGFfZmls
ZS0+YnMtPnN1cHBvcnRlZF96ZXJvX2ZsYWdzICYgQkRSVl9SRVFfTk9fRkFMTEJBQ0spKSB7DQo+
PiArICAgICAgICByZXR1cm4gMDsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBpZiAoYnMtPmVu
Y3J5cHRlZCkgew0KPj4gKyAgICAgICAgcmV0dXJuIDA7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsg
ICAgZm9yIChtID0gbDJtZXRhOyBtICE9IE5VTEw7IG0gPSBtLT5uZXh0KSB7DQo+PiArICAgICAg
ICBpbnQgcmV0Ow0KPj4gKw0KPj4gKyAgICAgICAgaWYgKCFtLT5jb3dfc3RhcnQubmJfYnl0ZXMg
JiYgIW0tPmNvd19lbmQubmJfYnl0ZXMpIHsNCj4+ICsgICAgICAgICAgICBjb250aW51ZTsNCj4+
ICsgICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAgIGlmICghaXNfemVyb19jb3coYnMsIG0pKSB7
DQo+PiArICAgICAgICAgICAgY29udGludWU7DQo+PiArICAgICAgICB9DQo+PiArDQo+PiArICAg
ICAgICAvKg0KPj4gKyAgICAgICAgICogaW5zdGVhZCBvZiB3cml0aW5nIHplcm8gQ09XIGJ1ZmZl
cnMsDQo+PiArICAgICAgICAgKiBlZmZpY2llbnRseSB6ZXJvIG91dCB0aGUgd2hvbGUgY2x1c3Rl
cnMNCj4+ICsgICAgICAgICAqLw0KPj4gKw0KPj4gKyAgICAgICAgcmV0ID0gcWNvdzJfcHJlX3dy
aXRlX292ZXJsYXBfY2hlY2soYnMsIDAsIG0tPmFsbG9jX29mZnNldCwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG0tPm5iX2NsdXN0ZXJzICogcy0+Y2x1
c3Rlcl9zaXplLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdHJ1ZSk7DQo+PiArICAgICAgICBpZiAocmV0IDwgMCkgew0KPj4gKyAgICAgICAgICAgIHJl
dHVybiByZXQ7DQo+PiArICAgICAgICB9DQo+PiArDQo+PiArICAgICAgICBCTEtEQkdfRVZFTlQo
YnMtPmZpbGUsIEJMS0RCR19DTFVTVEVSX0FMTE9DX1NQQUNFKTsNCj4+ICsgICAgICAgIHJldCA9
IGJkcnZfY29fcHdyaXRlX3plcm9lcyhzLT5kYXRhX2ZpbGUsIG0tPmFsbG9jX29mZnNldCwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtLT5uYl9jbHVzdGVycyAqIHMt
PmNsdXN0ZXJfc2l6ZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBC
RFJWX1JFUV9OT19GQUxMQkFDSyk7DQo+IA0KPiBNb3N0bHkgSSdtIHdyaXRpbmcgdGhpcyBtYWls
IGJlY2F1c2Ugb2YgdGhpcy4gIFplcm9pbmcgdGhlIHdob2xlIHJhbmdlDQo+IHNlZW1zIGluZWZm
aWNpZW50IHRvIG1lIGZvciB2ZXJ5IGxhcmdlIHJlcXVlc3RzLCBhbmQgdGhlIGNvbW1pdCBtZXNz
YWdlDQo+IGRvZXNuJ3Qgc2F5IGFueXRoaW5nIGFib3V0IHRoZSByZWFzb25pbmcgYmVoaW5kIHVu
Y29uZGl0aW9uYWxseSB6ZXJvaW5nDQo+IGV2ZXJ5dGhpbmcuDQo+IA0KPiBCZW5jaG1hcmtpbmcg
bG9va3MgbGlrZSBpbiBtb3N0IGNhc2VzIGl0IGlzIGFib3V0IGVxdWFsIHRvIHplcm9pbmcgaGVh
ZA0KPiBhbmQgdGFpbCBzZXBhcmF0ZWx5LiAgQnV0IGlmIEkgcHJlLWZpbGxsIGFuIGltYWdlIHdp
dGggcmFuZG9tIGRhdGEsIGl0DQo+IGlzIG11Y2ggc2xvd2VyOg0KPiANCj4gJCBxZW11LWltZyBj
cmVhdGUgLWYgcWNvdzIgZm9vLnFjb3cyIDEwRw0KPiAkIGRkIGlmPS9kZXYvdXJhbmRvbSBvZj1m
b28ucWNvdzIgYnM9MU0gc2Vlaz0xIGNvdW50PTQwOTYNCj4gJCBzeW5jDQo+IA0KPiBUaGVuIGRv
aW5nIGxhcmdlIHVuYWxpZ25lZCByZXF1ZXN0cyBvbiBpdDoNCj4gDQo+ICQgLi9xZW11LWltZyBi
ZW5jaCAtdyAtdCBub25lIC1zICQoKDQwMCAqIDEwNDg1NzYpKSBcDQo+ICAgIC1TICQoKDQwMSAq
IDEwNDg1NzYpKSAtbyAzMjc2OCAtYyAxMCAtZCAyIC1mIHFjb3cyIGZvby5xY293Mg0KPiANCj4g
V2hlbiB6ZXJvaW5nIHRoZSB3aG9sZSByYW5nZSwgdGhpcyB1c3VhbGx5IHRha2VzIGFyb3VuZCAy
NSBzIGZvciBtZTsNCj4ganVzdCB6ZXJvaW5nIGhlYWQgYW5kIHRhaWwgdGFrZXMgYXJvdW5kIDE0
IHMuIFdpdGhvdXQgdGhpcyBwYXRjaCwgaXQNCj4gdGFrZXMgYXJvdW5kIDE0IHMsIHRvby4NCj4g
DQo+IE9uIHRoZSBvdGhlciBoYW5kLCB3aGVuIGRvaW5nIHNtYWxsZXIgcmVxdWVzdHMgb24gYSBz
aW5nbGUgY2x1c3Rlcg0KPiAod2hpY2ggaXMgd2hhdCB0aGlzIHBhdGNoIGlzIGZvcik6DQo+IA0K
PiAkIC4vcWVtdS1pbWcgYmVuY2ggLXcgLXQgbm9uZSAtcyA0MDk2IC1TIDY1NTM2IC1vIDMyNzY4
IFwNCj4gICAgLWYgcWNvdzIgZm9vLnFjb3cyDQo+IA0KPiBUaGlzIHRha2VzIGFyb3VuZCAyNiBz
IGJlZm9yZSB0aGlzIHBhdGNoLCAxMiBzIHdpdGggaXQsIGFuZCBsaWtlIDMwIHRvDQo+IDQwIHdo
ZW4gemVyb2luZyBoZWFkIGFuZCB0YWlsIHNlcGFyYXRlbHkuDQo+IA0KPiANCj4gTm93LCBzdWNo
IGxhcmdlIHJlcXVlc3RzIHN1cmVseSBhcmUgdGhlIGV4Y2VwdGlvbiwgYXMgaXMgYWxsb2NhdGlu
Zw0KPiBibG9ja3MgaW4gYW4gYXJlYSBvZiB0aGUgaW1hZ2UgdGhhdCBhbHJlYWR5IGNvbnRhaW5z
IGRhdGEuICBIb3dldmVyLCBJDQo+IGp1c3Qgd2FudCB0byBhc2sgYmFjayB0aGF0IHplcm9pbmcg
dGhlIHdob2xlIHJhbmdlIHVuY29uZGl0aW9uYWxseSBpcw0KPiBkb25lIG9uIHB1cnBvc2UuICBN
YXliZSBpdCBtYWtlcyBzZW5zZSB0byBzcGxpdCBoZWFkIGFuZCB0YWlsIGlmIHRoZXkNCj4gYXJl
IGxpa2UgbW9yZSB0aGFuLCBJIGRvbid0IGtub3csIDE2IE1CIGFwYXJ0PyAgQnV0IHRoZSAiSSBk
b24ndCBrbm93Ig0KPiBpcyB0aGUgcHJvYmxlbSBvZiBjb3Vyc2UuICBJcyB0aGVyZSBhIHdheSB0
byBtYWtlIGEgZ29vZCBkZWZhdWx0Pw0KPiANCg0KSXQncyBpbmRlZWQgdHJpY2t5IHRvIGZpbmQg
YSBzb2x1dGlvbiB0aGF0IHBlcmZvcm1zIGJldHRlciBtb3N0DQp1bml2ZXJzYWxseS4gSSBpbXBs
aWVkIHRoYXQgd3JpdGVzIGFyZSBvZnRlbiBzaG9ydGVyIHRoYW4gYSBjbHVzdGVyLA0KYW5kIHRo
ZSBiaWdnZXIgdGhlIGNsdXN0ZXIgc2l6ZSB0aGUgbW9yZSB0aGUgZ2FpbiB0b28uIEkgdHJhY2Vk
IGEgd2hpbGUNCmFuZCBkaWQgbm90IGV2ZW4gc2VlIGEgd3JpdGUgbGFyZ2VyIHRoYW4gMU1iIGZy
b20gYSBmcmVzaGx5IGluc3RhbGxlZA0KY2VudG9zIFZNLg0KDQpaZXJvaW5nIGhlYWQgYW5kIHRh
aWwgc2VwYXJhdGVseSBoYXMgYW4gZXh0cmEgcGVuYWx0eSBiZWluZyBzZXBhcmF0ZSBpL28NCm9w
cyAocHJvYmFibHkgd2h5IGl0IGxvc2VzL2VxdWF0ZXMgaW4gcGVyZm9ybWFuY2UgYW55d2F5IGFj
Y29yZGluZyB0bw0KeW91ciBtZWFzdXJlbWVudHMpLg0KDQpTbyBJJ2Qgc2F5IGl0J3MgZWl0aGVy
IHVuY29uZGl0aW9uYWwsIG9yIGlmIHdlIHdhbnQgdG8gcHJvdGVjdCB0aGUgcmFyZQ0KY2FzZXMg
ZnJvbSBkZWdyYWRhdGlvbiB0b28sIHdlIG1pZ2h0IGZhbGxiYWNrIHRvIHdyaXRpbmcNCnplcm8g
YnVmZmVycy4gRS5nLiBpZiB6ZXJvZXNfbGVuZ3RoL2RhdGFfbGVuZ3RoIHJhdGlvIGlzIHRvbyBz
bWFsbC4NCkFnYWluLCBubyBpZGVhIHdoYXQgInRvbyBzbWFsbCIgaXMuDQpQcm9iYWJseSBubyBv
dGhlciB3YXkgdG8ga25vdyB0aGFuIHRvIG1lYXN1cmUgd2l0aCBkaWZmZXJlbnQgYm9yZGVybGlu
ZQ0KcmF0aW9zLg0KDQovQW50b24NCg0K

