Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8588C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F94020684
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aYF3HqVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F94020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47654 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFyYR-0007c3-MA
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 06:09:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hFyXa-0007KK-2r
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hFyXZ-0004H9-3D
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:08:42 -0400
Received: from mail-eopbgr60116.outbound.protection.outlook.com
	([40.107.6.116]:57653
	helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hFyXY-0004Ff-Fr
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=R10x/xmowOOqWoxmdvbg0SNoR8AGBQxR7F7pDblPA/g=;
	b=aYF3HqVzLv4pToPSn5JpzhkpqPzFSim3KGL9EC7A64M/ojzvxJNIYEWcczh0OzLs3FmmNVXBYV4//BRzR99zrwv/L9r1/yQ74zmux4oTYZGCRNP59Sff1LeArqA6QUiha6sHbgY/ZggRfuugESmk/9ou5kFaONCm7RqDzuzkxiM=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3228.eurprd08.prod.outlook.com (52.134.111.14) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.19; Mon, 15 Apr 2019 10:08:37 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1792.018;
	Mon, 15 Apr 2019 10:08:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH] util/error: do not free error on error_abort
Thread-Index: AQHU8hMKJR89uvD2b0yiP5/R2LIrXaY8unlEgABHvwA=
Date: Mon, 15 Apr 2019 10:08:37 +0000
Message-ID: <3381f703-4fc1-ac3c-658c-f7399403acf9@virtuozzo.com>
References: <20190413160732.55505-1-vsementsov@virtuozzo.com>
	<87zhorbytu.fsf@dusky.pond.sub.org>
