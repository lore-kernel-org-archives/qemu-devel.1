Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BDCC2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 12:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2C2206F5
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 12:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2C2206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKhUL-0007df-M0
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 08:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jKhTM-0006zL-M6
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jKhTK-0007kj-Da
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:00:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:57868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jKhTK-0007hO-50
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:00:22 -0400
IronPort-SDR: s4elcIdFdu1/vdgxO4C63BRfhuukRizcZG3LNC3+4D9sdOP+ItgwGE7E2bqDgSrAY3FIFvG0am
 yLF1oTw7ZxWw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2020 05:00:18 -0700
IronPort-SDR: VZiSYlQZtKxt/GNEzDsLiksw9fcnWEYxpRO2eX9gq36K4saFrHz6Uui23YrzG2BCB1DwWhhi/p
 c1+Fnr4IWJTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,343,1580803200"; d="scan'208";a="239147015"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga007.jf.intel.com with ESMTP; 04 Apr 2020 05:00:17 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 4 Apr 2020 05:00:17 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 4 Apr 2020 05:00:16 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.214]) with mapi id 14.03.0439.000;
 Sat, 4 Apr 2020 20:00:13 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v2 16/22] intel_iommu: replay pasid binds after context
 cache invalidation
Thread-Topic: [PATCH v2 16/22] intel_iommu: replay pasid binds after context
 cache invalidation
Thread-Index: AQHWBkpl2LeZyiHX6UiGnsLGwGyit6hm+m8AgACN3HD//4oJAIABzIUg
Date: Sat, 4 Apr 2020 12:00:12 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A221BD4@SHSMSX104.ccr.corp.intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-17-git-send-email-yi.l.liu@intel.com>
 <20200403144548.GK103677@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A220E44@SHSMSX104.ccr.corp.intel.com>
 <20200403161120.GN103677@xz-x1>
In-Reply-To: <20200403161120.GN103677@xz-x1>
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

