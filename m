Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06BCC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 07:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A24218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 07:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A24218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAUIG-0003q5-OJ
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 03:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iAUH3-0003A6-Vr
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 03:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iAUH1-0004t6-SJ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 03:21:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:10540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iAUH1-0004qJ-Kd
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 03:21:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Sep 2019 00:21:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,519,1559545200"; d="scan'208";a="211766258"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga004.fm.intel.com with ESMTP; 18 Sep 2019 00:21:07 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Sep 2019 00:21:07 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Sep 2019 00:21:07 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.113]) with mapi id 14.03.0439.000;
 Wed, 18 Sep 2019 15:21:05 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Thread-Topic: [Qemu-devel] vhost, iova, and dirty page tracking
Thread-Index: AdVsLg/AAnCsYtAES/qfxc77B9v7gf//8I+A//3tsaCABA8DAP/+1FBAgAIp6ID//2W6IA==
Date: Wed, 18 Sep 2019 07:21:05 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D57B785@SHSMSX104.ccr.corp.intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
 <20190917085404.3b063e53@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57AFBA@SHSMSX104.ccr.corp.intel.com>
 <a82101bf-f8a7-5ddd-5abe-6060762d9abe@redhat.com>
In-Reply-To: <a82101bf-f8a7-5ddd-5abe-6060762d9abe@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTA5ZjU4MzUtMGUzMi00ZTdiLTlmNmItNGEzMDlkNTMzZjQ3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZzBjY1JXSXFGQ2NPZ21jN1kxZ242R25LWlhuSEcyK2lYeDhVSWQwUVdaODc2WkR6ODkwR25CQTRCRGtGWW44TSJ9
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
Cc: "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gU2VudDog
V2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTgsIDIwMTkgMjowNCBQTQ0KPiANCj4gT24gMjAxOS85LzE4
IOS4iuWNiDk6MzEsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBBbGV4IFdpbGxpYW1z
b24gW21haWx0bzphbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbV0NCj4gPj4gU2VudDogVHVlc2Rh
eSwgU2VwdGVtYmVyIDE3LCAyMDE5IDEwOjU0IFBNDQo+ID4+DQo+ID4+IE9uIFR1ZSwgMTcgU2Vw
IDIwMTkgMDg6NDg6MzYgKzAwMDANCj4gPj4gIlRpYW4sIEtldmluIjxrZXZpbi50aWFuQGludGVs
LmNvbT4gIHdyb3RlOg0KPiA+Pg0KPiA+Pj4+IEZyb206IEphc29uIFdhbmcgW21haWx0bzpqYXNv
d2FuZ0ByZWRoYXQuY29tXQ0KPiA+Pj4+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDE2LCAyMDE5
IDQ6MzMgUE0NCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gT24gMjAxOS85LzE2IOS4iuWNiDk6NTEs
IFRpYW4sIEtldmluIHdyb3RlOg0KPiA+Pj4+PiBIaSwgSmFzb24NCj4gPj4+Pj4NCj4gPj4+Pj4g
V2UgaGFkIGEgZGlzY3Vzc2lvbiBhYm91dCBkaXJ0eSBwYWdlIHRyYWNraW5nIGluIFZGSU8sIHdo
ZW4NCj4gdklPTU1VDQo+ID4+Pj4+IGlzIGVuYWJsZWQ6DQo+ID4+Pj4+DQo+ID4+Pj4+IGh0dHBz
Oi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LQ0KPiA+Pj4+
IDA5L21zZzAyNjkwLmh0bWwNCj4gPj4+Pj4gSXQncyBhY3R1YWxseSBhIHNpbWlsYXIgbW9kZWwg
YXMgdmhvc3QgLSBRZW11IGNhbm5vdCBpbnRlcnBvc2UgdGhlDQo+IGZhc3QtDQo+ID4+Pj4gcGF0
aA0KPiA+Pj4+PiBETUFzIHRodXMgcmVsaWVzIG9uIHRoZSBrZXJuZWwgcGFydCB0byB0cmFjayBh
bmQgcmVwb3J0IGRpcnR5IHBhZ2UNCj4gPj4+PiBpbmZvcm1hdGlvbi4NCj4gPj4+Pj4gQ3VycmVu
dGx5IFFlbXUgdHJhY2tzIGRpcnR5IHBhZ2VzIGluIEdGTiBsZXZlbCwgdGh1cyBkZW1hbmRpbmcg
YQ0KPiA+Pj4+IHRyYW5zbGF0aW9uDQo+ID4+Pj4+IGZyb20gSU9WQSB0byBHUEEuIFRoZW4gdGhl
IG9wZW4gaW4gb3VyIGRpc2N1c3Npb24gaXMgd2hlcmUgdGhpcw0KPiA+Pj4+IHRyYW5zbGF0aW9u
DQo+ID4+Pj4+IHNob3VsZCBoYXBwZW4uIERvaW5nIHRoZSB0cmFuc2xhdGlvbiBpbiBrZXJuZWwg
aW1wbGllcyBhIGRldmljZSBpb3RsYg0KPiA+Pj4+IGZsYXZvciwNCj4gPj4+Pj4gd2hpY2ggaXMg
d2hhdCB2aG9zdCBpbXBsZW1lbnRzIHRvZGF5LiBJdCByZXF1aXJlcyBwb3RlbnRpYWxseSBsYXJn
ZQ0KPiA+Pj4+IHRyYWNraW5nDQo+ID4+Pj4+IHN0cnVjdHVyZXMgaW4gdGhlIGhvc3Qga2VybmVs
LCBidXQgbGV2ZXJhZ2luZyB0aGUgZXhpc3RpbmcgbG9nX3N5bmMNCj4gZmxvdw0KPiA+PiBpbg0K
PiA+Pj4+IFFlbXUuDQo+ID4+Pj4+IE9uIHRoZSBvdGhlciBoYW5kLCBRZW11IG1heSBwZXJmb3Jt
IGxvZ19zeW5jIGZvciBldmVyeSByZW1vdmFsDQo+IG9mDQo+ID4+Pj4gSU9WQQ0KPiA+Pj4+PiBt
YXBwaW5nIGFuZCB0aGVuIGRvIHRoZSB0cmFuc2xhdGlvbiBpdHNlbGYsIHRoZW4gYXZvaWRpbmcg
dGhlIEdQQQ0KPiA+Pj4+IGF3YXJlbmVzcw0KPiA+Pj4+PiBpbiB0aGUga2VybmVsIHNpZGUuIEl0
IG5lZWRzIHNvbWUgY2hhbmdlIHRvIGN1cnJlbnQgUWVtdSBsb2ctc3luYw0KPiA+PiBmbG93LA0K
PiA+Pj4+IGFuZA0KPiA+Pj4+PiBtYXkgYnJpbmcgbW9yZSBvdmVyaGVhZCBpZiBJT1ZBIGlzIGZy
ZXF1ZW50bHkgdW5tYXBwZWQuDQo+ID4+Pj4+DQo+ID4+Pj4+IFNvIHdlJ2QgbGlrZSB0byBoZWFy
IGFib3V0IHlvdXIgb3BpbmlvbnMsIGVzcGVjaWFsbHkgYWJvdXQgaG93IHlvdQ0KPiA+PiBjYW1l
DQo+ID4+Pj4+IGRvd24gdG8gdGhlIGN1cnJlbnQgaW90bGIgYXBwcm9hY2ggZm9yIHZob3N0Lg0K
PiA+Pj4+IFdlIGRvbid0IGNvbnNpZGVyIHRvbyBtdWNoIGluIHRoZSBwb2ludCB3aGVuIGludHJv
ZHVjaW5nIHZob3N0LiBBbmQNCj4gPj4+PiBiZWZvcmUgSU9UTEIsIHZob3N0IGhhcyBhbHJlYWR5
IGtub3cgR1BBIHRocm91Z2ggaXRzIG1lbSB0YWJsZQ0KPiA+Pj4+IChHUEEtPkhWQSkuIFNvIGl0
J3MgbmF0dXJlIGFuZCBlYXNpZXIgdG8gdHJhY2sgZGlydHkgcGFnZXMgYXQgR1BBIGxldmVsDQo+
ID4+Pj4gdGhlbiBpdCB3b24ndCBhbnkgY2hhbmdlcyBpbiB0aGUgZXhpc3RpbmcgQUJJLg0KPiA+
Pj4gVGhpcyBpcyB0aGUgc2FtZSBzaXR1YXRpb24gYXMgVkZJTy4NCj4gPj4gSXQgaXM/ICBWRklP
IGRvZXNuJ3Qga25vdyBHUEFzLCBpdCBvbmx5IGtub3dzIEhWQSwgSFBBLCBhbmQgSU9WQS4gIElu
DQo+ID4+IHNvbWUgY2FzZXMgSU9WQSBpcyBHUEEsIGJ1dCBub3QgYWxsLg0KPiA+IFdlbGwsIEkg
dGhvdWdodCB2aG9zdCBoYXMgYSBzaW1pbGFyIGRlc2lnbiwgdGhhdCB0aGUgaW5kZXggb2YgaXRz
IG1lbSB0YWJsZQ0KPiA+IGlzIEdQQSB3aGVuIHZJT01NVSBpcyBvZmYgYW5kIHRoZW4gYmVjb21l
cyBJT1ZBIHdoZW4gdklPTU1VIGlzIG9uLg0KPiA+IEJ1dCBJIG1heSBiZSB3cm9uZyBoZXJlLiBK
YXNvbiwgY2FuIHlvdSBoZWxwIGNsYXJpZnk/IEkgc2F3IHR3bw0KPiA+IGludGVyZmFjZXMgd2hp
Y2ggcG9rZSB0aGUgbWVtIHRhYmxlOiBWSE9TVF9TRVRfTUVNX1RBQkxFIChmb3IgR1BBKQ0KPiA+
IGFuZCBWSE9TVF9JT1RMQl9VUERBVEUgKGZvciBJT1ZBKS4gQXJlIHRoZXkgdXNlZCBleGNsdXNp
dmVseSBvcg0KPiB0b2dldGhlcj8NCj4gPg0KPiANCj4gQWN0dWFsbHksIHZob3N0IG1haW50YWlu
cyB0d28gaW50ZXJ2YWwgdHJlZXMsIG1lbSB0YWJsZSBHUEEtPkhWQSwgYW5kDQo+IGRldmljZSBJ
T1RMQiBJT1ZBLT5IVkEuIERldmljZSBJT1RMQiBpcyBvbmx5IHVzZWQgd2hlbiB2SU9NTVUgaXMN
Cj4gZW5hYmxlZCwgYW5kIGluIHRoYXQgY2FzZSBtZW0gdGFibGUgaXMgdXNlZCBvbmx5IHdoZW4g
dmhvc3QgbmVlZCB0bw0KPiB0cmFjayBkaXJ0eSBwYWdlcyAoZG8gcmV2ZXJzZSBsb29rdXAgb2Yg
bWVtdGFibGUgdG8gZ2V0IEhWQS0+R1BBKS4gU28gaW4NCj4gY29uY2x1c2lvbiwgZm9yIGRhdGFw
YXRoLCB0aGV5IGFyZSB1c2VkIGV4Y2x1c2l2ZWx5LCBidXQgdGhleSBuZWVkDQo+IGNvd29yayBm
b3IgbG9nZ2luZyBkaXJ0eSBwYWdlcyB3aGVuIGRldmljZSBJT1RMQiBpcyBlbmFibGVkLg0KPiAN
Cg0KT0suIFRoZW4gaXQncyBkaWZmZXJlbnQgZnJvbSBjdXJyZW50IFZGSU8gZGVzaWduLCB3aGlj
aCBtYWludGFpbnMgb25seQ0Kb25lIHRyZWUgd2hpY2ggaXMgaW5kZXhlZCBieSBlaXRoZXIgR1BB
IG9yIElPVkEgZXhjbHVzaXZlbHksIHVwb24gDQp3aGV0aGVyIHZJT01NVSBpcyBpbiB1c2UuIA0K
DQpUaGFua3MNCktldmluDQo=

