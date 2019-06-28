Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE16C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B4A2133F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="c3Ea3GaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B4A2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgsYQ-0000ZO-F7
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44330)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hgs3b-000540-66
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hgs3Z-0007mp-HX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:40:55 -0400
Received: from mail-vi1eur04on0700.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::700]:28228
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hgs3V-0007cW-TY; Fri, 28 Jun 2019 10:40:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=Wu9iRbkeKjkz6ZOWBXp1SslUFrlkUfWghoD/WSV8nkgT1PwAmT2Hg+Zbeyb8lnqExGNwD1bxYk+g4R80qrb0BhCzRtQgpXXGz/2RsXa6cS9+1iXPiB7Guy9/PGE8pXzN7mvWXuRWJ+jSHdSbqK4Mqote2hQBVEApG4GlZdcpk3E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmNqXCUeDlkPsxEpxfhxrIyzhXi84iNoznQ+Gr1B5I0=;
 b=Dz8Jk64OwhqKAFZ8bumiEJHLXEbSM2fABN9umt8g41aNGaWWF7k5bXohykKY8L913bi6V+/oBMfiMuI06Nq0+KI+3FxDQxjV7jS6Wgn4oqmw5oL7lkdqEWhXZAaCdhHaFCWIOVZj+gJ5m0nmE6sTdbe6XXEBiZwH4JWdBNIYsnc=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmNqXCUeDlkPsxEpxfhxrIyzhXi84iNoznQ+Gr1B5I0=;
 b=c3Ea3GaWexUI/Cb53beshiJ4ubCHgKT8wxNykJpVFwxpeS+2TQFWWGG0NHPxX3GfB/CQOtdoAu1lsWk7rwNpgqMeVnSiJPWFLDEKfr16Cbgjt2uECmE/jctq7sjOYjq0B9VuI66EnwUR5/19JZkRnRkNqFEoQSy9t0kNjU0lHkI=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4051.eurprd08.prod.outlook.com (20.178.119.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 14:40:44 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c%7]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 14:40:44 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v0 2/3] qcow2: add compression type processing
Thread-Index: AQHVLZuN7Ey1lYD5REukjsp4qtAkE6aw7L0AgAAL2QCAAEBXgP//5kmAgAAEfYA=
Date: Fri, 28 Jun 2019 14:40:43 +0000
Message-ID: <bf5134a7-7c5e-2b28-9acb-3b82df982e1e@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-3-dplotnikov@virtuozzo.com>
 <20190628102333.GG5179@dhcp-200-226.str.redhat.com>
 <08da0859-10da-5d4b-3203-72341a166255@virtuozzo.com>
 <20190628120622.GI5179@dhcp-200-226.str.redhat.com>
 <4fef0430-5a0c-36ca-eec0-a2c0ce10cb91@virtuozzo.com>
 <20190628142437.GL5179@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190628142437.GL5179@dhcp-200-226.str.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0066.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::34) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20065e82-4685-4444-d7e8-08d6fbd6995e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4051; 
