Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8025FC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE44206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cZ06G9de"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE44206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34280 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heJBg-0003oI-HJ
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 09:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44716)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heJ8t-0002WE-75
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heJ8q-0005Xp-4i
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:59:47 -0400
Received: from mail-eopbgr130112.outbound.protection.outlook.com
 ([40.107.13.112]:61698 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heJ8j-00059q-16; Fri, 21 Jun 2019 08:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdZhvwbiii+cFg2HP56T4KGfTdOsWCbZQMuiaQ6tWm4=;
 b=cZ06G9deTPfHZw0L/CJ0HA8dq5qJ3DeuzT9HxecTMn1YI41nSIOfB52OhWuScWnyJloBQ3klBTLgx1zvX78bMANsU8p/HgIfxCnXllY8xFMXdhXewSC1Z527nmV5/SbS+gHxfAtcsrVoEIR6ejiDEd/ff76j9VyR6xKndIwadIQ=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4776.eurprd08.prod.outlook.com (20.179.45.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 21 Jun 2019 12:59:33 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 12:59:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH 07/12] block/backup: add 'always' bitmap sync policy
Thread-Index: AQHVJwQUASyLXkk6xUaH3k5xNAqj4qamE50AgAAArgA=
Date: Fri, 21 Jun 2019 12:59:33 +0000
Message-ID: <0eba7f8d-d1ed-fd4d-c417-346083cbed9c@virtuozzo.com>
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-8-jsnow@redhat.com>
 <8fde15e1-9693-9e46-b5c8-0f657b1eebed@virtuozzo.com>
In-Reply-To: <8fde15e1-9693-9e46-b5c8-0f657b1eebed@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::23) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621155930892
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31fc20cf-9ae3-4149-a2fa-08d6f6484e6b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4776; 
x-ms-traffictypediagnostic: DBBPR08MB4776:
x-microsoft-antispam-prvs: <DBBPR08MB47764F98CECDE0648CAE8170C1E70@DBBPR08MB4776.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(136003)(39840400004)(346002)(366004)(51444003)(199004)(189003)(476003)(102836004)(99286004)(386003)(54906003)(256004)(6506007)(6436002)(316002)(6246003)(73956011)(76176011)(229853002)(66066001)(8676002)(66556008)(64756008)(25786009)(86362001)(4326008)(7736002)(81166006)(52116002)(6512007)(14454004)(81156014)(2201001)(71190400001)(6116002)(5660300002)(71200400001)(66476007)(478600001)(7416002)(53936002)(31686004)(66946007)(66446008)(2501003)(305945005)(186003)(11346002)(3846002)(26005)(2906002)(31696002)(486006)(8936002)(110136005)(446003)(36756003)(2616005)(6486002)(14444005)(68736007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4776;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zxbwoQuDsKDklp5Ts183k50tcYZ4VBs1+dFerVYVPVaFZQdhMrtPvsIbnZBgFQ4zzuJlYhK1wSHumhk1XaBfagF7knklYsjuXw5tl+TuevZ4MV1lIU/aukG/6x5JAExNvfjsL0S2ghaYB8S09JtzC6NuEKq4tyNa/7R7zpffkg7BpMI8DgMIx+bEOfEWD1g1eXt9e69JcPHB4UbUPdomyyNhIWOiHMOvLks6GqwSgPRmufBuBEFgjRoMq3FU1MK2wRJX/E8QfGxJzAjB4S67PrSSg7+pNkxRysKLKFJcNnyk2Aii7i8WtI15wb2Tb18O7GkI6Cq3N57EUYtcnk1lP2TCkBfoVwLrzbrZAq1ZeAsIuymmifE7ewkMA8FaYYyUzLJulNIDGC6sq1y39Ojd0fwZV4xUqKFNgHxEtZoNtOY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <726F5F131F76584496D6AA02FCAA48CE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fc20cf-9ae3-4149-a2fa-08d6f6484e6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 12:59:33.6447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4776
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.112
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

MjEuMDYuMjAxOSAxNTo1NywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjAuMDYuMjAxOSA0OjAzLCBKb2huIFNub3cgd3JvdGU6DQo+PiBUaGlzIGFkZHMgYW4gImFsd2F5
cyIgcG9saWN5IGZvciBiaXRtYXAgc3luY2hyb25pemF0aW9uLiBSZWdhcmRsZXNzIG9mIGlmDQo+
PiB0aGUgam9iIHN1Y2NlZWRzIG9yIGZhaWxzLCB0aGUgYml0bWFwIGlzICphbHdheXMqIHN5bmNo
cm9uaXplZC4gVGhpcyBtZWFucw0KPj4gdGhhdCBmb3IgYmFja3VwcyB0aGF0IGZhaWwgcGFydC13
YXkgdGhyb3VnaCwgdGhlIGJpdG1hcCByZXRhaW5zIGEgcmVjb3JkIG9mDQo+PiB3aGljaCBzZWN0
b3JzIG5lZWQgdG8gYmUgY29waWVkIG91dCB0byBhY2NvbXBsaXNoIGEgbmV3IGJhY2t1cCB1c2lu
ZyB0aGUNCj4+IG9sZCwgcGFydGlhbCByZXN1bHQuDQo+Pg0KPj4gSW4gZWZmZWN0LCB0aGlzIGFs
bG93cyB1cyB0byAicmVzdW1lIiBhIGZhaWxlZCBiYWNrdXA7IGhvd2V2ZXIgdGhlIG5ldyBiYWNr
dXANCj4+IHdpbGwgYmUgZnJvbSB0aGUgbmV3IHBvaW50IGluIHRpbWUsIHNvIGl0IGlzbid0IGEg
InJlc3VtZSIgYXMgbXVjaCBhcyBpdCBpcw0KPj4gYW4gImluY3JlbWVudGFsIHJldHJ5LiIgVGhp
cyBjYW4gYmUgdXNlZnVsIGluIHRoZSBjYXNlIG9mIGV4dHJlbWVseSBsYXJnZQ0KPj4gYmFja3Vw
cyB0aGF0IGZhaWwgY29uc2lkZXJhYmx5IHRocm91Z2ggdGhlIG9wZXJhdGlvbiBhbmQgd2UnZCBs
aWtlIHRvIG5vdCB3YXN0ZQ0KPj4gdGhlIHdvcmsgdGhhdCB3YXMgYWxyZWFkeSBwZXJmb3JtZWQu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KPj4g
LS0tDQo+PiDCoCBxYXBpL2Jsb2NrLWNvcmUuanNvbiB8wqAgNSArKysrLQ0KPj4gwqAgYmxvY2sv
YmFja3VwLmPCoMKgwqDCoMKgwqAgfCAxMCArKysrKystLS0tDQo+PiDCoCAyIGZpbGVzIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L3FhcGkvYmxvY2stY29yZS5qc29uIGIvcWFwaS9ibG9jay1jb3JlLmpzb24NCj4+IGluZGV4IDAz
MzJkY2FhYmMuLjU4ZDI2N2YxZjUgMTAwNjQ0DQo+PiAtLS0gYS9xYXBpL2Jsb2NrLWNvcmUuanNv
bg0KPj4gKysrIGIvcWFwaS9ibG9jay1jb3JlLmpzb24NCj4+IEBAIC0xMTQzLDYgKzExNDMsOSBA
QA0KPj4gwqAgIyBBbiBlbnVtZXJhdGlvbiBvZiBwb3NzaWJsZSBiZWhhdmlvcnMgZm9yIHRoZSBz
eW5jaHJvbml6YXRpb24gb2YgYSBiaXRtYXANCj4+IMKgICMgd2hlbiB1c2VkIGZvciBkYXRhIGNv
cHkgb3BlcmF0aW9ucy4NCj4+IMKgICMNCj4+ICsjIEBhbHdheXM6IFRoZSBiaXRtYXAgaXMgYWx3
YXlzIHN5bmNocm9uaXplZCB3aXRoIHJlbWFpbmluZyBibG9ja3MgdG8gY29weSwNCj4+ICsjwqDC
oMKgwqDCoMKgwqDCoMKgIHdoZXRoZXIgb3Igbm90IHRoZSBvcGVyYXRpb24gaGFzIGNvbXBsZXRl
ZCBzdWNjZXNzZnVsbHkgb3Igbm90Lg0KPiANCj4gSG1tLCBub3cgSSB0aGluayB0aGF0ICdhbHdh
eXMnIHNvdW5kcyBhIGJpdCBsaWtlICdyZWFsbHkgYWx3YXlzJyBpLmUuIGR1cmluZyBiYWNrdXAN
Cj4gdG9vLCB3aGljaCBpcyBjb25mdXNpbmcuLiBCdXQgSSBkb24ndCBoYXZlIGJldHRlciBzdWdn
ZXN0aW9uLg0KPiANCj4+ICsjDQo+PiDCoCAjIEBjb25kaXRpb25hbDogVGhlIGJpdG1hcCBpcyBv
bmx5IHN5bmNocm9uaXplZCB3aGVuIHRoZSBvcGVyYXRpb24gaXMgc3VjY2Vzc3VsLg0KPj4gwqAg
I8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVGhpcyBpcyB1c2VmdWwgZm9yIEluY3JlbWVu
dGFsIHNlbWFudGljcy4NCj4+IMKgICMNCj4+IEBAIC0xMTUzLDcgKzExNTYsNyBAQA0KPj4gwqAg
IyBTaW5jZTogNC4xDQo+PiDCoCAjIw0KPj4gwqAgeyAnZW51bSc6ICdCaXRtYXBTeW5jTW9kZScs
DQo+PiAtwqAgJ2RhdGEnOiBbJ2NvbmRpdGlvbmFsJywgJ25ldmVyJ10gfQ0KPj4gK8KgICdkYXRh
JzogWydhbHdheXMnLCAnY29uZGl0aW9uYWwnLCAnbmV2ZXInXSB9DQo+PiDCoCAjIw0KPj4gwqAg
IyBATWlycm9yQ29weU1vZGU6DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svYmFja3VwLmMgYi9ibG9j
ay9iYWNrdXAuYw0KPj4gaW5kZXggNjI3ZjcyNGI2OC4uYmViMjA3ODY5NiAxMDA2NDQNCj4+IC0t
LSBhL2Jsb2NrL2JhY2t1cC5jDQo+PiArKysgYi9ibG9jay9iYWNrdXAuYw0KPj4gQEAgLTI2Niwx
NSArMjY2LDE3IEBAIHN0YXRpYyB2b2lkIGJhY2t1cF9jbGVhbnVwX3N5bmNfYml0bWFwKEJhY2t1
cEJsb2NrSm9iICpqb2IsIGludCByZXQpDQo+PiDCoMKgwqDCoMKgIEJsb2NrRHJpdmVyU3RhdGUg
KmJzID0gYmxrX2JzKGpvYi0+Y29tbW9uLmJsayk7DQo+PiDCoMKgwqDCoMKgIGlmIChyZXQgPCAw
IHx8IGpvYi0+Yml0bWFwX21vZGUgPT0gQklUTUFQX1NZTkNfTU9ERV9ORVZFUikgew0KPj4gLcKg
wqDCoMKgwqDCoMKgIC8qIEZhaWx1cmUsIG9yIHdlIGRvbid0IHdhbnQgdG8gc3luY2hyb25pemUg
dGhlIGJpdG1hcC4NCj4+IC3CoMKgwqDCoMKgwqDCoMKgICogTWVyZ2UgdGhlIHN1Y2Nlc3NvciBi
YWNrIGludG8gdGhlIHBhcmVudCwgZGVsZXRlIG5vdGhpbmcuICovDQo+PiArwqDCoMKgwqDCoMKg
wqAgLyogRmFpbHVyZSwgb3Igd2UgZG9uJ3Qgd2FudCB0byBzeW5jaHJvbml6ZSB0aGUgYml0bWFw
LiAqLw0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChqb2ItPmJpdG1hcF9tb2RlID09IEJJVE1BUF9T
WU5DX01PREVfQUxXQVlTKSB7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiZHJ2X2RpcnR5
X2JpdG1hcF9jbGFpbShqb2ItPnN5bmNfYml0bWFwLCAmam9iLT5jb3B5X2JpdG1hcCk7DQo+PiAr
wqDCoMKgwqDCoMKgwqAgfQ0KPj4gK8KgwqDCoMKgwqDCoMKgIC8qIE1lcmdlIHRoZSBzdWNjZXNz
b3IgYmFjayBpbnRvIHRoZSBwYXJlbnQuICovDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYm0gPSBi
ZHJ2X3JlY2xhaW1fZGlydHlfYml0bWFwKGJzLCBqb2ItPnN5bmNfYml0bWFwLCBOVUxMKTsNCj4g
DQo+IEhtbSBnb29kLCBpdCBzaG91bGQgd29yay4gSXQncyBhIGxvdCBtb3JlIHRyaWNreSwgdGhh
biBqdXN0DQo+ICJzeW5jaHJvbml6ZWQgd2l0aCByZW1haW5pbmcgYmxvY2tzIHRvIGNvcHkiLCBi
dXQgSSdtIG5vdCBzdXJlIHRoZSB3ZSBuZWVkIG1vcmUgZGV0YWlscyBpbg0KPiBzcGVjLg0KPiAN
Cj4gV2hhdCB3ZSBoYXZlIGluIGJhY2t1cD8gU28sIGZyb20gb25lIGhhbmQgd2UgaGF2ZSBhbiBp
bmNyZW1lbnRhbCBiYWNrdXAsIGFuZCBhIGJpdG1hcCwgY291bnRpbmcgZnJvbSBpdC4NCj4gT24g
dGhlIG90aGVyIGhhbmQgaXQncyBub3Qgbm9ybWFsIGluY3JlbWVudGFsIGJhY2t1cCwgYXMgaXQg
ZG9uJ3QgY29ycmVzcG9uZCB0byBhbnkgdmFsaWQgc3RhdGUgb2Ygdm0gZGlzaywNCj4gYW5kIGl0
IG1heSBiZSB1c2VkIG9ubHkgYXMgYSBiYWNraW5nIGluIGEgY2hhaW4gb2YgZnVydGhlciBzdWNj
ZXNzZnVsIGluY3JlbWVudGFsIGJhY2t1cCwgeWVzPw0KPiANCj4gQW5kIHRoZW4gSSB0aGluazog
d2l0aCB0aGlzIG1vZGUgd2UgY2FuIG5vdCBzdG9wIG9uIGZpcnN0IGVycm9yLCBidXQgaWdub3Jl
IGl0LCBqdXN0IGxlYXZpbmcgZGlydHkgYml0IGZvcg0KPiByZXN1bHRpbmcgYml0bWFwLi4gV2Ug
aGF2ZSBCTE9DS0RFVl9PTl9FUlJPUl9JR05PUkUsIHdoaWNoIG1heSBiZSB1c2VkIHRvIGFjaGll
dmUgaXQsIGJ1dCBzZWVtcyBpdCBkb24ndA0KPiB3b3JrIGFzIGV4cGVjdGVkLCBhcyBpbiBiYWNr
dXBfbG9vcCgpIHdlIHJldHJ5IG9wZXJhdGlvbiBpZiByZXQgPCAwIGFuZMKgIGFjdGlvbiAhPSBC
TE9DS19FUlJPUl9BQ1RJT05fUkVQT1JULg0KPiANCj4gQW5kIGFub3RoZXIgdGhvdWdodDogY2Fu
IHVzZXIgdGFrZSBhIGRlY2lzaW9uIG9mIGRpc2NhcmRpbmcgKGxpa2UgQ09ORElUSU9OQUwpIG9y
IHNhdmluZyBpbiBiYWNraW5nIGNoYWluIChsaWtlDQo+IEFMV0FZUykgZmFpbGVkIGJhY2t1cCBy
ZXN1bHQgX2FmdGVyXyBiYWNrdXAgam9iIGNvbXBsZXRlPyBGb3IgZXhhbXBsZSwgZm9yIHNtYWxs
IHJlc3VsdGluZyBiYWNrdXAgaXQgbWF5IGJlDQo+IGJldHRlciB0byBkaXNjYXJkIGl0IGFuZCBm
b3IgbGFyZ2UgLSB0byBzYXZlLg0KPiBXaWxsIGl0IHdvcmsgaWYgd2Ugc3RhcnQgam9iIHdpdGgg
QUxXQVlTIG1vZGUgYW5kIGF1dG9jb21wbGV0ZSA9IGZhbHNlLCB0aGVuIG9uIGZhaWwgd2UgY2Fu
IGxvb2sgYXQgam9iIHByb2dyZXNzLA0KPiBhbmQgaWYgaXQgaXMgc21hbGwgd2UgY2FuY2VsIGpv
Yiwgb3RoZXJ3aXNlIGNhbGwgY29tcGxldGU/IE9yIHN0b3AsIGJsb2NrLWpvYi1jb21wbGV0ZSB3
aWxsIG5vdCB3b3JrIHdpdGggZmFpbHVyZQ0KPiBzY2VuYXJpb3M/IFRoZW4gd2UgaGF2ZSB0byBz
ZXQgQkxPQ0tERVZfT05fRVJST1JfSUdOT1JFLCBhbmQgb24gZmlyc3QgZXJyb3IgZXZlbnQgZGVj
aWRlLCBjYW5jZWwgb3Igbm90PyBCdXQgd2UNCj4gY2FuIG9ubHkgY2FuY2VsIG9yIGNvbnRpbnVl
Li4NCj4gDQo+IEhtbS4gQ2FuY2VsLiBTbyBvbiBjYW5jZWwgYW5kIGFib3J0IHlvdSBzeW5jaHJv
bml6ZSBiaXRtYXAgdG9vPyBTZWVtcyBpbiBiYWQgcmVsYXRpb24gd2l0aCB3aGF0IGNhbmNlbCBz
aG91bGQgZG8sDQo+IGFuZCBpbiB0cmFuc2FjdGlvbnMgaW4gZ2VuZXJhbC4uLg0KDQpJIG1lYW4g
Z3JvdXBlZCB0cmFuc2FjdGlvbiBtb2RlLCBob3cgc2hvdWxkIGl0IHdvcmsgd2l0aCB0aGlzPw0K
DQo+IA0KPiANCj4+IC3CoMKgwqDCoMKgwqDCoCBhc3NlcnQoYm0pOw0KPj4gwqDCoMKgwqDCoCB9
IGVsc2Ugew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEV2ZXJ5dGhpbmcgaXMgZmluZSwgZGVs
ZXRlIHRoaXMgYml0bWFwIGFuZCBpbnN0YWxsIHRoZSBiYWNrdXAuICovDQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgYm0gPSBiZHJ2X2RpcnR5X2JpdG1hcF9hYmRpY2F0ZShicywgam9iLT5zeW5jX2Jp
dG1hcCwgTlVMTCk7DQo+PiAtwqDCoMKgwqDCoMKgwqAgYXNzZXJ0KGJtKTsNCj4+IMKgwqDCoMKg
wqAgfQ0KPj4gK8KgwqDCoCBhc3NlcnQoYm0pOw0KPj4gwqAgfQ0KPj4gwqAgc3RhdGljIHZvaWQg
YmFja3VwX2NvbW1pdChKb2IgKmpvYikNCj4+DQo+IA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=

