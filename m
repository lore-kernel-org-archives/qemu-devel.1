Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BA5C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CCC20833
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LW8GB5XM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CCC20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50408 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG1nE-0001xE-2J
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 09:37:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hG1mH-0001Zy-Eg
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hG1mG-0002B0-9o
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:36:05 -0400
Received: from mail-eopbgr80114.outbound.protection.outlook.com
	([40.107.8.114]:64671
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hG1mF-00029Q-8E
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=fnkx2BveFN58oPr7+dZ53zu2OUHqDlaZ7++fUq0aS4A=;
	b=LW8GB5XMPo1knh+QJHuBbj3Xpws+wfhdSCDRZ2r8s+cfbSZ1Bzl2Rnd+HBRUVjtVHIEjEM/L5OW4EcMJ5yA6Z4fdY/i8R4csgHXFOqvz4hG7vICQQL8w5nRlgGnZTLv5GlIQcjb/KrGvFVjwo5kLP3kNGY5BKV5z5wHjDnyTiOU=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3226.eurprd08.prod.outlook.com (52.134.111.12) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.19; Mon, 15 Apr 2019 13:36:00 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1792.018;
	Mon, 15 Apr 2019 13:36:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH] util/error: do not free error on error_abort
Thread-Index: AQHU8hMKJR89uvD2b0yiP5/R2LIrXaY8unlEgAB6CgCAAAATB4AAB5OA
Date: Mon, 15 Apr 2019 13:35:59 +0000
Message-ID: <e432f8cf-4014-8175-4a56-167a14534528@virtuozzo.com>
References: <20190413160732.55505-1-vsementsov@virtuozzo.com>
	<87zhorbytu.fsf@dusky.pond.sub.org>
	<3381f703-4fc1-ac3c-658c-f7399403acf9@virtuozzo.com>
	<874l6za00z.fsf@dusky.pond.sub.org>
