Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CAEC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 05:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E943B2075C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 05:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E943B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSEIc-0003Yd-3d
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 00:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iSEHy-0002ux-GR
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 00:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iSEHw-0007hl-G9
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 00:55:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:65364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iSEHw-0007gV-7c
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 00:55:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Nov 2019 21:55:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,272,1569308400"; d="scan'208";a="205222652"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga003.jf.intel.com with ESMTP; 05 Nov 2019 21:55:23 -0800
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 5 Nov 2019 21:55:22 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.200]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 13:55:21 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [RFC v2 11/22] intel_iommu: process pasid cache invalidation
Thread-Topic: [RFC v2 11/22] intel_iommu: process pasid cache invalidation
Thread-Index: AQHVims0gnJtva3dYk2Lhkg1plkVR6d3k9OAgATO/oA=
Date: Wed, 6 Nov 2019 05:55:20 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0EEE4E@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-12-git-send-email-yi.l.liu@intel.com>
 <20191102160547.GA26023@xz-x1.metropole.lan>
In-Reply-To: <20191102160547.GA26023@xz-x1.metropole.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjU5OGVkOWQtMzk2ZS00MDZmLTgzZTItZmM3ODI4N2RlNGJmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicklxV1BaQnNQSFhyWjFtYlwvd3dtUkV3R3dPam8zeThoRlBnWkRKQW9YZE1LRnhSRDRRXC85dkFmWnk0Uktzd0hYIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBTdW5k
YXksIE5vdmVtYmVyIDMsIDIwMTkgMTI6MDYgQU0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyB2MiAxMS8yMl0gaW50ZWxfaW9tbXU6IHBy
b2Nlc3MgcGFzaWQgY2FjaGUgaW52YWxpZGF0aW9uDQo+IA0KPiBPbiBUaHUsIE9jdCAyNCwgMjAx
OSBhdCAwODozNDozMkFNIC0wNDAwLCBMaXUgWWkgTCB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFk
ZHMgUEFTSUQgY2FjaGUgaW52YWxpZGF0aW9uIGhhbmRsaW5nLiBXaGVuIGd1ZXN0IGVuYWJsZWQN
Cj4gPiBQQVNJRCB1c2FnZXMgKGUuZy4gU1ZBKSwgZ3Vlc3Qgc29mdHdhcmUgc2hvdWxkIGlzc3Vl
IGEgcHJvcGVyIFBBU0lEDQo+ID4gY2FjaGUgaW52YWxpZGF0aW9uIHdoZW4gY2FjaGluZy1tb2Rl
IGlzIGV4cG9zZWQuIFRoaXMgcGF0Y2ggb25seSBhZGRzDQo+ID4gdGhlIGRyYWZ0IGhhbmRsaW5n
IG9mIHBhc2lkIGNhY2hlIGludmFsaWRhdGlvbi4gRGV0YWlsZWQgaGFuZGxpbmcgd2lsbA0KPiA+
IGJlIGFkZGVkIGluIHN1YnNlcXVlbnQgcGF0Y2hlcy4NCj4gPg0KPiA+IENjOiBLZXZpbiBUaWFu
IDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gPiBDYzogSmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFu
QGxpbnV4LmludGVsLmNvbT4NCj4gPiBDYzogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0K
PiA+IENjOiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBMaXUgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBody9pMzg2
L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA2NiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tDQo+IC0tDQo+ID4gIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8
IDEyICsrKysrKysrDQo+ID4gIGh3L2kzODYvdHJhY2UtZXZlbnRzICAgICAgICAgICB8ICAzICsr
DQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4gPiBpbmRleCA4OGI4NDNmLi44NGZmNmYwIDEwMDY0NA0KPiA+IC0tLSBh
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
PiA+IEBAIC0yMzM1LDYgKzIzMzUsNjMgQEAgc3RhdGljIGJvb2wgdnRkX3Byb2Nlc3NfaW90bGJf
ZGVzYyhJbnRlbElPTU1VU3RhdGUNCj4gKnMsIFZUREludkRlc2MgKmludl9kZXNjKQ0KPiA+ICAg
ICAgcmV0dXJuIHRydWU7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IHZ0ZF9wYXNpZF9j
YWNoZV9kc2koSW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBkb21haW5faWQpDQo+ID4gK3sN
Cj4gPiArICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHZ0ZF9w
YXNpZF9jYWNoZV9wc2koSW50ZWxJT01NVVN0YXRlICpzLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDE2X3QgZG9tYWluX2lkLCB1aW50MzJfdCBwYXNpZCkNCj4gPiAr
ew0KPiA+ICsgICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgdnRk
X3Bhc2lkX2NhY2hlX2dzaShJbnRlbElPTU1VU3RhdGUgKnMpDQo+ID4gK3sNCj4gPiArICAgIHJl
dHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgYm9vbCB2dGRfcHJvY2Vzc19wYXNp
ZF9kZXNjKEludGVsSU9NTVVTdGF0ZSAqcywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBWVERJbnZEZXNjICppbnZfZGVzYykNCj4gPiArew0KPiA+ICsgICAgdWludDE2
X3QgZG9tYWluX2lkOw0KPiA+ICsgICAgdWludDMyX3QgcGFzaWQ7DQo+ID4gKyAgICBpbnQgcmV0
ID0gMDsNCj4gPiArDQo+ID4gKyAgICBpZiAoKGludl9kZXNjLT52YWxbMF0gJiBWVERfSU5WX0RF
U0NfUEFTSURDX1JTVkRfVkFMMCkgfHwNCj4gPiArICAgICAgICAoaW52X2Rlc2MtPnZhbFsxXSAm
IFZURF9JTlZfREVTQ19QQVNJRENfUlNWRF9WQUwxKSB8fA0KPiA+ICsgICAgICAgIChpbnZfZGVz
Yy0+dmFsWzJdICYgVlREX0lOVl9ERVNDX1BBU0lEQ19SU1ZEX1ZBTDIpIHx8DQo+ID4gKyAgICAg
ICAgKGludl9kZXNjLT52YWxbM10gJiBWVERfSU5WX0RFU0NfUEFTSURDX1JTVkRfVkFMMykpIHsN
Cj4gPiArICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgibm9uLXplcm8tZmllbGQtaW4tcGNfaW52
X2Rlc2MgaGk6IDB4JSIgUFJJeDY0DQo+ID4gKyAgICAgICAgICAgICAgICAgICIgbG86IDB4JSIg
UFJJeDY0LCBpbnZfZGVzYy0+dmFsWzFdLCBpbnZfZGVzYy0+dmFsWzBdKTsNCj4gPiArICAgICAg
ICByZXR1cm4gZmFsc2U7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgZG9tYWluX2lkID0g
VlREX0lOVl9ERVNDX1BBU0lEQ19ESUQoaW52X2Rlc2MtPnZhbFswXSk7DQo+ID4gKyAgICBwYXNp
ZCA9IFZURF9JTlZfREVTQ19QQVNJRENfUEFTSUQoaW52X2Rlc2MtPnZhbFswXSk7DQo+ID4gKw0K
PiA+ICsgICAgc3dpdGNoIChpbnZfZGVzYy0+dmFsWzBdICYgVlREX0lOVl9ERVNDX1BBU0lEQ19H
KSB7DQo+ID4gKyAgICBjYXNlIFZURF9JTlZfREVTQ19QQVNJRENfRFNJOg0KPiA+ICsgICAgICAg
IHJldCA9IHZ0ZF9wYXNpZF9jYWNoZV9kc2kocywgZG9tYWluX2lkKTsNCj4gPiArICAgICAgICBi
cmVhazsNCj4gPiArDQo+ID4gKyAgICBjYXNlIFZURF9JTlZfREVTQ19QQVNJRENfUEFTSURfU0k6
DQo+ID4gKyAgICAgICAgcmV0ID0gdnRkX3Bhc2lkX2NhY2hlX3BzaShzLCBkb21haW5faWQsIHBh
c2lkKTsNCj4gPiArICAgICAgICBicmVhazsNCj4gPiArDQo+ID4gKyAgICBjYXNlIFZURF9JTlZf
REVTQ19QQVNJRENfR0xPQkFMOg0KPiA+ICsgICAgICAgIHJldCA9IHZ0ZF9wYXNpZF9jYWNoZV9n
c2kocyk7DQo+ID4gKyAgICAgICAgYnJlYWs7DQo+ID4gKw0KPiA+ICsgICAgZGVmYXVsdDoNCj4g
PiArICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgiaW52YWxpZC1pbnYtZ3JhbnUtaW4tcGNfaW52
X2Rlc2MgaGk6IDB4JSIgUFJJeDY0DQo+ID4gKyAgICAgICAgICAgICAgICAgICIgbG86IDB4JSIg
UFJJeDY0LCBpbnZfZGVzYy0+dmFsWzFdLCBpbnZfZGVzYy0+dmFsWzBdKTsNCj4gPiArICAgICAg
ICByZXR1cm4gZmFsc2U7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgcmV0dXJuIChyZXQg
PT0gMCkgPyB0cnVlIDogZmFsc2U7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBib29sIHZ0
ZF9wcm9jZXNzX2ludl9pZWNfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERJbnZEZXNjICppbnZfZGVzYykNCj4gPiAg
ew0KPiA+IEBAIC0yNDQxLDEyICsyNDk4LDExIEBAIHN0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX2lu
dl9kZXNjKEludGVsSU9NTVVTdGF0ZQ0KPiAqcykNCj4gPiAgICAgICAgICB9DQo+ID4gICAgICAg
ICAgYnJlYWs7DQo+ID4NCj4gPiAtICAgIC8qDQo+ID4gLSAgICAgKiBUT0RPOiB0aGUgZW50aXR5
IG9mIGJlbG93IHR3byBjYXNlcyB3aWxsIGJlIGltcGxlbWVudGVkIGluIGZ1dHVyZSBzZXJpZXMu
DQo+ID4gLSAgICAgKiBUbyBtYWtlIGd1ZXN0ICh3aGljaCBpbnRlZ3JhdGVzIHNjYWxhYmxlIG1v
ZGUgc3VwcG9ydCBwYXRjaCBzZXQgaW4NCj4gPiAtICAgICAqIGlvbW11IGRyaXZlcikgd29yaywg
anVzdCByZXR1cm4gdHJ1ZSBpcyBlbm91Z2ggc28gZmFyLg0KPiA+IC0gICAgICovDQo+ID4gICAg
ICBjYXNlIFZURF9JTlZfREVTQ19QQzoNCj4gPiArICAgICAgICB0cmFjZV92dGRfaW52X2Rlc2Mo
InBhc2lkLWNhY2hlIiwgaW52X2Rlc2MudmFsWzFdLCBpbnZfZGVzYy52YWxbMF0pOw0KPiANCj4g
Q291bGQgYmUgaGVscGZ1bCBpZiB5b3UgZHVtcCBbMnwzXSB0b2dldGhlciBoZXJlLi4uDQoNCnN1
cmUuIExldCBtZSBhZGQgaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+ID4gKyAgICAgICAgaWYgKCF2
dGRfcHJvY2Vzc19wYXNpZF9kZXNjKHMsICZpbnZfZGVzYykpIHsNCj4gPiArICAgICAgICAgICAg
cmV0dXJuIGZhbHNlOw0KPiA+ICsgICAgICAgIH0NCj4gPiAgICAgICAgICBicmVhazsNCj4gPg0K
PiA+ICAgICAgY2FzZSBWVERfSU5WX0RFU0NfUElPVExCOg0KPiA+IGRpZmYgLS1naXQgYS9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmgNCj4gPiBpbmRleCA4NjY4NzcxLi5jNmNiMjhiIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50
ZXJuYWwuaA0KPiA+IEBAIC00NDUsNiArNDQ1LDE4IEBAIHR5cGVkZWYgdW5pb24gVlRESW52RGVz
YyBWVERJbnZEZXNjOw0KPiA+ICAjZGVmaW5lIFZURF9TUFRFX0xQQUdFX0w0X1JTVkRfTUFTSyhh
dykgXA0KPiA+ICAgICAgICAgICgweDg4MFVMTCB8IH4oVlREX0hBV19NQVNLKGF3KSB8IFZURF9T
TF9JR05fQ09NKSkNCj4gPg0KPiA+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRENfRyAgICAg
ICAgICAoM1VMTCA8PCA0KQ0KPiA+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRENfUEFTSUQo
dmFsKSAoKCh2YWwpID4+IDMyKSAmIDB4ZmZmZmZVTEwpDQo+ID4gKyNkZWZpbmUgVlREX0lOVl9E
RVNDX1BBU0lEQ19ESUQodmFsKSAgICgoKHZhbCkgPj4gMTYpICYNCj4gVlREX0RPTUFJTl9JRF9N
QVNLKQ0KPiA+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRENfUlNWRF9WQUwwICAweGZmZjAw
MDAwMDAwMGZmYzBVTEwNCj4gDQo+IE5pdDogTWluZCB0byBjb21tZW50IGhlcmUgdGhhdCBiaXQg
OS0xMSBpcyBtYXJrZWQgYXMgemVybyByYXRoZXIgdGhhbg0KPiByZXNlcnZlZD8gIFRoaXMgc2Vl
bXMgdG8gd29yayBidXQgaWYgYml0IDktMTEgY2FuIGJlIG5vbi16ZXJvIGluIHNvbWUNCj4gb3Ro
ZXIgZGVzY3JpcHRvcnMgdGhlbiBpdCB3b3VsZCBiZSBjbGVhcmVyIHRvIGRlZmluZSBpdCBhcw0K
PiAweGZmZjAwMDAwMDAwMGYxYzBVTEwgdGhlbiBleHBsaWNpdGx5IGNoZWNrIGJpdHMgOS0xMS4N
Cj4gDQo+IE90aGVyd2lzZSBsb29rcyBnb29kIHRvIG1lLg0KDQpZb3UgYXJlIHJpZ2h0LiBUaGlz
IGlzIG5vdCByZXNlcnZlZC4gSXQncyBwYXJ0cyBvZiB0aGUgZGVzY3JpcHRvciB0eXBlIG5vdy4g
V2lsbA0KZml4IGl0IGluIG5leHQgdmVyc2lvbi4NCg0KUmVnYXJkcywNCllpIExpdQ0K

