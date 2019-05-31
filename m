Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCDFC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 19:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AEF526E24
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 19:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WeybCj7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEF526E24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47875 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWmoA-0000lU-Nk
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 15:03:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWmmt-0000BM-94
	for qemu-devel@nongnu.org; Fri, 31 May 2019 15:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWmmr-0001oC-LN
	for qemu-devel@nongnu.org; Fri, 31 May 2019 15:01:59 -0400
Received: from mail-eopbgr80139.outbound.protection.outlook.com
	([40.107.8.139]:64576
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hWmmq-0001iV-9r
	for qemu-devel@nongnu.org; Fri, 31 May 2019 15:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ZXGZbCASboNZFrItFs+lyLH0r9ai1X5M9pg03IX29OE=;
	b=WeybCj7GEpAR9uO5RbSE7NjiraSdMciNjD3uC2FI4hKkvqynyYjtmjGdlwebolxuCeNXt1yHOJLAvsp5nHSrq01Nhki8jXgWWXuJ+luDInIzgg+2/GTKB8yx6gOP+Xz9khInkTSuvZVdipPF8phT7FGVNylkpn4c4EqKHd4uyis=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB5251.eurprd08.prod.outlook.com (20.179.39.152) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.16; Fri, 31 May 2019 19:01:49 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1943.018;
	Fri, 31 May 2019 19:01:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PULL v2 3/3] blockdev: acquire aio_context for
	bitmap add/remove
Thread-Index: AQHUyUcV8RSjifrUx0ySegZzcJVcPaaGGpmAgAAM0ACAAAyfgA==
Date: Fri, 31 May 2019 19:01:49 +0000
Message-ID: <5f47e6a1-f353-d23f-5cbe-5a3628fc1a70@virtuozzo.com>
References: <20190220180112.28250-1-jsnow@redhat.com>
	<20190220180112.28250-4-jsnow@redhat.com>
	<c4cfb4f0-cc7b-3952-3c70-b498b2ec9847@virtuozzo.com>
	<44d131fa-9cb8-95ba-eab6-0b7cdda374ab@redhat.com>
