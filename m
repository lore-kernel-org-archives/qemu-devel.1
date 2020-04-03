Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EBAC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8282B2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8282B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNvR-0003sb-GX
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 11:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jKNtl-0001rN-OQ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jKNtj-00045E-9I
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:06:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:47173)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jKNti-00041e-Pr
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:06:19 -0400
IronPort-SDR: kG+1L+BVL1p4H0mc0bI48SkDQLVfMxWPwEe8xJESoBjMvF4uIJPMuHXobwKaYa1ufMAdtg513J
 NP+y6Ye5qwPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2020 08:06:10 -0700
IronPort-SDR: FNX44tLyuxH04vnTh/w+HR7V68tJ7WbChyqU3jcDgg8tMo7993j6jW3VTH8Xr95qiRn3PXTIhQ
 VpxwlLAuSZZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; d="scan'208";a="238906322"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga007.jf.intel.com with ESMTP; 03 Apr 2020 08:06:02 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 08:06:02 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 08:06:01 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.209]) with mapi id 14.03.0439.000;
 Fri, 3 Apr 2020 23:05:57 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v2 13/22] intel_iommu: add PASID cache management
 infrastructure
Thread-Topic: [PATCH v2 13/22] intel_iommu: add PASID cache management
 infrastructure
Thread-Index: AQHWBkpjDlzgAqAO2kCfS3rvS1hmKKhkcUmAgADtXCD///hbAIACJjmw
Date: Fri, 3 Apr 2020 15:05:57 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A220DE7@SHSMSX104.ccr.corp.intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-14-git-send-email-yi.l.liu@intel.com>
 <20200402000225.GC7174@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A21EAAD@SHSMSX104.ccr.corp.intel.com>
 <20200402134436.GI7174@xz-x1>
