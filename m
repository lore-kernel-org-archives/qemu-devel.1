Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD9DC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4D9217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FHLopXYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4D9217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbpMs-0001Bl-Gu
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 12:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46524)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbpJD-00083j-MK
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbpJ9-0003MO-8a
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:44:09 -0400
Received: from mail-eopbgr30111.outbound.protection.outlook.com
 ([40.107.3.111]:61037 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbpJ6-0003GD-Av; Fri, 14 Jun 2019 12:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqjUAJbaZnxtfIbjv0AD6qEmKNhye2ggaIo26CrXIVo=;
 b=FHLopXYCT9Py9IiEqfokkVhz5ecDrKzcWeaNjpxBB0nlhdKm4f6pDN6Rb+4ylNKqrSg4EHTp4vPHUjjidZ8n2TsMVmdGomaWgWDUibXuMkWzm4ZBhq62CgoB04X702mDrT47UatzJ65IE5uhqVJwETHd5aIz/nMFjdSY652G3J8=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3649.eurprd08.prod.outlook.com (20.177.43.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 16:43:55 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 16:43:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 15/42] block: Re-evaluate backing file handling in
 reopen
Thread-Index: AQHVIWuwf7wnR9ymBkSFfDsy80Nj7qabKxeAgAAkiACAAA4+AA==
Date: Fri, 14 Jun 2019 16:43:55 +0000
Message-ID: <d876643d-862d-0e19-4dc9-0df55e9aeebf@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-16-mreitz@redhat.com>
 <9e448427-1d53-c1a7-c51f-123acf6eccaf@virtuozzo.com>
 <3f7ec115-9014-e375-ac7a-4b1ea46873e6@redhat.com>
In-Reply-To: <3f7ec115-9014-e375-ac7a-4b1ea46873e6@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0013.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::23) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614194354199
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 846a7423-45db-4b3b-7f35-08d6f0e77d9f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3649; 
x-ms-traffictypediagnostic: AM0PR08MB3649:
x-microsoft-antispam-prvs: <AM0PR08MB3649A08915A02AF203F2A052C1EE0@AM0PR08MB3649.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39850400004)(346002)(376002)(136003)(189003)(199004)(4326008)(73956011)(31696002)(316002)(14454004)(6116002)(478600001)(66476007)(86362001)(8936002)(2501003)(54906003)(2906002)(71190400001)(229853002)(6436002)(3846002)(66946007)(71200400001)(6486002)(53936002)(66446008)(64756008)(6512007)(66556008)(36756003)(11346002)(53546011)(110136005)(25786009)(486006)(14444005)(256004)(31686004)(81166006)(2616005)(476003)(68736007)(386003)(305945005)(186003)(52116002)(76176011)(446003)(7736002)(26005)(8676002)(6506007)(102836004)(81156014)(99286004)(66066001)(6246003)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3649;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xSeAwfdvgtbLI/sjp+JfwmC5wYrm5WBKcAhlLGwjol2cGpM2dgDaCOIfDBkH6ZP80LuY64wtwxR3Rr3UWyNjyJFb+wgeg3VCHrTcUPh58uZ4Eo8FWlPdcs9z+NnmkAanVWMAuLCsg8g1eTACc2zsnVHK1b9gL9VzzAypGKjpFm0cajtKNfN+7NQSNh9SqPYG1HHRR1PyK8KNm7SwXOjl7wduotJ2oiMHxgTeOrEfAsZpWz00BYStB+H10fu/r1JM/BPVYHZxeNZ1WP7oN1KJzWSE5JrtS+9+Elfh3lM+euRHAlOcm0joyjIYxWx9ksgUIfvW56sdijoZ71Dij0WdabvVYGBXhTR8JBkcVg2e3VWwOVKGzIU5bU1jFVkUe1glC7Vm6jXa5+THG0zevfPdw2dX8T0RPVjARWE1xVIR2Bc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3887A34AE722C43A8A9257AD27B59F9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846a7423-45db-4b3b-7f35-08d6f0e77d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 16:43:55.7399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3649
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.111
Subject: Re: [Qemu-devel] [PATCH v5 15/42] block: Re-evaluate backing file
 handling in reopen
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTQuMDYuMjAxOSAxODo1MiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNC4wNi4xOSAxNTo0Miwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEzLjA2LjIwMTkgMTowOSwg
TWF4IFJlaXR6IHdyb3RlOg0KPj4+IFJlb3BlbmluZyBhIG5vZGUncyBiYWNraW5nIGNoaWxkIG5l
ZWRzIGEgYml0IG9mIHNwZWNpYWwgaGFuZGxpbmcgYmVjYXVzZQ0KPj4+IHRoZSAiYmFja2luZyIg
Y2hpbGQgaGFzIGRpZmZlcmVudCBkZWZhdWx0cyB0aGFuIGFsbCBvdGhlciBjaGlsZHJlbg0KPj4+
IChhbW9uZyBvdGhlciB0aGluZ3MpLiAgQWRkaW5nIGZpbHRlciBzdXBwb3J0IGhlcmUgaXMgYSBi
aXQgbW9yZQ0KPj4+IGRpZmZpY3VsdCB0aGFuIGp1c3QgdXNpbmcgdGhlIGNoaWxkIGFjY2VzcyBm
dW5jdGlvbnMuICBJbiBmYWN0LCB3ZSBvZnRlbg0KPj4+IGhhdmUgdG8gZGlyZWN0bHkgdXNlIGJz
LT5iYWNraW5nIGJlY2F1c2UgdGhlc2UgZnVuY3Rpb25zIGFyZSBhYm91dCB0aGUNCj4+PiAiYmFj
a2luZyIgY2hpbGQgKHdoaWNoIG1heSBvciBtYXkgbm90IGJlIHRoZSBDT1cgYmFja2luZyBmaWxl
KS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+
DQo+Pj4gLS0tDQo+Pj4gICAgYmxvY2suYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLQ0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCA3IGRl
bGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrLmMgYi9ibG9jay5jDQo+Pj4g
aW5kZXggNTA1YjNlOWEwMS4uZGIyNzU5YzEwZCAxMDA2NDQNCj4+PiAtLS0gYS9ibG9jay5jDQo+
Pj4gKysrIGIvYmxvY2suYw0KPj4+IEBAIC0zNTQyLDE3ICszNTQyLDM5IEBAIHN0YXRpYyBpbnQg
YmRydl9yZW9wZW5fcGFyc2VfYmFja2luZyhCRFJWUmVvcGVuU3RhdGUgKnJlb3Blbl9zdGF0ZSwN
Cj4+PiAgICAgICAgICAgIH0NCj4+PiAgICAgICAgfQ0KPj4+ICAgIA0KPj4+ICsgICAgLyoNCj4+
PiArICAgICAqIEVuc3VyZSB0aGF0IEBicyBjYW4gcmVhbGx5IGhhbmRsZSBiYWNraW5nIGZpbGVz
LCBiZWNhdXNlIHdlIGFyZQ0KPj4+ICsgICAgICogYWJvdXQgdG8gZ2l2ZSBpdCBvbmUgKG9yIHN3
YXAgdGhlIGV4aXN0aW5nIG9uZSkNCj4+PiArICAgICAqLw0KPj4+ICsgICAgaWYgKGJzLT5kcnYt
PmlzX2ZpbHRlcikgew0KPj4+ICsgICAgICAgIC8qIEZpbHRlcnMgYWx3YXlzIGhhdmUgYSBmaWxl
IG9yIGEgYmFja2luZyBjaGlsZCAqLw0KPj4+ICsgICAgICAgIGlmICghYnMtPmJhY2tpbmcpIHsN
Cj4+PiArICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiJyVzJyBpcyBhICVzIGZpbHRlciBu
b2RlIHRoYXQgZG9lcyBub3Qgc3VwcG9ydCBhICINCj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAiYmFja2luZyBjaGlsZCIsIGJzLT5ub2RlX25hbWUsIGJzLT5kcnYtPmZvcm1hdF9uYW1lKTsN
Cj4+PiArICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+Pj4gKyAgICAgICAgfQ0KPj4+ICsg
ICAgfSBlbHNlIGlmICghYnMtPmRydi0+c3VwcG9ydHNfYmFja2luZykgew0KPj4+ICsgICAgICAg
IGVycm9yX3NldGcoZXJycCwgIkRyaXZlciAnJXMnIG9mIG5vZGUgJyVzJyBkb2VzIG5vdCBzdXBw
b3J0IGJhY2tpbmcgIg0KPj4+ICsgICAgICAgICAgICAgICAgICAgImZpbGVzIiwgYnMtPmRydi0+
Zm9ybWF0X25hbWUsIGJzLT5ub2RlX25hbWUpOw0KPj4+ICsgICAgICAgIHJldHVybiAtRUlOVkFM
Ow0KPj4+ICsgICAgfQ0KPj4NCj4+IGhtbSwgc2hvdWxkbid0IHdlIGhhdmUgdGhlc2UgY2hlY2tz
IGZvciBvdmVybGF5X2JzPw0KPiANCj4gSSB0aGluayB0aGlzIGlzIGNvcnJlY3QgaGVyZSBiZWNh
dXNlIHRoaXMgaXMgdGhlIG9ubHkgbm9kZSB0aGUgdXNlciBoYXMNCj4gY29udHJvbCBvdmVyLCBz
byB0aGlzIGlzIHRoZSBvbmx5IG9uZSB3ZSBjYW4gcmVhc29uYWJseSBjb21wbGFpbiBhYm91dC4N
Cj4gDQo+IEFuZCBJIGRvIHRoaW5rIGl0IGlzIHJlYXNvbmFibGUgdG8gY29tcGxhaW4gYWJvdXQu
DQo+IA0KPj4+ICsNCj4+PiAgICAgICAgLyoNCj4+PiAgICAgICAgICogRmluZCB0aGUgImFjdHVh
bCIgYmFja2luZyBmaWxlIGJ5IHNraXBwaW5nIGFsbCBsaW5rcyB0aGF0IHBvaW50DQo+Pj4gICAg
ICAgICAqIHRvIGFuIGltcGxpY2l0IG5vZGUsIGlmIGFueSAoZS5nLiBhIGNvbW1pdCBmaWx0ZXIg
bm9kZSkuDQo+Pj4gKyAgICAgKiBXZSBjYW5ub3QgdXNlIGFueSBvZiB0aGUgYmRydl9za2lwXyoo
KSBmdW5jdGlvbnMgaGVyZSBiZWNhdXNlDQo+Pj4gKyAgICAgKiB0aG9zZSByZXR1cm4gdGhlIGZp
cnN0IGV4cGxpY2l0IG5vZGUsIHdoaWxlIHdlIGFyZSBsb29raW5nIGZvcg0KPj4+ICsgICAgICog
aXRzIG92ZXJsYXkgaGVyZS4NCj4+PiAgICAgICAgICovDQo+Pj4gICAgICAgIG92ZXJsYXlfYnMg
PSBiczsNCj4+PiAtICAgIHdoaWxlIChiYWNraW5nX2JzKG92ZXJsYXlfYnMpICYmIGJhY2tpbmdf
YnMob3ZlcmxheV9icyktPmltcGxpY2l0KSB7DQo+Pj4gLSAgICAgICAgb3ZlcmxheV9icyA9IGJh
Y2tpbmdfYnMob3ZlcmxheV9icyk7DQo+Pj4gKyAgICB3aGlsZSAoYmRydl9maWx0ZXJlZF9icyhv
dmVybGF5X2JzKSAmJg0KPj4+ICsgICAgICAgICAgIGJkcnZfZmlsdGVyZWRfYnMob3ZlcmxheV9i
cyktPmltcGxpY2l0KQ0KPj4+ICsgICAgew0KPj4+ICsgICAgICAgIG92ZXJsYXlfYnMgPSBiZHJ2
X2ZpbHRlcmVkX2JzKG92ZXJsYXlfYnMpOw0KPj4+ICAgICAgICB9DQo+Pg0KPj4gaGVyZSwgb3Zl
cmxheV9icyBtYXkgYmUgc29tZSBmaWx0ZXIgd2l0aCBmaWxlIGNoaWxkIC4uDQo+Pg0KPj4+ICAg
IA0KPj4+ICAgICAgICAvKiBJZiB3ZSB3YW50IHRvIHJlcGxhY2UgdGhlIGJhY2tpbmcgZmlsZSB3
ZSBuZWVkIHNvbWUgZXh0cmEgY2hlY2tzICovDQo+Pj4gLSAgICBpZiAobmV3X2JhY2tpbmdfYnMg
IT0gYmFja2luZ19icyhvdmVybGF5X2JzKSkgew0KPj4+ICsgICAgaWYgKG5ld19iYWNraW5nX2Jz
ICE9IGJkcnZfZmlsdGVyZWRfYnMob3ZlcmxheV9icykpIHsNCj4+PiAgICAgICAgICAgIC8qIENo
ZWNrIGZvciBpbXBsaWNpdCBub2RlcyBiZXR3ZWVuIGJzIGFuZCBpdHMgYmFja2luZyBmaWxlICov
DQo+Pj4gICAgICAgICAgICBpZiAoYnMgIT0gb3ZlcmxheV9icykgew0KPj4+ICAgICAgICAgICAg
ICAgIGVycm9yX3NldGcoZXJycCwgIkNhbm5vdCBjaGFuZ2UgYmFja2luZyBsaW5rIGlmICclcycg
aGFzICINCj4+PiBAQCAtMzU2MCw4ICszNTgyLDggQEAgc3RhdGljIGludCBiZHJ2X3Jlb3Blbl9w
YXJzZV9iYWNraW5nKEJEUlZSZW9wZW5TdGF0ZSAqcmVvcGVuX3N0YXRlLA0KPj4+ICAgICAgICAg
ICAgICAgIHJldHVybiAtRVBFUk07DQo+Pj4gICAgICAgICAgICB9DQo+Pj4gICAgICAgICAgICAv
KiBDaGVjayBpZiB0aGUgYmFja2luZyBsaW5rIHRoYXQgd2Ugd2FudCB0byByZXBsYWNlIGlzIGZy
b3plbiAqLw0KPj4+IC0gICAgICAgIGlmIChiZHJ2X2lzX2JhY2tpbmdfY2hhaW5fZnJvemVuKG92
ZXJsYXlfYnMsIGJhY2tpbmdfYnMob3ZlcmxheV9icyksDQo+Pj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZXJycCkpIHsNCj4+PiArICAgICAgICBpZiAoYmRydl9p
c19iYWNraW5nX2NoYWluX2Zyb3plbihvdmVybGF5X2JzLA0KPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNoaWxkX2JzKG92ZXJsYXlfYnMtPmJhY2tpbmcpLCBl
cnJwKSkgew0KPj4NCj4+IC4uIGFuZCBoZXJlIHdlIGFyZSBkb2luZyB3cm9uZyB0aGluZywgYXMg
aXQgZG9uJ3QgaGF2ZSBiYWNraW5nIGNoaWxkDQo+Pg0KPj4gQWhhLCB5b3UgdXNlIHRoZSBmYWN0
IHRoYXQgd2Ugbm93IGRvbid0IGhhdmUgaW1wbGljaXQgZmlsdGVycyB3aXRoIGZpbGUgY2hpbGQu
IFRoZW4sIHNob3VsZA0KPj4gd2UgYWRkIGFuIGFzc2VydGlvbiBmb3IgdGhpcz8NCj4gDQo+IE5v
LCB0aGF0IHdhc27igJl0IG15IGludGVudGlvbi4gIFRoZSByZWFsIHJlYXNvbiBpcyB0aGF0IGFs
bCBvZiB0aGlzIGlzIGENCj4gbWVzcy4NCj4gDQo+IEhlcmUgaXMgdGhlIGZ1bGwgY29udGV4dDoN
Cj4gDQo+PiAgICAgIG92ZXJsYXlfYnMgPSBiczsNCj4+ICAgICAgd2hpbGUgKGJkcnZfZmlsdGVy
ZWRfYnMob3ZlcmxheV9icykgJiYNCj4+ICAgICAgICAgICAgIGJkcnZfZmlsdGVyZWRfYnMob3Zl
cmxheV9icyktPmltcGxpY2l0KQ0KPj4gICAgICB7DQo+PiAgICAgICAgICBvdmVybGF5X2JzID0g
YmRydl9maWx0ZXJlZF9icyhvdmVybGF5X2JzKTsNCj4+ICAgICAgfQ0KPj4NCj4+ICAgICAgLyog
SWYgd2Ugd2FudCB0byByZXBsYWNlIHRoZSBiYWNraW5nIGZpbGUgd2UgbmVlZCBzb21lIGV4dHJh
IGNoZWNrcyAqLw0KPj4gICAgICBpZiAobmV3X2JhY2tpbmdfYnMgIT0gYmRydl9maWx0ZXJlZF9i
cyhvdmVybGF5X2JzKSkgew0KPj4gICAgICAgICAgLyogQ2hlY2sgZm9yIGltcGxpY2l0IG5vZGVz
IGJldHdlZW4gYnMgYW5kIGl0cyBiYWNraW5nIGZpbGUgKi8NCj4+ICAgICAgICAgIGlmIChicyAh
PSBvdmVybGF5X2JzKSB7DQo+PiAgICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiQ2Fubm90
IGNoYW5nZSBiYWNraW5nIGxpbmsgaWYgJyVzJyBoYXMgIg0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgImFuIGltcGxpY2l0IGJhY2tpbmcgZmlsZSIsIGJzLT5ub2RlX25hbWUpOw0KPj4gICAg
ICAgICAgICAgIHJldHVybiAtRVBFUk07DQo+PiAgICAgICAgICB9DQo+PiAgICAgICAgICAvKiBD
aGVjayBpZiB0aGUgYmFja2luZyBsaW5rIHRoYXQgd2Ugd2FudCB0byByZXBsYWNlIGlzIGZyb3pl
biAqLw0KPj4gICAgICAgICAgaWYgKGJkcnZfaXNfYmFja2luZ19jaGFpbl9mcm96ZW4ob3Zlcmxh
eV9icywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNoaWxk
X2JzKG92ZXJsYXlfYnMtPmJhY2tpbmcpLCBlcnJwKSkgew0KPj4gICAgICAgICAgICAgIHJldHVy
biAtRVBFUk07DQo+PiAgICAgICAgICB9DQo+IA0KPiBOb3RlIHRoZSDigJxDaGVjayBmb3IgaW1w
bGljaXQgbm9kZXPigJ0gdGhpbmcuICBJZiB3ZSBnZXQgdG8gdGhlIGZyb3plbg0KPiBjaGVjaywg
d2UgaGF2ZSBhbHJlYWR5IGNvbmZpcm1lZCB0aGF0IG92ZXJsYXlfYnMgPT0gYnMsIHNvIHdlIHRo
ZW4ga25vdw0KPiB0aGF0IG92ZXJsYXlfYnMtPmJhY2tpbmcgd29ya3MuDQo+IA0KPiBJIGNhbiBh
ZGQgYW4gYWRkaXRpb25hbCBjb21tZW50IHRvIG1ha2UgdGhhdCBtb3JlIGNsZWFyLiAgSXQgdG9v
ayBteXNlbGYNCj4gcXVpdGUgYSBiaXQgb2YgZGlnZ2luZyB0byBmaWd1cmUgdGhhdCBvdXQgYWdh
aW4uLi4NCg0KQWhhLCBJIHNlZSBpdC4gQ29tbWVudCB3b3VsZCBiZSBnb29kLg0KDQo+IA0KPiAo
VGhlIHJlYXNvbiBmb3IgdGhlIGxvb3AgaXMgdGhhdCB3ZSB3YW50IHRvIGJlIGFibGUgdG8gcmVj
b2duaXplIHdoZW4NCj4gdGhlIHVzZXIgdHJpZXMgdG8gbm90IGNoYW5nZSB0aGUgYmFja2luZyBm
aWxlLiAgSW4gdGhhdCBjYXNlLCB3ZSBkb27igJl0DQo+IGhhdmUgdG8gZG8gYW55dGhpbmcsIGJ1
dCBiZWNhdXNlIHRoZSB1c2VyIGRvZXNu4oCZdCBrbm93IGFib3V0IGltcGxpY2l0DQo+IG5vZGVz
LCB3ZSBoYXZlIHRvIHNraXAgdGhlbSBpbiBvcmRlciB0byBjaGVjayB3aGV0aGVyIHRoZSB1c2Vy
IGFjdHVhbGx5DQo+IGRvZXNu4oCZdCB3YW50IHRvIGNoYW5nZSBhbnl0aGluZy4pDQo+IA0KPiBN
YXgNCj4gDQo+Pj4gICAgICAgICAgICAgICAgcmV0dXJuIC1FUEVSTTsNCj4+PiAgICAgICAgICAg
IH0NCj4+PiAgICAgICAgICAgIHJlb3Blbl9zdGF0ZS0+cmVwbGFjZV9iYWNraW5nX2JzID0gdHJ1
ZTsNCj4+PiBAQCAtMzcxMiw3ICszNzM0LDcgQEAgaW50IGJkcnZfcmVvcGVuX3ByZXBhcmUoQkRS
VlJlb3BlblN0YXRlICpyZW9wZW5fc3RhdGUsIEJsb2NrUmVvcGVuUXVldWUgKnF1ZXVlLA0KPj4+
ICAgICAgICAgKiBpdHMgbWV0YWRhdGEuIE90aGVyd2lzZSB0aGUgJ2JhY2tpbmcnIG9wdGlvbiBj
YW4gYmUgb21pdHRlZC4NCj4+PiAgICAgICAgICovDQo+Pj4gICAgICAgIGlmIChkcnYtPnN1cHBv
cnRzX2JhY2tpbmcgJiYgcmVvcGVuX3N0YXRlLT5iYWNraW5nX21pc3NpbmcgJiYNCj4+PiAtICAg
ICAgICAoYmFja2luZ19icyhyZW9wZW5fc3RhdGUtPmJzKSB8fCByZW9wZW5fc3RhdGUtPmJzLT5i
YWNraW5nX2ZpbGVbMF0pKSB7DQo+Pj4gKyAgICAgICAgKHJlb3Blbl9zdGF0ZS0+YnMtPmJhY2tp
bmcgfHwgcmVvcGVuX3N0YXRlLT5icy0+YmFja2luZ19maWxlWzBdKSkgew0KPj4+ICAgICAgICAg
ICAgZXJyb3Jfc2V0ZyhlcnJwLCAiYmFja2luZyBpcyBtaXNzaW5nIGZvciAnJXMnIiwNCj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgcmVvcGVuX3N0YXRlLT5icy0+bm9kZV9uYW1lKTsNCj4+PiAg
ICAgICAgICAgIHJldCA9IC1FSU5WQUw7DQo+Pj4gQEAgLTM4NTcsNyArMzg3OSw3IEBAIHZvaWQg
YmRydl9yZW9wZW5fY29tbWl0KEJEUlZSZW9wZW5TdGF0ZSAqcmVvcGVuX3N0YXRlKQ0KPj4+ICAg
ICAgICAgKiBmcm9tIGJkcnZfc2V0X2JhY2tpbmdfaGQoKSkgaGFzIHRoZSBuZXcgdmFsdWVzLg0K
Pj4+ICAgICAgICAgKi8NCj4+PiAgICAgICAgaWYgKHJlb3Blbl9zdGF0ZS0+cmVwbGFjZV9iYWNr
aW5nX2JzKSB7DQo+Pj4gLSAgICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqb2xkX2JhY2tpbmdfYnMg
PSBiYWNraW5nX2JzKGJzKTsNCj4+PiArICAgICAgICBCbG9ja0RyaXZlclN0YXRlICpvbGRfYmFj
a2luZ19icyA9IGNoaWxkX2JzKGJzLT5iYWNraW5nKTsNCj4+PiAgICAgICAgICAgIGFzc2VydCgh
b2xkX2JhY2tpbmdfYnMgfHwgIW9sZF9iYWNraW5nX2JzLT5pbXBsaWNpdCk7DQo+Pj4gICAgICAg
ICAgICAvKiBBYm9ydCB0aGUgcGVybWlzc2lvbiB1cGRhdGUgb24gdGhlIGJhY2tpbmcgYnMgd2Un
cmUgZGV0YWNoaW5nICovDQo+Pj4gICAgICAgICAgICBpZiAob2xkX2JhY2tpbmdfYnMpIHsNCj4+
Pg0KPj4NCj4+DQo+IA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

