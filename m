Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F32C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7921B2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QNdszc80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7921B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35212 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heK1L-0007iE-3V
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 09:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56907)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heJql-0008BN-2n
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heJqi-0006nV-Et
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:45:07 -0400
Received: from mail-ve1eur02on0702.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::702]:1046
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heJqd-0006e3-OG; Fri, 21 Jun 2019 09:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l46N8W0R5y4QWbipm8YAHcv8142iPBWlSV/fMYDg7J4=;
 b=QNdszc80huFOOQ6R9R8N7EeFCQ0uICujBHxTtnCXLtFzOwqerU3JO+I6SFm1rdQYgwMeAX02K8rcEDoqHx+s1qKJIZohADxLRCvR20PbqICgXX7BAJMM4Sx8oZtFDdA4fcxN7hcAWMsW53rUL359RSpids51dJsXicy8/awffDs=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4712.eurprd08.prod.outlook.com (10.255.79.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 21 Jun 2019 13:44:56 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 13:44:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH 07/12] block/backup: add 'always' bitmap sync policy
Thread-Index: AQHVJwQUASyLXkk6xUaH3k5xNAqj4qamE50AgAAy+QCAAAJpAP//1/qA
Date: Fri, 21 Jun 2019 13:44:55 +0000
Message-ID: <460b3bf5-23e6-15f5-eb9e-1451ef246af9@virtuozzo.com>
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-8-jsnow@redhat.com>
 <8fde15e1-9693-9e46-b5c8-0f657b1eebed@virtuozzo.com>
 <0eba7f8d-d1ed-fd4d-c417-346083cbed9c@virtuozzo.com>
 <05fd79a3-1828-f65b-118a-952aef26642a@virtuozzo.com>
In-Reply-To: <05fd79a3-1828-f65b-118a-952aef26642a@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:7:66::22) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621164453093
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c6ec0e9-9fc0-43a7-e57e-08d6f64ea505
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4712; 
x-ms-traffictypediagnostic: DBBPR08MB4712:
x-microsoft-antispam-prvs: <DBBPR08MB4712F729D82E773F6D76509FC1E70@DBBPR08MB4712.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(376002)(346002)(396003)(39840400004)(51444003)(199004)(189003)(6246003)(486006)(31696002)(2616005)(476003)(11346002)(446003)(6436002)(7416002)(2906002)(186003)(8676002)(305945005)(26005)(6512007)(36756003)(6506007)(14444005)(229853002)(256004)(386003)(52116002)(76176011)(14454004)(102836004)(81166006)(81156014)(53936002)(99286004)(68736007)(5660300002)(4326008)(2201001)(86362001)(2501003)(110136005)(54906003)(6116002)(316002)(3846002)(66066001)(7736002)(66946007)(71190400001)(71200400001)(73956011)(25786009)(6486002)(64756008)(66476007)(66556008)(66446008)(8936002)(31686004)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4712;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dmWlCdBPvpGEZw2HIN0OJlGQk5jHXhFCMT8p2HH1MQW6YVklAZ+I8E50t8uY/JiM1iPVT2UjSgPtMbT43kaY/Tih3UdWTMCWY06MuwJvzhfvVfJm4t5eHKvGK9Z8XJ5AwOaXVLW34dydye+bBnN1XQG/sKVmFDmFAJBmOvyLgyawwsmFONOdS4/RnfilJrMFRjUHNe7ATvZuR6Ig/u5AdleVPkPCeamiWWdLmfHFJNOqsffiSjxyHR827BbJZs43ArjN0T8Jp5MsOlULzRdBjykQV1E93ewhYJ6nNWxBy5CYx9hi7cMbzmlJPlRTmIy5afbu5eUBZdoCu/oHy7MAGiwnLYu49fzFpSeop4Z55Kzz92HqoAGOQLZuyxp9roFPLjAa5s/j00gBntLh+SXQGGgM58AssyEzfGMQ1KZJSTo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <045DB5ECCDCA0943B854E1F64E992F3B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6ec0e9-9fc0-43a7-e57e-08d6f64ea505
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 13:44:55.8891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4712
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe06::702
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

MjEuMDYuMjAxOSAxNjowOCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjEuMDYuMjAxOSAxNTo1OSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+
IDIxLjA2LjIwMTkgMTU6NTcsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+
Pj4gMjAuMDYuMjAxOSA0OjAzLCBKb2huIFNub3cgd3JvdGU6DQo+Pj4+IFRoaXMgYWRkcyBhbiAi
YWx3YXlzIiBwb2xpY3kgZm9yIGJpdG1hcCBzeW5jaHJvbml6YXRpb24uIFJlZ2FyZGxlc3Mgb2Yg
aWYNCj4+Pj4gdGhlIGpvYiBzdWNjZWVkcyBvciBmYWlscywgdGhlIGJpdG1hcCBpcyAqYWx3YXlz
KiBzeW5jaHJvbml6ZWQuIFRoaXMgbWVhbnMNCj4+Pj4gdGhhdCBmb3IgYmFja3VwcyB0aGF0IGZh
aWwgcGFydC13YXkgdGhyb3VnaCwgdGhlIGJpdG1hcCByZXRhaW5zIGEgcmVjb3JkIG9mDQo+Pj4+
IHdoaWNoIHNlY3RvcnMgbmVlZCB0byBiZSBjb3BpZWQgb3V0IHRvIGFjY29tcGxpc2ggYSBuZXcg
YmFja3VwIHVzaW5nIHRoZQ0KPj4+PiBvbGQsIHBhcnRpYWwgcmVzdWx0Lg0KPj4+Pg0KPj4+PiBJ
biBlZmZlY3QsIHRoaXMgYWxsb3dzIHVzIHRvICJyZXN1bWUiIGEgZmFpbGVkIGJhY2t1cDsgaG93
ZXZlciB0aGUgbmV3IGJhY2t1cA0KPj4+PiB3aWxsIGJlIGZyb20gdGhlIG5ldyBwb2ludCBpbiB0
aW1lLCBzbyBpdCBpc24ndCBhICJyZXN1bWUiIGFzIG11Y2ggYXMgaXQgaXMNCj4+Pj4gYW4gImlu
Y3JlbWVudGFsIHJldHJ5LiIgVGhpcyBjYW4gYmUgdXNlZnVsIGluIHRoZSBjYXNlIG9mIGV4dHJl
bWVseSBsYXJnZQ0KPj4+PiBiYWNrdXBzIHRoYXQgZmFpbCBjb25zaWRlcmFibHkgdGhyb3VnaCB0
aGUgb3BlcmF0aW9uIGFuZCB3ZSdkIGxpa2UgdG8gbm90IHdhc3RlDQo+Pj4+IHRoZSB3b3JrIHRo
YXQgd2FzIGFscmVhZHkgcGVyZm9ybWVkLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKb2hu
IFNub3cgPGpzbm93QHJlZGhhdC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiDCoCBxYXBpL2Jsb2NrLWNv
cmUuanNvbiB8wqAgNSArKysrLQ0KPj4+PiDCoCBibG9jay9iYWNrdXAuY8KgwqDCoMKgwqDCoCB8
IDEwICsrKysrKy0tLS0NCj4+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvcWFwaS9ibG9jay1jb3Jl
Lmpzb24gYi9xYXBpL2Jsb2NrLWNvcmUuanNvbg0KPj4+PiBpbmRleCAwMzMyZGNhYWJjLi41OGQy
NjdmMWY1IDEwMDY0NA0KPj4+PiAtLS0gYS9xYXBpL2Jsb2NrLWNvcmUuanNvbg0KPj4+PiArKysg
Yi9xYXBpL2Jsb2NrLWNvcmUuanNvbg0KPj4+PiBAQCAtMTE0Myw2ICsxMTQzLDkgQEANCj4+Pj4g
wqAgIyBBbiBlbnVtZXJhdGlvbiBvZiBwb3NzaWJsZSBiZWhhdmlvcnMgZm9yIHRoZSBzeW5jaHJv
bml6YXRpb24gb2YgYSBiaXRtYXANCj4+Pj4gwqAgIyB3aGVuIHVzZWQgZm9yIGRhdGEgY29weSBv
cGVyYXRpb25zLg0KPj4+PiDCoCAjDQo+Pj4+ICsjIEBhbHdheXM6IFRoZSBiaXRtYXAgaXMgYWx3
YXlzIHN5bmNocm9uaXplZCB3aXRoIHJlbWFpbmluZyBibG9ja3MgdG8gY29weSwNCj4+Pj4gKyPC
oMKgwqDCoMKgwqDCoMKgwqAgd2hldGhlciBvciBub3QgdGhlIG9wZXJhdGlvbiBoYXMgY29tcGxl
dGVkIHN1Y2Nlc3NmdWxseSBvciBub3QuDQo+Pj4NCj4+PiBIbW0sIG5vdyBJIHRoaW5rIHRoYXQg
J2Fsd2F5cycgc291bmRzIGEgYml0IGxpa2UgJ3JlYWxseSBhbHdheXMnIGkuZS4gZHVyaW5nIGJh
Y2t1cA0KPj4+IHRvbywgd2hpY2ggaXMgY29uZnVzaW5nLi4gQnV0IEkgZG9uJ3QgaGF2ZSBiZXR0
ZXIgc3VnZ2VzdGlvbi4NCj4+Pg0KPj4+PiArIw0KPj4+PiDCoCAjIEBjb25kaXRpb25hbDogVGhl
IGJpdG1hcCBpcyBvbmx5IHN5bmNocm9uaXplZCB3aGVuIHRoZSBvcGVyYXRpb24gaXMgc3VjY2Vz
c3VsLg0KPj4+PiDCoCAjwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUaGlzIGlzIHVzZWZ1
bCBmb3IgSW5jcmVtZW50YWwgc2VtYW50aWNzLg0KPj4+PiDCoCAjDQo+Pj4+IEBAIC0xMTUzLDcg
KzExNTYsNyBAQA0KPj4+PiDCoCAjIFNpbmNlOiA0LjENCj4+Pj4gwqAgIyMNCj4+Pj4gwqAgeyAn
ZW51bSc6ICdCaXRtYXBTeW5jTW9kZScsDQo+Pj4+IC3CoCAnZGF0YSc6IFsnY29uZGl0aW9uYWwn
LCAnbmV2ZXInXSB9DQo+Pj4+ICvCoCAnZGF0YSc6IFsnYWx3YXlzJywgJ2NvbmRpdGlvbmFsJywg
J25ldmVyJ10gfQ0KPj4+PiDCoCAjIw0KPj4+PiDCoCAjIEBNaXJyb3JDb3B5TW9kZToNCj4+Pj4g
ZGlmZiAtLWdpdCBhL2Jsb2NrL2JhY2t1cC5jIGIvYmxvY2svYmFja3VwLmMNCj4+Pj4gaW5kZXgg
NjI3ZjcyNGI2OC4uYmViMjA3ODY5NiAxMDA2NDQNCj4+Pj4gLS0tIGEvYmxvY2svYmFja3VwLmMN
Cj4+Pj4gKysrIGIvYmxvY2svYmFja3VwLmMNCj4+Pj4gQEAgLTI2NiwxNSArMjY2LDE3IEBAIHN0
YXRpYyB2b2lkIGJhY2t1cF9jbGVhbnVwX3N5bmNfYml0bWFwKEJhY2t1cEJsb2NrSm9iICpqb2Is
IGludCByZXQpDQo+Pj4+IMKgwqDCoMKgwqAgQmxvY2tEcml2ZXJTdGF0ZSAqYnMgPSBibGtfYnMo
am9iLT5jb21tb24uYmxrKTsNCj4+Pj4gwqDCoMKgwqDCoCBpZiAocmV0IDwgMCB8fCBqb2ItPmJp
dG1hcF9tb2RlID09IEJJVE1BUF9TWU5DX01PREVfTkVWRVIpIHsNCj4+Pj4gLcKgwqDCoMKgwqDC
oMKgIC8qIEZhaWx1cmUsIG9yIHdlIGRvbid0IHdhbnQgdG8gc3luY2hyb25pemUgdGhlIGJpdG1h
cC4NCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqAgKiBNZXJnZSB0aGUgc3VjY2Vzc29yIGJhY2sgaW50
byB0aGUgcGFyZW50LCBkZWxldGUgbm90aGluZy4gKi8NCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8q
IEZhaWx1cmUsIG9yIHdlIGRvbid0IHdhbnQgdG8gc3luY2hyb25pemUgdGhlIGJpdG1hcC4gKi8N
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChqb2ItPmJpdG1hcF9tb2RlID09IEJJVE1BUF9TWU5D
X01PREVfQUxXQVlTKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJkcnZfZGlydHlf
Yml0bWFwX2NsYWltKGpvYi0+c3luY19iaXRtYXAsICZqb2ItPmNvcHlfYml0bWFwKTsNCj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIH0NCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qIE1lcmdlIHRoZSBzdWNj
ZXNzb3IgYmFjayBpbnRvIHRoZSBwYXJlbnQuICovDQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBi
bSA9IGJkcnZfcmVjbGFpbV9kaXJ0eV9iaXRtYXAoYnMsIGpvYi0+c3luY19iaXRtYXAsIE5VTEwp
Ow0KPj4+DQo+Pj4gSG1tIGdvb2QsIGl0IHNob3VsZCB3b3JrLiBJdCdzIGEgbG90IG1vcmUgdHJp
Y2t5LCB0aGFuIGp1c3QNCj4+PiAic3luY2hyb25pemVkIHdpdGggcmVtYWluaW5nIGJsb2NrcyB0
byBjb3B5IiwgYnV0IEknbSBub3Qgc3VyZSB0aGUgd2UgbmVlZCBtb3JlIGRldGFpbHMgaW4NCj4+
PiBzcGVjLg0KPj4+DQo+Pj4gV2hhdCB3ZSBoYXZlIGluIGJhY2t1cD8gU28sIGZyb20gb25lIGhh
bmQgd2UgaGF2ZSBhbiBpbmNyZW1lbnRhbCBiYWNrdXAsIGFuZCBhIGJpdG1hcCwgY291bnRpbmcg
ZnJvbSBpdC4NCj4+PiBPbiB0aGUgb3RoZXIgaGFuZCBpdCdzIG5vdCBub3JtYWwgaW5jcmVtZW50
YWwgYmFja3VwLCBhcyBpdCBkb24ndCBjb3JyZXNwb25kIHRvIGFueSB2YWxpZCBzdGF0ZSBvZiB2
bSBkaXNrLA0KPj4+IGFuZCBpdCBtYXkgYmUgdXNlZCBvbmx5IGFzIGEgYmFja2luZyBpbiBhIGNo
YWluIG9mIGZ1cnRoZXIgc3VjY2Vzc2Z1bCBpbmNyZW1lbnRhbCBiYWNrdXAsIHllcz8NCj4+Pg0K
Pj4+IEFuZCB0aGVuIEkgdGhpbms6IHdpdGggdGhpcyBtb2RlIHdlIGNhbiBub3Qgc3RvcCBvbiBm
aXJzdCBlcnJvciwgYnV0IGlnbm9yZSBpdCwganVzdCBsZWF2aW5nIGRpcnR5IGJpdCBmb3INCj4+
PiByZXN1bHRpbmcgYml0bWFwLi4gV2UgaGF2ZSBCTE9DS0RFVl9PTl9FUlJPUl9JR05PUkUsIHdo
aWNoIG1heSBiZSB1c2VkIHRvIGFjaGlldmUgaXQsIGJ1dCBzZWVtcyBpdCBkb24ndA0KPj4+IHdv
cmsgYXMgZXhwZWN0ZWQsIGFzIGluIGJhY2t1cF9sb29wKCkgd2UgcmV0cnkgb3BlcmF0aW9uIGlm
IHJldCA8IDAgYW5kwqAgYWN0aW9uICE9IEJMT0NLX0VSUk9SX0FDVElPTl9SRVBPUlQuDQo+Pj4N
Cj4+PiBBbmQgYW5vdGhlciB0aG91Z2h0OiBjYW4gdXNlciB0YWtlIGEgZGVjaXNpb24gb2YgZGlz
Y2FyZGluZyAobGlrZSBDT05ESVRJT05BTCkgb3Igc2F2aW5nIGluIGJhY2tpbmcgY2hhaW4gKGxp
a2UNCj4+PiBBTFdBWVMpIGZhaWxlZCBiYWNrdXAgcmVzdWx0IF9hZnRlcl8gYmFja3VwIGpvYiBj
b21wbGV0ZT8gRm9yIGV4YW1wbGUsIGZvciBzbWFsbCByZXN1bHRpbmcgYmFja3VwIGl0IG1heSBi
ZQ0KPj4+IGJldHRlciB0byBkaXNjYXJkIGl0IGFuZCBmb3IgbGFyZ2UgLSB0byBzYXZlLg0KPj4+
IFdpbGwgaXQgd29yayBpZiB3ZSBzdGFydCBqb2Igd2l0aCBBTFdBWVMgbW9kZSBhbmQgYXV0b2Nv
bXBsZXRlID0gZmFsc2UsIHRoZW4gb24gZmFpbCB3ZSBjYW4gbG9vayBhdCBqb2IgcHJvZ3Jlc3Ms
DQo+Pj4gYW5kIGlmIGl0IGlzIHNtYWxsIHdlIGNhbmNlbCBqb2IsIG90aGVyd2lzZSBjYWxsIGNv
bXBsZXRlPyBPciBzdG9wLCBibG9jay1qb2ItY29tcGxldGUgd2lsbCBub3Qgd29yayB3aXRoIGZh
aWx1cmUNCj4+PiBzY2VuYXJpb3M/IFRoZW4gd2UgaGF2ZSB0byBzZXQgQkxPQ0tERVZfT05fRVJS
T1JfSUdOT1JFLCBhbmQgb24gZmlyc3QgZXJyb3IgZXZlbnQgZGVjaWRlLCBjYW5jZWwgb3Igbm90
PyBCdXQgd2UNCj4+PiBjYW4gb25seSBjYW5jZWwgb3IgY29udGludWUuLg0KPj4+DQo+Pj4gSG1t
LiBDYW5jZWwuIFNvIG9uIGNhbmNlbCBhbmQgYWJvcnQgeW91IHN5bmNocm9uaXplIGJpdG1hcCB0
b28/IFNlZW1zIGluIGJhZCByZWxhdGlvbiB3aXRoIHdoYXQgY2FuY2VsIHNob3VsZCBkbywNCj4+
PiBhbmQgaW4gdHJhbnNhY3Rpb25zIGluIGdlbmVyYWwuLi4NCj4+DQo+PiBJIG1lYW4gZ3JvdXBl
ZCB0cmFuc2FjdGlvbiBtb2RlLCBob3cgc2hvdWxkIGl0IHdvcmsgd2l0aCB0aGlzPw0KPiANCj4g
QWN0dWFsIHRoZSBwcm9ibGVtIGlzIHRoYXQgeW91IHdhbnQgdG8gaW1wbGVtZW50IHBhcnRpYWwg
c3VjY2VzcywgYW5kIGJsb2NrIGpvYnMgYXBpIGFuZCB0cmFuc2FjdGlvbnMgYXBpIGFyZSBub3Qg
cHJlcGFyZWQNCj4gZm9yIHN1Y2ggdGhpbmcNCg0KDQpTaG91bGQgaXQgYmUgT0sgaWYgd2UganVz
dDoNCg0KMS4gcmVzdHJpY3QgdXNpbmcgQUxXQVlTIHRvZ2V0aGVyIHdpdGggZ3JvdXBlZCB0cmFu
c2FjdGlvbiBtb2RlLCBzbyB3ZSBkb24ndCBuZWVkIHRvIGRlYWwgd2l0aCBvdGhlciBqb2IgZmFp
bHVyZXMuDQoyLiBkb24ndCBjbGFpbSBidXQgb25seSByZWNsYWltIG9uIGNhbmNlbCBldmVuIGlu
IEFMV0FZUyBtb2RlLCB0byBtYWtlIGNhbmNlbCByb2xsLWJhY2sgYWxsIHRoaW5ncw0KDQo/DQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

