Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_RHS_DOB autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846D8C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EBCE22522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PU4+ZSe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBCE22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itqya-0001F1-CG
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 05:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itqxo-0000Zi-KL
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itqxl-0004do-6x
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:40:52 -0500
Received: from mail-eopbgr150115.outbound.protection.outlook.com
 ([40.107.15.115]:31790 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itqxd-0004aT-11; Tue, 21 Jan 2020 05:40:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsS/2BdS6xRxWrs/z8Jlq/WNZSzQUkXEfA3XkbCAxxB9JQ/SCTNvhCzGekjfP6bp4LOlkjUDJgrDhxu7PRkEGXuC9iJpp5t89+sATlNF2pOBpMdfogTKiTS+Ti/edVoLsX3/MdB2/yLcgVf4r2kEoxSBph10idwLWPiZUBRVlW1/ZwPlbZJu7uQeq/ersQbEmmTIdSWB6OqWi3hjOT4X8TtSyZKZz+KIBhA1tAw9n3Vcgo/e9ZyGlQqTfbmL4qMGeKRM0Mm2fM5CSSfMyaMeO8ZPRFEHSu066TqCGvVsN3I5Y8XiL7hlHCS22+YMu1sdy6XXVA3vwYiSEqR8CzaLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56OLDC5a7BQpTXiJZxN4DKRBSmEfFWjgN9DqUn6ExPc=;
 b=bNIiwJz6cNum2GQ4kDsFoQoybi2dvNEDvtadHfd0Hgllp1UGxPm4Ocd2F9N+TYt4yPigR65jABQkUh6UnXlKHwP1h3vR30utBXmdUt+aMwQaKvMQAvqq/Kg0xaV1KrY4nWh1LmPMCO5YHLRrPx1p57bwgc87BGj9Gkz8iZeT2tuOz636g8dPuNQyNZgHRcm8WIZHvlTd/V/N68kbErjPkDZabPZZTxaB9i9pSumVZa0FyUwwydBXcST8Q/X/9pLpzK1TKp5Xl6vyyRTqEA4QFajH7sUlXii6SJafbAmXriRO7hFsLTTmVAlSMhX7+3mwIKphJHULbtljJCopk8aNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56OLDC5a7BQpTXiJZxN4DKRBSmEfFWjgN9DqUn6ExPc=;
 b=PU4+ZSe22DtWcCJjXkflOfrTUUiU8QBO/vR14osuB8CGOrlB1zuTarsW3MUE/O6Ys2+FL9WDqo60ayAXYOJRu+cybKyurRlFl65Pv4VVL/RTnDOW6WqaiDaHUcSJL9ney6BLHiQ9pXLkzvYklh5mpeHfYJLNDtUm4qQ54NoXiXU=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5000.eurprd08.prod.outlook.com (10.255.121.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Tue, 21 Jan 2020 10:40:38 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 10:40:38 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 AM0PR05CA0092.eurprd05.prod.outlook.com (2603:10a6:208:136::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 10:40:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 2/2] iotests: add test for backup-top failure on
 permission activation
Thread-Topic: [PATCH 2/2] iotests: add test for backup-top failure on
 permission activation
Thread-Index: AQHVzIVUyOIzH3fEwkGWDPORhit+OafzzmgAgAAESICAAQrFgIAANI8A///S/oCAABBigA==
Date: Tue, 21 Jan 2020 10:40:38 +0000
Message-ID: <04a32d71-31da-a3e3-5c5f-cc6465fc9402@virtuozzo.com>
References: <20200116155452.30972-1-vsementsov@virtuozzo.com>
 <20200116155452.30972-3-vsementsov@virtuozzo.com>
 <eedd42b6-bf4e-f6de-13a4-412d389fdb09@redhat.com>
 <ea9219cd-8cc1-8cc0-d568-a51013ba74a4@virtuozzo.com>
 <f52b6ff5-e993-d567-cbbe-1d6d158908da@redhat.com>
 <0e865df2-7d21-b18f-b73c-2948577b9dcb@virtuozzo.com>
 <1313e55e-0eb1-890a-4e8e-2517f1e80d38@redhat.com>
In-Reply-To: <1313e55e-0eb1-890a-4e8e-2517f1e80d38@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR05CA0092.eurprd05.prod.outlook.com
 (2603:10a6:208:136::32) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200121134037137
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2827594-0cd9-4d11-1d09-08d79e5e5acf
x-ms-traffictypediagnostic: AM6PR08MB5000:
x-microsoft-antispam-prvs: <AM6PR08MB5000A257891D9255C7A432BAC10D0@AM6PR08MB5000.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(39850400004)(396003)(366004)(136003)(189003)(199004)(66446008)(64756008)(66476007)(66946007)(6486002)(2906002)(66556008)(508600001)(966005)(71200400001)(316002)(53546011)(31686004)(16576012)(110136005)(54906003)(186003)(2616005)(956004)(26005)(81166006)(8936002)(8676002)(81156014)(31696002)(36756003)(16526019)(86362001)(4326008)(52116002)(5660300002)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5000;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +4Am9oZdOQ2yWhD09iGvYl3PRA3y9HH3uX/3R3mvDqnccqS+QKfFFqLW1EsQfu4vfquKvnH33YvGrJwxbhCfQYg/yQkBFIpuwpoHILhiaSCKzjGoujQJitnZ48ybat/L9HgCKPxDKRn33RoZcdwDWR3H4NsBejRlbnnXLBKXS0UtYArp1SlucsA3L6tzaQcuvMdmgC3r63uAsqAjpDZlkEOTQAKOW9K4KBLWky+KeAfb2enB7gikxuX2efdh/wRFXKc6cYYMTsehKDCriVd+CUEAiXA6V1gspJXpu3Axzi/jLDHksPEqYShhpYXj9S2REkS0MYsvpYTXXA9enLaFuzd81GMFLb4Ex0fYxklob+9xaQTV9Ys0uel2N3ktzWE4X91vmNCDY8pGm7kUV9aH1IH5w7IeNq4VPqlgghxYhm3yFl4d8lwicI16OB6PS9wCczj2G05SJd7sM4VcCoo9t7iZIlFILclPQ94m0EvoMoxTOhum+OIKyx8t1IcUWtkuB0Z12JXq6ZSWzudMi9CBhSP1a1+Ud8xjxdzwWrADlfdm5DkcxgaKxwNMkZKmErCN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B99FB577144C294BAC4C9DF27C8463CA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2827594-0cd9-4d11-1d09-08d79e5e5acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 10:40:38.5270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JwIghk9Ibn3EwxazhuZViCAHEmiPB9KfAtMyYI1e67vAn6LWt4wcADbDCXtECYIoM3u7LN1zNqgpf2FynsxubDJBOJTe3qU12xs+vqbw4qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5000
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.115
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjEuMDEuMjAyMCAxMjo0MSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyMS4wMS4yMCAxMDoyMywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDIxLjAxLjIwMjAgMTI6MTQs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAyMC4wMS4yMCAxODoyMCwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMjAuMDEuMjAyMCAyMDowNCwgTWF4IFJlaXR6IHdy
b3RlOg0KPj4+Pj4gT24gMTYuMDEuMjAgMTY6NTQsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4gVGhpcyB0ZXN0IGNoZWNrcyB0aGF0IGJ1ZyBpcyByZWFsbHkgZml4
ZWQgYnkgcHJldmlvdXMgY29tbWl0Lg0KPj4+Pj4+DQo+Pj4+Pj4gQ2M6IHFlbXUtc3RhYmxlQG5v
bmdudS5vcmcgIyB2NC4yLjANCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRz
b3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4+Pj4gLS0tDQo+Pj4+
Pj4gICAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yODMgICAgIHwgNzUgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4+Pj4+PiAgICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI4My5v
dXQgfCAgOCArKysrDQo+Pj4+Pj4gICAgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAgIHwgIDEg
Kw0KPj4+Pj4+ICAgICAzIGZpbGVzIGNoYW5nZWQsIDg0IGluc2VydGlvbnMoKykNCj4+Pj4+PiAg
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3FlbXUtaW90ZXN0cy8yODMNCj4+Pj4+PiAgICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3FlbXUtaW90ZXN0cy8yODMub3V0DQo+Pj4+Pg0KPj4+
Pj4gVGhlIHRlc3QgbG9va3MgZ29vZCB0byBtZSwgSSBqdXN0IGhhdmUgYSBjb21tZW50IG5pdCBh
bmQgYSBub3RlIG9uIHRoZQ0KPj4+Pj4gZmFjdCB0aGF0IHRoaXMgc2hvdWxkIHByb2JhYmx5IGJl
IHF1ZXVlZCBvbmx5IGFmdGVyIFRob21hc+KAmXMg4oCcRW5hYmxlDQo+Pj4+PiBtb3JlIGlvdGVz
dHMgZHVyaW5nICJtYWtlIGNoZWNrLWJsb2NrIuKAnSBzZXJpZXMuDQo+Pj4+Pg0KPj4+Pj4+IGRp
ZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMjgzIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI4
Mw0KPj4+Pj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+Pj4+Pj4gaW5kZXggMDAwMDAwMDAwMC4u
ZjBmMjE2ZDEwOQ0KPj4+Pj4+IC0tLSAvZGV2L251bGwNCj4+Pj4+PiArKysgYi90ZXN0cy9xZW11
LWlvdGVzdHMvMjgzDQo+Pj4+Pj4gQEAgLTAsMCArMSw3NSBAQA0KPj4+Pj4+ICsjIS91c3IvYmlu
L2VudiBweXRob24NCj4+Pj4+PiArIw0KPj4+Pj4+ICsjIFRlc3QgZm9yIGJhY2t1cC10b3AgZmls
dGVyIHBlcm1pc3Npb24gYWN0aXZhdGlvbiBmYWlsdXJlDQo+Pj4+Pj4gKyMNCj4+Pj4+PiArIyBD
b3B5cmlnaHQgKGMpIDIwMTkgVmlydHVvenpvIEludGVybmF0aW9uYWwgR21iSC4NCj4+Pj4+PiAr
Iw0KPj4+Pj4+ICsjIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQo+Pj4+Pj4gKyMgaXQgdW5kZXIgdGhlIHRlcm1zIG9m
IHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkNCj4+Pj4+PiAr
IyB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBM
aWNlbnNlLCBvcg0KPj4+Pj4+ICsjIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24u
DQo+Pj4+Pj4gKyMNCj4+Pj4+PiArIyBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhl
IGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwNCj4+Pj4+PiArIyBidXQgV0lUSE9VVCBBTlkg
V0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZg0KPj4+Pj4+ICsj
IE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNl
ZSB0aGUNCj4+Pj4+PiArIyBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRh
aWxzLg0KPj4+Pj4+ICsjDQo+Pj4+Pj4gKyMgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29w
eSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UNCj4+Pj4+PiArIyBhbG9uZyB3aXRo
IHRoaXMgcHJvZ3JhbS4gIElmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMv
Pi4NCj4+Pj4+PiArIw0KPj4+Pj4+ICsNCj4+Pj4+PiAraW1wb3J0IGlvdGVzdHMNCj4+Pj4+PiAr
DQo+Pj4+Pj4gKyMgVGhlIHRlc3QgaXMgdW5yZWxhdGVkIHRvIGZvcm1hdHMsIHJlc3RyaWN0IGl0
IHRvIHFjb3cyIHRvIGF2b2lkIGV4dHJhIHJ1bnMNCj4+Pj4+PiAraW90ZXN0cy52ZXJpZnlfaW1h
Z2VfZm9ybWF0KHN1cHBvcnRlZF9mbXRzPVsncWNvdzInXSkNCj4+Pj4+PiArDQo+Pj4+Pj4gK3Np
emUgPSAxMDI0ICogMTAyNA0KPj4+Pj4+ICsNCj4+Pj4+PiArIiIiDQo+Pj4+Pj4gK09uIGFjdGl2
YXRpb24sIGJhY2t1cC10b3AgaXMgZ29pbmcgdG8gdW5zaGFyZSB3cml0ZSBwZXJtaXNzaW9uIG9u
IGl0cw0KPj4+Pj4+ICtzb3VyY2UgY2hpbGQuIEl0IHdpbGwgYmUgaW1wb3NzaWJsZSBmb3IgdGhl
IGZvbGxvd2luZyBjb25maWd1cmF0aW9uOg0KPj4+Pj4NCj4+Pj4+IOKAnFRoZSBmb2xsb3dpbmcg
Y29uZmlndXJhdGlvbiB3aWxsIGJlY29tZSBpbXBvc3NpYmxl4oCdPw0KPj4+Pg0KPj4+PiBIbW0s
IG5vLCB0aGUgY29uZmlndXJhdGlvbiBpcyBwb3NzaWJsZS4gQnV0ICJpdCIsIGkuZS4gInVuc2hh
cmUgd3JpdGUgcGVybWlzc2lvbiIsDQo+Pj4+IGlzIGltcG9zc2libGUgd2l0aCBzdWNoIGNvbmZp
Z3VyYXRpb24uLg0KPj4+DQo+Pj4gQnV0IGJhY2t1cF90b3AgYWx3YXlzIHVuc2hhcmVzIHRoZSB3
cml0ZSBwZXJtaXNzaW9uIG9uIHRoZSBzb3VyY2UuDQo+Pg0KPj4gWWVzLCBhbmQgSSBqdXN0IHRy
eSB0byBzYXksIHRoYXQgdGhpcyBhY3Rpb24gd2lsbCBmYWlsLiBBbmQgdGhlIHRlc3QgY2hlY2tz
IHRoYXQgaXQNCj4+IGZhaWxzIChhbmQgaXQgY3Jhc2hlcyB3aXRoIGN1cnJlbnQgbWFzdGVyIGlu
c3RlYWQgb2YgZmFpbCkuDQo+IA0KPiBPSy4gIFNvIHdoYXQgSSB3YXMgdHJ5aW5nIHRvIHNheSBp
cyB0aGF0IHRoZSBjb21tZW50IGN1cnJlbnRseSBvbmx5DQo+IHN0YXRlcyB0aGF0IHRoaXMgd2ls
bCBmYWlsLiAgSeKAmWQgcHJlZmVyIGl0IHRvIGFsc28gcmVhc3N1cmUgbWUgdGhhdCBpdOKAmXMN
Cj4gY29ycmVjdCB0aGF0IHRoaXMgZmFpbHMgKGJlY2F1c2UgYWxsIHdyaXRlcyBvbiB0aGUgYmFj
a3VwIHNvdXJjZSBtdXN0IGdvDQo+IHRocm91Z2ggYmFja3VwX3RvcCksIGFuZCB0aGF0IHRoaXMg
aXMgZXhhY3RseSB3aGF0IHdlIHdhbnQgdG8gdGVzdCBoZXJlLg0KPiANCj4gT24gZmlyc3QgcmVh
ZGluZywgSSB3YXMgd29uZGVyaW5nIHdoeSBleGFjdGx5IHRoaXMgY29tbWVudCB3b3VsZCB0ZWxs
IG1lDQo+IGFsbCB0aGVzZSB0aGluZ3MsIGJlY2F1c2UgSSBkaWRu4oCZdCBrbm93IHdoYXQgdGhl
IHRlc3Qgd2FudHMgdG8gdGVzdCBpbg0KPiB0aGUgZmlyc3QgcGxhY2UuDQo+IA0KPiBNYXgNCg0K
SG1tLCBzb21ldGhpbmcgbGlrZToNCg0KQmFja3VwIHdhbnRzIHRvIGNvcHkgYSBwb2ludC1pbi10
aW1lIHN0YXRlIG9mIHRoZSBzb3VyY2Ugbm9kZS4gU28sIGl0IGNhdGNoZXMgYWxsIHdyaXRlcw0K
dG8gdGhlIHNvdXJjZSBub2RlIGJ5IGFwcGVuZGluZyBiYWNrdXAtdG9wIGZpbHRlciBhYm92ZSBp
dC4gU28gd2UgaGFuZGxlIGFsbCBjaGFuZ2VzIHdoaWNoDQpjb21lcyBmcm9tIHNvdXJjZSBub2Rl
IHBhcmVudHMuIFRvIHByZXZlbnQgYXBwZWFyaW5nIG9mIG5ldyB3cml0aW5nIHBhcmVudHMgZHVy
aW5nIHRoZQ0KcHJvZ3Jlc3MsIGJhY2t1cC10b3AgdW5zaGFyZXMgd3JpdGUgcGVybWlzc2lvbiBv
biBpdHMgc291cmNlIGNoaWxkLiBUaGlzIGhhcyBhZGRpdGlvbmFsDQppbXBsaWNhdGlvbjogYXMg
dGhpcyAidW5zaGFyaW5nIiBpcyBwcm9wYWdhdGVkIGJ5IGRlZmF1bHQgYnkgYmFja2luZy9maWxl
IGNoaWxkcmVuLA0KYmFja3VwLXRvcCBjb25mbGljdHMgd2l0aCBhbnkgc2lkZSBwYXJlbnRzIG9m
IHNvdXJjZSBzdWItdHJlZSB3aXRoIHdyaXRlIHBlcm1pc3Npb24uDQpBbmQgdGhpcyBpcyBpbiBn
b29kIHJlbGF0aW9uIHdpdGggdGhlIGdlbmVyYWwgaWRlYTogd2l0aCBzdWNoIHBhcmVudHMgd2Ug
Y2FuJ3QgZ3VhcmFudGVlDQpwb2ludC1pbi10aW1lIGJhY2t1cC4gU28sIHRyeWluZyB0byBiYWNr
dXAgdGhlIGNvbmZpZ3VyYXRpb24gd2l0aCB3cml0aW5nIHNpZGUgcGFyZW50cyBvZg0Kc291cmNl
IHN1Yi10cmVlIG5vZGVzIHNob3VsZCBmYWlsLiBMZXQncyB0ZXN0IGl0Lg0KDQo+IA0KPj4+Pj4g
SSB0aGluayB0aGVyZSBzaG91bGQgYmUgc29tZSBub3RlIHRoYXQgdGhpcyBpcyBleGFjdGx5IHdo
YXQgd2Ugd2FudCB0bw0KPj4+Pj4gdGVzdCwgaS5lLiB3aGF0IGhhcHBlbnMgd2hlbiB0aGlzIGlt
cG9zc2libGUgY29uZmlndXJhdGlvbiBpcyBhdHRlbXB0ZWQNCj4+Pj4+IGJ5IHN0YXJ0aW5nIGEg
YmFja3VwLiAgKEFuZCBtYXliZSB3aHkgdGhpcyBpc27igJl0IGFsbG93ZWQ7IG5hbWVseSBiZWNh
dXNlDQo+Pj4+PiB3ZSBjb3VsZG7igJl0IGRvIENCVyBmb3Igc3VjaCB3cml0ZSBhY2Nlc3Nlcy4p
DQo+Pj4+Pg0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUkCAgdGFyZ2V0ICDilIzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lJANCj4+Pj4+PiArICAgIOKUgiB0YXJnZXQg4pSCIOKXgOKUgOKUgOKUgOKUgOKUgOKUgOKUgCDi
lIIgYmFja3VwX3RvcCAg4pSCDQo+Pj4+Pj4gKyAgICDilJTilIDilIDilIDilIDilIDilIDilIDi
lIDilJggICAgICAgICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSYDQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICDilIINCj4+Pj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiBiYWNraW5nDQo+Pj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICDilrwNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg4pSM
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQo+Pj4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgIOKUgiAgIHNvdXJjZSAgICDilIINCj4+Pj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSYDQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICDilIINCj4+Pj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiBmaWxlDQo+Pj4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICDilrwNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg4pSM4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQICB3cml0ZSBwZXJtICAg4pSM
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
IOKUgiAgICBiYXNlICAgICDilIIg4peA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSAIOKUgiBvdGhlciDilIINCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg4pSU4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYICAgICAgICAgICAgICAg4pSU
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYDQo+Pj4+Pg0KPj4+Pj4gQ29vbCBVbmljb2RlIGFydC4g
Oi0pDQo+Pj4+DQo+Pj4+IEkgZm91bmQgdGhlIGdyZWF0IHRvb2w6IGh0dHBzOi8vZG90LXRvLWFz
Y2lpLmdnZXJnYW5vdi5jb20vDQo+Pj4NCj4+PiBUaGFua3MhDQo+Pj4NCj4+PiBNYXgNCj4+Pg0K
Pj4+Pj4+ICsNCj4+Pj4+PiArV3JpdGUgdW5zaGFyaW5nIHdpbGwgYmUgcHJvcGFnYXRlZCB0byB0
aGUgInNvdXJjZS0+YmFzZSJsaW5rIGFuZCB3aWxsDQo+Pj4+Pj4gK2NvbmZsaWN0IHdpdGggb3Ro
ZXIgbm9kZSB3cml0ZSBwZXJtaXNzaW9uLg0KPj4+Pj4+ICsNCj4+Pj4+PiArKE5vdGUsIHRoYXQg
d2UgY2FuJ3QganVzdCBjb25zaWRlciBzb3VyY2UgdG8gYmUgZGlyZWN0IGNoaWxkIG9mIG90aGVy
LA0KPj4+Pj4+ICthcyBpbiB0aGlzIGNhc2UgdGhpcyBsaW5rIHdpbGwgYmUgYnJva2VuLCB3aGVu
IGJhY2t1cF90b3AgaXMgYXBwZW5kZWQpDQo+Pj4+Pj4gKyIiIg0KPj4+Pj4+ICsNCj4+Pj4+PiAr
dm0gPSBpb3Rlc3RzLlZNKCkNCj4+Pj4+PiArdm0ubGF1bmNoKCkNCj4+Pj4+PiArDQo+Pj4+Pj4g
K3ZtLnFtcF9sb2coJ2Jsb2NrZGV2LWFkZCcsICoqeydub2RlLW5hbWUnOiAndGFyZ2V0JywgJ2Ry
aXZlcic6ICdudWxsLWNvJ30pDQo+Pj4+Pj4gKw0KPj4+Pj4+ICt2bS5xbXBfbG9nKCdibG9ja2Rl
di1hZGQnLCAqKnsNCj4+Pj4+PiArICAgICdub2RlLW5hbWUnOiAnc291cmNlJywNCj4+Pj4+PiAr
ICAgICdkcml2ZXInOiAnYmxrZGVidWcnLA0KPj4+Pj4+ICsgICAgJ2ltYWdlJzogeydub2RlLW5h
bWUnOiAnYmFzZScsICdkcml2ZXInOiAnbnVsbC1jbycsICdzaXplJzogc2l6ZX0NCj4+Pj4+PiAr
fSkNCj4+Pj4+PiArDQo+Pj4+Pj4gK3ZtLnFtcF9sb2coJ2Jsb2NrZGV2LWFkZCcsICoqew0KPj4+
Pj4+ICsgICAgJ25vZGUtbmFtZSc6ICdvdGhlcicsDQo+Pj4+Pj4gKyAgICAnZHJpdmVyJzogJ2Js
a2RlYnVnJywNCj4+Pj4+PiArICAgICdpbWFnZSc6ICdiYXNlJywNCj4+Pj4+PiArICAgICd0YWtl
LWNoaWxkLXBlcm1zJzogWyd3cml0ZSddDQo+Pj4+Pj4gK30pDQo+Pj4+Pj4gKw0KPj4+Pj4+ICt2
bS5xbXBfbG9nKCdibG9ja2Rldi1iYWNrdXAnLCBzeW5jPSdmdWxsJywgZGV2aWNlPSdzb3VyY2Un
LCB0YXJnZXQ9J3RhcmdldCcpDQo+Pj4+Pj4gKw0KPj4+Pj4+ICt2bS5zaHV0ZG93bigpDQo+Pj4+
Pg0KPj4+Pj4gWy4uLl0NCj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90
ZXN0cy9ncm91cCBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9ncm91cA0KPj4+Pj4+IGluZGV4IGNiMmI3
ODllNDQuLmQ4MjdlOGM4MjEgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3Rz
L2dyb3VwDQo+Pj4+Pj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwDQo+Pj4+Pj4gQEAg
LTI4OCwzICsyODgsNCBAQA0KPj4+Pj4+ICAgICAyNzcgcncgcXVpY2sNCj4+Pj4+PiAgICAgMjc5
IHJ3IGJhY2tpbmcgcXVpY2sNCj4+Pj4+PiAgICAgMjgwIHJ3IG1pZ3JhdGlvbiBxdWljaw0KPj4+
Pj4+ICsyODMgYXV0byBxdWljaw0KPj4+Pj4NCj4+Pj4+IEhtLiAgVGhpcyB3b3VsZCBiZSB0aGUg
Zmlyc3QgUHl0aG9uIHRlc3QgaW4gYXV0by4NCj4+Pj4NCj4+Pj4gTWlzc2VkIHRoYXQuIEl0J3Mg
T0sgdG8gZGVmaW5lIGl0IGp1c3QgInF1aWNrIiBhbmQgdXBkYXRlIGxhdGVyLg0KPj4+Pg0KPj4+
Pj4gICAgVGhvbWFz4oCZcyBzZXJpZXMgaGFzDQo+Pj4+PiBhdCBsZWFzdCBvbmUgcGF0Y2ggdGhh
dCBzZWVtcyB1c2VmdWwgdG8gY29tZSBiZWZvcmUgd2UgZG8gdGhpcywgbmFtZWx5DQo+Pj4+PiDi
gJxTa2lwIFB5dGhvbi1iYXNlZCB0ZXN0cyBpZiBRRU1VIGRvZXMgbm90IHN1cHBvcnQgdmlydGlv
LWJsa+KAnS4gIFNvIEkNCj4+Pj4+IHN1cHBvc2UgaGlzIHNlcmllcyBzaG91bGQgY29tZSBiZWZv
cmUgdGhpcywgdGhlbi4NCj4+Pj4+DQo+Pj4+PiBNYXgNCj4+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4N
Cj4+Pg0KPj4NCj4+DQo+IA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

