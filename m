Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2D8C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94F526D32
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AV4L64lP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94F526D32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWlO5-0005Rg-5F
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:32:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWlMj-0004iK-Jw
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWlMi-00073D-EA
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:30:53 -0400
Received: from mail-db5eur01on0728.outbound.protection.outlook.com
	([2a01:111:f400:fe02::728]:2647
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hWlMh-000713-LF
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=nqhGrPSA5u1xjeYmApzFQPyucy2VfvuoQNvjUtkLzmQ=;
	b=AV4L64lP/YOvXUNelTMkpigrGPIqIWyDMObOhzDhEiMMTp3Xq+BiJmXghOh+9q23h3FG+rXfZE8xUkE4/ZEieAL1Kx7OVoRRMUN3GqW/65YumtEqCPwuCZAhLm1TG/eVV91wwSYtVpW7ncmdzwaWo63upmIBuwHPcgodbYD/6uY=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.16; Fri, 31 May 2019 17:30:47 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1943.018;
	Fri, 31 May 2019 17:30:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PULL v2 3/3] blockdev: acquire aio_context for
	bitmap add/remove
Thread-Index: AQHUyUcV8RSjifrUx0ySegZzcJVcPaaGGpmA
Date: Fri, 31 May 2019 17:30:47 +0000
Message-ID: <c4cfb4f0-cc7b-3952-3c70-b498b2ec9847@virtuozzo.com>
References: <20190220180112.28250-1-jsnow@redhat.com>
	<20190220180112.28250-4-jsnow@redhat.com>
In-Reply-To: <20190220180112.28250-4-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0071.eurprd07.prod.outlook.com
	(2603:10a6:3:64::15) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190531203045069
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6ea9a10-e014-4853-d883-08d6e5edb7a8
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:AM0PR08MB3025; 
x-ms-traffictypediagnostic: AM0PR08MB3025:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR08MB3025136B3BA2C5EA4F01A998C1190@AM0PR08MB3025.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39850400004)(199004)(189003)(386003)(102836004)(26005)(36756003)(186003)(7736002)(6486002)(68736007)(8676002)(229853002)(2906002)(86362001)(305945005)(81156014)(6436002)(31686004)(966005)(476003)(6506007)(99286004)(76176011)(8936002)(52116002)(14454004)(53936002)(6512007)(6246003)(2616005)(446003)(66556008)(71200400001)(2501003)(6306002)(110136005)(11346002)(31696002)(4326008)(25786009)(486006)(3846002)(66066001)(71190400001)(66446008)(73956011)(64756008)(256004)(478600001)(66476007)(66946007)(5660300002)(316002)(6116002)(14444005)(81166006);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3025;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jW+8xTnIRKsYm9jce1k1nnAT9eRH2jQnvCm24UIe+2C4xBDK7JqGX5kbNBu/JRYHTRFBQSlfqjoibO9mzvfDMhKrlRc5ZCw2+s7W6oHhNEkXAQ+W38WHFxzOZltGYtkrtJTHyyjnoRgZrGyPRwI0fKdxPoVl6Yr9vtewxr3d6Lv1F5P/DCInIEZsoicdtZLzHe+zB8NYQBjArs15J/7CLsm9AxJqDOR2QXv0CmBoVPo4VySrHeOZQLo1JRUFeuztp3UKBc+bBvicAZvwJ9yPzi8G7tBz6FfdyhbU5XGmCQP3jBWjQYrMKk4DhiyPEMNIHOL7R0pOE0nBKr2gaLZGYbBL2C6WEF19cn0OAIPY+S7umdeJ2Uo9aiWj65SBjDekjgdNUYR9qm8kYx7uooGVAHJbcV3+C5NaaYmk0QlVZ9g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1895EE41F4D43488343707F0AFE7211@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ea9a10-e014-4853-d883-08d6e5edb7a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 17:30:47.4077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3025
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe02::728
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

