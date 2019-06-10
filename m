Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE0FC28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456402085A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DhEeB+bE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456402085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKR3-0006QO-VY
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45802)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haKMx-0004jS-Ou
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haKMw-0005D5-Ke
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:29:51 -0400
Received: from mail-eopbgr10112.outbound.protection.outlook.com
 ([40.107.1.112]:9305 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1haKMt-00059g-Gg; Mon, 10 Jun 2019 09:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zgDWOH88VYO+qA8xEnxCCv+TbSTqmKq4xUr9yhHx/A=;
 b=DhEeB+bEcax82rlRcFuDhnElruHMB7zq+fP1XbwFk64BrEJhAhPqiwy7HYrOLO9Twt07Ab5whS7AjMbI9e2IGJwsxAV1aDPNu1pz6tptKP0L43KiwJN/Xt3WX3BHTvbCTou+Wnbo0kM7SRL070P6V65YqZxkG9Czca/TQYRwSrA=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3811.eurprd08.prod.outlook.com (20.178.82.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Mon, 10 Jun 2019 13:29:32 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 13:29:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 6/7] block/nbd-client: nbd reconnect
Thread-Index: AQHU8IvOU96perqu+EiRV82H4T/8KaaP3geAgAWGEYD//9vfgA==
Date: Mon, 10 Jun 2019 13:29:31 +0000
Message-ID: <46bd12f6-8df7-ed2d-b85a-cd621c146e27@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-7-vsementsov@virtuozzo.com>
 <0b64cff5-33fa-0945-504c-b1bdd004c42a@redhat.com>
 <76780fdb-4c00-a8bd-4323-15bdd403fbaf@virtuozzo.com>
In-Reply-To: <76780fdb-4c00-a8bd-4323-15bdd403fbaf@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0019.eurprd03.prod.outlook.com
 (2603:10a6:3:76::29) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190610162929673
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f8bf12f-296c-4974-c2ce-08d6eda7abcc
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3811; 
x-ms-traffictypediagnostic: AM0PR08MB3811:
x-microsoft-antispam-prvs: <AM0PR08MB3811CD4E4CFC3F3DFB892406C1130@AM0PR08MB3811.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(366004)(39840400004)(396003)(376002)(346002)(136003)(189003)(199004)(66476007)(66446008)(66946007)(66556008)(316002)(6116002)(36756003)(71200400001)(71190400001)(31686004)(2501003)(64756008)(14454004)(25786009)(3846002)(5024004)(6486002)(256004)(4326008)(186003)(73956011)(478600001)(486006)(31696002)(229853002)(476003)(68736007)(305945005)(7736002)(6512007)(6246003)(99286004)(8936002)(5660300002)(8676002)(53936002)(11346002)(102836004)(446003)(66066001)(81156014)(81166006)(386003)(2906002)(86362001)(110136005)(6436002)(54906003)(6506007)(2616005)(52116002)(107886003)(76176011)(2201001)(26005)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3811;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UWDnobT9c50cUcwDfAERAchezkOjdh4A698MCYrQdbWiSNx1GK7igJzHfW7dCipD7OZmP4y/fb0q26z1oA9SvkvqmnA6a/Z7qJAnwEE7t5G7iH/bntL6GOiHMaq8HdP1pxngOOVplU8WyzHg8N53tJfo/gg1gVb2vOdXPPnVYZEQ/GTP5XQEN8CIgicmomiMvgSk1zcA1IQTEFH68/rE5fCuRpnvk7Dhi5t4tlr9uHfy1mss4GTDqtRd9j1JbnPWiFaV7PTOEKhPGkXT+HOmj/fzIGk8uIjlPU6bzSkjxRfc5Ld/zQLzLhSsGXF3XOSwlGWfqVeDAADElkOZMeL3qbxcbUHsn1mn3qHygDDSeaiRdd74CR1NrVbo85+leO4+Ezt6wW07+GB9PeXFxCcGQIDR+SU7wACNeXOTenmgqeI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <370BD7BC426D7B4B8DF8693CA5645D52@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8bf12f-296c-4974-c2ce-08d6eda7abcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 13:29:31.9477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3811
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.112
Subject: Re: [Qemu-devel] [PATCH v6 6/7] block/nbd-client: nbd reconnect
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMDYuMjAxOSAxNTozOCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDcuMDYuMjAxOSA2OjE3LCBFcmljIEJsYWtlIHdyb3RlOg0KPj4+ICt0eXBlZGVmIHN0cnVjdCBO
QkRDb25uZWN0aW9uIHsNCj4+PiArwqDCoMKgIEJsb2NrRHJpdmVyU3RhdGUgKmJzOw0KPj4+ICvC
oMKgwqAgU29ja2V0QWRkcmVzcyAqc2FkZHI7DQo+Pj4gK8KgwqDCoCBjb25zdCBjaGFyICpleHBv
cnQ7DQo+Pj4gK8KgwqDCoCBRQ3J5cHRvVExTQ3JlZHMgKnRsc2NyZWRzOw0KPj4+ICvCoMKgwqAg
Y29uc3QgY2hhciAqaG9zdG5hbWU7DQo+Pj4gK8KgwqDCoCBjb25zdCBjaGFyICp4X2RpcnR5X2Jp
dG1hcDsNCj4+PiArfSBOQkRDb25uZWN0aW9uOw0KPj4gQ2FuIHdlIHB1dCB0aGlzIHR5cGUgaW4g
YSBoZWFkZXIsIGFuZCB1c2UgaXQgaW5zdGVhZCBvZiBwYXNzaW5nIGxvdHMgb2YNCj4+IGluZGl2
aWR1YWwgcGFyYW1ldGVycyB0byBuYmRfY2xpZW50X2Nvbm5lY3QoKT/CoCBQcm9iYWJseSBhcyBh
IHNlcGFyYXRlDQo+PiBwcmUtcmVxdWlzaXRlIGNsZWFudXAgcGF0Y2guDQo+Pg0KPiANCj4gDQo+
IEhtbSwgYW5kIHRoZW4sIGluY2x1ZGUgaXQgaW50byBCRFJWTkJEU3RhdGU/IEkgZG9uJ3QgcmVt
ZW1iZXIgd2h5IGRpZG4ndCBkbw0KPiBpdCwgYW5kIG5vdyBJIGRvbid0IHNlZSBhbnkgcmVhc29u
IGZvciBpdC4gV2Ugc3RvcmUgdGhpcyBpbmZvcm1hdGlvbiBhbnl3YXkNCj4gZm9yIHRoZSB3aG9s
ZSBsaWZlIG9mIHRoZSBkcml2ZXIuLg0KPiANCj4gU28sIGlmIEknbSBnb2luZyB0byByZWZhY3Rv
ciBpdCwgSSBoYXZlIGEgcXVlc3Rpb246IGlzIHRoZXJlIGEgcmVhc29uIGZvcg0KPiBsYXllcmVk
IEJEUlZOQkRTdGF0ZToNCj4gDQo+IHR5cGVkZWYgc3RydWN0IEJEUlZOQkRTdGF0ZSB7DQo+ICDC
oMKgwqAgTkJEQ2xpZW50U2Vzc2lvbiBjbGllbnQ7DQo+IA0KPiAgwqDCoMKgIC8qIEZvciBuYmRf
cmVmcmVzaF9maWxlbmFtZSgpICovDQo+ICDCoMKgwqAgU29ja2V0QWRkcmVzcyAqc2FkZHI7DQo+
ICDCoMKgwqAgY2hhciAqZXhwb3J0LCAqdGxzY3JlZHNpZDsNCj4gfSBCRFJWTkJEU3RhdGU7DQo+
IA0KPiBhbmQgdXNlIG5iZF9nZXRfY2xpZW50X3Nlc3Npb24gZXZlcnl3aGVyZSBpbnN0ZWFkIG9m
IHNpbXBsZSBjb252ZXJ0aW5nIHZvaWQgKm9wYXF1ZQ0KPiB0byBTdGF0ZSBwb2ludGVyIGxpa2Ug
aW4gcWNvdzIgZm9yIGV4YW1wbGU/DQo+IA0KPiBUaGUgb25seSByZWFzb24gSSBjYW4gaW1hZ2lu
ZSBpcyBub3QgdG8gc2hhcmUgdGhlIHdob2xlIEJEUlZOQkRTdGF0ZSwgYW5kIGtlZXANCj4gdGhp
bmdzIHdlIGFyZSB1c2luZyBvbmx5IGluIG5iZC5jIHRvIGJlIGF2YWlsYWJsZSBvbmx5IGluIG5i
ZC5jLi4gQnV0IEkndmUgcHV0DQo+IHNhZGRyIGFuZCBleHBvcnQgdG8gTkJEQ29ubmVjdGlvbiB0
byBiZSB1c2VkIGluIG5iZC1jbGllbnQuYyBhbnl3YXkuIFNvLCBJIHRoaW5rDQo+IGl0J3MgYSBn
b29kIG1vbWVudCB0byBmbGF0dGVuIGFuZCBzaGFyZSBCRFJWTkJEU3RhdGUgYW5kIGRyb3AgbmJk
X2dldF9jbGllbnRfc2Vzc2lvbi4NCj4gDQoNCkFuZCBpZiB3ZSBhcmUgaGVyZSwgd2hhdCBpcyBl
eGFjdCBwdXJwb3NlIG9mIHNwbGl0dGluZyAgbmJkLWNsaWVudC5jIGZyb20gbmJkLmM/DQoNCkkg
c2VlLCBpdCB3YXMgbG9uZyBhZ286DQoNCmNvbW1pdCAyMzAyYzFjYWZiMTNkZjIzOTM4YjA5OGQ5
YzY1OTVkZTUyZWMyNTc3DQpBdXRob3I6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1
cmVhdUByZWRoYXQuY29tPg0KRGF0ZTogICBTdW4gRGVjIDEgMjI6MjM6NDEgMjAxMyArMDEwMA0K
DQogICAgIFNwbGl0IG5iZCBibG9jayBjbGllbnQgY29kZQ0KDQoNCkJ1dCBzdGlsbCwgaXQgZG9l
c24ndCBleHBsYWluLi4NCg0KQW5kIGFsbCB0aGlzIGxlYWRzIHRvIG5vb3Agd3JhcHBlcnMgbGlr
ZSB0aGlzDQoNCnN0YXRpYyBpbnQgbmJkX2NvX2ZsdXNoKEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0K
ew0KICAgICByZXR1cm4gbmJkX2NsaWVudF9jb19mbHVzaChicyk7DQp9DQoNCnN0YXRpYyB2b2lk
IG5iZF9kZXRhY2hfYWlvX2NvbnRleHQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQp7DQogICAgIG5i
ZF9jbGllbnRfZGV0YWNoX2Fpb19jb250ZXh0KGJzKTsNCn0NCg0Kc3RhdGljIHZvaWQgbmJkX2F0
dGFjaF9haW9fY29udGV4dChCbG9ja0RyaXZlclN0YXRlICpicywNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEFpb0NvbnRleHQgKm5ld19jb250ZXh0KQ0Kew0KICAgICBuYmRf
Y2xpZW50X2F0dGFjaF9haW9fY29udGV4dChicywgbmV3X2NvbnRleHQpOw0KfQ0KDQoNCm9yIG5l
ZWQgb2YgZGVmaW5pbmcgZHJpdmVyIGNhbGxiYWNrcyBpbiBoZWFkZXIgZmlsZSwgaW5zdGVhZCBv
ZiBrZWVwaW5nIHRoZW0gdG9nZXRoZXINCndpdGggZHJpdmVyIHN0cnVjdCBkZWZpbml0aW9uIGFu
ZCBzdGF0aWMgKGxpa2Ugb3RoZXIgYmxvY2sgZHJpdmVycykuLi4NCg0KDQpBbmQgbmFtZXMgb2Yg
dGhlc2UgdHdvIGZpbGVzIGFsd2F5cyBjb25mdXNlZCBtZS4uIG5iZC5jIGlzIG5iZCBjbGllbnQg
YmxvY2sgZHJpdmVyLCBhbmQNCmRyaXZlciBpcyBkZWZpbmVkIGhlcmUuLiBCdXQgd2UgaGF2ZSBu
YmQtY2xpZW50LmMgd2hpY2ggZGVmaW5lcyBuYmQgY2xpZW50IGRyaXZlciB0b28uDQpBbmQgd2Ug
YWxzbyBoYXZlIG5iZC9jbGllbnQuYyAoT0ssIHRoaXMgc3BsaXQgSSB1bmRlcnN0YW5kIG9mIGNv
dXJzZSwgYnV0IGl0IGluY3JlYXNlcw0KY29uZnVzaW9uIGFueXdheSkuDQoNCi0tIA0KQmVzdCBy
ZWdhcmRzLA0KVmxhZGltaXINCg==

