Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4FFC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AFB32064B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Wgae738d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFB32064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgsJ7-0005LP-Q4
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46186)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <den@virtuozzo.com>) id 1hgsBA-0000fp-6S
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1hgsB7-00046a-JX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:48:43 -0400
Received: from mail-he1eur02on0700.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::700]:58702
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1hgsAp-0003Sn-74; Fri, 28 Jun 2019 10:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCqVRj6lxbHbElZOS7pzC5VZ00mHC8b/mwANV8afLFU=;
 b=Wgae738dmfXO6jC5w88umBC9qeTGhzUSdY+sH6YieIX68oPeA99XLXP8Zys9pVqkD4iwM5w82Z7fD1jFuediej2CoOMttULPsqQ+QQ7pzRk1JmNuhDtoiYqNz+sLOZ3AEEnxXO363oLOc4M7BCNL2AG1DMXcUx9OxTUW70KRgZk=
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com (20.179.40.149) by
 DBBPR08MB4632.eurprd08.prod.outlook.com (10.255.78.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 14:47:32 +0000
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::1d8b:7420:f966:e881]) by DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::1d8b:7420:f966:e881%3]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 14:47:32 +0000
From: Denis Lunev <den@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [RFC] Re-evaluating subcluster allocation for qcow2 images
Thread-Index: AQHVLPCb4B1OTPiTIEWxN+ewhowOEKavjMGAgAAWOgCAADnRAIABSSKAgAABAoA=
Date: Fri, 28 Jun 2019 14:47:32 +0000
Message-ID: <083762bf-788e-1090-775d-c20e539583c9@virtuozzo.com>
References: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
 <4453cfc4-cff7-c004-1f4c-7cab462e4661@virtuozzo.com>
 <w51a7e3domn.fsf@maestria.local.igalia.com>
 <434b102d-9d8e-ccc2-cb53-7f49a3fbd6fb@virtuozzo.com>
 <w51r27dixcm.fsf@maestria.local.igalia.com>
