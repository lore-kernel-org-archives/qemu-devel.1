Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D030CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 01:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F15D20679
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 01:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F15D20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOtcr-0005gl-KH
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 21:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tu.guoyi@h3c.com>) id 1iOtc5-0004gl-Lj
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 21:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tu.guoyi@h3c.com>) id 1iOtc3-0003Mf-Uc
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 21:14:29 -0400
Received: from smtp.h3c.com ([60.191.123.50]:23898 helo=h3cspam02-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tu.guoyi@h3c.com>)
 id 1iOtc3-0003JD-DD; Sun, 27 Oct 2019 21:14:27 -0400
Received: from DAG2EX02-BASE.srv.huawei-3com.com ([10.8.0.65])
 by h3cspam02-ex.h3c.com with ESMTPS id x9S1E0IP037438
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Oct 2019 09:14:00 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX02-BASE.srv.huawei-3com.com (10.8.0.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Oct 2019 09:14:01 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%6])
 with mapi id 15.01.1713.004; Mon, 28 Oct 2019 09:14:00 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHFjb3cyLWJpdG1hcDogRml4IHVpbnQ2NF90IGxl?=
 =?utf-8?Q?ft-shift_overflow?=
Thread-Topic: [PATCH] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Index: AdWL3hfRDHnwa5Z/SpmfNSa9xKBzHAAP1oSAAENkeQA=
Date: Mon, 28 Oct 2019 01:14:00 +0000
Message-ID: <012a03e69c3b42d59b8f2982d4b59a9b@h3c.com>
References: <9845459389d245fcaca2c017c27be8bc@h3c.com>
 <a4897ac0-3caf-2a8e-e55e-5866cadf9d24@virtuozzo.com>
In-Reply-To: <a4897ac0-3caf-2a8e-e55e-5866cadf9d24@virtuozzo.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.108.112]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com x9S1E0IP037438
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 60.191.123.50
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
Cc: Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Wangyongqing <w_yongqing@h3c.com>, Changlimin <changlimin@h3c.com>,
 Gaoliang <liang_gao@h3c.com>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSBbbWFpbHRvOnZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbV0NCj4g5Y+R6YCB5pe2
