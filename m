Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4B3C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 871EF20657
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="brCSgsLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871EF20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46982 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqrZ-00087V-Kg
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41877)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hcqo5-0006K7-MC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hcqo3-0000Vy-1J
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:32:16 -0400
Received: from mail-eopbgr20129.outbound.protection.outlook.com
 ([40.107.2.129]:3905 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hcqns-0000NT-Sk; Mon, 17 Jun 2019 08:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL9ZT+xRKd2SeJHLYc0MfrvZWD+pHOG4nbRrZigE0m4=;
 b=brCSgsLCa4OPoEQRuGTi610Dhfm5rT49hkoUfV9EMENEzI0JZzVjJP97RtUoZAQt5gWqtq8a19nMItcEHARF9juzhioDDxki567ieaFdn4f0Cuw5P7WDJ+y2n0xUOjaHisTvgVmCCB2e4KtmgHYuL/QkmyBK4TMG28X6loNfTLg=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4377.eurprd08.prod.outlook.com (20.179.42.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Mon, 17 Jun 2019 12:32:02 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 12:32:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH 0/3] block: blk_co_pcache
Thread-Index: AQHVHG6Gw8f3OdFEe0GxA9A7ku3zhaaOpkUAgAADMICAEU1cAP//21mAgAAGSAA=
Date: Mon, 17 Jun 2019 12:32:01 +0000
Message-ID: <07ffee0e-8860-f770-92be-d157d14f282a@virtuozzo.com>
References: <20190606134814.123689-1-vsementsov@virtuozzo.com>
 <f92b274d-1949-3afa-7353-d3e3d67ae705@redhat.com>
 <dbacab33-ccb4-0c1e-5ce3-7214bd405701@virtuozzo.com>
 <4ec35629-0c64-9727-780f-31e4e494f376@virtuozzo.com>
 <20190617120929.GF7397@linux.fritz.box>
In-Reply-To: <20190617120929.GF7397@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::34) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190617153158477
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e52c388a-e641-40df-e6b8-08d6f31fcc09
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4377; 
x-ms-traffictypediagnostic: DBBPR08MB4377:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DBBPR08MB43774B0E93136BECD793EAA7C1EB0@DBBPR08MB4377.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(396003)(39840400004)(136003)(346002)(376002)(366004)(53754006)(199004)(189003)(8936002)(6246003)(478600001)(31686004)(5660300002)(68736007)(102836004)(305945005)(6512007)(76176011)(52116002)(14454004)(25786009)(6116002)(3846002)(107886003)(386003)(6506007)(71190400001)(36756003)(71200400001)(186003)(53546011)(6436002)(6486002)(6916009)(26005)(7736002)(53936002)(6306002)(2906002)(14444005)(256004)(54906003)(86362001)(476003)(486006)(11346002)(2616005)(4326008)(31696002)(66446008)(64756008)(66556008)(66476007)(66066001)(229853002)(316002)(99286004)(8676002)(446003)(81166006)(66946007)(73956011)(81156014)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4377;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SSpqBgThTFyW2HMz72i+VXvmrRPFH90VHI6Tx6+IeJNqZH9iTgFcLaDkBGxF9PUDgF/4kZbmcyJE2ek1rNZlbbvwd/oMbI9G6Z4lXYQeZ92g6Cy+TNSut6lVpoPPDetf1mkFYfVs1QQPnqVVhEzXVj4KqkOecHp03q83FS4LNx3y3FsRdozvQSium9+fsZU4ApBr+FWndPth2ue+ht0/KMqwFYJHp0/s32qExIGDr9L+pFqje6FsYQ0ESwxXCi4/lLTJ9WbEmbYTeJjZGskrXH0Bh7GGIRFhl4qm6IeZzEtxIQHF8C61Nb/PiL+1U+RAj3OaSp0b12HFTfDDNcLnOnMD0s/4v6Q0MyTfyotyTWJh6tZrqVRNZxWWKd0sOgUo3swUVpEgLI1/RZZfFfHZcCck28bPIEB/fSZItOPlttk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8E1CD279C43174CA980B5E77C003119@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52c388a-e641-40df-e6b8-08d6f31fcc09
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 12:32:01.6068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4377
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.129
Subject: Re: [Qemu-devel] [PATCH 0/3] block: blk_co_pcache
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTcuMDYuMjAxOSAxNTowOSwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTcuMDYuMjAxOSB1bSAx
MzoyMCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDA2
LjA2LjIwMTkgMTc6MDcsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4g
MDYuMDYuMjAxOSAxNjo1NSwgRXJpYyBCbGFrZSB3cm90ZToNCj4+Pj4gT24gNi82LzE5IDg6NDgg
QU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+PiBIaSBhbGwhDQo+
Pj4+Pg0KPj4+Pj4gSGVyZSBpcyBzbWFsbCBuZXcgaW8gQVBJOiBibGtfY29fcGNhY2hlLCB3aGlj
aCBkb2VzIGNvcHktb24tcmVhZCB3aXRob3V0DQo+Pj4+PiBleHRyYSBidWZmZXIgZm9yIHJlYWQg
ZGF0YS4gVGhpcyBtZWFucyB0aGF0IG9ubHkgcGFydHMgdGhhdCBuZWVkcyBDT1INCj4+Pj4+IHdp
bGwgYmUgYWN0dWFsbHkgcmVhZCBhbmQgb25seSBjb3JyZXNwb25kaW5nIGJ1ZmZlcnMgYWxsb2Nh
dGVkLCBubyBtb3JlLg0KPj4+Pj4NCj4+Pj4+IFRoaXMgYWxsb3dzIHRvIGltcHJvdmUgYSBiaXQg
YmxvY2stc3RyZWFtIGFuZCBOQkRfQ01EX0NBQ0hFDQo+Pj4+DQo+Pj4+IEknZCByZWFsbHkgbGlr
ZSB0byBzZWUgcWVtdS1pbyBnYWluIGFjY2VzcyB0byBjYWxsaW5nIHRoaXMgY29tbWFuZCwgc28N
Cj4+Pj4gdGhhdCB3ZSBjYW4gYWRkIGlvdGVzdHMgY292ZXJhZ2Ugb2YgdGhpcyBuZXcgZmVhdHVy
ZS4gTm90ZSB0aGF0IHRoZQ0KPj4+PiBpbi1kZXZlbG9wbWVudCBsaWJuYmQNCj4+Pj4gKGh0dHBz
Oi8vZ2l0aHViLmNvbS9saWJndWVzdGZzL2xpYm5iZC9jb21taXRzL21hc3RlcikgaXMgYWxzbyB1
c2FibGUgYXMNCj4+Pj4gYW4gTkJEIGNsaWVudCB0aGF0IGNhbiBkcml2ZSBOQkRfQ01EX0NBQ0hF
LCBhbHRob3VnaCBpdCdzIHN0aWxsIG5ldw0KPj4+PiBlbm91Z2ggdGhhdCB3ZSBwcm9iYWJseSBk
b24ndCB3YW50IHRvIHJlbHkgb24gaXQgYmVpbmcgYXZhaWxhYmxlIHlldC4NCj4+Pj4NCj4+Pg0K
Pj4+IEhtbSwgZG9uJ3QgeW91IHRoaW5rIHRoYXQgYmxrX2NvX3BjYWNoZSBzZW5kcyBOQkRfQ01E
X0NBQ0hFIGlmIGNhbGxlZCBvbiBuYmQgZHJpdmVyPw0KPj4+IEkgZGlkbid0IGltcGxlbWVudCBp
dC4gQnV0IG1heSBiZSBJIHNob3VsZC4uDQo+Pj4NCj4+PiBNYXkgYWltIHdhcyBvbmx5IHRvIGF2
b2lkIGV4dHJhIGFsbG9jYXRpb24gYW5kIHVubmVjZXNzYXJ5IHJlYWRzLiBCdXQgaWYgd2UgaW1w
bGVtZW50DQo+Pj4gZnVsbC1mZWF0dXJlZCBpbyByZXF1ZXN0LCB3aGF0IHNob3VsZCBpdCBkbz8N
Cj4+Pg0KPj4+IE9uIHFjb3cyIHdpdGggYmFja2luZyBpdCBzaG91bGQgcHVsbCBkYXRhIGZyb20g
YmFja2luZyB0byB0b3AsIGxpa2UgaW4gY29weS1vbi1yZWFkLg0KPj4+IEFuZCBmb3IgbmJkIGl0
IHdpbGwgc2VuZCBOQkRfQ01EX0NBQ0hFPw0KPj4+IFRoZXNlIHNlbWFudGljcyBzZWVtcyBkaWZm
ZXJlbnQsIGJ1dCB3aHkgbm90Pw0KPj4+DQo+Pg0KPj4gQW55IG9waW5pb25zIGhlcmU/IFNob3Vs
ZCBJIHJlc2VuZCBvciBjb3VsZCB3ZSB1c2UgaXQgYXMgYSBmaXJzdCBzdGVwLA0KPj4gbm90IHRv
dWNoaW5nIGV4dGVybmFsIEFQSSBidXQgaW1wcm92aW5nIHRoaW5ncyBhIGxpdHRsZSBiaXQ/DQo+
IA0KPiBJJ20gbm90IG9wcG9zZWQgdG8gbWFraW5nIG9ubHkgYSBmaXJzdCBzdGVwIG5vdy4gVGhl
IGludGVyZmFjZSBzZWVtcyB0bw0KPiBtYWtlIHNlbnNlIHRvIG1lOyB0aGUgb25seSB0aGluZyB0
aGF0IEkgZG9uJ3QgcmVhbGx5IGxpa2UgaXMgdGhlIG5hbWluZw0KPiBib3RoIG9mIHRoZSBvcGVy
YXRpb24gKGJsa19jb19wY2FjaGUpIGFuZCBvZiB0aGUgZmxhZyAoQkRSVl9SRVFfQ0FDSEUpDQo+
IGJlY2F1c2UgdG8gbWUsICJjYWNoZSIgZG9lc24ndCBtZWFuICJyZWFkLCBidXQgaWdub3JlIHRo
ZSByZXN1bHQiLg0KPiANCj4gVGhlIG9wZXJhdGlvbiBvbmx5IHJlc3VsdHMgaW4gc29tZXRoaW5n
IGJlaW5nIGNhY2hlZCBpZiB0aGUgYmxvY2sgZ3JhcGgNCj4gaXMgY29uZmlndXJlZCB0byBjYWNo
ZSB0aGluZ3MuIEFuZCBpbmRlZWQsIHRoZSBtb3N0IGltcG9ydGF0biB1c2UgY2FzZQ0KPiBmb3Ig
dGhlIGZsYWcgaXMgbm90IHBvcHVsYXRpbmcgYSBjYWNoZSwgYnV0IHRyaWdnZXJpbmcgY29weS1v
bi1yZWFkLiBTbw0KPiBJIHRoaW5rIGNhbGxpbmcgdGhpcyBvcGVyYXRpb24gImNhY2hlIiBpcyBt
aXNsZWFkaW5nLg0KPiANCj4gTm93LCBJIGRvbid0IGhhdmUgdmVyeSBnb29kIGlkZWFzIGZvciBi
ZXR0ZXIgbmFtZXMgZWl0aGVyLiBJIGd1ZXNzDQo+IEJEUlZfUkVRX05PX0RBVEEgY291bGQgd29y
aywgdGhvdWdoIGl0J3Mgbm90IHBlcmZlY3QuIChBbHNvLCBub3Qgc3VyZSBpZg0KPiBhIGJsa19j
b19wcmVhZHZfbm9fcmVhZCB3cmFwcGVyIGlzIGV2ZW4gbmVlZGVkIHdoZW4geW91IGNhbiBqdXN0
IGNhbGwNCj4gYmxrX2NvX3ByZWFkdiB3aXRoIHRoZSByaWdodCBmbGFnLikNCj4gDQo+IEknbSBv
cGVuIGZvciBnb29kIG5hbWluZyBpZGVhcy4NCj4gDQoNCk15IGZpcnN0IHRyeSAobm90IHB1Ymxp
c2hlZCkgd2FzIEJEUlZfUkVRX0ZBS0VfUkVBRCwgcGFzc2VkIGFzIGZsYWcgdG8gYmxrX2NvX3By
ZWFkdiwNCndpdGhvdXQgc2VwYXJhdGUgaW8gcmVxdWVzdCBmdW5jdGlvbi4NCg0KSSBkZWNpZGVk
IHRvIG1ha2UgaXQgdG8gYmUgQ2FjaGUgcmVxdWVzdCBpbnNwaXJlZCBieSBOQkRfQ01EX0NBQ0hF
LCB3aGljaCB3YXMgY3JlYXRlZA0KdG8gZG8gZXhhY3RseSBjb3B5LW9uLXJlYWQgb3BlcmF0aW9u
LiBTbyBpZiB3ZSBjYWxsIGl0IGNhY2hlIGl0IHdpbGwgY29ycmVzcG9uZCB0bw0KTkJEIHByb3Rv
Y29sLg0KDQpfTk9fREFUQSBhbHNvIHdvcmtzIGZvciBtZSwgbm90IGEgcHJvYmxlbSB0byByZXNl
bmQgd2l0aCB0aGlzIGZsYWcgYW5kIHdpdGhvdXQgYWRkaXRpb25hbA0Kd3JhcHBlciwgYXMgYSBm
aXJzdCBzdGVwLg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

