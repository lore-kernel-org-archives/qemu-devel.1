Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C9FC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 03:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BD021973
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 03:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BD021973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSuAB-0007VW-1q
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 23:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jSu9E-0006MB-5W
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 23:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jSu9C-0006zy-G4
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 23:09:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:33159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jSu9C-0006yE-04
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 23:09:30 -0400
IronPort-SDR: qj6BVaQLBJQLXG/MoI4vrNrEJSK+xf+ARJy7OF2AW4Ds2b7lrH8q8Nz1GkYaG4PQQYHmZXuh6X
 jaSADBPZWwbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 20:09:19 -0700
IronPort-SDR: ZHy/YHlvDzaZIY5AiXRGyyNYAn7EGkcbtAFi6Q3PjVTYDRFC1SCp3wOhO82RnFHS4RQqv5MYOQ
 5UwESnlNyzHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,321,1583222400"; d="scan'208";a="247233661"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga007.fm.intel.com with ESMTP; 26 Apr 2020 20:09:18 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 26 Apr 2020 20:09:17 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 27 Apr 2020 11:09:14 +0800
Received: from shsmsx604.ccr.corp.intel.com ([10.109.6.214]) by
 SHSMSX604.ccr.corp.intel.com ([10.109.6.214]) with mapi id 15.01.1713.004;
 Mon, 27 Apr 2020 11:09:14 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Derek Su <dereksu@qnap.com>, Lukas Straub <lukasstraub2@web.de>
Subject: RE: [PATCH 1/3] net/colo-compare.c: Create event_bh with the right
 AioContext
Thread-Topic: [PATCH 1/3] net/colo-compare.c: Create event_bh with the right
 AioContext
Thread-Index: AQHWDdROWO/1QHY6Ok6COLp0/RhfnqiE5E6A//9+GYCAAIrasP//hQ0AgAHzMCCAANysgIAFJG+w
Date: Mon, 27 Apr 2020 03:09:14 +0000
Message-ID: <36fa3066c75e43de806d6a6dabf598d2@intel.com>
References: <cover.1586370737.git.lukasstraub2@web.de>
 <b86f80bb47ac66b73b2afe80218c9913722c606a.1586370737.git.lukasstraub2@web.de>
 <5ab3bd6649a44354b087c31bb9fcd5a4@intel.com> <20200422104325.64659930@luklap>
 <0a075de2dc2f4e8c919478762e9a97da@intel.com> <20200422114020.3d479899@luklap>
 <8d0e2a591f1d48baa84d79e7a0f1cbb6@intel.com>
 <b1c85547-1a7b-b5a8-739b-e19eceffce45@qnap.com>
