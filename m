Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CFFC10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 06:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8041D20693
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 06:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cY28XfFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8041D20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47842 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGe7I-0004VN-1V
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 02:32:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGe6U-0004EZ-ED
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGe6T-0005wQ-DD
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:31:30 -0400
Received: from mail-eopbgr50134.outbound.protection.outlook.com
	([40.107.5.134]:19743
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hGe6S-0005vX-Ls
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=U3Ez2yRnrVGSYqSCfLx9eRV495eY1zCCHs3bR1Ae+0I=;
	b=cY28XfFy993OVY5aKWPpfwpqhknbD46WdScQE+gPx25M9wG9fpw1Mk8h1HVysvflDfoRkOzXAys+WTLF4BK6GBta4G0E4Ql4y05+ScA23MtEJkwP9nS7sjc3J8e8TJlHCH2i3OPeQt6FigexWpM47lnC0QmIQfhtNWB0IIxawvI=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3004.eurprd08.prod.outlook.com (52.134.109.158) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.19; Wed, 17 Apr 2019 06:31:23 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1792.018;
	Wed, 17 Apr 2019 06:31:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH] error: Fix error_report_err(), warn_report_err() hint
	printing
Thread-Index: AQHU9GqATqcg3voDiEWMIaAxjvjXyaY/5YKA
Date: Wed, 17 Apr 2019 06:31:23 +0000
Message-ID: <1b423cd5-3814-5b1d-f5fe-b315e4268137@virtuozzo.com>
References: <20190416153850.5186-1-armbru@redhat.com>
In-Reply-To: <20190416153850.5186-1-armbru@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0162.eurprd06.prod.outlook.com
	(2603:10a6:7:16::49) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190417093121086
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24e56148-7f89-415b-732f-08d6c2fe4f8c
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3004; 
x-ms-traffictypediagnostic: DB7PR08MB3004:
x-microsoft-antispam-prvs: <DB7PR08MB3004848A59A096118AAAA35DC1250@DB7PR08MB3004.eurprd08.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39840400004)(189003)(199004)(68736007)(53936002)(6512007)(6486002)(97736004)(6436002)(229853002)(2501003)(305945005)(25786009)(476003)(7736002)(31686004)(11346002)(446003)(2616005)(486006)(66066001)(186003)(52116002)(386003)(26005)(14454004)(86362001)(76176011)(2906002)(6506007)(102836004)(256004)(71190400001)(478600001)(105586002)(31696002)(71200400001)(4326008)(106356001)(316002)(36756003)(81166006)(81156014)(8676002)(8936002)(3846002)(110136005)(5660300002)(99286004)(6116002)(6246003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3004;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XdGlCOeAHcGTkFxYDBhm5klOPpwZdLXwo4/Nq6PLG5cIF44h/+XV/T2E/3mRT4Nsbu/4rh1/PIgRBMt8LlxcK6Dcq+y2UildfQ65PTJ4XZEGeM69ihM2abAtXTZZ2lx8DQgBbharf8J8Clxn4vuOUI1cW8cvsMH7W2q1wOTbab/UHTJqCawdZhXAKAE+foD+GPFTaXZQp1iEYadAk2p8lU47/QuTsUxXZw+lTAgbf0TpV0GBDAXDQRwkY5MJsBtG6SAK8ZLdPhl8elNA63+xai48TRdMEVpjeu2/mCU8wLjt1qcxMLEq8UA1HkOEAi7u8N6IysLrJXQrul91eExMjvTLj9/MJXP8+Wc7H0B5C/wZtTkygUVrb3u4uLcpTyZykEoiMHBKPBQGELYqrMLEZytFLeUzYLpCFVjOESfU/+0=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <AC85C3E4AEA1CE4F85878461AA93A0E6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e56148-7f89-415b-732f-08d6c2fe4f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 06:31:23.5653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3004
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.134
Subject: Re: [Qemu-devel] [PATCH] error: Fix error_report_err(),
 warn_report_err() hint printing
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417063123.WjIQSSoYkUaexLui5_h9CvJeswaxtbJiBi1i3mTgTY4@z>

MTYuMDQuMjAxOSAxODozOCwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IEJlZm9yZSB0aGUg
ZnJvbSBxZXJyb3JfcmVwb3J0KCkgdG8gZXJyb3Jfc2V0ZygpLCBoaW50cyBsb29rZWQgbGlrZQ0K
PiB0aGlzOg0KPiANCj4gICAgICBxZXJyb3JfcmVwb3J0KFFFUlJfTUFDUk8sIC4uLiBhcmd1bWVu
dHMgLi4uKTsNCj4gICAgICBlcnJvcl9wcmludGZfdW5sZXNzX3FtcCguLi4gaGludCAuLi4pOw0K
PiANCj4gZXJyb3JfcHJpbnRmX3VubGVzc19xbXAoKSBtYWRlIHBlcmZlY3Qgc2Vuc2U6IGl0IHBy
aW50ZWQgZXhhY3RseSB3aGVuDQo+IHFlcnJvcl9yZXBvcnQoKSBkaWQuDQo+IA0KPiBBZnRlciB0
aGUgY29udmVyc2lvbiB0byBlcnJvcl9zZXRnKCk6DQo+IA0KPiAgICAgIGVycm9yX3NldGcoZXJy
cCwgUUVSUl9NQUNSTywgLi4uIGFyZ3VtZW50cyAuLi4pOw0KPiAgICAgIGVycm9yX3ByaW50Zl91
bmxlc3NfcW1wKC4uLiBoaW50IC4uLik7DQo+IA0KPiBUaGUgInVubGVzcyBRTVAgcGFydCIgc3Rp
bGwgbWFkZSBzb21lIHNlbnNlOyBpbiBRTVAgY29udGV4dCwgdGhlDQo+IGNhbGxlciBnZW5lcmFs
bHkgdXNlcyB0aGUgZXJyb3IgYXMgUU1QIHJlc3BvbnNlIGluc3RlYWQgb2YgcHJpbnRpbmcNCj4g
aXQuDQo+IA0KPiBIb3dldmVyLCBldmVyeXRoaW5nIGVsc2UgaXMgd3JvbmcuICBJZiB0aGUgY2Fs
bGVyIGhhbmRsZXMgdGhlIGVycm9yLA0KPiB0aGUgaGludCBnZXRzIHByaW50ZWQgYW55d2F5ICh1
bmxlc3MgUU1QKS4gIElmIHRoZSBjYWxsZXIgcmVwb3J0cyB0aGUNCj4gZXJyb3IsIHRoZSBoaW50
IGdldHMgcHJpbnRlZCAqYmVmb3JlKiB0aGUgcmVwb3J0ICh1bmxlc3MgUU1QKSBvciBub3QNCj4g
YXQgYWxsIChpZiBRTVApLg0KPiANCj4gQ29tbWl0IDUwYjdiMDAwYzkxIGZpeGVkIHRoaXMgYnkg
bWFraW5nIGhpbnRzIGEgbWVtYmVyIG9mIEVycm9yLiAgSXQNCj4ga2VwdCBwcmludGluZyBoaW50
cyB3aXRoIGVycm9yX3ByaW50Zl91bmxlc3NfcW1wKCk6DQo+IA0KPiAgICAgICB2b2lkIGVycm9y
X3JlcG9ydF9lcnIoRXJyb3IgKmVycikNCj4gICAgICAgew0KPiAJIGVycm9yX3JlcG9ydCgiJXMi
LCBlcnJvcl9nZXRfcHJldHR5KGVycikpOw0KPiAgICAgICsgICAgaWYgKGVyci0+aGludCkgew0K
PiAgICAgICsgICAgICAgIGVycm9yX3ByaW50Zl91bmxlc3NfcW1wKCIlc1xuIiwgZXJyLT5oaW50
LT5zdHIpOw0KPiAgICAgICsgICAgfQ0KPiAJIGVycm9yX2ZyZWUoZXJyKTsNCj4gICAgICAgfQ0K
PiANCj4gVGhpcyBpcyB3cm9uZy4gIFdlIHNob3VsZCAoYW5kIG5vdyBjYW4pIHByaW50IHRoZSBo
aW50IGV4YWN0bHkgd2hlbiB3ZQ0KPiBwcmludCB0aGUgZXJyb3IuDQo+IA0KPiBUaGUgbWlzdGFr
ZSBoYXMgc2luY2UgYmVlbiBjb3BpZWQgdG8gd2Fybl9yZXBvcnRfZXJyKCkuDQo+IA0KPiBGaXgg
Ym90aCB0byB1c2UgZXJyb3JfcHJpbnRmKCkuDQo+IA0KPiBSZXBvcnRlZC1ieTogVmxhZGltaXIg
U2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPiBDYzogRXJp
YyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1i
cnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgdXRpbC9lcnJvci5jIHwgNCAr
Ky0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS91dGlsL2Vycm9yLmMgYi91dGlsL2Vycm9yLmMNCj4gaW5kZXgg
OTM0YTc4ZTFiMS4uNzEyYjRkNGI1ZCAxMDA2NDQNCj4gLS0tIGEvdXRpbC9lcnJvci5jDQo+ICsr
KyBiL3V0aWwvZXJyb3IuYw0KPiBAQCAtMjIzLDcgKzIyMyw3IEBAIHZvaWQgZXJyb3JfcmVwb3J0
X2VycihFcnJvciAqZXJyKQ0KPiAgIHsNCj4gICAgICAgZXJyb3JfcmVwb3J0KCIlcyIsIGVycm9y
X2dldF9wcmV0dHkoZXJyKSk7DQo+ICAgICAgIGlmIChlcnItPmhpbnQpIHsNCj4gLSAgICAgICAg
ZXJyb3JfcHJpbnRmX3VubGVzc19xbXAoIiVzIiwgZXJyLT5oaW50LT5zdHIpOw0KPiArICAgICAg
ICBlcnJvcl9wcmludGYoIiVzIiwgZXJyLT5oaW50LT5zdHIpOw0KPiAgICAgICB9DQo+ICAgICAg
IGVycm9yX2ZyZWUoZXJyKTsNCj4gICB9DQo+IEBAIC0yMzIsNyArMjMyLDcgQEAgdm9pZCB3YXJu
X3JlcG9ydF9lcnIoRXJyb3IgKmVycikNCj4gICB7DQo+ICAgICAgIHdhcm5fcmVwb3J0KCIlcyIs
IGVycm9yX2dldF9wcmV0dHkoZXJyKSk7DQo+ICAgICAgIGlmIChlcnItPmhpbnQpIHsNCj4gLSAg
ICAgICAgZXJyb3JfcHJpbnRmX3VubGVzc19xbXAoIiVzIiwgZXJyLT5oaW50LT5zdHIpOw0KPiAr
ICAgICAgICBlcnJvcl9wcmludGYoIiVzIiwgZXJyLT5oaW50LT5zdHIpOw0KPiAgICAgICB9DQo+
ICAgICAgIGVycm9yX2ZyZWUoZXJyKTsNCj4gICB9DQo+IA0KDQoNClJldmlld2VkLWJ5OiBWbGFk
aW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCg0K
LS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

