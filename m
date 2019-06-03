Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF70C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 10:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CB928071
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 10:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NvyLa8u2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CB928071
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60816 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXjrV-0003Nw-2N
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 06:06:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXjqh-0002zi-6M
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 06:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXjqf-00062T-Vj
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 06:05:51 -0400
Received: from mail-db5eur01on0716.outbound.protection.outlook.com
	([2a01:111:f400:fe02::716]:53352
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hXjqd-0005un-7o; Mon, 03 Jun 2019 06:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=RBBjeh7bxWuuEPiu0ojQ4cJAvpZhcD2ToIuajeGE/5o=;
	b=NvyLa8u2n4tYLUx7FRgeWpCvwvcVJ1vT4tFx2u0StbZDcL5PuZNLvrt7KG1Jxt1cSW5yX5QQZtEmVX3YqNvw1+yJPbcT9BkFXVClqm7U8Wqq1AOJAn5hMGo1sGkce7mOrbrcx5JWCBTryjdkKHxzh4/mwhFBmxHUY4D/FZZvIS0=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB4561.eurprd08.prod.outlook.com (20.178.119.157) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.18; Mon, 3 Jun 2019 10:05:43 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1943.018;
	Mon, 3 Jun 2019 10:05:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 2/9] python/qemu: improve event_wait
	method of vm
Thread-Index: AQHVF85q+3dW9LtTsEuJHgYinVs7IKaF4vKAgAPVPYA=
Date: Mon, 3 Jun 2019 10:05:43 +0000
Message-ID: <aa893018-31af-552a-5c61-a180947b7bde@virtuozzo.com>
References: <20190531163202.162543-1-vsementsov@virtuozzo.com>
	<20190531163202.162543-3-vsementsov@virtuozzo.com>
	<7d905bca-84d4-de2b-f23f-91c02e97cee3@redhat.com>
