Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5730DC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 07:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2667520640
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 07:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2667520640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAUc3-0006KN-9f
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 03:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iAUb3-0005ca-4O
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 03:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iAUb0-0004vF-PU
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 03:41:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:39720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iAUb0-0004sq-Hz
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 03:41:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Sep 2019 00:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,520,1559545200"; d="scan'208";a="270790156"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga001.jf.intel.com with ESMTP; 18 Sep 2019 00:41:46 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Sep 2019 00:41:46 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Sep 2019 00:41:45 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.195]) with mapi id 14.03.0439.000;
 Wed, 18 Sep 2019 15:41:43 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>
Thread-Topic: [Qemu-devel] vhost, iova, and dirty page tracking
Thread-Index: AdVsLg/AAnCsYtAES/qfxc77B9v7gf//8I+A//3tsaCAA8b/gP/+jHxggAK7doD//2YFsA==
Date: Wed, 18 Sep 2019 07:41:43 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D57B7E0@SHSMSX104.ccr.corp.intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
 <8302a4ae-1914-3046-b3b5-b3234d7dda02@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B1D1@SHSMSX104.ccr.corp.intel.com>
 <6d73572e-1e89-b04a-bdd6-98ac73798083@redhat.com>
In-Reply-To: <6d73572e-1e89-b04a-bdd6-98ac73798083@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWM2NzEwZDUtNWQ5ZC00ZDAzLThkYmItZmVlNDU4OTc3MDY4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMzN4NkdOa1BcLzBIaVhWSFpFWnFuWTR6cExlNVZ6NVRXS2QyRkRRTFdWdGF2VWRXc3VkUmxXSjVRSkdla1R4RXgifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
V2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTgsIDIwMTkgMjoxMCBQTQ0KPiANCj4gT24gMjAxOS85LzE4
IOS4iuWNiDk6NDQsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBKYXNvbiBXYW5nIFtt
YWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gPj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVy
IDE3LCAyMDE5IDY6MzYgUE0NCj4gPj4NCj4gPj4gT24gMjAxOS85LzE3IOS4i+WNiDQ6NDgsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+Pj4+IEZyb206IEphc29uIFdhbmcgW21haWx0bzpqYXNvd2Fu
Z0ByZWRoYXQuY29tXQ0KPiA+Pj4+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDE2LCAyMDE5IDQ6
MzMgUE0NCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gT24gMjAxOS85LzE2IOS4iuWNiDk6NTEsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+Pj4+PiBIaSwgSmFzb24NCj4gPj4+Pj4NCj4gPj4+Pj4gV2Ug
aGFkIGEgZGlzY3Vzc2lvbiBhYm91dCBkaXJ0eSBwYWdlIHRyYWNraW5nIGluIFZGSU8sIHdoZW4N
Cj4gdklPTU1VDQo+ID4+Pj4+IGlzIGVuYWJsZWQ6DQo+ID4+Pj4+DQo+ID4+Pj4+IGh0dHBzOi8v
bGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LQ0KPiA+Pj4+IDA5
L21zZzAyNjkwLmh0bWwNCj4gPj4+Pj4gSXQncyBhY3R1YWxseSBhIHNpbWlsYXIgbW9kZWwgYXMg
dmhvc3QgLSBRZW11IGNhbm5vdCBpbnRlcnBvc2UgdGhlDQo+IGZhc3QtDQo+ID4+Pj4gcGF0aA0K
PiA+Pj4+PiBETUFzIHRodXMgcmVsaWVzIG9uIHRoZSBrZXJuZWwgcGFydCB0byB0cmFjayBhbmQg
cmVwb3J0IGRpcnR5IHBhZ2UNCj4gPj4+PiBpbmZvcm1hdGlvbi4NCj4gPj4+Pj4gQ3VycmVudGx5
IFFlbXUgdHJhY2tzIGRpcnR5IHBhZ2VzIGluIEdGTiBsZXZlbCwgdGh1cyBkZW1hbmRpbmcgYQ0K
PiA+Pj4+IHRyYW5zbGF0aW9uDQo+ID4+Pj4+IGZyb20gSU9WQSB0byBHUEEuIFRoZW4gdGhlIG9w
ZW4gaW4gb3VyIGRpc2N1c3Npb24gaXMgd2hlcmUgdGhpcw0KPiA+Pj4+IHRyYW5zbGF0aW9uDQo+
ID4+Pj4+IHNob3VsZCBoYXBwZW4uIERvaW5nIHRoZSB0cmFuc2xhdGlvbiBpbiBrZXJuZWwgaW1w
bGllcyBhIGRldmljZSBpb3RsYg0KPiA+Pj4+IGZsYXZvciwNCj4gPj4+Pj4gd2hpY2ggaXMgd2hh
dCB2aG9zdCBpbXBsZW1lbnRzIHRvZGF5LiBJdCByZXF1aXJlcyBwb3RlbnRpYWxseSBsYXJnZQ0K
PiA+Pj4+IHRyYWNraW5nDQo+ID4+Pj4+IHN0cnVjdHVyZXMgaW4gdGhlIGhvc3Qga2VybmVsLCBi
dXQgbGV2ZXJhZ2luZyB0aGUgZXhpc3RpbmcgbG9nX3N5bmMNCj4gZmxvdw0KPiA+PiBpbg0KPiA+
Pj4+IFFlbXUuDQo+ID4+Pj4+IE9uIHRoZSBvdGhlciBoYW5kLCBRZW11IG1heSBwZXJmb3JtIGxv
Z19zeW5jIGZvciBldmVyeSByZW1vdmFsDQo+IG9mDQo+ID4+Pj4gSU9WQQ0KPiA+Pj4+PiBtYXBw
aW5nIGFuZCB0aGVuIGRvIHRoZSB0cmFuc2xhdGlvbiBpdHNlbGYsIHRoZW4gYXZvaWRpbmcgdGhl
IEdQQQ0KPiA+Pj4+IGF3YXJlbmVzcw0KPiA+Pj4+PiBpbiB0aGUga2VybmVsIHNpZGUuIEl0IG5l
ZWRzIHNvbWUgY2hhbmdlIHRvIGN1cnJlbnQgUWVtdSBsb2ctc3luYw0KPiBmbG93LA0KPiA+Pj4+
IGFuZA0KPiA+Pj4+PiBtYXkgYnJpbmcgbW9yZSBvdmVyaGVhZCBpZiBJT1ZBIGlzIGZyZXF1ZW50
bHkgdW5tYXBwZWQuDQo+ID4+Pj4+DQo+ID4+Pj4+IFNvIHdlJ2QgbGlrZSB0byBoZWFyIGFib3V0
IHlvdXIgb3BpbmlvbnMsIGVzcGVjaWFsbHkgYWJvdXQgaG93IHlvdQ0KPiA+PiBjYW1lDQo+ID4+
Pj4+IGRvd24gdG8gdGhlIGN1cnJlbnQgaW90bGIgYXBwcm9hY2ggZm9yIHZob3N0Lg0KPiA+Pj4+
IFdlIGRvbid0IGNvbnNpZGVyIHRvbyBtdWNoIGluIHRoZSBwb2ludCB3aGVuIGludHJvZHVjaW5n
IHZob3N0LiBBbmQNCj4gPj4+PiBiZWZvcmUgSU9UTEIsIHZob3N0IGhhcyBhbHJlYWR5IGtub3cg
R1BBIHRocm91Z2ggaXRzIG1lbSB0YWJsZQ0KPiA+Pj4+IChHUEEtPkhWQSkuIFNvIGl0J3MgbmF0
dXJlIGFuZCBlYXNpZXIgdG8gdHJhY2sgZGlydHkgcGFnZXMgYXQgR1BBIGxldmVsDQo+ID4+Pj4g
dGhlbiBpdCB3b24ndCBhbnkgY2hhbmdlcyBpbiB0aGUgZXhpc3RpbmcgQUJJLg0KPiA+Pj4gVGhp
cyBpcyB0aGUgc2FtZSBzaXR1YXRpb24gYXMgVkZJTy4NCj4gPj4+DQo+ID4+Pj4gRm9yIFZGSU8g
Y2FzZSwgdGhlIG9ubHkgYWR2YW50YWdlcyBvZiB1c2luZyBHUEEgaXMgdGhhdCB0aGUgbG9nIGNh
bg0KPiB0aGVuDQo+ID4+Pj4gYmUgc2hhcmVkIGFtb25nIGFsbCB0aGUgZGV2aWNlcyB0aGF0IGJl
bG9uZ3MgdG8gdGhlIFZNLiBPdGhlcndpc2UNCj4gPj4+PiBzeW5jaW5nIHRocm91Z2ggSU9WQSBp
cyBjbGVhbmVyLg0KPiA+Pj4gSSBzdGlsbCB3b3JyeSBhYm91dCB0aGUgcG90ZW50aWFsIHBlcmZv
cm1hbmNlIGltcGFjdCB3aXRoIHRoaXMgYXBwcm9hY2guDQo+ID4+PiBJbiBjdXJyZW50IG1kZXYg
bGl2ZSBtaWdyYXRpb24gc2VyaWVzLCB0aGVyZSBhcmUgbXVsdGlwbGUgc3lzdGVtIGNhbGxzDQo+
ID4+PiBpbnZvbHZlZCB3aGVuIHJldHJpZXZpbmcgdGhlIGRpcnR5IGJpdG1hcCBpbmZvcm1hdGlv
biBmb3IgYSBnaXZlbg0KPiBtZW1vcnkNCj4gPj4+IHJhbmdlLg0KPiA+Pg0KPiA+PiBJIGhhdmVu
J3QgdG9vayBhIGRlZXAgbG9vayBhdCB0aGF0IHNlcmllcy4gVGVjaG5pY2FsbHkgZGlydHkgYml0
bWFwDQo+ID4+IGNvdWxkIGJlIHNoYXJlZCBiZXR3ZWVuIGRldmljZSBhbmQgZHJpdmVyLCB0aGVu
IHRoZXJlJ3Mgbm8gc3lzdGVtIGNhbGwNCj4gPj4gaW4gc3luY2hyb25pemF0aW9uLg0KPiA+IFRo
YXQgc2VyaWVzIHJlcXVpcmUgUWVtdSB0byB0ZWxsIHRoZSBrZXJuZWwgYWJvdXQgdGhlIGluZm9y
bWF0aW9uDQo+ID4gYWJvdXQgcXVlcmllZCByZWdpb24gKHN0YXJ0LCBudW1iZXIsIGFuZCBwYWdl
X3NpemUpLCByZWFkDQo+ID4gdGhlIGluZm9ybWF0aW9uIGFib3V0IHRoZSBkaXJ0eSBiaXRtYXAg
KG9mZnNldCwgc2l6ZSkgYW5kIHRoZW4gcmVhZA0KPiA+IHRoZSBkaXJ0eSBiaXRtYXAuDQo+IA0K
PiANCj4gQW55IHBvaW50ZXIgdG8gdGhhdCBzZXJpZXMsIEkgY2FuIG9ubHkgZmluZCBhICJtZGV2
IGxpdmUgbWlncmF0aW9uDQo+IHN1cHBvcnQgd2l0aCB2ZmlvLW1kZXYtcGNpIiBmcm9tIExpdSBZ
aSB3aXRob3V0IGFjdHVhbCBjb2Rlcy4NCg0KaHR0cHM6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hp
dmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDgvbXNnMDU1NDMuaHRtbA0KSXQncyBpbnRlcmVzdGlu
ZyB0aGF0IEkgY2Fubm90IGdvb2dsZSBpdC4gSGF2ZSB0byBtYW51YWxseSBmaW5kIGl0IGluDQpR
ZW11IGFyY2hpdmUuDQoNCj4gDQo+IA0KPiA+IEFsdGhvdWdoIHRoZSBiaXRtYXAgY2FuIGJlIG1t
YXBlZCB0aHVzIHNoYXJlZCwNCj4gPiBlYXJsaWVyIHJlYWRzL3dyaXRlcyBhcmUgY29uZHVjdGVk
IGJ5IHByZWFkL3B3cml0ZSBzeXN0ZW0gY2FsbHMuDQo+ID4gVGhpcyBkZXNpZ24gaXMgZmluZSBm
b3IgY3VycmVudCBsb2dfZGlydHkgaW1wbGVtZW50YXRpb24sIHdoZXJlDQo+ID4gZGlydHkgYml0
bWFwIGlzIHN5bmNlZCBpbiBldmVyeSBwcmUtY29weSByb3VuZC4gQnV0IHRvIGRvIGl0IGZvcg0K
PiA+IGV2ZXJ5IElPVkEgdW5tYXAsIGl0J3MgZGVmaW5pdGVseSBvdmVyLWtpbGxlZC4NCj4gPg0K
PiA+Pg0KPiA+Pj4gSU9WQSBtYXBwaW5ncyBtaWdodCBiZSBjaGFuZ2VkIGZyZXF1ZW50bHkuIFRo
b3VnaCBvbmUgbWF5DQo+ID4+PiBhcmd1ZSB0aGF0IGZyZXF1ZW50IElPVkEgY2hhbmdlIGFscmVh
ZHkgaGFzIGJhZCBwZXJmb3JtYW5jZSwgaXQncyBzdGlsbA0KPiA+Pj4gbm90IGdvb2QgdG8gaW50
cm9kdWNlIGZ1cnRoZXIgbm9uLW5lZ2xpZ2libGUgb3ZlcmhlYWQgaW4gc3VjaCBzaXR1YXRpb24u
DQo+ID4+DQo+ID4+IFllcywgaXQgZGVwZW5kcyBvbiB0aGUgYmVoYXZpb3Igb2YgdklPTU1VIGRy
aXZlciwgZS5nIHRoZSBmcmVxdWVuY3kNCj4gYW5kDQo+ID4+IGdyYW51bGFyaXR5IG9mIHRoZSBm
bHVzaGluZy4NCj4gPj4NCj4gPj4NCj4gPj4+IE9uIHRoZSBvdGhlciBoYW5kLCBJIHJlYWxpemVk
IHRoYXQgYWRkaW5nIElPVkEgYXdhcmVuZXNzIGluIFZGSU8gaXMNCj4gPj4+IGFjdHVhbGx5IGVh
c3kuIFRvZGF5IFZGSU8gYWxyZWFkeSBtYWludGFpbnMgYSBmdWxsIGxpc3Qgb2YgSU9WQSBhbmQg
aXRzDQo+ID4+PiBhc3NvY2lhdGVkIEhWQSBpbiB2ZmlvX2RtYSBzdHJ1Y3R1cmUsIGFjY29yZGlu
ZyB0byBWRklPX01BUCBhbmQNCj4gPj4+IFZGSU9fVU5NQVAuIEFzIGxvbmcgYXMgd2UgYWxsb3cg
dGhlIGxhdHRlciB0d28gb3BlcmF0aW9ucyB0byBhY2NlcHQNCj4gPj4+IGFub3RoZXIgcGFyYW1l
dGVyIChHUEEpLCBJT1ZBLT5HUEEgbWFwcGluZyBjYW4gYmUgbmF0dXJhbGx5IGNhY2hlZA0KPiA+
Pj4gaW4gZXhpc3RpbmcgdmZpb19kbWEgb2JqZWN0cy4NCj4gPj4NCj4gPj4gTm90ZSB0aGF0IHRo
ZSBIVkEgdG8gR1BBIG1hcHBpbmcgaXMgbm90IGFuIDE6MSBtYXBwaW5nLiBPbmUgSFZBDQo+IHJh
bmdlDQo+ID4+IGNvdWxkIGJlIG1hcHBlZCB0byBzZXZlcmFsIEdQQSByYW5nZXMuDQo+ID4gVGhp
cyBpcyBmaW5lLiBDdXJyZW50bHkgdmZpb19kbWEgbWFpbnRhaW5zIElPVkEtPkhWQSBtYXBwaW5n
Lg0KPiA+DQo+ID4gYnR3IHVuZGVyIHdoYXQgY29uZGl0aW9uIEhWQS0+R1BBIGlzIG5vdCAxOjEg
bWFwcGluZz8gSSBkaWRuJ3QgcmVhbGl6ZSBpdC4NCj4gDQo+IA0KPiBJIGRvbid0IHJlbWVtYmVy
IHRoZSBkZXRhaWxzIGUuZyBtZW1vcnkgcmVnaW9uIGFsaWFzPyBBbmQgbmVpdGhlciBrdm0NCj4g
bm9yIGt2bSBBUEkgZG9lcyBmb3JiaWQgdGhpcyBpZiBteSBtZW1vcnkgaXMgY29ycmVjdC4NCj4g
DQoNCkkgZGlkIHNlZSBzdWNoIGNvbW1lbnQgaW4gdmhvc3QgY29kZSAobG9nX3dyaXRlX2h2YSk6
DQoNCgkvKiBNb3JlIHRoYW4gb25lIEdQQXMgY2FuIGJlIG1hcHBlZCBpbnRvIGEgc2luZ2xlIEhW
QS4gU28NCiAgICAgICAgICAgICAgICAgKiBpdGVyYXRlIGFsbCBwb3NzaWJsZSB1bWVtcyBoZXJl
IHRvIGJlIHNhZmUuDQogICAgICAgICAgICAgICAgICovDQoNCmFuZCBsb29rcyBpdCB0cmllcyB0
byBsb2cgYWxsIHBvc3NpYmxlIEdQQXMgdGhhdCBpcyBtYXBwZWQgdG8gdGhlIHNhbWUNCkhWQSwg
ZXZlbiB3aGVuIG9ubHkgb25lIG9mIHRoZW0gaXMgYWN0dWFsbHkgbWFwcGVkIGJ5IHJlcXVlc3Rl
ZCANCklPVkEgKGZyb20gZ3Vlc3QgcC5vLnYpLiBidXQgSSBqdXN0IGNhbm5vdCBjb21lIHVwIGEg
c2NlbmFyaW8gd2hlcmUgDQp0aGlzIHNpdHVhdGlvbiB3aWxsIGJlIHRyaWdnZXJlZC4gSSBvbmNl
IHRob3VnaHQgYWJvdXQgS1NNLCBidXQgaW4gdGhhdCANCmNhc2UgaXQncyB0d28gSFZBcyBtYXBw
ZWQgdG8gdGhlIHNhbWUgUEZOIHRodXMgaXJyZWxldmFudC4uLg0KDQpUaGFua3MNCktldmluDQo=

