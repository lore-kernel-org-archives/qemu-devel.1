Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063B3C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97572083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bgOLWWXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97572083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34530 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heJJG-00084Y-2w
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 09:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46963)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heJHH-0006gm-ML
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heJHD-0008SD-UR
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:08:27 -0400
Received: from mail-eopbgr140095.outbound.protection.outlook.com
 ([40.107.14.95]:52156 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heJH5-0008Jb-4R; Fri, 21 Jun 2019 09:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoWN0aArRcwqPeCv9SEE/OS402FlvX/WjdLa2Mtp6hw=;
 b=bgOLWWXm5OeJHx8QO/f//QRRpB2te2QOvWSodBwgOjZYwD8dHVYTqt+AjPN3oJRS3ARsee8MZEDR6EDaz5nJO3dALIt8QGps+HuOmQH2+Ec4xXuh8gZPK3Drz4y4vKcj64qw1nsMgMFFG2Nc7np/EZKM+eVX4J+n74HbgxGEJw8=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4235.eurprd08.prod.outlook.com (20.179.40.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 21 Jun 2019 13:08:12 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 13:08:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH 07/12] block/backup: add 'always' bitmap sync policy
Thread-Index: AQHVJwQUASyLXkk6xUaH3k5xNAqj4qamE50AgAAy+QD//9AfAA==
Date: Fri, 21 Jun 2019 13:08:11 +0000
Message-ID: <05fd79a3-1828-f65b-118a-952aef26642a@virtuozzo.com>
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-8-jsnow@redhat.com>
 <8fde15e1-9693-9e46-b5c8-0f657b1eebed@virtuozzo.com>
 <0eba7f8d-d1ed-fd4d-c417-346083cbed9c@virtuozzo.com>
In-Reply-To: <0eba7f8d-d1ed-fd4d-c417-346083cbed9c@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0364.eurprd05.prod.outlook.com
 (2603:10a6:7:94::23) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621160808212
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b3daea1-a07c-4aa3-3e2c-08d6f649833e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4235; 
x-ms-traffictypediagnostic: DBBPR08MB4235:
x-microsoft-antispam-prvs: <DBBPR08MB423581F0532C12CBDC27F285C1E70@DBBPR08MB4235.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(346002)(376002)(396003)(39840400004)(199004)(189003)(51444003)(476003)(2501003)(66066001)(8936002)(5660300002)(53936002)(7736002)(2201001)(229853002)(36756003)(25786009)(66476007)(8676002)(31696002)(6486002)(14454004)(486006)(2906002)(110136005)(81156014)(2616005)(305945005)(81166006)(66946007)(73956011)(6436002)(86362001)(4326008)(6246003)(316002)(3846002)(26005)(446003)(71200400001)(76176011)(102836004)(71190400001)(6116002)(256004)(11346002)(186003)(99286004)(6506007)(14444005)(386003)(7416002)(68736007)(66446008)(66556008)(478600001)(52116002)(64756008)(6512007)(54906003)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4235;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A/gmreR6dBQ3xOzfTm/GS8VknEf2r7KsRQLloq6e0G1J3NKj1xmWkHscxxceqTgzMvLL1D2e9WShN1u+uf0f/SAnlVJ4OrjD1fgd9V0OVcq7F6zuGNA0gT/SOxoZ0kEqoaqcHwdQSgIRSLNx1BIdXjAKscFpVDUpO2HwvzJMJnmo/34rD7r2rWw5iidbxZTS/ZVqJztSurUMUtXm5jVZLAXvdCr3N7CznYJCMQ71X93ucrbQXOL0j2sapI4lCxpW+7uz/T/W06SmxPfkNq/mLV1UDceBoaOpX5uwC/F2nBRw9jPuj/WpnqjWjz+jlJj69fcseEIreTUyk9CUvhJkI+zXUiiZeYvVywM9npIxAkk7Ra8QLe/WzJDRR3pUJnGuIWcLdkWsmG4ZZLemo6UFVhtl6Gh/3STRZyG6s6Ri0yI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5457D1E660D1F647B9B46DF39AE2571C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3daea1-a07c-4aa3-3e2c-08d6f649833e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 13:08:11.8611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4235
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.95
Subject: Re: [Qemu-devel] [PATCH 07/12] block/backup: add 'always' bitmap
 sync policy
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjEuMDYuMjAxOSAxNTo1OSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjEuMDYuMjAxOSAxNTo1NywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+
IDIwLjA2LjIwMTkgNDowMywgSm9obiBTbm93IHdyb3RlOg0KPj4+IFRoaXMgYWRkcyBhbiAiYWx3
YXlzIiBwb2xpY3kgZm9yIGJpdG1hcCBzeW5jaHJvbml6YXRpb24uIFJlZ2FyZGxlc3Mgb2YgaWYN
Cj4+PiB0aGUgam9iIHN1Y2NlZWRzIG9yIGZhaWxzLCB0aGUgYml0bWFwIGlzICphbHdheXMqIHN5
bmNocm9uaXplZC4gVGhpcyBtZWFucw0KPj4+IHRoYXQgZm9yIGJhY2t1cHMgdGhhdCBmYWlsIHBh
cnQtd2F5IHRocm91Z2gsIHRoZSBiaXRtYXAgcmV0YWlucyBhIHJlY29yZCBvZg0KPj4+IHdoaWNo
IHNlY3RvcnMgbmVlZCB0byBiZSBjb3BpZWQgb3V0IHRvIGFjY29tcGxpc2ggYSBuZXcgYmFja3Vw
IHVzaW5nIHRoZQ0KPj4+IG9sZCwgcGFydGlhbCByZXN1bHQuDQo+Pj4NCj4+PiBJbiBlZmZlY3Qs
IHRoaXMgYWxsb3dzIHVzIHRvICJyZXN1bWUiIGEgZmFpbGVkIGJhY2t1cDsgaG93ZXZlciB0aGUg
bmV3IGJhY2t1cA0KPj4+IHdpbGwgYmUgZnJvbSB0aGUgbmV3IHBvaW50IGluIHRpbWUsIHNvIGl0
IGlzbid0IGEgInJlc3VtZSIgYXMgbXVjaCBhcyBpdCBpcw0KPj4+IGFuICJpbmNyZW1lbnRhbCBy
ZXRyeS4iIFRoaXMgY2FuIGJlIHVzZWZ1bCBpbiB0aGUgY2FzZSBvZiBleHRyZW1lbHkgbGFyZ2UN
Cj4+PiBiYWNrdXBzIHRoYXQgZmFpbCBjb25zaWRlcmFibHkgdGhyb3VnaCB0aGUgb3BlcmF0aW9u
IGFuZCB3ZSdkIGxpa2UgdG8gbm90IHdhc3RlDQo+Pj4gdGhlIHdvcmsgdGhhdCB3YXMgYWxyZWFk
eSBwZXJmb3JtZWQuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBKb2huIFNub3cgPGpzbm93QHJl
ZGhhdC5jb20+DQo+Pj4gLS0tDQo+Pj4gwqAgcWFwaS9ibG9jay1jb3JlLmpzb24gfMKgIDUgKysr
Ky0NCj4+PiDCoCBibG9jay9iYWNrdXAuY8KgwqDCoMKgwqDCoCB8IDEwICsrKysrKy0tLS0NCj4+
PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+
Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvcWFwaS9ibG9jay1jb3JlLmpzb24gYi9xYXBpL2Jsb2NrLWNv
cmUuanNvbg0KPj4+IGluZGV4IDAzMzJkY2FhYmMuLjU4ZDI2N2YxZjUgMTAwNjQ0DQo+Pj4gLS0t
IGEvcWFwaS9ibG9jay1jb3JlLmpzb24NCj4+PiArKysgYi9xYXBpL2Jsb2NrLWNvcmUuanNvbg0K
Pj4+IEBAIC0xMTQzLDYgKzExNDMsOSBAQA0KPj4+IMKgICMgQW4gZW51bWVyYXRpb24gb2YgcG9z
c2libGUgYmVoYXZpb3JzIGZvciB0aGUgc3luY2hyb25pemF0aW9uIG9mIGEgYml0bWFwDQo+Pj4g
wqAgIyB3aGVuIHVzZWQgZm9yIGRhdGEgY29weSBvcGVyYXRpb25zLg0KPj4+IMKgICMNCj4+PiAr
IyBAYWx3YXlzOiBUaGUgYml0bWFwIGlzIGFsd2F5cyBzeW5jaHJvbml6ZWQgd2l0aCByZW1haW5p
bmcgYmxvY2tzIHRvIGNvcHksDQo+Pj4gKyPCoMKgwqDCoMKgwqDCoMKgwqAgd2hldGhlciBvciBu
b3QgdGhlIG9wZXJhdGlvbiBoYXMgY29tcGxldGVkIHN1Y2Nlc3NmdWxseSBvciBub3QuDQo+Pg0K
Pj4gSG1tLCBub3cgSSB0aGluayB0aGF0ICdhbHdheXMnIHNvdW5kcyBhIGJpdCBsaWtlICdyZWFs
bHkgYWx3YXlzJyBpLmUuIGR1cmluZyBiYWNrdXANCj4+IHRvbywgd2hpY2ggaXMgY29uZnVzaW5n
Li4gQnV0IEkgZG9uJ3QgaGF2ZSBiZXR0ZXIgc3VnZ2VzdGlvbi4NCj4+DQo+Pj4gKyMNCj4+PiDC
oCAjIEBjb25kaXRpb25hbDogVGhlIGJpdG1hcCBpcyBvbmx5IHN5bmNocm9uaXplZCB3aGVuIHRo
ZSBvcGVyYXRpb24gaXMgc3VjY2Vzc3VsLg0KPj4+IMKgICPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFRoaXMgaXMgdXNlZnVsIGZvciBJbmNyZW1lbnRhbCBzZW1hbnRpY3MuDQo+Pj4gwqAg
Iw0KPj4+IEBAIC0xMTUzLDcgKzExNTYsNyBAQA0KPj4+IMKgICMgU2luY2U6IDQuMQ0KPj4+IMKg
ICMjDQo+Pj4gwqAgeyAnZW51bSc6ICdCaXRtYXBTeW5jTW9kZScsDQo+Pj4gLcKgICdkYXRhJzog
Wydjb25kaXRpb25hbCcsICduZXZlciddIH0NCj4+PiArwqAgJ2RhdGEnOiBbJ2Fsd2F5cycsICdj
b25kaXRpb25hbCcsICduZXZlciddIH0NCj4+PiDCoCAjIw0KPj4+IMKgICMgQE1pcnJvckNvcHlN
b2RlOg0KPj4+IGRpZmYgLS1naXQgYS9ibG9jay9iYWNrdXAuYyBiL2Jsb2NrL2JhY2t1cC5jDQo+
Pj4gaW5kZXggNjI3ZjcyNGI2OC4uYmViMjA3ODY5NiAxMDA2NDQNCj4+PiAtLS0gYS9ibG9jay9i
YWNrdXAuYw0KPj4+ICsrKyBiL2Jsb2NrL2JhY2t1cC5jDQo+Pj4gQEAgLTI2NiwxNSArMjY2LDE3
IEBAIHN0YXRpYyB2b2lkIGJhY2t1cF9jbGVhbnVwX3N5bmNfYml0bWFwKEJhY2t1cEJsb2NrSm9i
ICpqb2IsIGludCByZXQpDQo+Pj4gwqDCoMKgwqDCoCBCbG9ja0RyaXZlclN0YXRlICpicyA9IGJs
a19icyhqb2ItPmNvbW1vbi5ibGspOw0KPj4+IMKgwqDCoMKgwqAgaWYgKHJldCA8IDAgfHwgam9i
LT5iaXRtYXBfbW9kZSA9PSBCSVRNQVBfU1lOQ19NT0RFX05FVkVSKSB7DQo+Pj4gLcKgwqDCoMKg
wqDCoMKgIC8qIEZhaWx1cmUsIG9yIHdlIGRvbid0IHdhbnQgdG8gc3luY2hyb25pemUgdGhlIGJp
dG1hcC4NCj4+PiAtwqDCoMKgwqDCoMKgwqDCoCAqIE1lcmdlIHRoZSBzdWNjZXNzb3IgYmFjayBp
bnRvIHRoZSBwYXJlbnQsIGRlbGV0ZSBub3RoaW5nLiAqLw0KPj4+ICvCoMKgwqDCoMKgwqDCoCAv
KiBGYWlsdXJlLCBvciB3ZSBkb24ndCB3YW50IHRvIHN5bmNocm9uaXplIHRoZSBiaXRtYXAuICov
DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChqb2ItPmJpdG1hcF9tb2RlID09IEJJVE1BUF9TWU5D
X01PREVfQUxXQVlTKSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmRydl9kaXJ0eV9i
aXRtYXBfY2xhaW0oam9iLT5zeW5jX2JpdG1hcCwgJmpvYi0+Y29weV9iaXRtYXApOw0KPj4+ICvC
oMKgwqDCoMKgwqDCoCB9DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qIE1lcmdlIHRoZSBzdWNjZXNz
b3IgYmFjayBpbnRvIHRoZSBwYXJlbnQuICovDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGJtID0g
YmRydl9yZWNsYWltX2RpcnR5X2JpdG1hcChicywgam9iLT5zeW5jX2JpdG1hcCwgTlVMTCk7DQo+
Pg0KPj4gSG1tIGdvb2QsIGl0IHNob3VsZCB3b3JrLiBJdCdzIGEgbG90IG1vcmUgdHJpY2t5LCB0
aGFuIGp1c3QNCj4+ICJzeW5jaHJvbml6ZWQgd2l0aCByZW1haW5pbmcgYmxvY2tzIHRvIGNvcHki
LCBidXQgSSdtIG5vdCBzdXJlIHRoZSB3ZSBuZWVkIG1vcmUgZGV0YWlscyBpbg0KPj4gc3BlYy4N
Cj4+DQo+PiBXaGF0IHdlIGhhdmUgaW4gYmFja3VwPyBTbywgZnJvbSBvbmUgaGFuZCB3ZSBoYXZl
IGFuIGluY3JlbWVudGFsIGJhY2t1cCwgYW5kIGEgYml0bWFwLCBjb3VudGluZyBmcm9tIGl0Lg0K
Pj4gT24gdGhlIG90aGVyIGhhbmQgaXQncyBub3Qgbm9ybWFsIGluY3JlbWVudGFsIGJhY2t1cCwg
YXMgaXQgZG9uJ3QgY29ycmVzcG9uZCB0byBhbnkgdmFsaWQgc3RhdGUgb2Ygdm0gZGlzaywNCj4+
IGFuZCBpdCBtYXkgYmUgdXNlZCBvbmx5IGFzIGEgYmFja2luZyBpbiBhIGNoYWluIG9mIGZ1cnRo
ZXIgc3VjY2Vzc2Z1bCBpbmNyZW1lbnRhbCBiYWNrdXAsIHllcz8NCj4+DQo+PiBBbmQgdGhlbiBJ
IHRoaW5rOiB3aXRoIHRoaXMgbW9kZSB3ZSBjYW4gbm90IHN0b3Agb24gZmlyc3QgZXJyb3IsIGJ1
dCBpZ25vcmUgaXQsIGp1c3QgbGVhdmluZyBkaXJ0eSBiaXQgZm9yDQo+PiByZXN1bHRpbmcgYml0
bWFwLi4gV2UgaGF2ZSBCTE9DS0RFVl9PTl9FUlJPUl9JR05PUkUsIHdoaWNoIG1heSBiZSB1c2Vk
IHRvIGFjaGlldmUgaXQsIGJ1dCBzZWVtcyBpdCBkb24ndA0KPj4gd29yayBhcyBleHBlY3RlZCwg
YXMgaW4gYmFja3VwX2xvb3AoKSB3ZSByZXRyeSBvcGVyYXRpb24gaWYgcmV0IDwgMCBhbmTCoCBh
Y3Rpb24gIT0gQkxPQ0tfRVJST1JfQUNUSU9OX1JFUE9SVC4NCj4+DQo+PiBBbmQgYW5vdGhlciB0
aG91Z2h0OiBjYW4gdXNlciB0YWtlIGEgZGVjaXNpb24gb2YgZGlzY2FyZGluZyAobGlrZSBDT05E
SVRJT05BTCkgb3Igc2F2aW5nIGluIGJhY2tpbmcgY2hhaW4gKGxpa2UNCj4+IEFMV0FZUykgZmFp
bGVkIGJhY2t1cCByZXN1bHQgX2FmdGVyXyBiYWNrdXAgam9iIGNvbXBsZXRlPyBGb3IgZXhhbXBs
ZSwgZm9yIHNtYWxsIHJlc3VsdGluZyBiYWNrdXAgaXQgbWF5IGJlDQo+PiBiZXR0ZXIgdG8gZGlz
Y2FyZCBpdCBhbmQgZm9yIGxhcmdlIC0gdG8gc2F2ZS4NCj4+IFdpbGwgaXQgd29yayBpZiB3ZSBz
dGFydCBqb2Igd2l0aCBBTFdBWVMgbW9kZSBhbmQgYXV0b2NvbXBsZXRlID0gZmFsc2UsIHRoZW4g
b24gZmFpbCB3ZSBjYW4gbG9vayBhdCBqb2IgcHJvZ3Jlc3MsDQo+PiBhbmQgaWYgaXQgaXMgc21h
bGwgd2UgY2FuY2VsIGpvYiwgb3RoZXJ3aXNlIGNhbGwgY29tcGxldGU/IE9yIHN0b3AsIGJsb2Nr
LWpvYi1jb21wbGV0ZSB3aWxsIG5vdCB3b3JrIHdpdGggZmFpbHVyZQ0KPj4gc2NlbmFyaW9zPyBU
aGVuIHdlIGhhdmUgdG8gc2V0IEJMT0NLREVWX09OX0VSUk9SX0lHTk9SRSwgYW5kIG9uIGZpcnN0
IGVycm9yIGV2ZW50IGRlY2lkZSwgY2FuY2VsIG9yIG5vdD8gQnV0IHdlDQo+PiBjYW4gb25seSBj
YW5jZWwgb3IgY29udGludWUuLg0KPj4NCj4+IEhtbS4gQ2FuY2VsLiBTbyBvbiBjYW5jZWwgYW5k
IGFib3J0IHlvdSBzeW5jaHJvbml6ZSBiaXRtYXAgdG9vPyBTZWVtcyBpbiBiYWQgcmVsYXRpb24g
d2l0aCB3aGF0IGNhbmNlbCBzaG91bGQgZG8sDQo+PiBhbmQgaW4gdHJhbnNhY3Rpb25zIGluIGdl
bmVyYWwuLi4NCj4gDQo+IEkgbWVhbiBncm91cGVkIHRyYW5zYWN0aW9uIG1vZGUsIGhvdyBzaG91
bGQgaXQgd29yayB3aXRoIHRoaXM/DQoNCkFjdHVhbCB0aGUgcHJvYmxlbSBpcyB0aGF0IHlvdSB3
YW50IHRvIGltcGxlbWVudCBwYXJ0aWFsIHN1Y2Nlc3MsIGFuZCBibG9jayBqb2JzIGFwaSBhbmQg
dHJhbnNhY3Rpb25zIGFwaSBhcmUgbm90IHByZXBhcmVkDQpmb3Igc3VjaCB0aGluZw0KDQo+IA0K
Pj4NCj4+DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGFzc2VydChibSk7DQo+Pj4gwqDCoMKgwqDCoCB9
IGVsc2Ugew0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBFdmVyeXRoaW5nIGlzIGZpbmUsIGRl
bGV0ZSB0aGlzIGJpdG1hcCBhbmQgaW5zdGFsbCB0aGUgYmFja3VwLiAqLw0KPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBibSA9IGJkcnZfZGlydHlfYml0bWFwX2FiZGljYXRlKGJzLCBqb2ItPnN5bmNf
Yml0bWFwLCBOVUxMKTsNCj4+PiAtwqDCoMKgwqDCoMKgwqAgYXNzZXJ0KGJtKTsNCj4+PiDCoMKg
wqDCoMKgIH0NCj4+PiArwqDCoMKgIGFzc2VydChibSk7DQo+Pj4gwqAgfQ0KPj4+IMKgIHN0YXRp
YyB2b2lkIGJhY2t1cF9jb21taXQoSm9iICpqb2IpDQo+Pj4NCj4+DQo+Pg0KPiANCj4gDQoNCg0K
LS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

