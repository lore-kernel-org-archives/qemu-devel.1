Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17159C74A42
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 06:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E313120838
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 06:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E313120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlSUc-0004JT-71
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 02:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42540)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hlSTX-00031Q-35
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 02:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hlSTW-0004rx-1K
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 02:22:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:41863)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hlSTV-0004oS-Nr
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 02:22:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jul 2019 23:22:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; d="scan'208";a="249688252"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga001.jf.intel.com with ESMTP; 10 Jul 2019 23:22:34 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 23:22:33 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.110]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.3]) with mapi id 14.03.0439.000;
 Thu, 11 Jul 2019 14:22:25 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <zhexu@redhat.com>
Thread-Topic: [RFC v1 09/18] intel_iommu: process pasid cache invalidation
Thread-Index: AQHVM+ypbPCEP53jKkOJyUhyWGWM7abBNOaAgAPE2+A=
Date: Thu, 11 Jul 2019 06:22:25 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439F2C5DE@SHSMSX104.ccr.corp.intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-10-git-send-email-yi.l.liu@intel.com>
 <20190709044737.GE5178@xz-x1>
In-Reply-To: <20190709044737.GE5178@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTUzZTQwNzEtNTEyNC00ZmJhLTgzYjgtZWU5MzFhMzIwZWY2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTUgxTFhwNE15Y3FwYVQ3cjM1NWhicWZRcDFyT05ia1JjdzhLTUN6MVd4eFBBN1BpRmhaaWpoUDlyalF5WjNpaiJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [RFC v1 09/18] intel_iommu: process pasid cache
 invalidation
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
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnpoZXh1QHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNk
YXksIEp1bHkgOSwgMjAxOSAxMjo0OCBQTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRl
bC5jb20+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IG1zdEByZWRoYXQuY29tOyBwYm9u
emluaUByZWRoYXQuY29tOw0KPiBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgZXJpYy5hdWdl
ckByZWRoYXQuY29tOw0KPiBkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXU7IHRpYW55dS5sYW5A
aW50ZWwuY29tOyBUaWFuLCBLZXZpbg0KPiA8a2V2aW4udGlhbkBpbnRlbC5jb20+OyBUaWFuLCBK
dW4gSiA8anVuLmoudGlhbkBpbnRlbC5jb20+OyBTdW4sIFlpIFkNCj4gPHlpLnkuc3VuQGludGVs
LmNvbT47IGt2bUB2Z2VyLmtlcm5lbC5vcmc7IEphY29iIFBhbg0KPiA8amFjb2IuanVuLnBhbkBs
aW51eC5pbnRlbC5jb20+OyBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtSRkMgdjEgMDkvMThdIGludGVsX2lvbW11OiBwcm9jZXNzIHBhc2lkIGNhY2hl
IGludmFsaWRhdGlvbg0KPiANCj4gT24gRnJpLCBKdWwgMDUsIDIwMTkgYXQgMDc6MDE6NDJQTSAr
MDgwMCwgTGl1IFlpIEwgd3JvdGU6DQo+ID4gK3N0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX3Bhc2lk
X2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFZUREludkRlc2MgKmludl9kZXNjKSB7DQo+ID4gKyAgICBpZiAoKGludl9kZXNj
LT52YWxbMF0gJiBWVERfSU5WX0RFU0NfUEFTSURDX1JTVkRfVkFMMCkgfHwNCj4gPiArICAgICAg
ICAoaW52X2Rlc2MtPnZhbFsxXSAmIFZURF9JTlZfREVTQ19QQVNJRENfUlNWRF9WQUwxKSB8fA0K
PiA+ICsgICAgICAgIChpbnZfZGVzYy0+dmFsWzJdICYgVlREX0lOVl9ERVNDX1BBU0lEQ19SU1ZE
X1ZBTDIpIHx8DQo+ID4gKyAgICAgICAgKGludl9kZXNjLT52YWxbM10gJiBWVERfSU5WX0RFU0Nf
UEFTSURDX1JTVkRfVkFMMykpIHsNCj4gPiArICAgICAgICB0cmFjZV92dGRfaW52X2Rlc2MoIm5v
bi16ZXJvLWZpZWxkLWluLXBjX2ludl9kZXNjIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGludl9kZXNjLT52YWxbMV0sIGludl9kZXNjLT52YWxbMF0pOw0KPiANCj4gVGhlIGZp
cnN0IHBhcmFtZXRlciBvZiB0cmFjZV92dGRfaW52X2Rlc2MoKSBzaG91bGQgYmUgdGhlIHR5cGUu
DQo+IA0KPiBDYW4gdXNlIGVycm9yX3JlcG9ydF9vbmNlKCkgaGVyZS4NCg0KSSB0aGluayBzbywg
bGV0IG1lIHN3aXRjaCB0byB1c2UgaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+ID4gKyAgICAgICAg
cmV0dXJuIGZhbHNlOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIHN3aXRjaCAoaW52X2Rl
c2MtPnZhbFswXSAmIFZURF9JTlZfREVTQ19QQVNJRENfRykgew0KPiA+ICsgICAgY2FzZSBWVERf
SU5WX0RFU0NfUEFTSURDX0RTSToNCj4gPiArICAgICAgICBicmVhazsNCj4gPiArDQo+ID4gKyAg
ICBjYXNlIFZURF9JTlZfREVTQ19QQVNJRENfUEFTSURfU0k6DQo+ID4gKyAgICAgICAgYnJlYWs7
DQo+ID4gKw0KPiA+ICsgICAgY2FzZSBWVERfSU5WX0RFU0NfUEFTSURDX0dMT0JBTDoNCj4gPiAr
ICAgICAgICBicmVhazsNCj4gPiArDQo+ID4gKyAgICBkZWZhdWx0Og0KPiA+ICsgICAgICAgIHRy
YWNlX3Z0ZF9pbnZfZGVzYygiaW52YWxpZC1pbnYtZ3JhbnUtaW4tcGNfaW52X2Rlc2MiLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW52X2Rlc2MtPnZhbFsxXSwgaW52X2Rlc2Mt
PnZhbFswXSk7DQo+IA0KPiBIZXJlIHRvby4NCg0KR290IGl0Lg0KDQpUaGFua3MsDQpZaSBMaXUN
Cg0KPiA+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAg
ICByZXR1cm4gdHJ1ZTsNCj4gPiArfQ0KPiANCj4gUmVnYXJkcywNCj4gDQo+IC0tDQo+IFBldGVy
IFh1DQo=

