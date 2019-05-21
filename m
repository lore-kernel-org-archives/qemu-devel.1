Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD085C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7268D2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FwtnuJTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7268D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1Uj-0003yL-Ob
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 05:55:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hT1Tk-0003Xs-0F
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hT1Ti-0000wx-Ey
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:54:39 -0400
Received: from mail-eopbgr130129.outbound.protection.outlook.com
	([40.107.13.129]:44194
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hT1Th-0000uj-Le; Tue, 21 May 2019 05:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=SWyt5H9GfCeGfMsoR9P6M8jMjw0jRFW64Kh7u+lmd/I=;
	b=FwtnuJTf4XOaPRD9pUNlWSpsxuhq6sSfayUweVuEuQFnr11g+X7pthEUZIklQ/bz1Y5xVIVPa7Rsq+5JTuay2PgFUmMIzAud2vVix/BkguiIt2vN3loTw2bL+W1nuUDN+8XdPkKsv48inPxwRV7CXNtIydZ5pXlz8wqgjtg8pyk=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB4325.eurprd08.prod.outlook.com (20.179.6.10) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.15; Tue, 21 May 2019 09:54:34 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Tue, 21 May 2019 09:54:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH] blockdev: loosen restrictions on
	drive-backup source node
Thread-Index: AQHVB3U8T8N/CtvASkibFN88EMNUT6Z0qomAgAC864A=
Date: Tue, 21 May 2019 09:54:34 +0000
Message-ID: <e6dae5b3-8ad4-df6b-e280-08202c61e61d@virtuozzo.com>
References: <20190510211119.29376-1-jsnow@redhat.com>
	<fc38cdc4-dc42-d476-6a27-bcb85adafb7d@redhat.com>
