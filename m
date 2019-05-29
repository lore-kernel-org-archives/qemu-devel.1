Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010AFC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA69823CA0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gK9MmNGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA69823CA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW0zh-0004f6-1F
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 12:00:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hW0yu-0004Jx-QN
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hW0yt-0004yg-8j
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:59:12 -0400
Received: from mail-ve1eur02on070c.outbound.protection.outlook.com
	([2a01:111:f400:fe06::70c]:12470
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hW0ym-0004tz-M9; Wed, 29 May 2019 11:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=49hh8qxyoMiG1FTy/dUuHeVLWQSU4KSUZDUYsHhd/eo=;
	b=gK9MmNGqO55xa3+x2CYAaEzRojB/31da+2qVJV2UxG0pSw42W4+CBtfFurmJlChyiP+5VPqzKbsRgY8ZI1fMI/dMkJdtU8nr36KsS2Iz+Jizuj5W9VejCuL7RLu7cqngcgAAfseEwVURyDaKHWoXK9bBpN5+vSh56RsoG7N0Eyk=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB3971.eurprd08.prod.outlook.com (20.178.202.216) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.18; Wed, 29 May 2019 15:58:59 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::9499:ef6a:95e:a3c6]) by AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::9499:ef6a:95e:a3c6%4]) with mapi id 15.20.1922.021;
	Wed, 29 May 2019 15:58:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH 3/3] block/qcow2-bitmap: rewrite bitmap reopening logic
Thread-Index: AQHVEX7kb+YUVuiEF0SEYwFufr/zvqaCRK0AgAAHLYA=
Date: Wed, 29 May 2019 15:58:59 +0000
Message-ID: <a49711ca-2845-bac5-022e-abcde1f103c5@virtuozzo.com>
References: <20190523154733.54944-1-vsementsov@virtuozzo.com>
	<20190523154733.54944-4-vsementsov@virtuozzo.com>
	<1950138d-f65a-9458-2d7d-8267ba3463e8@redhat.com>
In-Reply-To: <1950138d-f65a-9458-2d7d-8267ba3463e8@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0009.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:3:f7::19) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190529185857079
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a23bde6-ad2f-41c5-519a-08d6e44e8fd0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:AM0PR08MB3971; 
x-ms-traffictypediagnostic: AM0PR08MB3971:
x-microsoft-antispam-prvs: <AM0PR08MB3971CA6B000E94269BDD772DC11F0@AM0PR08MB3971.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(39850400004)(376002)(136003)(366004)(396003)(52314003)(199004)(189003)(11346002)(486006)(8936002)(2616005)(478600001)(31686004)(86362001)(6512007)(71200400001)(31696002)(446003)(76176011)(71190400001)(6246003)(14444005)(256004)(81166006)(102836004)(99286004)(19627235002)(53546011)(386003)(53936002)(8676002)(36756003)(6506007)(66066001)(81156014)(14454004)(4326008)(64756008)(476003)(26005)(52116002)(6486002)(73956011)(229853002)(66946007)(2201001)(316002)(6436002)(7736002)(6116002)(68736007)(3846002)(2501003)(305945005)(186003)(54906003)(5660300002)(110136005)(2906002)(25786009)(66556008)(66476007)(66446008);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3971;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ECjjRJoclVs0f97wgTZW0dJQmuiinOdttk+7s9XrAmjRZUHD7DrEPot7YKF6SmLZMKMkHEuciePwYIzJ5TfMvsCNje5xltgyhwbgSPL7P1dgR4Qp2CTUzEQV30K9E5h/uChtsZqLeYXW7hROx1xhqTFiKCusK8z+brNwa/4RVyEbLvqbnKou18XbWBHqp8c7xfpSZseKi8mgT5eZ4ZSeYYUNfnfckRQHSSH/GcHMvm6+czN1D833+9T1j5I1k5t2j3hmBVd5jDUlPTZxkka7Q6nmJGj1MDJDkixEk+1PqUVspPKiiONgJDlSHZ7Kqz16P8aEIwO0R2JMUoM7EFvNfQrhmuo6eL8GpnwqDmCcFcvkDYaz2QYWfMfxnki6NTh+WPYaGffn9txoTigmwrP7w4X0G6mUP/94M03VdDFHk58=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBAB8A7C5C4B03418DB2B4B14DF12FF7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a23bde6-ad2f-41c5-519a-08d6e44e8fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 15:58:59.4358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3971
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe06::70c
Subject: Re: [Qemu-devel] [PATCH 3/3] block/qcow2-bitmap: rewrite bitmap
 reopening logic
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>,
	Alberto Garcia <berto@igalia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMDUuMjAxOSAxODozMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyMy4wNS4xOSAxNzo0Nywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEN1cnJlbnQgbG9naWMNCj4+
