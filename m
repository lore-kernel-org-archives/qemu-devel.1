Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCF9C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 06:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A852073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 06:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Q+hukPMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A852073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60173 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGHkV-0003wA-AN
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 02:39:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGHjd-0003dL-MB
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGHja-0002S7-BE
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:38:24 -0400
Received: from mail-ve1eur01on0708.outbound.protection.outlook.com
	([2a01:111:f400:fe1f::708]:10816
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hGHjZ-0002R7-A0
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=jiXU35+Tydpm8IDGnjF3UaRCozkN0ydn5bhQn1ePJRI=;
	b=Q+hukPMzb0lfsysoeRj0FCWqruYBn5xsTTCBf601zz7rHtGci4wA/KxBxikOEa0ql6oKkvilEUjUWloNMcrSY/FVKCUv0NlKTksyz4F10H76kLhtFVZ8BKv76qXwbWjhK2v9c17qHtQdlkH7eJgRGWBSGnIxShk5XdeADr7Vd8g=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3721.eurprd08.prod.outlook.com (20.178.47.220) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.19; Tue, 16 Apr 2019 06:38:17 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1792.018;
	Tue, 16 Apr 2019 06:38:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH] util/error: do not free error on error_abort
Thread-Index: AQHU8hMKJR89uvD2b0yiP5/R2LIrXaY8unlEgAB6CgCAAAATB4AAB5OAgAEcnw+AAAECgA==
Date: Tue, 16 Apr 2019 06:38:17 +0000
Message-ID: <da576bee-8ed5-13d9-7f29-74110d6ccb4b@virtuozzo.com>
References: <20190413160732.55505-1-vsementsov@virtuozzo.com>
	<87zhorbytu.fsf@dusky.pond.sub.org>
	<3381f703-4fc1-ac3c-658c-f7399403acf9@virtuozzo.com>
	<874l6za00z.fsf@dusky.pond.sub.org>
	<e432f8cf-4014-8175-4a56-167a14534528@virtuozzo.com>
	<87k1fu791j.fsf@dusky.pond.sub.org>
