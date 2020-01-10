Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C9CC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 20:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A59E20678
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 20:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QXYERmWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A59E20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq0YW-0005Vq-4U
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 15:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iq0Xr-000537-7C
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 15:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iq0Xo-0004lU-5t
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 15:06:10 -0500
Received: from mail-eopbgr80111.outbound.protection.outlook.com
 ([40.107.8.111]:64490 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iq0Xn-0004N7-3Q
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 15:06:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j31mKKSaoaIV8RhN5OqDDrzbeh4xzXcNPxioSm9J/Z3RqjZNy38N0B0ePFkoIB3ZeWd2iOodJC94jWYzxjRzD0TUDLZHpG9FIE9P7lrfqVeHEQNKvy+YpXHshAjnXiWJpPlJAAENzKzNfqO8wiFmxRUonGRC4ikVTPwy/uKsVAI1k6tzhIiRaxs0PkZnDgPx2Q8/EAbPJlRn4SfYcn1QxIzSP0Ei8wrsIuaRCK1e/RdGL0OOwvHj07/lb9GWk6BmrA7zZTmu70b10s0tGmRezVKEYII7+qng/YzitjWVz0pWkG67GpW5vJsZZvONs9II6ze6tCiHDq2zIkOHW5Uwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UpXk8juY/k2Ui7g9zghwLxsHU8iWcl0b2DteSg7YTQ=;
 b=WnJm8x7lujOjU2tWdQnOLvcaU9AmTtY6U3EbLST+rts5aob9lVxJulfbRIc15fPjmY0+YigS1QTTSOQxrEsgG9e75vUBvONgUFK4nspodvsvtdfaQc3cBsP7Xc203S7LaVEgHJQRx5SZhxg7+LVgsmj1W6iowKtkS1yDtTfvICIvf/rzrCGouscacYqvuHqq1ws6nUvUR7nl7qeZwiAchqOvlLdrxvHTjdwuQBm1Aj6sBagI/+iYpvELJJeA4lzhaZAA4w5kVZFB2vrUC6veQR1EJVscEzKorh7ISOlxQYdB0o1KOqjqmk0fD6NclOrTUyK+29ISsDAlVf5Tz357eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UpXk8juY/k2Ui7g9zghwLxsHU8iWcl0b2DteSg7YTQ=;
 b=QXYERmWvX1/7CY4OYijJkwEkmVi7S6PpM5UyUhESE7fsrJTmYUYuu6OgYMppuyFUQuMsscf0e0w0HDmqc2SqfCA6qzmXkfbgV/3GTLcfBYlOFCUje0bGcEOCeM+tfypVaIrc6Ggr5oXqdscreJ998uDxmVQTU4a/+3T7ElMDfak=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3192.eurprd08.prod.outlook.com (52.135.166.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Fri, 10 Jan 2020 20:06:02 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 20:06:02 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P192CA0023.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Fri, 10 Jan 2020 20:06:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 10/21] hw/core: Fix latent fit_load_fdt() error handling
 bug
Thread-Topic: [PATCH 10/21] hw/core: Fix latent fit_load_fdt() error handling
 bug
Thread-Index: AQHVp7Zc+yLwnj0NqE2ZqD9/orOgMKerwU8AgAEB4/yAAGZTgIA3ac6A
Date: Fri, 10 Jan 2020 20:06:02 +0000
Message-ID: <52a3810e-0805-d368-ec2a-7e6265f494d6@virtuozzo.com>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-11-armbru@redhat.com>
 <b42438de-3f05-a949-9304-29c051bc4444@virtuozzo.com>
 <87tv6dnbfl.fsf@dusky.pond.sub.org>
 <cce60ff4-254d-85df-cd7a-b3b373d17173@virtuozzo.com>
In-Reply-To: <cce60ff4-254d-85df-cd7a-b3b373d17173@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0023.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::33)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200110230559820
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b74a7e2f-e1c7-4639-25a8-08d79608843f
x-ms-traffictypediagnostic: AM6PR08MB3192:
x-microsoft-antispam-prvs: <AM6PR08MB319298FD8E1B82576BC84B61C1380@AM6PR08MB3192.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(396003)(136003)(39840400004)(189003)(199004)(956004)(2616005)(6916009)(8936002)(478600001)(2906002)(66556008)(81166006)(5660300002)(52116002)(86362001)(8676002)(81156014)(4326008)(71200400001)(64756008)(66446008)(6486002)(66476007)(31686004)(66946007)(16526019)(36756003)(316002)(26005)(31696002)(16576012)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3192;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9cjkmmcZFsAQ1tQlAl+46BYoZNshV/TNPET3XWyYpspZk8pzWtBWFuNr3ioUu3/v2OGfCy25M2MHadcvUx8njGe07gCaYBdbXJn268V6cL5CYZDukXDCCDRhDMpTQutkHw5xoW/iy3K67kZXJLNwCteCYceJbZEWEFgcoYoSQYIWYzai2YPmJSOeTyrg7z2AFC7I2CMcwpaD35+kHfYGEEcSkt9i5dJ/i+yDhgddCCoddscnMeVa+xQySOEJvQ6Nf88o1g2D2Ve3AZZCEJ16vx6tgXp4KgcGq77iGpptmd/rGaWT5VKKmsvyqPG2VfYRJsQdl5kvBtNGoW/Y4Cx+qeUFxVpAVeG4z+a21lXS3bHTwjnmzDO9XR2zwhfsqLfRTl5mqUHmOPWi3KXlRAF0550j0I+djZn+avjrF/D0IMgZGSgnxUmPUMWL/toDBk13
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <282CCA970A8D1C4283D550B2031731AC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74a7e2f-e1c7-4639-25a8-08d79608843f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 20:06:02.0429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nj6hwFI1JRDWKJVz1oHMzokr0/M70OKh02duXFeUqaC7HnUU/CQgWNr3C9pkbOs0ekt4kNr4RvbiQ9CwsTGSXca3SGORcoCbRfPIylCESnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3192
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.111
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMTIuMjAxOSAxMzo1MywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDYuMTIuMjAxOSAxMDo0NiwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+PiBWbGFkaW1pciBT
ZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+IHdyaXRlczoNCj4+
DQo+Pj4gMzAuMTEuMjAxOSAyMjo0MiwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+Pj4+IGZp
dF9sb2FkX2ZkdCgpIHJlY292ZXJzIGZyb20gZml0X2ltYWdlX2FkZHIoKSBmYWlsaW5nIHdpdGgg
RU5PRU5ULg0KPj4+PiBFeGNlcHQgaXQgZG9lc24ndCB3aGVuIGl0cyBAZXJycCBhcmd1bWVudCBp
cyAmZXJyb3JfZmF0YWwgb3INCj4+Pj4gJmVycm9yX2Fib3J0LCBiZWNhdXNlIGl0IGJsaW5kbHkg
cGFzc2VzIEBlcnJwIHRvIGZpdF9pbWFnZV9hZGRyKCkuDQo+Pj4+IE1lc3NlZCB1cCBpbiBjb21t
aXQgM2ViOTllZGI0OCAibG9hZGVyLWZpdDogV2VhbiBvZmYgZXJyb3JfcHJpbnRmKCkiLg0KPj4+
Pg0KPj4+PiBUaGUgYnVnIGNhbid0IGJpdGUgYXMgbm8gY2FsbGVyIGFjdHVhbGx5IHBhc3NlcyAm
ZXJyb3JfZmF0YWwgb3INCj4+Pj4gJmVycm9yX2Fib3J0LsKgIEZpeCBpdCBhbnl3YXkuDQo+Pj4+
DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNv
bT4NCj4+Pg0KPj4+IFJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2
c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4NCj4+PiBIbW0sIGFjdHVhbGx5IGl0IG1ha2Vz
IG15DQo+Pj4gIltQQVRDSCB2NyAwMS8yMV0gaHcvY29yZS9sb2FkZXItZml0OiBmaXggZnJlZWlu
ZyBlcnJwIGluIGZpdF9sb2FkX2ZkdCINCj4+PiB1bm5lY2Vzc2FyeS4gSWYgeW91IHdhbnQgeW91
IG1heSBkcm9wIG15IDAxIChhcyBpdCBjb3ZlcnMgbGVzcyBwcm9ibGVtcyksDQo+Pg0KPj4gWWVz
Lg0KPj4NCj4+PiBhbmQgaW4gdGhpcyBjYXNlIHlvdSBtYXkgbm90ZSBpbiB5b3VyIGNvdmVyIGxl
dHRlciwgdGhhdA0KPj4+IGVycnAgPSBOVUxMIGlzIGJyb2tlbiBoZXJlIHRvbyAobWF5IGJlIG5v
YmFkeSBwYXNzIGl0PyksDQo+Pg0KPj4gWW91J3JlIHJpZ2h0LCBudWxsIEBlcnJwIGlzIHdyb25n
LCB0b28uDQo+Pg0KPj4+IGFuZCBub3JtYWwgZXJycCBpcyBoYW5kbGVkIHdyb25nLCBhcyAqZXJy
cCBkb2Vzbid0IHNldCB0byBOVUxMIGFmdGVyDQo+Pj4gZXJyb3JfZnJlZSgqZXJycCkNCj4+DQo+
PiBZZXMsIHRoYXQncyB3cm9uZywgdG9vLsKgIGZpdF9sb2FkX2ZkdCgpIGl0c2VsZiBkb2Vzbid0
IHVzZSAqZXJycCBhZnRlcg0KPj4gZnJlZWluZyBpdCwgYnV0IGl0IHNldHMgYSB0cmFwIGZvciBp
dHMgY2FsbGVycy4NCj4+DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IChzdGlsbCwgdGhlIG9ubHkgY2FsbGVyIHJlbHkgb24gcmV0dXJuIHZhbHVlIG1vcmUgdGhhbiBv
bg0KPj4+IGVyciwgc28gdGhlIHByb2JsZW0gY2FuJ3QgYmUgdHJpZ2dlcmVkIHdpdGggY3VycmVu
dCBjb2RlKQ0KPj4NCj4+IFRydWUuDQo+Pg0KPj4gTmV3IGNvbW1pdCBtZXNzYWdlIChiYXNlZCBv
biB2MidzKToNCj4+DQo+PiDCoMKgwqDCoCBody9jb3JlOiBGaXggZml0X2xvYWRfZmR0KCkgZXJy
b3IgQVBJIHZpb2xhdGlvbnMNCj4+DQo+PiDCoMKgwqDCoCBmaXRfbG9hZF9mZHQoKSBwYXNzZXMg
QGVycnAgdG8gZml0X2ltYWdlX2FkZHIoKSwgdGhlbiByZWNvdmVycyBmcm9tDQo+PiDCoMKgwqDC
oCBFTk9FTlQgZmFpbHVyZXMuwqAgUGFzc2luZyBAZXJycCBpcyB3cm9uZywgYmVjYXVzZSBpdCB3
b3JrcyBvbmx5IGFzDQo+PiDCoMKgwqDCoCBsb25nIGFzIEBlcnJwIGlzIG5laXRoZXIgQGVycm9y
X2ZhdGFsIG5vciBAZXJyb3JfYWJvcnQuwqAgRXJyb3INCj4+IMKgwqDCoMKgIHJlY292ZXJ5IGRl
cmVmZXJlbmNlcyBAZXJycC7CoCBUaGF0J3MgYWxzbyB3cm9uZzsgc2VlIHRoZSBiaWcgY29tbWVu
dA0KPj4gwqDCoMKgwqAgaW4gZXJyb3IuaC7CoCBFcnJvciByZWNvdmVyeSBjYW4gbGVhdmUgKmVy
cnAgcG9pbnRpbmcgdG8gYSBmcmVlZA0KPj4gwqDCoMKgwqAgRXJyb3Igb2JqZWN0LsKgIFdyb25n
LCBpdCBtdXN0IGJlIG51bGwgb24gc3VjY2Vzcy7CoCBNZXNzZWQgdXAgaW4NCj4+IMKgwqDCoMKg
IGNvbW1pdCAzZWI5OWVkYjQ4ICJsb2FkZXItZml0OiBXZWFuIG9mZiBlcnJvcl9wcmludGYoKSIu
DQo+Pg0KPj4gwqDCoMKgwqAgTm8gY2FsbGVyIGFjdHVhbGx5IHBhc3NlcyBzdWNoIHZhbHVlcywg
b3IgdXNlcyAqZXJycCBvbiBzdWNjZXNzLg0KPj4NCj4+IMKgwqDCoMKgIEZpeCBhbnl3YXk6IHNw
bGljZSBpbiBhIGxvY2FsIEVycm9yICplcnIsIGFuZCBlcnJvcl9wcm9wYWdhdGUoKS4NCj4+DQo+
PiDCoMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhh
dC5jb20+DQo+Pg0KPj4gT2theT8NCj4gDQo+IFllcykgYWxzbyBhZGQNCj4gUmV2aWV3ZWQtYnk6
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4N
Cj4gDQo+IA0KPj4NCj4+Pg0KPj4+PiAtLS0NCj4+Pj4gwqDCoCBody9jb3JlL2xvYWRlci1maXQu
YyB8IDE1ICsrKysrKysrLS0tLS0tLQ0KPj4+PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ody9jb3Jl
L2xvYWRlci1maXQuYyBiL2h3L2NvcmUvbG9hZGVyLWZpdC5jDQo+Pj4+IGluZGV4IDk1M2IxNmJj
ODIuLmM0NjU5MjFiOGYgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L2NvcmUvbG9hZGVyLWZpdC5jDQo+
Pj4+ICsrKyBiL2h3L2NvcmUvbG9hZGVyLWZpdC5jDQo+Pj4+IEBAIC0xNzgsMTEgKzE3OCwxMiBA
QCBzdGF0aWMgaW50IGZpdF9sb2FkX2ZkdChjb25zdCBzdHJ1Y3QgZml0X2xvYWRlciAqbGRyLCBj
b25zdCB2b2lkICppdGIsDQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaW50IGNmZywgdm9pZCAqb3BhcXVlLCBjb25zdCB2b2lkICptYXRj
aF9kYXRhLA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGh3YWRkciBrZXJuZWxfZW5kLCBFcnJvciAqKmVycnApDQo+Pj4+IMKgwqAgew0K
Pj4+PiArwqDCoMKgIEVycm9yICplcnIgPSBOVUxMOw0KPj4+PiDCoMKgwqDCoMKgwqAgY29uc3Qg
Y2hhciAqbmFtZTsNCj4+Pj4gwqDCoMKgwqDCoMKgIGNvbnN0IHZvaWQgKmRhdGE7DQo+Pj4+IMKg
wqDCoMKgwqDCoCBjb25zdCB2b2lkICpsb2FkX2RhdGE7DQo+Pj4+IMKgwqDCoMKgwqDCoCBod2Fk
ZHIgbG9hZF9hZGRyOw0KPj4+PiAtwqDCoMKgIGludCBpbWdfb2ZmLCBlcnI7DQo+Pj4+ICvCoMKg
wqAgaW50IGltZ19vZmY7DQo+Pj4+IMKgwqDCoMKgwqDCoCBzaXplX3Qgc3o7DQo+Pj4+IMKgwqDC
oMKgwqDCoCBpbnQgcmV0Ow0KPj4+PiBAQCAtMTk3LDEzICsxOTgsMTMgQEAgc3RhdGljIGludCBm
aXRfbG9hZF9mZHQoY29uc3Qgc3RydWN0IGZpdF9sb2FkZXIgKmxkciwgY29uc3Qgdm9pZCAqaXRi
LA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsNCj4+Pj4gwqDCoMKg
wqDCoMKgIH0NCj4+Pj4gLcKgwqDCoCBlcnIgPSBmaXRfaW1hZ2VfYWRkcihpdGIsIGltZ19vZmYs
ICJsb2FkIiwgJmxvYWRfYWRkciwgZXJycCk7DQo+Pj4+IC3CoMKgwqAgaWYgKGVyciA9PSAtRU5P
RU5UKSB7DQo+Pj4+ICvCoMKgwqAgcmV0ID0gZml0X2ltYWdlX2FkZHIoaXRiLCBpbWdfb2ZmLCAi
bG9hZCIsICZsb2FkX2FkZHIsICZlcnIpOw0KPj4+PiArwqDCoMKgIGlmIChyZXQgPT0gLUVOT0VO
VCkgew0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb2FkX2FkZHIgPSBST1VORF9VUChrZXJu
ZWxfZW5kLCA2NCAqIEtpQikgKyAoMTAgKiBNaUIpOw0KPj4+PiAtwqDCoMKgwqDCoMKgwqAgZXJy
b3JfZnJlZSgqZXJycCk7DQo+Pj4+IC3CoMKgwqAgfSBlbHNlIGlmIChlcnIpIHsNCj4+Pj4gLcKg
wqDCoMKgwqDCoMKgIGVycm9yX3ByZXBlbmQoZXJycCwgInVuYWJsZSB0byByZWFkIEZEVCBsb2Fk
IGFkZHJlc3MgZnJvbSBGSVQ6ICIpOw0KPj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0ID0gZXJyOw0K
Pj4+PiArwqDCoMKgwqDCoMKgwqAgZXJyb3JfZnJlZShlcnIpOw0KPj4+PiArwqDCoMKgIH0gZWxz
ZSBpZiAocmV0KSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBlcnJvcl9wcm9wYWdhdGVfcHJlcGVu
ZChlcnJwLCBlcnIsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAidW5hYmxlIHRvIHJlYWQgRkRUIGxvYWQgYWRkcmVz
cyBmcm9tIEZJVDogIik7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KPj4+
PiDCoMKgwqDCoMKgwqAgfQ0KPj4+Pg0KPj4+DQo+Pj4gU28gbXVjaCBhdHRlbnRpb24gdG8gdGhh
dCBmdW5jdGlvbiA6KQ0KPj4+DQo+Pj4gSSdkIGFsc28gcHJvcG9zZSB0aGUgZm9sbG93aW5nOg0K
Pj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L2NvcmUvbG9hZGVyLWZpdC5jIGIvaHcvY29yZS9sb2Fk
ZXItZml0LmMNCj4+PiBpbmRleCBjNDY1OTIxYjhmLi4yYzllZmVlZjdhIDEwMDY0NA0KPj4+IC0t
LSBhL2h3L2NvcmUvbG9hZGVyLWZpdC5jDQo+Pj4gKysrIGIvaHcvY29yZS9sb2FkZXItZml0LmMN
Cj4+PiBAQCAtMTgwLDggKzE4MCw4IEBAIHN0YXRpYyBpbnQgZml0X2xvYWRfZmR0KGNvbnN0IHN0
cnVjdCBmaXRfbG9hZGVyICpsZHIsIGNvbnN0IHZvaWQgKml0YiwNCj4+PiDCoMKgIHsNCj4+PiDC
oMKgwqDCoMKgwqAgRXJyb3IgKmVyciA9IE5VTEw7DQo+Pj4gwqDCoMKgwqDCoMKgIGNvbnN0IGNo
YXIgKm5hbWU7DQo+Pj4gLcKgwqDCoCBjb25zdCB2b2lkICpkYXRhOw0KPj4+IC3CoMKgwqAgY29u
c3Qgdm9pZCAqbG9hZF9kYXRhOw0KPj4+ICvCoMKgwqAgdm9pZCAqZGF0YTsNCj4+PiArwqDCoMKg
IHZvaWQgKmxvYWRfZGF0YTsNCj4+PiDCoMKgwqDCoMKgwqAgaHdhZGRyIGxvYWRfYWRkcjsNCj4+
PiDCoMKgwqDCoMKgwqAgaW50IGltZ19vZmY7DQo+Pj4gwqDCoMKgwqDCoMKgIHNpemVfdCBzejsN
Cj4+PiBAQCAtMjE4LDkgKzIxOCw5IEBAIHN0YXRpYyBpbnQgZml0X2xvYWRfZmR0KGNvbnN0IHN0
cnVjdCBmaXRfbG9hZGVyICpsZHIsIGNvbnN0IHZvaWQgKml0YiwNCj4+Pg0KPj4+IMKgwqDCoMKg
wqDCoCByZXQgPSAwOw0KPj4+IMKgwqAgb3V0Og0KPj4+IC3CoMKgwqAgZ19mcmVlKCh2b2lkICop
IGRhdGEpOw0KPj4+ICvCoMKgwqAgZ19mcmVlKGRhdGEpOw0KPj4+IMKgwqDCoMKgwqDCoCBpZiAo
ZGF0YSAhPSBsb2FkX2RhdGEpIHsNCj4+PiAtwqDCoMKgwqDCoMKgwqAgZ19mcmVlKCh2b2lkICop
IGxvYWRfZGF0YSk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGdfZnJlZShsb2FkX2RhdGEpOw0KPj4+
IMKgwqDCoMKgwqDCoCB9DQo+Pj4gwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+Pj4gwqDCoCB9
DQo+Pj4NCj4+Pg0KPj4+IE9yLCBldmVuIGJldHRlcjoNCj4+Pg0KPj4+IC0tLSBhL2h3L2NvcmUv
bG9hZGVyLWZpdC5jDQo+Pj4gKysrIGIvaHcvY29yZS9sb2FkZXItZml0LmMNCj4+PiBAQCAtMTgw
LDcgKzE4MCw4IEBAIHN0YXRpYyBpbnQgZml0X2xvYWRfZmR0KGNvbnN0IHN0cnVjdCBmaXRfbG9h
ZGVyICpsZHIsIGNvbnN0IHZvaWQgKml0YiwNCj4+PiDCoMKgIHsNCj4+PiDCoMKgwqDCoMKgwqAg
RXJyb3IgKmVyciA9IE5VTEw7DQo+Pj4gwqDCoMKgwqDCoMKgIGNvbnN0IGNoYXIgKm5hbWU7DQo+
Pj4gLcKgwqDCoCBjb25zdCB2b2lkICpkYXRhOw0KPj4+ICvCoMKgwqAgZ19hdXRvZnJlZSB2b2lk
ICpkYXRhID0gTlVMTDsNCj4+PiArwqDCoMKgIGdfYXV0b2ZyZWUgdm9pZCAqZmR0X2ZpbHRlcl9k
YXRhID0gTlVMTDsNCj4+PiDCoMKgwqDCoMKgwqAgY29uc3Qgdm9pZCAqbG9hZF9kYXRhOw0KPj4+
IMKgwqDCoMKgwqDCoCBod2FkZHIgbG9hZF9hZGRyOw0KPj4+IMKgwqDCoMKgwqDCoCBpbnQgaW1n
X29mZjsNCj4+PiBAQCAtMjAyLDI3ICsyMDMsMjMgQEAgc3RhdGljIGludCBmaXRfbG9hZF9mZHQo
Y29uc3Qgc3RydWN0IGZpdF9sb2FkZXIgKmxkciwgY29uc3Qgdm9pZCAqaXRiLA0KPj4+IMKgwqDC
oMKgwqDCoCBpZiAocmV0ID09IC1FTk9FTlQpIHsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBs
b2FkX2FkZHIgPSBST1VORF9VUChrZXJuZWxfZW5kLCA2NCAqIEtpQikgKyAoMTAgKiBNaUIpOw0K
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX2ZyZWUoZXJyKTsNCj4+PiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIDA7DQo+Pj4gwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAocmV0KSB7DQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyb3JfcHJvcGFnYXRlX3ByZXBlbmQoZXJycCwgZXJyLA0K
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICJ1bmFibGUgdG8gcmVhZCBGRFQgbG9hZCBhZGRyZXNzIGZyb20gRklU
OiAiKTsNCj4+PiAtwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7DQo+Pj4gK8KgwqDCoMKgwqDCoMKg
IHJldHVybiByZXQ7DQo+Pj4gwqDCoMKgwqDCoMKgIH0NCj4+Pg0KPj4+IMKgwqDCoMKgwqDCoCBp
ZiAobGRyLT5mZHRfZmlsdGVyKSB7DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGxvYWRfZGF0YSA9IGxk
ci0+ZmR0X2ZpbHRlcihvcGFxdWUsIGRhdGEsIG1hdGNoX2RhdGEsICZsb2FkX2FkZHIpOw0KPj4+
ICvCoMKgwqDCoMKgwqDCoCBsb2FkX2RhdGEgPSBmZHRfZmlsdGVyX2RhdGEgPQ0KPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGRyLT5mZHRfZmlsdGVyKG9wYXF1ZSwgZGF0YSwg
bWF0Y2hfZGF0YSwgJmxvYWRfYWRkcik7DQo+Pj4gwqDCoMKgwqDCoMKgIH0NCj4+Pg0KPj4+IMKg
wqDCoMKgwqDCoCBsb2FkX2FkZHIgPSBsZHItPmFkZHJfdG9fcGh5cyhvcGFxdWUsIGxvYWRfYWRk
cik7DQo+Pj4gwqDCoMKgwqDCoMKgIHN6ID0gZmR0X3RvdGFsc2l6ZShsb2FkX2RhdGEpOw0KPj4+
IMKgwqDCoMKgwqDCoCByb21fYWRkX2Jsb2JfZml4ZWQobmFtZSwgbG9hZF9kYXRhLCBzeiwgbG9h
ZF9hZGRyKTsNCj4+Pg0KPj4+IC3CoMKgwqAgcmV0ID0gMDsNCj4+PiAtb3V0Og0KPj4+IC3CoMKg
wqAgZ19mcmVlKCh2b2lkICopIGRhdGEpOw0KPj4+IC3CoMKgwqAgaWYgKGRhdGEgIT0gbG9hZF9k
YXRhKSB7DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGdfZnJlZSgodm9pZCAqKSBsb2FkX2RhdGEpOw0K
Pj4+IC3CoMKgwqAgfQ0KPj4+IC3CoMKgwqAgcmV0dXJuIHJldDsNCj4+PiArwqDCoMKgIHJldHVy
biAwOw0KPj4+IMKgwqAgfQ0KPj4NCj4+IExvb2tzIGxpa2UgYSBzZW5zaWJsZSBzZXBhcmF0ZSBj
bGVhbnVwIHBhdGNoIHRvIG1lLsKgIENhcmUgdG8gcG9zdCBpdD8NCj4+DQo+IA0KPiBZZXMsIEkn
bGwgc2VuZA0KPiANCg0KDQpIbSwgaXQgZG9lc24ndCBjb21waWxlLCBhcyBmaXRfbG9hZF9pbWFn
ZV9hbGxvYyByZXR1cm4gdHlwZSBpcyBjb25zdCBwb2ludGVyLi4NClNvLCBJIGp1c3QgZG9uJ3Qg
dW5kZXJzdGFuZCB0aGUgbG9naWMgb2YgdGhlIGNvZGUgKGZvciBtZSBpdCdzIHN0cmFuZ2UgdG8N
CmZyZWUgcG9pbnRlciwgcmV0dXJuZWQgYnkgZnVuY3Rpb24sIHJldHVybmluZyBjb25zdCBwb2lu
dGVyKQ0KDQpBbmQgd2hhdCBhcmUgdGhlIHJlYXNvbnMsIHRvIG1ha2UgcmV0dXJuIHR5cGUgb2Yg
Zml0X2xvYWRfaW1hZ2VfYWxsb2MgY29uc3RhbnQsDQpJIGRvbid0IHNlZS4uIElNSE8sIHRoZXJl
IGFyZSBubyByZWFzb25zLg0KU2FtZSB0aGluZyB3aXRoIC5mZHRfZmlsdGVyIC4uLg0KDQpJIGRv
bid0IHdhbnQgdG8gZGlnIGluLCBzbywgc29ycnksIEknbGwgbm90IHNlbmQgOikNCg0KDQotLSAN
CkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

