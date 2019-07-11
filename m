Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FD0C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 08:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333CA20872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 08:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333CA20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlUDn-0004Jo-5H
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 04:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50483)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hlUDI-0003uf-F3
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 04:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hlUDH-0004Z6-6P
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 04:14:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:21236)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hlUDG-0004Vl-Sl
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 04:13:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Jul 2019 01:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; d="scan'208";a="364742387"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2019 01:13:55 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jul 2019 01:13:55 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jul 2019 01:13:54 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.110]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.134]) with mapi id 14.03.0439.000;
 Thu, 11 Jul 2019 16:13:51 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <zhexu@redhat.com>
Thread-Topic: [RFC v1 11/18] intel_iommu: create VTDAddressSpace per BDF+PASID
Thread-Index: AQHVM+yrBZlmLzzpm0uvJxEFyEF+iabBVBeAgAO6QOA=
Date: Thu, 11 Jul 2019 08:13:51 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439F2C862@SHSMSX104.ccr.corp.intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-12-git-send-email-yi.l.liu@intel.com>
 <20190709063915.GG5178@xz-x1>
In-Reply-To: <20190709063915.GG5178@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjNhMzM2YzAtZTU3OS00NTExLWEzZGQtOGQyOWNhMDBkM2UxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS2IzaElCU2w1UTdZa2djV3lVZUd2QnBITEJUVVlGUVdab2xuQ3p5d3M2MTNKbGZuK2JvZ2txdTNQbHhrVk1lbyJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [RFC v1 11/18] intel_iommu: create VTDAddressSpace
 per BDF+PASID
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
Cc: "tianyu.lan@intel.com" <tianyu.lan@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
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