In-Reply-To: <b1c85547-1a7b-b5a8-739b-e19eceffce45@qnap.com>
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
Received-SPF: pass client-ip=134.134.136.24; envelope-from=chen.zhang@intel.com;
 helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:09:19
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.24
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGVyZWsgU3UgPGRlcmVr
c3VAcW5hcC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMjQsIDIwMjAgMTI6MzcgUE0NCj4g
VG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT47IEx1a2FzIFN0cmF1Yg0KPiA8
bHVrYXNzdHJhdWIyQHdlYi5kZT4NCj4gQ2M6IHFlbXUtZGV2ZWwgPHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZz47IExpIFpoaWppYW4NCj4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT47IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+OyBNYXJjLQ0KPiBBbmRyw6kgTHVyZWF1IDxtYXJjYW5k
cmUubHVyZWF1QHJlZGhhdC5jb20+OyBQYW9sbyBCb256aW5pDQo+IDxwYm9uemluaUByZWRoYXQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gbmV0L2NvbG8tY29tcGFyZS5jOiBDcmVh
dGUgZXZlbnRfYmggd2l0aCB0aGUgcmlnaHQNCj4gQWlvQ29udGV4dA0KPiANCj4gT24gMjAyMC80
LzIzIOS4i+WNiDM6MjksIFpoYW5nLCBDaGVuIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTHVrYXMgU3RyYXViIDxsdWthc3N0cmF1
YjJAd2ViLmRlPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDIyLCAyMDIwIDU6NDAgUE0N
Cj4gPj4gVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gPj4gQ2M6IHFl
bXUtZGV2ZWwgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IExpIFpoaWppYW4NCj4gPj4gPGxpemhp
amlhbkBjbi5mdWppdHN1LmNvbT47IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+OyBN
YXJjLQ0KPiA+PiBBbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+OyBQ
YW9sbyBCb256aW5pDQo+ID4+IDxwYm9uemluaUByZWRoYXQuY29tPg0KPiA+PiBTdWJqZWN0OiBS
ZTogW1BBVENIIDEvM10gbmV0L2NvbG8tY29tcGFyZS5jOiBDcmVhdGUgZXZlbnRfYmggd2l0aCB0
aGUNCj4gPj4gcmlnaHQgQWlvQ29udGV4dA0KPiA+Pg0KPiA+PiBPbiBXZWQsIDIyIEFwciAyMDIw
IDA5OjAzOjAwICswMDAwDQo+ID4+ICJaaGFuZywgQ2hlbiIgPGNoZW4uemhhbmdAaW50ZWwuY29t
PiB3cm90ZToNCj4gPj4NCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+
IEZyb206IEx1a2FzIFN0cmF1YiA8bHVrYXNzdHJhdWIyQHdlYi5kZT4NCj4gPj4+PiBTZW50OiBX
ZWRuZXNkYXksIEFwcmlsIDIyLCAyMDIwIDQ6NDMgUE0NCj4gPj4+PiBUbzogWmhhbmcsIENoZW4g
PGNoZW4uemhhbmdAaW50ZWwuY29tPg0KPiA+Pj4+IENjOiBxZW11LWRldmVsIDxxZW11LWRldmVs
QG5vbmdudS5vcmc+OyBMaSBaaGlqaWFuDQo+ID4+Pj4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNv
bT47IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Ow0KPiBNYXJjLQ0KPiA+Pj4+IEFu
ZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT47IFBhb2xvIEJvbnppbmkN
Cj4gPj4+PiA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gPj4+PiBTdWJqZWN0OiBSZTogW1BBVENI
IDEvM10gbmV0L2NvbG8tY29tcGFyZS5jOiBDcmVhdGUgZXZlbnRfYmggd2l0aA0KPiA+Pj4+IHRo
ZSByaWdodCBBaW9Db250ZXh0DQo+ID4+Pj4NCj4gPj4+PiBPbiBXZWQsIDIyIEFwciAyMDIwIDA4
OjI5OjM5ICswMDAwDQo+ID4+Pj4gIlpoYW5nLCBDaGVuIiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+
IHdyb3RlOg0KPiA+Pj4+DQo+ID4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
Pj4+Pj4gRnJvbTogTHVrYXMgU3RyYXViIDxsdWthc3N0cmF1YjJAd2ViLmRlPg0KPiA+Pj4+Pj4g
U2VudDogVGh1cnNkYXksIEFwcmlsIDksIDIwMjAgMjozNCBBTQ0KPiA+Pj4+Pj4gVG86IHFlbXUt
ZGV2ZWwgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gPj4+Pj4+IENjOiBaaGFuZywgQ2hlbiA8
Y2hlbi56aGFuZ0BpbnRlbC5jb20+OyBMaSBaaGlqaWFuDQo+ID4+Pj4+PiA8bGl6aGlqaWFuQGNu
LmZ1aml0c3UuY29tPjsgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT47DQo+ID4+Pj4+
PiBNYXJjLSBBbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+OyBQYW9s
bw0KPiBCb256aW5pDQo+ID4+Pj4+PiA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gPj4+Pj4+IFN1
YmplY3Q6IFtQQVRDSCAxLzNdIG5ldC9jb2xvLWNvbXBhcmUuYzogQ3JlYXRlIGV2ZW50X2JoIHdp
dGggdGhlDQo+ID4+Pj4+PiByaWdodCBBaW9Db250ZXh0DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gcWVt
dV9iaF9uZXcgd2lsbCBzZXQgdGhlIGJoIHRvIGJlIGV4ZWN1dGVkIGluIHRoZSBtYWluIGxvb3Au
DQo+ID4+Pj4+PiBUaGlzIGNhdXNlcyBwcm9ibGVtcyBhcyBjb2xvX2NvbXBhcmVfaGFuZGxlX2V2
ZW50IGFzc3VtZXMgdGhhdA0KPiBpdA0KPiA+Pj4+Pj4gaGFzIGV4Y2x1c2l2ZSBhY2Nlc3MgdGhl
IHF1ZXVlcywgd2hpY2ggYXJlIGFsc28gYWNjZXNzZWQgaW4gdGhlDQo+ID4+Pj4+PiBpb3RocmVh
ZC4gSXQgYWxzbyBhc3N1bWVzIHRoYXQgaXQgcnVucyBpbiBhIGRpZmZlcmVudCB0aHJlYWQgdGhh
bg0KPiA+Pj4+Pj4gdGhlIGNhbGxlciBhbmQgdGFrZXMgdGhlIGFwcHJvcHJpYXRlIGxvY2tzLg0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+IENyZWF0ZSB0aGUgYmggd2l0aCB0aGUgQWlvQ29udGV4dCBvZiB0
aGUgaW90aHJlYWQgdG8gZnVsZmlsbA0KPiA+Pj4+Pj4gdGhlc2UgYXNzdW1wdGlvbnMuDQo+ID4+
Pj4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+PiBMb29rcyBnb29kIGZvciBtZSwgSSBhc3N1bWUgaXQgd2ls
bCBpbmNyZWFzZSBwZXJmb3JtYW5jZS4gRG8geW91DQo+ID4+Pj4+IGhhdmUNCj4gPj4+PiByZWxh
dGVkIGRhdGE/DQo+ID4+Pj4NCj4gPj4+PiBObywgdGhpcyBmaXhlcyBzZXZlcmFsIGNyYXNoZXMg
YmVjYXVzZSB0aGUgcXVldWVzIHdoZXJlIGFjY2Vzc2VkDQo+ID4+Pj4gY29uY3VycmVudGx5IGZy
b20gbXVsdGlwbGUgdGhyZWFkcy4gU29ycnkgZm9yIG15IGJhZCB3b3JkaW5nLg0KPiA+Pj4NCj4g
Pj4+IENhbiB5b3UgZGVzY3JpYmUgc29tZSBkZXRhaWxzIGFib3V0IHRoZSBjcmFzaD8gU3RlcCBi
eSBzdGVwPw0KPiA+Pj4gTWF5YmUgSSBjYW4gcmUtcHJvZHVjZSBhbmQgdGVzdCBpdCBmb3IgdGhp
cyBwYXRjaC4NCj4gPj4NCj4gPj4gVGhlcmUgaXMgbm8gY2xlYXIgdGVzdCBjYXNlLiBGb3IgbWUg
dGhlIGNyYXNoZXMgaGFwcGVuZWQgYWZ0ZXIgMS0yMGgNCj4gPj4gb2YgcnVudGltZSB3aXRoIGxv
dHMgb2YgY2hlY2twb2ludHMgKDgwMG1zKSBhbmQgc29tZSBuZXR3b3JrIHRyYWZmaWMuDQo+ID4+
IFRoZSBjb3JlZHVtcCBhbHdheXMgc2hvd2VkIHRoYXQgdHdvIHRocmVhZHMgd2hlcmUgZG9pbmcg
b3BlcmF0aW9ucw0KPiBvbg0KPiA+PiB0aGUgcXVldWVzIHNpbXVsdGFuZW91c2x5Lg0KPiA+PiBV
bmZvcnR1bmF0ZWx5LCBJIGRvbid0IGhhdmUgdGhlIGNvcmVkdW1wcyBhbnltb3JlLg0KPiA+DQo+
ID4gT0ssIEFsdGhvdWdoIEkgaGF2ZSBub3QgZW5jb3VudGVyZWQgdGhlIHByb2JsZW0geW91IGRl
c2NyaWJlZC4NCj4gPiBJIGhhdmUgdGVzdCB0aGlzIHBhdGNoLCBsb29rcyBydW5uaW5nIGZpbmUu
DQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogWmhhbmcgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+
DQo+ID4NCj4gPiBUaGFua3MNCj4gPiBaaGFuZyBDaGVuDQo+IA0KPiANCj4gSGksDQo+IA0KPiBJ
IGVuY291bnRlcmVkIFBWTSBjcmFzaCBjYXVzZWQgYnkgdGhlIHJhY2UgY29uZGl0aW9uIGlzc3Vl
IGluIHY0LjIuMC4NCj4gSGVyZSBpcyB0aGUgY29yZWR1bXAgZm9yIHJlZmVyZW5jZS4NCj4gDQo+
IGBgYA0KPiB3YXJuaW5nOiBjb3JlIGZpbGUgbWF5IG5vdCBtYXRjaCBzcGVjaWZpZWQgZXhlY3V0
YWJsZSBmaWxlLg0KPiAgIENvcmUgd2FzIGdlbmVyYXRlZCBieSBgcWVtdS1zeXN0ZW0teDg2XzY0
IC1uYW1lIHNvdXJjZSAtZW5hYmxlLWt2bSAtDQo+IGNwdSBjb3JlMmR1byAtbSAxMDI0IC1nbG9i
YWwga3ZtLWEnLg0KPiAgIFByb2dyYW0gdGVybWluYXRlZCB3aXRoIHNpZ25hbCBTSUdTRUdWLCBT
ZWdtZW50YXRpb24gZmF1bHQuDQo+ICAgIzAgMHgwMDAwNTVjYjQ3OGJjZDI1IGluIHFlbXVfaGV4
ZHVtcCAoYnVmPTB4MCwgZnA9MHg3ZjZlOTEyMmI2ODANCj4gPElPXzJfMV9zdGRlcnI+LCBwcmVm
aXg9MHg1NWNiNDdhMzg4ZjUgImNvbG8tY29tcGFyZSBzcGt0Iiwgc2l6ZT0xNTE0KSBhdA0KPiB1
dGlsL2hleGR1bXAuYzozNA0KPiAgIDM0IGZwcmludGYoZnAsICIgJTAyeCIsICh1bnNpZ25lZCBj
aGFyKWJ1ZltiICsgaV0pOw0KPiAgIFtDdXJyZW50IHRocmVhZCBpcyAxIChUaHJlYWQgMHg3ZjZk
YTFhZGU3MDAgKExXUCA2MTE5KSldDQo+ICAgKGdkYikgd2hlcmUNCj4gICAjMCAweDAwMDA1NWNi
NDc4YmNkMjUgaW4gcWVtdV9oZXhkdW1wIChidWY9MHgwLCBmcD0weDdmNmU5MTIyYjY4MA0KPiA8
SU9fMl8xX3N0ZGVycj4sIHByZWZpeD0weDU1Y2I0N2EzODhmNSAiY29sby1jb21wYXJlIHNwa3Qi
LCBzaXplPTE1MTQpIGF0DQo+IHV0aWwvaGV4ZHVtcC5jOjM0DQo+ICAgIzEgMHgwMDAwNTVjYjQ3
NmZhMWI1IGluIGNvbG9fY29tcGFyZV90Y3AgKHM9MHg1NWNiNDk2NDI5ZjAsDQo+IGNvbm49MHg3
ZjZlNzgwMDNlMzApIGF0IG5ldC9jb2xvLWNvbXBhcmUuYzo0NjINCj4gICAjMiAweDAwMDA1NWNi
NDc2ZmE4YzEgaW4gY29sb19jb21wYXJlX2Nvbm5lY3Rpb24NCj4gKG9wYXF1ZT0weDdmNmU3ODAw
M2UzMCwgdXNlcl9kYXRhPTB4NTVjYjQ5NjQyOWYwKSBhdCBuZXQvY29sby0NCj4gY29tcGFyZS5j
OjY4Nw0KPiAgICMzIDB4MDAwMDU1Y2I0NzZmYjRhYiBpbiBjb21wYXJlX3ByaV9yc19maW5hbGl6
ZQ0KPiAocHJpX3JzPTB4NTVjYjQ5NjQyYjE4KSBhdCBuZXQvY29sby1jb21wYXJlLmM6MTAwMQ0K
PiAgICM0IDB4MDAwMDU1Y2I0NzZlYjQ2ZiBpbiBuZXRfZmlsbF9yc3RhdGUgKHJzPTB4NTVjYjQ5
NjQyYjE4LA0KPiBidWY9MHg3ZjZkYTFhZGQyYzggIiIsIHNpemU9MTA2NCkgYXQgbmV0L25ldC5j
OjE3NjQNCj4gICAjNSAweDAwMDA1NWNiNDc2ZmFhZmEgaW4gY29tcGFyZV9wcmlfY2hyX2luIChv
cGFxdWU9MHg1NWNiNDk2NDI5ZjAsDQo+IGJ1Zj0weDdmNmRhMWFkYzZmMCAiYEXLp1ZcMjEwUlQi
LCBzaXplPTQwOTYpIGF0IG5ldC9jb2xvLWNvbXBhcmUuYzo3NzYNCj4gICAjNiAweDAwMDA1NWNi
NDc4MTUzNjMgaW4gcWVtdV9jaHJfYmVfd3JpdGVfaW1wbCAocz0weDU1Y2I0OGM4N2VjMCwNCj4g
YnVmPTB4N2Y2ZGExYWRjNmYwICJgRcunVlwyMTBSVCIsIGxlbj00MDk2KSBhdCBjaGFyZGV2L2No
YXIuYzoxNzcNCj4gICAjNyAweDAwMDA1NWNiNDc4MTUzYzcgaW4gcWVtdV9jaHJfYmVfd3JpdGUg
KHM9MHg1NWNiNDhjODdlYzAsDQo+IGJ1Zj0weDdmNmRhMWFkYzZmMCAiYEXLp1ZcMjEwUlQiLCBs
ZW49NDA5NikgYXQgY2hhcmRldi9jaGFyLmM6MTg5DQo+ICAgIzggMHgwMDAwNTVjYjQ3ODFlMDAy
IGluIHRjcF9jaHJfcmVhZCAoY2hhbj0weDU1Y2I0OGVmNzY5MCwNCj4gY29uZD1HX0lPX0lOLCBv
cGFxdWU9MHg1NWNiNDhjODdlYzApIGF0IGNoYXJkZXYvY2hhci1zb2NrZXQuYzo1MjUNCj4gICAj
OSAweDAwMDA1NWNiNDc4Mzk2NTUgaW4gcWlvX2NoYW5uZWxfZmRfc291cmNlX2Rpc3BhdGNoDQo+
IChzb3VyY2U9MHg3ZjZlNzgwMDIwNTAsIGNhbGxiYWNrPTB4NTVjYjQ3ODFkZTUzIDx0Y3BfY2hy
X3JlYWQ+LA0KPiB1c2VyX2RhdGE9MHg1NWNiNDhjODdlYzApIGF0IGlvL2NoYW5uZWwtd2F0Y2gu
Yzo4NA0KPiAgICMxMCAweDAwMDA3ZjZlOTUwZTEyODUgaW4gZ19tYWluX2NvbnRleHRfZGlzcGF0
Y2ggKCkgYXQNCj4gL3Vzci9saWIveDg2XzY0LWxpbnV4LWdudS9saWJnbGliLTIuMC5zby4wDQo+
ICAgIzExIDB4MDAwMDdmNmU5NTBlMTY1MCBpbiAoKSBhdCAvdXNyL2xpYi94ODZfNjQtbGludXgt
Z251L2xpYmdsaWItMi4wLnNvLjANCj4gICAjMTIgMHgwMDAwN2Y2ZTk1MGUxOTYyIGluIGdfbWFp
bl9sb29wX3J1biAoKSBhdA0KPiAvdXNyL2xpYi94ODZfNjQtbGludXgtZ251L2xpYmdsaWItMi4w
LnNvLjANCj4gICAjMTMgMHgwMDAwNTVjYjQ3NDkyMGFlIGluIGlvdGhyZWFkX3J1biAob3BhcXVl
PTB4NTVjYjQ4YzY3ZjEwKSBhdA0KPiBpb3RocmVhZC5jOjgyDQo+ICAgIzE0IDB4MDAwMDU1Y2I0
NzhhNjk5ZCBpbiBxZW11X3RocmVhZF9zdGFydCAoYXJncz0weDU1Y2I0OTgwMzVkMCkgYXQNCj4g
dXRpbC9xZW11LXRocmVhZC1wb3NpeC5jOjUxOQ0KPiAgICMxNSAweDAwMDA3ZjZlOTEyMzc2ZGIg
aW4gc3RhcnRfdGhyZWFkIChhcmc9MHg3ZjZkYTFhZGU3MDApIGF0DQo+IHB0aHJlYWRfY3JlYXRl
LmM6NDYzDQo+ICAgIzE2IDB4MDAwMDdmNmU5MGY2MDg4ZiBpbiBjbG9uZSAoKSBhdA0KPiAuLi9z
eXNkZXBzL3VuaXgvc3lzdi9saW51eC94ODZfNjQvY2xvbmUuUzo5NQ0KPiAgIChnZGIpDQo+IGBg
YA0KPiANCj4gQ09MTyB3b3JrcyB3ZWxsIGFmdGVyIGFwcGx5aW5nIHRoaXMgcGF0Y2ggaW4gbXkg
dGVzdHMuDQo+IA0KPiBSZXZpZXdlZC1ieTogRGVyZWsgU3UgPGRlcmVrc3VAcW5hcC5jb20+DQo+
IFRlc3RlZC1ieTogRGVyZWsgU3UgPGRlcmVrc3VAcW5hcC5jb20+DQo+IA0KDQpUaGFua3MgRGVy
ZWsuDQoNCj4gUmVnYXJkcywNCj4gRGVyZWsNCj4gDQo+IA0KPiANCj4gDQo+ID4NCj4gPj4NCj4g
Pj4gUmVnYXJkcywNCj4gPj4gTHVrYXMgU3RyYXViDQo+ID4+DQo+ID4+PiBUaGFua3MNCj4gPj4+
IFpoYW5nIENoZW4NCj4gPj4+DQo+ID4+Pj4NCj4gPj4+PiBSZWdhcmRzLA0KPiA+Pj4+IEx1a2Fz
IFN0cmF1Yg0KPiA+Pj4+DQo+ID4+Pj4+IFRoYW5rcw0KPiA+Pj4+PiBaaGFuZyBDaGVuDQo+ID4+
Pj4+DQo+ID4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBMdWthcyBTdHJhdWIgPGx1a2Fzc3RyYXViMkB3
ZWIuZGU+DQo+ID4+Pj4+PiAtLS0NCj4gPj4+Pj4+ICAgbmV0L2NvbG8tY29tcGFyZS5jIHwgMyAr
Ky0NCj4gPj4+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IGRpZmYgLS1naXQgYS9uZXQvY29sby1jb21wYXJlLmMg
Yi9uZXQvY29sby1jb21wYXJlLmMgaW5kZXgNCj4gPj4+Pj4+IDEwYzAyMzlmOWQuLjFkZTQyMjBm
ZTIgMTAwNjQ0DQo+ID4+Pj4+PiAtLS0gYS9uZXQvY29sby1jb21wYXJlLmMNCj4gPj4+Pj4+ICsr
KyBiL25ldC9jb2xvLWNvbXBhcmUuYw0KPiA+Pj4+Pj4gQEAgLTg5MCw2ICs4OTAsNyBAQCBzdGF0
aWMgdm9pZCBjb2xvX2NvbXBhcmVfaGFuZGxlX2V2ZW50KHZvaWQNCj4gPj4+Pj4+ICpvcGFxdWUp
DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gICBzdGF0aWMgdm9pZCBjb2xvX2NvbXBhcmVfaW90aHJlYWQo
Q29tcGFyZVN0YXRlICpzKSAgew0KPiA+Pj4+Pj4gKyAgICBBaW9Db250ZXh0ICpjdHggPSBpb3Ro
cmVhZF9nZXRfYWlvX2NvbnRleHQocy0+aW90aHJlYWQpOw0KPiA+Pj4+Pj4gICAgICAgb2JqZWN0
X3JlZihPQkpFQ1Qocy0+aW90aHJlYWQpKTsNCj4gPj4+Pj4+ICAgICAgIHMtPndvcmtlcl9jb250
ZXh0ID0NCj4gPj4+Pj4+IGlvdGhyZWFkX2dldF9nX21haW5fY29udGV4dChzLT5pb3RocmVhZCk7
DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gQEAgLTkwNiw3ICs5MDcsNyBAQCBzdGF0aWMgdm9pZA0KPiA+
Pj4+Pj4gY29sb19jb21wYXJlX2lvdGhyZWFkKENvbXBhcmVTdGF0ZQ0KPiA+Pj4+ICpzKQ0KPiA+
Pj4+Pj4gICAgICAgfQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICAgICAgIGNvbG9fY29tcGFyZV90aW1l
cl9pbml0KHMpOw0KPiA+Pj4+Pj4gLSAgICBzLT5ldmVudF9iaCA9IHFlbXVfYmhfbmV3KGNvbG9f
Y29tcGFyZV9oYW5kbGVfZXZlbnQsIHMpOw0KPiA+Pj4+Pj4gKyAgICBzLT5ldmVudF9iaCA9IGFp
b19iaF9uZXcoY3R4LCBjb2xvX2NvbXBhcmVfaGFuZGxlX2V2ZW50LCBzKTsNCj4gPj4+Pj4+ICAg
fQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICAgc3RhdGljIGNoYXIgKmNvbXBhcmVfZ2V0X3ByaV9pbmRl
dihPYmplY3QgKm9iaiwgRXJyb3IgKiplcnJwKQ0KPiA+Pj4+Pj4gLS0NCj4gPj4+Pj4+IDIuMjAu
MQ0KPiA+Pj4+Pg0KPiA+Pj4NCj4gPg0KDQo=