In-Reply-To: <87zhorbytu.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::14)
	To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190415130834670
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce4ed48f-8fa9-4b67-4969-08d6c18a535b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:DB7PR08MB3228; 
x-ms-traffictypediagnostic: DB7PR08MB3228:
x-microsoft-antispam-prvs: <DB7PR08MB32286B72F417EF13E5B3C150C12B0@DB7PR08MB3228.eurprd08.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(136003)(39850400004)(396003)(376002)(199004)(189003)(6246003)(76176011)(86362001)(52116002)(386003)(102836004)(6506007)(26005)(4326008)(31686004)(5660300002)(99286004)(36756003)(478600001)(71200400001)(486006)(476003)(186003)(229853002)(71190400001)(6486002)(53936002)(2616005)(6916009)(316002)(446003)(11346002)(25786009)(6436002)(256004)(14444005)(8676002)(31696002)(14454004)(305945005)(7736002)(66066001)(68736007)(106356001)(105586002)(6116002)(8936002)(97736004)(81166006)(81156014)(3846002)(6512007)(2906002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3228;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ne7RLsouY/jBWRegVXflyciuqqnwUbrl3Whm/q6NMis8CCSA9gpuUPKXMH39Pqz8Qd/LkySfXTFVFMBFxy6PF2uvjPB2miuLxtClgK2FsyO0O3aRkqCgGUNUBPO+S21CmqGtRf+Xn+D8LFKVV+DSkpkok01bv0QZ1tbrU+DyRaC0fh3vzz1q9ZIiwkg5RAiAV4XEossZIp1B+3IRRc9Yg+SZ6tyPxxaTrHHiGJ0HBJ3k8wllgWCEAHQhoTeZS63qQgrZbMWFz9tjIOcihXfxgp6Mg4RM5DGul2wBeko8qLfosNv1b5vILiy8LTXnMBnmdfKTUHxv2WhUO3Pk6e/c+SeJKvteMtLwdGT8057UIghNuc7l4BgNkxOF4thvBalOKgwUpKYjjoB6JHPJfMMIaS851eUOjlOGXZQVpR41h0A=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <7774EB8D66BDF24F991100838D37B379@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4ed48f-8fa9-4b67-4969-08d6c18a535b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 10:08:37.0765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3228
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.116
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
Message-ID: <20190415100837.5X-Dv76BIKmcU66tUTUqulaWzF2U9JrWMoo_kX2Qmho@z>

MTUuMDQuMjAxOSA4OjUxLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4gVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPiB3cml0ZXM6DQo+IA0K
Pj4gSXQgd291bGQgYmUgbmljZSB0byBoYXZlIEVycm9yIG9iamVjdCBub3QgZnJlZWQgYXdheSB3
aGVuIGRlYnVnZ2luZyBhDQo+PiBjb3JlZHVtcC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFk
aW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAt
LS0NCj4+ICAgdXRpbC9lcnJvci5jIHwgOCArKysrKy0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS91dGls
L2Vycm9yLmMgYi91dGlsL2Vycm9yLmMNCj4+IGluZGV4IDkzNGE3OGUxYjEuLmY5MTgwYzBmMzAg
MTAwNjQ0DQo+PiAtLS0gYS91dGlsL2Vycm9yLmMNCj4+ICsrKyBiL3V0aWwvZXJyb3IuYw0KPj4g
QEAgLTMyLDkgKzMyLDExIEBAIEVycm9yICplcnJvcl9mYXRhbDsNCj4+ICAgc3RhdGljIHZvaWQg
ZXJyb3JfaGFuZGxlX2ZhdGFsKEVycm9yICoqZXJycCwgRXJyb3IgKmVycikNCj4+ICAgew0KPj4g
ICAgICAgaWYgKGVycnAgPT0gJmVycm9yX2Fib3J0KSB7DQo+PiAtICAgICAgICBmcHJpbnRmKHN0
ZGVyciwgIlVuZXhwZWN0ZWQgZXJyb3IgaW4gJXMoKSBhdCAlczolZDpcbiIsDQo+PiAtICAgICAg
ICAgICAgICAgIGVyci0+ZnVuYywgZXJyLT5zcmMsIGVyci0+bGluZSk7DQo+PiAtICAgICAgICBl
cnJvcl9yZXBvcnRfZXJyKGVycik7DQo+PiArICAgICAgICBlcnJvcl9yZXBvcnQoIlVuZXhwZWN0
ZWQgZXJyb3IgaW4gJXMoKSBhdCAlczolZDogJXMiLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
IGVyci0+ZnVuYywgZXJyLT5zcmMsIGVyci0+bGluZSwgZXJyb3JfZ2V0X3ByZXR0eShlcnIpKTsN
Cj4+ICsgICAgICAgIGlmIChlcnItPmhpbnQpIHsNCj4+ICsgICAgICAgICAgICBlcnJvcl9wcmlu
dGZfdW5sZXNzX3FtcCgiJXMiLCBlcnItPmhpbnQtPnN0cik7DQo+PiArICAgICAgICB9DQo+PiAg
ICAgICAgICAgYWJvcnQoKTsNCj4+ICAgICAgIH0NCj4+ICAgICAgIGlmIChlcnJwID09ICZlcnJv
cl9mYXRhbCkgew0KPiANCj4gTm8gb2JqZWN0aW9ucyB0byBub3QgZnJlZWluZyB0aGUgZXJyb3Ig
b2JqZWN0IG9uIHRoZSBwYXRoIHRvIGFib3J0KCkuDQo+IA0KPiBZb3UgYWxzbyBmb3JtYXQgdGhl
IGVycm9yIG1lc3NhZ2UgZGlmZmVyZW50bHkuICBDb21taXQgMWU5YjY1YmIxYmEncw0KPiBleGFt
cGxlDQo+IA0KPiAgICAgICAgICBVbmV4cGVjdGVkIGVycm9yIGluIHBhcnNlX2Jsb2NrX2Vycm9y
X2FjdGlvbigpIGF0IC4uLi9xZW11L2Jsb2NrZGV2LmM6MzIyOg0KPiAgICAgICAgICBxZW11LXN5
c3RlbS14ODZfNjQ6IC1kcml2ZSBpZj1ub25lLHdlcnJvcj1mb286ICdmb28nIGludmFsaWQgd3Jp
dGUgZXJyb3IgYWN0aW9uDQo+ICAgICAgICAgIEFib3J0ZWQgKGNvcmUgZHVtcGVkKQ0KPiANCj4g
Y2hhbmdlcyB0byAoZ3Vlc3N3b3JrLCBub3QgdGVzdGVkKToNCj4gDQo+ICAgICAgICAgIHFlbXUt
c3lzdGVtLXg4Nl82NDogLWRyaXZlIGlmPW5vbmUsd2Vycm9yPWZvbzogVW5leHBlY3RlZCBlcnJv
ciBpbiBwYXJzZV9ibG9ja19lcnJvcl9hY3Rpb24oKSBhdCAuLi4vcWVtdS9ibG9ja2Rldi5jOjMy
MjogJ2ZvbycgaW52YWxpZCB3cml0ZSBlcnJvciBhY3Rpb24NCj4gICAgICAgICAgQWJvcnRlZCAo
Y29yZSBkdW1wZWQpDQoNCmhtLiBjaGVja3BhdGNoIGRvbid0IGFsbG93IHRvIHB1dCBcbiBpbnRv
IGVycm9yX3JlcG9ydC4gU28sIHNob3VsZCBJIGNhbGwgZXJyb3JfcmVwb3J0IHR3aWNlPw0KDQpU
cmFuc2l0aW9uIGZyb20gZnByaW50ZiB0byBlcnJvcl9yZXBvcnQgaXMgT0sgZm9yIHlvdT8NCg0K
PiANCj4gSW50ZW50aW9uYWw/ICBJdCBtYWtlcyBzZW5zZSBhcyBhbiBlcnJvciBtZXNzYWdlLCBi
dXQgcmVhZGFiaWxpdHkNCj4gc3VmZmVycyBkdWUgdG8gdGhlIGxvbmcgbGluZS4gIElmIHdlIGRl
Y2lkZSB3ZSB3YW50IHRoaXMgY2hhbmdlLCBpdA0KPiBuZWVkcyB0byBiZSBtZW50aW9uZWQgaW4g
dGhlIGNvbW1pdCBtZXNzYWdlLg0KPiANCj4gT3Blbi1jb2RpbmcgZXJyb3JfcmVwb3J0X2Vycigp
IGhlcmUgc28geW91IGNhbiBkZWxldGUgdGhlIGVycm9yX2ZyZWUoKQ0KPiBhbmQgYSBuZXdsaW5l
IGlzIGEgYml0IHVnbHksIGJ1dCBmYWN0b3Jpbmcgb3V0IHRoZSBjb21tb24gcGFydCBkb2Vzbid0
DQo+IHNlZW0gd29ydGh3aGlsZS4NCj4gDQo+IEhtbSwgcGVyaGFwcyBmYWN0b3Jpbmcgb3V0DQo+
IA0KPiAgICAgICAgICBpZiAoZXJyLT5oaW50KSB7DQo+ICAgICAgICAgICAgICBlcnJvcl9wcmlu
dGZfdW5sZXNzX3FtcCgiJXMiLCBlcnItPmhpbnQtPnN0cik7DQo+ICAgICAgICAgIH0NCj4gDQo+
IGludG8gYSBzdGF0aWMgaGVscGVyIHdvdWxkIGJlIHdvcnRod2hpbGUuICBXZSBhbHJlYWR5IGhh
dmUgdHdvIGNvcGllcy4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

