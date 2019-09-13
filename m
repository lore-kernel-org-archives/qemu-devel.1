Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD30C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBAAC2081B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fxri9zaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAAC2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nn6-0005Me-UX
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8nkt-0003xN-6H
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8nkr-0004sg-Mn
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:45:03 -0400
Received: from mail-eopbgr10099.outbound.protection.outlook.com
 ([40.107.1.99]:7821 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8nkl-0004hi-Uv; Fri, 13 Sep 2019 11:44:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDhmQQ3tD+v5TRt7/qthCQt7GN0fnHGvWC94DJDpuYBFEb/S+wqoVP1TT7c9FtUNOlZzQJLI7Kq6GBwoXgzhgMT5Mqo5j4SAMamwTt1vP+ipnR1pHli0xpEvfCGwU8v87TXxoQGqsUX2GxihloPCBYIR2T6sHiVq3X+zEPC8bG18zpE3I58/vsAKoRBI6xo7qRlM/dEEzoxWEA+vS/A3vhXW9oSGdnu1OvIJpBq1xOhL/fQxhaJVZoayyxBQJkmUW2gPLRV1QYcxqOvbz67GE0bTMcIi7MTg8N1nnqwHxdOD7Wzw3ZDvGqaGuDce0g3VbgVqGWLJP+J/DgZ4cH2YyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ32vdQms0WIA6up0mXAyRjA0LPMZzlLOqJq3einwBk=;
 b=lflC9Aw8L9Xvh8LfcThQQyxSHJIGQxAOQnN1s1emoQsVsPfQHauIb8NtzczsHMEFiClezDXradgV727DewT7qB6Bl0GVANVLsPu5fx1qZ1ZL4p1J65gvcJY1mCYFT+5BucSfHFU2UYa0sLH8ng8f9G6IAkifUCZtI5oNFDK8YPKFtqLAtWYLwqG4YHWa557SxYFAEHR9uw3KKvuw+XUXLadEVu9SZRZQlFE71SViuPIvJPdmvj6zS/VccX+EsxNQD25JH+ptrQgjrMebiPjcv+IsKstYpUmmcbHPQrZPAP4Symg1vi9ynoEKbWyWyffXmsv1szz9e5vRNSH18NwFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ32vdQms0WIA6up0mXAyRjA0LPMZzlLOqJq3einwBk=;
 b=fxri9zaQTImz/OFbGXGkJd4mOOtWK8reYjVMw1ndmBAs52JqfjHccONe5cyKjj0ih8YZf7HGlxsyYpnXJgAxrBL5X7M0HiGVnReHSCAJ8alwKjrtYj6eSOlpVoIBCrehelffkYcez/tc5pGyu14+dYRAFVBgnZwqtssS5dQB5jQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5531.eurprd08.prod.outlook.com (52.133.243.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Fri, 13 Sep 2019 15:44:54 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.016; Fri, 13 Sep 2019
 15:44:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v5 1/3] Fix qcow2+luks corruption introduced by commit
 8ac0f15f335
Thread-Index: AQHVakfmT7LKCGOnKkSfQz/snxq8lKcpv8yA
Date: Fri, 13 Sep 2019 15:44:53 +0000
Message-ID: <170075bf-2837-6934-cbe0-aaf67eb748df@virtuozzo.com>
References: <20190913152818.17843-1-mlevitsk@redhat.com>
 <20190913152818.17843-2-mlevitsk@redhat.com>
In-Reply-To: <20190913152818.17843-2-mlevitsk@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::34) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190913184451516
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8a21f58-7cf8-4ad9-ba09-08d738615224
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5531; 
x-ms-traffictypediagnostic: DB8PR08MB5531:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB55316F9507F66E8FDC64DD5CC1B30@DB8PR08MB5531.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:49;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(366004)(396003)(376002)(346002)(189003)(199004)(6486002)(2501003)(66066001)(71190400001)(71200400001)(6436002)(476003)(36756003)(229853002)(66946007)(102836004)(66476007)(110136005)(54906003)(66556008)(64756008)(66446008)(99286004)(53936002)(256004)(52116002)(6246003)(5660300002)(31686004)(386003)(6506007)(486006)(4326008)(6512007)(6306002)(2906002)(966005)(31696002)(478600001)(186003)(7736002)(2616005)(76176011)(305945005)(446003)(25786009)(81166006)(81156014)(8936002)(8676002)(11346002)(316002)(6116002)(26005)(3846002)(14454004)(86362001)(98903001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5531;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WAnQlUeNIsF4bPa/z7LMDfzBsD6eCPXeHbux0upx9PwtVHPwGSlQHgjCJesd/RM/B2YUoFcXOO36zU0AFphDlZPC2pEXcnxXKJ2erAWedOd+qggjqzPaTmKoMGbkjCxy7H85MoCxxdDfrC9Pt6jJyrN/nTMRnHgWZDNYuazVoMYY/CU+e4h3Ndg65ZpM9CV4BSvVleZ4IUFGCMVN8AtcY9yH5tC2TmCSzBIFjcbNuCRpsq97owD7JP3hVlkyxx+OE0VjZf9DbHv0nDMZ6/GmNjtkvNdtgYt2YiLiml5edd2heLrq9kzqW3I5c3WMJi9oWjNHvYO/J8T5tQuFVQOzg6E9LxRWNSlTOztKmPPf87ON/67QplDV0w5486SLV+JvE7K93Z2gkcnY73P/8JLw2AGhHAs4E0PWu8zM+AVzCzs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAAAEAEEB89836479833BCC4DBB9E385@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a21f58-7cf8-4ad9-ba09-08d738615224
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 15:44:53.8787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5EEqEqZRCFjbi/vU1PZn0PcXQYqt90PSQ5FxRcaZuyiVCLwgbuloZLhsRVYGhehIKXiIaK9buqSICQlCzxpGkpDIBe/vew+wItHRKjC2Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5531
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.99
Subject: Re: [Qemu-devel] [PATCH v5 1/3] Fix qcow2+luks corruption
 introduced by commit 8ac0f15f335
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDkuMjAxOSAxODoyOCwgTWF4aW0gTGV2aXRza3kgd3JvdGU6DQo+IFRoaXMgZml4ZXMgc3Vi
dGxlIGNvcnJ1cHRpb24gaW50cm9kdWNlZCBieSBsdWtzIHRocmVhZGVkIGVuY3J5cHRpb24NCj4g
aW4gY29tbWl0IDhhYzBmMTVmMzM1DQo+IA0KPiBCdWd6aWxsYTogaHR0cHM6Ly9idWd6aWxsYS5y
ZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xNzQ1OTIyDQo+IA0KPiBUaGUgY29ycnVwdGlvbiBo
YXBwZW5zIHdoZW4gd2UgZG8gYSB3cml0ZSB0aGF0DQo+ICAgICAqIHdyaXRlcyB0byB0d28gb3Ig
bW9yZSB1bmFsbG9jYXRlZCBjbHVzdGVycyBhdCBvbmNlDQo+ICAgICAqIGRvZXNuJ3QgZnVsbHkg
Y292ZXIgdGhlIGZpcnN0IHNlY3Rvcg0KPiAgICAgKiBkb2Vzbid0IGZ1bGx5IGNvdmVyIHRoZSBs
YXN0IHNlY3Rvcg0KPiANCj4gSW4gdGhpcyBjYXNlLCB3aGVuIGFsbG9jYXRpbmcgdGhlIG5ldyBj
bHVzdGVycyB3ZSBDT1cgYm90aCBhcmVhcw0KPiBwcmlvciB0byB0aGUgd3JpdGUgYW5kIGFmdGVy
IHRoZSB3cml0ZSwgYW5kIHdlIGVuY3J5cHQgdGhlbS4NCj4gDQo+IFRoZSBhYm92ZSBtZW50aW9u
ZWQgY29tbWl0IGFjY2lkZW50YWxseSBtYWRlIGl0IHNvIHdlIGVuY3J5cHQgdGhlDQo+IHNlY29u
ZCBDT1cgYXJlYSB1c2luZyB0aGUgcGh5c2ljYWwgY2x1c3RlciBvZmZzZXQgb2YgdGhlIGZpcnN0
IGFyZWEuDQo+IA0KPiBUaGUgcHJvYmxlbSBpcyB0aGF0IG9mZnNldF9pbl9jbHVzdGVyIGluIGRv
X3BlcmZvcm1fY293X2VuY3J5cHQNCj4gY2FuIGJlIGxhcmdlciB0aGF0IHRoZSBjbHVzdGVyIHNp
emUsIHRodXMgY2x1c3Rlcl9vZmZzZXQNCj4gd2lsbCBubyBsb25nZXIgcG9pbnQgdG8gdGhlIHN0
YXJ0IG9mIHRoZSBjbHVzdGVyIGF0IHdoaWNoIGVuY3J5cHRlZA0KPiBhcmVhIHN0YXJ0cy4NCj4g
DQo+IE5leHQgcGF0Y2ggaW4gdGhpcyBzZXJpZXMgd2lsbCByZWZhY3RvciB0aGUgY29kZSB0byBh
dm9pZCBhbGwgdGhlc2UNCj4gYXNzdW1wdGlvbnMuDQo+IA0KPiBJbiB0aGUgYnVncmVwb3J0IHRo
YXQgd2FzIHRyaWdnZXJlZCBieSByZWJhc2luZyBhIGx1a3MgaW1hZ2UgdG8gbmV3LA0KPiB6ZXJv
IGZpbGxlZCBiYXNlLCB3aGljaCBsb3Qgb2Ygc3VjaCB3cml0ZXMsIGFuZCBjYXVzZXMgc29tZSBm
aWxlcw0KPiB3aXRoIHplcm8gYXJlYXMgdG8gY29udGFpbiBnYXJiYWdlIHRoZXJlIGluc3RlYWQu
DQo+IEJ1dCBhcyBkZXNjcmliZWQgYWJvdmUgaXQgY2FuIGhhcHBlbiBlbHNld2hlcmUgYXMgd2Vs
bA0KPiANCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heGltIExldml0c2t5IDxtbGV2aXRza0ByZWRo
YXQuY29tPg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNl
bWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQo+IC0tLQ0KPiAgIGJsb2NrL3Fjb3cyLWNsdXN0ZXIu
YyB8IDcgKysrKy0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzItY2x1c3Rlci5jIGIvYmxv
Y2svcWNvdzItY2x1c3Rlci5jDQo+IGluZGV4IGRjYWNkM2M0NTAuLmJmZWIwMjQxZDcgMTAwNjQ0
DQo+IC0tLSBhL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYw0KPiArKysgYi9ibG9jay9xY293Mi1jbHVz
dGVyLmMNCj4gQEAgLTQ3NCw5ICs0NzQsMTAgQEAgc3RhdGljIGJvb2wgY29yb3V0aW5lX2ZuIGRv
X3BlcmZvcm1fY293X2VuY3J5cHQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgICAgICBh
c3NlcnQoKG9mZnNldF9pbl9jbHVzdGVyICYgfkJEUlZfU0VDVE9SX01BU0spID09IDApOw0KPiAg
ICAgICAgICAgYXNzZXJ0KChieXRlcyAmIH5CRFJWX1NFQ1RPUl9NQVNLKSA9PSAwKTsNCj4gICAg
ICAgICAgIGFzc2VydChzLT5jcnlwdG8pOw0KPiAtICAgICAgICBpZiAocWNvdzJfY29fZW5jcnlw
dChicywgY2x1c3Rlcl9vZmZzZXQsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNy
Y19jbHVzdGVyX29mZnNldCArIG9mZnNldF9pbl9jbHVzdGVyLA0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBidWZmZXIsIGJ5dGVzKSA8IDApIHsNCj4gKyAgICAgICAgaWYgKHFjb3cy
X2NvX2VuY3J5cHQoYnMsDQo+ICsgICAgICAgICAgICAgICAgc3RhcnRfb2ZfY2x1c3RlcihzLCBj
bHVzdGVyX29mZnNldCArIG9mZnNldF9pbl9jbHVzdGVyKSwNCj4gKyAgICAgICAgICAgICAgICBz
cmNfY2x1c3Rlcl9vZmZzZXQgKyBvZmZzZXRfaW5fY2x1c3RlciwNCj4gKyAgICAgICAgICAgICAg
ICBidWZmZXIsIGJ5dGVzKSA8IDApIHsNCj4gICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+
ICAgICAgICAgICB9DQo+ICAgICAgIH0NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFk
aW1pcg0K