6Ze0OiAyMDE55bm0MTDmnIgyN+aXpSAwOjUwDQo+IOaUtuS7tuS6ujogdHVndW95aSAoQ2xvdWQp
IDx0dS5ndW95aUBoM2MuY29tPjsga3dvbGZAcmVkaGF0LmNvbTsNCj4gbXJlaXR6QHJlZGhhdC5j
b207IHFlbXUtYmxvY2tAbm9uZ251Lm9yZw0KPiDmioTpgIE6IGNoZW5nY2hpd2VuIChDbG91ZCkg
PGNoZW5nY2hpd2VuQGgzYy5jb20+Ow0KPiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHdhbmd5b25n
cWluZyAoQ2xvdWQpIDx3X3lvbmdxaW5nQGgzYy5jb20+Ow0KPiBjaGFuZ2xpbWluIChDbG91ZCkg
PGNoYW5nbGltaW5AaDNjLmNvbT47IGdhb2xpYW5nIChDbG91ZCkNCj4gPGxpYW5nX2dhb0BoM2Mu
Y29tPjsgd2FuZ3lvbmcgKENsb3VkKSA8d2FuZy55b25nREBoM2MuY29tPg0KPiDkuLvpopg6IFJl
OiBbUEFUQ0hdIHFjb3cyLWJpdG1hcDogRml4IHVpbnQ2NF90IGxlZnQtc2hpZnQgb3ZlcmZsb3cN
Cj4gDQo+IDI2LjEwLjIwMTkgMTI6MTksIFR1Z3VveWkgd3JvdGU6DQo+ID4gSW4gY2hlY2tfY29u
c3RyYWludHNfb25fYml0bWFwKCksIHRoZSBzYW5pdHkgY2hlY2sgb24gdGhlIGdyYW51bGFyaXR5
DQo+ID4gd2lsbCBjYXVzZSB1aW50NjRfdCBpbnRlZ2VyIGxlZnQtc2hpZnQgb3ZlcmZsb3cgd2hl
biBjbHVzdGVyX3NpemUgaXMNCj4gPiAyTSBhbmQgdGhlIGdyYW51bGFyaXR5IGlzIGJpZ2dlciB0
aGFuIDMySyB3aGljaCBpcyBldmVuIHNtYWxsZXIgdGhhbg0KPiA+IHRoZSBkZWZhdWx0IHZhbHVl
IGZvciBhIHFjb3cyIGRpc2sgd2l0aCBjbHVzdGVyX3NpemUgc2V0IHRvIDY0ayBvcg0KPiA+IGJp
Z2dlci4gVGhpcyBwYXRjaCBmaXggdGhlIGlzc3VlIGJ5IHJpZ2h0LXNoaWZ0IEBsZW4gaW5zdGVh
ZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEd1b3lpIFR1IDx0dS5ndW95aUBoM2MuY29tPg0K
PiA+IC0tLQ0KPiA+ICAgYmxvY2svcWNvdzItYml0bWFwLmMgfCA0ICsrLS0NCj4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvYmxvY2svcWNvdzItYml0bWFwLmMgYi9ibG9jay9xY293Mi1iaXRtYXAuYyBpbmRl
eA0KPiA+IDk4Mjk0YTcuLjJhMWQ3ODkgMTAwNjQ0DQo+ID4gLS0tIGEvYmxvY2svcWNvdzItYml0
bWFwLmMNCj4gPiArKysgYi9ibG9jay9xY293Mi1iaXRtYXAuYw0KPiA+IEBAIC0xNzIsOCArMTcy
LDggQEAgc3RhdGljIGludA0KPiBjaGVja19jb25zdHJhaW50c19vbl9iaXRtYXAoQmxvY2tEcml2
ZXJTdGF0ZSAqYnMsDQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gICAgICAgaWYgKChsZW4gPiAodWlu
dDY0X3QpQk1FX01BWF9QSFlTX1NJWkUgPDwgZ3JhbnVsYXJpdHlfYml0cykgfHwNCj4gPiAtICAg
ICAgICAobGVuID4gKHVpbnQ2NF90KUJNRV9NQVhfVEFCTEVfU0laRSAqIHMtPmNsdXN0ZXJfc2l6
ZSA8PA0KPiA+IC0gICAgICAgICAgICAgICBncmFudWxhcml0eV9iaXRzKSkNCj4gDQo+IEhtbS4N
Cj4gQk1FX01BWF9UQUJMRV9TSVpFID0gMHg4MDAwMDAwDQo+IA0KPiAweDgwMDAwMDAgKiAxMDI0
ICogMTAyNCAqIDIgPDwgMTYgPSAyICoqIDY0LCBzbyBmb3IgNjRrIGdyYW51bGFyaXR5IGl0DQo+
IG93ZXJmbG93cy4uDQo+IEJ1dCBmb3IgMzJrIGRvZXNuJ3QuIE9yIGFtIEkgd3Jvbmc/DQoNCllv
dSBhcmUgcmlnaHQsIGl0IGRvZXNuJ3Qgb3ZlcmZsb3cgZm9yIDMySy4NCg0KPiANCj4gQW55d2F5
LCB0aGFua3MgZm9yIGZpeGluZyENCj4gDQo+ID4gKyAgICAgICAgKChsZW4gPj4gZ3JhbnVsYXJp
dHlfYml0cykgPiAodWludDY0X3QpQk1FX01BWF9UQUJMRV9TSVpFICoNCj4gPiArICAgICAgICAg
ICAgICAgIHMtPmNsdXN0ZXJfc2l6ZSkpDQo+IA0KPiBJdCdzIGEgYml0IGluY29ycmVjdCwgYXMg
bGVuIG1heSBiZSB1bmFsaWduZWQsIHdlIG5lZWQgKChsZW4gKyBncmFudWxhcml0eSAtIDEpID4+
DQo+IGdyYW51bGFyaXR5X2JpdHMpIG9uIHRoZSBsZWZ0LCBvciBiZXR0ZXIgRElWX1JPVU5URF9V
UChsZW4sIGdyYW51bGFyaXR5KS4NCg0KWWVzLCBAbGVuIHNob3VsZCBiZSBST1VORC1VUCwgdGhh
bmtzIGZvciBwb2ludGluZyBpdCBvdXQsIGFuZCBJJ2xsIGZpeCBpdCBhbmQgc2VuZCBhbm90aGVy
IHBhdGNoDQoNCj4gDQo+ID4gICAgICAgew0KPiA+ICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAs
ICJUb28gbXVjaCBzcGFjZSB3aWxsIGJlIG9jY3VwaWVkIGJ5IHRoZQ0KPiBiaXRtYXAuICINCj4g
PiAgICAgICAgICAgICAgICAgICAgICAiVXNlIGxhcmdlciBncmFudWxhcml0eSIpOw0KPiA+IC0t
DQo+ID4gMi43LjQNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4g5pys6YKu5Lu2
5Y+K5YW26ZmE5Lu25ZCr5pyJ5paw5Y2O5LiJ6ZuG5Zui55qE5L+d5a+G5L+h5oGv77yM5LuF6ZmQ
5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5LitDQo+IOWIl+WHug0KPiA+IOeahOS4quS6uuaIlue+
pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6uuS7peS7u+S9leW9ouW8j+S9v+eUqO+8iOWMheaL
rOS9huS4jemZkOS6juWFqOmDqOaIlg0KPiDpg6jliIblnLDms4TpnLLjgIHlpI3liLbjgIENCj4g
PiDmiJbmlaPlj5HvvInmnKzpgq7ku7bkuK3nmoTkv6Hmga/jgILlpoLmnpzmgqjplJnmlLbkuobm
nKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJbpgq7ku7YNCj4g6YCa55+l5Y+R5Lu25Lq6
5bm25Yig6Zmk5pysDQo+ID4g6YKu5Lu277yBDQo+ID4gVGhpcyBlLW1haWwgYW5kIGl0cyBhdHRh
Y2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tDQo+ID4gTmV3IEgz
Qywgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2Ug
YWRkcmVzcw0KPiA+IGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24g
Y29udGFpbmVkIGhlcmVpbiBpbiBhbnkNCj4gPiB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBsaW1p
dGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsDQo+ID4gcmVwcm9kdWN0aW9uLCBv
ciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkDQo+ID4g
cmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1tYWlsIGlu
IGVycm9yLA0KPiA+IHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBp
bW1lZGlhdGVseSBhbmQgZGVsZXRlIGl0IQ0KPiA+DQo+IA0KPiBOb3Qgc3VyZSB0aGF0IHRoaXMg
aXMgcG9zc2libGUsIGFzIGl0J3MgYXV0b21hdGljYWxseSBhdmFpbGFibGUgaGVyZToNCj4gaHR0
cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMTAvbXNnMDcz
MzYuaHRtbA0KPiANCj4gDQo+IC0tDQo+IEJlc3QgcmVnYXJkcywNCj4gVmxhZGltaXINCg0KVGhh
bmtzIGEgbG90IGZvciByZXZpZXdpbmcgaXQNCg==

