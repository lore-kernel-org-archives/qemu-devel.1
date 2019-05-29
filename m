Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E3CC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1812070D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PIE0yzUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1812070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50797 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVvDG-0006pc-57
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 05:49:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hVvBD-00063t-GQ
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hVvBB-0000Is-EH
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:47:31 -0400
Received: from mail-eopbgr40113.outbound.protection.outlook.com
	([40.107.4.113]:62255
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hVvB9-0000CE-DY; Wed, 29 May 2019 05:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=X9kxRblx6l2vmfiZMFsDJcluRj0Bh6n9Z7R5c+3J33E=;
	b=PIE0yzUGUNjtc56vG9W3owUbcGg4+LECVgUmBC+mJ/AWjCkWeVbTviyEyab7StqFCuX3QGfMfyapYty/n97dsG58h5JrM7Z5Hw4G22X+h9xKuhxaqHoD3ec16YE/Mb7IQ0v9S8PZ1Vpdhk+skJf2f7dv23Sb67oa3e5dUbiZEoM=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB3137.eurprd08.prod.outlook.com (52.134.125.27) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.20; Wed, 29 May 2019 09:47:22 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::9499:ef6a:95e:a3c6]) by AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::9499:ef6a:95e:a3c6%4]) with mapi id 15.20.1922.021;
	Wed, 29 May 2019 09:47:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, "kwolf@redhat.com"
	<kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com"
	<armbru@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v0 2/3] qcow2: add compression type processing
Thread-Index: AQHVFWMFINuomH1KzEmyu7oSefHOn6aB3D4A
Date: Wed, 29 May 2019 09:47:22 +0000
Message-ID: <0f124c25-92eb-4b28-5f26-b9d571a0bab5@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
	<20190528143727.10529-3-dplotnikov@virtuozzo.com>
