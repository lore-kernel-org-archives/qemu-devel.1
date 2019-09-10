Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D226FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1B12067B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BKjpbu5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1B12067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bGx-0006ni-Gg
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7bFx-000626-QS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7bFv-0000Mc-R0
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:12:09 -0400
Received: from mail-eopbgr150097.outbound.protection.outlook.com
 ([40.107.15.97]:59556 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7bFv-0000Ls-2C; Tue, 10 Sep 2019 04:12:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSqB6jK4e2vCAkXzb03yZiJt9qksZGfDTC04e7HHs/BEh8zCQstw/wn12ykDqs7AmdjjpacbOFto67IcxXgA8gu08V9TpaR96ooYYuoPd6q4/mK+OVK6F/mxmcbV1ukhoGLIqTXwF1n1IGyD+cGfrNum4sjKFquUY5g33TwbHirTknUucjd9yPtNmMGN5WPPHrm8KhaWekr1/zrqOSNjJpCXORq+Ebp4jTAaoO5hQiKXRDL5S/HsYiYnGFfFo4a/O2wURQOShhWCGoUmC/v8JC0QLPRq4T13RrYAEtq9c3b8F/fOfWYBgqCYuBqIFponoMpZPDo5O1cLaGrl16OYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZOnXjaYpoO2GsFJKeHJEammtqXfvAOb0oxawZTEu1k=;
 b=i4bHLziBafyOsayWeOF3TpDk9kV/YXH+SdzVz1MDN3aIXPc7UYLiQbyxierViUrcsA9GUn2vOE4oy+Ly4ay9ZvlCCTv+p4It3gMfPET3xacPdNOyuqfFmGSGFcnOcn7DnO7SLq1WLP+cUyAFtqwz8RgXNBScRYDk/Mbkzc0IIwYqiVZR8sC99CyjWZ+DbiG6DjBo0HV6B1KDzm6T3BevmuVktZzvjoec6/tVziqfaPQA6r/E8L+z6Lc+az5PAGJ3uNGgR9j30zruydbu193rUOlv8FraLKj5WhdWrlCjlbQQdEO0ayKt2isZjTy/LFj4xsVvUhIeINt51NUbv36L/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZOnXjaYpoO2GsFJKeHJEammtqXfvAOb0oxawZTEu1k=;
 b=BKjpbu5dvPGoxm2PhZ3G2F9GQINxRF+6K+SH62EO9Gg18cvGdVjI5Q+ZbrUeUiZAIWeLomKanRuNGeahnIdCDOkT696gUx+fvx8nfGMIAaRSxlaIkCD9JqjgHvGJBZM8ZYnH93CsI+iiRwW7i7Zn5w/iMFVD/huHwjPV9GIwASs=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5417.eurprd08.prod.outlook.com (52.133.241.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Tue, 10 Sep 2019 08:12:04 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 08:12:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v10 04/14] block/backup: introduce BlockCopyState
Thread-Index: AQHVX03FFzbmaM/Nm0mHXVJ2sTGOiKcjXkKAgABGsID//9DwAIAADU8AgAEU5gCAAAgnAA==
Date: Tue, 10 Sep 2019 08:12:04 +0000
Message-ID: <577ab66d-ea14-a363-0b8a-92932198c284@virtuozzo.com>
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-5-vsementsov@virtuozzo.com>
 <ae856032-2d6f-adb8-939b-410708dea596@redhat.com>
 <01bc8974-b9a5-8312-fe24-e2fbe87ab13d@virtuozzo.com>
 <e94365cd-3bdf-4055-10de-abad4f65225b@redhat.com>
 <d4b6869a-a711-f911-2b29-c7062aa44aa6@virtuozzo.com>
 <80720d39-b9d6-d693-0f6a-0a078d6056e0@redhat.com>
In-Reply-To: <80720d39-b9d6-d693-0f6a-0a078d6056e0@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0045.eurprd09.prod.outlook.com
 (2603:10a6:3:45::13) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190910111202002
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78a60792-fce6-4e0b-ab8d-08d735c690bf
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5417; 
x-ms-traffictypediagnostic: DB8PR08MB5417:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5417515A5B451766ADC44F6BC1B60@DB8PR08MB5417.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(7736002)(14444005)(446003)(76176011)(102836004)(53546011)(6506007)(386003)(2616005)(305945005)(110136005)(486006)(99286004)(66066001)(6116002)(71200400001)(71190400001)(53936002)(81156014)(8676002)(8936002)(3846002)(2501003)(11346002)(4326008)(14454004)(5660300002)(25786009)(31686004)(478600001)(54906003)(6246003)(186003)(476003)(256004)(316002)(107886003)(31696002)(6486002)(229853002)(2906002)(36756003)(52116002)(7416002)(66556008)(86362001)(66476007)(6436002)(66446008)(64756008)(26005)(66946007)(6512007)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5417;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nCot/Dp6qlLMqZSCpkM7yZaQXrihbD9i4PW5XC6CqAJlDBap2urnAUM4HlzeF7Smfk+gwrwa8J+MM8uTvLpFtqY3rHkpn+w/dOtByhtlDEVUcd6r3T66ur+iXU8amCSBQDqrcv3B/+WkLEieRaTXP4v1PHB3eE77LFTO+CZmYpNX+vPSiCjvZ8pqMMJVpDThbvR6OxQrAvxd6aYlIdpOEJMSmTbTfaFtkUQ/ig3Y7km0htRJ6hH7V7fZ0NWZoaOoiqGnaPwGx9SyFeiBGs13PBvAlH85+tP+3R2znaGMBsxtRokTwtqUIvi2OgGb3+dfAmZqQkZEvdXT94UJ7bjJxzLMXEtoievUu01A0mgygJ0kdnw4V+ywrKlJQU/mIkx0waZZy0oIFSfRmzJtKu0uXOVNT5T1SX8QZBsHdX9GBBc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6B2A479C9A7F84BA18501C6D9396521@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a60792-fce6-4e0b-ab8d-08d735c690bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 08:12:04.6032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0sD4N1CdrMiTzV+jlu2T2QU0A+KIWKLcfrYkL04qT9wBOoYS3XtDqZ/uCTzmLS32UUWSroBOhs52WgJ+WepjhUntC+ZXrj3P5ityYL9U6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5417
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.97
Subject: Re: [Qemu-devel] [PATCH v10 04/14] block/backup: introduce
 BlockCopyState
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMDkuMjAxOSAxMDo0MiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwOS4wOS4xOSAxNzoxMSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDA5LjA5LjIwMTkgMTc6MjQs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAwOS4wOS4xOSAxNjoxMiwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMDkuMDkuMjAxOSAxNTo1OSwgTWF4IFJlaXR6IHdy
b3RlOg0KPj4+Pj4gT24gMzAuMDguMTkgMTg6MTIsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4gU3BsaXQgY29weWluZyBjb2RlIHBhcnQgZnJvbSBiYWNrdXAgdG8g
ImJsb2NrLWNvcHkiLCBpbmNsdWRpbmcgc2VwYXJhdGUNCj4+Pj4+PiBzdGF0ZSBzdHJ1Y3R1cmUg
YW5kIGZ1bmN0aW9uIHJlbmFtaW5nLiBUaGlzIGlzIG5lZWRlZCB0byBzaGFyZSBpdCB3aXRoDQo+
Pj4+Pj4gYmFja3VwLXRvcCBmaWx0ZXIgZHJpdmVyIGluIGZ1cnRoZXIgY29tbWl0cy4NCj4+Pj4+
Pg0KPj4+Pj4+IE5vdGVzOg0KPj4+Pj4+DQo+Pj4+Pj4gMS4gQXMgQmxvY2tDb3B5U3RhdGUga2Vl
cHMgb3duIEJsb2NrQmFja2VuZCBvYmplY3RzLCByZW1haW5pbmcNCj4+Pj4+PiBqb2ItPmNvbW1v
bi5ibGsgdXNlcnMgb25seSB1c2UgaXQgdG8gZ2V0IGJzIGJ5IGJsa19icygpIGNhbGwsIHNvIGNs
ZWFyDQo+Pj4+Pj4gam9iLT5jb21tZW4uYmxrIHBlcm1pc3Npb25zIHNldCBpbiBibG9ja19qb2Jf
Y3JlYXRlIGFuZCBhZGQNCj4+Pj4+PiBqb2ItPnNvdXJjZV9icyB0byBiZSB1c2VkIGluc3RlYWQg
b2YgYmxrX2JzKGpvYi0+Y29tbW9uLmJsayksIHRvIGtlZXANCj4+Pj4+PiBpdCBtb3JlIGNsZWFy
IHdoaWNoIGJzIHdlIHVzZSB3aGVuIGludHJvZHVjZSBiYWNrdXAtdG9wIGZpbHRlciBpbg0KPj4+
Pj4+IGZ1cnRoZXIgY29tbWl0Lg0KPj4+Pj4+DQo+Pj4+Pj4gMi4gUmVuYW1lIHMvaW5pdGlhbGl6
aW5nX2JpdG1hcC9za2lwX3VuYWxsb2NhdGVkLyB0byBzb3VuZCBhIGJpdCBiZXR0ZXINCj4+Pj4+
PiBhcyBpbnRlcmZhY2UgdG8gQmxvY2tDb3B5U3RhdGUNCj4+Pj4+Pg0KPj4+Pj4+IDMuIFNwbGl0
IGlzIG5vdCB2ZXJ5IGNsZWFuOiB0aGVyZSBsZWZ0IHNvbWUgZHVwbGljYXRlZCBmaWVsZHMsIGJh
Y2t1cA0KPj4+Pj4+IGNvZGUgdXNlcyBzb21lIEJsb2NrQ29weVN0YXRlIGZpZWxkcyBkaXJlY3Rs
eSwgbGV0J3MgcG9zdHBvbmUgaXQgZm9yDQo+Pj4+Pj4gZnVydGhlciBpbXByb3ZlbWVudHMgYW5k
IGtlZXAgdGhpcyBjb21tZW50IHNpbXBsZXIgZm9yIHJldmlldy4NCj4+Pj4+Pg0KPj4+Pj4+IFNp
Z25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmly
dHVvenpvLmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiAgICAgYmxvY2svYmFja3VwLmMgICAgIHwg
MzU3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPj4+Pj4+
ICAgICBibG9jay90cmFjZS1ldmVudHMgfCAgMTIgKy0NCj4+Pj4+PiAgICAgMiBmaWxlcyBjaGFu
Z2VkLCAyMzEgaW5zZXJ0aW9ucygrKSwgMTM4IGRlbGV0aW9ucygtKQ0KPj4+Pj4+DQo+Pj4+Pj4g
ZGlmZiAtLWdpdCBhL2Jsb2NrL2JhY2t1cC5jIGIvYmxvY2svYmFja3VwLmMNCj4+Pj4+PiBpbmRl
eCBhYmI1MDk5ZmEzLi4wMDJkZWU0ZDdmIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2Jsb2NrL2JhY2t1
cC5jDQo+Pj4+Pj4gKysrIGIvYmxvY2svYmFja3VwLmMNCj4+Pj4+PiBAQCAtMzUsMTIgKzM1LDQz
IEBAIHR5cGVkZWYgc3RydWN0IENvd1JlcXVlc3Qgew0KPj4+Pj4+ICAgICAgICAgQ29RdWV1ZSB3
YWl0X3F1ZXVlOyAvKiBjb3JvdXRpbmVzIGJsb2NrZWQgb24gdGhpcyByZXF1ZXN0ICovDQo+Pj4+
Pj4gICAgIH0gQ293UmVxdWVzdDsNCj4+Pj4+PiAgICAgDQo+Pj4+Pj4gK3R5cGVkZWYgdm9pZCAo
KlByb2dyZXNzQnl0ZXNDYWxsYmFja0Z1bmMpKGludDY0X3QgYnl0ZXMsIHZvaWQgKm9wYXF1ZSk7
DQo+Pj4+Pj4gK3R5cGVkZWYgdm9pZCAoKlByb2dyZXNzUmVzZXRDYWxsYmFja0Z1bmMpKHZvaWQg
Km9wYXF1ZSk7DQo+Pj4+Pj4gK3R5cGVkZWYgc3RydWN0IEJsb2NrQ29weVN0YXRlIHsNCj4+Pj4+
PiArICAgIEJsb2NrQmFja2VuZCAqc291cmNlOw0KPj4+Pj4+ICsgICAgQmxvY2tCYWNrZW5kICp0
YXJnZXQ7DQo+Pj4+Pj4gKyAgICBCZHJ2RGlydHlCaXRtYXAgKmNvcHlfYml0bWFwOw0KPj4+Pj4+
ICsgICAgaW50NjRfdCBjbHVzdGVyX3NpemU7DQo+Pj4+Pj4gKyAgICBib29sIHVzZV9jb3B5X3Jh
bmdlOw0KPj4+Pj4+ICsgICAgaW50NjRfdCBjb3B5X3JhbmdlX3NpemU7DQo+Pj4+Pj4gKyAgICB1
aW50NjRfdCBsZW47DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgICAgQmRydlJlcXVlc3RGbGFncyB3cml0
ZV9mbGFnczsNCj4+Pj4+PiArDQo+Pj4+Pj4gKyAgICAvKg0KPj4+Pj4+ICsgICAgICogc2tpcF91
bmFsbG9jYXRlZDogaWYgdHJ1ZSwgb24gY29weSBvcGVyYXRpb24gZmlyc3RseSByZXNldCBhcmVh
cw0KPj4+Pj4+ICsgICAgICogdW5hbGxvY2F0ZWQgaW4gdG9wIGxheWVyIG9mIHNvdXJjZSAoYW5k
IHRoZW4gb2YgY291cnNlIGRvbid0IGNvcHkNCj4+Pj4+PiArICAgICAqIGNvcnJlc3BvbmRpbmcg
Y2x1c3RlcnMpLiBJZiBzb21lIGJ5dGVzIHJlc2V0LCBjYWxsDQo+Pj4+Pj4gKyAgICAgKiBwcm9n
cmVzc19yZXNldF9jYWxsYmFjay4NCj4+Pj4+PiArICAgICAqLw0KPj4+Pj4NCj4+Pj4+IEl0IGlz
buKAmXQgcXVpdGUgY2xlYXIgdGhhdCB0aGlzIHJlZmVycyB0byB0aGUgY29weV9iaXRtYXAuICBN
YXliZQ0KPj4+Pj4gc29tZXRoaW5nIGxpa2UNCj4+Pj4+DQo+Pj4+PiDigJxJZiB0cnVlLCB0aGUg
Y29weSBvcGVyYXRpb24gcHJlcGFyZXMgYSBzeW5jPXRvcCBqb2I6IEl0IHNjYW5zIHRoZQ0KPj4+
Pg0KPj4+PiBobW0sIG5vdyBpdCdzIG5vdCByZWZhY3RvcmVkIHRvIHNjYW4gaXQgYmVmb3JlIGNv
cHlpbmcgbG9vcCwgc28gaXQncyBub3QgcHJlY2lzZQ0KPj4+PiB3b3JkaW5nLi4NCj4+Pj4NCj4+
Pj4+IHNvdXJjZSdzIHRvcCBsYXllciB0byBmaW5kIGFsbCB1bmFsbG9jYXRlZCBhcmVhcyBhbmQg
cmVzZXRzIHRoZW0gaW4gdGhlDQo+Pj4+DQo+Pj4+IE5vdCBhbGwsIGJ1dCBtb3N0bHkgaW5zaWRl
IGJsb2NrLWNvcHkgcmVxdWVzdGVkIGFyZWEgKGJ1dCBtYXkgYmUgbW9yZSkNCj4+Pg0KPj4+IFNv
cnJ5LCBJIG1lYW50IGJhY2t1cCBvcGVyYXRpb24uDQo+Pj4NCj4+Pj4+IGNvcHlfYml0bWFwIChz
byB0aGV5IHdpbGwgbm90IGJlIGNvcGllZCkuICBXaGVuZXZlciBhbnkgc3VjaCBhcmVhIGlzDQo+
Pj4+PiBjbGVhcmVkLCBwcm9ncmVzc19yZXNldF9jYWxsYmFjayB3aWxsIGJlIGludm9rZWQuDQo+
Pj4+PiBPbmNlIHRoZSB3aG9sZSB0b3AgbGF5ZXIgaGFzIGJlZW4gc2Nhbm5lZCwgc2tpcF91bmFs
bG9jYXRlZCBpcyBjbGVhcmVkDQo+Pj4+PiBhbmQgdGhlIGFjdHVhbCBjb3B5aW5nIGJlZ2lucy7i
gJ0NCj4+Pj4NCj4+Pj4gTGFzdCBzZW50ZW5jZSBzb3VuZHMgbGlrZSBpdCdzIGEgYmxvY2stY29w
eSB3aG8gd2lsbCBjbGVhciBza2lwX3VuYWxsb2NhdGVkLA0KPj4+PiBidXQgaXQncyBub3Qgc28u
IEl0J3Mgbm90IHZlcnkgZ29vZCBkZXNpZ24gYW5kIG1heSBiZSByZWZhY3RvcmVkIGluIGZ1dHVy
ZSwNCj4+Pj4gYnV0IGZvciBub3csIEknZCBiZXR0ZXIgZHJvcCBsYXN0IHNlbnRlbmNlLg0KPj4+
DQo+Pj4gQnV0IHdhc27igJl0IHRoYXQgdGhlIHBvaW50IG9mIHRoaXMgdmFyaWFibGU/ICBUaGF0
IGl0IGdvZXMgYmFjayB0byBmYWxzZQ0KPj4+IG9uY2UgdGhlIGJpdG1hcCBpcyBmdWxseSBpbml0
aWFsaXplZD8NCj4+DQo+PiBJIGp1c3Qgd2FudCB0byBzdHJlc3MsIHRoYXQgYmxvY2stY29weSBp
dHNlbGYgKHdoaWNoIHdpbGwgYmUgaW4gYSBzZXBhcmF0ZSBmaWxlLA0KPj4gc28gaXQgd291bGQg
YmUgY2xlYW4gZW5vdWdoLCB3aGF0IGlzIGJsb2NrLWNvcHkgYW5kIHdoYXQgaXMgaXRzIHVzZXIp
IGRvIG5vdCBjbGVhcg0KPj4gdGhpcyB2YXJpYWJsZS4gSXQgb2YgY291cnNlIG1heSB0cmFjayBj
YWxscyB0byAgYmxvY2tfY29weV9yZXNldF91bmFsbG9jYXRlZCgpIGFuZA0KPj4gY2xlYXIgdGhp
cyB2YXJpYWJsZSBhdXRvbWF0aWNhbGx5LCBidXQgaXQgZG9uJ3QgZG8gaXQgbm93LiBBbmQgeW91
ciB3b3JkaW5nIGxvb2tzDQo+PiBmb3IgbWUgbGlrZSBibG9jay1jb3B5IGNvZGUgbWF5IGF1dG9t
YXRpY2FsbHkgY2xlYXIgdGhpcyB2YXJpYWJsZQ0KPiANCj4gSG0sIE9LLg0KPiANCj4+Pg0KPj4+
Pj4NCj4+Pj4+IGluc3RlYWQ/DQo+Pj4+DQo+Pj4+IE9yLCB3aGF0IGFib3V0IHRoZSBmb2xsb3dp
bmcgbWl4Og0KPj4+Pg0KPj4+PiBVc2VkIGZvciBqb2Igc3luYz10b3AgbW9kZS4gSWYgdHJ1ZSwg
YmxvY2tfY29weSgpIHdpbGwgcmVzZXQgaW4gY29weV9iaXRtYXAgYXJlYXMNCj4+Pj4gdW5hbGxv
Y2F0ZWQgaW4gdG9wIGltYWdlIChzbyB0aGV5IHdpbGwgbm90IGJlIGNvcGllZCkuIFdoZW5ldmVy
IGFueSBzdWNoIGFyZWEgaXMgY2xlYXJlZCwNCj4+Pj4gcHJvZ3Jlc3NfcmVzZXRfY2FsbGJhY2sg
d2lsbCBiZSBpbnZva2VkLiBVc2VyIGlzIGFzc3VtZWQgdG8gY2FsbCBpbiBiYWNrZ3JvdW5kDQo+
Pj4+IGJsb2NrX2NvcHlfcmVzZXRfdW5hbGxvY2F0ZWQoKSBzZXZlcmFsIHRpbWVzIHRvIGNvdmVy
IHRoZSB3aG9sZSBjb3BpZWQgZGlzayBhbmQNCj4+Pj4gdGhlbiBjbGVhciBza2lwX3VuYWxsb2Nh
dGVkLCB0byBwcmV2ZW50IGV4dHJhIGVmZm9ydC4NCj4+Pg0KPj4+IEkgZG9u4oCZdCBrbm93LiAg
VGhlIHBvaW50IG9mIHRoaXMgdmFyaWFibGUgaXMgdGhlIGluaXRpYWxpemF0aW9uIG9mIHRoZQ0K
Pj4+IGJpdG1hcC4gIGJsb2NrLWNvcHkgb25seSB1c2VzIHRoaXMgYXMgYSBoaW50IHRoYXQgaXQg
bmVlZHMgdG8NCj4+PiBwYXJ0aWNpcGF0ZSBpbiB0aGF0IGluaXRpYWxpemF0aW9uIHByb2Nlc3Ms
IHRvbywgYW5kIGNhbm5vdCBhc3N1bWUgdGhlDQo+Pj4gYml0bWFwIHRvIGJlIGZ1bGx5IGFsbG9j
YXRlZC4NCj4+DQo+PiBIbW0sIGJ1dCB3aGVyZSBpcyBhIGNvbmZsaWN0IG9mIHRoaXMgYW5kIG15
IHdvcmRpbmc/IElNSE8sIEkganVzdCBkb2N1bWVudGVkDQo+PiBleGFjdGx5IHdoYXQncyB3cml0
dGVuIGluIHRoZSBjb2RlLg0KPiANCj4gVGhlcmXigJlzIG5vIGNvbmZsaWN0IGJlY2F1c2UgaXQg
aXNu4oCZdCBtZW50aW9uZWQ7IHdoaWNoIGlzIHRoZSBwcm9ibGVtIEkNCj4gaGF2ZSB3aXRoIGl0
Lg0KPiANCj4gV2hhdCBJIHdhcyByZWFsbHkgY29uZnVzZWQgYWJvdXQgaXMgd2hvIGNvbnN1bWVz
IHRoZSB2YXJpYWJsZS4gIEl0IGFsbA0KPiBiZWNvbWVzIG11Y2ggY2xlYXJlciB3aGVuIEkgdGFr
ZSBpdCBhcyBhIGdpdmVuIHRoYXQgYWxsIG9mIHlvdXINCj4gZGVzY3JpcHRpb24ganVzdCBpcyBh
biBpbXBlcmF0aXZlIHRvIGJsb2NrLWNvcHkuICBUaGF0IHNpbXBseSB3YXNu4oCZdA0KPiBjbGVh
ciB0byBtZS4gIChXaGljaCBpcyB3aHkgeW91IGRvbuKAmXQgbGlrZSBteSBkZXNjcmlwdGlvbiwg
cHJlY2lzZWx5DQo+IGJlY2F1c2UgaXQgdGVsbHMgdGhlIHN0b3J5IGZyb20gYW5vdGhlciBQT1Ys
IG5hbWVseSB0aGF0IG9mIGJhY2t1cC4pDQo+IA0KPiBGdXJ0aGVybW9yZSwgSSBqdXN0IG1pc3Mg
dGhlIGJpZyBwaWN0dXJlIGFib3V0IGl0LiAgV2h5IGRvZXMgdGhlDQo+IHZhcmlhYmxlIGV2ZW4g
ZXhpc3Q/DQoNClRvbyBrZWVwIGl0IHNpbXBsZXIgZm9yIG5vdywgd2UgY2FuIGltcHJvdmUgaXQg
YXMgYSBmb2xsb3ctdXAuIEkgc2VlDQpzZXZlcmFsIHNvbHV0aW9uczoNCg0KMS4gdHJhY2sgc2Vx
dWVudGlhbCBjYWxscyB0byBibG9ja19jb3B5X3Jlc2V0X3VuYWxsb2NhdGVkKCkgYW5kIHdoZW4N
Cml0IGNvbWVzIHRvIHRoZSBkaXNrIGVuZCAtIGNsZWFyIHRoZSB2YXJpYWJsZQ0KDQoyLiBkb24n
dCBwdWJsaXNoIGJsb2NrX2NvcHlfcmVzZXRfdW5hbGxvY2F0ZWQoKSBhdCBhbGwsIGFzc3VtaW5n
IHNlcXVlbnRpYWwNCmNhbGxzIHRvIGJsb2NrX2NvcHkoKSBhbmQgZG8gbGlrZSBpbiAoMS4pDQoN
CjMuIGtlZXAgYWRkaXRpb25hbCBiaXRtYXAgdG8gdHJhY2ssIHdoYXQgd2FzIGFscmVhZHkgZXhw
bG9yZWQgYWJvdXQgYmVpbmcNCmFsbG9jYXRlZC91bmFsbG9jYXRlZCAoc2VlbXMgdG9vIG11Y2gp
DQoNCg0KSSB0aGluaywgSSdsbCByZXNlbmQgd2l0aCBbMi5dIHNvb24sIGlmIG5vIG90aGVyIGlk
ZWFzLiBPciBJIGNhbiBsZWF2ZSBpdCBmb3INCmEgZm9sbG93LXVwLg0KDQpJIGRvbuKAmXQgcXVp
dGUgbGlrZSBsZWF2aW5nIHB1enpsaW5nIHRvZ2V0aGVyIHRoZQ0KPiBiaXRzIHRvIHRoZSByZWFk
ZXIsIGlmIHdlIGNhbiBhdm9pZCBpdC4NCj4gDQo+IE1heA0KPiANCg0KDQotLSANCkJlc3QgcmVn
YXJkcywNClZsYWRpbWlyDQo=