x-ms-traffictypediagnostic: AM0PR08MB4051:
x-microsoft-antispam-prvs: <AM0PR08MB4051CDBD54B911F8ECF0C9ABCFFC0@AM0PR08MB4051.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(376002)(136003)(366004)(396003)(199004)(189003)(186003)(6512007)(478600001)(3846002)(25786009)(66066001)(53546011)(316002)(6246003)(66556008)(486006)(5660300002)(81156014)(476003)(71190400001)(6116002)(14454004)(8676002)(71200400001)(81166006)(11346002)(256004)(99286004)(66476007)(64756008)(73956011)(66446008)(446003)(36756003)(2616005)(66946007)(54906003)(6506007)(2906002)(6436002)(6486002)(7736002)(305945005)(52116002)(229853002)(4326008)(76176011)(86362001)(31686004)(102836004)(8936002)(26005)(107886003)(31696002)(53936002)(68736007)(6916009)(386003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4051;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N9S13kWfC1MYYYyeq6YbKAJQlRKgRXMXEwf7LS3VdLRQWzpMlYlMb6Fu6fGR5WBCc/RsAoLX+/rl1siziFlbTwvI301kWsomblhyd3WYIcCu+6qIQiPH1FgxAupsnCC7sMPGWN9AQYztJ0xUYxs2SknMtxFscXzs2yZEiYv5erVgLremGZvxk3KfV7JIUEirHoqQDQkVMcY4AbRxyE1jwrz32QHmJwSG55UwYrTvO63+NmULMujJFe3xuxyjHe2a2Ce5CqJmXCdpLCrBenQCSlo2OCC2H5rchPvpXnho99TuwZB7h88d5tz7n+HvSUQHb5EuBgSrcL4kxDfbD7D8Av6hBg/wZBPCQ/D9BkN3CERHINunp45xSDbkxO4JF4JYG2As++QOKljyfk6un/Kj4VghOu048wD4l+WjojwQvWY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A046D0AEBA23B44CB0B64D470B97C37C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20065e82-4685-4444-d7e8-08d6fbd6995e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 14:40:43.8514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4051
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::700
Subject: Re: [Qemu-devel] [PATCH v0 2/3] qcow2: add compression type
 processing
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI4LjA2LjIwMTkgMTc6MjQsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDI4LjA2LjIw
MTkgdW0gMTQ6NTYgaGF0IERlbmlzIFBsb3RuaWtvdiBnZXNjaHJpZWJlbjoNCj4+DQo+Pg0KPj4g
T24gMjguMDYuMjAxOSAxNTowNiwgS2V2aW4gV29sZiB3cm90ZToNCj4+PiBBbSAyOC4wNi4yMDE5
IHVtIDEzOjI0IGhhdCBEZW5pcyBQbG90bmlrb3YgZ2VzY2hyaWViZW46DQo+Pj4+DQo+Pj4+DQo+
Pj4+IE9uIDI4LjA2LjIwMTkgMTM6MjMsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4+PiBBbSAyOC4w
NS4yMDE5IHVtIDE2OjM3IGhhdCBEZW5pcyBQbG90bmlrb3YgZ2VzY2hyaWViZW46DQo+Pj4+Pj4g
V2l0aCB0aGUgcGF0Y2gsIHFjb3cyIGlzIGFibGUgdG8gcHJvY2VzcyBpbWFnZSBjb21wcmVzc2lv
biB0eXBlDQo+Pj4+Pj4gZGVmaW5lZCBpbiB0aGUgaW1hZ2UgaGVhZGVyIGFuZCBjaG9vc2UgdGhl
IGNvcnJlc3BvbmRpbmcgbWV0aG9kDQo+Pj4+Pj4gZm9yIGNsdXN0ZXJzIGNvbXByZXNzaW5nLg0K
Pj4+Pj4+DQo+Pj4+Pj4gQWxzbywgaXQgcmV3b3JrIHRoZSBjbHVzdGVyIGNvbXByZXNzaW9uIGNv
ZGUgZm9yIGFkZGluZyBtb3JlDQo+Pj4+Pj4gY29tcHJlc3Npb24gdHlwZXMuDQo+Pj4+Pj4NCj4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBEZW5pcyBQbG90bmlrb3YgPGRwbG90bmlrb3ZAdmlydHVvenpv
LmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiAgICAgYmxvY2svcWNvdzIuYyB8IDEwMyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPj4+Pj4+ICAgICAx
IGZpbGUgY2hhbmdlZCwgOTIgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+Pj4+Pj4N
Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzIuYyBiL2Jsb2NrL3Fjb3cyLmMNCj4+Pj4+
PiBpbmRleCBjNGI1YjkzNDA4Li45MGYxNWNjM2M5IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2Jsb2Nr
L3Fjb3cyLmMNCj4+Pj4+PiArKysgYi9ibG9jay9xY293Mi5jDQo+Pj4+Pj4gQEAgLTQwMCwxMSAr
NDAwLDM5IEBAIHN0YXRpYyBpbnQgcWNvdzJfcmVhZF9leHRlbnNpb25zKEJsb2NrRHJpdmVyU3Rh
dGUgKmJzLCB1aW50NjRfdCBzdGFydF9vZmZzZXQsDQo+Pj4+Pj4gICAgICAgICAgICAgICAgIGJy
ZWFrOw0KPj4+Pj4+ICAgICANCj4+Pj4+PiAgICAgICAgICAgICBjYXNlIFFDT1cyX0VYVF9NQUdJ
Q19DT01QUkVTU0lPTl9UWVBFOg0KPj4+Pj4+ICsgICAgICAgICAgICAvKiBDb21wcmVzc2lvbiB0
eXBlIGFsd2F5cyBnb2VzIHdpdGggdGhlIGNvbXByZXNzaW9uIHR5cGUgYml0IHNldCAqLw0KPj4+
Pj4+ICsgICAgICAgICAgICBpZiAoIShzLT5pbmNvbXBhdGlibGVfZmVhdHVyZXMgJiBRQ09XMl9J
TkNPTVBBVF9DT01QUkVTU0lPTl9UWVBFKSkgew0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgZXJy
b3Jfc2V0ZyhlcnJwLA0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAiY29tcHJl
c3Npb25fdHlwZV9leHQ6ICINCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgImV4
cGVjdCBjb21wcmVzc2lvbiB0eXBlIGJpdCBzZXQiKTsNCj4+Pj4+PiArICAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOw0KPj4+Pj4+ICsgICAgICAgICAgICB9DQo+Pj4+Pj4gKw0KPj4+Pj4+
ICsgICAgICAgICAgICByZXQgPSBiZHJ2X3ByZWFkKGJzLT5maWxlLCBvZmZzZXQsICZzLT5jb21w
cmVzc2lvbl90eXBlLCBleHQubGVuKTsNCj4+Pj4+PiArICAgICAgICAgICAgcy0+Y29tcHJlc3Np
b25fdHlwZSA9IGJlMzJfdG9fY3B1KHMtPmNvbXByZXNzaW9uX3R5cGUpOw0KPj4+Pj4+ICsNCj4+
Pj4+PiArICAgICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4+Pj4+PiArICAgICAgICAgICAgICAg
IGVycm9yX3NldGdfZXJybm8oZXJycCwgLXJldCwNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIkVSUk9SOiBDb3VsZCBub3QgcmVhZCBjb21wcmVzc2lvbiB0eXBlIik7
DQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4+Pj4+ICsgICAgICAgICAg
ICB9DQo+Pj4+Pj4gKw0KPj4+Pj4+ICAgICAgICAgICAgICAgICAvKg0KPj4+Pj4+IC0gICAgICAg
ICAgICAgKiBTZXR0aW5nIGNvbXByZXNzaW9uIHR5cGUgdG8gQkRSVlFjb3cyU3RhdGUtPmNvbXBy
ZXNzaW9uX3R5cGUNCj4+Pj4+PiAtICAgICAgICAgICAgICogZnJvbSB0aGUgaW1hZ2UgaGVhZGVy
IGlzIGdvaW5nIHRvIGJlIGhlcmUNCj4+Pj4+PiArICAgICAgICAgICAgICogVGhlIGRlZmF1bHQg
Y29tcHJlc3Npb24gdHlwZSBpcyBub3QgYWxsb3dlZCB3aGVuIHRoZSBleHRlbnNpb24NCj4+Pj4+
PiArICAgICAgICAgICAgICogaXMgcHJlc2VudC4gWkxJQiBpcyB1c2VkIGFzIHRoZSBkZWZhdWx0
IGNvbXByZXNzaW9uIHR5cGUuDQo+Pj4+Pj4gKyAgICAgICAgICAgICAqIFdoZW4gY29tcHJlc3Np
b24gdHlwZSBleHRlbnNpb24gaGVhZGVyIGlzIHByZXNlbnQgdGhlbg0KPj4+Pj4+ICsgICAgICAg
ICAgICAgKiBjb21wcmVzc2lvbl90eXBlIHNob3VsZCBoYXZlIGEgdmFsdWUgZGlmZmVyZW50IGZy
b20gdGhlIGRlZmF1bHQuDQo+Pj4+Pj4gICAgICAgICAgICAgICAgICAqLw0KPj4+Pj4+IC0gICAg
ICAgICAgICAgYnJlYWs7DQo+Pj4+Pj4gKyAgICAgICAgICAgIGlmIChzLT5jb21wcmVzc2lvbl90
eXBlID09IFFDT1cyX0NPTVBSRVNTSU9OX1RZUEVfWkxJQikgew0KPj4+Pj4+ICsgICAgICAgICAg
ICAgICAgZXJyb3Jfc2V0ZyhlcnJwLA0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAiY29tcHJlc3Npb25fdHlwZV9leHQ6Ig0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiaW52YWxpZCBjb21wcmVzc2lvbiB0eXBlICVkIiwNCj4+Pj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgUUNPVzJfQ09NUFJFU1NJT05fVFlQRV9aTElCKTsNCj4+Pj4+PiArICAg
ICAgICAgICAgfQ0KPj4+Pj4NCj4+Pj4+IFRoaXMgaXMgYSByZXN0cmljdGlvbiB0aGF0IHRoZSBz
cGVjIGRvZXNuJ3QgbWFrZSwgc28gc3RyaWN0bHkgc3BlYWtpbmcNCj4+Pj4+IHRoaXMgaW1wbGVt
ZW50YXRpb24gd291bGRuJ3QgYmUgY29tcGxpYW50IHRvIHRoZSBzcGVjLg0KPj4+PiBUaGUgaWRl
YSBpcyB0aGF0IFpMSUIgc2hvdWxkbid0IGFwcGVhciBpbiB0aGUgY29tcHJlc3Npb24gdHlwZQ0K
Pj4+PiBleHRlbnNpb24uIFRoaXMgYWxsb3dzIGltYWdlIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkg
d2l0aCBhbiBvbGRlciBxZW11DQo+Pj4+IGlmIHpsaWIgaXMgdXNlZC4NCj4+Pj4NCj4+Pj4gVGhl
cmUgaXMgbm8gcmVhc29uIHRvIHNldCBaTElCIGluIHRoZSBleHRlbnNpb24gYmVjYXVzZSBhbiBv
bGRlciBxZW11DQo+Pj4+IGtub3dzIGhvdyB0byB0cmVhZCBaTElCIGNvbXByZXNzZWQgY2x1c3Rl
cnMuDQo+Pj4+DQo+Pj4+IFRoZSByZXN0cmljdGlvbiBhaW1zIHRvIGd1YXJhbnRlZSB0aGF0Lg0K
Pj4+Pg0KPj4+PiBJIHRyaWVkIHRvIGRlc2NyaWJlIHRoaXMgY2FzZSBpbiB0aGUgc3BlY2lmaWNh
dGlvbjoNCj4+Pj4gLi4uDQo+Pj4+IFdoZW4gdGhlIGNvbXByZXNzaW9uIHR5cGUgYml0IGlzIG5v
dCBzZXQsIGFuZCB0aGUgY29tcHJlc3Npb24gdHlwZQ0KPj4+PiBoZWFkZXIgZXh0ZW5zaW9uIGlz
IGFic2VudCwgWkxJQiBjb21wcmVzc2lvbiBpcyB1c2VkIGZvciBjb21wcmVzc2VkDQo+Pj4+IGNs
dXN0ZXJzLg0KPj4+Pg0KPj4+PiBRZW11IHZlcnNpb25zIG9sZGVyIHRoYW4gNC4xIGNhbiB1c2Ug
aW1hZ2VzIGNyZWF0ZWQgd2l0aCBjb21wcmVzc2lvbg0KPj4+PiB0eXBlIFpMSUIgd2l0aG91dCBh
bnkgYWRkaXRpb25hbCBwcmVwYXJhdGlvbnMgYW5kIGNhbm5vdCB1c2UgaW1hZ2VzDQo+Pj4+IGNy
ZWF0ZWQgd2l0aCBjb21wcmVzc2lvbiB0eXBlcyAhPSBaTElCLg0KPj4+PiAuLi4NCj4+Pj4NCj4+
Pj4gRG9lcyBpdCBtYWtlcyBzZW5zZT8NCj4+Pg0KPj4+IFRoaXMgdGV4dCBzYXlzIHRoYXQgdXNp
bmcgemxpYiBpbiB0aGUgZXh0ZW5zaW9uIGlzIG5vdCBuZWNlc3NhcnkgYmVjYXVzZQ0KPj4+IGl0
J3MgdGhlIGRlZmF1bHQuIEJ1dCBpdCBkb2Vzbid0IHNheSB0aGF0IHVzaW5nIHpsaWIgaW4gdGhl
IGV4dGVuc2lvbiBpcw0KPj4+IGlsbGVnYWwuDQo+Pj4NCj4+PiBJIGFncmVlIHRoYXQgdGhlcmUg
aXMgbm8gZ29vZCByZWFzb24gdG8gY3JlYXRlIGEgY29tcHJlc3Npb24gdHlwZQ0KPj4+IGV4dGVu
c2lvbiBpZiB5b3UgaGF2ZSB6bGliLiBCdXQgaXMgdGhlcmUgYSBnb29kIHJlYXNvbiB0byBmb3Ji
aWQgaXQ/DQo+PiBJIHRoaW5rIHllcywgaWYgd2UgY3JlYXRlIGltYWdlIHdpdGggdGhlIGV4dGVu
c2lvbiBzZXQgdG8gemxpYiB3ZQ0KPj4gcHJldmVudCBhbiBvbGRlciBxZW11IGZyb20gdXNpbmcg
dGhhdCBpbWFnZS4gRnVydGhlcm1vcmUsIHRvIGFsbG93IG9sZGVyDQo+PiBxZW11IHVzaW5nIHN1
Y2ggaW1hZ2VzIHdlIG5lZWQgdG8gY3JlYXRlIHNwZWNpYWwgY29udmVyc2lvbiBwcm9jZWR1cmUN
Cj4+IHdoaWNoIGhhcyB0byByZW1vdmUgdGhlIGV4dGVuc2lvbiBoZWFkZXIuDQo+Pg0KPj4gSWYg
emxpYiBpcyBhICJzcGVjaWFsIGNvbXByZXNzaW9uIHR5cGUiIHdoaWNoIGlzIGFsd2F5cyBzZXQg
YnkgZGVmYXVsdA0KPj4gd2l0aG91dCB0aGUgZXh0ZW5zaW9uIGhlYWRlciB3ZSdsbCBnZXQgcmlk
IG9mIHN1Y2ggaW1hZ2UgY29udmVyc2lvbg0KPj4gcHJvY2VkdXJlIGFuZCBhbiBvbGRlciBxZW11
IGNvdWxkIHVzZSBpdCAiYXMgaXMiDQo+Pg0KPj4gTWlnaHQgaXQgd29yayBhcyBhIGdvb2QgcmVh
c29uPw0KPj4NCj4+PiBJdA0KPj4+IG9ubHkgcmVxdWlyZXMgdXMgdG8gYWRkIGFydGlmaWNpYWwg
cmVzdHJpY3Rpb25zIHRvIGNvZGUgdGhhdCB3b3VsZCB3b3JrDQo+Pj4gZmluZSB3aXRob3V0IHRo
ZW0uDQo+Pj4NCj4+PiBFaXRoZXIgd2F5LCBpZiB3ZSB3YW50IHRvIHJlamVjdCBzdWNoIGV4dGVu
c2lvbnMsIHRoZSBzcGVjIG5lZWRzIHRvIHNheQ0KPj4+IHRoYXQgaXQncyBpbGxlZ2FsLiBBbmQg
aWYgdGhlIHNwZWMgYWxsb3dzIHN1Y2ggaW1hZ2VzLCB3ZSBtdXN0IGFjY2VwdA0KPj4+IHRoZW0u
DQo+PiBZZXMsIGl0J3MgdHJ1ZQ0KPj4NCj4+IFRoZSBvbmx5IHJlYXNvbnMgdGhhdCB6bGliIGNv
bXByZXNzaW9uIHR5cGUgZXZlbiBleGlzdHMgaW4gdGhlDQo+PiBlbnVtZXJhdGlvbiBpcyB0byBh
dm9pZCBhbWJpZ3VpdHkgZm9yIHVzZXJzLg0KPj4gRm9yIHRoZW0gaXQgbWF5IGJlIGhhcmQgdG8g
dW5kZXJzdGFuZCB3aHkgdGhleSBjYW4gc2V0IHpzdGQgYW5kIGNhbm5vdA0KPj4gc2V0IHpsaWIg
YXMgY29tcHJlc3Npb24gdHlwZSBhbmQgdG8gcmVhbGx5IHNldCB6bGliIHRoZXkgaGF2ZSB0byBz
ZXQgbm8NCj4+IGNvbXByZXNzaW9uIHR5cGUgdG8gbWFrZSB0aGUgZGVmYXVsdCB6bGliIHRvIGFw
cGx5Lg0KPj4NCj4+IFdoZW4gYSB1c2VyIHNldCB6bGliIGFzIGNvbXByZXNzaW9uIHR5cGUgdGhl
IGltYWdlIGlzIGNyZWF0ZWQgYXMgYmVmb3JlDQo+PiB0aGUgZXh0ZW5zaW9uIGhlYWRlciB3ZXJl
IGludHJvZHVjZWQuDQo+Pg0KPj4gUmVhc29uYWJsZT8NCj4+Pg0KPj4+Pj4gV2UgY2FuIGRpc2N1
c3Mgd2hldGhlciB0aGUgY29kZSBvciB0aGUgc3BlYyBzaG91bGQgYmUgY2hhbmdlZC4gQXQgdGhl
DQo+Pj4+PiBtb21lbnQsIEkgZG9uJ3Qgc2VlIGEgZ29vZCByZWFzb24gdG8gbWFrZSB0aGUgcmVz
dHJpY3Rpb24NCj4+Pj4+DQo+Pj4+Pj4gKyNpZmRlZiBERUJVR19FWFQNCj4+Pj4+PiArICAgICAg
ICAgICAgcHJpbnRmKCJRY293MjogaW1hZ2UgY29tcHJlc3Npb24gdHlwZSAlc1xuIiwgcy0+Y29t
cHJlc3Npb25fdHlwZSk7DQo+Pj4+Pj4gKyNlbmRpZg0KPj4+Pj4+ICsgICAgICAgICAgICBicmVh
azsNCj4+Pj4+PiAgICAgDQo+Pj4+Pj4gICAgICAgICAgICAgY2FzZSBRQ09XMl9FWFRfTUFHSUNf
REFUQV9GSUxFOg0KPj4+Pj4+ICAgICAgICAgICAgIHsNCj4+Pj4+DQo+Pj4+PiBXZSB3b3VsZCBz
YXZlIG1vc3Qgb2YgdGhpcyBjb2RlIGlmIHdlIGFkZGVkIGEgbmV3IGZpZWxkIHRvIHRoZSBoZWFk
ZXINCj4+Pj4+IGluc3RlYWQgb2YgYWRkaW5nIGEgaGVhZGVyIGV4dGVuc2lvbi4gTm90IHNheWlu
ZyB0aGF0IHdlIHNob3VsZA0KPj4+Pj4gZGVmaW5pdGVseSBkbyB0aGlzLCBidXQgbGV0J3MgZGlz
Y3VzcyBpdCBhdCBsZWFzdC4NCj4+Pj4NCj4+Pj4gSWYgd2UgYWRkIHRoZSBuZXcgZmllbGQgdG8g
dGhlIGhlYWRlciB3aWxsIHRoZSBvbGRlciBxZW11IGJlIGFibGUgdG8gdXNlDQo+Pj4+IGl0LiBP
ciB3ZSB3aWxsIGFkZCB0aGUgaGVhZGVyIG9ubHkgaWYgbmVlZGVkLCBpLmUuIGlmIGNvbXByZXNz
aW9uX3R5cGUNCj4+Pj4gIT0gemxpYg0KPj4+DQo+Pj4gSW5jcmVhc2luZyB0aGUgaGVhZGVyIHNp
emUgaXMgYmFja3dhcmRzIGNvbXBhdGlibGUuIE9sZGVyIHFlbXUgdmVyc2lvbnMNCj4+PiBzaG91
bGQgaGFuZGxlIHN1Y2ggaW1hZ2VzIGNvcnJlY3RseS4gVGhleSB3b3VsZCBzdG9yZSB0aGUgdW5r
bm93biBwYXJ0DQo+Pj4gb2YgdGhlIGhlYWRlciBpbiBzLT51bmtub3duX2hlYWRlcl9maWVsZHMg
YW5kIGtlZXAgaXQgdW5tb2RpZmllZCB3aGVuDQo+Pj4gdXBkYXRpbmcgdGhlIGltYWdlIGhlYWRl
ci4NCj4+Pg0KPj4+IFdlIHdvdWxkIHN0aWxsIGFkZCB0aGUgaW5jb21wYXRpYmxlIGZlYXR1cmUg
ZmxhZyBmb3Igbm9uLXpsaWIsIG9mDQo+Pj4gY291cnNlLg0KPj4gc28sIHdlIGJhc2ljYWxseSBu
ZWVkIHRvIGRvIHRoZSBzYW1lOiBzdG9yZSBjb21wcmVzc2lvbiB0eXBlIGFuZCBmb3JiaWQNCj4+
IHRvIHVzZSBiZWNhdXNlIG9mIGZsYWcgaWYgbm90IHpsaWIuDQo+Pg0KPj4gU291bmRzIGxpa2Ug
aXQgZG9lc24ndCBkaWZmZXIgdGhhdCBtdWNoIGZyb20gdGhlIGV4dGVuc2lvbiBoZWFkZXIgYXBw
cm9hY2guDQo+IA0KPiBJdCBwcm92aWRlcyBtb3JlIG9yIGxlc3MgdGhlIHNhbWUgZnVuY3Rpb25h
bGl0eSwgYnV0IHdvdWxkIHByb2JhYmx5IG1ha2UNCj4gdGhpcyBwYXRjaCBoYWxmIHRoZSBzaXpl
IGJlY2F1c2UgYWxsIG9mIHRoZSBjb2RlIHJlbGF0ZWQgdG8gcmVhZGluZyBhbmQNCj4gY2hlY2tp
bmcgdGhlIGhlYWRlciBleHRlbnNpb24gd291bGQgZ28gYXdheS4gSXQgYWxzbyBzYXZlcyBhIGZl
dyBieXRlcw0KPiBpbiB0aGUgaGVhZGVyIGNsdXN0ZXIgKDQgYnl0ZXMgdnMuIDE2IGJ5dGVzKS4N
Cm9rLCB3aWxsIHJlLWRvIGl0IHRoYXQgd2F5Lg0KDQpEbyB5b3UgYWdyZWUgaW4gZ2VuZXJhbCB3
aXRoIGhvdyB6bGliIGNvbXByZXNzaW9uIHR5cGUgaXMgdHJlYXRlZD8NCg0KRGVuaXMNCj4gDQo+
IEtldmluDQo+IA0KDQotLSANCkJlc3QsDQpEZW5pcw0K

