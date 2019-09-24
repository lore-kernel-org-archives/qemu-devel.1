Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FE0C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 02:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7967A206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 02:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7967A206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCaAg-0008Mu-HM
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 22:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iCa9w-0007xe-Vo
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 22:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iCa9v-0004wT-3Y
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 22:02:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:50997)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iCa9u-0004si-PR
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 22:02:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Sep 2019 19:02:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,542,1559545200"; d="scan'208";a="182753489"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga008.jf.intel.com with ESMTP; 23 Sep 2019 19:02:20 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Sep 2019 19:02:20 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Sep 2019 19:02:20 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.146]) with mapi id 14.03.0439.000;
 Tue, 24 Sep 2019 10:02:18 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: RE: [Qemu-devel] vhost, iova, and dirty page tracking
Thread-Topic: [Qemu-devel] vhost, iova, and dirty page tracking
Thread-Index: AdVsLg/AAnCsYtAES/qfxc77B9v7gf//8I+A//3tsaCAA8b/gP/+jHxggAK7doD//1RiwAA9GJkAAAkwmQAAAXN8gAAAR/kAAAB+N4D//2+WgP//IMoA//z7YsD/+lDngP/tyhIw
Date: Tue, 24 Sep 2019 02:02:17 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D58C8B9@SHSMSX104.ccr.corp.intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
 <8302a4ae-1914-3046-b3b5-b3234d7dda02@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B1D1@SHSMSX104.ccr.corp.intel.com>
 <6d73572e-1e89-b04a-bdd6-98ac73798083@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B90C@SHSMSX104.ccr.corp.intel.com>
 <204219fa-ee72-ca60-52a4-fb4bbc887773@redhat.com>
 <20190919052819.GA18391@joy-OptiPlex-7040>
 <7b6d6343-33de-ebd7-9846-af54a45a82a2@redhat.com>
 <20190919061756.GB18391@joy-OptiPlex-7040>
 <e0efbdc0-aad9-0d17-ec68-36460865501f@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57DD2A@SHSMSX104.ccr.corp.intel.com>
 <1ec55b2e-6a59-f1df-0604-5b524da0f001@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D587E3C@SHSMSX104.ccr.corp.intel.com>
 <51578ae6-cc36-3b1a-9184-70a847e58712@redhat.com>
In-Reply-To: <51578ae6-cc36-3b1a-9184-70a847e58712@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTNjNGUwZmYtMDBkYi00NjljLWEwZjctYjMzYzJjOTEyNjAwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRUNkOHVZNXNkbVBLMEdBQ2Y2WHErWWs2WElzUjh1TldBZm1ZcUxsRlBRUHJ3endaT25sbVdENUNCeGVQMFA0OSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: Adalbert Lazar <alazar@bitdefender.com>,
 'Alex Williamson' <alex.williamson@redhat.com>,
 "tamas@tklengyel.com" <tamas@tklengyel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gU2VudDog