In-Reply-To: <20200402134436.GI7174@xz-x1>
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
X-Received-From: 192.55.52.115
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

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBB
cHJpbCAyLCAyMDIwIDk6NDUgUE0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEzLzIyXSBpbnRlbF9pb21tdTogYWRkIFBBU0lE
IGNhY2hlIG1hbmFnZW1lbnQNCj4gaW5mcmFzdHJ1Y3R1cmUNCj4gDQo+IE9uIFRodSwgQXByIDAy
LCAyMDIwIGF0IDA2OjQ2OjExQU0gKzAwMDAsIExpdSwgWWkgTCB3cm90ZToNCj4gDQo+IFsuLi5d
DQo+IA0KPiA+ID4gPiArLyoqDQo+ID4gPiA+ICsgKiBUaGlzIGZ1bmN0aW9uIHJlcGxheSB0aGUg
Z3Vlc3QgcGFzaWQgYmluZGluZ3MgdG8gaG90cyBieQ0KPiA+ID4gPiArICogd2Fsa2luZyB0aGUg
Z3Vlc3QgUEFTSUQgdGFibGUuIFRoaXMgZW5zdXJlcyBob3N0IHdpbGwgaGF2ZQ0KPiA+ID4gPiAr
ICogbGF0ZXN0IGd1ZXN0IHBhc2lkIGJpbmRpbmdzLiBDYWxsZXIgc2hvdWxkIGhvbGQgaW9tbXVf
bG9jay4NCj4gPiA+ID4gKyAqLw0KPiA+ID4gPiArc3RhdGljIHZvaWQgdnRkX3JlcGxheV9ndWVz
dF9wYXNpZF9iaW5kaW5ncyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lEQ2FjaGVJbmZvDQo+ID4g
PiA+ICsqcGNfaW5mbykgew0KPiA+ID4gPiArICAgIFZUREhvc3RJT01NVUNvbnRleHQgKnZ0ZF9k
ZXZfaWN4Ow0KPiA+ID4gPiArICAgIGludCBzdGFydCA9IDAsIGVuZCA9IFZURF9IUEFTSURfTUFY
Ow0KPiA+ID4gPiArICAgIHZ0ZF9wYXNpZF90YWJsZV93YWxrX2luZm8gd2Fsa19pbmZvID0gey5m
bGFncyA9IDB9Ow0KPiA+ID4NCj4gPiA+IFNvIHZ0ZF9wYXNpZF90YWJsZV93YWxrX2luZm8gaXMg
c3RpbGwgdXNlZC4gIEkgdGhvdWdodCB3ZSBoYWQNCj4gPiA+IHJlYWNoZWQgYSBjb25zZW5zdXMg
dGhhdCB0aGlzIGNhbiBiZSBkcm9wcGVkPw0KPiA+DQo+ID4geWVhaCwgSSBkaWQgaGF2ZSBjb25z
aWRlcmVkIHlvdXIgc3VnZ2VzdGlvbiBhbmQgcGxhbiB0byBkbyBpdC4gQnV0DQo+ID4gd2hlbiBJ
IHN0YXJ0ZWQgY29kaW5nLCBpdCBsb29rcyBhIGxpdHRsZSBiaXQgd2VpcmQgdG8gbWU6DQo+ID4g
Rm9yIG9uZSwgdGhlcmUgaXMgYW4gaW5wdXQgVlREUEFTSURDYWNoZUluZm8gaW4gdGhpcyBmdW5j
dGlvbi4gSXQgbWF5DQo+ID4gYmUgbmF0dXJlIHRvIHRoaW5rIGFib3V0IHBhc3NpbmcgdGhlIHBh
cmFtZXRlciB0byBmdXJ0aGVyIGNhbGxpbmcNCj4gPiAodnRkX3JlcGxheV9wYXNpZF9iaW5kX2Zv
cl9kZXYoKSkuIEJ1dCwgd2UgY2FuJ3QgZG8gdGhhdC4gVGhlDQo+ID4gdnRkX2J1cy9kZXZmbiBm
aWVsZHMgc2hvdWxkIGJlIGZpbGxlZCB3aGVuIGxvb3BpbmcgdGhlIGFzc2lnbmVkDQo+ID4gZGV2
aWNlcywgbm90IHRoZSBvbmUgcGFzc2VkIGJ5IHZ0ZF9yZXBsYXlfZ3Vlc3RfcGFzaWRfYmluZGlu
Z3MoKSBjYWxsZXIuDQo+IA0KPiBIYWNreSB3YXkgaXMgd2UgY2FuIGRpcmVjdGx5IG1vZGlmeSBW
VERQQVNJRENhY2hlSW5mbyogd2l0aCBidXMvZGV2Zm4gZm9yIHRoZQ0KPiBsb29wLiAgT3RoZXJ3
aXNlIHdlIGNhbiBkdXBsaWNhdGUgdGhlIG9iamVjdCB3aGVuIGxvb3BpbmcsIHNvIHRoYXQgd2Ug
Y2FuIGF2b2lkDQo+IGludHJvZHVjaW5nIGEgbmV3IHN0cnVjdCB3aGljaCBzZWVtcyB0byBjb250
YWluIG1vc3RseSB0aGUgc2FtZSBpbmZvcm1hdGlvbi4NCg0KSSBzZWUuIFBsZWFzZSBzZWUgYmVs
b3cgcmVwbHkuDQoNCj4gPiBGb3IgdHdvLCByZXVzaW5nIHRoZSBWVERQQVNJRENhY2hlSW5mbyBm
b3IgcGFzc2luZyB3YWxrIGluZm8gbWF5DQo+ID4gcmVxdWlyZSB0aGUgZmluYWwgdXNlciBkbyB0
aGUgc2FtZSB0aGluZyBhcyB3aGF0IHRoZQ0KPiA+IHZ0ZF9yZXBsYXlfZ3Vlc3RfcGFzaWRfYmlu
ZGluZ3MoKSBoYXMgZG9uZSBoZXJlLg0KPiANCj4gSSBkb24ndCBzZWUgaXQgaGFwcGVuLCBjb3Vs
ZCB5b3UgZXhwbGFpbj8NCg0KbXkgY29uY2VybiBpcyBhcm91bmQgZmxhZ3MgZmllbGQgaW4gVlRE
UEFTSURDYWNoZUluZm8uIFRoZSBmbGFncyBub3QNCm9ubHkgaW5kaWNhdGVzIHRoZSBpbnZhbGlk
YXRpb24gZ3JhbnVsYXJpdHksIGJ1dCBhbHNvIGluZGljYXRlcyB0aGUNCmZpZWxkIHByZXNlbmNl
LiBlLmcuIFZURF9QQVNJRF9DQUNIRV9ERVZTSSBpbmRpY2F0ZXMgdGhlIHZ0ZF9idXMvZGV2Zm4N
CmZpZWxkcyBhcmUgdmFsaWQuIElmIHJldXNlIGl0IHRvIHBhc3Mgd2FsayBpbmZvIHRvIHZ0ZF9z
bV9wYXNpZF90YWJsZV93YWxrX29uZSwNCml0IHdvdWxkIGJlIG1lYW5pbmdsZXNzIGFzIHZ0ZF9i
dXMvZGV2Zm4gZmllbGRzIGFyZSBhbHdheXMgdmFsaWQuIEJ1dA0KSSdtIGZpbmUgdG8gcmV1c2Ug
aXQncyBtb3JlIHByZWZlcmVkLiBJbnN0ZWFkIG9mIG1vZGlmeWluZyB0aGUgdnRkX2J1cy9kZXZu
DQppbiBWVERQQVNJRENhY2hlSW5mbyosIEknZCByYXRoZXIgdG8gZGVmaW5lIGFub3RoZXIgVlRE
UEFTSURDYWNoZUluZm8gdmFyaWFibGUNCmFuZCBwYXNzIGl0IHRvIHZ0ZF9zbV9wYXNpZF90YWJs
ZV93YWxrX29uZS4gVGhpcyBtYXkgbm90IGFmZmVjdCB0aGUgZnV0dXJlDQpjYWxsZXIgb2YgdnRk
X3JlcGxheV9ndWVzdF9wYXNpZF9iaW5kaW5ncygpIGFzIHZ0ZF9idXMvZGV2Zm4gZmllbGQgYXJl
IG5vdA0KZGVzaWduZWQgdG8gYnJpbmcgc29tZXRoaW5nIGJhY2sgdG8gY2FsbGVyLg0KDQpzdHJ1
Y3QgVlREUEFTSURDYWNoZUluZm8gew0KI2RlZmluZSBWVERfUEFTSURfQ0FDSEVfRk9SQ0VfUkVT
RVQgICAgKDFVTEwgPDwgMCkNCiNkZWZpbmUgVlREX1BBU0lEX0NBQ0hFX0dMT0JBTCAgICAgICAg
ICgxVUxMIDw8IDEpDQojZGVmaW5lIFZURF9QQVNJRF9DQUNIRV9ET01TSSAgICAgICAgICAoMVVM
TCA8PCAyKQ0KI2RlZmluZSBWVERfUEFTSURfQ0FDSEVfUEFTSURTSSAgICAgICAgKDFVTEwgPDwg
MykNCiNkZWZpbmUgVlREX1BBU0lEX0NBQ0hFX0RFVlNJICAgICAgICAgICgxVUxMIDw8IDQpDQog
ICAgdWludDMyX3QgZmxhZ3M7DQogICAgdWludDE2X3QgZG9tYWluX2lkOw0KICAgIHVpbnQzMl90
IHBhc2lkOw0KICAgIFZUREJ1cyAqdnRkX2J1czsNCiAgICB1aW50MTZfdCBkZXZmbjsNCn07IA0K
DQo+ID4NCj4gPiBTbyBrZXB0IHRoZSB2dGRfcGFzaWRfdGFibGVfd2Fsa19pbmZvLg0KPiANCj4g
Wy4uLl0NCj4gDQo+ID4gPiA+ICsvKioNCj4gPiA+ID4gKyAqIFRoaXMgZnVuY3Rpb24gc3luY3Mg
dGhlIHBhc2lkIGJpbmRpbmdzIGJldHdlZW4gZ3Vlc3QgYW5kIGhvc3QuDQo+ID4gPiA+ICsgKiBJ
dCBpbmNsdWRlcyB1cGRhdGluZyB0aGUgcGFzaWQgY2FjaGUgaW4gdklPTU1VIGFuZCB1cGRhdGlu
Zw0KPiA+ID4gPiArdGhlDQo+ID4gPiA+ICsgKiBwYXNpZCBiaW5kaW5ncyBwZXIgZ3Vlc3QncyBs
YXRlc3QgcGFzaWQgZW50cnkgcHJlc2VuY2UuDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gK3N0YXRp
YyB2b2lkIHZ0ZF9wYXNpZF9jYWNoZV9zeW5jKEludGVsSU9NTVVTdGF0ZSAqcywNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lEQ2FjaGVJbmZvICpwY19p
bmZvKSB7DQo+ID4gPiA+ICsgICAgLyoNCj4gPiA+ID4gKyAgICAgKiBSZWdhcmRzIHRvIGEgcGFz
aWQgY2FjaGUgaW52YWxpZGF0aW9uLCBlLmcuIGEgUFNJLg0KPiA+ID4gPiArICAgICAqIGl0IGNv
dWxkIGJlIGVpdGhlciBjYXNlcyBvZiBiZWxvdzoNCj4gPiA+ID4gKyAgICAgKiBhKSBhIHByZXNl
bnQgcGFzaWQgZW50cnkgbW92ZWQgdG8gbm9uLXByZXNlbnQNCj4gPiA+ID4gKyAgICAgKiBiKSBh
IHByZXNlbnQgcGFzaWQgZW50cnkgdG8gYmUgYSBwcmVzZW50IGVudHJ5DQo+ID4gPiA+ICsgICAg
ICogYykgYSBub24tcHJlc2VudCBwYXNpZCBlbnRyeSBtb3ZlZCB0byBwcmVzZW50DQo+ID4gPiA+
ICsgICAgICoNCj4gPiA+ID4gKyAgICAgKiBEaWZmZXJlbnQgaW52YWxpZGF0aW9uIGdyYW51bGFy
aXR5IG1heSBhZmZlY3QgZGlmZmVyZW50IGRldmljZQ0KPiA+ID4gPiArICAgICAqIHNjb3BlIGFu
ZCBwYXNpZCBzY29wZS4gQnV0IGZvciBlYWNoIGludmFsaWRhdGlvbiBncmFudWxhcml0eSwNCj4g
PiA+ID4gKyAgICAgKiBpdCBuZWVkcyB0byBkbyB0d28gc3RlcHMgdG8gc3luYyBob3N0IGFuZCBn
dWVzdCBwYXNpZCBiaW5kaW5nLg0KPiA+ID4gPiArICAgICAqDQo+ID4gPiA+ICsgICAgICogSGVy
ZSBpcyB0aGUgaGFuZGxpbmcgb2YgYSBQU0k6DQo+ID4gPiA+ICsgICAgICogMSkgbG9vcCBhbGwg
dGhlIGV4aXN0aW5nIHZ0ZF9wYXNpZF9hcyBpbnN0YW5jZXMgdG8gdXBkYXRlIHRoZW0NCj4gPiA+
ID4gKyAgICAgKiAgICBhY2NvcmRpbmcgdG8gdGhlIGxhdGVzdCBndWVzdCBwYXNpZCBlbnRyeSBp
biBwYXNpZCB0YWJsZS4NCj4gPiA+ID4gKyAgICAgKiAgICB0aGlzIHdpbGwgbWFrZSBzdXJlIGFm
ZmVjdGVkIGV4aXN0aW5nIHZ0ZF9wYXNpZF9hcyBpbnN0YW5jZXMNCj4gPiA+ID4gKyAgICAgKiAg
ICBjYWNoZWQgdGhlIGxhdGVzdCBwYXNpZCBlbnRyaWVzLiBBbHNvLCBkdXJpbmcgdGhlIGxvb3As
IHRoZQ0KPiA+ID4gPiArICAgICAqICAgIGhvc3Qgc2hvdWxkIGJlIG5vdGlmaWVkIGlmIG5lZWRl
ZC4gZS5nLiBwYXNpZCB1bmJpbmQgb3IgcGFzaWQNCj4gPiA+ID4gKyAgICAgKiAgICB1cGRhdGUu
IFNob3VsZCBiZSBhYmxlIHRvIGNvdmVyIGNhc2UgYSkgYW5kIGNhc2UgYikuDQo+ID4gPiA+ICsg
ICAgICoNCj4gPiA+ID4gKyAgICAgKiAyKSBsb29wIGFsbCBkZXZpY2VzIHRvIGNvdmVyIGNhc2Ug
YykNCj4gPiA+ID4gKyAgICAgKiAgICAtIEZvciBkZXZpY2VzIHdoaWNoIGhhdmUgSG9zdElPTU1V
Q29udGV4dCBpbnN0YW5jZXMsDQo+ID4gPiA+ICsgICAgICogICAgICB3ZSBsb29wIHRoZW0gYW5k
IGNoZWNrIGlmIGd1ZXN0IHBhc2lkIGVudHJ5IGV4aXN0cy4gSWYgeWVzLA0KPiA+ID4gPiArICAg
ICAqICAgICAgaXQgaXMgY2FzZSBjKSwgd2UgdXBkYXRlIHRoZSBwYXNpZCBjYWNoZSBhbmQgYWxz
byBub3RpZnkNCj4gPiA+ID4gKyAgICAgKiAgICAgIGhvc3QuDQo+ID4gPiA+ICsgICAgICogICAg
LSBGb3IgZGV2aWNlcyB3aGljaCBoYXZlIG5vIEhvc3RJT01NVUNvbnRleHQsIGl0IGlzIG5vdA0K
PiA+ID4gPiArICAgICAqICAgICAgbmVjZXNzYXJ5IHRvIGNyZWF0ZSBwYXNpZCBjYWNoZSBhdCB0
aGlzIHBoYXNlIHNpbmNlIGl0DQo+ID4gPiA+ICsgICAgICogICAgICBjb3VsZCBiZSBjcmVhdGVk
IHdoZW4gdklPTU1VIGRvZXMgRE1BIGFkZHJlc3MgdHJhbnNsYXRpb24uDQo+ID4gPiA+ICsgICAg
ICogICAgICBUaGlzIGlzIG5vdCB5ZXQgaW1wbGVtZW50ZWQgc2luY2UgdGhlcmUgaXMgbm8gZW11
bGF0ZWQNCj4gPiA+ID4gKyAgICAgKiAgICAgIHBhc2lkLWNhcGFibGUgZGV2aWNlcyB0b2RheS4g
SWYgd2UgaGF2ZSBzdWNoIGRldmljZXMgaW4NCj4gPiA+ID4gKyAgICAgKiAgICAgIGZ1dHVyZSwg
dGhlIHBhc2lkIGNhY2hlIHNoYWxsIGJlIGNyZWF0ZWQgdGhlcmUuDQo+ID4gPiA+ICsgICAgICog
T3RoZXIgZ3JhbnVsYXJpdHkgZm9sbG93IHRoZSBzYW1lIHN0ZXBzLCBqdXN0IHdpdGggZGlmZmVy
ZW50IHNjb3BlDQo+ID4gPiA+ICsgICAgICoNCj4gPiA+ID4gKyAgICAgKi8NCj4gPiA+ID4gKw0K
PiA+ID4gPiArICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPiA+ID4gPiArICAgIC8qIFN0ZXAgMTog
bG9vcCBhbGwgdGhlIGV4aXNpdG5nIHZ0ZF9wYXNpZF9hcyBpbnN0YW5jZXMgKi8NCj4gPiA+ID4g
KyAgICBnX2hhc2hfdGFibGVfZm9yZWFjaF9yZW1vdmUocy0+dnRkX3Bhc2lkX2FzLA0KPiA+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2dGRfZmx1c2hfcGFzaWQsIHBjX2lu
Zm8pOw0KPiA+ID4NCj4gPiA+IE9LIHRoZSBzZXJpZXMgaXMgZXZvbHZpbmcgYWxvbmcgd2l0aCBv
dXIgZGlzY3Vzc2lvbnMsIGFuZCAvbWUgdG9vIG9uDQo+ID4gPiB1bmRlcnN0YW5kaW5nIHlvdXIg
c2VyaWVzLi4uIE5vdyBJJ20gbm90IHZlcnkgc3VyZSB3aGV0aGVyIHRoaXMgb3BlcmF0aW9uIGlz
IHN0aWxsDQo+IHVzZWZ1bC4uLg0KPiA+ID4NCj4gPiA+IFRoZSBtYWpvciBwb2ludCBpcyB5b3Un
bGwgbmVlZCB0byBkbyBwYXNpZCB0YWJsZSB3YWxrIGZvciBhbGwgdGhlDQo+ID4gPiByZWdpc3Rl
cmVkIGRldmljZXMgYmVsb3cuICBTbyBJSVVDIHZ0ZF9yZXBsYXlfZ3Vlc3RfcGFzaWRfYmluZGlu
Z3MoKQ0KPiA+ID4gd2lsbCBiZSBhYmxlIHRvIGFsc28gZGV0ZWN0IGFkZGl0aW9uLCByZW1vdmFs
IG9yIG1vZGlmaWNhdGlvbiBvZg0KPiA+ID4gcGFzaWQgYWRkcmVzcyBzcGFjZXMuICBBbSBJIHJp
Z2h0Pw0KPiA+DQo+ID4gSXQncyB0cnVlIGlmIHRoZXJlIGlzIG9ubHkgYXNzaWduZWQgcGFzaWQt
Y2FwYWJsZSBkZXZpY2VzLiBJZiB0aGVyZSBpcw0KPiA+IGVtdWFsdGVkIHBhc2lkLWNhcGFibGUg
ZGV2aWNlLCBpdCB3b3VsZCBiZSBhIHByb2JsZW0gYXMgZW11YWx0ZWQNCj4gPiBkZXZpY2VzIHdv
bid0IHJlZ2lzdGVyIEhvc3RJT01NVUNvbnRleHQuIFNvbWVob3csIHRoZSBwYXNpZCBjYWhjZQ0K
PiA+IGludmFsaWRhdGlvbiBmb3IgZW11YWx0ZWQgZGV2aWNlIHdvdWxkIGJlIG1pc3NlZC4gU28g
SSBjaG9zZSB0byBtYWtlDQo+ID4gdGhlIHN0ZXAgMSBjb3ZlciB0aGUgInJlYWwiIGNhY2hlIGlu
dmFsaWRhdGlvbihhLmsuYS4gcmVtb3ZhbCksIHdoaWxlDQo+ID4gc3RlcCAyIHRvIGNvdmVyIGFk
ZGl0aW9uIGFuZCBtb2RpZmljYXRpb24uDQo+IA0KPiBPSy4gIEJ0dywgSSB0aGluayBtb2RpZmlj
YXRpb24gc2hvdWxkIHN0aWxsIGJlbG9uZ3MgdG8gc3RlcCAxIHRoZW4gKEkgdGhpbmsgeW91J3Jl
IGRvaW5nDQo+IHRoYXQsIHRob3VnaCkuDQoNCk9oLCB5ZXMsIG1vZGlmaWNhdGlvbiBpcyBkb25l
IGluIHN0ZXAgMS4uLiBzdGVwIDIgaXMgb25seSBmb3IgYWRkaXRpb24uDQoNClJlZ2FyZHMsDQpZ
aSBMaXUNCg==