In-Reply-To: <44d131fa-9cb8-95ba-eab6-0b7cdda374ab@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0012.eurprd05.prod.outlook.com
	(2603:10a6:3:e3::22) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190531220147375
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75b6ca0e-1e04-43a2-f31a-08d6e5fa6f14
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:AM0PR08MB5251; 
x-ms-traffictypediagnostic: AM0PR08MB5251:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR08MB5251884175457D146580F81CC1190@AM0PR08MB5251.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(346002)(366004)(39850400004)(396003)(136003)(189003)(199004)(52314003)(66066001)(66446008)(316002)(71190400001)(71200400001)(6486002)(256004)(229853002)(73956011)(66946007)(2501003)(478600001)(68736007)(6436002)(25786009)(76176011)(14444005)(14454004)(66556008)(64756008)(305945005)(36756003)(966005)(102836004)(66476007)(3846002)(53546011)(7736002)(6116002)(5660300002)(486006)(2616005)(86362001)(11346002)(6506007)(2906002)(31696002)(26005)(446003)(8936002)(476003)(110136005)(52116002)(186003)(386003)(99286004)(6246003)(53936002)(6512007)(4326008)(31686004)(6306002)(8676002)(81166006)(81156014);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5251;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tflhW42k8vD4YRwcdyd8ELaBEJkHQXm2RYEWQpy0bfi8hSQVyFLaC3QjvN1uMsGEt1DvanF3VKLB9EgV2FalwttIDkoEO3TjDteeH4wGEEuazFgypJxdFYEalS5uOCn9PwLR+lKzS9Ub2LFBR8PZdzrAQK4DgD0SryT+wMMsIYBHDYkbIzfW3Lz8hFmDnI6YQFU+oKbI+flukZqz2txxbQXgcLVllPQha6g9SNJeRSXbfwo5T7YOl4yjpLnwZsUXI6hNkktG6BGiwOwcJhtJGnWsL9Nuyx4/cj/MPmiwpKcMQEB6u9k06zLQ5n/XXKT/kDJrU3cFVZyCoK69Dg6O95GD5a/M3h+AUgZQrb0OPY9XAGD8it04W20J10AZEYcyKRRs4789AVDZEh9ewvAR13SsyZ6FNfRWecqy719hBjg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46D598C1D40E11418707C1B922D2656A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b6ca0e-1e04-43a2-f31a-08d6e5fa6f14
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 19:01:49.2379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5251
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.139
Subject: Re: [Qemu-devel] [PULL v2 3/3] blockdev: acquire aio_context for
 bitmap add/remove
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzEuMDUuMjAxOSAyMToxNiwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDUvMzEvMTkg
MTozMCBQTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEhpIQ0KPj4N
Cj4+IDIwLjAyLjIwMTkgMjE6MDEsIEpvaG4gU25vdyB3cm90ZToNCj4+PiBXaGVuIGJpdG1hcHMg
YXJlIHBlcnNpc3RlbnQsIHRoZXkgbWF5IGluY3VyIGEgZGlzayByZWFkIG9yIHdyaXRlIHdoZW4g
Yml0bWFwcw0KPj4+IGFyZSBhZGRlZCBvciByZW1vdmVkLiBGb3IgY29uZmlndXJhdGlvbnMgbGlr
ZSB2aXJ0aW8tZGF0YXBsYW5lLCBmYWlsaW5nIHRvDQo+Pj4gYWNxdWlyZSB0aGlzIGxvY2sgd2ls
bCBhYm9ydCBRRU1VIHdoZW4gZGlzayBJTyBvY2N1cnMuDQo+Pj4NCj4+PiBXZSB1c2VkIHRvIGFj
cXVpcmUgYWlvX2NvbnRleHQgYXMgcGFydCBvZiB0aGUgYml0bWFwIGxvb2t1cCwgc28gcmUtaW50
cm9kdWNlDQo+Pj4gdGhlIGxvY2sgZm9yIGp1c3QgdGhlIGNhc2VzIHRoYXQgaGF2ZSBhbiBJTyBw
ZW5hbHR5LiBDb21taXQgMjExOTg4MmMgcmVtb3ZlZA0KPj4+IHRoZXNlIGxvY2tzLCBhbmQgSSBm
YWlsZWQgdG8gbm90aWNlIHRoaXMgd2hlbiB3ZSBjb21taXR0ZWQgZmQ1YWU0Y2MsIHNvIHRoaXMN
Cj4+PiBoYXMgYmVlbiBicm9rZW4gc2luY2UgcGVyc2lzdGVudCBiaXRtYXBzIHdlcmUgaW50cm9k
dWNlZC4NCj4+Pg0KPj4+IEZpeGVzOiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19i
dWcuY2dpP2lkPTE2NzIwMTANCj4+PiBSZXBvcnRlZC1CeTogQWlodWEgTGlhbmcgPGFsaWFuZ0By
ZWRoYXQuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IEpvaG4gU25vdyA8anNub3dAcmVkaGF0LmNv
bT4NCj4+PiBSZXZpZXdlZC1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+Pj4g
TWVzc2FnZS1pZDogMjAxOTAyMTgyMzMxNTQuMTkzMDMtMS1qc25vd0ByZWRoYXQuY29tDQo+Pj4g
U2lnbmVkLW9mZi1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KPj4+IC0tLQ0KPj4N
Cj4+IFsuLl0NCj4+DQo+Pj4gICAgdm9pZCBxbXBfYmxvY2tfZGlydHlfYml0bWFwX3JlbW92ZShj
b25zdCBjaGFyICpub2RlLCBjb25zdCBjaGFyICpuYW1lLA0KPj4+IEBAIC0yODc4LDYgKzI4ODUs
NyBAQCB2b2lkIHFtcF9ibG9ja19kaXJ0eV9iaXRtYXBfcmVtb3ZlKGNvbnN0IGNoYXIgKm5vZGUs
IGNvbnN0IGNoYXIgKm5hbWUsDQo+Pj4gICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKmJzOw0KPj4+
ICAgICAgICBCZHJ2RGlydHlCaXRtYXAgKmJpdG1hcDsNCj4+PiAgICAgICAgRXJyb3IgKmxvY2Fs
X2VyciA9IE5VTEw7DQo+Pj4gKyAgICBBaW9Db250ZXh0ICphaW9fY29udGV4dCA9IE5VTEw7DQo+
Pj4gICAgDQo+Pj4gICAgICAgIGJpdG1hcCA9IGJsb2NrX2RpcnR5X2JpdG1hcF9sb29rdXAobm9k
ZSwgbmFtZSwgJmJzLCBlcnJwKTsNCj4+PiAgICAgICAgaWYgKCFiaXRtYXAgfHwgIWJzKSB7DQo+
Pj4gQEAgLTI4OTIsMTQgKzI5MDAsMjAgQEAgdm9pZCBxbXBfYmxvY2tfZGlydHlfYml0bWFwX3Jl
bW92ZShjb25zdCBjaGFyICpub2RlLCBjb25zdCBjaGFyICpuYW1lLA0KPj4+ICAgICAgICB9DQo+
Pj4gICAgDQo+Pj4gICAgICAgIGlmIChiZHJ2X2RpcnR5X2JpdG1hcF9nZXRfcGVyc2lzdGFuY2Uo
Yml0bWFwKSkgew0KPj4+ICsgICAgICAgIGFpb19jb250ZXh0ID0gYmRydl9nZXRfYWlvX2NvbnRl
eHQoYnMpOw0KPj4+ICsgICAgICAgIGFpb19jb250ZXh0X2FjcXVpcmUoYWlvX2NvbnRleHQpOw0K
Pj4+ICAgICAgICAgICAgYmRydl9yZW1vdmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXAoYnMsIG5h
bWUsICZsb2NhbF9lcnIpOw0KPj4+ICAgICAgICAgICAgaWYgKGxvY2FsX2VyciAhPSBOVUxMKSB7
DQo+Pj4gICAgICAgICAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7DQo+
Pj4gLSAgICAgICAgICAgIHJldHVybjsNCj4+PiArICAgICAgICAgICAgZ290byBvdXQ7DQo+Pj4g
ICAgICAgICAgICB9DQo+Pj4gICAgICAgIH0NCj4+PiAgICANCj4+PiAgICAgICAgYmRydl9yZWxl
YXNlX2RpcnR5X2JpdG1hcChicywgYml0bWFwKTsNCj4+PiArIG91dDoNCj4+PiArICAgIGlmIChh
aW9fY29udGV4dCkgew0KPj4+ICsgICAgICAgIGFpb19jb250ZXh0X3JlbGVhc2UoYWlvX2NvbnRl
eHQpOw0KPj4+ICsgICAgfQ0KPj4+ICAgIH0NCj4+PiAgICANCj4+PiAgICAvKioNCj4+Pg0KPj4N
Cj4+IEEgYml0IGxhdGUsIGJ1dCBJIGhhdmUgYSBxdWVzdGlvbjoNCj4+DQo+PiBXaHkgZGlkIHlv
dSBpbmNsdWRlIGJkcnZfcmVsZWFzZV9kaXJ0eV9iaXRtYXAgY2FsbCBpbnRvIGNvbnRleHQtYWNx
dWlyZWQgc2VjdGlvbj8gQXMgSSBjYW4NCj4+IHVuZGVyc3RhbmQgZnJvbSBjb21taXQgbWVzc2Fn
ZSwgaXQncyBub3QgYWN0dWFsbHkgbmVlZGVkPw0KPj4NCj4gDQo+IE5vIHJlYXNvbiBiZXlvbmQg
aGFiaXQuDQo+IA0KDQpPayB0aGFua3MuIEknbSBub3cgd29ya2luZyAob2sgd29ya2VkLCBJJ2Qg
YmV0dGVyIGdvIGhvbWUgbm93KSBvbiB0cmFuc2FjdGlvbiBhY3Rpb24gZm9yIGJpdG1hcC1yZW1v
dmUuDQpJdCBvY2N1cnMsIHRoYXQgd2UgbmVlZCBpdCB0byBoYXZlIGFuIGFiaWxpdHkgdG8gX21v
dmVfLCBub3QgX2NvcHlfIGJpdG1hcHMgaW4gdHJhbnNhY3Rpb24gKHdlIG9mIGNvdXJzZQ0KY2Fu
IGNvcHkgaW4gdHJhbnNhY3Rpb24gYW5kIHRoZW4gcmVtb3ZlIGFmdGVyIHRyYW5zYWN0aW9uLCBi
dXQgaXQgZG9lc24ndCB3b3JrIGlmIGJpdG1hcCBpcyBwZXJzaXN0ZW50IGFuZA0KYWZ0ZXIgdHJh
bnNhY3Rpb24gbm9kZSBpcyBSTykuIFNvLCBJIGhhdmUgdG8gcmVmYWN0b3IgdGhpcyBjb2RlIGFu
eXdheSwgYW5kIHRoZXJlZm9yZSBJJ3ZlIGFza2VkIGZvciB0aGlzDQp0aGluZyB3aGljaCBJIHdh
bnQgdG8gcmVmYWN0b3IgdG9vLg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