ID09PT09PT09PT09PT0NCj4+DQo+PiBSZW9wZW4gcncgLT4gcm86DQo+Pg0KPj4gU3RvcmUgYml0
bWFwcyBhbmQgcmVsZWFzZSBCZHJ2RGlydHlCaXRtYXAncy4NCj4+DQo+PiBSZW9wZW4gcm8gLT4g
cnc6DQo+Pg0KPj4gTG9hZCBiaXRtYXAgbGlzdA0KPj4gU2tpcCBiaXRtYXBzIHdoaWNoIGZvciB3
aGljaCB3ZSBkb24ndCBoYXZlIEJkcnZEaXJ0eUJpdG1hcCBbdGhpcyBpcw0KPj4gICAgIHRoZSB3
b3JzdCB0aGluZ10NCj4+IEEga2luZCBvZiBmYWlsIHdpdGggZXJyb3IgbWVzc2FnZSBpZiB3ZSBz
ZWUgbm90IHJlYWRvbmx5IGJpdG1hcA0KPj4NCj4+IFRoaXMgbGVhZHMgdG8gYXQgbGVhc3QgdGhl
IGZvbGxvd2luZyBidWc6DQo+Pg0KPj4gQXNzdW1lIHdlIGhhdmUgYml0bWFwMC4NCj4+IENyZWF0
ZSBleHRlcm5hbCBzbmFwc2hvdA0KPj4gICAgYml0bWFwMCBpcyBzdG9yZWQgYW5kIHRoZXJlZm9y
ZSByZW1vdmVkDQo+PiBDb21taXQgc25hcHNob3QNCj4+ICAgIG5vdyB3ZSBoYXZlIG5vIGJpdG1h
cHMNCj4+IERvIHNvbWUgd3JpdGVzIGZyb20gZ3Vlc3QgKCopDQo+PiAgICB0aGV5IGFyZSBub3Qg
bWFya2VkIGluIGJpdG1hcA0KPj4gU2h1dGRvd24NCj4+IFN0YXJ0DQo+PiAgICBiaXRtYXAwIGlz
IGxvYWRlZCBhcyB2YWxpZCwgYnV0IGl0IGlzIGFjdHVhbGx5IGJyb2tlbiEgSXQgbWlzc2VzDQo+
PiAgICB3cml0ZXMgKCopDQo+PiBJbmNyZW1lbnRhbCBiYWNrdXANCj4+ICAgIGl0IHdpbGwgYmUg
aW5jb25zaXN0ZW50DQo+Pg0KPj4gTmV3IGxvZ2ljDQo+PiA9PT09PT09PT0NCj4+DQo+PiBSZW9w
ZW4gcncgLT4gcm86DQo+Pg0KPj4gU3RvcmUgYml0bWFwcyBhbmQgZG9uJ3QgcmVtb3ZlIHRoZW0g
ZnJvbSBSQU0sIG9ubHkgbWFyayB0aGVtIHJlYWRvbmx5DQo+PiAodGhlIGxhdHRlciBpcyBhbHJl
YWR5IGRvbmUsIGJ1dCBkaWRuJ3Qgd29yayBwcm9wZXJseSBiZWNhdXNlIG9mDQo+PiByZW1vdmlu
ZyBpbiBzdG9yaW5nIGZ1bmN0aW9uKQ0KPj4NCj4+IFJlb3BlbiB0byBydyAoZG9uJ3QgZmlsdGVy
IGNhc2Ugd2l0aCByZW9wZW4gcncgLT4gcncsIGl0IGlzIHN1cHBvcnRlZA0KPj4gbm93IGluIHFj
b3cyX3Jlb3Blbl9iaXRtYXBzX3J3KQ0KPj4NCj4+IExvYWQgYml0bWFwIGxpc3QNCj4+DQo+PiBD
YXJlZnVsbHkgY29uc2lkZXIgYWxsIHBvc3NpYmxlIGNvbWJpbmF0aW9ucyBvZiBiaXRtYXBzIGlu
IFJBTSBhbmQgaW4NCj4+IHRoZSBpbWFnZSwgdHJ5IHRvIGZpeCBjb3JydXB0aW9ucywgcHJpbnQg
Y29ycmVzcG9uZGluZyBlcnJvciBtZXNzYWdlcy4NCj4+DQo+PiBBbHNvLCBjYWxsIHFjb3cyX3Jl
b3Blbl9iaXRtYXBzX3J3IGFmdGVyIHRoZSB3aG9sZSByZW9wZW4gcXVldWUNCj4+IGNvbW1pdGVk
LCBhcyBvdGhlcndpc2Ugd2UgY2FuJ3Qgd3JpdGUgdG8gdGhlIHFjb3cyIGZpbGUgY2hpbGQgb24g
cmVvcGVuDQo+PiBybyAtPiBydy4NCj4+DQo+PiBBbHNvLCBhZGQgY29ycmVzcG9uZGluZyB0ZXN0
LWNhc2VzIHRvIDI1NS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3Yt
T2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgYmxvY2sv
cWNvdzIuaCAgICAgICAgICAgICAgfCAgIDUgKy0NCj4+ICAgaW5jbHVkZS9ibG9jay9ibG9ja19p
bnQuaCAgfCAgIDIgKy0NCj4+ICAgYmxvY2suYyAgICAgICAgICAgICAgICAgICAgfCAgMjkgKyst
LS0tDQo+PiAgIGJsb2NrL3Fjb3cyLWJpdG1hcC5jICAgICAgIHwgMTk3ICsrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4+ICAgYmxvY2svcWNvdzIuYyAgICAgICAgICAgICAg
fCAgIDIgKy0NCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI1NSAgICAgfCAgIDIgKw0KPj4gICB0
ZXN0cy9xZW11LWlvdGVzdHMvMjU1Lm91dCB8ICAzNSArKysrKysrDQo+PiAgIDcgZmlsZXMgY2hh
bmdlZCwgMTkzIGluc2VydGlvbnMoKyksIDc5IGRlbGV0aW9ucygtKQ0KPiANCj4gWy4uLl0NCj4g
DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzItYml0bWFwLmMgYi9ibG9jay9xY293Mi1iaXRt
YXAuYw0KPj4gaW5kZXggMmI4NGJmYTAwNy4uNGU1NjVkYjExZiAxMDA2NDQNCj4+IC0tLSBhL2Js
b2NrL3Fjb3cyLWJpdG1hcC5jDQo+PiArKysgYi9ibG9jay9xY293Mi1iaXRtYXAuYw0KPiANCj4g
Wy4uLl0NCj4gDQo+PiBAQCAtMTEwMyw3NiArMTExMCwxNTAgQEAgUWNvdzJCaXRtYXBJbmZvTGlz
dCAqcWNvdzJfZ2V0X2JpdG1hcF9pbmZvX2xpc3QoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+PiAg
ICAgICByZXR1cm4gbGlzdDsNCj4+ICAgfQ0KPj4gICANCj4+IC1pbnQgcWNvdzJfcmVvcGVuX2Jp
dG1hcHNfcndfaGludChCbG9ja0RyaXZlclN0YXRlICpicywgYm9vbCAqaGVhZGVyX3VwZGF0ZWQs
DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4g
Ky8qDQo+PiArICogcWNvdzJfcmVvcGVuX2JpdG1hcHNfcncNCj4+ICsgKg0KPj4gKyAqIFRoZSBm
dW5jdGlvbiBpcyBjYWxsZWQgaW4gYmRydl9yZW9wZW5fbXVsdGlwbGUgYWZ0ZXIgYWxsIGNhbGxz
IHRvDQo+PiArICogYmRydl9yZW9wZW5fY29tbWl0LCB3aGVuIGZpbmFsIGJzIGlzIHdyaXRhYmxl
LiBJdCBpcyBkb25lIHNvLCBhcyB3ZSBuZWVkDQo+PiArICogd3JpdGUgYWNjZXNzIHRvIGNoaWxk
IGJzLCBhbmQgd2l0aCBjdXJyZW50IHJlb3BlbmluZyBhcmNoaXRlY3R1cmUsIHdoZW4NCj4+ICsg
KiByZW9wZW4gcm8gLT4gcncgaXQgaXMgcG9zc2libGUgb25seSBhZnRlciBhbGwgcmVvcGVuIGNv
bW1pdHMuDQo+PiArICoNCj4+ICsgKiBTbywgd2UgY2FuJ3QgZmFpbCBoZXJlLg0KPiANCj4gV2h5
PyAgQmVjYXVzZSB0aGUgY3VycmVudCBkZXNpZ24gZm9yYmlkcyBpdD8NCj4gDQo+IFRoZW4gdGhl
IGN1cnJlbnQgZGVzaWduIHNlZW1zIGZsYXdlZCB0byBtZS4NCj4gDQo+IFtDQy1pbmcgQmVydG9d
DQo+IA0KPiBXaXRob3V0IGhhdmluZyBsb29rZWQgdG9vIGNsb3NlIGludG8gdGhpcywgaXQgc2Vl
bXMgZnJvbSB5b3VyIGNvbW1pdA0KPiBtZXNzYWdlIHRoYXQgaXQgaXMgcG9zc2libGUgdG8gcnVu
IGludG8gdW5yZWNvdmVyYWJsZSBmYXRhbCBlcnJvcnMgaGVyZS4NCj4gICBXZSBjYW5ub3QganVz
dCBpZ25vcmUgdGhhdCBvbiB0aGUgYmFzaXMgdGhhdCB0aGUgY3VycmVudCBkZXNpZ24gY2Fubm90
DQo+IGRlYWwgd2l0aCB0aGF0Lg0KPiANCj4gSXQganVzdCBhcHBlYXJzIHdyb25nIHRvIG1lIHRv
IHVwZGF0ZSBhbnkgZmxhZ3MgaW4gdGhlIGltYWdlIGluIHRoZQ0KPiAuY29tbWl0KCkgcGFydCBv
ZiBhIHRyYW5zYWN0aW9uLiAgV2Ugc2hvdWxkIHRyeSB0byBkbyBzbyBpbiAucHJlcGFyZSgpLg0K
PiAgIElmIGl0IHdvcmtzLCBncmVhdCwgd2XigJlyZSBzZXQgZm9yIC5jb21taXQoKS4gIElmIGl0
IGRvZXNu4oCZdCwgd2VscCwgdGltZQ0KPiBmb3IgLmFib3J0KCkgYW5kIHByZXRlbmQgdGhlIGlt
YWdlIGlzIHN0aWxsIHJlYWQtb25seSAoZXZlbiB0aG91Z2ggaXQNCj4ga2luZCBvZiBtYXkgYmUg
aGFsZi1wcmVwYXJlZCBmb3Igd3JpdGluZykuDQo+IA0KPiBJZiB3ZSBmYWlsIHRvIHNldCBJTl9V
U0UgaW4gLmNvbW1pdCgpLCB0aGF04oCZcyBhIGZhdGFsIGVycm9yIGluIG15IG9waW5pb24uDQo+
IA0KPiBBZnRlciBzb21lIGNoYXR0aW5nIHdpdGggSm9obiwgSeKAmXZlIGNvbWUgdG8gdGhlIGZv
bGxvd2luZyBiZWxpZWY6DQo+IA0KPiBXaGVuIHN3aXRjaGluZyBhIG5vZGUgZnJvbSBSTyB0byBS
L1csIGl0IG11c3QgYmUgYWJsZSB0byB3cml0ZSB0byBpdHMNCj4gY2hpbGRyZW4gaW4gLnByZXBh
cmUoKSAtLSBwcmVjaXNlbHkgYmVjYXVzZSBwZXJmb3JtaW5nIHRoaXMgc3dpdGNoIG1heQ0KPiBu
ZWVkIHNvbWUgbWV0YWRhdGEgY2hhbmdlLiAgSWYgd2UgY2Fubm90IGRvIHRoaXMgY2hhbmdlLCB0
aGVuIHdlIGNhbm5vdA0KPiBzd2l0Y2ggdGhlIG5vZGUgdG8gUi9XLiAgU28gaXTigJlzIGNsZWFy
IHRvIG1lIHRoYXQgdGhpcyBuZWVkcyB0byBiZSBkb25lDQo+IGluIC5wcmVwYXJlKCkuDQo+IA0K
PiBTbyBJIHRoaW5rIGEgbm9kZeKAmXMgY2hpbGRyZW4gbXVzdCBiZSBSL1cgYmVmb3JlIHdlIGNh
biAucHJlcGFyZSgpIHRoZQ0KPiBub2RlLiAgVGhhdCBtZWFucyB3ZSBuZWVkIHRvIC5jb21taXQo
KSB0aGVtLiAgVGhhdCBtZWFucyB3ZSBjYW5ub3QgaGF2ZQ0KPiBhIHNpbmdsZSB0cmFuc2FjdGlv
biB0aGF0IHN3aXRjaGVzIGEgd2hvbGUgdHJlZSB0byBiZSBSL1csIGJ1dCBpdCBtdXN0DQo+IGNv
bnNpc3Qgb2Ygb25lIHRyYW5zYWN0aW9uIHBlciBsZXZlbC4NCj4gDQo+IElmIHNvbWV0aGluZyBm
YWlscywgd2UgbmVlZCB0byByb2xsIGJhY2sgYWxsIHRoZSBwcmV2aW91cyBsYXllcnMuICBXZWxs
LA0KPiBpdCBkZXBlbmRzLg0KPiANCj4gSWYgd2Ugc3dpdGNoIHRvIFIvVyAoYW5kIHNvbWV0aGlu
ZyBmYWlscyksIHRoZW4gd2UgbmVlZCB0byB0cnkgdG8gcmV2ZXJ0DQo+IHRoZSBjaGlsZHJlbiB3
ZSBoYXZlIGFscmVhZHkgbWFkZSBSL1cgdG8gYmUgUk8uICBJZiB0aGF0IGRvZXNu4oCZdCB3b3Jr
LA0KPiB3ZWxwLCB0b28gYmFkLCBidXQgbm90IGZhdGFsLg0KDQpBbmQsIHRoYW4sIHdoeSBub3Qg
ZG8gZnVsbCByZW9wZW4gcncgaW4gLnByZXBhcmUsIGFuZCBqdXN0IG9yZ2FuaXplDQpyZWN1cnNp
b24gc28gdGhhdCBjaGlsZHJlbiByZW9wZW5lZCBydyBiZWZvcmUgcGFyZW50PyBUaGFuIHdlIGFn
YWluIGhhdmUNCm9uZSB0cmFuc2FjdGlvbiBmb3IgdGhlIHRyZWUsIGJ1dCBhYm9ydCBtYXkgZmFp
bCB0byByb2xsYmFjayBpdCBpbiB3b3JzdCBjYXNlLg0KQnV0IHdlIGNhbnQgYXZvaWQgaXQgYW55
d2F5LCB3aXRoIG9uZSB0cmFuc2FjdGlvbiBvciB3aXRoIHRyYW5zYWN0aW9ucyBwZXIgbGV2ZWwu
Lg0KDQpTbywganVzdCBtb3ZlIGFsbCBjb2RlIGZyb20gLmNvbW1pdCB0byAucHJlcGFyZSBmb3Ig
cmVvcGVuLXJ3IGFuZCB0cnkgdG8gcm9sbC1iYWNrDQppdCBpbiAuYWJvcnQ/DQoNCk9yIGRvIHlv
dSBoYXZlIGFuIGlkZWEgZm9yIGEgcGF0Y2g/DQoNCj4gDQo+IFN3aXRjaGluZyB0byBSTyBnb2Vz
IHRoZSBvdGhlciB3YXkgYXJvdW5kIChwYXJlbnRzIHRvIGNoaWxkcmVuKSwgc28gaWYNCj4gd2Ug
ZW5jb3VudGVyIGFuIGVycm9yIHRoZXJlLCB3ZSBjYW5ub3QgbWFrZSB0aGF0IG5vZGXigJlzIGNo
aWxkcmVuIFJPLA0KPiB0b28uICBXZSBjb3VsZCB0cnkgdG8gcmV2ZXJ0IHRoZSB3aG9sZSBjaGFu
Z2UgYW5kIG1ha2UgdGhlIHdob2xlIHRyZWUNCj4gUi9XIGFnYWluLCBvciB3ZSBqdXN0IGRvbuKA
mXQuICBJIHRoaW5rIOKAnGp1c3QgZG9u4oCZdOKAnSBpcyByZWFzb25hYmxlLg0KPiANCj4gTWF4
DQo+IA0KPj4gICAgICBPbiB0aGUgb3RoZXIgaGFuZCwgd2UgbWF5IGZhY2UgZGlmZmVyZW50IGtp
bmRzIG9mDQo+PiArICogY29ycnVwdGlvbnMgYW5kL29yIGp1c3QgY2FuJ3Qgd3JpdGUgSU5fVVNF
IGZsYWdzIHRvIHRoZSBpbWFnZSBkdWUgdG8gRUlPLg0KPj4gKyAqDQo+PiArICogVHJ5IHRvIGhh
bmRsZSBhcyBtYW55IGNhc2VzIGFzIHdlIGNhbi4NCj4+ICsgKi8NCj4+ICt2b2lkIHFjb3cyX3Jl
b3Blbl9iaXRtYXBzX3J3KEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0KPiANCg0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=

