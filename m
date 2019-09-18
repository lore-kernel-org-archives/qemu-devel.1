Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EFFC4CECD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 01:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80012067B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 01:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80012067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAP21-0002qs-1G
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 21:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iAP1I-0002Qt-67
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 21:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iAP1G-0000XY-Lj
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 21:44:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:41189)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iAP1G-0000Wf-D0
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 21:44:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Sep 2019 18:44:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,518,1559545200"; d="scan'208";a="180973198"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga008.jf.intel.com with ESMTP; 17 Sep 2019 18:44:31 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Sep 2019 18:44:31 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Sep 2019 18:44:30 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.113]) with mapi id 14.03.0439.000;
 Wed, 18 Sep 2019 09:44:29 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>
Thread-Topic: [Qemu-devel] vhost, iova, and dirty page tracking
Thread-Index: AdVsLg/AAnCsYtAES/qfxc77B9v7gf//8I+A//3tsaCAA8b/gP/+jHxg
Date: Wed, 18 Sep 2019 01:44:28 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D57B1D1@SHSMSX104.ccr.corp.intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
 <8302a4ae-1914-3046-b3b5-b3234d7dda02@redhat.com>
In-Reply-To: <8302a4ae-1914-3046-b3b5-b3234d7dda02@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmZjMzQyMDgtN2M0ZS00Mzg1LWJmNWMtMmY4N2IyOTM2MDAxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOUlrNHhsTGxuTERQZUxyWm1uTGVuTFh6YTNzcjV1aWYrN0xUM1lrMThDTTR5SjhSTjRHczBjQmFhZVVubTk3VCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] vhost, iova, and dirty page tracking
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
Cc: 'Alex Williamson' <alex.williamson@redhat.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gU2VudDog
VHVlc2RheSwgU2VwdGVtYmVyIDE3LCAyMDE5IDY6MzYgUE0NCj4gDQo+IE9uIDIwMTkvOS8xNyDk
uIvljYg0OjQ4LCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogSmFzb24gV2FuZyBbbWFp
bHRvOmphc293YW5nQHJlZGhhdC5jb21dDQo+ID4+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDE2
LCAyMDE5IDQ6MzMgUE0NCj4gPj4NCj4gPj4NCj4gPj4gT24gMjAxOS85LzE2IOS4iuWNiDk6NTEs
IFRpYW4sIEtldmluIHdyb3RlOg0KPiA+Pj4gSGksIEphc29uDQo+ID4+Pg0KPiA+Pj4gV2UgaGFk
IGEgZGlzY3Vzc2lvbiBhYm91dCBkaXJ0eSBwYWdlIHRyYWNraW5nIGluIFZGSU8sIHdoZW4gdklP
TU1VDQo+ID4+PiBpcyBlbmFibGVkOg0KPiA+Pj4NCj4gPj4+IGh0dHBzOi8vbGlzdHMubm9uZ251
Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LQ0KPiA+PiAwOS9tc2cwMjY5MC5odG1s
DQo+ID4+PiBJdCdzIGFjdHVhbGx5IGEgc2ltaWxhciBtb2RlbCBhcyB2aG9zdCAtIFFlbXUgY2Fu
bm90IGludGVycG9zZSB0aGUgZmFzdC0NCj4gPj4gcGF0aA0KPiA+Pj4gRE1BcyB0aHVzIHJlbGll
cyBvbiB0aGUga2VybmVsIHBhcnQgdG8gdHJhY2sgYW5kIHJlcG9ydCBkaXJ0eSBwYWdlDQo+ID4+
IGluZm9ybWF0aW9uLg0KPiA+Pj4gQ3VycmVudGx5IFFlbXUgdHJhY2tzIGRpcnR5IHBhZ2VzIGlu
IEdGTiBsZXZlbCwgdGh1cyBkZW1hbmRpbmcgYQ0KPiA+PiB0cmFuc2xhdGlvbg0KPiA+Pj4gZnJv
bSBJT1ZBIHRvIEdQQS4gVGhlbiB0aGUgb3BlbiBpbiBvdXIgZGlzY3Vzc2lvbiBpcyB3aGVyZSB0
aGlzDQo+ID4+IHRyYW5zbGF0aW9uDQo+ID4+PiBzaG91bGQgaGFwcGVuLiBEb2luZyB0aGUgdHJh
bnNsYXRpb24gaW4ga2VybmVsIGltcGxpZXMgYSBkZXZpY2UgaW90bGINCj4gPj4gZmxhdm9yLA0K
PiA+Pj4gd2hpY2ggaXMgd2hhdCB2aG9zdCBpbXBsZW1lbnRzIHRvZGF5LiBJdCByZXF1aXJlcyBw
b3RlbnRpYWxseSBsYXJnZQ0KPiA+PiB0cmFja2luZw0KPiA+Pj4gc3RydWN0dXJlcyBpbiB0aGUg
aG9zdCBrZXJuZWwsIGJ1dCBsZXZlcmFnaW5nIHRoZSBleGlzdGluZyBsb2dfc3luYyBmbG93DQo+
IGluDQo+ID4+IFFlbXUuDQo+ID4+PiBPbiB0aGUgb3RoZXIgaGFuZCwgUWVtdSBtYXkgcGVyZm9y
bSBsb2dfc3luYyBmb3IgZXZlcnkgcmVtb3ZhbCBvZg0KPiA+PiBJT1ZBDQo+ID4+PiBtYXBwaW5n
IGFuZCB0aGVuIGRvIHRoZSB0cmFuc2xhdGlvbiBpdHNlbGYsIHRoZW4gYXZvaWRpbmcgdGhlIEdQ
QQ0KPiA+PiBhd2FyZW5lc3MNCj4gPj4+IGluIHRoZSBrZXJuZWwgc2lkZS4gSXQgbmVlZHMgc29t
ZSBjaGFuZ2UgdG8gY3VycmVudCBRZW11IGxvZy1zeW5jIGZsb3csDQo+ID4+IGFuZA0KPiA+Pj4g
bWF5IGJyaW5nIG1vcmUgb3ZlcmhlYWQgaWYgSU9WQSBpcyBmcmVxdWVudGx5IHVubWFwcGVkLg0K
PiA+Pj4NCj4gPj4+IFNvIHdlJ2QgbGlrZSB0byBoZWFyIGFib3V0IHlvdXIgb3BpbmlvbnMsIGVz
cGVjaWFsbHkgYWJvdXQgaG93IHlvdQ0KPiBjYW1lDQo+ID4+PiBkb3duIHRvIHRoZSBjdXJyZW50
IGlvdGxiIGFwcHJvYWNoIGZvciB2aG9zdC4NCj4gPj4NCj4gPj4gV2UgZG9uJ3QgY29uc2lkZXIg
dG9vIG11Y2ggaW4gdGhlIHBvaW50IHdoZW4gaW50cm9kdWNpbmcgdmhvc3QuIEFuZA0KPiA+PiBi
ZWZvcmUgSU9UTEIsIHZob3N0IGhhcyBhbHJlYWR5IGtub3cgR1BBIHRocm91Z2ggaXRzIG1lbSB0
YWJsZQ0KPiA+PiAoR1BBLT5IVkEpLiBTbyBpdCdzIG5hdHVyZSBhbmQgZWFzaWVyIHRvIHRyYWNr
IGRpcnR5IHBhZ2VzIGF0IEdQQSBsZXZlbA0KPiA+PiB0aGVuIGl0IHdvbid0IGFueSBjaGFuZ2Vz
IGluIHRoZSBleGlzdGluZyBBQkkuDQo+ID4gVGhpcyBpcyB0aGUgc2FtZSBzaXR1YXRpb24gYXMg
VkZJTy4NCj4gPg0KPiA+PiBGb3IgVkZJTyBjYXNlLCB0aGUgb25seSBhZHZhbnRhZ2VzIG9mIHVz
aW5nIEdQQSBpcyB0aGF0IHRoZSBsb2cgY2FuIHRoZW4NCj4gPj4gYmUgc2hhcmVkIGFtb25nIGFs
bCB0aGUgZGV2aWNlcyB0aGF0IGJlbG9uZ3MgdG8gdGhlIFZNLiBPdGhlcndpc2UNCj4gPj4gc3lu
Y2luZyB0aHJvdWdoIElPVkEgaXMgY2xlYW5lci4NCj4gPiBJIHN0aWxsIHdvcnJ5IGFib3V0IHRo
ZSBwb3RlbnRpYWwgcGVyZm9ybWFuY2UgaW1wYWN0IHdpdGggdGhpcyBhcHByb2FjaC4NCj4gPiBJ
biBjdXJyZW50IG1kZXYgbGl2ZSBtaWdyYXRpb24gc2VyaWVzLCB0aGVyZSBhcmUgbXVsdGlwbGUg
c3lzdGVtIGNhbGxzDQo+ID4gaW52b2x2ZWQgd2hlbiByZXRyaWV2aW5nIHRoZSBkaXJ0eSBiaXRt
YXAgaW5mb3JtYXRpb24gZm9yIGEgZ2l2ZW4gbWVtb3J5DQo+ID4gcmFuZ2UuDQo+IA0KPiANCj4g
SSBoYXZlbid0IHRvb2sgYSBkZWVwIGxvb2sgYXQgdGhhdCBzZXJpZXMuIFRlY2huaWNhbGx5IGRp
cnR5IGJpdG1hcA0KPiBjb3VsZCBiZSBzaGFyZWQgYmV0d2VlbiBkZXZpY2UgYW5kIGRyaXZlciwg
dGhlbiB0aGVyZSdzIG5vIHN5c3RlbSBjYWxsDQo+IGluIHN5bmNocm9uaXphdGlvbi4NCg0KVGhh
dCBzZXJpZXMgcmVxdWlyZSBRZW11IHRvIHRlbGwgdGhlIGtlcm5lbCBhYm91dCB0aGUgaW5mb3Jt
YXRpb24NCmFib3V0IHF1ZXJpZWQgcmVnaW9uIChzdGFydCwgbnVtYmVyLCBhbmQgcGFnZV9zaXpl
KSwgcmVhZA0KdGhlIGluZm9ybWF0aW9uIGFib3V0IHRoZSBkaXJ0eSBiaXRtYXAgKG9mZnNldCwg
c2l6ZSkgYW5kIHRoZW4gcmVhZA0KdGhlIGRpcnR5IGJpdG1hcC4gQWx0aG91Z2ggdGhlIGJpdG1h
cCBjYW4gYmUgbW1hcGVkIHRodXMgc2hhcmVkLCANCmVhcmxpZXIgcmVhZHMvd3JpdGVzIGFyZSBj
b25kdWN0ZWQgYnkgcHJlYWQvcHdyaXRlIHN5c3RlbSBjYWxscy4NClRoaXMgZGVzaWduIGlzIGZp
bmUgZm9yIGN1cnJlbnQgbG9nX2RpcnR5IGltcGxlbWVudGF0aW9uLCB3aGVyZSANCmRpcnR5IGJp
dG1hcCBpcyBzeW5jZWQgaW4gZXZlcnkgcHJlLWNvcHkgcm91bmQuIEJ1dCB0byBkbyBpdCBmb3IN
CmV2ZXJ5IElPVkEgdW5tYXAsIGl0J3MgZGVmaW5pdGVseSBvdmVyLWtpbGxlZC4gDQoNCj4gDQo+
IA0KPiA+IElPVkEgbWFwcGluZ3MgbWlnaHQgYmUgY2hhbmdlZCBmcmVxdWVudGx5LiBUaG91Z2gg
b25lIG1heQ0KPiA+IGFyZ3VlIHRoYXQgZnJlcXVlbnQgSU9WQSBjaGFuZ2UgYWxyZWFkeSBoYXMg
YmFkIHBlcmZvcm1hbmNlLCBpdCdzIHN0aWxsDQo+ID4gbm90IGdvb2QgdG8gaW50cm9kdWNlIGZ1
cnRoZXIgbm9uLW5lZ2xpZ2libGUgb3ZlcmhlYWQgaW4gc3VjaCBzaXR1YXRpb24uDQo+IA0KPiAN
Cj4gWWVzLCBpdCBkZXBlbmRzIG9uIHRoZSBiZWhhdmlvciBvZiB2SU9NTVUgZHJpdmVyLCBlLmcg
dGhlIGZyZXF1ZW5jeSBhbmQNCj4gZ3JhbnVsYXJpdHkgb2YgdGhlIGZsdXNoaW5nLg0KPiANCj4g
DQo+ID4NCj4gPiBPbiB0aGUgb3RoZXIgaGFuZCwgSSByZWFsaXplZCB0aGF0IGFkZGluZyBJT1ZB
IGF3YXJlbmVzcyBpbiBWRklPIGlzDQo+ID4gYWN0dWFsbHkgZWFzeS4gVG9kYXkgVkZJTyBhbHJl
YWR5IG1haW50YWlucyBhIGZ1bGwgbGlzdCBvZiBJT1ZBIGFuZCBpdHMNCj4gPiBhc3NvY2lhdGVk
IEhWQSBpbiB2ZmlvX2RtYSBzdHJ1Y3R1cmUsIGFjY29yZGluZyB0byBWRklPX01BUCBhbmQNCj4g
PiBWRklPX1VOTUFQLiBBcyBsb25nIGFzIHdlIGFsbG93IHRoZSBsYXR0ZXIgdHdvIG9wZXJhdGlv
bnMgdG8gYWNjZXB0DQo+ID4gYW5vdGhlciBwYXJhbWV0ZXIgKEdQQSksIElPVkEtPkdQQSBtYXBw
aW5nIGNhbiBiZSBuYXR1cmFsbHkgY2FjaGVkDQo+ID4gaW4gZXhpc3RpbmcgdmZpb19kbWEgb2Jq
ZWN0cy4NCj4gDQo+IA0KPiBOb3RlIHRoYXQgdGhlIEhWQSB0byBHUEEgbWFwcGluZyBpcyBub3Qg
YW4gMToxIG1hcHBpbmcuIE9uZSBIVkEgcmFuZ2UNCj4gY291bGQgYmUgbWFwcGVkIHRvIHNldmVy
YWwgR1BBIHJhbmdlcy4NCg0KVGhpcyBpcyBmaW5lLiBDdXJyZW50bHkgdmZpb19kbWEgbWFpbnRh
aW5zIElPVkEtPkhWQSBtYXBwaW5nLg0KDQpidHcgdW5kZXIgd2hhdCBjb25kaXRpb24gSFZBLT5H
UEEgaXMgbm90IDE6MSBtYXBwaW5nPyBJIGRpZG4ndCByZWFsaXplIGl0Lg0KDQo+IA0KPiANCj4g
PiAgIFRob3NlIG9iamVjdHMgYXJlIGFsd2F5cyB1cGRhdGVkIGFjY29yZGluZw0KPiA+IHRvIE1B
UCBhbmQgVU5NQVAgaW9jdGxzIHRvIGJlIHVwLXRvLWRhdGUuIFFlbXUgdGhlbiB1bmlmb3JtbHkN
Cj4gPiByZXRyaWV2ZXMgdGhlIFZGSU8gZGlydHkgYml0bWFwIGZvciB0aGUgZW50aXJlIEdQQSBy
YW5nZSBpbiBldmVyeSBwcmUtY29weQ0KPiA+IHJvdW5kLCByZWdhcmRsZXNzIG9mIHdoZXRoZXIg
dklPTU1VIGlzIGVuYWJsZWQuIFRoZXJlIGlzIG5vIG5lZWQgb2YNCj4gPiBhbm90aGVyIElPVExC
IGltcGxlbWVudGF0aW9uLCB3aXRoIHRoZSBtYWluIGFzayBvbiBhIHYyIE1BUC9VTk1BUA0KPiA+
IGludGVyZmFjZS4NCj4gDQo+IA0KPiBPciBwcm92aWRlIEdQQSB0byBIVkEgbWFwcGluZyBhcyB2
aG9zdCBkaWQuIEJ1dCBhIHF1ZXN0aW9uIGlzLCBJIGJlbGlldmUNCj4gZGV2aWNlIGNhbiBvbmx5
IGRvIGRpcnR5IHBhZ2UgbG9nZ2luZyB0aHJvdWdoIElPVkEuIFNvIGhvdyBkbyB5b3UgaGFuZGxl
DQo+IHRoZSBjYXNlIHdoZW4gSU9WQSBpcyByZW1vdmVkIGluIHRoaXMgY2FzZT8NCj4gDQoNClRo
YXQncyB3aHkgYSBsb2dfc3luYyBpcyByZXF1aXJlZCBlYWNoIHRpbWUgd2hlbiBJT1ZBIGlzIHVu
bWFwcGVkLCBpbg0KQWxleCdzIHRob3VnaHQuIA0KDQpUaGFua3MNCktldmluDQo=