In-Reply-To: <20190528143727.10529-3-dplotnikov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0235.eurprd05.prod.outlook.com
	(2603:10a6:3:fb::11) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190529124720545
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 907b7811-c12e-4f60-e411-08d6e41aa5f5
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB3137; 
x-ms-traffictypediagnostic: AM0PR08MB3137:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR08MB3137BA81368F22D5C95369EDC11F0@AM0PR08MB3137.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(346002)(376002)(396003)(136003)(366004)(199004)(189003)(6116002)(76176011)(4326008)(3846002)(66446008)(66556008)(64756008)(66476007)(11346002)(186003)(6486002)(256004)(14444005)(966005)(446003)(81166006)(31686004)(8936002)(26005)(5660300002)(229853002)(6306002)(6512007)(36756003)(73956011)(66946007)(8676002)(25786009)(66066001)(305945005)(54906003)(107886003)(316002)(110136005)(6246003)(52116002)(478600001)(81156014)(2501003)(486006)(476003)(2616005)(68736007)(86362001)(6436002)(71190400001)(53936002)(102836004)(6506007)(2201001)(7736002)(2906002)(14454004)(99286004)(71200400001)(31696002)(386003)(21314003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3137;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pDaZiCkCG0GoAeME/Y/XhtLddGxGVFg/V4ONE5htTA4ApGP9qnS91ubdAKjlu9k3O0AqPO/62vOzs2V0suJC0OFksPYaBaN9DDnhBdO8R+8bkAA/mu0EoI//1oZ+EQfArcXYTTDGNzI8PCT1w5pDZf5tSuA8SwKo0LXfYROXBjB+A3FSyxGL2iZ2h6e4Jvcbavh+f+LBVjA7NgHwASxd1Q9bldjB2lKf91cfF0x4QjlT+EST+w4zPcPvLBknhgYRBECXj+2PBj5tabu4l76FEFI0Hpe9boBezQo/Lhiewk1S6Ea1YPmTeKYBblWhbFLBUg9udgAoOUwMAT2uyk4N23/9cW6QC9jUnj29ugHUUFxZQjnq+1mj0QQh6ZmIwKFwBl9L/eISh3kIgaQmPbSZNDUDYnEKCwKkAqhv3qN31lw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DDBED1175513046A66995907A893F71@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907b7811-c12e-4f60-e411-08d6e41aa5f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 09:47:22.7539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3137
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.113
Subject: Re: [Qemu-devel] [PATCH v0 2/3] qcow2: add compression type
 processing
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
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMDUuMjAxOSAxNzozNywgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPiBXaXRoIHRoZSBwYXRj
aCwgcWNvdzIgaXMgYWJsZSB0byBwcm9jZXNzIGltYWdlIGNvbXByZXNzaW9uIHR5cGUNCj4gZGVm
aW5lZCBpbiB0aGUgaW1hZ2UgaGVhZGVyIGFuZCBjaG9vc2UgdGhlIGNvcnJlc3BvbmRpbmcgbWV0
aG9kDQo+IGZvciBjbHVzdGVycyBjb21wcmVzc2luZy4NCj4gDQo+IEFsc28sIGl0IHJld29yayB0
aGUgY2x1c3RlciBjb21wcmVzc2lvbiBjb2RlIGZvciBhZGRpbmcgbW9yZQ0KPiBjb21wcmVzc2lv
biB0eXBlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERlbmlzIFBsb3RuaWtvdiA8ZHBsb3RuaWtv
dkB2aXJ0dW96em8uY29tPg0KPiAtLS0NCj4gICBibG9jay9xY293Mi5jIHwgMTAzICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDkyIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2Jsb2NrL3Fjb3cyLmMgYi9ibG9jay9xY293Mi5jDQo+IGluZGV4IGM0YjViOTM0MDguLjkw
ZjE1Y2MzYzkgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL3Fjb3cyLmMNCj4gKysrIGIvYmxvY2svcWNv
dzIuYw0KPiBAQCAtNDAwLDExICs0MDAsMzkgQEAgc3RhdGljIGludCBxY293Ml9yZWFkX2V4dGVu
c2lvbnMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90IHN0YXJ0X29mZnNldCwNCj4gICAg
ICAgICAgICAgICBicmVhazsNCj4gICANCj4gICAgICAgICAgIGNhc2UgUUNPVzJfRVhUX01BR0lD
X0NPTVBSRVNTSU9OX1RZUEU6DQo+ICsgICAgICAgICAgICAvKiBDb21wcmVzc2lvbiB0eXBlIGFs
d2F5cyBnb2VzIHdpdGggdGhlIGNvbXByZXNzaW9uIHR5cGUgYml0IHNldCAqLw0KPiArICAgICAg
ICAgICAgaWYgKCEocy0+aW5jb21wYXRpYmxlX2ZlYXR1cmVzICYgUUNPVzJfSU5DT01QQVRfQ09N
UFJFU1NJT05fVFlQRSkpIHsNCj4gKyAgICAgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAiY29tcHJlc3Npb25fdHlwZV9leHQ6ICINCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICJleHBlY3QgY29tcHJlc3Npb24gdHlwZSBiaXQg
c2V0Iik7DQo+ICsgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsgICAgICAgICAg
ICB9DQo+ICsNCj4gKyAgICAgICAgICAgIHJldCA9IGJkcnZfcHJlYWQoYnMtPmZpbGUsIG9mZnNl
dCwgJnMtPmNvbXByZXNzaW9uX3R5cGUsIGV4dC5sZW4pOw0KPiArICAgICAgICAgICAgcy0+Y29t
cHJlc3Npb25fdHlwZSA9IGJlMzJfdG9fY3B1KHMtPmNvbXByZXNzaW9uX3R5cGUpOw0KPiArDQo+
ICsgICAgICAgICAgICBpZiAocmV0IDwgMCkgew0KPiArICAgICAgICAgICAgICAgIGVycm9yX3Nl
dGdfZXJybm8oZXJycCwgLXJldCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJFUlJPUjogQ291bGQgbm90IHJlYWQgY29tcHJlc3Npb24gdHlwZSIpOw0KPiArICAgICAgICAg
ICAgICAgIHJldHVybiByZXQ7DQo+ICsgICAgICAgICAgICB9DQo+ICsNCj4gICAgICAgICAgICAg
ICAvKg0KPiAtICAgICAgICAgICAgICogU2V0dGluZyBjb21wcmVzc2lvbiB0eXBlIHRvIEJEUlZR
Y293MlN0YXRlLT5jb21wcmVzc2lvbl90eXBlDQo+IC0gICAgICAgICAgICAgKiBmcm9tIHRoZSBp
bWFnZSBoZWFkZXIgaXMgZ29pbmcgdG8gYmUgaGVyZQ0KPiArICAgICAgICAgICAgICogVGhlIGRl
ZmF1bHQgY29tcHJlc3Npb24gdHlwZSBpcyBub3QgYWxsb3dlZCB3aGVuIHRoZSBleHRlbnNpb24N
Cj4gKyAgICAgICAgICAgICAqIGlzIHByZXNlbnQuIFpMSUIgaXMgdXNlZCBhcyB0aGUgZGVmYXVs
dCBjb21wcmVzc2lvbiB0eXBlLg0KPiArICAgICAgICAgICAgICogV2hlbiBjb21wcmVzc2lvbiB0
eXBlIGV4dGVuc2lvbiBoZWFkZXIgaXMgcHJlc2VudCB0aGVuDQo+ICsgICAgICAgICAgICAgKiBj
b21wcmVzc2lvbl90eXBlIHNob3VsZCBoYXZlIGEgdmFsdWUgZGlmZmVyZW50IGZyb20gdGhlIGRl
ZmF1bHQuDQo+ICAgICAgICAgICAgICAgICovDQo+IC0gICAgICAgICAgICAgYnJlYWs7DQo+ICsg
ICAgICAgICAgICBpZiAocy0+Y29tcHJlc3Npb25fdHlwZSA9PSBRQ09XMl9DT01QUkVTU0lPTl9U
WVBFX1pMSUIpIHsNCj4gKyAgICAgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiY29tcHJlc3Npb25fdHlwZV9leHQ6Ig0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgImludmFsaWQgY29tcHJlc3Npb24gdHlwZSAlZCIsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICBRQ09XMl9DT01QUkVTU0lPTl9UWVBFX1pMSUIpOw0K
PiArICAgICAgICAgICAgfQ0KPiArI2lmZGVmIERFQlVHX0VYVA0KPiArICAgICAgICAgICAgcHJp
bnRmKCJRY293MjogaW1hZ2UgY29tcHJlc3Npb24gdHlwZSAlc1xuIiwgcy0+Y29tcHJlc3Npb25f
dHlwZSk7DQo+ICsjZW5kaWYNCj4gKyAgICAgICAgICAgIGJyZWFrOw0KPiAgIA0KPiAgICAgICAg
ICAgY2FzZSBRQ09XMl9FWFRfTUFHSUNfREFUQV9GSUxFOg0KPiAgICAgICAgICAgew0KPiBAQCAt
MTQ5Miw2ICsxNTIwLDkgQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gcWNvdzJfZG9fb3BlbihC
bG9ja0RyaXZlclN0YXRlICpicywgUURpY3QgKm9wdGlvbnMsDQo+ICAgICAgIFFMSVNUX0lOSVQo
JnMtPmNsdXN0ZXJfYWxsb2NzKTsNCj4gICAgICAgUVRBSUxRX0lOSVQoJnMtPmRpc2NhcmRzKTsN
Cj4gICANCj4gKyAgICAvKiBTZXQgZGVmYXVsdCBjb21wcmVzc2lvbiB0eXBlICovDQo+ICsgICAg
cy0+Y29tcHJlc3Npb25fdHlwZSA9IFFDT1cyX0NPTVBSRVNTSU9OX1RZUEVfWkxJQjsNCj4gKw0K
PiAgICAgICAvKiByZWFkIHFjb3cyIGV4dGVuc2lvbnMgKi8NCj4gICAgICAgaWYgKHFjb3cyX3Jl
YWRfZXh0ZW5zaW9ucyhicywgaGVhZGVyLmhlYWRlcl9sZW5ndGgsIGV4dF9lbmQsIE5VTEwsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmxhZ3MsICZ1cGRhdGVfaGVhZGVyLCAm
bG9jYWxfZXJyKSkgew0KPiBAQCAtMTUwMCw2ICsxNTMxLDM0IEBAIHN0YXRpYyBpbnQgY29yb3V0
aW5lX2ZuIHFjb3cyX2RvX29wZW4oQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIFFEaWN0ICpvcHRpb25z
LA0KPiAgICAgICAgICAgZ290byBmYWlsOw0KPiAgICAgICB9DQo+ICAgDQo+ICsgICAgLyoNCj4g
KyAgICAgKiBUaGUgY29tcHJlc3Npb24gdHlwZSBpcyBzZXQgb24gdGhlIGV4dGVuc2lvbiBoZWFk
ZXIgcHJvY2Vzc2luZw0KPiArICAgICAqIGlmIHRoZSBjb21wcmVzc2lvbiB0eXBlIGV4dGVuc2lv
biBoZWFkZXIgaXMgcHJlc2VudC4NCj4gKyAgICAgKiBXaGVuIHRoZSBjb21wcmVzc2lvbiB0eXBl
IGlzIGRpZmZlcmVudCBmcm9tIFpMSUIgKGRlZmF1bHQpIHRoZXJlDQo+ICsgICAgICogc2hvdWxk
IGJlIGJvdGggdGhlIGNvbXByZXNzaW9uIHR5cGUgYml0IGFuZCB0aGUgY29tcHJlc3Npb24NCj4g
KyAgICAgKiB0eXBlIGV4dGVuc2lvbiBoZWFkZXIgc2V0LiBXaGVuIHRoZSBaTElCIChkZWZhdWx0
KSBjb21wcmVzc2lvbg0KPiArICAgICAqIHR5cGUgaXMgdXNlZCB0aGVyZSBzaG91bGQgYmUgbmVp
dGhlciB0aGUgY29tcHJlc3Npb24gdHlwZSBiaXQgbm9yDQo+ICsgICAgICogdGhlIGNvbXByZXNz
aW9uIHR5cGUgZXh0ZW5zaW9uIGhlYWRlciBzZXQuDQo+ICsgICAgICovDQo+ICsNCj4gKyAgICBp
ZiAoKHMtPmluY29tcGF0aWJsZV9mZWF0dXJlcyAmIFFDT1cyX0lOQ09NUEFUX0NPTVBSRVNTSU9O
X1RZUEUpICYNCj4gKyAgICAgICAgKHMtPmNvbXByZXNzaW9uX3R5cGUgPT0gUUNPVzJfQ09NUFJF
U1NJT05fVFlQRV9aTElCKSkgew0KPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJJbGxlZ2Fs
IGNvbXByZXNzaW9uIHR5cGUgc2V0dGluZyIpOw0KPiArICAgICAgICByZXQgPSAtRUlOVkFMOw0K
PiArICAgICAgICBnb3RvIGZhaWw7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgLyogQ2hlY2sgYXZh
aWxhYmxlIGNvbXByZXNzaW9uIHR5cGVzICovDQo+ICsgICAgc3dpdGNoIChzLT5jb21wcmVzc2lv
bl90eXBlKSB7DQo+ICsgICAgY2FzZSBRQ09XMl9DT01QUkVTU0lPTl9UWVBFX1pMSUI6DQo+ICsg
ICAgICAgIGJyZWFrOw0KPiArDQo+ICsgICAgZGVmYXVsdDoNCj4gKyAgICAgICAgZXJyb3Jfc2V0
ZyhlcnJwLCAiVW5rbm93biBjb21wcmVzc2lvbiB0eXBlIik7DQo+ICsgICAgICAgIHJldCA9IC1F
SU5WQUw7DQo+ICsgICAgICAgIGdvdG8gZmFpbDsNCj4gKyAgICB9DQo+ICsNCj4gICAgICAgLyog
T3BlbiBleHRlcm5hbCBkYXRhIGZpbGUgKi8NCj4gICAgICAgcy0+ZGF0YV9maWxlID0gYmRydl9v
cGVuX2NoaWxkKE5VTEwsIG9wdGlvbnMsICJkYXRhLWZpbGUiLCBicywgJmNoaWxkX2ZpbGUsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0cnVlLCAmbG9jYWxfZXJyKTsN
Cj4gQEAgLTM5NzAsNyArNDAyOSw3IEBAIGZhaWw6DQo+ICAgfQ0KPiAgIA0KPiAgIC8qDQo+IC0g
KiBxY293Ml9jb21wcmVzcygpDQo+ICsgKiB6bGliX2NvbXByZXNzKCkNCj4gICAgKg0KPiAgICAq
IEBkZXN0IC0gZGVzdGluYXRpb24gYnVmZmVyLCBAZGVzdF9zaXplIGJ5dGVzDQo+ICAgICogQHNy
YyAtIHNvdXJjZSBidWZmZXIsIEBzcmNfc2l6ZSBieXRlcw0KPiBAQCAtMzk3OSw3ICs0MDM4LDcg
QEAgZmFpbDoNCj4gICAgKiAgICAgICAgICAtMSBkZXN0aW5hdGlvbiBidWZmZXIgaXMgbm90IGVu
b3VnaCB0byBzdG9yZSBjb21wcmVzc2VkIGRhdGENCj4gICAgKiAgICAgICAgICAtMiBvbiBhbnkg
b3RoZXIgZXJyb3INCj4gICAgKi8NCj4gLXN0YXRpYyBzc2l6ZV90IHFjb3cyX2NvbXByZXNzKHZv
aWQgKmRlc3QsIHNpemVfdCBkZXN0X3NpemUsDQo+ICtzdGF0aWMgc3NpemVfdCB6bGliX2NvbXBy
ZXNzKHZvaWQgKmRlc3QsIHNpemVfdCBkZXN0X3NpemUsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29uc3Qgdm9pZCAqc3JjLCBzaXplX3Qgc3JjX3NpemUpDQo+ICAgew0KPiAg
ICAgICBzc2l6ZV90IHJldDsNCj4gQEAgLTQwMTMsNyArNDA3Miw3IEBAIHN0YXRpYyBzc2l6ZV90
IHFjb3cyX2NvbXByZXNzKHZvaWQgKmRlc3QsIHNpemVfdCBkZXN0X3NpemUsDQo+ICAgfQ0KPiAg
IA0KPiAgIC8qDQo+IC0gKiBxY293Ml9kZWNvbXByZXNzKCkNCj4gKyAqIHpsaWJfZGVjb21wcmVz
cygpDQo+ICAgICoNCj4gICAgKiBEZWNvbXByZXNzIHNvbWUgZGF0YSAobm90IG1vcmUgdGhhbiBA
c3JjX3NpemUgYnl0ZXMpIHRvIHByb2R1Y2UgZXhhY3RseQ0KPiAgICAqIEBkZXN0X3NpemUgYnl0
ZXMuDQo+IEBAIC00MDI0LDcgKzQwODMsNyBAQCBzdGF0aWMgc3NpemVfdCBxY293Ml9jb21wcmVz
cyh2b2lkICpkZXN0LCBzaXplX3QgZGVzdF9zaXplLA0KPiAgICAqIFJldHVybnM6IDAgb24gc3Vj
Y2Vzcw0KPiAgICAqICAgICAgICAgIC0xIG9uIGZhaWwNCj4gICAgKi8NCj4gLXN0YXRpYyBzc2l6
ZV90IHFjb3cyX2RlY29tcHJlc3Modm9pZCAqZGVzdCwgc2l6ZV90IGRlc3Rfc2l6ZSwNCj4gK3N0
YXRpYyBzc2l6ZV90IHpsaWJfZGVjb21wcmVzcyh2b2lkICpkZXN0LCBzaXplX3QgZGVzdF9zaXpl
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgdm9pZCAqc3JjLCBz
aXplX3Qgc3JjX3NpemUpDQo+ICAgew0KPiAgICAgICBpbnQgcmV0ID0gMDsNCj4gQEAgLTQxMjIs
MTYgKzQxODEsMzggQEAgc3RhdGljIHNzaXplX3QgY29yb3V0aW5lX2ZuDQo+ICAgcWNvdzJfY29f
Y29tcHJlc3MoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHZvaWQgKmRlc3QsIHNpemVfdCBkZXN0X3Np
emUsDQo+ICAgICAgICAgICAgICAgICAgICAgY29uc3Qgdm9pZCAqc3JjLCBzaXplX3Qgc3JjX3Np
emUpDQo+ICAgew0KPiAtICAgIHJldHVybiBxY293Ml9jb19kb19jb21wcmVzcyhicywgZGVzdCwg
ZGVzdF9zaXplLCBzcmMsIHNyY19zaXplLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBxY293Ml9jb21wcmVzcyk7DQo+ICsgICAgQkRSVlFjb3cyU3RhdGUgKnMgPSBicy0+b3Bh
cXVlOw0KPiArICAgIFFjb3cyQ29tcHJlc3NGdW5jIGZuOw0KPiArDQo+ICsgICAgc3dpdGNoIChz
LT5jb21wcmVzc2lvbl90eXBlKSB7DQo+ICsgICAgY2FzZSBRQ09XMl9DT01QUkVTU0lPTl9UWVBF
X1pMSUI6DQo+ICsgICAgICAgIGZuID0gemxpYl9jb21wcmVzczsNCj4gKyAgICAgICAgYnJlYWs7
DQo+ICsNCj4gKyAgICBkZWZhdWx0Og0KPiArICAgICAgICByZXR1cm4gLUVOT1RTVVA7DQo+ICsg
ICAgfQ0KPiArDQo+ICsgICAgcmV0dXJuIHFjb3cyX2NvX2RvX2NvbXByZXNzKGJzLCBkZXN0LCBk
ZXN0X3NpemUsIHNyYywgc3JjX3NpemUsIGZuKTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHNz
aXplX3QgY29yb3V0aW5lX2ZuDQo+ICAgcWNvdzJfY29fZGVjb21wcmVzcyhCbG9ja0RyaXZlclN0
YXRlICpicywgdm9pZCAqZGVzdCwgc2l6ZV90IGRlc3Rfc2l6ZSwNCj4gICAgICAgICAgICAgICAg
ICAgICAgIGNvbnN0IHZvaWQgKnNyYywgc2l6ZV90IHNyY19zaXplKQ0KPiAgIHsNCj4gLSAgICBy
ZXR1cm4gcWNvdzJfY29fZG9fY29tcHJlc3MoYnMsIGRlc3QsIGRlc3Rfc2l6ZSwgc3JjLCBzcmNf
c2l6ZSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcWNvdzJfZGVjb21wcmVz
cyk7DQo+ICsgICAgQkRSVlFjb3cyU3RhdGUgKnMgPSBicy0+b3BhcXVlOw0KPiArICAgIFFjb3cy
Q29tcHJlc3NGdW5jIGZuOw0KPiArDQo+ICsgICAgc3dpdGNoIChzLT5jb21wcmVzc2lvbl90eXBl
KSB7DQo+ICsgICAgY2FzZSBRQ09XMl9DT01QUkVTU0lPTl9UWVBFX1pMSUI6DQo+ICsgICAgICAg
IGZuID0gemxpYl9kZWNvbXByZXNzOw0KPiArICAgICAgICBicmVhazsNCj4gKw0KPiArICAgIGRl
ZmF1bHQ6DQo+ICsgICAgICAgIHJldHVybiAtRU5PVFNVUDsNCj4gKyAgICB9DQo+ICsNCj4gKyAg
ICByZXR1cm4gcWNvdzJfY29fZG9fY29tcHJlc3MoYnMsIGRlc3QsIGRlc3Rfc2l6ZSwgc3JjLCBz
cmNfc2l6ZSwgZm4pOw0KPiAgIH0NCj4gICANCj4gICAvKiBYWFg6IHB1dCBjb21wcmVzc2VkIHNl
Y3RvcnMgZmlyc3QsIHRoZW4gYWxsIHRoZSBjbHVzdGVyIGFsaWduZWQNCj4gDQoNClRoZXNlIHRo
aW5ncyAoY29tcHJlc3Npb24pIGFyZSBtb3ZlZCB0byBzZXBhcmF0ZSBmaWxlIGJ5IG15IHBhdGNo
ZXMsIHN0YWdlZCBpbiBNYXgncyBibG9jayBicmFuY2g6DQoNCmh0dHBzOi8vZ2l0LnhhbmNsaWMu
bW9lL1hhbkNsaWMvcWVtdS9jb21taXRzL2JyYW5jaC9ibG9jaw0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=

