Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473E3C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 07:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204212083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 07:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204212083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55344 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heEA1-0001BT-9r
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 03:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41372)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1heE7O-0007Hq-OK
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 03:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1heE7K-0005C7-AV
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 03:37:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:26572)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1heE7I-0004hh-Rx
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 03:37:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Jun 2019 00:37:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,399,1557212400"; d="scan'208";a="154377626"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga008.jf.intel.com with ESMTP; 21 Jun 2019 00:37:44 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 21 Jun 2019 00:37:44 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 21 Jun 2019 00:37:43 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.33]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.72]) with mapi id 14.03.0439.000;
 Fri, 21 Jun 2019 15:37:42 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela
 <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>,
 qemu-dev <qemu-devel@nongnu.org>, Stefano Stabellini
 <sstabellini@kernel.org>, Paul Durrant <paul.durrant@citrix.com>
Thread-Topic: [PATCH V2 0/5] Add Xen COLO support
Thread-Index: AQHVHuNRBWevQzBoQk2i1pAZg06es6aTwJgAgACjccCAEVckwP//hdeAgACJfjA=
Date: Fri, 21 Jun 2019 07:37:41 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780618AE3E@shsmsx102.ccr.corp.intel.com>
References: <20190609164433.5866-1-chen.zhang@intel.com>
 <e02f265c-a0f4-0b34-e3e9-48f0d9eefaf8@redhat.com>
 <9CFF81C0F6B98A43A459C9EDAD400D780615AACB@shsmsx102.ccr.corp.intel.com>
 <9CFF81C0F6B98A43A459C9EDAD400D780618AD39@shsmsx102.ccr.corp.intel.com>
 <8e9f8d98-6122-ebd8-7be9-1bdd177ab2c5@redhat.com>
