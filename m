Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52759C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B492073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B492073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSVS-0008Ir-AF
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jHSUI-0006sj-Qr
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jHSUF-0002WS-Du
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:23:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:60837)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jHSUF-0002WD-6B
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:23:55 -0400
IronPort-SDR: d96foqpVMlZWSn9anWAIn+JIvBD5Eoef/5dTPE4p77KOKZUN59DvXwVUiecgYe3vzFufJoPyQc
 3Px/QIny4nhg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2020 06:23:51 -0700
IronPort-SDR: bPBHDFJhmOu/dFFY9XMnunax37XJvI4o+lCJknmKZ1cwKiocXIi24I5J8L/mA8lIw1nfOMpMJP
 onqLyQr8WHZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,308,1580803200"; d="scan'208";a="358141858"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2020 06:23:51 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 06:23:50 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 06:23:49 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.50]) with mapi id 14.03.0439.000;
 Thu, 26 Mar 2020 21:23:46 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v1 20/22] intel_iommu: propagate PASID-based iotlb
 invalidation to host
Thread-Topic: [PATCH v1 20/22] intel_iommu: propagate PASID-based iotlb
 invalidation to host
Thread-Index: AQHWAEW3X+65yqyUwUiucJlWzaqkgqhXjwWAgAHAhkCAAREEgP//9nsAgACJf2A=
Date: Thu, 26 Mar 2020 13:23:45 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A204500@SHSMSX104.ccr.corp.intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-21-git-send-email-yi.l.liu@intel.com>
 <20200324183423.GE127076@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A2022C5@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A203E63@SHSMSX104.ccr.corp.intel.com>
 <20200326130248.GB422390@xz-x1>