SGkgUGV0ZXIsDQoNCj4gRnJvbTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiBTZW50
OiBTYXR1cmRheSwgQXByaWwgNCwgMjAyMCAxMjoxMSBBTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5s
LmxpdUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTYvMjJdIGludGVsX2lv
bW11OiByZXBsYXkgcGFzaWQgYmluZHMgYWZ0ZXIgY29udGV4dCBjYWNoZQ0KPiBpbnZhbGlkYXRp
b24NCj4gDQo+IE9uIEZyaSwgQXByIDAzLCAyMDIwIGF0IDAzOjIxOjEwUE0gKzAwMDAsIExpdSwg
WWkgTCB3cm90ZToNCj4gPiA+IEZyb206IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4g
PiA+IFNlbnQ6IEZyaWRheSwgQXByaWwgMywgMjAyMCAxMDo0NiBQTQ0KPiA+ID4gVG86IExpdSwg
WWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAx
Ni8yMl0gaW50ZWxfaW9tbXU6IHJlcGxheSBwYXNpZCBiaW5kcyBhZnRlciBjb250ZXh0DQo+IGNh
Y2hlDQo+ID4gPiBpbnZhbGlkYXRpb24NCj4gPiA+DQo+ID4gPiBPbiBTdW4sIE1hciAyOSwgMjAy
MCBhdCAwOToyNDo1NVBNIC0wNzAwLCBMaXUgWWkgTCB3cm90ZToNCj4gPiA+ID4gVGhpcyBwYXRj
aCByZXBsYXlzIGd1ZXN0IHBhc2lkIGJpbmRpbmdzIGFmdGVyIGNvbnRleHQgY2FjaGUNCj4gPiA+
ID4gaW52YWxpZGF0aW9uLiBUaGlzIGlzIGEgYmVoYXZpb3IgdG8gZW5zdXJlIHNhZmV0eS4gQWN0
dWFsbHksDQo+ID4gPiA+IHByb2dyYW1tZXIgc2hvdWxkIGlzc3VlIHBhc2lkIGNhY2hlIGludmFs
aWRhdGlvbiB3aXRoIHByb3Blcg0KPiA+ID4gPiBncmFudWxhcml0eSBhZnRlciBpc3N1aW5nIGEg
Y29udGV4dCBjYWNoZSBpbnZhbGlkYXRpb24uDQo+ID4gPiA+DQo+ID4gPiA+IENjOiBLZXZpbiBU
aWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gPiA+ID4gQ2M6IEphY29iIFBhbiA8amFjb2Iu
anVuLnBhbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+IENjOiBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+DQo+ID4gPiA+IENjOiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4N
Cj4gPiA+ID4gQ2M6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQo+ID4gPiA+
IENjOiBSaWNoYXJkIEhlbmRlcnNvbiA8cnRoQHR3aWRkbGUubmV0Pg0KPiA+ID4gPiBDYzogRWR1
YXJkbyBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBMaXUgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGh3
L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDUxDQo+ID4gPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gIGh3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaCB8ICA2ICsrKystDQo+ID4gPiA+ICBody9pMzg2L3RyYWNlLWV2ZW50cyAgICAg
ICAgICAgfCAgMSArDQo+ID4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50
ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+ID4gPiBpbmRleCBkODdmNjA4
Li44ODNhZWFjIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4g
PiA+ID4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gPiA+IEBAIC02OCw2ICs2OCwx
MCBAQCBzdGF0aWMgdm9pZA0KPiA+ID4gdnRkX2FkZHJlc3Nfc3BhY2VfcmVmcmVzaF9hbGwoSW50
ZWxJT01NVVN0YXRlICpzKTsNCj4gPiA+ID4gIHN0YXRpYyB2b2lkIHZ0ZF9hZGRyZXNzX3NwYWNl
X3VubWFwKFZUREFkZHJlc3NTcGFjZSAqYXMsIElPTU1VTm90aWZpZXINCj4gKm4pOw0KPiA+ID4g
Pg0KPiA+ID4gPiAgc3RhdGljIHZvaWQgdnRkX3Bhc2lkX2NhY2hlX3Jlc2V0KEludGVsSU9NTVVT
dGF0ZSAqcyk7DQo+ID4gPiA+ICtzdGF0aWMgdm9pZCB2dGRfcGFzaWRfY2FjaGVfc3luYyhJbnRl
bElPTU1VU3RhdGUgKnMsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBWVERQQVNJRENhY2hlSW5mbyAqcGNfaW5mbyk7DQo+ID4gPiA+ICtzdGF0aWMgdm9pZCB2dGRf
cGFzaWRfY2FjaGVfZGV2c2koSW50ZWxJT01NVVN0YXRlICpzLA0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFZUREJ1cyAqdnRkX2J1cywgdWludDE2X3QgZGV2Zm4p
Ow0KPiA+ID4gPg0KPiA+ID4gPiAgc3RhdGljIHZvaWQgdnRkX3BhbmljX3JlcXVpcmVfY2FjaGlu
Z19tb2RlKHZvaWQpDQo+ID4gPiA+ICB7DQo+ID4gPiA+IEBAIC0xODUzLDcgKzE4NTcsMTAgQEAg
c3RhdGljIHZvaWQNCj4gdnRkX2lvbW11X3JlcGxheV9hbGwoSW50ZWxJT01NVVN0YXRlDQo+ID4g
PiAqcykNCj4gPiA+ID4NCj4gPiA+ID4gIHN0YXRpYyB2b2lkIHZ0ZF9jb250ZXh0X2dsb2JhbF9p
bnZhbGlkYXRlKEludGVsSU9NTVVTdGF0ZSAqcykNCj4gPiA+ID4gIHsNCj4gPiA+ID4gKyAgICBW
VERQQVNJRENhY2hlSW5mbyBwY19pbmZvOw0KPiA+ID4gPiArDQo+ID4gPiA+ICAgICAgdHJhY2Vf
dnRkX2ludl9kZXNjX2NjX2dsb2JhbCgpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICAgICAgLyogUHJv
dGVjdHMgY29udGV4dCBjYWNoZSAqLw0KPiA+ID4gPiAgICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0K
PiA+ID4gPiAgICAgIHMtPmNvbnRleHRfY2FjaGVfZ2VuKys7DQo+ID4gPiA+IEBAIC0xODcwLDYg
KzE4NzcsOSBAQCBzdGF0aWMgdm9pZA0KPiA+ID4gdnRkX2NvbnRleHRfZ2xvYmFsX2ludmFsaWRh
dGUoSW50ZWxJT01NVVN0YXRlICpzKQ0KPiA+ID4gPiAgICAgICAqIFZULWQgZW11bGF0aW9uIGNv
ZGVzLg0KPiA+ID4gPiAgICAgICAqLw0KPiA+ID4gPiAgICAgIHZ0ZF9pb21tdV9yZXBsYXlfYWxs
KHMpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgcGNfaW5mby5mbGFncyA9IFZURF9QQVNJRF9D
QUNIRV9HTE9CQUw7DQo+ID4gPiA+ICsgICAgdnRkX3Bhc2lkX2NhY2hlX3N5bmMocywgJnBjX2lu
Zm8pOw0KPiA+ID4gPiAgfQ0KPiA+ID4gPg0KPiA+ID4gPiAgLyoqDQo+ID4gPiA+IEBAIC0yMDA1
LDYgKzIwMTUsMjIgQEAgc3RhdGljIHZvaWQNCj4gPiA+IHZ0ZF9jb250ZXh0X2RldmljZV9pbnZh
bGlkYXRlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgKiBo
YXBwZW5lZC4NCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgKi8NCj4gPiA+ID4gICAgICAgICAg
ICAgICAgICB2dGRfc3luY19zaGFkb3dfcGFnZV90YWJsZSh2dGRfYXMpOw0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgIC8qDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICogUGVyIHNwZWMsIGNv
bnRleHQgZmx1c2ggc2hvdWxkIGFsc28NCj4gPiA+ID4gZm9sbG93ZWQgd2l0aCBQQVNJRA0KPiA+
ID4gPiArICAgICAgICAgICAgICAgICAqIGNhY2hlIGFuZCBpb3RsYiBmbHVzaC4gUmVnYXJkcyB0
bw0KPiA+ID4gPiBhIGRldmljZSBzZWxlY3RpdmUNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAg
KiBjb250ZXh0IGNhY2hlIGludmFsaWRhdGlvbjoNCj4gPiA+DQo+ID4gPiBJZiBjb250ZXh0IGVu
dHJ5IGZsdXNoIHNob3VsZCBhbHNvIGZvbGxvdyBhbm90aGVyIHBhc2lkIGNhY2hlIGZsdXNoLA0K
PiA+ID4gdGhlbiB0aGlzIGlzIHN0aWxsIG5lZWRlZD8gIFNob3VsZG4ndCB0aGUgcGFzaWQgZmx1
c2ggZG8gdGhlIHNhbWUNCj4gPiA+IHRoaW5nIGFnYWluPw0KPiA+DQo+ID4geWVzLCBidXQgaG93
IGFib3V0IGd1ZXN0IHNvZnR3YXJlIGZhaWxlZCB0byBmb2xsb3cgaXQ/IEl0IHdpbGwgZG8NCj4g
PiB0aGUgc2FtZSB0aGluZyB3aGVuIHBhc2lkIGNhY2hlIGZsdXNoIGNvbWVzLiBCdXQgdGhpcyBv
bmx5IGhhcHBlbnMNCj4gPiBmb3IgdGhlIHJpZDJwYXNpZCBjYXNlICh0aGUgSU9WQSBwYWdlIHRh
YmxlKS4NCj4gDQo+IERvIHlvdSBtZWFuIGl0IHdpbGwgbm90IGhhcHBlbiB3aGVuIG5lc3RlZCBw
YWdlIHRhYmxlIGlzIHVzZWQgKHNvIGl0J3MNCj4gcmVxdWlyZWQgZm9yIG5lc3RlZCB0YWJsZXMp
Pw0KDQpubywgYnkgdGhlIElPVkEgcGFnZSB0YWJsZSBjYXNlLCBJIGp1c3Qgd2FudCB0byBjb25m
aXJtIHRoZSBkdXBsaWNhdGUNCnJlcGxheSBpcyB0cnVlLiBCdXQgaXQgaXMgbm90ICJvbmx5IiBj
YXNlLiA6LSkgbXkgYmFkLiBhbnkgc2NhbGFibGUgbW9kZQ0KY29udGV4dCBlbnRyeSBtb2RpZmlj
YXRpb24gd2lsbCByZXN1bHQgaW4gZHVwbGljYXRlIHJlcGxheSBhcyB0aGlzIHBhdGNoDQplbmZv
cmNlcyBhIHBhc2lkIHJlcGxheSBhZnRlciBjb250ZXh0IGNhY2hlIGludmFsaWRhdGlvbi4gQnV0
IGZvciBub3JtYWwNCmd1ZXN0IFNWTSB1c2FnZSwgaXQgd29uJ3QgaGF2ZSBzdWNoIGR1cGxpY2F0
ZSB3b3JrIGFzIGl0IG9ubHkgbW9kaWZpZXMNCnBhc2lkIGVudHJ5Lg0KDQo+IFllYWggd2UgY2Fu
IGtlZXAgdGhlbSBmb3Igc2FmZSBubyBtYXR0ZXIgd2hhdDsgYXQgbGVhc3QgSSdtIGZpbmUgd2l0
aA0KPiBpdCAoSSBiZWxpZXZlIG1vc3Qgb2YgdGhlIGNvZGUgd2UncmUgZGlzY3Vzc2luZyBpcyBu
b3QgZmFzdCBwYXRoKS4NCj4gSnVzdCB3YW50IHRvIGJlIHN1cmUgb2YgaXQgc2luY2UgaWYgaXQn
cyBkZWZpbml0ZWx5IGR1cGxpY2F0ZWQgdGhlbiB3ZQ0KPiBjYW4gaW5zdGVhZCBkcm9wIGl0Lg0K
DQp5ZXMsIGl0IGlzIG5vdCBmYXN0IHBhdGguIEJUVy4gSSBndWVzcyB0aGUgaW92YSBzaGFkb3cg
c3luYyBhcHBsaWVzDQp0aGUgc2FtZSBub3Rpb24uIHJpZ2h0Pw0KDQpSZWdhcmRzLA0KWWkgTGl1
DQo=