In-Reply-To: <fc38cdc4-dc42-d476-6a27-bcb85adafb7d@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0022.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::32)
	To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190521125431856
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 546edf89-0318-4e35-2c4b-08d6ddd253ca
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB4325; 
x-ms-traffictypediagnostic: AM6PR08MB4325:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR08MB4325AB171DFB3DF26B990700C1070@AM6PR08MB4325.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(376002)(136003)(396003)(39850400004)(189003)(199004)(2201001)(71190400001)(81156014)(81166006)(71200400001)(305945005)(6246003)(6116002)(3846002)(86362001)(31696002)(7736002)(316002)(4326008)(25786009)(8676002)(256004)(8936002)(36756003)(26005)(14444005)(5660300002)(186003)(68736007)(6512007)(6306002)(6486002)(6436002)(229853002)(66446008)(446003)(31686004)(2616005)(476003)(11346002)(53936002)(64756008)(73956011)(66066001)(2501003)(66476007)(66946007)(486006)(386003)(53546011)(6506007)(54906003)(2906002)(102836004)(14454004)(76176011)(478600001)(99286004)(52116002)(966005)(66556008)(110136005);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4325;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qJuN0O7df5sydWmpwvxYDxKkgtiVx11hCCypP9U6Dmlstjhpc57cSvbD2OBp4QhK20Q63CL7Y3pnwCkg+KsY/gAWBH5pQtJGbxDSFPcmLg+OkZJ1kIN4W/zCIBTdZZSTouocbAGHZAOCOJFkliTkha9bkibbvQtD/SqSwKp9PbI2HDzrNZ1ZLqcXUmAIfi3Dm2kUuCcbhY/ueaMnTZUAcBvzoCNTIym1mn17Gh48joY8H9U3UyOESfiBoho8lO3X+n/ysAvID6eYa4/JY8nXEdiii1tylM5A7JeEQjMjC/zLDF98WA63W5SsPjYQKJ+N5l6CijsW4EyDNylLbr9gCF6CO9ucEFkWaRSMfGev4g3yX9ZF3cIrduMH30U5+jOdOL/VUL+CuZyK5ITk9KSxw6jH/1yoGWRcluKg0OME3nE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01BCDD340347E8478B00D9F8B81B7E7D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546edf89-0318-4e35-2c4b-08d6ddd253ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 09:54:34.1091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4325
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.129
Subject: Re: [Qemu-devel] [PATCH] blockdev: loosen restrictions on
 drive-backup source node
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjEuMDUuMjAxOSAxOjM4LCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gNS8xMC8xOSA1
OjExIFBNLCBKb2huIFNub3cgd3JvdGU6DQo+PiBXZSBtYW5kYXRlIHRoYXQgdGhlIHNvdXJjZSBu
b2RlIG11c3QgYmUgYSByb290IG5vZGU7IGJ1dCB0aGVyZSdzIG5vIHJlYXNvbg0KPj4gSSBhbSBh
d2FyZSBvZiB0aGF0IGl0IG5lZWRzIHRvIGJlIHJlc3RyaWN0ZWQgdG8gc3VjaC4gSW4gc29tZSBj
YXNlcywgd2UgbmVlZA0KPj4gdG8gbWFrZSBzdXJlIHRoYXQgdGhlcmUncyBhIG1lZGl1bSBwcmVz
ZW50LCBidXQgaW4gdGhlIGdlbmVyYWwgY2FzZSB3ZSBjYW4NCj4+IGFsbG93IHRoZSBiYWNrdXAg
am9iIGl0c2VsZiB0byBkbyB0aGUgZ3JhcGggY2hlY2tpbmcuDQo+Pg0KPj4gVGhpcyBwYXRjaCBo
ZWxwcyBpbXByb3ZlIHRoZSBlcnJvciBtZXNzYWdlIHdoZW4geW91IHRyeSB0byBiYWNrdXAgZnJv
bQ0KPj4gdGhlIHNhbWUgbm9kZSBtb3JlIHRoYW4gb25jZSwgd2hpY2ggaXMgcmVmbGVjdGVkIGlu
IHRoZSBjaGFuZ2UgdG8gdGVzdA0KPj4gMDU2Lg0KPj4NCj4+IEZvciBiYWNrdXBzIHdpdGggYml0
bWFwcywgaXQgd2lsbCBhbHNvIHNob3cgYSBiZXR0ZXIgZXJyb3IgbWVzc2FnZSB0aGF0DQo+PiB0
aGUgYml0bWFwIGlzIGluIHVzZSBpbnN0ZWFkIG9mIGdpdmluZyB5b3Ugc29tZXRoaW5nIGNyeXB0
aWMgbGlrZSAibmVlZA0KPj4gYSByb290IG5vZGUuIg0KPj4NCj4+IEZpeGVzOiBodHRwczovL2J1
Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE3MDczMDMNCj4+IFNpZ25lZC1vZmYt
Ynk6IEpvaG4gU25vdyA8anNub3dAcmVkaGF0LmNvbT4NCj4+IC0tLQ0KPj4gICBibG9ja2Rldi5j
ICAgICAgICAgICAgIHwgNiArKysrKy0NCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzA1NiB8IDIg
Ky0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrZGV2LmMgYi9ibG9ja2Rldi5jDQo+PiBpbmRleCA3
OWZiYWM4NDUwLi4yN2NiNzJmN2FhIDEwMDY0NA0KPj4gLS0tIGEvYmxvY2tkZXYuYw0KPj4gKysr
IGIvYmxvY2tkZXYuYw0KPj4gQEAgLTM0NTAsNyArMzQ1MCw3IEBAIHN0YXRpYyBCbG9ja0pvYiAq
ZG9fZHJpdmVfYmFja3VwKERyaXZlQmFja3VwICpiYWNrdXAsIEpvYlR4biAqdHhuLA0KPj4gICAg
ICAgICAgIGJhY2t1cC0+Y29tcHJlc3MgPSBmYWxzZTsNCj4+ICAgICAgIH0NCj4+ICAgDQo+PiAt
ICAgIGJzID0gcW1wX2dldF9yb290X2JzKGJhY2t1cC0+ZGV2aWNlLCBlcnJwKTsNCj4+ICsgICAg
YnMgPSBiZHJ2X2xvb2t1cF9icyhiYWNrdXAtPmRldmljZSwgYmFja3VwLT5kZXZpY2UsIGVycnAp
Ow0KPj4gICAgICAgaWYgKCFicykgew0KPj4gICAgICAgICAgIHJldHVybiBOVUxMOw0KPj4gICAg
ICAgfQ0KPj4gQEAgLTM0NTksNiArMzQ1OSwxMCBAQCBzdGF0aWMgQmxvY2tKb2IgKmRvX2RyaXZl
X2JhY2t1cChEcml2ZUJhY2t1cCAqYmFja3VwLCBKb2JUeG4gKnR4biwNCj4+ICAgICAgIGFpb19j
b250ZXh0X2FjcXVpcmUoYWlvX2NvbnRleHQpOw0KPj4gICANCj4+ICAgICAgIGlmICghYmFja3Vw
LT5oYXNfZm9ybWF0KSB7DQo+PiArICAgICAgICBpZiAoIWJzLT5kcnYpIHsNCj4+ICsgICAgICAg
ICAgICBlcnJvcl9zZXRnKGVycnAsICJEZXZpY2UgaGFzIG5vIG1lZGl1bSIpOw0KPj4gKyAgICAg
ICAgICAgIHJldHVybiBOVUxMOw0KPj4gKyAgICAgICAgfQ0KPiANCj4gUGluZ2luZyBteSBvd24g
cGF0Y2ggd2l0aCBhIHJldmlldyBjb21tZW50LiBJdCBpcyB3ZWlyZCB0aGF0IEkgc2h1ZmZsZWQN
Cj4gdGhlIGVycm9yIGNoZWNraW5nIGRvd24gYmVsb3cgYSBjb25kaXRpb25hbCwgYnV0IGl0J3Mg
dGhlIG9ubHkgY2FzZQ0KPiB3aGVyZSB3ZSBkaXJlY3RseSBuZWVkIGRvIGFjY2VzcyBicy0+ZHJ2
IG5vdy4NCg0Kbm90IHRoZSBvbmx5OiBpdCdzIGFjY2Vzc2VkIGluIGZvbGxvd2luZw0KICAgICBp
ZiAoYmFja3VwLT5tb2RlICE9IE5FV19JTUFHRV9NT0RFX0VYSVNUSU5HKSB7DQogICAgICAgICBh
c3NlcnQoYmFja3VwLT5mb3JtYXQpOw0KICAgICAgICAgaWYgKHNvdXJjZSkgew0KYXMgd2VsbC4N
Cg0KPiANCj4gT3RoZXJ3aXNlLCBibG9jay9iYWNrdXAgYWxyZWFkeSBjaGVja3MgZm9yIHRoaXMg
aW4gaXRzIG93biByb3V0aW5lIGFuZCBJDQo+IGZlbHQgbGlrZSBpdCB3YXMgYmVzdCB0byBsZXQg
dGhlIGpvYiBoYW5kbGUgaWYgaXQgaGFkIHRoZSByaWdodCB0eXBlIG9mDQo+IGFyZ3VtZW50cyBp
bnN0ZWFkIG9mIHNwbGl0dGluZyB0aGF0IG91dCB1cCBoZXJlLg0KPiANCj4gU3RpbGwsIGl0IHBy
b2JhYmx5IGxvb2tzIHdlaXJkIHRvIHNlZSB0aGUgIkRldmljZSBoYXMgbm8gbWVkaXVtIiBlcnJv
cg0KPiBpbiBhIGNvbmRpdGlvbmFsIGhlcmUsIHNvIGlmIHRoaXMgcGF0Y2ggbG9va3Mgb2theSBv
dGhlcndpc2UsIEkgY2FuIHNlbmQNCj4gYSB2MiB3aXRoIHRoYXQgZXJyb3IgY2hlY2tpbmcgc2h1
ZmZsZWQgYmFjayB1cCB0byB0b3AtbGV2ZWwgdG8gbWFpbnRhaW4NCj4gc29tZSBjb25zaXN0ZW5j
eSB3aXRoIGhvdyB0aGUgZXJyb3IgY2hlY2tpbmcgdXNlZCB0byBiZSBoYW5kbGVkLg0KPiANCj4+
ICAgICAgICAgICBiYWNrdXAtPmZvcm1hdCA9IGJhY2t1cC0+bW9kZSA9PSBORVdfSU1BR0VfTU9E
RV9FWElTVElORyA/DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMIDogKGNoYXIq
KSBicy0+ZHJ2LT5mb3JtYXRfbmFtZTsNCj4+ICAgICAgIH0NCj4+IGRpZmYgLS1naXQgYS90ZXN0
cy9xZW11LWlvdGVzdHMvMDU2IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzA1Ng0KPj4gaW5kZXggM2Rm
MzIzOTg0ZC4uZjQwZmMxMWEwOSAxMDA3NTUNCj4+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8w
NTYNCj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNTYNCj4+IEBAIC0yMTQsNyArMjE0LDcg
QEAgY2xhc3MgQmFja3VwVGVzdChpb3Rlc3RzLlFNUFRlc3RDYXNlKToNCj4+ICAgICAgICAgICBy
ZXMgPSBzZWxmLnZtLnFtcCgncXVlcnktYmxvY2stam9icycpDQo+PiAgICAgICAgICAgc2VsZi5h
c3NlcnRfcW1wKHJlcywgJ3JldHVyblswXS9zdGF0dXMnLCAnY29uY2x1ZGVkJykNCj4+ICAgICAg
ICAgICAjIExlYXZlIHpvbWJpZSBqb2IgdW4tZGlzbWlzc2VkLCBvYnNlcnZlIGEgZmFpbHVyZToN
Cj4+IC0gICAgICAgIHJlcyA9IHNlbGYucW1wX2JhY2t1cF9hbmRfd2FpdChzZXJyb3I9J05lZWQg
YSByb290IGJsb2NrIG5vZGUnLA0KPj4gKyAgICAgICAgcmVzID0gc2VsZi5xbXBfYmFja3VwX2Fu
ZF93YWl0KHNlcnJvcj0iTm9kZSAnZHJpdmUwJyBpcyBidXN5OiBibG9jayBkZXZpY2UgaXMgaW4g
dXNlIGJ5IGJsb2NrIGpvYjogYmFja3VwIiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZGV2aWNlPSdkcml2ZTAnLCBmb3JtYXQ9aW90ZXN0cy5pbWdmbXQsDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN5bmM9J2Z1bGwnLCB0
YXJnZXQ9c2VsZi5kZXN0X2ltZywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYXV0b19kaXNtaXNzPUZhbHNlKQ0KPj4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K