RnJpZGF5LCBTZXB0ZW1iZXIgMjAsIDIwMTkgOToxOSBBTQ0KPiANCj4gT24gMjAxOS85LzIwIOS4
iuWNiDY6NTQsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBQYW9sbyBCb256aW5pIFtt
YWlsdG86cGJvbnppbmlAcmVkaGF0LmNvbV0NCj4gPj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJl
ciAxOSwgMjAxOSA3OjE0IFBNDQo+ID4+DQo+ID4+IE9uIDE5LzA5LzE5IDA5OjE2LCBUaWFuLCBL
ZXZpbiB3cm90ZToNCj4gPj4+Pj4gd2h5IEdQQTEgYW5kIEdQQTIgc2hvdWxkIGJlIGJvdGggZGly
dHk/DQo+ID4+Pj4+IGV2ZW4gdGhleSBoYXZlIHRoZSBzYW1lIEhWQSBkdWUgdG8gb3ZlcmxhcGlu
ZyB2aXJ0dWFsIGFkZHJlc3MNCj4gc3BhY2UNCj4gPj4gaW4NCj4gPj4+Pj4gdHdvIHByb2Nlc3Nl
cywgdGhleSBzdGlsbCBjb3JyZXNwb25kIHRvIHR3byBwaHlzaWNhbCBwYWdlcy4NCj4gPj4+Pj4g
ZG9uJ3QgZ2V0IHdoYXQncyB5b3VyIG1lYW5pbmcgOikNCj4gPj4+PiBUaGUgcG9pbnQgaXMgbm90
IGxlYXZlIGFueSBjb3JuZXIgY2FzZSB0aGF0IGlzIGhhcmQgdG8gZGVidWcgb3IgZml4IGluDQo+
ID4+Pj4gdGhlIGZ1dHVyZS4NCj4gPj4+Pg0KPiA+Pj4+IExldCdzIGp1c3Qgc3RhcnQgYnkgYSBz
aW5nbGUgcHJvY2VzcywgdGhlIEFQSSBhbGxvd3MgdXNlcnNwYWNlIHRvIG1hcHMNCj4gPj4+PiBI
VkEgdG8gYm90aCBHUEExIGFuZCBHUEEyLiBTaW5jZSBpdCBrbm93cyBHUEExIGFuZCBHUEEyIGFy
ZQ0KPiA+PiBlcXVpdmFsZW50LA0KPiA+Pj4+IGl0J3Mgb2sgdG8gc3luYyBqdXN0IHRocm91Z2gg
R1BBMS4gVGhhdCBtZWFucyBpZiB5b3Ugb25seSBsb2cgR1BBMiwgaXQNCj4gPj4+PiB3b24ndCB3
b3JrLg0KPiA+Pj4gSSBub3RlZCBLVk0gaXRzZWxmIGRvZXNuJ3QgY29uc2lkZXIgc3VjaCBzaXR1
YXRpb24gKG9uZSBIVkEgaXMgbWFwcGVkDQo+ID4+PiB0byBtdWx0aXBsZSBHUEFzKSwgd2hlbiBk
b2luZyBpdHMgZGlydHkgcGFnZSB0cmFja2luZy4gSWYgeW91IGxvb2sgYXQNCj4gPj4+IGt2bV92
Y3B1X21hcmtfcGFnZV9kaXJ0eSwgaXQgc2ltcGx5IGZpbmRzIHRoZSB1bmlxdWUgbWVtc2xvdCB3
aGljaA0KPiA+Pj4gY29udGFpbnMgdGhlIGRpcnR5IGdmbiBhbmQgdGhlbiBzZXQgdGhlIGRpcnR5
IGJpdCB3aXRoaW4gdGhhdCBzbG90LiBJdA0KPiA+Pj4gZG9lc24ndCBhdHRlbXB0IHRvIHdhbGsg
YWxsIG1lbXNsb3RzIHRvIGZpbmQgb3V0IGFueSBvdGhlciBHUEEgd2hpY2gNCj4gPj4+IG1heSBi
ZSBtYXBwZWQgdG8gdGhlIHNhbWUgSFZBLg0KPiA+Pj4NCj4gPj4+IFNvIHRoZXJlIG11c3QgYmUg
c29tZSBkaXNjb25uZWN0IGhlcmUuIGxldCdzIGhlYXIgZnJvbSBQYW9sbyBmaXJzdCBhbmQNCj4g
Pj4+IHVuZGVyc3RhbmQgdGhlIHJhdGlvbmFsZSBiZWhpbmQgc3VjaCBzaXR1YXRpb24uDQo+ID4+
IEluIGdlbmVyYWwsIHVzZXJzcGFjZSBjYW5ub3QgYXNzdW1lIHRoYXQgaXQncyBva2F5IHRvIHN5
bmMganVzdCB0aHJvdWdoDQo+ID4+IEdQQTEuICBJdCBtdXN0IHN5bmMgdGhlIGhvc3QgcGFnZSBp
ZiAqZWl0aGVyKiBHUEExIG9yIEdQQTIgYXJlIG1hcmtlZA0KPiA+PiBkaXJ0eS4NCj4gPiBBZ3Jl
ZS4gSW4gdGhpcyBjYXNlIHRoZSBrZXJuZWwgb25seSBuZWVkcyB0byB0cmFjayB3aGV0aGVyIEdQ
QTEgb3INCj4gPiBHUEEyIGlzIGRpcnRpZWQgYnkgZ3Vlc3Qgb3BlcmF0aW9ucy4NCj4gDQo+IA0K
PiBOb3QgbmVjZXNzYXJpbHkgZ3Vlc3Qgb3BlcmF0aW9ucy4NCj4gDQo+IA0KPiA+ICAgVGhlIHJl
YXNvbiB3aHkgdmhvc3QgaGFzIHRvDQo+ID4gc2V0IGJvdGggR1BBMSBhbmQgR1BBMiBpcyBkdWUg
dG8gaXRzIG93biBkZXNpZ24gLSBpdCBtYWludGFpbnMNCj4gPiBJT1ZBLT5IVkEgYW5kIEdQQS0+
SFZBIG1hcHBpbmdzIHRodXMgZ2l2ZW4gYSBJT1ZBIHlvdSBoYXZlDQo+ID4gdG8gcmV2ZXJzZSBs
b29rdXAgR1BBLT5IVkEgbWVtVGFibGUgd2hpY2ggZ2l2ZXMgbXVsdGlwbGUgcG9zc2libGUNCj4g
PiBHUEFzLg0KPiANCj4gDQo+IFNvIGlmIHVzZXJzcGFjZSBuZWVkIHRvIHRyYWNrIGJvdGggR1BB
MSBhbmQgR1BBMiwgdmhvc3QgY2FuIGp1c3Qgc3RvcA0KPiB3aGVuIGl0IGZvdW5kIGEgb25lIEhW
QS0+R1BBIG1hcHBpbmcgdGhlcmUuDQo+IA0KPiANCj4gPiAgIEJ1dCBpbiBjb25jZXB0IGlmIHZo
b3N0IGNhbiBtYWludGFpbiBhIElPVkEtPkdQQSBtYXBwaW5nLA0KPiA+IHRoZW4gaXQgaXMgc3Ry
YWlnaHRmb3J3YXJkIHRvIHNldCB0aGUgcmlnaHQgR1BBIGV2ZXJ5IHRpbWUgd2hlbiBhIElPVkEN
Cj4gPiBpcyB0cmFja2VkLg0KPiANCj4gDQo+IFRoYXQgbWVhbnMsIHRoZSB0cmFuc2xhdGlvbiBp
cyBkb25lIHR3aWNlIGJ5IHNvZnR3YXJlLCBJT1ZBLT5HUEEgYW5kDQo+IEdQQS0+SFZBIGZvciBl
YWNoIHBhY2tldC4NCj4gDQo+IFRoYW5rcw0KPiANCg0KeWVzLCBpdCdzIG5vdCBuZWNlc3Nhcnkg
aWYgd2UgY2FyZSBhYm91dCBvbmx5IHRoZSBjb250ZW50IG9mIHRoZSBkaXJ0eSBHUEEsDQphcyBz
ZWVuIGluIGxpdmUgbWlncmF0aW9uLiBJbiB0aGF0IGNhc2UsIGp1c3Qgc2V0dGluZyB0aGUgZmly
c3QgR1BBIGluIHRoZSBsb29wDQppcyBzdWZmaWNpZW50IGFzIHlvdSBwb2ludGVkIG91dC4gSG93
ZXZlciB0aGVyZSBpcyBvbmUgY29ybmVyIGNhc2Ugd2hpY2ggSSdtDQpub3Qgc3VyZS4gV2hhdCBh
Ym91dCBhbiB1c2FnZSAoZS5nLiBWTSBpbnRyb3NwZWN0aW9uKSB3aGljaCBjYXJlcyBvbmx5IA0K
YWJvdXQgdGhlIGd1ZXN0IGFjY2VzcyBwYXR0ZXJuIGkuZS4gd2hpY2ggR1BBIGlzIGRpcnRpZWQg
aW5zdGVhZCBvZiBwb2tpbmcNCml0cyBjb250ZW50PyBOZWl0aGVyIHNldHRpbmcgdGhlIGZpcnN0
IEdQQSBub3Igc2V0dGluZyBhbGwgdGhlIGFsaWFzaW5nIEdQQXMNCmNhbiBwcm92aWRlIHRoZSBh
Y2N1cmF0ZSBpbmZvLCBpZiBubyBleHBsaWNpdCBJT1ZBLT5HUEEgbWFwcGluZyBpcyBtYWludGFp
bmVkDQppbnNpZGUgdmhvc3QuIEJ1dCBJIGNhbm5vdCB0ZWxsIHdoZXRoZXIgbWFpbnRhaW5pbmcg
c3VjaCBhY2N1cmFjeSBmb3IgYWxpYXNpbmcNCkdQQXMgaXMgcmVhbGx5IG5lY2Vzc2FyeS4gK1ZN
IGludHJvc3BlY3Rpb24gZ3V5cyBpZiB0aGV5IGhhdmUgc29tZSBvcGluaW9ucy4NCg0KVGhhbmtz
DQpLZXZpbg0KDQo=