In-Reply-To: <w51r27dixcm.fsf@maestria.local.igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::32) To DBBPR08MB4250.eurprd08.prod.outlook.com
 (2603:10a6:10:c2::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 165d6cc8-8ea6-4c0e-c20c-08d6fbd78cd4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DBBPR08MB4632; 
x-ms-traffictypediagnostic: DBBPR08MB4632:
x-microsoft-antispam-prvs: <DBBPR08MB4632322A603138AA5E517C52B6FC0@DBBPR08MB4632.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(366004)(39840400004)(346002)(396003)(199004)(189003)(486006)(305945005)(66446008)(64756008)(66556008)(66476007)(73956011)(66946007)(81156014)(8936002)(36756003)(81166006)(3846002)(53546011)(102836004)(68736007)(6506007)(5660300002)(71200400001)(186003)(71190400001)(6116002)(478600001)(2501003)(31696002)(107886003)(6246003)(53936002)(2906002)(476003)(2616005)(99286004)(14444005)(7736002)(386003)(54906003)(316002)(25786009)(229853002)(110136005)(256004)(31686004)(52116002)(86362001)(66066001)(14454004)(26005)(11346002)(6486002)(6436002)(8676002)(4326008)(6512007)(446003)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4632;
 H:DBBPR08MB4250.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SjQIr/gzYZYWLnWjV2GziPKA+JBSc1S6zJUCTdC6L4BV/CFD6eHToNMuLTMSj8YXgBFhDDXYPWwWio3yIUBohEjgVk7iFDZ86kBlvQ+DwAq16Fn4Vv8wAvt6+8x4KorX9RMl2x7bRvnocvb/Jl4KCBp5IFhPnZ69pGoC6L1k9nhmx/mvxdKIKtwPRKLe180U1vncU/crT4bozXsZDvXFWP7HDaaI3ki/V1nsinX2d/E8LNtIJqD0W5xgAmj6nplqZReTZdKQulM4W6R1fJn3NGbLNSKjqfyRfQF+rx1E90zqcpgExgORL79Mlh78lz6Kn0zwSjHgDQsGYC6hFnszVJ5doXMfgn5QAq3urTZlHqyrlq3FLuruBhg+osXUqYbot1MN2kGzQC9fqObbUsNn+ViMrmvWEfpcYzXxYAfO+tA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4A63F4DCBB3A54F890426C467CE0591@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165d6cc8-8ea6-4c0e-c20c-08d6fbd78cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 14:47:32.1506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: den@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4632
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe05::700
Subject: Re: [Qemu-devel] [RFC] Re-evaluating subcluster allocation for
 qcow2 images
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gNi8yOC8xOSA1OjQzIFBNLCBBbGJlcnRvIEdhcmNpYSB3cm90ZToNCj4gT24gVGh1IDI3IEp1
biAyMDE5IDA2OjA1OjU1IFBNIENFU1QsIERlbmlzIEx1bmV2IHdyb3RlOg0KPj4+PiBUaHVzIGlu
IHJlc3BlY3QgdG8gdGhpcyBwYXR0ZXJucyBzdWJjbHVzdGVycyBjb3VsZCBnaXZlIHVzIGJlbmVm
aXRzDQo+Pj4+IG9mIGZhc3QgcmFuZG9tIElPIGFuZCBnb29kIHJlY2xhaW0gcmF0ZS4NCj4+PiBF
eGFjdGx5LCBidXQgdGhhdCBmYXN0IHJhbmRvbSBJL08gd291bGQgb25seSBoYXBwZW4gd2hlbiBh
bGxvY2F0aW5nDQo+Pj4gbmV3IGNsdXN0ZXJzLiBPbmNlIHRoZSBjbHVzdGVycyBhcmUgYWxsb2Nh
dGVkIGl0IGRvZXNuJ3QgcHJvdmlkZSBhbnkNCj4+PiBhZGRpdGlvbmFsIHBlcmZvcm1hbmNlIGJl
bmVmaXQuDQo+PiBObywgSSBhbSB0YWxraW5nIGFib3V0IHRoZSBzaXR1YXRpb24gYWZ0ZXIgdGhl
IGFsbG9jYXRpb24uIFRoYXQgaXMgdGhlDQo+PiBtYWluIHBvaW50IHdoeSBJIGhhdmUgYSBmZWVs
aW5nIHRoYXQgc3ViLWNsdXN0ZXIgY291bGQgcHJvdmlkZSBhDQo+PiBiZW5lZml0Lg0KPj4NCj4+
IE9LLiBUaGUgc2l0dWF0aW9uICgxKSBpcyB0aGUgZm9sbG93aW5nOg0KPj4gLSB0aGUgZGlzayBp
cyBjb21wbGV0ZWx5IGFsbG9jYXRlZA0KPj4gLSBRQ09XMiBpbWFnZSBzaXplIGlzIDggVGINCj4+
IC0gd2UgaGF2ZSBpbWFnZSB3aXRoIDEgTWIgY2x1c3Rlci82NGsgc3ViLWNsdXN0ZXIgKGZvciBz
aW1wbGljaXR5KQ0KPj4gLSBMMiBtZXRhZGF0YSBjYWNoZSBzaXplIGlzIDEyOCBNYiAoNjQgTWIg
TDIgdGFibGVzLCA2NCBNYiBvdGhlciBkYXRhKQ0KPj4gLSBob2xlcyBhcmUgbWFkZSBvbiBhIHN1
Yi1jbHVzdGVyIGJhc2VzLCBpLmUuIHdpdGggNjQgS2IgZ3JhbnVsYXJpdHkNCj4+DQo+PiBJbiB0
aGlzIGNhc2UgcmFuZG9tIElPIHRlc3Qgd2lsbCBnaXZlIG5lYXIgbmF0aXZlIElPUFMNCj4+IHJl
c3VsdC4gTWV0YWRhdGEgaXMgaW4gbWVtb3J5LCBubyBhZGRpdGlvbmFsIHJlYWRzIGFyZQ0KPj4g
cmVxdWlyZWQuIFdhc3RlZCBob3N0IGZpbGVzeXN0ZW0gc3BhY2UgKGR1ZSB0byBjbHVzdGVyIHNp
emUpIGlzIGtlcHQNCj4+IGF0IG1pbmltdW0sIGkuZS4gb24gdGhlIGxldmVsIG9mIHRoZSAicHJl
LXN1YmNsdXN0ZXIiIFFDT1cyLg0KPj4NCj4+IFNpdHVhdGlvbiAoMik6DQo+PiAtIDggVGIgUUNP
VzIgaW1hZ2UgaXMgY29tcGxldGVseSBhbGxvY2F0ZWQNCj4+IC0gMSBNYiBjbHVzdGVyIHNpemUs
IDEyOCBNYiBMMiBjYWNoZSBzaXplDQo+Pg0KPj4gTmVhciBzYW1lIHBlcmZvcm1hbmNlIGFzICgx
KSwgYnV0IG11Y2ggbGVzcyBkaXNrIHNwYWNlIHNhdmluZ3MgZm9yDQo+PiBob2xlcy4NCj4+DQo+
PiBTaXR1YXRpb24gKDMpOg0KPj4gLSA4IFRiIFFDT1cyIGltYWdlLCBjb21wbGV0ZWx5IGFsbG9j
YXRlZA0KPj4gLSA2NCBLYiBjbHVzdGVyIHNpemUsIDEyOCBNQiBMMiBjYWNoZQ0KPj4NCj4+IFJh
bmRvbSBJTyBwZXJmb3JtYW5jZSBoYWx2ZWQgZnJvbSAoMSkgYW5kICgyKSBkdWUgdG8gbWV0YWRh
dGEgcmUtcmVhZA0KPj4gZm9yIGVhY2ggc3Vic2VxdWVudCBvcGVyYXRpb24uIFNhbWUgZGlzayBz
cGFjZSBzYXZpbmdzIGFzIGluIGNhc2UgKDEpLg0KPiBJZiBJIHVuZGVyc3Rvb2QgY29ycmVjdGx5
IHdoYXQgeW91IGFyZSB0cnlpbmcgdG8gc2F5LCBzdWJjbHVzdGVycyBhbGxvdw0KPiB1cyB0byB1
c2UgbGFyZ2VyIGNsdXN0ZXIgc2l6ZXMgaW4gb3JkZXIgdG8gcmVkdWNlIHRoZSBhbW91bnQgb2Yg
TDINCj4gbWV0YWRhdGEgKGFuZCB0aGVyZWZvcmUgdGhlIGNhY2hlIHNpemUpIHdoaWxlIGtlZXBp
bmcgdGhlIHNhbWUgc3BhY2UNCj4gYmVuZWZpdHMgYXMgc21hbGxlciBjbHVzdGVycy4NCnllcw0K
DQo+PiBQbGVhc2Ugbm90ZSwgSSBhbSBub3QgdGFsa2luZyBub3cgYWJvdXQgeW91ciBjYXNlIHdp
dGggQ09XLiBIZXJlIHRoZQ0KPj4gYWxsb2NhdGlvbiBpcyBwZXJmb3JtZWQgb24gdGhlIHN1Yi1j
bHVzdGVyIGJhc2lzLCBpLmUuIHRoZSBhYnNjZW5jZSBvZg0KPj4gdGhlIHN1Yi1jbHVzdGVyIGlu
IHRoZSBpbWFnZSBtZWFucyBob2xlIG9uIHRoYXQgb2Zmc2V0LiBUaGlzIGlzDQo+PiBpbXBvcnRh
bnQgZGlmZmVyZW5jZS4NCj4gSSBtZW50aW9uZWQgdGhlIHBvc3NpYmlsaXR5IHRoYXQgaWYgeW91
IGhhdmUgYSBjYXNlIGxpa2UgMk1CIC8gNjRLQiBhbmQNCj4geW91IHdyaXRlIHRvIGFuIGVtcHR5
IGNsdXN0ZXIgdGhlbiB5b3UgY291bGQgYWxsb2NhdGUgdGhlIG5lY2Vzc2FyeQ0KPiBzdWJjbHVz
dGVycywgYW5kIGFkZGl0aW9uYWxseSBmYWxsb2NhdGUoKSB0aGUgc3BhY2Ugb2YgdGhlIHdob2xl
IGNsdXN0ZXINCj4gKDJNQikgaW4gb3JkZXIgdG8gdHJ5IHRvIGtlZXAgaXQgY29udGlndW91cy4N
Cj4NCj4gV2l0aCB0aGlzIHdlIHdvdWxkIGxvc2UgdGhlIHNwYWNlIHNhdmluZyBhZHZhbnRhZ2Ug
b2YgaGF2aW5nDQo+IHN1YmNsdXN0ZXJzLiBCdXQgcGVyaGFwcyB0aGF0IHdvdWxkIHdvcmsgZm9y
IHNtYWxsZXIgY2x1c3RlciBzaXplcyAoaXQNCj4gd291bGQgbWl0aWdhdGUgdGhlIGZyYWdtZW50
YXRpb24gcHJvYmxlbSkuDQp5ZXMsIHRoaXMgaXMgZGlzdGluY3Rpb24gYW5kIGNvbXBsZXRlbHkg
ZGlmZmVyZW50IHVzZWNhc2UuDQpXZSBoYXZlIG9idGFpbmVkIGl0IG92ZXIgdGltZSBmcm9tIG91
ciBjdXN0b21lcnMsDQp3aG8gd2FudHMgdmVyeSBmYXN0IHBlcmZvcm1hbmNlIEFORCBzcGFjZSBj
b25zZXJ2YXRpb24NCmF0IG9uY2UuIFRoaXMgaXMgc3RpbGwgdGhlIGNhc2UgZm9yIFNTRCB1c2Vy
cywgd2hpY2ggYXJlDQpmYXN0IGJ1dCBzbWFsbC4NCg0KRGVuDQo=

