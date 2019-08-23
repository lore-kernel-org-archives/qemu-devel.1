Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012CFC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E0921897
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DPQ1LXWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E0921897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i18O5-0000bn-TD
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i18MQ-00083W-Kb
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i18MP-0004vQ-I9
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:08:06 -0400
Received: from mail-db5eur03on0708.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::708]:15984
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i18ML-0004qu-Qp; Fri, 23 Aug 2019 08:08:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bplSGoD4fit54s2XvYhfOCy4TtNu4lekOfm9x2R/hVSV4SWYMUDgn8jw694XI3ppt7vIG3RPBt6TKhnTG7CjHRBB/0JgEQdtuOsDlAb/pEbP2VhLTRIIrM30e4KXQADgOFIAfwZsdMcif8pC0Wof6ZYteGO3xuCek7VwWI8xrqNL2NT6QMAgvxm0CPShUmCHng6TZl9cW+NGLyI2DN8SfYf5YXhR+5gQw9lqwlVPjh11/RiHr0mHSOIUKUUpa3QF4W+ZyFg81/Bi7NLWSkQm0s/PR0d7rF/NDZ67I81iFZIPuVqDnx85kLplc551r7DH7zVZHIZ2vzxzFoYPbCronA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCnmiWd5OTRVUcugnnR2Fe06E4oPeFMNHpL34C/uqRM=;
 b=CfYg1udafXPF02GzFuIwczeaoumxBFM6RtVTkAnfBlMGnePL5hr9kacjXetgdPK4I16GrNHVYV4y4tVz27WVJkixtF+7vE06z6gYir8yJ/++PlEE1PSjdN/dnGOBwxhRuRGomDjoMDgsbjELMBD5QV/hlPAY136bF4AiChnhRdFN6ogXR37wghp1H6FrGmDMRE/76bq33js0+0tf0QE8N3i0EjhISYFJC+wmXYr2rTONt76RvPdsmibAYuDvUwrTwVzOWfjNgVcz/M27FPRyVyNv5ZCa4d1Ioj9QZWl6nzhBoNQExtkDN5wyzV8MupnVWKrY9Zi6Am9pZ9sZlO1PQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCnmiWd5OTRVUcugnnR2Fe06E4oPeFMNHpL34C/uqRM=;
 b=DPQ1LXWA/pGny0ywcI5iMSB0cz5tGUv7E7lBYO+KqSEdVPIe1K7yz5BMVWN5VVbIotEuDpDzzuPAFItfEToti9XI2WGGxmZNOWB8Gffe1CEgmoqf4irdsWB9+0SpRYaVQ+WpxpLcKHjzzAWmasusNlnzhxVC++bkVgUTfmjPb4I=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3056.eurprd08.prod.outlook.com (52.133.14.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 12:07:57 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2157.024; Fri, 23 Aug 2019
 12:07:57 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH] block: workaround for unaligned byte range in fallocate()
