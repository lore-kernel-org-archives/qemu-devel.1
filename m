Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A54C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0027F20866
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TAFR1BVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0027F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47629 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYZje-0004Wi-6f
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 13:30:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYZiF-0003fu-BR
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYZiC-0002Te-Bn
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:28:35 -0400
Received: from mail-eopbgr40126.outbound.protection.outlook.com
	([40.107.4.126]:17126
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYZhu-0001uP-1c; Wed, 05 Jun 2019 13:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=54mcsB7maQ2xm7w9OOpyc/v5oyrOe+n16yYEnXXs4Yw=;
	b=TAFR1BVtAa8cY4EcfQsetifHpy3VJi/5r3pFoCQ7xtcmeaH1G1486mfZBarXQmHOWR2AuY3TjJZ1Xo8+dV2R83D4ZDH/jbFjCMmLOEd3tebu9bKv7gey8n1mMpclyLgHn0tArHF22XkuRfw59GgjCsOSOai4XwYIpqPiwYuoSL8=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB3202.eurprd08.prod.outlook.com (52.134.90.13) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.12; Wed, 5 Jun 2019 17:28:06 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011;
	Wed, 5 Jun 2019 17:28:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
	<berrange@redhat.com>
Thread-Topic: [PATCH 2/2] nbd-client: enable TCP keepalive
Thread-Index: AQHVG4a+gcethstE402cAbEv20QdEaaNIdEAgAAg+ACAADo6AP//z8UAgAAEOYA=
Date: Wed, 5 Jun 2019 17:28:05 +0000
Message-ID: <c0df2189-d90a-8a58-776b-646bbad76976@virtuozzo.com>
References: <20190605100913.34972-1-vsementsov@virtuozzo.com>
	<20190605100913.34972-3-vsementsov@virtuozzo.com>
	<cd780b66-ab31-1feb-0cce-0b6525df7d79@redhat.com>
	<20190605163710.GP8956@redhat.com>
	<e5a35aeb-21a4-449c-f8d5-9d2ac2968fd5@virtuozzo.com>
	<19a96fc2-7f12-7b30-edef-b3da66eef759@redhat.com>
In-Reply-To: <19a96fc2-7f12-7b30-edef-b3da66eef759@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0013.eurprd07.prod.outlook.com
	(2603:10a6:7:67::23) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190605202803852
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: febf0976-a238-49d3-aaa3-08d6e9db2b93
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB3202; 
x-ms-traffictypediagnostic: AM0PR08MB3202:
x-microsoft-antispam-prvs: <AM0PR08MB3202F3E58793AE0E2ADE555FC1160@AM0PR08MB3202.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(39850400004)(346002)(136003)(366004)(376002)(199004)(189003)(6512007)(305945005)(7736002)(25786009)(36756003)(6486002)(6436002)(256004)(316002)(4326008)(478600001)(66066001)(229853002)(2906002)(6116002)(68736007)(86362001)(6506007)(386003)(486006)(8936002)(31686004)(110136005)(2616005)(107886003)(3846002)(11346002)(476003)(102836004)(14454004)(31696002)(5660300002)(446003)(186003)(54906003)(73956011)(71190400001)(76176011)(6246003)(66476007)(66556008)(66446008)(64756008)(52116002)(53936002)(99286004)(8676002)(26005)(66946007)(71200400001)(53546011)(81166006)(81156014);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3202;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1MwhQDKI4AN7tlKasaySJbaV/RqgWuWopRhGWiA1cn48v1fffyp31pXEEZNtxoAAiao+YdcsVZ8MMndPMHj9IDkQbgC039+iXXtvM9DgLXiS3F2v2LBbB5llJ6xY2rbQCEfgbqRT45LbYG/eygIRfk4ex1sHrbuRzC8mFHOBHmq0Oti/8OagvvrOm8rZ82EDgwLhfwQam9U4CmigLDrCUgiZYSZ9/ZKo77NPCFBySSfxHxFu8g8EeIz7uRjN0hsakqo33NTh/TedPCm1JL+0ngy1P3+pUPTX6HKe4iy89TjPQZoGLRa7F52m6CGpEUSjRv4oXMYsKjq41hbQYKlugS2OO+L1HkaiGu8neGSPZOZxD8LwfNmL2aIspMpEYjMi44cHP+I7FE8HR2K6FdWH1M76fQMKp53W7qi+97vqeds=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A48520A2F9DB1479807054A5CC3CBE7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febf0976-a238-49d3-aaa3-08d6e9db2b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 17:28:05.9680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3202
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.126
Subject: Re: [Qemu-devel] [PATCH 2/2] nbd-client: enable TCP keepalive
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDUuMDYuMjAxOSAyMDoxMiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gNi81LzE5IDEyOjA1IFBN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPiANCj4+PiBCeSBlbmFibGlu
ZyBUQ1Aga2VlcGFsaXZlcyB3ZSBhcmUgZXhwbGljaXRseSBtYWtpbmcgdGhlIGNvbm5lY3Rpb24N
Cj4+PiBsZXNzIHJlbGlhYmxlIGJ5IGZvcmNpbmcgaXQgdG8gYmUgdGVybWluYXRlZCB3aGVuIGtl
ZXBhbGl2ZQ0KPj4+IHRocmVzaG9sZCB0cmlnZ2VycywgaW5zdGVhZCBvZiB3YWl0aW5nIGxvbmdl
ciBmb3IgVENQIHRvIHJlY292ZXIuDQo+Pj4NCj4+PiBUaGUgcmF0aW9uYWxlIHMgdGhhdCBvbmNl
IGEgY29ubmVjdGlvbiBoYXMgYmVlbiBpbiBhIGh1bmcgc3RhdGUgZm9yDQo+Pj4gc28gbG9uZyB0
aGF0IGtlZXBhbGl2ZSB0cmlnZ2VycywgaXRzIChob3BlZnVsbHkpIG5vdCB1c2VmdWwgdG8gdGhl
DQo+Pj4gbWdtdCBhcHAgdG8gY2Fycnkgb24gd2FpdGluZyBhbnl3YXkuDQo+Pj4NCj4+PiBJZiB0
aGUgY29ubmVjdGlvbiBpcyB0ZXJtaW5hdGVkIGJ5IGtlZXBhbGl2ZSAmIHRoZSBtZ210IGFwcCB0
aGVuDQo+Pj4gc3Bhd25zIGEgbmV3IGNsaWVudCB0byBjYXJyeSBvbiB3aXRoIHRoZSB3b3JrLCB3
aGF0IGFyZSB0aGUgcmlza3MNCj4+PiBpbnZvbHZlZCA/IGVnIENvdWxkIHBhY2tldHMgZnJvbSB0
aGUgc3R1Y2ssIHRlcm1pbmF0ZWQsIGNvbm5lY3Rpb24NCj4+PiBzdWRkZW5seSBhcnJpdmUgbGF0
ZXIgYW5kIHRyaWdnZXIgSS9PIHdpdGggb3V0ZGF0ZWQgZGF0YSBwYXlsb2FkID8NCj4+DQo+PiBI
bW0sIEkgYmVsaWV2ZSB0aGF0IHRjcCBndWFyYW50ZWVzIGlzb2xhdGlvbiBiZXR3ZWVuIGRpZmZl
cmVudCBjb25uZWN0aW9ucw0KPj4NCj4+Pg0KPj4+IEkgZ3Vlc3MgdGhpcyBpcyBubyBkaWZmZXJl
bnQgYSBzaXR1YXRpb24gZnJvbSBhbiBhcHAgZXhwbGljaXRseQ0KPj4+IGtpbGxpbmcgdGhlIFFF
TVUgTkJEIGNsaWVudCBwcm9jZXNzIGluc3RlYWQgJiBzcGF3bmluZyBhIG5ldyBvbmUuDQo+Pj4N
Cj4+PiBJJ20gc3RpbGwgZmVlbGluZyBhIGxpdHRsZSB1bmVhc3kgYWJvdXQgZW5hYmxpbmcgaXQg
dW5jb25kaXRpb25hbGx5DQo+Pj4gdGhvdWdoLCBzaW5jZSBwcmV0dHkgbXVjaCBldmVyeXRoaW5n
IEkga25vdyB3aGljaCBzdXBwb3J0cyBrZWVwYWxpdmVzDQo+Pj4gaGFzIGEgd2F5IHRvIHR1cm4g
dGhlbSBvbi9vZmYgYXQgbGVhc3QsIGV2ZW4gaWYgeW91IGNhbid0IHR1bmUgdGhlDQo+Pj4gaW5k
aXZpZHVhbCB0aW1lciBzZXR0aW5ncy4NCj4+DQo+PiBIbS4gU28sIEkgY2FuIGFkZCBib29sIGtl
ZXBhbGl2ZSBwYXJhbWV0ZXIgZm9yIG5iZCBmb3JtYXQgd2l0aCBkZWZhdWx0IHRvIHRydWUuDQo+
PiBBbmQgaWYgbmVlZGVkLCBpdCBtYXkgYmUgbGF0ZXIgZXh0ZW5kZWQgdG8gYmUgcWFwaSAnYWx0
ZXJuYXRlJyBvZiBib29sIG9yIHN0cnVjdCB3aXRoDQo+PiB0aHJlZSBudW1lcmljIHBhcmFtZXRl
cnMsIGNvcnJlc3BvbmRpbmcgdG8gVENQX0tFRVBDTlQsIFRDUF9LRUVQSURMRSBhbmQgVENQX0tF
RVBJTlRWTCAuDQo+Pg0KPj4gT3BpbmlvbnM/DQo+IA0KPiBBZGRpbmcgYSBib29sIHRoYXQgY291
bGQgbGF0ZXIgdHVybiBpbnRvIGEgcWFwaSAnYWx0ZXJuYXRlJyBmb3INCj4gZmluZS10dW5pbmcg
c2VlbXMgcmVhc29uYWJsZS4gRGVmYXVsdGluZyB0aGUgYm9vbCB0byB0cnVlIGlzIG5vdA0KPiBi
YWNrd2FyZHMtY29tcGF0aWJsZTsgYmV0dGVyIHdvdWxkIGJlIGRlZmF1bHRpbmcgaXQgdG8gZmFs
c2UgYW5kIGxldHRpbmcNCj4gdXNlcnMgb3B0LWluOyBpbnRyb3NwZWN0aW9uIHdpbGwgYWxzbyB3
b3JrIHRvIGxldCB5b3Uga25vdyB3aGV0aGVyIHRoZQ0KPiBmZWF0dXJlIGlzIHByZXNlbnQuDQo+
IA0KDQpPay4NCg0KT25lIG1vcmUgdGhpbmcgdG8gZGlzY3VzcyB0aGVuLiBTaG91bGQgSSBhZGQg
a2VlcGFsaXZlIGRpcmVjdGx5IHRvIEJsb2NrZGV2T3B0aW9uc05iZD8NCg0KU2VlbXMgbW9yZSB1
c2VmdWwgdG8gcHV0IGl0IGludG8gU29ja2V0QWRkcmVzcywgdG8gYmUgcmV1c2VkIGJ5IG90aGVy
IHNvY2tldCB1c2Vycy4uDQpCdXQgIlNvY2tldEFkZHJlc3MiIHNvdW5kcyBsaWtlIGFkZHJlc3Ms
IG5vdCBsaWtlIGFkZHJlc3MrY29ubmVjdGlvbi1vcHRpb25zLiBPbg0KdGhlIG90aGVyIGhhbmQs
IHN0cnVjdHVyZSBuYW1lcyBhcmUgbm90IHBhcnQgb2YgQVBJLiBTbywgZmluYWxseSwgaXMgSW5l
dFNvY2tldEFkZHJlc3MNCmEgZ29vZCBwbGFjZSBmb3Igc3VjaCB0aGluZz8NCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