In-Reply-To: <8e9f8d98-6122-ebd8-7be9-1bdd177ab2c5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzAzY2VlMGUtMjllMy00NDkxLWE3NDYtOWQ3MmY3OWJmZWEwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoib0JEYkc1WlZrRWdESytmNjBWRm9hYnA1ZFRRMjhyMEpaRVNSVHlWTlwvbUhSS2NXVzJYNVlyOXpZK2I1VGx3d2YifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [PATCH V2 0/5] Add Xen COLO support
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyBbbWFp
bHRvOmphc293YW5nQHJlZGhhdC5jb21dDQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyMSwgMjAxOSAz
OjI1IFBNDQo+IFRvOiBaaGFuZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+OyBMaSBaaGlq
aWFuIDxsaXpoaWppYW5AY24uZnVqaXRzdS5jb20+Ow0KPiBEci4gRGF2aWQgQWxhbiBHaWxiZXJ0
IDxkZ2lsYmVydEByZWRoYXQuY29tPjsgSnVhbiBRdWludGVsYQ0KPiA8cXVpbnRlbGFAcmVkaGF0
LmNvbT47IHpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47DQo+
IHFlbXUtZGV2IDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBTdGVmYW5vIFN0YWJlbGxpbmkNCj4g
PHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+OyBQYXVsIER1cnJhbnQgPHBhdWwuZHVycmFudEBjaXRy
aXguY29tPg0KPiBDYzogWmhhbmcgQ2hlbiA8emhhbmdja2lkQGdtYWlsLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCBWMiAwLzVdIEFkZCBYZW4gQ09MTyBzdXBwb3J0DQo+IA0KPiANCj4gT24g
MjAxOS82LzIxIOS4i+WNiDI6NDMsIFpoYW5nLCBDaGVuIHdyb3RlOg0KPiA+IEFueW9uZSBoYXZl
IGFueSBjb21tZW50cyBhYm91dCB0aGlzIHNlcmllcz8NCj4gPg0KPiA+IFRoYW5rcw0KPiA+IFpo
YW5nIENoZW4NCj4gDQo+IA0KPiBJIHdpbGwgcHJvYmFibHkgcmV2aWV3IGFuZCBnaXZlIGZlZWRi
YWNrIHNvbWV0aW1lIG5leHQgd2Vlay4NCj4gDQoNClRoYW5rIHlvdSBKYXNvbn4gDQoNClRoYW5r
cw0KWmhhbmcgQ2hlbg0KDQo+IFRoYW5rcw0KPiANCj4gDQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBRZW11LWRldmVsIFttYWlsdG86cWVtdS1k
ZXZlbC0NCj4gPj4gYm91bmNlcytjaGVuLnpoYW5nPWludGVsLmNvbUBub25nbnUub3JnXSBPbiBC
ZWhhbGYgT2YgWmhhbmcsIENoZW4NCj4gPj4gU2VudDogTW9uZGF5LCBKdW5lIDEwLCAyMDE5IDE6
NTYgUE0NCj4gPj4gVG86IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+OyBMaSBaaGlq
aWFuDQo+ID4+IDxsaXpoaWppYW5AY24uZnVqaXRzdS5jb20+OyBEci4gRGF2aWQgQWxhbiBHaWxi
ZXJ0DQo+ID4+IDxkZ2lsYmVydEByZWRoYXQuY29tPjsgSnVhbiBRdWludGVsYSA8cXVpbnRlbGFA
cmVkaGF0LmNvbT47DQo+ID4+IHpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVh
d2VpLmNvbT47IHFlbXUtZGV2DQo+ID4+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBTdGVmYW5v
IFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+Ow0KPiA+PiBQYXVsIER1cnJhbnQg
PHBhdWwuZHVycmFudEBjaXRyaXguY29tPg0KPiA+PiBDYzogWmhhbmcgQ2hlbiA8emhhbmdja2lk
QGdtYWlsLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtRZW11LWRldmVsXSBbUEFUQ0ggVjIgMC81
XSBBZGQgWGVuIENPTE8gc3VwcG9ydA0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+IEZyb206IEphc29uIFdhbmcgW21haWx0bzpqYXNvd2Fu
Z0ByZWRoYXQuY29tXQ0KPiA+Pj4gU2VudDogTW9uZGF5LCBKdW5lIDEwLCAyMDE5IDEyOjA5IFBN
DQo+ID4+PiBUbzogWmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPjsgTGkgWmhpamlh
bg0KPiA+Pj4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT47IERyLiBEYXZpZCBBbGFuIEdpbGJl
cnQNCj4gPj4+IDxkZ2lsYmVydEByZWRoYXQuY29tPjsgSnVhbiBRdWludGVsYSA8cXVpbnRlbGFA
cmVkaGF0LmNvbT47DQo+ID4+PiB6aGFuZ2hhaWxpYW5nIDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1
YXdlaS5jb20+OyBxZW11LWRldg0KPiA+Pj4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IFN0ZWZh
bm8gU3RhYmVsbGluaQ0KPiA+Pj4gPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+OyBQYXVsIER1cnJh
bnQgPHBhdWwuZHVycmFudEBjaXRyaXguY29tPg0KPiA+Pj4gQ2M6IFpoYW5nIENoZW4gPHpoYW5n
Y2tpZEBnbWFpbC5jb20+DQo+ID4+PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDAvNV0gQWRkIFhl
biBDT0xPIHN1cHBvcnQNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gT24gMjAxOS82LzEwIOS4iuWNiDEy
OjQ0LCBaaGFuZyBDaGVuIHdyb3RlOg0KPiA+Pj4+IEZyb206IFpoYW5nIENoZW4gPGNoZW4uemhh
bmdAaW50ZWwuY29tPg0KPiA+Pj4+DQo+ID4+Pj4gWGVuIENPTE8gYmFzZWQgb24gS1ZNIENPTE8g
YXJjaGl0ZWN0dXJlLCBpdCBzaGFyZWQgQ09MTyBwcm94eSBhbmQNCj4gPj4+PiBibG9jayByZXBs
aWNhdGlvbiB3aXRoIEtWTSBDT0xPLiBUaGUgb25seSBkaWZmZXJlY2UgaXMgWGVuIENPTE8NCj4g
Pj4+PiBoYXZlIG93biBDT0xPLWZyYW1lIHRvIGhhbmRsZSBsaXZlIG1pZ3JhdGlvbiByZWxhdGVk
IGZ1bmN0aW9uLCBzbw0KPiA+Pj4+IHdlIG5lZWQgdGhpcyBzZXJpZXMgbWFrZSBYZW4gQ09MTyBm
cmFtZSBjYW4gY29tbXVuaWNhdGUgd2l0aCBvdGhlcg0KPiA+Pj4+IENPTE8gbW9kdWxlcyBpbiBx
ZW11LiBYZW4gc2lkZSByZWxhdGVkIHBhdGNoZXMgaGF2ZSBiZWVuIG1lcmdlZC4NCj4gPj4+DQo+
ID4+PiBBbnkgcG9pbnRlciB0byB0aGlzPw0KPiA+Pj4NCj4gPj4gWWVzLCBwbGVhc2Ugc2VlIHRo
aXMgdGhyZWFkOg0KPiA+Pg0KPiA+PiBodHRwczovL2xpc3RzLnhlbi5vcmcvYXJjaGl2ZXMvaHRt
bC94ZW4tZGV2ZWwvMjAxNy0wMy9tc2cwMDcxOC5odG1sDQo+ID4+DQo+ID4+IFRoYW5rcw0KPiA+
PiBaaGFuZyBDaGVuDQo+ID4+DQo+ID4+PiBUaGFua3MNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4+IFYy
Og0KPiA+Pj4+ICAgIC0gUmViYXNlIG9uIHVwc3RyZWFtIGNvZGUuDQo+ID4+Pj4gICAgLSBPcHRp
bWl6ZSBjb2RlIGJ5IFpoaWppYW4ncyBjb21tZW50cyBpbiBwYXRjaCA0LzUuDQo+ID4+Pj4gICAg
LSBSZW1vdmUgb3JpZ2luIDUvNiBwYXRjaC4NCj4gPj4+Pg0KPiA+Pj4+IFYxOg0KPiA+Pj4+ICAg
IC0gSW5pdGlhbCBwYXRjaC4NCj4gPj4+Pg0KPiA+Pj4+IFpoYW5nIENoZW4gKDUpOg0KPiA+Pj4+
ICAgICBDT0xPLWNvbXBhcmU6IEFkZCBuZXcgcGFyYW1ldGVyIHRvIGNvbW11bmljYXRlIHdpdGgg
cmVtb3RlDQo+ID4+Pj4gY29sby0NCj4gPj4+IGZyYW1lDQo+ID4+Pj4gICAgIENPTE8tY29tcGFy
ZTogQWRkIHJlbW90ZSBub3RpZmljYXRpb24gY2hhcmRldiBoYW5kbGVyIGZyYW1lDQo+ID4+Pj4g
ICAgIENPTE8tY29tcGFyZTogTWFrZSB0aGUgY29tcGFyZV9jaHJfc2VuZCgpIGNhbiBzZW5kIG5v
dGlmaWNhdGlvbg0KPiA+Pj4+ICAgICAgIG1lc3NhZ2UuDQo+ID4+Pj4gICAgIENPTE8tY29tcGFy
ZTogQWRkIGNvbG8tY29tcGFyZSByZW1vdGUgbm90aWZ5IHN1cHBvcnQNCj4gPj4+PiAgICAgbWln
cmF0aW9uL2NvbG8uYzogQWRkIG1pc3NlZCBmaWx0ZXIgbm90aWZ5IGZvciBYZW4gQ09MTy4NCj4g
Pj4+Pg0KPiA+Pj4+ICAgIG1pZ3JhdGlvbi9jb2xvLmMgICB8ICAgMiArDQo+ID4+Pj4gICAgbmV0
L2NvbG8tY29tcGFyZS5jIHwgMTU1DQo+ID4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tDQo+ID4+PiAtLS0NCj4gPj4+PiAgICBxZW11LW9wdGlvbnMuaHggICAg
fCAgMzMgKysrKysrKysrLQ0KPiA+Pj4+ICAgIDMgZmlsZXMgY2hhbmdlZCwgMTcxIGluc2VydGlv
bnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiA+Pj4+DQo=