In-Reply-To: <874l6za00z.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::11)
	To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190415163557365
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e10a6b9c-3e16-4aae-b85a-08d6c1a74bd1
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:DB7PR08MB3226; 
x-ms-traffictypediagnostic: DB7PR08MB3226:
x-microsoft-antispam-prvs: <DB7PR08MB3226C9F74CA540EC59214488C12B0@DB7PR08MB3226.eurprd08.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(39850400004)(376002)(396003)(136003)(189003)(199004)(25786009)(106356001)(105586002)(446003)(11346002)(6486002)(14454004)(5660300002)(486006)(229853002)(93886005)(6436002)(36756003)(14444005)(71200400001)(71190400001)(476003)(2616005)(478600001)(256004)(6512007)(6916009)(86362001)(76176011)(305945005)(102836004)(6246003)(68736007)(81156014)(316002)(7736002)(52116002)(81166006)(8936002)(31696002)(99286004)(6116002)(3846002)(8676002)(4326008)(97736004)(66066001)(2906002)(386003)(6506007)(186003)(26005)(31686004)(53936002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3226;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FB75fmBuxERg5z8IV0FfwGOb7UcXzbQg0Tb+mHdG51EfNKrVzh4cHBJ7qBxlZntBYQZknKKh7CgcpP9PnAYlQWzX4q+eKWmt/WNIeyoBwInznQL5B9A9e3rRT8265E9siV6KTnQ0ypMGvF0PlttmJrepp7E7by1LQYHV4OtQCANIXdqzYeYv08lqMO+Zjivt50AYp5PpH95DYzsriiOz2iVnbKMrCZsui/zq8RtccA9m92rMgCIkbLqu1/NrVwx50ZlTXB2OVN1S2FSMGoiMgeK3EaG3/MgqmD+6jIq7S1W8UlSA6GB49AATVpli8DvaEIdYyxH430zQ9Y4OqvKmvnLC23WjC7wUc+Wu3Slfl0l5hKMqMF9yMitC3LEIqAb7dTHhJkow/M/z8fI0VOztPpfBOpGe6S+c5WXgZSYJ1fw=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <FC52E9E32B794E4CB5993DB6F0EE896A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10a6b9c-3e16-4aae-b85a-08d6c1a74bd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 13:35:59.9541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3226
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.114
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
Message-ID: <20190415133559.SL9KUeUzCjQTqLjLP4o0cNp8XRFgZduDp06pPGlH6oM@z>

MTUuMDQuMjAxOSAxNjowOCwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPiAN
Cj4+IDE1LjA0LjIwMTkgODo1MSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+Pj4gVmxhZGlt
aXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPiB3cml0ZXM6
DQo+Pj4NCj4+Pj4gSXQgd291bGQgYmUgbmljZSB0byBoYXZlIEVycm9yIG9iamVjdCBub3QgZnJl
ZWQgYXdheSB3aGVuIGRlYnVnZ2luZyBhDQo+Pj4+IGNvcmVkdW1wLg0KPj4+Pg0KPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICB1dGlsL2Vycm9yLmMgfCA4ICsrKysrLS0tDQo+
Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+
Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS91dGlsL2Vycm9yLmMgYi91dGlsL2Vycm9yLmMNCj4+Pj4g
aW5kZXggOTM0YTc4ZTFiMS4uZjkxODBjMGYzMCAxMDA2NDQNCj4+Pj4gLS0tIGEvdXRpbC9lcnJv
ci5jDQo+Pj4+ICsrKyBiL3V0aWwvZXJyb3IuYw0KPj4+PiBAQCAtMzIsOSArMzIsMTEgQEAgRXJy
b3IgKmVycm9yX2ZhdGFsOw0KPj4+PiAgICBzdGF0aWMgdm9pZCBlcnJvcl9oYW5kbGVfZmF0YWwo
RXJyb3IgKiplcnJwLCBFcnJvciAqZXJyKQ0KPj4+PiAgICB7DQo+Pj4+ICAgICAgICBpZiAoZXJy
cCA9PSAmZXJyb3JfYWJvcnQpIHsNCj4+Pj4gLSAgICAgICAgZnByaW50ZihzdGRlcnIsICJVbmV4
cGVjdGVkIGVycm9yIGluICVzKCkgYXQgJXM6JWQ6XG4iLA0KPj4+PiAtICAgICAgICAgICAgICAg
IGVyci0+ZnVuYywgZXJyLT5zcmMsIGVyci0+bGluZSk7DQo+Pj4+IC0gICAgICAgIGVycm9yX3Jl
cG9ydF9lcnIoZXJyKTsNCj4+Pj4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJVbmV4cGVjdGVkIGVy
cm9yIGluICVzKCkgYXQgJXM6JWQ6ICVzIiwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGVy
ci0+ZnVuYywgZXJyLT5zcmMsIGVyci0+bGluZSwgZXJyb3JfZ2V0X3ByZXR0eShlcnIpKTsNCj4+
Pj4gKyAgICAgICAgaWYgKGVyci0+aGludCkgew0KPj4+PiArICAgICAgICAgICAgZXJyb3JfcHJp
bnRmX3VubGVzc19xbXAoIiVzIiwgZXJyLT5oaW50LT5zdHIpOw0KPj4+PiArICAgICAgICB9DQo+
Pj4+ICAgICAgICAgICAgYWJvcnQoKTsNCj4+Pj4gICAgICAgIH0NCj4+Pj4gICAgICAgIGlmIChl
cnJwID09ICZlcnJvcl9mYXRhbCkgew0KPj4+DQo+Pj4gTm8gb2JqZWN0aW9ucyB0byBub3QgZnJl
ZWluZyB0aGUgZXJyb3Igb2JqZWN0IG9uIHRoZSBwYXRoIHRvIGFib3J0KCkuDQo+Pj4NCj4+PiBZ
b3UgYWxzbyBmb3JtYXQgdGhlIGVycm9yIG1lc3NhZ2UgZGlmZmVyZW50bHkuICBDb21taXQgMWU5
YjY1YmIxYmEncw0KPj4+IGV4YW1wbGUNCj4+Pg0KPj4+ICAgICAgICAgICBVbmV4cGVjdGVkIGVy
cm9yIGluIHBhcnNlX2Jsb2NrX2Vycm9yX2FjdGlvbigpIGF0IC4uLi9xZW11L2Jsb2NrZGV2LmM6
MzIyOg0KPj4+ICAgICAgICAgICBxZW11LXN5c3RlbS14ODZfNjQ6IC1kcml2ZSBpZj1ub25lLHdl
cnJvcj1mb286ICdmb28nIGludmFsaWQgd3JpdGUgZXJyb3IgYWN0aW9uDQo+Pj4gICAgICAgICAg
IEFib3J0ZWQgKGNvcmUgZHVtcGVkKQ0KPj4+DQo+Pj4gY2hhbmdlcyB0byAoZ3Vlc3N3b3JrLCBu
b3QgdGVzdGVkKToNCj4+Pg0KPj4+ICAgICAgICAgICBxZW11LXN5c3RlbS14ODZfNjQ6IC1kcml2
ZSBpZj1ub25lLHdlcnJvcj1mb286IFVuZXhwZWN0ZWQgZXJyb3IgaW4gcGFyc2VfYmxvY2tfZXJy
b3JfYWN0aW9uKCkgYXQgLi4uL3FlbXUvYmxvY2tkZXYuYzozMjI6ICdmb28nIGludmFsaWQgd3Jp
dGUgZXJyb3IgYWN0aW9uDQo+Pj4gICAgICAgICAgIEFib3J0ZWQgKGNvcmUgZHVtcGVkKQ0KPj4N
Cj4+IGhtLiBjaGVja3BhdGNoIGRvbid0IGFsbG93IHRvIHB1dCBcbiBpbnRvIGVycm9yX3JlcG9y
dC4gU28sIHNob3VsZCBJIGNhbGwgZXJyb3JfcmVwb3J0IHR3aWNlPw0KPj4NCj4+IFRyYW5zaXRp
b24gZnJvbSBmcHJpbnRmIHRvIGVycm9yX3JlcG9ydCBpcyBPSyBmb3IgeW91Pw0KPiANCj4gTGV0
J3Mgc2ltcGx5IG5vdCBtZXNzIHdpdGggdGhlIGZvcm1hdHRpbmcgYXQgYWxsLiAgU29tZXRoaW5n
IGxpa2U6DQo+IA0KPiAoMSkgSW5saW5lIGVycm9yX3JlcG9ydF9lcnIoKSwgZGVsZXRlIHRoZSBl
cnJvcl9mcmVlKCkNCj4gDQo+ICgyKSBPcHRpb25hbDogcmVwbGFjZSBmcHJpbnRmKCkgYnkgZXJy
b3JfcHJpbnRmKCkNCj4gDQo+ICgzKSBPcHRpb25hbDogY2xlYW4gdXAgdGhlIGFkZGl0aW9uYWwg
Y29weSBvZg0KPiANCj4gICAgICAgICAgaWYgKGVyci0+aGludCkgew0KPiAgICAgICAgICAgICAg
ZXJyb3JfcHJpbnRmX3VubGVzc19xbXAoIiVzIiwgZXJyLT5oaW50LT5zdHIpOw0KPiAgICAgICAg
ICB9DQo+IA0KPiAoM2EpIEVpdGhlciBjcmVhdGUgYSBoZWxwZXIgZnVuY3Rpb24sIHJlcGxhY2lu
ZyBhbGwgdGhyZWUgY29waWVzLA0KPiANCj4gKDNiKSBPciBzaW1wbHkgZGVsZXRlIHRoZSBuZXcg
Y29weSBmcm9tIHRoZSBwYXRoIGxlYWRpbmcgdG8gYWJvcnQoKSwNCj4gICAgICAgc2luY2UgdGhl
IGhpbnQgaXMgdW5saWtlbHkgdG8gYmUgdXNlZnVsIHRoZXJlLg0KPiANCg0KV2h5IHdlIHByaW50
IGVycm9yIGFsd2F5cyBidXQgaGludCBvbmx5ICJ1bmxlc3NfcW1wIj8NCg0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=