In-Reply-To: <20200326130248.GB422390@xz-x1>
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

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBN
YXJjaCAyNiwgMjAyMCA5OjAzIFBNDQo+IFRvOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAyMC8yMl0gaW50ZWxfaW9tbXU6IHByb3BhZ2F0
ZSBQQVNJRC1iYXNlZCBpb3RsYg0KPiBpbnZhbGlkYXRpb24gdG8gaG9zdA0KPiANCj4gT24gVGh1
LCBNYXIgMjYsIDIwMjAgYXQgMDU6NDE6MzlBTSArMDAwMCwgTGl1LCBZaSBMIHdyb3RlOg0KPiA+
ID4gRnJvbTogTGl1LCBZaSBMDQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDI1LCAyMDIw
IDk6MjIgUE0NCj4gPiA+IFRvOiAnUGV0ZXIgWHUnIDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4gPiA+
IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjEgMjAvMjJdIGludGVsX2lvbW11OiBwcm9wYWdhdGUgUEFT
SUQtYmFzZWQNCj4gPiA+IGlvdGxiIGludmFsaWRhdGlvbiB0byBob3N0DQo+ID4gPg0KPiA+ID4g
PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+ID4gPiA+IFNlbnQ6IFdlZG5l
c2RheSwgTWFyY2ggMjUsIDIwMjAgMjozNCBBTQ0KPiA+ID4gPiBUbzogTGl1LCBZaSBMIDx5aS5s
LmxpdUBpbnRlbC5jb20+DQo+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMjAvMjJdIGlu
dGVsX2lvbW11OiBwcm9wYWdhdGUgUEFTSUQtYmFzZWQNCj4gPiA+ID4gaW90bGIgaW52YWxpZGF0
aW9uIHRvIGhvc3QNCj4gPiA+ID4NCj4gPiA+ID4gT24gU3VuLCBNYXIgMjIsIDIwMjAgYXQgMDU6
MzY6MTdBTSAtMDcwMCwgTGl1IFlpIEwgd3JvdGU6DQo+ID4gPiA+ID4gVGhpcyBwYXRjaCBwcm9w
YWdhdGVzIFBBU0lELWJhc2VkIGlvdGxiIGludmFsaWRhdGlvbiB0byBob3N0Lg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gSW50ZWwgVlQtZCAzLjAgc3VwcG9ydHMgbmVzdGVkIHRyYW5zbGF0aW9uIGlu
IFBBU0lEIGdyYW51bGFyLg0KPiA+ID4gPiA+IEd1ZXN0IFNWQSBzdXBwb3J0IGNvdWxkIGJlIGlt
cGxlbWVudGVkIGJ5IGNvbmZpZ3VyaW5nIG5lc3RlZA0KPiA+ID4gPiA+IHRyYW5zbGF0aW9uIG9u
IHNwZWNpZmljIFBBU0lELiBUaGlzIGlzIGFsc28ga25vd24gYXMgZHVhbCBzdGFnZQ0KPiA+ID4g
PiA+IERNQSB0cmFuc2xhdGlvbi4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFVuZGVyIHN1Y2ggY29u
ZmlndXJhdGlvbiwgZ3Vlc3Qgb3ducyB0aGUgR1ZBLT5HUEEgdHJhbnNsYXRpb24NCj4gPiA+ID4g
PiB3aGljaCBpcyBjb25maWd1cmVkIGFzIGZpcnN0IGxldmVsIHBhZ2UgdGFibGUgaW4gaG9zdCBz
aWRlIGZvciBhDQo+ID4gPiA+ID4gc3BlY2lmaWMgcGFzaWQsIGFuZCBob3N0IG93bnMgR1BBLT5I
UEEgdHJhbnNsYXRpb24uIEFzIGd1ZXN0DQo+ID4gPiA+ID4gb3ducyBmaXJzdCBsZXZlbCB0cmFu
c2xhdGlvbiB0YWJsZSwgcGlvdGxiIGludmFsaWRhdGlvbiBzaG91bGQNCj4gPiA+ID4gPiBiZSBw
cm9wYWdhdGVkIHRvIGhvc3Qgc2luY2UgaG9zdCBJT01NVSB3aWxsIGNhY2hlIGZpcnN0IGxldmVs
DQo+ID4gPiA+ID4gcGFnZSB0YWJsZSByZWxhdGVkIG1hcHBpbmdzIGR1cmluZyBETUEgYWRkcmVz
cyB0cmFuc2xhdGlvbi4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoaXMgcGF0Y2ggdHJhcHMgdGhl
IGd1ZXN0IFBBU0lELWJhc2VkIGlvdGxiIGZsdXNoIGFuZCBwcm9wYWdhdGUNCj4gPiA+ID4gPiBp
dCB0byBob3N0Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQ2M6IEtldmluIFRpYW4gPGtldmluLnRp
YW5AaW50ZWwuY29tPg0KPiA+ID4gPiA+IENjOiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGlu
dXguaW50ZWwuY29tPg0KPiA+ID4gPiA+IENjOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+
DQo+ID4gPiA+ID4gQ2M6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPiA+ID4g
PiA+IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPiA+ID4gPiA+IENj
OiBSaWNoYXJkIEhlbmRlcnNvbiA8cnRoQHR3aWRkbGUubmV0Pg0KPiA+ID4gPiA+IENjOiBFZHVh
cmRvIEhhYmtvc3QgPGVoYWJrb3N0QHJlZGhhdC5jb20+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogTGl1IFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4g
PiAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgMTM5DQo+ID4gPiA+ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gIGh3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAgNyArKysNCj4gPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAxNDYgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2h3
L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBpbmRleA0KPiA+ID4g
PiA+IGI5YWMwN2QuLjEwZDMxNGQgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvaHcvaTM4Ni9pbnRl
bF9pb21tdS5jDQo+ID4gPiA+ID4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gPiA+
ID4gQEAgLTMxMzQsMTUgKzMxMzQsMTU0IEBAIHN0YXRpYyBib29sDQo+ID4gPiA+IHZ0ZF9wcm9j
ZXNzX3Bhc2lkX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KPiA+ID4gPiA+ICAgICAgcmV0dXJu
IChyZXQgPT0gMCkgPyB0cnVlIDogZmFsc2U7ICB9DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiArLyoq
DQo+ID4gPiA+ID4gKyAqIENhbGxlciBvZiB0aGlzIGZ1bmN0aW9uIHNob3VsZCBob2xkIGlvbW11
X2xvY2suDQo+ID4gPiA+ID4gKyAqLw0KPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCB2dGRfaW52YWxp
ZGF0ZV9waW90bGIoSW50ZWxJT01NVVN0YXRlICpzLA0KPiA+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgVlREQnVzICp2dGRfYnVzLA0KPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGRldmZuLA0KPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgRHVhbElPTU1VU3RhZ2UxQ2FjaGUNCj4gPiA+ID4g
PiArKnN0YWdlMV9jYWNoZSkgew0KPiA+ID4gPiA+ICsgICAgVlRESG9zdElPTU1VQ29udGV4dCAq
dnRkX2Rldl9pY3g7DQo+ID4gPiA+ID4gKyAgICBIb3N0SU9NTVVDb250ZXh0ICpob3N0X2ljeDsN
Cj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgICB2dGRfZGV2X2ljeCA9IHZ0ZF9idXMtPmRldl9p
Y3hbZGV2Zm5dOw0KPiA+ID4gPiA+ICsgICAgaWYgKCF2dGRfZGV2X2ljeCkgew0KPiA+ID4gPiA+
ICsgICAgICAgIGdvdG8gb3V0Ow0KPiA+ID4gPiA+ICsgICAgfQ0KPiA+ID4gPiA+ICsgICAgaG9z
dF9pY3ggPSB2dGRfZGV2X2ljeC0+aG9zdF9pY3g7DQo+ID4gPiA+ID4gKyAgICBpZiAoIWhvc3Rf
aWN4KSB7DQo+ID4gPiA+ID4gKyAgICAgICAgZ290byBvdXQ7DQo+ID4gPiA+ID4gKyAgICB9DQo+
ID4gPiA+ID4gKyAgICBpZiAoaG9zdF9pb21tdV9jdHhfZmx1c2hfc3RhZ2UxX2NhY2hlKGhvc3Rf
aWN4LCBzdGFnZTFfY2FjaGUpKSB7DQo+ID4gPiA+ID4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJD
YWNoZSBmbHVzaCBmYWlsZWQiKTsNCj4gPiA+ID4NCj4gPiA+ID4gSSB0aGluayB0aGlzIHNob3Vs
ZCBub3QgZWFzaWx5IGJlIHRyaWdnZXJlZCBieSB0aGUgZ3Vlc3QsIGJ1dCBqdXN0DQo+ID4gPiA+
IGluIGNhc2UuLi4gTGV0J3MgdXNlDQo+ID4gPiA+IGVycm9yX3JlcG9ydF9vbmNlKCkgdG8gYmUg
c2FmZS4NCj4gPiA+DQo+ID4gPiBBZ3JlZWQuDQo+ID4gPg0KPiA+ID4gPiA+ICsgICAgfQ0KPiA+
ID4gPiA+ICtvdXQ6DQo+ID4gPiA+ID4gKyAgICByZXR1cm47DQo+ID4gPiA+ID4gK30NCj4gPiA+
ID4gPiArDQo+ID4gPiA+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCB2dGRfcGFzaWRfY2FjaGVfdmFs
aWQoDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgVlREUEFTSURBZGRyZXNz
U3BhY2UgKnZ0ZF9wYXNpZF9hcykgew0KPiA+ID4gPiA+ICsgICAgcmV0dXJuIHZ0ZF9wYXNpZF9h
cy0+aW9tbXVfc3RhdGUgJiYNCj4gICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eDQo+IA0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGNoZWNrIGNhbiBiZSBkcm9wcGVk
IGJlY2F1c2UgYWx3YXlzIHRydWU/DQo+ID4gPiA+DQo+ID4gPiA+IElmIHlvdSBhZ3JlZSB3aXRo
IGJvdGggdGhlIGNoYW5nZXMsIHBsZWFzZSBhZGQ6DQo+ID4gPiA+DQo+ID4gPiA+IFJldmlld2Vk
LWJ5OiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+ID4gPg0KPiA+ID4gSSB0aGluayB0
aGUgY29kZSBzaG91bGQgZW5zdXJlIGFsbCB0aGUgcGFzaWRfYXMgaW4gaGFzaCB0YWJsZSBpcw0K
PiA+ID4gdmFsaWQuIEFuZCB3ZSBjYW4gc2luY2UgYWxsIHRoZSBvcGVyYXRpb25zIGFyZSB1bmRl
ciBwcm90ZWN0aW9uIG9mIGlvbW11X2xvY2suDQo+ID4gPg0KPiA+IFBldGVyLA0KPiA+DQo+ID4g
SSB0aGluayBteSByZXBseSB3YXMgd3JvbmcuIHBhc2lkX2FzIGluIGhhcyB0YWJsZSBtYXkgYmUg
c3RhbGUgc2luY2UNCj4gPiB0aGUgcGVyIHBhc2lkX2FzIGNhY2hlX2dlbiBtYXkgYmUgbm90IGlk
ZW50aWNhbCB3aXRoIHRoZSBjYWNoZV9nZW4gaW4NCj4gPiBpb21tdV9zdGF0ZS4gZS5nLiB2dGRf
cGFzaWRfY2FjaGVfcmVzZXQoKSBvbmx5IGluY3JlYXNlcyB0aGUgY2FjaGVfZ2VuDQo+ID4gaW4g
aW9tbXVfc3RhdGUuIFNvIHRoZXJlIHdpbGwgYmUgcGFzaWRfYXMgaW4gaGFzaCB0YWJsZSB3aGlj
aCBoYXMNCj4gPiBjYWNoZWQgcGFzaWQgZW50cnkgYnV0IGl0cyBjYWNoZV9nZW4gaXMgbm90IGVx
dWFsIHRvIHRoZSBvbmUgaW4NCj4gPiBpb21tdV9zdGF0ZS4gRm9yIHN1Y2ggcGFzaWRfYXMsIHdl
IHNob3VsZCB0cmVhdCBpdCBhcyBzdGFsZS4NCj4gPiBTbyBJIGd1ZXNzIHRoZSB2dGRfcGFzaWRf
Y2FjaGVfdmFsaWQoKSBpcyBzdGlsbCBuZWNlc3NhcnkuDQo+IA0KPiBJIGd1ZXNzIHlvdSBtaXNy
ZWFkIG15IGNvbW1lbnQuIDopDQo+IA0KPiBJIHdhcyBzYXlpbmcgdGhlICJ2dGRfcGFzaWRfYXMt
PmlvbW11X3N0YXRlIiBjaGVjayBpcyBub3QgbmVlZGVkLCBiZWNhdXNlDQo+IGlvbW11X3N0YXRl
IHdhcyBhbHdheXMgc2V0IGlmIHRoZSBhZGRyZXNzIHNwYWNlIGlzIGNyZWF0ZWQuDQo+IHZ0ZF9w
YXNpZF9jYWNoZV92YWxpZCgpIGlzIG5lZWRlZC4NCg0Kb2ssIEkgc2VlLg0KDQo+IEFsc28sIHBs
ZWFzZSBkb3VibGUgY29uZmlybSB0aGF0IHZ0ZF9wYXNpZF9jYWNoZV9yZXNldCgpIHNob3VsZCBk
cm9wIGFsbCB0aGUNCj4gYWRkcmVzcyBzcGFjZXMgKGFzIEkgdGhpbmsgaXQgc2hvdWxkKSwgbm90
ICJvbmx5IGluY3JlYXNlIHRoZSBjYWNoZV9nZW4iLiANCg0KeWVzLCBJJ20ganVzdCBldmFsdWF0
aW5nIGl0LiB2dGRfcGFzaWRfY2FjaGVfcmVzZXQoKSBzaG91bGQgZHJvcCBhbGwgdGhlDQpwYXNp
ZF9hcyBhbmQgbmVlZCB0byBub3RpZnkgaG9zdCB0byB1bmJpbmQgcGFzaWQuDQoNCj4gSU1ITyB5
b3UNCj4gc2hvdWxkIG9ubHkgaW5jcmVhc2UgdGhlIGNhY2hlX2dlbiBpbiB0aGUgUFNJIGhvb2sg
KHZ0ZF9wYXNpZF9jYWNoZV9wc2koKSkgb25seS4NCg0KSSdtIG5vdCBxdWl0ZSBnZXQgaGVyZS4g
V2h5IGNhY2hlX2dlbiBpbmNyZWFzZSBvbmx5IGhhcHBlbiBpbiBQU0kNCmhvb2s/IEkgdGhpbmsg
Y2FjaGVfZ2VuIHVzZWQgdG8gYXZvaWQgZHJvcCBhbGwgcGFzaWRfYXMgd2hlbiBhIHBhc2lkDQpj
YWNoZSByZXNldCBoYXBwZW5lZC4NCg0KUmVnYXJkcywNCllpIExpdQ0K

