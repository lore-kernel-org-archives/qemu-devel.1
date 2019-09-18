Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBF8C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 02:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CA4206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 02:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CA4206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAPWe-0001bs-Jy
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 22:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iAPVa-0000jX-0J
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 22:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iAPVW-00030m-Vx
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 22:15:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:12547)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iAPVW-0002ya-Kk
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 22:15:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Sep 2019 19:15:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,519,1559545200"; d="scan'208";a="198889838"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by orsmga002.jf.intel.com with ESMTP; 17 Sep 2019 19:15:44 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Sep 2019 19:15:44 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Sep 2019 19:15:43 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.146]) with mapi id 14.03.0439.000;
 Wed, 18 Sep 2019 10:15:42 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: 'Alex Williamson' <alex.williamson@redhat.com>
Thread-Topic: [Qemu-devel] vhost, iova, and dirty page tracking
Thread-Index: AdVsLg/AAnCsYtAES/qfxc77B9v7gf//8I+A//3tsaCABA8DAP/+1FBA//2UQtA=
Date: Wed, 18 Sep 2019 02:15:41 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D57B2B4@SHSMSX104.ccr.corp.intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
 <20190917085404.3b063e53@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57AFB7@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D57AFB7@SHSMSX104.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmVjYjE4NWUtODFjYS00MjFjLWI1MTUtMmU1NjEyZmIzMTExIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicmZTNXNySUVtZk9nZWdNUDRPaW9KaEd1S0xSbWRJUndBTFZXR0w0eGw2cE5oQU5mNjJDUm1xNlI5ZFFRejZ1MCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
