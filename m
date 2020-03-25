Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C5BC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3C02077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3C02077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH5sQ-0005lx-56
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jH5rj-0005AF-Km
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jH5rh-0003UJ-GN
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:14:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:36592)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jH5rh-0003O0-7z
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:14:37 -0400
IronPort-SDR: S/erqCwmfUS04ptKTmOOkjjXzLW4U8Py9RFgoOef6PD1GiEyKHqtQTCHM9WBqcf76q1sXBjPcy
 cEjb/fcTM5pA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 06:14:32 -0700
IronPort-SDR: rdHWNtp6q/Ba8wcojmZLFVf71T6S2kP5/HYGkYvzdajq/L3PSTL+u4yjqLuwJ3r/4uhnh6aNY/
 q75F60RGCm4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; d="scan'208";a="326221905"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga001.jf.intel.com with ESMTP; 25 Mar 2020 06:14:31 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 06:14:31 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 06:14:30 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.232]) with mapi id 14.03.0439.000;
 Wed, 25 Mar 2020 21:14:27 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v1 15/22] intel_iommu: replay guest pasid bindings to host
Thread-Topic: [PATCH v1 15/22] intel_iommu: replay guest pasid bindings to host
Thread-Index: AQHWAEW2TKrNzFeLS0yo5PxjKqQ+KahXhXqAgAHBPcA=
Date: Wed, 25 Mar 2020 13:14:26 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A202251@SHSMSX104.ccr.corp.intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-16-git-send-email-yi.l.liu@intel.com>
 <20200324180013.GZ127076@xz-x1>