PiBGcm9tOiBrdm0tb3duZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86a3ZtLW93bmVyQHZnZXIu
a2VybmVsLm9yZ10gT24gQmVoYWxmDQo+IE9mIFBldGVyIFh1DQo+IFNlbnQ6IFR1ZXNkYXksIEp1
bHkgOSwgMjAxOSAyOjM5IFBNDQo+IFRvOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtSRkMgdjEgMTEvMThdIGludGVsX2lvbW11OiBjcmVhdGUgVlREQWRk
cmVzc1NwYWNlIHBlciBCREYrUEFTSUQNCj4gDQo+IE9uIEZyaSwgSnVsIDA1LCAyMDE5IGF0IDA3
OjAxOjQ0UE0gKzA4MDAsIExpdSBZaSBMIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+ID4gKy8q
Kg0KPiA+ICsgKiBUaGlzIGZ1bmN0aW9uIGZpbmRzIG9yIGFkZHMgYSBWVERBZGRyZXNzU3BhY2Ug
Zm9yIGEgZGV2aWNlIHdoZW4NCj4gPiArICogaXQgaXMgYm91bmQgdG8gYSBwYXNpZA0KPiA+ICsg
Ki8NCj4gPiArc3RhdGljIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FkZF9maW5kX3Bhc2lkX2FzKElu
dGVsSU9NTVVTdGF0ZSAqcywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFBDSUJ1cyAqYnVzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaW50IGRldmZuLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGFsbG9jYXRlKQ0KPiA+
ICt7DQo+ID4gKyAgICBjaGFyIGtleVszMl07DQo+ID4gKyAgICBjaGFyICpuZXdfa2V5Ow0KPiA+
ICsgICAgVlREQWRkcmVzc1NwYWNlICp2dGRfcGFzaWRfYXM7DQo+ID4gKyAgICB1aW50MTZfdCBz
aWQ7DQo+ID4gKw0KPiA+ICsgICAgc2lkID0gdnRkX21ha2Vfc291cmNlX2lkKHBjaV9idXNfbnVt
KGJ1cyksIGRldmZuKTsNCj4gPiArICAgIHZ0ZF9nZXRfcGFzaWRfa2V5KCZrZXlbMF0sIDMyLCBw
YXNpZCwgc2lkKTsNCj4gPiArICAgIHZ0ZF9wYXNpZF9hcyA9IGdfaGFzaF90YWJsZV9sb29rdXAo
cy0+dnRkX3Bhc2lkX2FzLCAma2V5WzBdKTsNCj4gPiArDQo+ID4gKyAgICBpZiAoIXZ0ZF9wYXNp
ZF9hcyAmJiBhbGxvY2F0ZSkgew0KPiA+ICsgICAgICAgIG5ld19rZXkgPSBnX21hbGxvYygzMik7
DQo+ID4gKyAgICAgICAgdnRkX2dldF9wYXNpZF9rZXkoJm5ld19rZXlbMF0sIDMyLCBwYXNpZCwg
c2lkKTsNCj4gPiArICAgICAgICAvKg0KPiA+ICsgICAgICAgICAqIEluaXRpYXRlIHRoZSB2dGRf
cGFzaWRfYXMgc3RydWN0dXJlLg0KPiA+ICsgICAgICAgICAqDQo+ID4gKyAgICAgICAgICogVGhp
cyBzdHJ1Y3R1cmUgaGVyZSBpcyB1c2VkIHRvIHRyYWNrIHRoZSBndWVzdCBwYXNpZA0KPiA+ICsg
ICAgICAgICAqIGJpbmRpbmcgYW5kIGFsc28gc2VydmVzIGFzIHBhc2lkLWNhY2hlIG1hbmdlbWVu
dCBlbnRyeS4NCj4gPiArICAgICAgICAgKg0KPiA+ICsgICAgICAgICAqIFRPRE86IGluIGZ1dHVy
ZSwgaWYgd2FudHMgdG8gc3VwcG9ydCB0aGUgU1ZBLWF3YXJlIERNQQ0KPiA+ICsgICAgICAgICAq
ICAgICAgIGVtdWxhdGlvbiwgdGhlIHZ0ZF9wYXNpZF9hcyBzaG91bGQgYmUgZnVsbHkgaW5pdGlh
bGl6ZWQuDQo+ID4gKyAgICAgICAgICogICAgICAgZS5nLiB0aGUgYWRkcmVzc19zcGFjZSBhbmQg
bWVtb3J5IHJlZ2lvbiBmaWVsZHMuDQo+ID4gKyAgICAgICAgICovDQo+IA0KPiBJJ20gbm90IHZl
cnkgc3VyZSBhYm91dCB0aGlzIHBhcnQuICBJTUhPIGFsbCB0aG9zZSBtZW1vcnkgcmVnaW9ucyBh
cmUNCj4gdXNlZCB0byBpbmxheSB0aGUgd2hvbGUgSU9NTVUgaWRlYSBpbnRvIFFFTVUncyBtZW1v
cnkgQVBJIGZyYW1ld29yay4NCj4gTm93IGV2ZW4gd2l0aG91dCB0aGUgd2hvbGUgUEFTSUQgc3Vw
cG9ydCB3ZSd2ZSBhbHJlYWR5IGhhdmUgYSB3b3JrYWJsZQ0KPiB2dGRfaW9tbXVfdHJhbnNsYXRl
KCkgdGhhdCB3aWxsIGludGVyY2VwdCBkZXZpY2UgRE1BIG9wZXJhdGlvbnMgYW5kIHdlDQo+IGNh
biB0cnkgdG8gdHJhbnNsYXRlIHRoZSBJT1ZBIHRvIGFueXRoaW5nIHdlIHdhbnQuICBOb3cgdGhl
IGlvbW11X2lkeA0KPiBwYXJhbWV0ZXIgb2YgdnRkX2lvbW11X3RyYW5zbGF0ZSgpIGlzIG5ldmVy
IHVzZWQgKEknZCBzYXkgdW50aWwgbm93IEkNCj4gc3RpbGwgZG9uJ3Qgc3VyZSBvbiB3aGV0aGVy
IHRoZSAiaW9tbXVfaWR4IiBpZGVhIGlzIHRoZSBiZXN0IHdlIGNhbg0KPiBoYXZlLi4uIEkndmUg
dHJpZWQgdG8gZGViYXRlIG9uIHRoYXQgYnV0Li4uIGFueXdheSBJIGFzc3VtZSBmb3IgSW50ZWwN
Cj4gd2UgY2FuIHRoaW5rIGl0IGFzIHRoZSAicGFzaWQiIGluZm9ybWF0aW9uIG9yIGF0IGxlYXN0
IGNvbnRhaW5zIGl0KSwNCj4gaG93ZXZlciBpbiB0aGUgZnVydGhlciB3ZSBjYW4gaGF2ZSB0aGF0
IFBBU0lEL2lvbW11X2lkeC93aGF0ZXZlcg0KPiBwYXNzZWQgaW50byB0aGlzIHRyYW5zbGF0ZSgp
IGZ1bmN0aW9uIHRvbywgdGhlbiB3ZSBjYW4gd2FsayB0aGUgMXN0DQo+IGxldmVsIHBhZ2UgdGFi
bGUgdGhlcmUgaWYgd2UgZm91bmQgdGhhdCB0aGlzIGRldmljZSBoYWQgZW5hYmxlZCB0aGUNCj4g
MXN0IGxldmVsIG1hcHBpbmcgKG9yIGV2ZW4gbmVzdGVkKS4gIEkgZG9uJ3Qgc2VlIHdoYXQgZWxz
ZSB3ZSBuZWVkIHRvDQo+IGRvIHRvIHBsYXkgd2l0aCBleHRyYSBtZW1vcnkgcmVnaW9ucy4NCg0K
Tm90IHN1cmUgaWYgcGFzc2luZyBhIFBBU0lEIHRvIHRyYW5zbGF0ZSgpIGZ1bmN0aW9uIGlzIGdv
b2Qgc2luY2Ugd2UgbWF5DQpuZWVkIHRvIHBhc3MgUEFTSUQgcGFyYW1ldGVyIHRocm91Z2ggYWxs
IHRoZSBRRU1VIEFkZHJlc3NTcGFjZSByZWFkLw0Kd3JpdGUgc3RhY2suDQoNCkFjdHVhbGx5LCBJ
IGRpZCBzb21lIGV4cGVyaW1lbnQgd2l0aCBhIHNpbXBsZSBlbXVsYXRlZCBTVkEtY2FwYWJsZSBk
ZXZpY2UNCnNvbWUgdGltZSBhZ28gKG5vIGlvbW11X2lkeCBhdCB0aGF0IHRpbWUpLiBQZXIgbXkg
dW5kZXJzdGFuZGluZywgYQ0KU1ZBIGNhcGFibGUgZGV2aWNlIG1vZGVsIG5lZWRzIHRvIGZldGNo
IGFuIEFkZHJlc3NTcGFjZSB3aXRoIGEgUEFTSUQNCmFuZCB0aGVuIGNhbGwgZG1hX21lbW9yeV9y
dygpIHdoaWNoIHdpbGwgaW52b2tlIHRoZSBRRU1VIEFkZHJlc3NTcGFjZQ0KcmVhZC93cml0ZSBz
dGFjaywgdGhlbiBmaW5hbGx5IGNhbGwgaW50byB2dGRfaW9tbXVfdHJhbnNsYXRlKCksIGFuZCBp
bg0KdHJhbnNsYXRlKCkgd2UgY2FuIGdldCB0aGUgVlREQWRkcmVzc1NwYWNlIGluc3RhbmNlIGFu
ZCBpdCBoYXMgYSBmbGFnDQoicGFzaWRfYWxsb2NhdGVkIi4gSWYgaXQgaXMgdHJ1ZSwgdHJhbnNs
YXRlIHRoZSBpbnB1dCBhZGRyZXNzIHdpdGggcGFnZSB0YWJsZQ0KYmVoaW5kIHRoZSBQQVNJRCBm
cm9tIHRoZSAicGFzaWQiIGZpZWxkIGluIFZUREFkZHJlc3NTcGFjZS4gSSBndWVzcyB0aGlzDQpt
YXkgaW50cm9kdWNlIHRoZSBsZWFzdCBjaGFuZ2VzIHRvIGV4aXN0aW5nIGxvZ2ljLg0KDQo+IA0K
PiBDb25jbHVzaW9uOiBJIGZlZWwgbGlrZSBTVkEgY2FuIHVzZSBpdHMgb3duIHN0cnVjdHVyZSBo
ZXJlIGluc3RlYWQgb2YNCj4gcmV1c2luZyBWVERBZGRyZXNzU3BhY2UsIGJlY2F1c2UgSSB0aGlu
ayB0aG9zZSBtZW1vcnkgcmVnaW9ucyBjYW4NCj4gcHJvYmFibHkgYmUgdXNlbGVzcy4gIEV2ZW4g
aXQgd2lsbCwgd2UgY2FuIHJlZmFjdG9yIHRoZSBjb2RlIGxhdGVyLA0KPiBidXQgSSByZWFsbHkg
ZG91YnQgaXQuLi4NCg0KSG1tbSwgcmlnaHQsIGV2ZW4gbmVjZXNzYXJ5LCBTVkEgd2lsbCByZXF1
aXJlIGxlc3MgbWVtb3J5IHJlZ2lvbnMuIEkgY2FuDQpzd2l0Y2ggdG8gdXNlIGEgc3RydWN0dXJl
IG5hbWVkIFZURFBBU0lEQWRkcmVzc1NwYWNlIG9yIGFsaWtlLg0KDQpUaGFua3MsDQpZaSBMaXUN
Cg0KPiA+ICsgICAgICAgIHZ0ZF9wYXNpZF9hcyA9IGdfbWFsbG9jMChzaXplb2YoVlREQWRkcmVz
c1NwYWNlKSk7DQo+ID4gKyAgICAgICAgdnRkX3Bhc2lkX2FzLT5pb21tdV9zdGF0ZSA9IHM7DQo+
ID4gKyAgICAgICAgdnRkX3Bhc2lkX2FzLT5idXMgPSBidXM7DQo+ID4gKyAgICAgICAgdnRkX3Bh
c2lkX2FzLT5kZXZmbiA9IGRldmZuOw0KPiA+ICsgICAgICAgIHZ0ZF9wYXNpZF9hcy0+Y29udGV4
dF9jYWNoZV9lbnRyeS5jb250ZXh0X2NhY2hlX2dlbiA9IDA7DQo+ID4gKyAgICAgICAgdnRkX3Bh
c2lkX2FzLT5wYXNpZCA9IHBhc2lkOw0KPiA+ICsgICAgICAgIHZ0ZF9wYXNpZF9hcy0+cGFzaWRf
YWxsb2NhdGVkID0gdHJ1ZTsNCj4gPiArICAgICAgICB2dGRfcGFzaWRfYXMtPnBhc2lkX2NhY2hl
X2VudHJ5LnBhc2lkX2NhY2hlX2dlbiA9IDA7DQo+ID4gKyAgICAgICAgZ19oYXNoX3RhYmxlX2lu
c2VydChzLT52dGRfcGFzaWRfYXMsIG5ld19rZXksIHZ0ZF9wYXNpZF9hcyk7DQo+ID4gKyAgICB9
DQo+ID4gKyAgICByZXR1cm4gdnRkX3Bhc2lkX2FzOw0KPiA+ICt9DQo+IA0KPiBSZWdhcmRzLA0K
PiANCj4gLS0NCj4gUGV0ZXIgWHUNCg==

