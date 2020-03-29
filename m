Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B2AC43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 11:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44C62076A
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 11:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44C62076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIVx7-0004LF-TB
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 07:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jIVwX-0003uR-Fr
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 07:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jIVwU-00055u-VD
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 07:17:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:19143)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jIVwU-0004ov-Jy
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 07:17:26 -0400
IronPort-SDR: KuNUUDU3bKopjACpNsyWrOFHWWZaxCxigzzTsBbuABmjZAjia3mmoZa2fP3qAVEXq9/gHNuSJ7
 IdfWC3WcauIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2020 04:17:18 -0700
IronPort-SDR: 1br1Y5RvtaSlhdYFonqv1HsmCdLKEIV9UW9CHth/Ldkw1sKFH44OL/RymJQ+jctpdhD8DGIzxJ
 U6wQgxIwwgTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,320,1580803200"; d="scan'208";a="241370455"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga008.fm.intel.com with ESMTP; 29 Mar 2020 04:17:18 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 29 Mar 2020 04:17:17 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 29 Mar 2020 04:17:17 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.209]) with mapi id 14.03.0439.000;
 Sun, 29 Mar 2020 19:17:13 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v1 19/22] intel_iommu: process PASID-based iotlb
 invalidation
Thread-Topic: [PATCH v1 19/22] intel_iommu: process PASID-based iotlb
 invalidation
Thread-Index: AQHWAEW7LEF9U5OYaU6Z5+49z1fjtahXjMmAgAHFm8D//5dxAIAGjJFg
Date: Sun, 29 Mar 2020 11:17:12 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A2117B0@SHSMSX104.ccr.corp.intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-20-git-send-email-yi.l.liu@intel.com>
 <20200324182623.GD127076@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A202340@SHSMSX104.ccr.corp.intel.com>
 <20200325151540.GE354390@xz-x1>