SGkhDQoNCjIwLjAyLjIwMTkgMjE6MDEsIEpvaG4gU25vdyB3cm90ZToNCj4gV2hlbiBiaXRtYXBz
IGFyZSBwZXJzaXN0ZW50LCB0aGV5IG1heSBpbmN1ciBhIGRpc2sgcmVhZCBvciB3cml0ZSB3aGVu
IGJpdG1hcHMNCj4gYXJlIGFkZGVkIG9yIHJlbW92ZWQuIEZvciBjb25maWd1cmF0aW9ucyBsaWtl
IHZpcnRpby1kYXRhcGxhbmUsIGZhaWxpbmcgdG8NCj4gYWNxdWlyZSB0aGlzIGxvY2sgd2lsbCBh
Ym9ydCBRRU1VIHdoZW4gZGlzayBJTyBvY2N1cnMuDQo+IA0KPiBXZSB1c2VkIHRvIGFjcXVpcmUg
YWlvX2NvbnRleHQgYXMgcGFydCBvZiB0aGUgYml0bWFwIGxvb2t1cCwgc28gcmUtaW50cm9kdWNl
DQo+IHRoZSBsb2NrIGZvciBqdXN0IHRoZSBjYXNlcyB0aGF0IGhhdmUgYW4gSU8gcGVuYWx0eS4g
Q29tbWl0IDIxMTk4ODJjIHJlbW92ZWQNCj4gdGhlc2UgbG9ja3MsIGFuZCBJIGZhaWxlZCB0byBu
b3RpY2UgdGhpcyB3aGVuIHdlIGNvbW1pdHRlZCBmZDVhZTRjYywgc28gdGhpcw0KPiBoYXMgYmVl
biBicm9rZW4gc2luY2UgcGVyc2lzdGVudCBiaXRtYXBzIHdlcmUgaW50cm9kdWNlZC4NCj4gDQo+
IEZpeGVzOiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE2NzIw
MTANCj4gUmVwb3J0ZWQtQnk6IEFpaHVhIExpYW5nIDxhbGlhbmdAcmVkaGF0LmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KPiBSZXZpZXdlZC1ieTog
RXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+IE1lc3NhZ2UtaWQ6IDIwMTkwMjE4MjMz
MTU0LjE5MzAzLTEtanNub3dAcmVkaGF0LmNvbQ0KPiBTaWduZWQtb2ZmLWJ5OiBKb2huIFNub3cg
PGpzbm93QHJlZGhhdC5jb20+DQo+IC0tLQ0KDQpbLi5dDQoNCj4gICB2b2lkIHFtcF9ibG9ja19k
aXJ0eV9iaXRtYXBfcmVtb3ZlKGNvbnN0IGNoYXIgKm5vZGUsIGNvbnN0IGNoYXIgKm5hbWUsDQo+
IEBAIC0yODc4LDYgKzI4ODUsNyBAQCB2b2lkIHFtcF9ibG9ja19kaXJ0eV9iaXRtYXBfcmVtb3Zl
KGNvbnN0IGNoYXIgKm5vZGUsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ICAgICAgIEJsb2NrRHJpdmVy
U3RhdGUgKmJzOw0KPiAgICAgICBCZHJ2RGlydHlCaXRtYXAgKmJpdG1hcDsNCj4gICAgICAgRXJy
b3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+ICsgICAgQWlvQ29udGV4dCAqYWlvX2NvbnRleHQgPSBO
VUxMOw0KPiAgIA0KPiAgICAgICBiaXRtYXAgPSBibG9ja19kaXJ0eV9iaXRtYXBfbG9va3VwKG5v
ZGUsIG5hbWUsICZicywgZXJycCk7DQo+ICAgICAgIGlmICghYml0bWFwIHx8ICFicykgew0KPiBA
QCAtMjg5MiwxNCArMjkwMCwyMCBAQCB2b2lkIHFtcF9ibG9ja19kaXJ0eV9iaXRtYXBfcmVtb3Zl
KGNvbnN0IGNoYXIgKm5vZGUsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ICAgICAgIH0NCj4gICANCj4g
ICAgICAgaWYgKGJkcnZfZGlydHlfYml0bWFwX2dldF9wZXJzaXN0YW5jZShiaXRtYXApKSB7DQo+
ICsgICAgICAgIGFpb19jb250ZXh0ID0gYmRydl9nZXRfYWlvX2NvbnRleHQoYnMpOw0KPiArICAg
ICAgICBhaW9fY29udGV4dF9hY3F1aXJlKGFpb19jb250ZXh0KTsNCj4gICAgICAgICAgIGJkcnZf
cmVtb3ZlX3BlcnNpc3RlbnRfZGlydHlfYml0bWFwKGJzLCBuYW1lLCAmbG9jYWxfZXJyKTsNCj4g
ICAgICAgICAgIGlmIChsb2NhbF9lcnIgIT0gTlVMTCkgew0KPiAgICAgICAgICAgICAgIGVycm9y
X3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9lcnIpOw0KPiAtICAgICAgICAgICAgcmV0dXJuOw0KPiAr
ICAgICAgICAgICAgZ290byBvdXQ7DQo+ICAgICAgICAgICB9DQo+ICAgICAgIH0NCj4gICANCj4g
ICAgICAgYmRydl9yZWxlYXNlX2RpcnR5X2JpdG1hcChicywgYml0bWFwKTsNCj4gKyBvdXQ6DQo+
ICsgICAgaWYgKGFpb19jb250ZXh0KSB7DQo+ICsgICAgICAgIGFpb19jb250ZXh0X3JlbGVhc2Uo
YWlvX2NvbnRleHQpOw0KPiArICAgIH0NCj4gICB9DQo+ICAgDQo+ICAgLyoqDQo+IA0KDQpBIGJp
dCBsYXRlLCBidXQgSSBoYXZlIGEgcXVlc3Rpb246DQoNCldoeSBkaWQgeW91IGluY2x1ZGUgYmRy
dl9yZWxlYXNlX2RpcnR5X2JpdG1hcCBjYWxsIGludG8gY29udGV4dC1hY3F1aXJlZCBzZWN0aW9u
PyBBcyBJIGNhbg0KdW5kZXJzdGFuZCBmcm9tIGNvbW1pdCBtZXNzYWdlLCBpdCdzIG5vdCBhY3R1
YWxseSBuZWVkZWQ/DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

