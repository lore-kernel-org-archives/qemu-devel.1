Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012AFECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D0E2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SfU4RqCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D0E2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9wj-0001im-0u
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iL9Pm-0004aL-Jv
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iL9Pl-0001yy-9K
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:18:18 -0400
Received: from mail-eopbgr140135.outbound.protection.outlook.com
 ([40.107.14.135]:4933 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iL9Pb-0001vK-3j; Thu, 17 Oct 2019 13:18:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yaz5XpDCtLY0dKhYr0IRC2EB5t2xtHlhohCTTkLekASrs4fXdSZoWGV9cjtDTkt+QwOuz7lc5qxjatqC8hxXf7/4m6r+JiYaS0ifk6X+n66HVFD0DD0LzuTwejzs6lhKfeoZc47qb4OxmfYwbheqpBeeqJJj8goasroNyJnTczD5LTsQhf7V5HY7SKnvHuvNuJRzuMicILlWyZwCKfe4LTPFUqtoGqfLqzLAzeriOmrAKJSUzIFJqyniHfMlcuQ1kerK8DduxOyfe5D4/6qMefS1m3H3K3oj7up34feVeu+AI10W1CIPJUVFDCgwASTZB7VjidYG8g6a20dou2R/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pf6gFi1SspuVMR3cc9aSgK37CXGp/d5wTSgbjq399TE=;
 b=QH2vnpYz4HeY/syYfH+FJa6jA6UWQokRIzFglH6nnf7IfURtcdfVsSTQMqrkrMuK9mEhUp9Hk4vQnIMTUXuIjTKxjAR5eG5AWo3X2B5xhq4o5fCnuGbu/19wtD+tMwFGq1fvXa5lYJB7PRGXp+F42ONPV1K5wWgh5VJK4ZUoG0cGjjJjG4l384+buE0BlJdefb3LJZNfpzF1N84eA1FOslQnUBDpHFKvIfhY6kieaHKd//3F6xJ1Y+69sXQgVs4Qowe292qn+f0/U+p8QEfupeI537abeTHgt6CrkxzX7Ch5wVFq7FG1QYFo39j8UaCovS+Q+uKHmc+VHpjRPCKV7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pf6gFi1SspuVMR3cc9aSgK37CXGp/d5wTSgbjq399TE=;
 b=SfU4RqCQeIk8yKfUeK3t2F157gTiUVvpwYSpOwcBvNeGRm/Q4sAkqL3qdeflZoTPCt3XS3u0KowPUVca0YvIUyrbDVOWM0/T8YRTttcit5bbSBJ+Fe6YnsXVo7QBO7dlrtHYv4ltxUv2LMYhdj031PiSUdVl0e4PSmF7RQNZ4Sw=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB5539.eurprd08.prod.outlook.com (20.179.33.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Thu, 17 Oct 2019 17:18:00 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 17:18:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 3/4] tests/qemu-iotests: add case to write compressed
 data of multiple clusters
Thread-Topic: [PATCH v4 3/4] tests/qemu-iotests: add case to write compressed
 data of multiple clusters
Thread-Index: AQHVhD7Yoi9zUa6WJEqUBiigbTsO3adfFSWA
Date: Thu, 17 Oct 2019 17:18:00 +0000
Message-ID: <2385abe2-cfd0-4d13-ce6a-bde10a884381@virtuozzo.com>
References: <1571243333-882302-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1571243333-882302-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1571243333-882302-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::24)
 To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191017201757126
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ce33e7a-a126-404d-ed54-08d75325f5a2
x-ms-traffictypediagnostic: AM0PR08MB5539:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB553908FA2725DAE967EDCE43C16D0@AM0PR08MB5539.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(346002)(39850400004)(376002)(366004)(189003)(199004)(316002)(2616005)(107886003)(6246003)(31686004)(14454004)(7736002)(6436002)(186003)(476003)(486006)(256004)(446003)(102836004)(11346002)(76176011)(52116002)(110136005)(54906003)(26005)(229853002)(66446008)(6506007)(386003)(6486002)(99286004)(6512007)(305945005)(2906002)(2501003)(31696002)(3846002)(4326008)(64756008)(66946007)(66556008)(66476007)(71190400001)(6116002)(25786009)(66066001)(8676002)(2201001)(5660300002)(36756003)(478600001)(8936002)(81156014)(81166006)(86362001)(71200400001)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5539;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XfKKYiXh2aWGYy1TpqGcU3iiRbr4nRV74JJ+kWQPmw3sZE7Rc0DNvUSHLi1nedhAb1EaaSu4IANOFRPFJFqrpWuBd8p7l/ETbuoyR/3oGAVodhMVF7KlMxd4aqVkhdV/vhr5qURT8/L8p3CtP4azVmD37Rk3xZLAJtMRR/zwsVRYH12r85XIrMf95mHspWYH3KwV3jnvWcz9kZgvw28hfBuOxSK9hPcAzescHY89t4imTFLlrzzwOuAFZvTB/fWaeGd+NESlu3VMIwaK6kovEtT0ZN6udXIPVv0grMVduBHCU/ZyRuyd2N/ClE5p9BCy+skiH5uF+lKd3ZPuWy+R5mBD5TX9m4seR81bxgpyKDYyORLBlOTrVTexfG+wAxTr74LfF57mYB1/J4u7O7ZItlFvi2PZGy/tnUnRPAvXP2s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <266824F5DEFB974EAC96630C30BE8EE0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce33e7a-a126-404d-ed54-08d75325f5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 17:18:00.2821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWbGZ0ymmSg0R2NrPwqnO3rrGsQl6KgqdJA6+xE0j7GLB347RydOq4+weEYln8vW+N+foNbvL0oAUoVMVyF1A3N0/5b5dhp6YCNs6FBUjn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5539
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.135
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
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTYuMTAuMjAxOSAxOToyOCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IEFkZCB0aGUgdGVz
dCBjYXNlIHRvIHRoZSBpb3Rlc3QgIzIxNCB0aGF0IGNoZWNrcyBwb3NzaWJpbGl0eSBvZiB3cml0
aW5nDQo+IGNvbXByZXNzZWQgZGF0YSBvZiBtb3JlIHRoYW4gb25lIGNsdXN0ZXIgc2l6ZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2
aXJ0dW96em8uY29tPg0KPiAtLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjE0ICAgICB8IDM1
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgdGVzdHMvcWVtdS1pb3Rl
c3RzLzIxNC5vdXQgfCAxNSArKysrKysrKysrKysrKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDUw
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMjE0
IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzIxNA0KPiBpbmRleCAyMWVjOGEyLi4wMDAzZGMyIDEwMDc1
NQ0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMjE0DQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90
ZXN0cy8yMTQNCj4gQEAgLTg5LDYgKzg5LDQxIEBAIF9jaGVja190ZXN0X2ltZyAtciBhbGwNCj4g
ICAkUUVNVV9JTyAtYyAicmVhZCAgLVAgMHgxMSAgMCA0TSIgIiRURVNUX0lNRyIgMj4mMSB8IF9m
aWx0ZXJfcWVtdV9pbyB8IF9maWx0ZXJfdGVzdGRpcg0KPiAgICRRRU1VX0lPIC1jICJyZWFkICAt
UCAweDIyIDRNIDRNIiAiJFRFU1RfSU1HIiAyPiYxIHwgX2ZpbHRlcl9xZW11X2lvIHwgX2ZpbHRl
cl90ZXN0ZGlyDQo+ICAgDQo+ICtlY2hvDQo+ICtlY2hvICI9PT0gV3JpdGUgY29tcHJlc3NlZCBk
YXRhIG9mIG11bHRpcGxlIGNsdXN0ZXJzID09PSINCj4gK2VjaG8NCj4gK2NsdXN0ZXJfc2l6ZT0w
eDEwMDAwDQo+ICtfbWFrZV90ZXN0X2ltZyAyTSAtbyBjbHVzdGVyX3NpemU9JGNsdXN0ZXJfc2l6
ZQ0KPiArDQo+ICtlY2hvICJVbmNvbXByZXNzZWQgZGF0YToiDQo+ICtsZXQgZGF0YV9zaXplPSI4
ICogJGNsdXN0ZXJfc2l6ZSINCj4gKyRRRU1VX0lPIC1jICJ3cml0ZSAtUCAweGFhIDAgJGRhdGFf
c2l6ZSIgIiRURVNUX0lNRyIgXA0KPiArICAgICAgICAgMj4mMSB8IF9maWx0ZXJfcWVtdV9pbyB8
IF9maWx0ZXJfdGVzdGRpcg0KPiArJFFFTVVfSU1HIGluZm8gIiRURVNUX0lNRyIgfCBzZWQgLW4g
Jy9kaXNrIHNpemU6LyBzL14gKi8vcCcNCg0KaG1tLCBJJ20gYWZyYWlkLCAiZGlzayBzaXplIiBp
cyB1bnN0YWJsZSB0aGluZyBmb3IgaW90ZXN0cy4gQ29uc2lkZXINCmJhY2twb3J0aW5nOiBvdGhl
ciBzaXplIG9mIG1ldGFkYXRhIGluIHFjb3cyIGltYWdlLCBhbmQgd2UnbGwgaGF2ZSB0bw0KZml4
IHRoaXMgdGVzdCBvZnRlbi4uDQoNCklmIHlvdSB3YW50IHRvIGNoZWNrLCB0aGF0IGNsdXN0ZXJz
IGFyZSBjb21wcmVzc2VkLCB5b3UgbWF5IHVzZQ0KcWVtdS1pbWcgY2hlY2sgKHdpdGggb3Igd2l0
aG91dCAtLW91dHB1dD1qc29uKSwgaXQgc2hvd3MgYW1vdW50IG9mDQpjb21wcmVzc2VkIGNsdXN0
ZXJzLg0KDQo+ICsNCj4gK19tYWtlX3Rlc3RfaW1nIDJNIC1vIGNsdXN0ZXJfc2l6ZT0kY2x1c3Rl
cl9zaXplDQo+ICtsZXQgZGF0YV9zaXplPSIzICogJGNsdXN0ZXJfc2l6ZSArICgkY2x1c3Rlcl9z
aXplID4+IDEpIg0KDQpJJ2QgYmUgYSBiaXQgbW9yZSBoYXBweSB3aXRoICRjbHVzdGVyX3NpemUg
LyAyLCBzdGlsbCwgaGFwcGluZXNzIGFuZA0KYmFzaCBzY3JpcHRzIGFyZSBpbmNvbXBhdGlibGUg
YW55d2F5Lg0KDQo+ICsjIFNldCBjb21wcmVzcz1vbi4gVGhhdCB3aWxsIGFsaWduIHRoZSB3cml0
dGVuIGRhdGENCj4gKyMgYnkgdGhlIGNsdXN0ZXIgc2l6ZSBhbmQgd2lsbCB3cml0ZSB0aGVtIGNv
bXByZXNzZWQuDQo+ICtRRU1VX0lPX09QVElPTlM9JFFFTVVfSU9fT1BUSU9OU19OT19GTVQgXA0K
PiArJFFFTVVfSU8gLWMgIndyaXRlIC1QIDB4YmIgMCAkZGF0YV9zaXplIiAtLWltYWdlLW9wdHMg
XA0KPiArICAgICAgICAgZHJpdmVyPSRJTUdGTVQsY29tcHJlc3M9b24sZmlsZS5maWxlbmFtZT0k
VEVTVF9JTUcgXA0KPiArICAgICAgICAgMj4mMSB8IF9maWx0ZXJfcWVtdV9pbyB8IF9maWx0ZXJf
dGVzdGRpcg0KPiArDQo+ICtsZXQgb2Zmc2V0PSI0ICogJGNsdXN0ZXJfc2l6ZSINCj4gK1FFTVVf
SU9fT1BUSU9OUz0kUUVNVV9JT19PUFRJT05TX05PX0ZNVCBcDQo+ICskUUVNVV9JTyAtYyAid3Jp
dGUgLVAgMHhjYyAkb2Zmc2V0ICRkYXRhX3NpemUiICJqc29uOntcDQo+ICsgICAgJ2RyaXZlcic6
ICckSU1HRk1UJywNCj4gKyAgICAnZmlsZSc6IHsNCj4gKyAgICAgICAgJ2RyaXZlcic6ICdmaWxl
JywNCj4gKyAgICAgICAgJ2ZpbGVuYW1lJzogJyRURVNUX0lNRycNCj4gKyAgICB9LA0KPiArICAg
ICdjb21wcmVzcyc6IHRydWUNCj4gK30iIHwgX2ZpbHRlcl9xZW11X2lvIHwgX2ZpbHRlcl90ZXN0
ZGlyDQo+ICsNCg0KSXQgd291bGQgYmUgZ29vZCB0byBhZGQgY2FzZSB3aXRoIHVuYWxpZ25lZCBv
ZmZzZXQgYXMgd2VsbC4gQW5kLCBtYXliZSwNCmNoZWNrIHRoYXQgd2UgZG9uJ3QgcmV3cml0ZSBl
eGlzdGluZyBkYXRhIGluIHBhcnRpYWwgY2x1c3RlcnMgd2hlbiB3cml0aW5nDQp1bmFsaWduZWQg
Y29tcHJlc3NlZCBkYXRhIG92ZXIgaXQuDQoNCj4gK2VjaG8gIkFmdGVyIHRoZSBtdWx0aXBsZSBj
bHVzdGVyIGRhdGEgaGF2ZSBiZWVuIHdyaXR0ZW4gY29tcHJlc3NlZCwiDQo+ICskUUVNVV9JTUcg
aW5mbyAiJFRFU1RfSU1HIiB8IHNlZCAtbiAnL2Rpc2sgc2l6ZTovIHMvXiAqLy9wJw0KPiArDQo+
ICAgIyBzdWNjZXNzLCBhbGwgZG9uZQ0KPiAgIGVjaG8gJyoqKiBkb25lJw0KPiAgIHJtIC1mICRz
ZXEuZnVsbA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzIxNC5vdXQgYi90ZXN0
cy9xZW11LWlvdGVzdHMvMjE0Lm91dA0KPiBpbmRleCAwZmNkOGRjLi4wOWEyZTlhIDEwMDY0NA0K
PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMjE0Lm91dA0KPiArKysgYi90ZXN0cy9xZW11LWlv
dGVzdHMvMjE0Lm91dA0KPiBAQCAtMzIsNCArMzIsMTkgQEAgcmVhZCA0MTk0MzA0LzQxOTQzMDQg
Ynl0ZXMgYXQgb2Zmc2V0IDANCj4gICA0IE1pQiwgWCBvcHM7IFhYOlhYOlhYLlggKFhYWCBZWVkv
c2VjIGFuZCBYWFggb3BzL3NlYykNCj4gICByZWFkIDQxOTQzMDQvNDE5NDMwNCBieXRlcyBhdCBv
ZmZzZXQgNDE5NDMwNA0KPiAgIDQgTWlCLCBYIG9wczsgWFg6WFg6WFguWCAoWFhYIFlZWS9zZWMg
YW5kIFhYWCBvcHMvc2VjKQ0KPiArDQo+ICs9PT0gV3JpdGUgY29tcHJlc3NlZCBkYXRhIG9mIG11
bHRpcGxlIGNsdXN0ZXJzID09PQ0KPiArDQo+ICtGb3JtYXR0aW5nICdURVNUX0RJUi90LklNR0ZN
VCcsIGZtdD1JTUdGTVQgc2l6ZT0yMDk3MTUyDQo+ICtVbmNvbXByZXNzZWQgZGF0YToNCj4gK3dy
b3RlIDUyNDI4OC81MjQyODggYnl0ZXMgYXQgb2Zmc2V0IDANCj4gKzUxMiBLaUIsIFggb3BzOyBY
WDpYWDpYWC5YIChYWFggWVlZL3NlYyBhbmQgWFhYIG9wcy9zZWMpDQo+ICtkaXNrIHNpemU6IDc3
MiBLaUINCj4gK0Zvcm1hdHRpbmcgJ1RFU1RfRElSL3QuSU1HRk1UJywgZm10PUlNR0ZNVCBzaXpl
PTIwOTcxNTINCj4gK3dyb3RlIDIyOTM3Ni8yMjkzNzYgYnl0ZXMgYXQgb2Zmc2V0IDANCj4gKzIy
NCBLaUIsIFggb3BzOyBYWDpYWDpYWC5YIChYWFggWVlZL3NlYyBhbmQgWFhYIG9wcy9zZWMpDQo+
ICt3cm90ZSAyMjkzNzYvMjI5Mzc2IGJ5dGVzIGF0IG9mZnNldCAyNjIxNDQNCj4gKzIyNCBLaUIs
IFggb3BzOyBYWDpYWDpYWC5YIChYWFggWVlZL3NlYyBhbmQgWFhYIG9wcy9zZWMpDQo+ICtBZnRl
ciB0aGUgbXVsdGlwbGUgY2x1c3RlciBkYXRhIGhhdmUgYmVlbiB3cml0dGVuIGNvbXByZXNzZWQs
DQo+ICtkaXNrIHNpemU6IDI2OCBLaUINCj4gICAqKiogZG9uZQ0KPiANCg0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=