In-Reply-To: <20200324180013.GZ127076@xz-x1>
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
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
TWFyY2ggMjUsIDIwMjAgMjowMCBBTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTUvMjJdIGludGVsX2lvbW11OiByZXBsYXkg
Z3Vlc3QgcGFzaWQgYmluZGluZ3MgdG8gaG9zdA0KPiANCj4gT24gU3VuLCBNYXIgMjIsIDIwMjAg
YXQgMDU6MzY6MTJBTSAtMDcwMCwgTGl1IFlpIEwgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBhZGRz
IGd1ZXN0IHBhc2lkIGJpbmRpbmdzIHJlcGxheSBmb3IgZG9tYWluDQo+ID4gc2VsZWN0aXZlIHBh
c2lkIGNhY2hlIGludmFsaWRhdGlvbihkc2kpIGFuZCBnbG9iYWwgcGFzaWQNCj4gPiBjYWNoZSBp
bnZhbGlkYXRpb24gYnkgd2Fsa2luZyBndWVzdCBwYXNpZCB0YWJsZS4NCj4gPg0KPiA+IFJlYXNv
bjoNCj4gPiBHdWVzdCBPUyBtYXkgZmx1c2ggdGhlIHBhc2lkIGNhY2hlIHdpdGggYSBsYXJnZXIg
Z3JhbnVsYXJpdHkuDQo+ID4gZS5nLiBndWVzdCBkb2VzIGEgc3ZtX2JpbmQoKSBidXQgZmx1c2gg
dGhlIHBhc2lkIGNhY2hlIHdpdGgNCj4gPiBnbG9iYWwgb3IgZG9tYWluIHNlbGVjdGl2ZSBwYXNp
ZCBjYWNoZSBpbnZhbGlkYXRpb24gaW5zdGVhZA0KPiA+IG9mIHBhc2lkIHNlbGVjdGl2ZShwc2kp
IHBhc2lkIGNhY2hlIGludmFsaWRhdGlvbi4gUmVnYXJkcyB0bw0KPiA+IHN1Y2ggY2FzZSwgaXQg
d29ya3MgaW4gaG9zdC4gUGVyIHNwZWMsIGEgZ2xvYmFsIG9yIGRvbWFpbg0KPiA+IHNlbGVjdGl2
ZSBwYXNpZCBjYWNoZSBpbnZhbGlkYXRpb24gc2hvdWxkIGJlIGFibGUgdG8gY292ZXINCj4gPiB3
aGF0IGEgcGFzaWQgc2VsZWN0aXZlIGludmFsaWRhdGlvbiBkb2VzLiBUaGUgb25seSBjb25jZXJu
DQo+ID4gaXMgcGVyZm9ybWFuY2UgZGVkdWN0aW9uIHNpbmNlIGRzaSBhbmQgZ2xvYmFsIGNhY2hl
IGludmFsaWRhdGlvbg0KPiA+IHdpbGwgZmx1c2ggbW9yZSB0aGFuIHBzaS4gVG8gYWxpZ24gd2l0
aCBuYXRpdmUsIHZJT01NVSBuZWVkcw0KPiA+IGVtdWxhdG9yIG5lZWRzIHRvIGRvIHJlcGxheSBm
b3IgdGhlIHR3byBpbnZhbGlkYXRpb24gZ3JhbnVsYXJpdHkNCj4gPiB0byByZWZsZWN0IHRoZSBs
YXRlc3QgcGFzaWQgYmluZGluZ3MgaW4gZ3Vlc3QgcGFzaWQgdGFibGUuDQo+IA0KPiBUaGlzIGlz
IGFjdHVhbGx5IHJlbGF0ZWQgdG8gbXkgcXVlc3Rpb24gaW4gdGhlIG90aGVyIHBhdGNoIG9uIHdo
ZXRoZXINCj4gdGhlIHJlcGxheSBjYW4gYW5kIHNob3VsZCBhbHNvIHdvcmsgZm9yIHRoZSBQU0kg
Y2FzZSB0b28uICBJJ20gc3RpbGwNCj4gY29uZnVzZWQgb24gd2h5IHRoZSBndWVzdCBjYW5ub3Qg
dXNlIGEgUFNJIGZvciBhIG5ld2x5IGNyZWF0ZWQgUEFTSUQNCj4gZW50cnkgZm9yIG9uZSBkZXZp
Y2U/DQoNClVzZSBhIFBTSSBmb3IgYSBuZXdseSBjcmVhdGVkIFBBU0lEIGVudHJ5IGZvciBvbmUg
ZGV2aWNlIGlzIHRoZSBjb3JyZWN0DQp3YXkuIEJ1dCBzcGVjIGRvZXNuJ3QgaW5jbHVkZSB0aGUg
ZGV2aWNlIGluZm8gaW4gdGhlIGludmFsaWRhdGlvbiBkZXNjcmlwdG9yLg0KUmVhc29uIGlzIHRo
ZXJlIGlzIERJRCBpbmZvIHdoaWNoIGlzIGVub3VnaC4NCg0KSSB0aGluayB0aGUgcmVwbGF5IGNv
ZGUgYW5kIHRoZSBQU0kgY29kZSBzaG91bGQgYmUgZGVzaWduZWQgd2l0aA0KdGhlIHNhbWUgaWRl
YS4gV2l0aCBhIFN0ZXAgMSBsb29wIGFsbCBleGlzdGluZyBwYXNpZF9hcywgYW5kIFN0ZXAgMg0K
dG8gbG9vcCBhbGwgYXNzaWduZWQgZGV2aWNlcy4gSSdsbCB0cnkgdG8gbWFrZSB0aGVtIHNoYXJl
IHRoZSBsb3cNCmxldmVsIGNvZGUuIGUuZy4gdGhlIG1vc3QgY29kZSBpbiBQU0kgaGFuZGxpbmcu
DQoNCj4gDQo+ID4NCj4gPiBDYzogS2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+
ID4gQ2M6IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6
IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4gPiBDYzogWWkgU3VuIDx5aS55LnN1bkBs
aW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5j
b20+DQo+ID4gQ2M6IFJpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+DQo+ID4gU2ln
bmVkLW9mZi1ieTogTGl1IFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAg
aHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgMTI4DQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJu
YWwuaCB8ICAgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTI3IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gaW5kZXggMDQyM2M4My4uOGVjNjM4ZiAxMDA2
NDQNCj4gPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gPiArKysgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4gPiBAQCAtMjcxNyw2ICsyNzE3LDEzMCBAQCBzdGF0aWMgVlREUEFTSURB
ZGRyZXNzU3BhY2UNCj4gKnZ0ZF9hZGRfZmluZF9wYXNpZF9hcyhJbnRlbElPTU1VU3RhdGUgKnMs
DQo+ID4gICAgICByZXR1cm4gdnRkX3Bhc2lkX2FzOw0KPiA+ICB9DQo+ID4NCj4gPiArLyoqDQo+
ID4gKyAqIENvbnN0YW50IGluZm9ybWF0aW9uIHVzZWQgZHVyaW5nIHBhc2lkIHRhYmxlIHdhbGsN
Cj4gPiArICAgQHZ0ZF9idXMsIEBkZXZmbjogZGV2aWNlIGluZm8NCj4gPiArICogQGZsYWdzOiBp
bmRpY2F0ZXMgaWYgaXQgaXMgZG9tYWluIHNlbGVjdGl2ZSB3YWxrDQo+ID4gKyAqIEBkaWQ6IGRv
bWFpbiBJRCBvZiB0aGUgcGFzaWQgdGFibGUgd2Fsaw0KPiA+ICsgKi8NCj4gPiArdHlwZWRlZiBz
dHJ1Y3Qgew0KPiA+ICsgICAgVlREQnVzICp2dGRfYnVzOw0KPiA+ICsgICAgdWludDE2X3QgZGV2
Zm47DQo+ID4gKyNkZWZpbmUgVlREX1BBU0lEX1RBQkxFX0RJRF9TRUxfV0FMSyAgICgxVUxMIDw8
IDApOw0KPiA+ICsgICAgdWludDMyX3QgZmxhZ3M7DQo+ID4gKyAgICB1aW50MTZfdCBkaWQ7DQo+
ID4gK30gdnRkX3Bhc2lkX3RhYmxlX3dhbGtfaW5mbzsNCj4gDQo+IFNvIHRoaXMgaXMgZ29pbmcg
dG8gYmUgc2ltaWxhciB0byBWVERQQVNJRENhY2hlSW5mbyBhcyBJIG1lbnRpb25lZC4NCj4gTWF5
YmUgeW91IGNhbiB1c2UgYSBzaGFyZWQgb2JqZWN0IGZvciBib3RoPw0KDQpBaGEsIHNpbWlsYXIu
IGhpZ2ggY2hhbmNlIHRvIHJldXNlIGZvciBib3RoLiA6LSkNCg0KPiA+ICsNCj4gPiArLyoqDQo+
ID4gKyAqIENhbGxlciBvZiB0aGlzIGZ1bmN0aW9uIHNob3VsZCBob2xkIGlvbW11X2xvY2suDQo+
ID4gKyAqLw0KPiA+ICtzdGF0aWMgYm9vbCB2dGRfc21fcGFzaWRfdGFibGVfd2Fsa19vbmUoSW50
ZWxJT01NVVN0YXRlICpzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZG1hX2FkZHJfdCBwdF9iYXNlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW50IHN0YXJ0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW50IGVuZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZ0ZF9wYXNpZF90YWJsZV93YWxrX2luZm8gKmluZm8pDQo+ID4gK3sNCj4g
PiArICAgIFZURFBBU0lERW50cnkgcGU7DQo+ID4gKyAgICBpbnQgcGFzaWQgPSBzdGFydDsNCj4g
PiArICAgIGludCBwYXNpZF9uZXh0Ow0KPiA+ICsgICAgVlREUEFTSURBZGRyZXNzU3BhY2UgKnZ0
ZF9wYXNpZF9hczsNCj4gPiArICAgIFZURFBBU0lEQ2FjaGVFbnRyeSAqcGNfZW50cnk7DQo+ID4g
Kw0KPiA+ICsgICAgd2hpbGUgKHBhc2lkIDwgZW5kKSB7DQo+ID4gKyAgICAgICAgcGFzaWRfbmV4
dCA9IHBhc2lkICsgMTsNCj4gPiArDQo+ID4gKyAgICAgICAgaWYgKCF2dGRfZ2V0X3BlX2luX3Bh
c2lkX2xlYWZfdGFibGUocywgcGFzaWQsIHB0X2Jhc2UsICZwZSkNCj4gPiArICAgICAgICAgICAg
JiYgdnRkX3BlX3ByZXNlbnQoJnBlKSkgew0KPiA+ICsgICAgICAgICAgICB2dGRfcGFzaWRfYXMg
PSB2dGRfYWRkX2ZpbmRfcGFzaWRfYXMocywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW5mby0+dnRkX2J1cywgaW5mby0+ZGV2Zm4sIHBhc2lkKTsNCj4gDQo+
IEZvciB0aGlzIGNodW5rOg0KPiANCj4gPiArICAgICAgICAgICAgcGNfZW50cnkgPSAmdnRkX3Bh
c2lkX2FzLT5wYXNpZF9jYWNoZV9lbnRyeTsNCj4gPiArICAgICAgICAgICAgaWYgKHMtPnBhc2lk
X2NhY2hlX2dlbiA9PSBwY19lbnRyeS0+cGFzaWRfY2FjaGVfZ2VuKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgICB2dGRfdXBkYXRlX3BlX2luX2NhY2hlKHMsIHZ0ZF9wYXNpZF9hcywgJnBlKTsNCj4g
PiArICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgICAgIHZ0ZF9maWxsX2lu
X3BlX2luX2NhY2hlKHMsIHZ0ZF9wYXNpZF9hcywgJnBlKTsNCj4gPiArICAgICAgICAgICAgfQ0K
PiANCj4gV2UgYWxyZWFkeSBnb3QgJnBlLCB0aGVuIHdvdWxkIGl0IGJlIGVhc2llciB0byBzaW1w
bHkgY2FsbDoNCj4gDQo+ICAgICAgICAgICAgICAgIHZ0ZF91cGRhdGVfcGVfaW5fY2FjaGUocywg
dnRkX3Bhc2lkX2FzLCAmcGUpOw0KPiANCj4gPw0KDQpJZiB0aGUgcGFzaWRfY2FjaGVfZ2VuIGlz
IGVxdWFsIHRvIGlvbW11X3N0YXRlJ3MsIHRoZW4gaXQgbWVhbnMgdGhlcmUgaXMNCmEgY2hhbmNl
IHRoYXQgdGhlIGNhY2hlZCBwYXNpZCBlbnRyeSBpcyBlcXVhbCB0byBwZSBoZXJlLiBXaGlsZSBm
b3IgdGhlDQplbHNlIGNhc2UsIGl0IGlzIHN1cmVseSB0aGVyZSBpcyBubyB2YWxpZCBwYXNpZCBl
bnRyeSBpbiB0aGUgcGFzaWRfYXMuIEFuZA0KdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB2dGRfdXBk
YXRlX3BlX2luX2NhY2hlKCkgYW5kDQp2dGRfZmlsbF9pbl9wZV9pbl9jYWNoZSgpIGlzIHdoZXRo
ZXIgZG8gYSBjb21wYXJlIGJldHdlZW4gdGhlIG5ldyBwYXNpZCBlbnRyeQ0KYW5kIGNhY2hlZCBw
YXNpZCBlbnRyeS4NCg0KPiBTaW5jZSBJSVVDIHRoZSBjYWNoZV9nZW4gaXMgb25seSBoZWxwZnVs
IHRvIGF2b2lkIGxvb2tpbmcgdXAgdGhlICZwZS4NCj4gQW5kIHRoZSB2dGRfcGFzaWRfZW50cnlf
Y29tcGFyZSgpIGNoZWNrIHNob3VsZCBiZSBldmVuIG1vcmUgc29saWQgdGhhbg0KPiB0aGUgY2Fj
aGVfZ2VuLg0KDQpCdXQgaWYgdGhlIGNhY2hlX2dlbiBpcyBub3QgZXF1YWwgdGhlIG9uZSBpbiBp
b21tdV9zdGF0ZSwgdGhlbiB0aGUgY2FjaGVkDQpwYXNpZCBlbnRyeSBpcyBub3QgdmFsaWQgYXQg
YWxsLiBUaGUgY29tcGFyZSBpcyBvbmx5IG5lZWRlZCBhZnRlciB0aGUgY2FjaGVfZ2VuDQppcyBj
aGVja2VkLg0KDQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgICAgIHBhc2lkID0gcGFzaWRfbmV4
dDsNCj4gPiArICAgIH0NCj4gPiArICAgIHJldHVybiB0cnVlOw0KPiA+ICt9DQo+ID4gKw0KPiA+
ICsvKg0KPiA+ICsgKiBDdXJyZW50bHksIFZULWQgc2NhbGFibGUgbW9kZSBwYXNpZCB0YWJsZSBp
cyBhIHR3byBsZXZlbCB0YWJsZSwNCj4gPiArICogdGhpcyBmdW5jdGlvbiBhaW1zIHRvIGxvb3Ag
YSByYW5nZSBvZiBQQVNJRHMgaW4gYSBnaXZlbiBwYXNpZA0KPiA+ICsgKiB0YWJsZSB0byBpZGVu
dGlmeSB0aGUgcGFzaWQgY29uZmlnIGluIGd1ZXN0Lg0KPiA+ICsgKiBDYWxsZXIgb2YgdGhpcyBm
dW5jdGlvbiBzaG91bGQgaG9sZCBpb21tdV9sb2NrLg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIHZv
aWQgdnRkX3NtX3Bhc2lkX3RhYmxlX3dhbGsoSW50ZWxJT01NVVN0YXRlICpzLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkbWFfYWRkcl90IHBkdF9iYXNlLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgc3RhcnQsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBlbmQsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZ0ZF9wYXNpZF90YWJsZV93YWxrX2luZm8gKmlu
Zm8pDQo+ID4gK3sNCj4gPiArICAgIFZURFBBU0lERGlyRW50cnkgcGRpcmU7DQo+ID4gKyAgICBp
bnQgcGFzaWQgPSBzdGFydDsNCj4gPiArICAgIGludCBwYXNpZF9uZXh0Ow0KPiA+ICsgICAgZG1h
X2FkZHJfdCBwdF9iYXNlOw0KPiA+ICsNCj4gPiArICAgIHdoaWxlIChwYXNpZCA8IGVuZCkgew0K
PiA+ICsgICAgICAgIHBhc2lkX25leHQgPSBwYXNpZCArIFZURF9QQVNJRF9UQkxfRU5UUllfTlVN
Ow0KPiA+ICsgICAgICAgIGlmICghdnRkX2dldF9wZGlyZV9mcm9tX3BkaXJfdGFibGUocGR0X2Jh
c2UsIHBhc2lkLCAmcGRpcmUpDQo+ID4gKyAgICAgICAgICAgICYmIHZ0ZF9wZGlyZV9wcmVzZW50
KCZwZGlyZSkpIHsNCj4gPiArICAgICAgICAgICAgcHRfYmFzZSA9IHBkaXJlLnZhbCAmIFZURF9Q
QVNJRF9UQUJMRV9CQVNFX0FERFJfTUFTSzsNCj4gPiArICAgICAgICAgICAgaWYgKCF2dGRfc21f
cGFzaWRfdGFibGVfd2Fsa19vbmUocywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcHRfYmFzZSwgcGFzaWQsIHBhc2lkX25leHQsIGluZm8pKSB7DQo+IA0KPiB2dGRfc21fcGFz
aWRfdGFibGVfd2Fsa19vbmUoKSBuZXZlciByZXR1cm5zIGZhbHNlLiAgUmVtb3ZlIHRoaXMgY2hl
Y2s/DQo+IE1heWJlIGFsc28gbGV0IHZ0ZF9zbV9wYXNpZF90YWJsZV93YWxrX29uZSgpIHRvIHJl
dHVybiBub3RoaW5nLg0KDQpPb3BzLiBDb3VsZCBtYWtlIGl0IGFzIHZvaWQuDQoNClJlZ2FyZHMs
DQpZaSBMaXUNCg==