Cc: Jason Wang <jasowang@redhat.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBUaWFuLCBLZXZpbg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAxOCwgMjAx
OSA5OjMyIEFNDQo+IA0KPiA+IEZyb206IEFsZXggV2lsbGlhbXNvbiBbbWFpbHRvOmFsZXgud2ls
bGlhbXNvbkByZWRoYXQuY29tXQ0KPiA+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxNywgMjAx
OSAxMDo1NCBQTQ0KPiA+DQo+ID4gT24gVHVlLCAxNyBTZXAgMjAxOSAwODo0ODozNiArMDAwMA0K
PiA+ICJUaWFuLCBLZXZpbiIgPGtldmluLnRpYW5AaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+
ID4gPiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gPiA+
ID4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMTYsIDIwMTkgNDozMyBQTQ0KPiA+ID4gPg0KPiA+
ID4gPg0KPiA+ID4gPiBPbiAyMDE5LzkvMTYg5LiK5Y2IOTo1MSwgVGlhbiwgS2V2aW4gd3JvdGU6
DQo+ID4gPiA+ID4gSGksIEphc29uDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBXZSBoYWQgYSBkaXNj
dXNzaW9uIGFib3V0IGRpcnR5IHBhZ2UgdHJhY2tpbmcgaW4gVkZJTywgd2hlbg0KPiB2SU9NTVUN
Cj4gPiA+ID4gPiBpcyBlbmFibGVkOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gaHR0cHM6Ly9saXN0
cy5ub25nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktDQo+ID4gPiA+IDA5L21z
ZzAyNjkwLmh0bWwNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEl0J3MgYWN0dWFsbHkgYSBzaW1pbGFy
IG1vZGVsIGFzIHZob3N0IC0gUWVtdSBjYW5ub3QgaW50ZXJwb3NlIHRoZQ0KPiBmYXN0LQ0KPiA+
ID4gPiBwYXRoDQo+ID4gPiA+ID4gRE1BcyB0aHVzIHJlbGllcyBvbiB0aGUga2VybmVsIHBhcnQg
dG8gdHJhY2sgYW5kIHJlcG9ydCBkaXJ0eSBwYWdlDQo+ID4gPiA+IGluZm9ybWF0aW9uLg0KPiA+
ID4gPiA+IEN1cnJlbnRseSBRZW11IHRyYWNrcyBkaXJ0eSBwYWdlcyBpbiBHRk4gbGV2ZWwsIHRo
dXMgZGVtYW5kaW5nIGENCj4gPiA+ID4gdHJhbnNsYXRpb24NCj4gPiA+ID4gPiBmcm9tIElPVkEg
dG8gR1BBLiBUaGVuIHRoZSBvcGVuIGluIG91ciBkaXNjdXNzaW9uIGlzIHdoZXJlIHRoaXMNCj4g
PiA+ID4gdHJhbnNsYXRpb24NCj4gPiA+ID4gPiBzaG91bGQgaGFwcGVuLiBEb2luZyB0aGUgdHJh
bnNsYXRpb24gaW4ga2VybmVsIGltcGxpZXMgYSBkZXZpY2UgaW90bGINCj4gPiA+ID4gZmxhdm9y
LA0KPiA+ID4gPiA+IHdoaWNoIGlzIHdoYXQgdmhvc3QgaW1wbGVtZW50cyB0b2RheS4gSXQgcmVx
dWlyZXMgcG90ZW50aWFsbHkgbGFyZ2UNCj4gPiA+ID4gdHJhY2tpbmcNCj4gPiA+ID4gPiBzdHJ1
Y3R1cmVzIGluIHRoZSBob3N0IGtlcm5lbCwgYnV0IGxldmVyYWdpbmcgdGhlIGV4aXN0aW5nIGxv
Z19zeW5jDQo+IGZsb3cNCj4gPiBpbg0KPiA+ID4gPiBRZW11Lg0KPiA+ID4gPiA+IE9uIHRoZSBv
dGhlciBoYW5kLCBRZW11IG1heSBwZXJmb3JtIGxvZ19zeW5jIGZvciBldmVyeSByZW1vdmFsDQo+
IG9mDQo+ID4gPiA+IElPVkENCj4gPiA+ID4gPiBtYXBwaW5nIGFuZCB0aGVuIGRvIHRoZSB0cmFu
c2xhdGlvbiBpdHNlbGYsIHRoZW4gYXZvaWRpbmcgdGhlIEdQQQ0KPiA+ID4gPiBhd2FyZW5lc3MN
Cj4gPiA+ID4gPiBpbiB0aGUga2VybmVsIHNpZGUuIEl0IG5lZWRzIHNvbWUgY2hhbmdlIHRvIGN1
cnJlbnQgUWVtdSBsb2ctc3luYw0KPiA+IGZsb3csDQo+ID4gPiA+IGFuZA0KPiA+ID4gPiA+IG1h
eSBicmluZyBtb3JlIG92ZXJoZWFkIGlmIElPVkEgaXMgZnJlcXVlbnRseSB1bm1hcHBlZC4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IFNvIHdlJ2QgbGlrZSB0byBoZWFyIGFib3V0IHlvdXIgb3Bpbmlv
bnMsIGVzcGVjaWFsbHkgYWJvdXQgaG93IHlvdQ0KPiA+IGNhbWUNCj4gPiA+ID4gPiBkb3duIHRv
IHRoZSBjdXJyZW50IGlvdGxiIGFwcHJvYWNoIGZvciB2aG9zdC4NCj4gPiA+ID4NCj4gPiA+ID4N
Cj4gPiA+ID4gV2UgZG9uJ3QgY29uc2lkZXIgdG9vIG11Y2ggaW4gdGhlIHBvaW50IHdoZW4gaW50
cm9kdWNpbmcgdmhvc3QuIEFuZA0KPiA+ID4gPiBiZWZvcmUgSU9UTEIsIHZob3N0IGhhcyBhbHJl
YWR5IGtub3cgR1BBIHRocm91Z2ggaXRzIG1lbSB0YWJsZQ0KPiA+ID4gPiAoR1BBLT5IVkEpLiBT
byBpdCdzIG5hdHVyZSBhbmQgZWFzaWVyIHRvIHRyYWNrIGRpcnR5IHBhZ2VzIGF0IEdQQSBsZXZl
bA0KPiA+ID4gPiB0aGVuIGl0IHdvbid0IGFueSBjaGFuZ2VzIGluIHRoZSBleGlzdGluZyBBQkku
DQo+ID4gPg0KPiA+ID4gVGhpcyBpcyB0aGUgc2FtZSBzaXR1YXRpb24gYXMgVkZJTy4NCj4gPg0K
PiA+IEl0IGlzPyAgVkZJTyBkb2Vzbid0IGtub3cgR1BBcywgaXQgb25seSBrbm93cyBIVkEsIEhQ
QSwgYW5kIElPVkEuICBJbg0KPiA+IHNvbWUgY2FzZXMgSU9WQSBpcyBHUEEsIGJ1dCBub3QgYWxs
Lg0KPiANCj4gV2VsbCwgSSB0aG91Z2h0IHZob3N0IGhhcyBhIHNpbWlsYXIgZGVzaWduLCB0aGF0
IHRoZSBpbmRleCBvZiBpdHMgbWVtIHRhYmxlDQo+IGlzIEdQQSB3aGVuIHZJT01NVSBpcyBvZmYg
YW5kIHRoZW4gYmVjb21lcyBJT1ZBIHdoZW4gdklPTU1VIGlzIG9uLg0KPiBCdXQgSSBtYXkgYmUg
d3JvbmcgaGVyZS4gSmFzb24sIGNhbiB5b3UgaGVscCBjbGFyaWZ5PyBJIHNhdyB0d28NCj4gaW50
ZXJmYWNlcyB3aGljaCBwb2tlIHRoZSBtZW0gdGFibGU6IFZIT1NUX1NFVF9NRU1fVEFCTEUgKGZv
ciBHUEEpDQo+IGFuZCBWSE9TVF9JT1RMQl9VUERBVEUgKGZvciBJT1ZBKS4gQXJlIHRoZXkgdXNl
ZCBleGNsdXNpdmVseSBvcg0KPiB0b2dldGhlcj8NCj4gDQo+ID4NCj4gPiA+ID4gRm9yIFZGSU8g
Y2FzZSwgdGhlIG9ubHkgYWR2YW50YWdlcyBvZiB1c2luZyBHUEEgaXMgdGhhdCB0aGUgbG9nIGNh
bg0KPiB0aGVuDQo+ID4gPiA+IGJlIHNoYXJlZCBhbW9uZyBhbGwgdGhlIGRldmljZXMgdGhhdCBi
ZWxvbmdzIHRvIHRoZSBWTS4gT3RoZXJ3aXNlDQo+ID4gPiA+IHN5bmNpbmcgdGhyb3VnaCBJT1ZB
IGlzIGNsZWFuZXIuDQo+ID4gPg0KPiA+ID4gSSBzdGlsbCB3b3JyeSBhYm91dCB0aGUgcG90ZW50
aWFsIHBlcmZvcm1hbmNlIGltcGFjdCB3aXRoIHRoaXMgYXBwcm9hY2guDQo+ID4gPiBJbiBjdXJy
ZW50IG1kZXYgbGl2ZSBtaWdyYXRpb24gc2VyaWVzLCB0aGVyZSBhcmUgbXVsdGlwbGUgc3lzdGVt
IGNhbGxzDQo+ID4gPiBpbnZvbHZlZCB3aGVuIHJldHJpZXZpbmcgdGhlIGRpcnR5IGJpdG1hcCBp
bmZvcm1hdGlvbiBmb3IgYSBnaXZlbg0KPiBtZW1vcnkNCj4gPiA+IHJhbmdlLiBJT1ZBIG1hcHBp
bmdzIG1pZ2h0IGJlIGNoYW5nZWQgZnJlcXVlbnRseS4gVGhvdWdoIG9uZSBtYXkNCj4gPiA+IGFy
Z3VlIHRoYXQgZnJlcXVlbnQgSU9WQSBjaGFuZ2UgYWxyZWFkeSBoYXMgYmFkIHBlcmZvcm1hbmNl
LCBpdCdzIHN0aWxsDQo+ID4gPiBub3QgZ29vZCB0byBpbnRyb2R1Y2UgZnVydGhlciBub24tbmVn
bGlnaWJsZSBvdmVyaGVhZCBpbiBzdWNoIHNpdHVhdGlvbi4NCj4gPiA+DQo+ID4gPiBPbiB0aGUg
b3RoZXIgaGFuZCwgSSByZWFsaXplZCB0aGF0IGFkZGluZyBJT1ZBIGF3YXJlbmVzcyBpbiBWRklP
IGlzDQo+ID4gPiBhY3R1YWxseSBlYXN5LiBUb2RheSBWRklPIGFscmVhZHkgbWFpbnRhaW5zIGEg
ZnVsbCBsaXN0IG9mIElPVkEgYW5kIGl0cw0KPiA+ID4gYXNzb2NpYXRlZCBIVkEgaW4gdmZpb19k
bWEgc3RydWN0dXJlLCBhY2NvcmRpbmcgdG8gVkZJT19NQVAgYW5kDQo+ID4gPiBWRklPX1VOTUFQ
LiBBcyBsb25nIGFzIHdlIGFsbG93IHRoZSBsYXR0ZXIgdHdvIG9wZXJhdGlvbnMgdG8gYWNjZXB0
DQo+ID4gPiBhbm90aGVyIHBhcmFtZXRlciAoR1BBKSwgSU9WQS0+R1BBIG1hcHBpbmcgY2FuIGJl
IG5hdHVyYWxseSBjYWNoZWQNCj4gPiA+IGluIGV4aXN0aW5nIHZmaW9fZG1hIG9iamVjdHMuIFRo
b3NlIG9iamVjdHMgYXJlIGFsd2F5cyB1cGRhdGVkDQo+IGFjY29yZGluZw0KPiA+ID4gdG8gTUFQ
IGFuZCBVTk1BUCBpb2N0bHMgdG8gYmUgdXAtdG8tZGF0ZS4gUWVtdSB0aGVuIHVuaWZvcm1seQ0K
PiA+ID4gcmV0cmlldmVzIHRoZSBWRklPIGRpcnR5IGJpdG1hcCBmb3IgdGhlIGVudGlyZSBHUEEg
cmFuZ2UgaW4gZXZlcnkgcHJlLQ0KPiBjb3B5DQo+ID4gPiByb3VuZCwgcmVnYXJkbGVzcyBvZiB3
aGV0aGVyIHZJT01NVSBpcyBlbmFibGVkLiBUaGVyZSBpcyBubyBuZWVkIG9mDQo+ID4gPiBhbm90
aGVyIElPVExCIGltcGxlbWVudGF0aW9uLCB3aXRoIHRoZSBtYWluIGFzayBvbiBhIHYyIE1BUC9V
Tk1BUA0KPiA+ID4gaW50ZXJmYWNlLg0KPiA+ID4NCj4gPiA+IEFsZXgsIHlvdXIgdGhvdWdodHM/
DQo+ID4NCj4gPiBTYW1lIGFzIGxhc3QgdGltZSwgeW91J3JlIGFza2luZyBWRklPIHRvIGJlIGF3
YXJlIG9mIGFuIGVudGlyZWx5IG5ldw0KPiA+IGFkZHJlc3Mgc3BhY2UgYW5kIGltcGxlbWVudCB0
cmFja2luZyBzdHJ1Y3R1cmVzIG9mIHRoYXQgYWRkcmVzcyBzcGFjZQ0KPiA+IHRvIG1ha2UgbGlm
ZSBlYXNpZXIgZm9yIFFFTVUuICBEb24ndCB3ZSB0eXBpY2FsbHkgcHVzaCBzdWNoIGNvbXBsZXhp
dHkNCj4gPiB0byB1c2Vyc3BhY2UgcmF0aGVyIHRoYW4gaW50byB0aGUga2VybmVsPyAgSSdtIG5v
dCBjb252aW5jZWQuICBUaGFua3MsDQo+ID4NCj4gDQo+IElzIGl0IHJlYWxseSBjb21wbGV4PyBO
byBuZWVkIG9mIGEgbmV3IHRyYWNraW5nIHN0cnVjdHVyZS4gSnVzdCBhbGxvd2luZw0KPiB0aGUg
TUFQIGludGVyZmFjZSB0byBjYXJyeSBhIG5ldyBwYXJhbWV0ZXIgYW5kIHRoZW4gcmVjb3JkIGl0
IGluIHRoZQ0KPiBleGlzdGluZyB2ZmlvX2RtYSBvYmplY3RzLg0KPiANCj4gTm90ZSB0aGUgZnJl
cXVlbmN5IG9mIGd1ZXN0IERNQSBtYXAvdW5tYXAgY291bGQgYmUgdmVyeSBoaWdoLiBXZQ0KPiBz
YXcgPjEwMEsgaW52b2NhdGlvbnMgcGVyIHNlY29uZCB3aXRoIGEgNDBHIE5JQy4gVG8gZG8gdGhl
IHJpZ2h0DQo+IHRyYW5zbGF0aW9uIFFlbXUgcmVxdWlyZXMgbG9nX3N5bmMgZm9yIGV2ZXJ5IHVu
bWFwLCBiZWZvcmUgdGhlDQo+IG1hcHBpbmcgZm9yIGxvZ2dlZCBkaXJ0eSBJT1ZBIGJlY29tZXMg
c3RhbGUuIEluIGN1cnJlbnQgS2lydGkncyBwYXRjaCwNCj4gZWFjaCBsb2dfc3luYyByZXF1aXJl
cyBzZXZlcmFsIHN5c3RlbV9jYWxscyB0aHJvdWdoIHRoZSBtaWdyYXRpb24NCj4gaW5mbywgZS5n
LiBzZXR0aW5nIHN0YXJ0X3Bmbi9wYWdlX3NpemUvdG90YWxfcGZucyBhbmQgdGhlbiByZWFkaW5n
DQo+IGRhdGFfb2Zmc2V0L2RhdGFfc2l6ZS4gVGhhdCBkZXNpZ24gaXMgZmluZSBmb3IgZG9pbmcg
bG9nX3N5bmMgaW4gZXZlcnkNCj4gcHJlLWNvcHkgcm91bmQsIGJ1dCB0b28gY29zdGx5IGlmIGRv
aW5nIHNvIGZvciBldmVyeSBJT1ZBIHVubWFwLiBJZg0KPiBzbWFsbCBleHRlbnNpb24gaW4ga2Vy
bmVsIGNhbiBsZWFkIHRvIGdyZWF0IG92ZXJoZWFkIHJlZHVjdGlvbiwNCj4gd2h5IG5vdD8NCj4g
DQoNClRoZXJlIGlzIGFub3RoZXIgdmFsdWUgb2YgcmVjb3JkaW5nIEdQQSBpbiBWRklPLiBWZW5k
b3IgZHJpdmVycyAoZS5nLg0KR1ZULWcpIG1heSBuZWVkIHRvIHNlbGVjdGl2ZWx5IHdyaXRlLXBy
b3RlY3QgZ3Vlc3QgbWVtb3J5IHBhZ2VzDQp3aGVuIGludGVycHJldGluZyBjZXJ0YWluIHdvcmts
b2FkIGRlc2NyaXB0b3JzLiBUaG9zZSBwYWdlcyBhcmUNCnJlY29yZGVkIGluIElPVkEgd2hlbiB2
SU9NTVUgaXMgZW5hYmxlZCwgaG93ZXZlciB0aGUgS1ZNIA0Kd3JpdGUtcHJvdGVjdGlvbiBBUEkg
b25seSBrbm93cyBHUEEuIFNvIGN1cnJlbnRseSB2SU9NTVUgbXVzdA0KYmUgZGlzYWJsZWQgb24g
SW50ZWwgdkdQVXMgd2hlbiBHVlQtZyBpcyBlbmFibGVkLiBUbyBtYWtlIGl0IHdvcmtpbmcNCndl
IG5lZWQgYSB3YXkgdG8gdHJhbnNsYXRlIElPVkEgaW50byBHUEEgaW4gdGhlIHZlbmRvciBkcml2
ZXJzLiBUaGVyZQ0KYXJlIHR3byBvcHRpb25zLiBPbmUgaXMgaGF2aW5nIEtWTSBleHBvcnQgYSBu
ZXcgQVBJIGZvciBzdWNoIA0KdHJhbnNsYXRpb24gcHVycG9zZS4gQnV0IGFzIHlvdSBleHBsYWlu
ZWQgZWFybGllciBpdCdzIG5vdCBnb29kIHRvDQpoYXZlIHZlbmRvciBkcml2ZXJzIGRlcGVuZCBv
biBLVk0uIFRoZSBvdGhlciBpcyBoYXZpbmcgVkZJTw0KbWFpbnRhaW5pbmcgc3VjaCBrbm93bGVk
Z2UgdGhyb3VnaCBleHRlbmRlZCBNQVAgaW50ZXJmYWNlLCANCnRoZW4gcHJvdmlkaW5nIGEgdW5p
Zm9ybSBBUEkgZm9yIGFsbCB2ZW5kb3IgZHJpdmVycyB0byB1c2UuDQoNClRoYW5rcw0KS2V2aW4N
CiANCg==