In-Reply-To: <7d905bca-84d4-de2b-f23f-91c02e97cee3@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0026.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::15)
	To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190603130541387
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97c0dac9-6d83-4567-ab56-08d6e80b0a25
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:AM0PR08MB4561; 
x-ms-traffictypediagnostic: AM0PR08MB4561:
x-microsoft-antispam-prvs: <AM0PR08MB4561BF7BE673DA789BFE4A86C1140@AM0PR08MB4561.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(346002)(366004)(376002)(39850400004)(396003)(199004)(189003)(25786009)(7736002)(5660300002)(2501003)(14454004)(14444005)(110136005)(186003)(305945005)(2906002)(256004)(476003)(486006)(8936002)(11346002)(6246003)(2616005)(107886003)(446003)(81166006)(8676002)(81156014)(66066001)(31686004)(478600001)(31696002)(316002)(71200400001)(71190400001)(4326008)(68736007)(36756003)(6486002)(6436002)(53936002)(6512007)(64756008)(76176011)(3846002)(2201001)(52116002)(99286004)(66476007)(66946007)(66556008)(386003)(6506007)(53546011)(86362001)(102836004)(229853002)(73956011)(6116002)(54906003)(26005)(66446008);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4561;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0sFCNnvog/UhrSXeIdSsCafKdpVNjaNjBP3iXpxK8Oy+VlyiKQiKXGJ6DyjDzkT3mNRjMMO3CbKScrMvm1aA5vSRh19GI15Ev0Xn8nM0CznfkhrZcfi4iL+KOlnLTP21mJHxvDN8vwUO9FLEr3zJ2yEvqUaWWDGi904S28ivsOH0OU6FEhOVFTkQVzXRiHPht+8E/Nok6e8l8VsjnI3i6gDZxjqwh311zap5C9bT/Ocpf2bOoZKmrkWGbFYgTvOdkbG3DXOiYglzKpt9g4YMkze1WKOBSfcuSxdIO80zbWUIclI1HUOcn1kqnE2trWVTTQTLNXQjvEuYgfsncE0QBQVWge8gXrt0V2aaxB9EyqUth2BfETwkoo69aG9qEWTVa+qPcdvGFKadK9+EinplamIbUT769v8/au513QlNdQQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E564385BD9CE840A46D975B00BED181@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c0dac9-6d83-4567-ab56-08d6e80b0a25
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 10:05:43.4367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4561
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe02::716
Subject: Re: [Qemu-devel] [PATCH v2 2/9] python/qemu: improve event_wait
 method of vm
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
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDYuMjAxOSAyOjMzLCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gNS8zMS8xOSAx
MjozMSBQTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFN1cHBvcnQg
c2V2ZXJhbCBuYW1lcyB0byB3YWl0IGZvciwgd2hpY2ggdXNlZnVsLCB3aGVuIHdlIGRvbid0IHN1
cmUNCj4+IHdoaWNoIGV2ZW50IHdpbGwgd2UgZ2V0LiBGb3IgZXhhbXBsZSB3aGVuIG1pcnJvciBm
YWlscyB3ZSBnZXQNCj4+IEJMT0NLX0pPQl9DT01QTEVURSBvdGhlcndpc2Ugd2UgZ2V0IEJMT0NL
X0pPQl9SRUFEWSAoYW5kIG9ubHkgdGhlbiwNCj4+IGFmdGVyIGNvbXBsZXRpbmcgYmxvY2stam9i
IHdlIGdldCBCTE9DS19KT0JfQ09NUExFVEUpLg0KPj4NCj4+IEFsc28sIGFkZCBmaWx0ZXJlZCB2
ZXJzaW9uIGZvciBjb252ZW5pZW50IHVzZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1p
ciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0N
Cj4+ICAgcHl0aG9uL3FlbXUvX19pbml0X18ucHkgICAgICAgfCA5ICsrKysrKy0tLQ0KPj4gICB0
ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weSB8IDUgKysrKysNCj4+ICAgMiBmaWxlcyBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9weXRob24vcWVtdS9fX2luaXRfXy5weSBiL3B5dGhvbi9xZW11L19faW5pdF9fLnB5DQo+PiBp
bmRleCA4MWQ5NjU3ZWMwLi41ZTUxNzAyNWI5IDEwMDY0NA0KPj4gLS0tIGEvcHl0aG9uL3FlbXUv
X19pbml0X18ucHkNCj4+ICsrKyBiL3B5dGhvbi9xZW11L19faW5pdF9fLnB5DQo+PiBAQCAtNDAy
LDcgKzQwMiw3IEBAIGNsYXNzIFFFTVVNYWNoaW5lKG9iamVjdCk6DQo+PiAgICAgICAgICAgc2Vs
Zi5fcW1wLmNsZWFyX2V2ZW50cygpDQo+PiAgICAgICAgICAgcmV0dXJuIGV2ZW50cw0KPj4gICAN
Cj4+IC0gICAgZGVmIGV2ZW50X3dhaXQoc2VsZiwgbmFtZSwgdGltZW91dD02MC4wLCBtYXRjaD1O
b25lKToNCj4+ICsgICAgZGVmIGV2ZW50X3dhaXQoc2VsZiwgbmFtZXMsIHRpbWVvdXQ9NjAuMCwg
bWF0Y2g9Tm9uZSk6DQo+PiAgICAgICAgICAgIiIiDQo+PiAgICAgICAgICAgV2FpdCBmb3Igc3Bl
Y2lmaWVkIHRpbWVvdXQgb24gbmFtZWQgZXZlbnQgaW4gUU1QOyBvcHRpb25hbGx5IGZpbHRlcg0K
Pj4gICAgICAgICAgIHJlc3VsdHMgYnkgbWF0Y2guDQo+PiBAQCAtNDEyLDYgKzQxMiw5IEBAIGNs
YXNzIFFFTVVNYWNoaW5lKG9iamVjdCk6DQo+PiAgICAgICAgICAgICAgeyJmb28iOiB7ImJhciI6
IDF9fSBtYXRjaGVzIHsiZm9vIjogTm9uZX0NCj4+ICAgICAgICAgICAgICB7ImZvbyI6IHsiYmFy
IjogMX19IGRvZXMgbm90IG1hdGNoZXMgeyJmb28iOiB7ImJheiI6IE5vbmV9fQ0KPj4gICAgICAg
ICAgICIiIg0KPj4gKyAgICAgICAgaWYgbm90IGlzaW5zdGFuY2UobmFtZXMsIGxpc3QpOg0KPj4g
KyAgICAgICAgICAgIG5hbWVzID0gW25hbWVzXQ0KPj4gKw0KPj4gICAgICAgICAgIGRlZiBldmVu
dF9tYXRjaChldmVudCwgbWF0Y2g9Tm9uZSk6DQo+PiAgICAgICAgICAgICAgIGlmIG1hdGNoIGlz
IE5vbmU6DQo+PiAgICAgICAgICAgICAgICAgICByZXR1cm4gVHJ1ZQ0KPj4gQEAgLTQzMCwxNCAr
NDMzLDE0IEBAIGNsYXNzIFFFTVVNYWNoaW5lKG9iamVjdCk6DQo+PiAgIA0KPj4gICAgICAgICAg
ICMgU2VhcmNoIGNhY2hlZCBldmVudHMNCj4+ICAgICAgICAgICBmb3IgZXZlbnQgaW4gc2VsZi5f
ZXZlbnRzOg0KPj4gLSAgICAgICAgICAgIGlmIChldmVudFsnZXZlbnQnXSA9PSBuYW1lKSBhbmQg
ZXZlbnRfbWF0Y2goZXZlbnQsIG1hdGNoKToNCj4+ICsgICAgICAgICAgICBpZiAoZXZlbnRbJ2V2
ZW50J10gaW4gbmFtZXMpIGFuZCBldmVudF9tYXRjaChldmVudCwgbWF0Y2gpOg0KPj4gICAgICAg
ICAgICAgICAgICAgc2VsZi5fZXZlbnRzLnJlbW92ZShldmVudCkNCj4+ICAgICAgICAgICAgICAg
ICAgIHJldHVybiBldmVudA0KPj4gICANCj4+ICAgICAgICAgICAjIFBvbGwgZm9yIG5ldyBldmVu
dHMNCj4+ICAgICAgICAgICB3aGlsZSBUcnVlOg0KPj4gICAgICAgICAgICAgICBldmVudCA9IHNl
bGYuX3FtcC5wdWxsX2V2ZW50KHdhaXQ9dGltZW91dCkNCj4+IC0gICAgICAgICAgICBpZiAoZXZl
bnRbJ2V2ZW50J10gPT0gbmFtZSkgYW5kIGV2ZW50X21hdGNoKGV2ZW50LCBtYXRjaCk6DQo+PiAr
ICAgICAgICAgICAgaWYgKGV2ZW50WydldmVudCddIGluIG5hbWVzKSBhbmQgZXZlbnRfbWF0Y2go
ZXZlbnQsIG1hdGNoKToNCj4+ICAgICAgICAgICAgICAgICAgIHJldHVybiBldmVudA0KPj4gICAg
ICAgICAgICAgICBzZWxmLl9ldmVudHMuYXBwZW5kKGV2ZW50KQ0KPj4gICANCj4+IGRpZmYgLS1n
aXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9p
b3Rlc3RzLnB5DQo+PiBpbmRleCA3YmRlMzgwZDk2Li40MjE4ZmM5MDhiIDEwMDY0NA0KPj4gLS0t
IGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkNCj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90
ZXN0cy9pb3Rlc3RzLnB5DQo+PiBAQCAtNTMyLDYgKzUzMiwxMSBAQCBjbGFzcyBWTShxdGVzdC5R
RU1VUXRlc3RNYWNoaW5lKToNCj4+ICAgICAgICAgICBsb2cocmVzdWx0LCBmaWx0ZXJzLCBpbmRl
bnQ9aW5kZW50KQ0KPj4gICAgICAgICAgIHJldHVybiByZXN1bHQNCj4+ICAgDQo+PiArICAgIGRl
ZiBldmVudF93YWl0X2xvZyhzZWxmLCBuYW1lcywgKiprd2FyZ3MpOg0KPj4gKyAgICAgICAgZXZl
bnQgPSBzZWxmLmV2ZW50X3dhaXQobmFtZXMsICoqa3dhcmdzKQ0KPj4gKyAgICAgICAgbG9nKGV2
ZW50LCBmaWx0ZXJzPVtmaWx0ZXJfcW1wX2V2ZW50XSkNCj4+ICsgICAgICAgIHJldHVybiBldmVu
dA0KPj4gKw0KPj4gICAgICAgIyBSZXR1cm5zIE5vbmUgb24gc3VjY2VzcywgYW5kIGFuIGVycm9y
IHN0cmluZyBvbiBmYWlsdXJlDQo+PiAgICAgICBkZWYgcnVuX2pvYihzZWxmLCBqb2IsIGF1dG9f
ZmluYWxpemU9VHJ1ZSwgYXV0b19kaXNtaXNzPUZhbHNlKToNCj4+ICAgICAgICAgICBlcnJvciA9
IE5vbmUNCj4+DQo+IA0KPiBUaGVyZSdzIHNvbWV0aGluZyBsaWtlIHRoaXMgaW4gdGhlIHF1ZXVl
OyBzZWU6DQo+IFtRZW11LWRldmVsXSBbUEFUQ0ggdjMgMy81XSBRRU1VTWFjaGluZTogYWRkIGV2
ZW50c193YWl0IG1ldGhvZC4NCj4gDQo+IFRob3VnaCB5b3VycyBpcyBhIGxvdCBzaG9ydGVyLCBh
Y3R1YWxseSwgYmVjYXVzZSBJIG1hZGUgc2VwYXJhdGUNCj4gZXZlbnRfd2FpdCBhbmQgZXZlbnRz
X3dhaXQgY2FsbHMgaW5zdGVhZCBvZiBqdXN0IHRocm93aW5nIG5vbi1pdGVyYWJsZXMNCj4gaW4g
YSBsaXN0Lg0KDQpIbW0sIGl0J3MgYWxyZWFkeSBzdGFnZWQgYnkgTWF4LiBPaywgSSdsbCByZWJh
c2Ugb24gaXQuDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

