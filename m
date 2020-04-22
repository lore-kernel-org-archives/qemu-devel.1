Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9BCC55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F167620735
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F167620735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRBId-0001Dr-5k
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 05:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRBI2-0000oY-3S
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRBI0-0003D6-JX
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:03:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:44293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jRBI0-00036l-1z
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:03:28 -0400
IronPort-SDR: nFd1HJaxf8QJWAItHgt2nc0qETqJyzqzUXyYlNL/AmSRXmqN0jTxf1uVj2TeQYGhqp+C3EdRc3
 LNSWOAuAqxzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2020 02:03:22 -0700
IronPort-SDR: 1oMEEuMHP+yLtMN5WO+4+ghhYohwfJSfYG74YBnZCuOaV93Z0b7fqAjDZ1n36cnNVGryxb2wTx
 xq5AtLoqdaZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,413,1580803200"; d="scan'208";a="456431687"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga005.fm.intel.com with ESMTP; 22 Apr 2020 02:03:22 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Apr 2020 02:03:03 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 22 Apr 2020 17:03:00 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 22 Apr 2020 17:03:00 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: RE: [PATCH 1/3] net/colo-compare.c: Create event_bh with the right
 AioContext
Thread-Topic: [PATCH 1/3] net/colo-compare.c: Create event_bh with the right
 AioContext
Thread-Index: AQHWDdROWO/1QHY6Ok6COLp0/RhfnqiE5E6A//9+GYCAAIrasA==
Date: Wed, 22 Apr 2020 09:03:00 +0000
Message-ID: <0a075de2dc2f4e8c919478762e9a97da@intel.com>
References: <cover.1586370737.git.lukasstraub2@web.de>
 <b86f80bb47ac66b73b2afe80218c9913722c606a.1586370737.git.lukasstraub2@web.de>
 <5ab3bd6649a44354b087c31bb9fcd5a4@intel.com> <20200422104325.64659930@luklap>
