Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1113BC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0563206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EBn/dysT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0563206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46987 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYZNZ-000676-VZ
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 13:07:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYZMV-0005Mi-Rb
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYZMT-0005Pi-Q5
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:06:07 -0400
Received: from mail-eopbgr140127.outbound.protection.outlook.com
	([40.107.14.127]:63748
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYZMO-000567-EH; Wed, 05 Jun 2019 13:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=cxWDPzQr73eJLTTNdRQf+uHFJQQPUW4WtsTgoJ835+0=;
	b=EBn/dysTW6SfCkZCe/ru76hbZIWfQXbXAurKU7qg/RIR11tpFnVvswJBDFEVwqhP1NGwpb6Qr8i7IhZkC4gVdDffFYdcz66qLQVcjyhnwog8OvHUzZUAP1u5P7Sb4hDeqBZ6ZNU+yjVBxc2v0qWPrrciVUi33sLWQFaWs3TH4L8=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB4050.eurprd08.prod.outlook.com (20.178.118.203) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Wed, 5 Jun 2019 17:05:37 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011;
	Wed, 5 Jun 2019 17:05:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Eric Blake
	<eblake@redhat.com>
Thread-Topic: [PATCH 2/2] nbd-client: enable TCP keepalive
Thread-Index: AQHVG4a+gcethstE402cAbEv20QdEaaNIdEAgAAg+ACAAAfwAA==
Date: Wed, 5 Jun 2019 17:05:37 +0000
Message-ID: <e5a35aeb-21a4-449c-f8d5-9d2ac2968fd5@virtuozzo.com>
References: <20190605100913.34972-1-vsementsov@virtuozzo.com>
	<20190605100913.34972-3-vsementsov@virtuozzo.com>
	<cd780b66-ab31-1feb-0cce-0b6525df7d79@redhat.com>
	<20190605163710.GP8956@redhat.com>
In-Reply-To: <20190605163710.GP8956@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0067.eurprd07.prod.outlook.com
	(2603:10a6:3:64::11) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190605200534850
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e155a169-8ed3-4125-7b18-08d6e9d807c0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB4050; 
x-ms-traffictypediagnostic: AM0PR08MB4050:
x-microsoft-antispam-prvs: <AM0PR08MB405050D4807E3073F1835572C1160@AM0PR08MB4050.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(396003)(136003)(376002)(39850400004)(346002)(189003)(199004)(305945005)(7736002)(36756003)(6436002)(25786009)(52116002)(110136005)(5660300002)(76176011)(64756008)(54906003)(229853002)(53936002)(6512007)(66556008)(6486002)(186003)(66446008)(4326008)(66476007)(107886003)(478600001)(6246003)(73956011)(14454004)(31686004)(476003)(99286004)(6506007)(66946007)(71200400001)(2906002)(316002)(66066001)(86362001)(53546011)(81166006)(446003)(6116002)(8936002)(26005)(3846002)(486006)(81156014)(102836004)(68736007)(2616005)(31696002)(8676002)(11346002)(14444005)(256004)(71190400001)(386003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4050;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3VVc29fOprQZ0HngCTg9AxPhmu/peojZ+b/A/fDEyjEYngiIIyKojn3nXGqwRgQSHSD0zN47EWA0eUba/BVD5EEIMO4SATd9sUUAVgLQu0GdSpA0Ej7tKpXUFgCyx33536+sKBn2moiulbn3RRZx6B7zWQE22rERY+DAPug0b/5AYayE4OsBdTggYzOGtAjaz6GrXii3PtK4jSKiq21Zovt9q/wQRknTPl1NYgqqJnSsk7Bqtsy6unMlVAPhWXylSUfkJitBZLPRQG/18PoG2eYcSdcePHm3/c2nzHeMqSDWyRRAPD/7/ciAnQ1EyzI0VSQmPlF0hnM6scyxXSF3mWpe3CgGZkFMoaGUCLQUnVMBvqlmAOxrSlE8qrJua+X2frDeqzqN8gIU5v6JV5aI2aoEwFWposVpa64my5LI/EE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <906D7F03DE02094DBBA891E06C99CF7C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e155a169-8ed3-4125-7b18-08d6e9d807c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 17:05:37.4105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.127
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

MDUuMDYuMjAxOSAxOTozNywgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24gV2VkLCBK
dW4gMDUsIDIwMTkgYXQgMDk6Mzk6MTBBTSAtMDUwMCwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IE9u
IDYvNS8xOSA1OjA5IEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4+
IEVuYWJsZSBrZWVwYWxpdmUgb3B0aW9uIHRvIHRyYWNrIHNlcnZlciBhdmFpbGFibGl0eS4NCj4+
DQo+PiBzL2F2YWlsYWJsaXR5L2F2YWlsYWJpbGl0eS8NCj4+DQo+PiBEbyB3ZSB3YW50IHRoaXMg
dW5jb25kaXRpb25hbGx5LCBvciBzaG91bGQgaXQgYmUgYW4gb3B0aW9uIChhbmQgaGVuY2UNCj4+
IGV4cG9zZWQgb3ZlciBRTVApPw0KPiANCj4gSSBndWVzcyB0aGlzIGlzIHJlYWxseSBhIHF1ZXN0
aW9uIGFib3V0IHdoYXQgb3VyIGludGVuZGVkIGNvbm5lY3Rpb24NCj4gcmVsaWFiaWxpdHkgcG9s
aWN5IHNob3VsZCBiZS4NCj4gDQo+IEJ5IGVuYWJsaW5nIFRDUCBrZWVwYWxpdmVzIHdlIGFyZSBl
eHBsaWNpdGx5IG1ha2luZyB0aGUgY29ubmVjdGlvbg0KPiBsZXNzIHJlbGlhYmxlIGJ5IGZvcmNp
bmcgaXQgdG8gYmUgdGVybWluYXRlZCB3aGVuIGtlZXBhbGl2ZQ0KPiB0aHJlc2hvbGQgdHJpZ2dl
cnMsIGluc3RlYWQgb2Ygd2FpdGluZyBsb25nZXIgZm9yIFRDUCB0byByZWNvdmVyLg0KPiANCj4g
VGhlIHJhdGlvbmFsZSBzIHRoYXQgb25jZSBhIGNvbm5lY3Rpb24gaGFzIGJlZW4gaW4gYSBodW5n
IHN0YXRlIGZvcg0KPiBzbyBsb25nIHRoYXQga2VlcGFsaXZlIHRyaWdnZXJzLCBpdHMgKGhvcGVm
dWxseSkgbm90IHVzZWZ1bCB0byB0aGUNCj4gbWdtdCBhcHAgdG8gY2Fycnkgb24gd2FpdGluZyBh
bnl3YXkuDQo+IA0KPiBJZiB0aGUgY29ubmVjdGlvbiBpcyB0ZXJtaW5hdGVkIGJ5IGtlZXBhbGl2
ZSAmIHRoZSBtZ210IGFwcCB0aGVuDQo+IHNwYXducyBhIG5ldyBjbGllbnQgdG8gY2Fycnkgb24g
d2l0aCB0aGUgd29yaywgd2hhdCBhcmUgdGhlIHJpc2tzDQo+IGludm9sdmVkID8gZWcgQ291bGQg
cGFja2V0cyBmcm9tIHRoZSBzdHVjaywgdGVybWluYXRlZCwgY29ubmVjdGlvbg0KPiBzdWRkZW5s
eSBhcnJpdmUgbGF0ZXIgYW5kIHRyaWdnZXIgSS9PIHdpdGggb3V0ZGF0ZWQgZGF0YSBwYXlsb2Fk
ID8NCg0KSG1tLCBJIGJlbGlldmUgdGhhdCB0Y3AgZ3VhcmFudGVlcyBpc29sYXRpb24gYmV0d2Vl
biBkaWZmZXJlbnQgY29ubmVjdGlvbnMNCg0KPiANCj4gSSBndWVzcyB0aGlzIGlzIG5vIGRpZmZl
cmVudCBhIHNpdHVhdGlvbiBmcm9tIGFuIGFwcCBleHBsaWNpdGx5DQo+IGtpbGxpbmcgdGhlIFFF
TVUgTkJEIGNsaWVudCBwcm9jZXNzIGluc3RlYWQgJiBzcGF3bmluZyBhIG5ldyBvbmUuDQo+IA0K
PiBJJ20gc3RpbGwgZmVlbGluZyBhIGxpdHRsZSB1bmVhc3kgYWJvdXQgZW5hYmxpbmcgaXQgdW5j
b25kaXRpb25hbGx5DQo+IHRob3VnaCwgc2luY2UgcHJldHR5IG11Y2ggZXZlcnl0aGluZyBJIGtu
b3cgd2hpY2ggc3VwcG9ydHMga2VlcGFsaXZlcw0KPiBoYXMgYSB3YXkgdG8gdHVybiB0aGVtIG9u
L29mZiBhdCBsZWFzdCwgZXZlbiBpZiB5b3UgY2FuJ3QgdHVuZSB0aGUNCj4gaW5kaXZpZHVhbCB0
aW1lciBzZXR0aW5ncy4NCg0KSG0uIFNvLCBJIGNhbiBhZGQgYm9vbCBrZWVwYWxpdmUgcGFyYW1l
dGVyIGZvciBuYmQgZm9ybWF0IHdpdGggZGVmYXVsdCB0byB0cnVlLg0KQW5kIGlmIG5lZWRlZCwg
aXQgbWF5IGJlIGxhdGVyIGV4dGVuZGVkIHRvIGJlIHFhcGkgJ2FsdGVybmF0ZScgb2YgYm9vbCBv
ciBzdHJ1Y3Qgd2l0aA0KdGhyZWUgbnVtZXJpYyBwYXJhbWV0ZXJzLCBjb3JyZXNwb25kaW5nIHRv
IFRDUF9LRUVQQ05ULCBUQ1BfS0VFUElETEUgYW5kIFRDUF9LRUVQSU5UVkwgLg0KDQpPcGluaW9u
cz8NCg0KDQo+IA0KPj4+IFJlcXVlc3RlZC1ieTogRGVuaXMgVi4gTHVuZXYgPGRlbkBvcGVudnou
b3JnPg0KPj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZz
ZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+PiAtLS0NCj4+PiAgIGJsb2NrL25iZC1jbGllbnQu
YyB8IDEgKw0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pj4NCj4+PiBk
aWZmIC0tZ2l0IGEvYmxvY2svbmJkLWNsaWVudC5jIGIvYmxvY2svbmJkLWNsaWVudC5jDQo+Pj4g
aW5kZXggNzkwZWNjMWVlMS4uYjU3Y2VhODQ4MiAxMDA2NDQNCj4+PiAtLS0gYS9ibG9jay9uYmQt
Y2xpZW50LmMNCj4+PiArKysgYi9ibG9jay9uYmQtY2xpZW50LmMNCj4+PiBAQCAtMTEzNyw2ICsx
MTM3LDcgQEAgc3RhdGljIGludCBuYmRfY2xpZW50X2Nvbm5lY3QoQmxvY2tEcml2ZXJTdGF0ZSAq
YnMsDQo+Pj4gICANCj4+PiAgICAgICAvKiBOQkQgaGFuZHNoYWtlICovDQo+Pj4gICAgICAgbG9n
b3V0KCJzZXNzaW9uIGluaXQgJXNcbiIsIGV4cG9ydCk7DQo+Pj4gKyAgICBxaW9fY2hhbm5lbF9z
ZXRfa2VlcGFsaXZlKFFJT19DSEFOTkVMKHNpb2MpLCB0cnVlLCBOVUxMKTsNCj4+PiAgICAgICBx
aW9fY2hhbm5lbF9zZXRfYmxvY2tpbmcoUUlPX0NIQU5ORUwoc2lvYyksIHRydWUsIE5VTEwpOw0K
Pj4+ICAgDQo+Pj4gICAgICAgY2xpZW50LT5pbmZvLnJlcXVlc3Rfc2l6ZXMgPSB0cnVlOw0KPj4+
DQo+Pg0KPj4gLS0gDQo+PiBFcmljIEJsYWtlLCBQcmluY2lwYWwgU29mdHdhcmUgRW5naW5lZXIN
Cj4+IFJlZCBIYXQsIEluYy4gICAgICAgICAgICsxLTkxOS0zMDEtMzIyNg0KPj4gVmlydHVhbGl6
YXRpb246ICBxZW11Lm9yZyB8IGxpYnZpcnQub3JnDQo+Pg0KPiANCj4gDQo+IA0KPiANCj4gUmVn
YXJkcywNCj4gRGFuaWVsDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