Thread-Index: AQHVWRfHNK+M7DbBZ0mb34AZ6lO4bKcHqa4AgAD66wA=
Date: Fri, 23 Aug 2019 12:07:56 +0000
Message-ID: <cce16373-ba65-c276-202c-211c41279355@virtuozzo.com>
References: <1566498661-53008-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <218c5855-a8dc-df50-23cb-ebd1a1cd259c@redhat.com>
In-Reply-To: <218c5855-a8dc-df50-23cb-ebd1a1cd259c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::18) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 590cf434-ab67-4a68-ef79-08d727c288a3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3056; 
x-ms-traffictypediagnostic: VI1PR08MB3056:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB305607F522E986772CDB5D50F4A40@VI1PR08MB3056.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(136003)(39850400004)(366004)(376002)(189003)(199004)(4326008)(52116002)(44832011)(14454004)(2501003)(76176011)(5660300002)(6246003)(107886003)(8676002)(99286004)(36756003)(316002)(476003)(2616005)(53546011)(6506007)(81156014)(81166006)(486006)(386003)(102836004)(6512007)(186003)(7736002)(66446008)(6436002)(66476007)(66556008)(446003)(26005)(2201001)(64756008)(2906002)(11346002)(54906003)(3846002)(25786009)(53936002)(6116002)(229853002)(31686004)(110136005)(8936002)(66066001)(31696002)(86362001)(256004)(66946007)(71200400001)(71190400001)(305945005)(14444005)(6486002)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3056;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K6EBJXTEd+3G43AArgkzPL5wxvdjOOMOdimCGrMQXKGHUkaoVdKLSbMZK6yBuhKWFAlgEBZz0MlQCptp+QEHAKNo3H0qySBdpEzTK84IOJ5zaQrSm9741/wo8fNbnWT2u/VD7WkISYJEt4QFLp5RFbmg9VSGhoMxaxUSoPgn/MKNdG62lyS8i22gUMwofMi5BOshxN0QhpbJPPYtphn2WTy7jr81oFPFhd5G0r2bymPz+mPk4KnzvQU/khJR83A2FJbLisyiCGhuKQHqCv7/ocoQb+bFKC7dXbwzTBYmsTHXYGS/MHIIOaPx8iNpGFwx7vpUB3lCBalu6XGTMog5KkPcnIsID80zdvcpjU165xE4Hh6/QB3zkw2tmy+w3rUPPW3+BhMbdY/rLfSzwZJnj/xbN4f05uqNxPhcsF/rvec=
Content-Type: text/plain; charset="utf-8"
Content-ID: <479D52F2E3CA3041B20B8ECE7B1777CB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590cf434-ab67-4a68-ef79-08d727c288a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 12:07:56.7907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEHSmePmm9jYCJR6zufxfV/iAcDmVj9E83cKoipgc9SA0S3wop/BMm+onnZJEooTVuZA//t6+EWZCqxzOInpghoZVEE/NTCHUZrIiPVpnJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3056
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0a::708
Subject: Re: [Qemu-devel] [PATCH] block: workaround for unaligned byte range
 in fallocate()
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDIzLzA4LzIwMTkgMDA6MDksIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDgvMjIvMTkg
MTozMSBQTSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+PiBSZXZlcnQgdGhlIGNvbW1pdCAx
MThmOTk0NDJkICdibG9jay9pby5jOiBmaXggZm9yIHRoZSBhbGxvY2F0aW9uIGZhaWx1cmUnDQo+
PiBhbmQgbWFrZSBiZXR0ZXIgZXJyb3IgaGFuZGxpbmcgZm9yIHRoZSBmaWxlIHN5c3RlbXMgdGhh
dCBkbyBub3Qgc3VwcG9ydA0KPiANCj4gcy9tYWtlL3VzZS8NCj4gDQo+PiBmYWxsb2NhdGUoKSBm
b3IgdGhlIHVuYWxpZ25lZCBieXRlIHJhbmdlLiBBbGxvdyBmYWxsaW5nIGJhY2sgdG8gcHdyaXRl
DQo+IA0KPiBzL3RoZS9hbi8NCj4gDQo+PiBpbiBjYXNlIGZhbGxvY2F0ZSgpIHJldHVybnMgRUlO
VkFMLg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT4N
Cj4+IFN1Z2dlc3RlZC1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpv
LmNvbT4NCj4+IC0tLQ0KPj4gRGlzY3Vzc2VkIGluIGVtYWlsIHRocmVhZCB3aXRoIHRoZSBtZXNz
YWdlIElEDQo+PiA8MTU1NDQ3NDI0NC01NTM2NjEtMS1naXQtc2VuZC1lbWFpbC1hbmRyZXkuc2hp
bmtldmljaEB2aXJ0dW96em8uY29tPg0KPj4NCj4+ICAgYmxvY2svZmlsZS1wb3NpeC5jIHwgNyAr
KysrKysrDQo+PiAgIGJsb2NrL2lvLmMgICAgICAgICB8IDIgKy0NCj4+ICAgMiBmaWxlcyBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
YmxvY2svZmlsZS1wb3NpeC5jIGIvYmxvY2svZmlsZS1wb3NpeC5jDQo+PiBpbmRleCBmYmViMDA2
Li4yYzI1NGZmIDEwMDY0NA0KPj4gLS0tIGEvYmxvY2svZmlsZS1wb3NpeC5jDQo+PiArKysgYi9i
bG9jay9maWxlLXBvc2l4LmMNCj4+IEBAIC0xNTg4LDYgKzE1ODgsMTMgQEAgc3RhdGljIGludCBo
YW5kbGVfYWlvY2Jfd3JpdGVfemVyb2VzKHZvaWQgKm9wYXF1ZSkNCj4+ICAgICAgIGlmIChzLT5o
YXNfd3JpdGVfemVyb2VzKSB7DQo+PiAgICAgICAgICAgaW50IHJldCA9IGRvX2ZhbGxvY2F0ZShz
LT5mZCwgRkFMTE9DX0ZMX1pFUk9fUkFOR0UsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBhaW9jYi0+YWlvX29mZnNldCwgYWlvY2ItPmFpb19uYnl0ZXMpOw0KPj4gKyAgICAg
ICAgaWYgKHJldCA9PSAtRUlOVkFMKSB7DQo+PiArICAgICAgICAgICAgLyoNCj4+ICsgICAgICAg
ICAgICAgKiBBbGxvdyBmYWxsaW5nIGJhY2sgdG8gcHdyaXRlIGZvciBmaWxlIHN5c3RlbXMgdGhh
dA0KPj4gKyAgICAgICAgICAgICAqIGRvIG5vdCBzdXBwb3J0IGZhbGxvY2F0ZSgpIGZvciB1bmFs
aWduZWQgYnl0ZSByYW5nZS4NCj4gDQo+IHMvZm9yL2ZvciBhbi8NCj4gDQo+PiArICAgICAgICAg
ICAgICovDQo+PiArICAgICAgICAgICAgcmV0dXJuIC1FTk9UU1VQOw0KPj4gKyAgICAgICAgfQ0K
Pj4gICAgICAgICAgIGlmIChyZXQgPT0gMCB8fCByZXQgIT0gLUVOT1RTVVApIHsNCj4+ICAgICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICAgICAgICAgICB9DQo+PiBkaWZmIC0tZ2l0IGEvYmxv
Y2svaW8uYyBiL2Jsb2NrL2lvLmMNCj4+IGluZGV4IDU2YmJmMTkuLjU4ZjA4Y2QgMTAwNjQ0DQo+
PiAtLS0gYS9ibG9jay9pby5jDQo+PiArKysgYi9ibG9jay9pby5jDQo+PiBAQCAtMTU1OCw3ICsx
NTU4LDcgQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmRydl9jb19kb19wd3JpdGVfemVyb2Vz
KEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4gICAgICAgICAgICAgICBhc3NlcnQoIWJzLT5zdXBw
b3J0ZWRfemVyb19mbGFncyk7DQo+PiAgICAgICAgICAgfQ0KPj4gICANCj4+IC0gICAgICAgIGlm
IChyZXQgPCAwICYmICEoZmxhZ3MgJiBCRFJWX1JFUV9OT19GQUxMQkFDSykpIHsNCj4+ICsgICAg
ICAgIGlmIChyZXQgPT0gLUVOT1RTVVAgJiYgIShmbGFncyAmIEJEUlZfUkVRX05PX0ZBTExCQUNL
KSkgew0KPj4gICAgICAgICAgICAgICAvKiBGYWxsIGJhY2sgdG8gYm91bmNlIGJ1ZmZlciBpZiB3
cml0ZSB6ZXJvZXMgaXMgdW5zdXBwb3J0ZWQgKi8NCj4+ICAgICAgICAgICAgICAgQmRydlJlcXVl
c3RGbGFncyB3cml0ZV9mbGFncyA9IGZsYWdzICYgfkJEUlZfUkVRX1pFUk9fV1JJVEU7DQo+PiAg
IA0KPj4NCj4gDQo+IFJldmlld2VkLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4N
Cj4gDQoNClRoYW5rIHlvdSBFcmljIQ0KQWxzbywgSSB3b3VsZCBwcmVmZXIgIm1ha2UgdGhlIGZp
bmVyIGVycm9yIGhhbmRsaW5nIiBiZWNhdXNlIHRoZSB3b3JkIA0KJ2JldHRlcicgaGFzIGEgd2lk
ZSBzZW5zZS4NCkkgaGF2ZSBwcmVwYXJlZCB0aGUgdjIgd2l0aCB5b3VyIGNvcnJlY3Rpb25zIGFu
ZCBhbSB3YWl0aW5nIGZvciBEZW5pcyANCkx1bmV2J3MgcmVzcG9uc2UuIEhlIGlzIGNvbWluZyBi
YWNrIHRvIHdvcmsgZnJvbSBoaXMgdmFjYXRpb24gb24gVHVlc2RheS4NCg0KQW5kcmV5DQotLSAN
CldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQo=