In-Reply-To: <20200325151540.GE354390@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.43
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
TWFyY2ggMjUsIDIwMjAgMTE6MTYgUE0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDE5LzIyXSBpbnRlbF9pb21tdTogcHJvY2Vz
cyBQQVNJRC1iYXNlZCBpb3RsYiBpbnZhbGlkYXRpb24NCj4gDQo+IE9uIFdlZCwgTWFyIDI1LCAy
MDIwIGF0IDAxOjM2OjAzUE0gKzAwMDAsIExpdSwgWWkgTCB3cm90ZToNCj4gPiA+IEZyb206IFBl
dGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2gg
MjUsIDIwMjAgMjoyNiBBTQ0KPiA+ID4gVG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29t
Pg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxOS8yMl0gaW50ZWxfaW9tbXU6IHByb2Nl
c3MgUEFTSUQtYmFzZWQgaW90bGINCj4gPiA+IGludmFsaWRhdGlvbg0KPiA+ID4NCj4gPiA+IE9u
IFN1biwgTWFyIDIyLCAyMDIwIGF0IDA1OjM2OjE2QU0gLTA3MDAsIExpdSBZaSBMIHdyb3RlOg0K
PiA+ID4gPiBUaGlzIHBhdGNoIGFkZHMgdGhlIGJhc2ljIFBBU0lELWJhc2VkIGlvdGxiIChwaW90
bGIpIGludmFsaWRhdGlvbg0KPiA+ID4gPiBzdXBwb3J0LiBwaW90bGIgaXMgdXNlZCBkdXJpbmcg
d2Fsa2luZyBJbnRlbCBWVC1kIDFzdCBsZXZlbCBwYWdlDQo+ID4gPiA+IHRhYmxlLiBUaGlzIHBh
dGNoIG9ubHkgYWRkcyB0aGUgYmFzaWMgcHJvY2Vzc2luZy4gRGV0YWlsZWQNCj4gPiA+ID4gaGFu
ZGxpbmcgd2lsbCBiZSBhZGRlZCBpbiBuZXh0IHBhdGNoLg0KPiA+ID4gPg0KPiA+ID4gPiBDYzog
S2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+ID4gPiA+IENjOiBKYWNvYiBQYW4g
PGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0KPiA+ID4gPiBDYzogUGV0ZXIgWHUgPHBl
dGVyeEByZWRoYXQuY29tPg0KPiA+ID4gPiBDYzogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRl
bC5jb20+DQo+ID4gPiA+IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0K
PiA+ID4gPiBDYzogUmljaGFyZCBIZW5kZXJzb24gPHJ0aEB0d2lkZGxlLm5ldD4NCj4gPiA+ID4g
Q2M6IEVkdWFyZG8gSGFia29zdCA8ZWhhYmtvc3RAcmVkaGF0LmNvbT4NCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogTGl1IFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4g
PiA+ICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA1Nw0KPiA+ID4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICBody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmggfCAxMyArKysrKysrKysrDQo+ID4gPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDcwIGluc2VydGlvbnMoKykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBpbmRleA0KPiA+ID4gPiBi
MDA3NzE1Li5iOWFjMDdkIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11
LmMNCj4gPiA+ID4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gPiA+IEBAIC0zMTM0
LDYgKzMxMzQsNTkgQEAgc3RhdGljIGJvb2wNCj4gPiA+ID4gdnRkX3Byb2Nlc3NfcGFzaWRfZGVz
YyhJbnRlbElPTU1VU3RhdGUNCj4gPiA+ICpzLA0KPiA+ID4gPiAgICAgIHJldHVybiAocmV0ID09
IDApID8gdHJ1ZSA6IGZhbHNlOyAgfQ0KPiA+ID4gPg0KPiA+ID4gPiArc3RhdGljIHZvaWQgdnRk
X3Bpb3RsYl9wYXNpZF9pbnZhbGlkYXRlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBkb21haW5faWQs
DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMy
X3QgcGFzaWQpIHsgfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICtzdGF0aWMgdm9pZCB2dGRfcGlvdGxi
X3BhZ2VfaW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90DQo+IGRvbWFpbl9p
ZCwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQs
IGh3YWRkciBhZGRyLCB1aW50OF90DQo+ID4gPiA+ICthbSwgYm9vbCBpaCkgeyB9DQo+ID4gPiA+
ICsNCj4gPiA+ID4gK3N0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX3Bpb3RsYl9kZXNjKEludGVsSU9N
TVVTdGF0ZSAqcywNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFZUREludkRlc2MgKmludl9kZXNjKSB7DQo+ID4gPiA+ICsgICAgdWludDE2X3QgZG9tYWluX2lk
Ow0KPiA+ID4gPiArICAgIHVpbnQzMl90IHBhc2lkOw0KPiA+ID4gPiArICAgIHVpbnQ4X3QgYW07
DQo+ID4gPiA+ICsgICAgaHdhZGRyIGFkZHI7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICBpZiAo
KGludl9kZXNjLT52YWxbMF0gJiBWVERfSU5WX0RFU0NfUElPVExCX1JTVkRfVkFMMCkgfHwNCj4g
PiA+ID4gKyAgICAgICAgKGludl9kZXNjLT52YWxbMV0gJiBWVERfSU5WX0RFU0NfUElPVExCX1JT
VkRfVkFMMSkpIHsNCj4gPiA+ID4gKyAgICAgICAgZXJyb3JfcmVwb3J0X29uY2UoIm5vbi16ZXJv
LWZpZWxkLWluLXBpb3RsYl9pbnZfZGVzYyBoaTogMHglIiBQUkl4NjQNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICIgbG86IDB4JSIgUFJJeDY0LCBpbnZfZGVzYy0+dmFsWzFdLCBpbnZfZGVz
Yy0+dmFsWzBdKTsNCj4gPiA+ID4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gPiArICAg
IH0NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgIGRvbWFpbl9pZCA9IFZURF9JTlZfREVTQ19QSU9U
TEJfRElEKGludl9kZXNjLT52YWxbMF0pOw0KPiA+ID4gPiArICAgIHBhc2lkID0gVlREX0lOVl9E
RVNDX1BJT1RMQl9QQVNJRChpbnZfZGVzYy0+dmFsWzBdKTsNCj4gPiA+ID4gKyAgICBzd2l0Y2gg
KGludl9kZXNjLT52YWxbMF0gJiBWVERfSU5WX0RFU0NfSU9UTEJfRykgew0KPiA+ID4gPiArICAg
IGNhc2UgVlREX0lOVl9ERVNDX1BJT1RMQl9BTExfSU5fUEFTSUQ6DQo+ID4gPiA+ICsgICAgICAg
IHZ0ZF9waW90bGJfcGFzaWRfaW52YWxpZGF0ZShzLCBkb21haW5faWQsIHBhc2lkKTsNCj4gPiA+
ID4gKyAgICAgICAgYnJlYWs7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICBjYXNlIFZURF9JTlZf
REVTQ19QSU9UTEJfUFNJX0lOX1BBU0lEOg0KPiA+ID4gPiArICAgICAgICBhbSA9IFZURF9JTlZf
REVTQ19QSU9UTEJfQU0oaW52X2Rlc2MtPnZhbFsxXSk7DQo+ID4gPiA+ICsgICAgICAgIGFkZHIg
PSAoaHdhZGRyKSBWVERfSU5WX0RFU0NfUElPVExCX0FERFIoaW52X2Rlc2MtPnZhbFsxXSk7DQo+
ID4gPiA+ICsgICAgICAgIGlmIChhbSA+IFZURF9NQU1WKSB7DQo+ID4gPg0KPiA+ID4gSSBzYXcg
dGhpcyBvZiBzcGVjIDEwLjQuMiwgTUFNVjoNCj4gPiA+DQo+ID4gPiAgICAgICAgIEluZGVwZW5k
ZW50IG9mIHZhbHVlIHJlcG9ydGVkIGluIHRoaXMgZmllbGQsIGltcGxlbWVudGF0aW9ucw0KPiA+
ID4gICAgICAgICBzdXBwb3J0aW5nIFNNVFMgbXVzdCBzdXBwb3J0IGFkZHJlc3Mtc2VsZWN0aXZl
IFBBU0lELWJhc2VkDQo+ID4gPiAgICAgICAgIElPVExCIGludmFsaWRhdGlvbnMgKHBfaW90bGJf
aW52X2RzYykgd2l0aCBhbnkgZGVmaW5lZCBhZGRyZXNzDQo+ID4gPiAgICAgICAgIG1hc2suDQo+
ID4gPg0KPiA+ID4gRG9lcyBpdCBtZWFuIHdlIHNob3VsZCBldmVuIHN1cHBvcnQgbGFyZ2VyIEFN
Pw0KPiA+ID4NCj4gPiA+IEJlc2lkZXMgdGhhdCwgdGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUu
DQo+ID4NCj4gPiBJIGRvbid0IHRoaW5rIHNvLiBUaGlzIGZpZWxkIGlzIGZvciBzZWNvbmQtbGV2
ZWwgdGFibGUgaW4gc2NhbGFibGUNCj4gPiBtb2RlIGFuZCB0aGUgdHJhbnNsYXRpb24gdGFibGUg
aW4gbGVnYWN5IG1vZGUuIEZvciBmaXJzdC1sZXZlbCB0YWJsZSwNCj4gPiBpdCBhbHdheXMgc3Vw
cG9ydHMgcGFnZSBzZWxlY3RpdmUgaW52YWxpZGF0aW9uIGFuZCBhbGwgdGhlIHN1cHBvcnRlZA0K
PiA+IG1hc2tzIHJlZ2FyZGxlc3Mgb2YgdGhlIFBTSSBzdXBwb3J0IGJpdCBhbmQgdGhlIE1BTVYg
ZmllbGQgaW4gdGhlIENBUF9SRUcuDQo+IA0KPiBZZXMgdGhhdCdzIGV4YWN0bHkgd2hhdCBJIHdh
bnRlZCB0byBhc2suLi4gIExldCBtZSB0cnkgYWdhaW4uDQo+IA0KPiBJIHRob3VnaHQgVlREX01B
TVYgd2FzIG9ubHkgZm9yIDJuZCBsZXZlbCBwYWdlIHRhYmxlLCBub3QgZm9yIHBhc2lkLWlvdGxi
DQo+IGludmFsaWRhdGlvbnMuICBTbyBJIHRoaW5rIHdlIHNob3VsZCByZW1vdmUgdGhpcyAiaWYi
DQo+IGNoZWNrICh0aGF0IGNvcnJlc3BvbmRzIHRvICJ3ZSBzaG91bGQgZXZlbiBzdXBwb3J0IGxh
cmdlciBBTSIpLCByaWdodD8NCg0KUmlnaHQuIEkgY29uZmlybWVkIHdpdGggc3BlYyBvd25lci4g
V2lsbCByZW1vdmUgaXQuIDotKQ0KDQpSZWdhcmRzLA0KWWkgTGl1DQo=