In-Reply-To: <20200422104325.64659930@luklap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.151; envelope-from=chen.zhang@intel.com;
 helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 05:03:22
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.151
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
Cc: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVrYXMgU3RyYXViIDxs
dWthc3N0cmF1YjJAd2ViLmRlPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDIyLCAyMDIwIDQ6
NDMgUE0NCj4gVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gQ2M6IHFl
bXUtZGV2ZWwgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IExpIFpoaWppYW4NCj4gPGxpemhpamlh
bkBjbi5mdWppdHN1LmNvbT47IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+OyBNYXJj
LQ0KPiBBbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+OyBQYW9sbyBC
b256aW5pDQo+IDxwYm9uemluaUByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEv
M10gbmV0L2NvbG8tY29tcGFyZS5jOiBDcmVhdGUgZXZlbnRfYmggd2l0aCB0aGUgcmlnaHQNCj4g
QWlvQ29udGV4dA0KPiANCj4gT24gV2VkLCAyMiBBcHIgMjAyMCAwODoyOTozOSArMDAwMA0KPiAi
WmhhbmcsIENoZW4iIDxjaGVuLnpoYW5nQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEx1a2FzIFN0cmF1YiA8bHVrYXNz
dHJhdWIyQHdlYi5kZT4NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCA5LCAyMDIwIDI6MzQg
QU0NCj4gPiA+IFRvOiBxZW11LWRldmVsIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+ID4gPiBD
YzogWmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPjsgTGkgWmhpamlhbg0KPiA+ID4g
PGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT47IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+OyBNYXJjLQ0KPiA+ID4gQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQu
Y29tPjsgUGFvbG8gQm9uemluaQ0KPiA+ID4gPHBib256aW5pQHJlZGhhdC5jb20+DQo+ID4gPiBT
dWJqZWN0OiBbUEFUQ0ggMS8zXSBuZXQvY29sby1jb21wYXJlLmM6IENyZWF0ZSBldmVudF9iaCB3
aXRoIHRoZQ0KPiA+ID4gcmlnaHQgQWlvQ29udGV4dA0KPiA+ID4NCj4gPiA+IHFlbXVfYmhfbmV3
IHdpbGwgc2V0IHRoZSBiaCB0byBiZSBleGVjdXRlZCBpbiB0aGUgbWFpbiBsb29wLiBUaGlzDQo+
ID4gPiBjYXVzZXMgcHJvYmxlbXMgYXMgY29sb19jb21wYXJlX2hhbmRsZV9ldmVudCBhc3N1bWVz
IHRoYXQgaXQgaGFzDQo+ID4gPiBleGNsdXNpdmUgYWNjZXNzIHRoZSBxdWV1ZXMsIHdoaWNoIGFy
ZSBhbHNvIGFjY2Vzc2VkIGluIHRoZQ0KPiA+ID4gaW90aHJlYWQuIEl0IGFsc28gYXNzdW1lcyB0
aGF0IGl0IHJ1bnMgaW4gYSBkaWZmZXJlbnQgdGhyZWFkIHRoYW4NCj4gPiA+IHRoZSBjYWxsZXIg
YW5kIHRha2VzIHRoZSBhcHByb3ByaWF0ZSBsb2Nrcy4NCj4gPiA+DQo+ID4gPiBDcmVhdGUgdGhl
IGJoIHdpdGggdGhlIEFpb0NvbnRleHQgb2YgdGhlIGlvdGhyZWFkIHRvIGZ1bGZpbGwgdGhlc2UN
Cj4gPiA+IGFzc3VtcHRpb25zLg0KPiA+ID4NCj4gPg0KPiA+IExvb2tzIGdvb2QgZm9yIG1lLCBJ
IGFzc3VtZSBpdCB3aWxsIGluY3JlYXNlIHBlcmZvcm1hbmNlLiBEbyB5b3UgaGF2ZQ0KPiByZWxh
dGVkIGRhdGE/DQo+IA0KPiBObywgdGhpcyBmaXhlcyBzZXZlcmFsIGNyYXNoZXMgYmVjYXVzZSB0
aGUgcXVldWVzIHdoZXJlIGFjY2Vzc2VkDQo+IGNvbmN1cnJlbnRseSBmcm9tIG11bHRpcGxlIHRo
cmVhZHMuIFNvcnJ5IGZvciBteSBiYWQgd29yZGluZy4NCg0KQ2FuIHlvdSBkZXNjcmliZSBzb21l
IGRldGFpbHMgYWJvdXQgdGhlIGNyYXNoPyBTdGVwIGJ5IHN0ZXA/DQpNYXliZSBJIGNhbiByZS1w
cm9kdWNlIGFuZCB0ZXN0IGl0IGZvciB0aGlzIHBhdGNoLg0KDQpUaGFua3MNClpoYW5nIENoZW4N
Cg0KPiANCj4gUmVnYXJkcywNCj4gTHVrYXMgU3RyYXViDQo+IA0KPiA+IFRoYW5rcw0KPiA+IFpo
YW5nIENoZW4NCj4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTHVrYXMgU3RyYXViIDxsdWthc3N0
cmF1YjJAd2ViLmRlPg0KPiA+ID4gLS0tDQo+ID4gPiAgbmV0L2NvbG8tY29tcGFyZS5jIHwgMyAr
Ky0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9jb2xvLWNvbXBhcmUuYyBiL25ldC9jb2xv
LWNvbXBhcmUuYyBpbmRleA0KPiA+ID4gMTBjMDIzOWY5ZC4uMWRlNDIyMGZlMiAxMDA2NDQNCj4g
PiA+IC0tLSBhL25ldC9jb2xvLWNvbXBhcmUuYw0KPiA+ID4gKysrIGIvbmV0L2NvbG8tY29tcGFy
ZS5jDQo+ID4gPiBAQCAtODkwLDYgKzg5MCw3IEBAIHN0YXRpYyB2b2lkIGNvbG9fY29tcGFyZV9o
YW5kbGVfZXZlbnQodm9pZA0KPiA+ID4gKm9wYXF1ZSkNCj4gPiA+DQo+ID4gPiAgc3RhdGljIHZv
aWQgY29sb19jb21wYXJlX2lvdGhyZWFkKENvbXBhcmVTdGF0ZSAqcykgIHsNCj4gPiA+ICsgICAg
QWlvQ29udGV4dCAqY3R4ID0gaW90aHJlYWRfZ2V0X2Fpb19jb250ZXh0KHMtPmlvdGhyZWFkKTsN
Cj4gPiA+ICAgICAgb2JqZWN0X3JlZihPQkpFQ1Qocy0+aW90aHJlYWQpKTsNCj4gPiA+ICAgICAg
cy0+d29ya2VyX2NvbnRleHQgPSBpb3RocmVhZF9nZXRfZ19tYWluX2NvbnRleHQocy0+aW90aHJl
YWQpOw0KPiA+ID4NCj4gPiA+IEBAIC05MDYsNyArOTA3LDcgQEAgc3RhdGljIHZvaWQgY29sb19j
b21wYXJlX2lvdGhyZWFkKENvbXBhcmVTdGF0ZQ0KPiAqcykNCj4gPiA+ICAgICAgfQ0KPiA+ID4N
Cj4gPiA+ICAgICAgY29sb19jb21wYXJlX3RpbWVyX2luaXQocyk7DQo+ID4gPiAtICAgIHMtPmV2
ZW50X2JoID0gcWVtdV9iaF9uZXcoY29sb19jb21wYXJlX2hhbmRsZV9ldmVudCwgcyk7DQo+ID4g
PiArICAgIHMtPmV2ZW50X2JoID0gYWlvX2JoX25ldyhjdHgsIGNvbG9fY29tcGFyZV9oYW5kbGVf
ZXZlbnQsIHMpOw0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiAgc3RhdGljIGNoYXIgKmNvbXBhcmVf
Z2V0X3ByaV9pbmRldihPYmplY3QgKm9iaiwgRXJyb3IgKiplcnJwKQ0KPiA+ID4gLS0NCj4gPiA+
IDIuMjAuMQ0KPiA+DQoNCg==