In-Reply-To: <87k1fu791j.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0004.eurprd02.prod.outlook.com
	(2603:10a6:3:8c::14) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190416093815426
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab490970-981c-46ee-0cba-08d6c2361bd5
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:DB7PR08MB3721; 
x-ms-traffictypediagnostic: DB7PR08MB3721:
x-microsoft-antispam-prvs: <DB7PR08MB3721CB0CEF32F43C1B7DD9B3C1240@DB7PR08MB3721.eurprd08.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(396003)(39840400004)(346002)(136003)(199004)(189003)(25786009)(52116002)(446003)(6486002)(5660300002)(229853002)(3846002)(99286004)(4326008)(53936002)(11346002)(6246003)(6116002)(93886005)(68736007)(31686004)(316002)(14454004)(86362001)(76176011)(6436002)(97736004)(2616005)(6916009)(2906002)(31696002)(106356001)(6512007)(36756003)(81166006)(105586002)(6506007)(26005)(71200400001)(81156014)(8676002)(486006)(386003)(71190400001)(66066001)(8936002)(305945005)(186003)(256004)(478600001)(102836004)(14444005)(7736002)(476003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3721;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BcNnIN6oyxA++NHAOHHUjzsc55wayTqymj0qUhipft0D8U08sKmueLiZCEuwUz5UnovG1T0Q1HgEZ50F+TDDX67Nbq3zo5XNHbPKUqZv6gVeBOOVnA+JA7MdptzWhbiC42ip7qdeUaiczoNlO4TVX5a7kkYhR/vylFDu3KJIZ6FAZb78zEAbCpifJXTL9bBQX6y84oez7mfIosMNS6DUoYtrrD+vfv/U7rVpuobcOqnLIkraNXQrsseT/DplJJLq1ZNBTXhzyLoO3F4XdZhPR0lU/ylSGH1lUaThvC5Kxla9CfCMBUTMuqWMqEfDrrlX/+nl+jzxokMkApd3WBD7eIVjkePhCLlK118d2WYJVR8a9jaND+nxh85U+SgJ+oyEGAlFHImDxQxFuJlJmWjZL6EYSEkqoYN/5WMyenf4dYg=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <5F32F1A628189144B204160DC9F73AFF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab490970-981c-46ee-0cba-08d6c2361bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 06:38:17.3495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3721
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::708
Subject: Re: [Qemu-devel] [PATCH] util/error: do not free error on
 error_abort
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416063817.SZPafUh56HlWrXTiBm321Kl7lRlZdsMq95ox0Uyn1E8@z>

MTYuMDQuMjAxOSA5OjM0LCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4gVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPiB3cml0ZXM6DQo+IA0K
Pj4gMTUuMDQuMjAxOSAxNjowOCwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+Pj4gVmxhZGlt
aXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPiB3cml0ZXM6
DQo+Pj4NCj4+Pj4gMTUuMDQuMjAxOSA4OjUxLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4+
Pj4+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNv
bT4gd3JpdGVzOg0KPj4+Pj4NCj4+Pj4+PiBJdCB3b3VsZCBiZSBuaWNlIHRvIGhhdmUgRXJyb3Ig
b2JqZWN0IG5vdCBmcmVlZCBhd2F5IHdoZW4gZGVidWdnaW5nIGENCj4+Pj4+PiBjb3JlZHVtcC4N
Cj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiAgICAgdXRp
bC9lcnJvci5jIHwgOCArKysrKy0tLQ0KPj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL3V0
aWwvZXJyb3IuYyBiL3V0aWwvZXJyb3IuYw0KPj4+Pj4+IGluZGV4IDkzNGE3OGUxYjEuLmY5MTgw
YzBmMzAgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvdXRpbC9lcnJvci5jDQo+Pj4+Pj4gKysrIGIvdXRp
bC9lcnJvci5jDQo+Pj4+Pj4gQEAgLTMyLDkgKzMyLDExIEBAIEVycm9yICplcnJvcl9mYXRhbDsN
Cj4+Pj4+PiAgICAgc3RhdGljIHZvaWQgZXJyb3JfaGFuZGxlX2ZhdGFsKEVycm9yICoqZXJycCwg
RXJyb3IgKmVycikNCj4+Pj4+PiAgICAgew0KPj4+Pj4+ICAgICAgICAgaWYgKGVycnAgPT0gJmVy
cm9yX2Fib3J0KSB7DQo+Pj4+Pj4gLSAgICAgICAgZnByaW50ZihzdGRlcnIsICJVbmV4cGVjdGVk
IGVycm9yIGluICVzKCkgYXQgJXM6JWQ6XG4iLA0KPj4+Pj4+IC0gICAgICAgICAgICAgICAgZXJy
LT5mdW5jLCBlcnItPnNyYywgZXJyLT5saW5lKTsNCj4+Pj4+PiAtICAgICAgICBlcnJvcl9yZXBv
cnRfZXJyKGVycik7DQo+Pj4+Pj4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJVbmV4cGVjdGVkIGVy
cm9yIGluICVzKCkgYXQgJXM6JWQ6ICVzIiwNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAg
ZXJyLT5mdW5jLCBlcnItPnNyYywgZXJyLT5saW5lLCBlcnJvcl9nZXRfcHJldHR5KGVycikpOw0K
Pj4+Pj4+ICsgICAgICAgIGlmIChlcnItPmhpbnQpIHsNCj4+Pj4+PiArICAgICAgICAgICAgZXJy
b3JfcHJpbnRmX3VubGVzc19xbXAoIiVzIiwgZXJyLT5oaW50LT5zdHIpOw0KPj4+Pj4+ICsgICAg
ICAgIH0NCj4+Pj4+PiAgICAgICAgICAgICBhYm9ydCgpOw0KPj4+Pj4+ICAgICAgICAgfQ0KPj4+
Pj4+ICAgICAgICAgaWYgKGVycnAgPT0gJmVycm9yX2ZhdGFsKSB7DQo+Pj4+Pg0KPj4+Pj4gTm8g
b2JqZWN0aW9ucyB0byBub3QgZnJlZWluZyB0aGUgZXJyb3Igb2JqZWN0IG9uIHRoZSBwYXRoIHRv
IGFib3J0KCkuDQo+Pj4+Pg0KPj4+Pj4gWW91IGFsc28gZm9ybWF0IHRoZSBlcnJvciBtZXNzYWdl
IGRpZmZlcmVudGx5LiAgQ29tbWl0IDFlOWI2NWJiMWJhJ3MNCj4+Pj4+IGV4YW1wbGUNCj4+Pj4+
DQo+Pj4+PiAgICAgICAgICAgIFVuZXhwZWN0ZWQgZXJyb3IgaW4gcGFyc2VfYmxvY2tfZXJyb3Jf
YWN0aW9uKCkgYXQgLi4uL3FlbXUvYmxvY2tkZXYuYzozMjI6DQo+Pj4+PiAgICAgICAgICAgIHFl
bXUtc3lzdGVtLXg4Nl82NDogLWRyaXZlIGlmPW5vbmUsd2Vycm9yPWZvbzogJ2ZvbycgaW52YWxp
ZCB3cml0ZSBlcnJvciBhY3Rpb24NCj4+Pj4+ICAgICAgICAgICAgQWJvcnRlZCAoY29yZSBkdW1w
ZWQpDQo+Pj4+Pg0KPj4+Pj4gY2hhbmdlcyB0byAoZ3Vlc3N3b3JrLCBub3QgdGVzdGVkKToNCj4+
Pj4+DQo+Pj4+PiAgICAgICAgICAgIHFlbXUtc3lzdGVtLXg4Nl82NDogLWRyaXZlIGlmPW5vbmUs
d2Vycm9yPWZvbzogVW5leHBlY3RlZCBlcnJvciBpbiBwYXJzZV9ibG9ja19lcnJvcl9hY3Rpb24o
KSBhdCAuLi4vcWVtdS9ibG9ja2Rldi5jOjMyMjogJ2ZvbycgaW52YWxpZCB3cml0ZSBlcnJvciBh
Y3Rpb24NCj4+Pj4+ICAgICAgICAgICAgQWJvcnRlZCAoY29yZSBkdW1wZWQpDQo+Pj4+DQo+Pj4+
IGhtLiBjaGVja3BhdGNoIGRvbid0IGFsbG93IHRvIHB1dCBcbiBpbnRvIGVycm9yX3JlcG9ydC4g
U28sIHNob3VsZCBJIGNhbGwgZXJyb3JfcmVwb3J0IHR3aWNlPw0KPj4+Pg0KPj4+PiBUcmFuc2l0
aW9uIGZyb20gZnByaW50ZiB0byBlcnJvcl9yZXBvcnQgaXMgT0sgZm9yIHlvdT8NCj4+Pg0KPj4+
IExldCdzIHNpbXBseSBub3QgbWVzcyB3aXRoIHRoZSBmb3JtYXR0aW5nIGF0IGFsbC4gIFNvbWV0
aGluZyBsaWtlOg0KPj4+DQo+Pj4gKDEpIElubGluZSBlcnJvcl9yZXBvcnRfZXJyKCksIGRlbGV0
ZSB0aGUgZXJyb3JfZnJlZSgpDQo+Pj4NCj4+PiAoMikgT3B0aW9uYWw6IHJlcGxhY2UgZnByaW50
ZigpIGJ5IGVycm9yX3ByaW50ZigpDQo+Pj4NCj4+PiAoMykgT3B0aW9uYWw6IGNsZWFuIHVwIHRo
ZSBhZGRpdGlvbmFsIGNvcHkgb2YNCj4+Pg0KPj4+ICAgICAgICAgICBpZiAoZXJyLT5oaW50KSB7
DQo+Pj4gICAgICAgICAgICAgICBlcnJvcl9wcmludGZfdW5sZXNzX3FtcCgiJXMiLCBlcnItPmhp
bnQtPnN0cik7DQo+Pj4gICAgICAgICAgIH0NCj4+Pg0KPj4+ICgzYSkgRWl0aGVyIGNyZWF0ZSBh
IGhlbHBlciBmdW5jdGlvbiwgcmVwbGFjaW5nIGFsbCB0aHJlZSBjb3BpZXMsDQo+Pj4NCj4+PiAo
M2IpIE9yIHNpbXBseSBkZWxldGUgdGhlIG5ldyBjb3B5IGZyb20gdGhlIHBhdGggbGVhZGluZyB0
byBhYm9ydCgpLA0KPj4+ICAgICAgICBzaW5jZSB0aGUgaGludCBpcyB1bmxpa2VseSB0byBiZSB1
c2VmdWwgdGhlcmUuDQo+Pj4NCj4+DQo+PiBXaHkgd2UgcHJpbnQgZXJyb3IgYWx3YXlzIGJ1dCBo
aW50IG9ubHkgInVubGVzc19xbXAiPw0KPiANCj4gIkhpbnRzIiBhcmUgaW50ZW5kZWQgZm9yIGdp
dmluZyBoaW50cyB0byBhIGh1bWFuIHVzZXIgKGFsdGhvdWdoIHRoZXkgYXJlDQo+IG1pc3VzZWQg
Zm9yIG90aGVyIHB1cnBvc2VzIGluIHBsYWNlcyk6DQo+IA0KPiAvKg0KPiAgICogQXBwZW5kIGEg
cHJpbnRmLXN0eWxlIGh1bWFuLXJlYWRhYmxlIGV4cGxhbmF0aW9uIHRvIGFuIGV4aXN0aW5nIGVy
cm9yLg0KPiAgICogSWYgdGhlIGVycm9yIGlzIGxhdGVyIHJlcG9ydGVkIHRvIGEgaHVtYW4gdXNl
ciB3aXRoDQo+ICAgKiBlcnJvcl9yZXBvcnRfZXJyKCkgb3Igd2Fybl9yZXBvcnRfZXJyKCksIHRo
ZSBoaW50cyB3aWxsIGJlIHNob3duLA0KPiAgICogdG9vLiAgSWYgaXQncyByZXBvcnRlZCB2aWEg
UU1QLCB0aGUgaGludHMgd2lsbCBiZSBpZ25vcmVkLg0KPiAgICogSW50ZW5kZWQgdXNlIGlzIGFk
ZGluZyBoZWxwZnVsIGhpbnRzIG9uIHRoZSBodW1hbiB1c2VyIGludGVyZmFjZSwNCj4gICAqIGUu
Zy4gYSBsaXN0IG9mIHZhbGlkIHZhbHVlcy4gIEl0J3Mgbm90IGZvciBjbGFyaWZ5aW5nIGEgY29u
ZnVzaW5nDQo+ICAgKiBlcnJvciBtZXNzYWdlLg0KPiAgICogQGVycnAgbWF5IGJlIE5VTEwsIGJ1
dCBub3QgJmVycm9yX2ZhdGFsIG9yICZlcnJvcl9hYm9ydC4NCj4gICAqIFRyaXZpYWxseSB0aGUg
Y2FzZSBpZiB5b3UgY2FsbCBpdCBvbmx5IGFmdGVyIGVycm9yX3NldGcoKSBvcg0KPiAgICogZXJy
b3JfcHJvcGFnYXRlKCkuDQo+ICAgKiBNYXkgYmUgY2FsbGVkIG11bHRpcGxlIHRpbWVzLiAgVGhl
IHJlc3VsdGluZyBoaW50IHNob3VsZCBlbmQgd2l0aCBhDQo+ICAgKiBuZXdsaW5lLg0KPiAgICov
DQo+IHZvaWQgZXJyb3JfYXBwZW5kX2hpbnQoRXJyb3IgKiplcnJwLCBjb25zdCBjaGFyICpmbXQs
IC4uLikNCj4gICAgICBHQ0NfRk1UX0FUVFIoMiwgMyk7DQo+IA0KDQpIbW0sIHRoaXMgbWVhbnMs
IHRoYXQgaW4gZXJyb3JfcmVwb3J0X2VyciBjaGVja2luZyBmb3IgcW1wIG1vbml0b3IgaXMgd3Jv
bmcgdGhpbmcsDQphcyBlcnJvcl9yZXBvcnRfZXJyIGlzIGV4YWN0bHkgZm9yIGh1bWFuIHVzZXIg
d2hvIHdpbGwgcmVhZCBxZW11IGxvZyBhbmQgd2lsbCBuZWVkDQptYXhpbXVtIGluZm9ybWF0aW9u
Lg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

