Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59A1C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 01:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99EB20665
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 01:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99EB20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAOqm-0007xS-LQ
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 21:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iAOp9-0006rr-PT
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 21:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iAOp7-0001Rf-0V
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 21:32:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:46753)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iAOp6-0001Oz-HO
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 21:32:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Sep 2019 18:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,518,1559545200"; d="scan'208";a="338173737"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga004.jf.intel.com with ESMTP; 17 Sep 2019 18:31:54 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Sep 2019 18:31:54 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 18:31:53 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 18:31:53 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.92]) with mapi id 14.03.0439.000;
 Wed, 18 Sep 2019 09:31:52 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Thread-Topic: [Qemu-devel] vhost, iova, and dirty page tracking
Thread-Index: AdVsLg/AAnCsYtAES/qfxc77B9v7gf//8I+A//3tsaCABA8DAP/+1FBA
Date: Wed, 18 Sep 2019 01:31:52 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D57AFBA@SHSMSX104.ccr.corp.intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
 <20190917085404.3b063e53@x1.home>
In-Reply-To: <20190917085404.3b063e53@x1.home>
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
X-Received-From: 192.55.52.136
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

PiBGcm9tOiBBbGV4IFdpbGxpYW1zb24gW21haWx0bzphbGV4LndpbGxpYW1zb25AcmVkaGF0LmNv
bV0NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDE3LCAyMDE5IDEwOjU0IFBNDQo+IA0KPiBP
biBUdWUsIDE3IFNlcCAyMDE5IDA4OjQ4OjM2ICswMDAwDQo+ICJUaWFuLCBLZXZpbiIgPGtldmlu
LnRpYW5AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4gPiBGcm9tOiBKYXNvbiBXYW5nIFttYWls
dG86amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gPiA+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDE2
LCAyMDE5IDQ6MzMgUE0NCj4gPiA+DQo+ID4gPg0KPiA+ID4gT24gMjAxOS85LzE2IOS4iuWNiDk6
NTEsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4gPiBIaSwgSmFzb24NCj4gPiA+ID4NCj4gPiA+
ID4gV2UgaGFkIGEgZGlzY3Vzc2lvbiBhYm91dCBkaXJ0eSBwYWdlIHRyYWNraW5nIGluIFZGSU8s
IHdoZW4gdklPTU1VDQo+ID4gPiA+IGlzIGVuYWJsZWQ6DQo+ID4gPiA+DQo+ID4gPiA+IGh0dHBz
Oi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LQ0KPiA+ID4g
MDkvbXNnMDI2OTAuaHRtbA0KPiA+ID4gPg0KPiA+ID4gPiBJdCdzIGFjdHVhbGx5IGEgc2ltaWxh
ciBtb2RlbCBhcyB2aG9zdCAtIFFlbXUgY2Fubm90IGludGVycG9zZSB0aGUgZmFzdC0NCj4gPiA+
IHBhdGgNCj4gPiA+ID4gRE1BcyB0aHVzIHJlbGllcyBvbiB0aGUga2VybmVsIHBhcnQgdG8gdHJh
Y2sgYW5kIHJlcG9ydCBkaXJ0eSBwYWdlDQo+ID4gPiBpbmZvcm1hdGlvbi4NCj4gPiA+ID4gQ3Vy
cmVudGx5IFFlbXUgdHJhY2tzIGRpcnR5IHBhZ2VzIGluIEdGTiBsZXZlbCwgdGh1cyBkZW1hbmRp
bmcgYQ0KPiA+ID4gdHJhbnNsYXRpb24NCj4gPiA+ID4gZnJvbSBJT1ZBIHRvIEdQQS4gVGhlbiB0
aGUgb3BlbiBpbiBvdXIgZGlzY3Vzc2lvbiBpcyB3aGVyZSB0aGlzDQo+ID4gPiB0cmFuc2xhdGlv
bg0KPiA+ID4gPiBzaG91bGQgaGFwcGVuLiBEb2luZyB0aGUgdHJhbnNsYXRpb24gaW4ga2VybmVs
IGltcGxpZXMgYSBkZXZpY2UgaW90bGINCj4gPiA+IGZsYXZvciwNCj4gPiA+ID4gd2hpY2ggaXMg
d2hhdCB2aG9zdCBpbXBsZW1lbnRzIHRvZGF5LiBJdCByZXF1aXJlcyBwb3RlbnRpYWxseSBsYXJn
ZQ0KPiA+ID4gdHJhY2tpbmcNCj4gPiA+ID4gc3RydWN0dXJlcyBpbiB0aGUgaG9zdCBrZXJuZWws
IGJ1dCBsZXZlcmFnaW5nIHRoZSBleGlzdGluZyBsb2dfc3luYyBmbG93DQo+IGluDQo+ID4gPiBR
ZW11Lg0KPiA+ID4gPiBPbiB0aGUgb3RoZXIgaGFuZCwgUWVtdSBtYXkgcGVyZm9ybSBsb2dfc3lu
YyBmb3IgZXZlcnkgcmVtb3ZhbCBvZg0KPiA+ID4gSU9WQQ0KPiA+ID4gPiBtYXBwaW5nIGFuZCB0
aGVuIGRvIHRoZSB0cmFuc2xhdGlvbiBpdHNlbGYsIHRoZW4gYXZvaWRpbmcgdGhlIEdQQQ0KPiA+
ID4gYXdhcmVuZXNzDQo+ID4gPiA+IGluIHRoZSBrZXJuZWwgc2lkZS4gSXQgbmVlZHMgc29tZSBj
aGFuZ2UgdG8gY3VycmVudCBRZW11IGxvZy1zeW5jDQo+IGZsb3csDQo+ID4gPiBhbmQNCj4gPiA+
ID4gbWF5IGJyaW5nIG1vcmUgb3ZlcmhlYWQgaWYgSU9WQSBpcyBmcmVxdWVudGx5IHVubWFwcGVk
Lg0KPiA+ID4gPg0KPiA+ID4gPiBTbyB3ZSdkIGxpa2UgdG8gaGVhciBhYm91dCB5b3VyIG9waW5p
b25zLCBlc3BlY2lhbGx5IGFib3V0IGhvdyB5b3UNCj4gY2FtZQ0KPiA+ID4gPiBkb3duIHRvIHRo
ZSBjdXJyZW50IGlvdGxiIGFwcHJvYWNoIGZvciB2aG9zdC4NCj4gPiA+DQo+ID4gPg0KPiA+ID4g
V2UgZG9uJ3QgY29uc2lkZXIgdG9vIG11Y2ggaW4gdGhlIHBvaW50IHdoZW4gaW50cm9kdWNpbmcg
dmhvc3QuIEFuZA0KPiA+ID4gYmVmb3JlIElPVExCLCB2aG9zdCBoYXMgYWxyZWFkeSBrbm93IEdQ
QSB0aHJvdWdoIGl0cyBtZW0gdGFibGUNCj4gPiA+IChHUEEtPkhWQSkuIFNvIGl0J3MgbmF0dXJl
IGFuZCBlYXNpZXIgdG8gdHJhY2sgZGlydHkgcGFnZXMgYXQgR1BBIGxldmVsDQo+ID4gPiB0aGVu
IGl0IHdvbid0IGFueSBjaGFuZ2VzIGluIHRoZSBleGlzdGluZyBBQkkuDQo+ID4NCj4gPiBUaGlz
IGlzIHRoZSBzYW1lIHNpdHVhdGlvbiBhcyBWRklPLg0KPiANCj4gSXQgaXM/ICBWRklPIGRvZXNu
J3Qga25vdyBHUEFzLCBpdCBvbmx5IGtub3dzIEhWQSwgSFBBLCBhbmQgSU9WQS4gIEluDQo+IHNv
bWUgY2FzZXMgSU9WQSBpcyBHUEEsIGJ1dCBub3QgYWxsLg0KDQpXZWxsLCBJIHRob3VnaHQgdmhv
c3QgaGFzIGEgc2ltaWxhciBkZXNpZ24sIHRoYXQgdGhlIGluZGV4IG9mIGl0cyBtZW0gdGFibGUN
CmlzIEdQQSB3aGVuIHZJT01NVSBpcyBvZmYgYW5kIHRoZW4gYmVjb21lcyBJT1ZBIHdoZW4gdklP
TU1VIGlzIG9uLg0KQnV0IEkgbWF5IGJlIHdyb25nIGhlcmUuIEphc29uLCBjYW4geW91IGhlbHAg
Y2xhcmlmeT8gSSBzYXcgdHdvIA0KaW50ZXJmYWNlcyB3aGljaCBwb2tlIHRoZSBtZW0gdGFibGU6
IFZIT1NUX1NFVF9NRU1fVEFCTEUgKGZvciBHUEEpDQphbmQgVkhPU1RfSU9UTEJfVVBEQVRFIChm
b3IgSU9WQSkuIEFyZSB0aGV5IHVzZWQgZXhjbHVzaXZlbHkgb3IgdG9nZXRoZXI/DQoNCj4gDQo+
ID4gPiBGb3IgVkZJTyBjYXNlLCB0aGUgb25seSBhZHZhbnRhZ2VzIG9mIHVzaW5nIEdQQSBpcyB0
aGF0IHRoZSBsb2cgY2FuIHRoZW4NCj4gPiA+IGJlIHNoYXJlZCBhbW9uZyBhbGwgdGhlIGRldmlj
ZXMgdGhhdCBiZWxvbmdzIHRvIHRoZSBWTS4gT3RoZXJ3aXNlDQo+ID4gPiBzeW5jaW5nIHRocm91
Z2ggSU9WQSBpcyBjbGVhbmVyLg0KPiA+DQo+ID4gSSBzdGlsbCB3b3JyeSBhYm91dCB0aGUgcG90
ZW50aWFsIHBlcmZvcm1hbmNlIGltcGFjdCB3aXRoIHRoaXMgYXBwcm9hY2guDQo+ID4gSW4gY3Vy
cmVudCBtZGV2IGxpdmUgbWlncmF0aW9uIHNlcmllcywgdGhlcmUgYXJlIG11bHRpcGxlIHN5c3Rl
bSBjYWxscw0KPiA+IGludm9sdmVkIHdoZW4gcmV0cmlldmluZyB0aGUgZGlydHkgYml0bWFwIGlu
Zm9ybWF0aW9uIGZvciBhIGdpdmVuIG1lbW9yeQ0KPiA+IHJhbmdlLiBJT1ZBIG1hcHBpbmdzIG1p
Z2h0IGJlIGNoYW5nZWQgZnJlcXVlbnRseS4gVGhvdWdoIG9uZSBtYXkNCj4gPiBhcmd1ZSB0aGF0
IGZyZXF1ZW50IElPVkEgY2hhbmdlIGFscmVhZHkgaGFzIGJhZCBwZXJmb3JtYW5jZSwgaXQncyBz
dGlsbA0KPiA+IG5vdCBnb29kIHRvIGludHJvZHVjZSBmdXJ0aGVyIG5vbi1uZWdsaWdpYmxlIG92
ZXJoZWFkIGluIHN1Y2ggc2l0dWF0aW9uLg0KPiA+DQo+ID4gT24gdGhlIG90aGVyIGhhbmQsIEkg
cmVhbGl6ZWQgdGhhdCBhZGRpbmcgSU9WQSBhd2FyZW5lc3MgaW4gVkZJTyBpcw0KPiA+IGFjdHVh
bGx5IGVhc3kuIFRvZGF5IFZGSU8gYWxyZWFkeSBtYWludGFpbnMgYSBmdWxsIGxpc3Qgb2YgSU9W
QSBhbmQgaXRzDQo+ID4gYXNzb2NpYXRlZCBIVkEgaW4gdmZpb19kbWEgc3RydWN0dXJlLCBhY2Nv
cmRpbmcgdG8gVkZJT19NQVAgYW5kDQo+ID4gVkZJT19VTk1BUC4gQXMgbG9uZyBhcyB3ZSBhbGxv
dyB0aGUgbGF0dGVyIHR3byBvcGVyYXRpb25zIHRvIGFjY2VwdA0KPiA+IGFub3RoZXIgcGFyYW1l
dGVyIChHUEEpLCBJT1ZBLT5HUEEgbWFwcGluZyBjYW4gYmUgbmF0dXJhbGx5IGNhY2hlZA0KPiA+
IGluIGV4aXN0aW5nIHZmaW9fZG1hIG9iamVjdHMuIFRob3NlIG9iamVjdHMgYXJlIGFsd2F5cyB1
cGRhdGVkIGFjY29yZGluZw0KPiA+IHRvIE1BUCBhbmQgVU5NQVAgaW9jdGxzIHRvIGJlIHVwLXRv
LWRhdGUuIFFlbXUgdGhlbiB1bmlmb3JtbHkNCj4gPiByZXRyaWV2ZXMgdGhlIFZGSU8gZGlydHkg
Yml0bWFwIGZvciB0aGUgZW50aXJlIEdQQSByYW5nZSBpbiBldmVyeSBwcmUtY29weQ0KPiA+IHJv
dW5kLCByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdklPTU1VIGlzIGVuYWJsZWQuIFRoZXJlIGlzIG5v
IG5lZWQgb2YNCj4gPiBhbm90aGVyIElPVExCIGltcGxlbWVudGF0aW9uLCB3aXRoIHRoZSBtYWlu
IGFzayBvbiBhIHYyIE1BUC9VTk1BUA0KPiA+IGludGVyZmFjZS4NCj4gPg0KPiA+IEFsZXgsIHlv
dXIgdGhvdWdodHM/DQo+IA0KPiBTYW1lIGFzIGxhc3QgdGltZSwgeW91J3JlIGFza2luZyBWRklP
IHRvIGJlIGF3YXJlIG9mIGFuIGVudGlyZWx5IG5ldw0KPiBhZGRyZXNzIHNwYWNlIGFuZCBpbXBs
ZW1lbnQgdHJhY2tpbmcgc3RydWN0dXJlcyBvZiB0aGF0IGFkZHJlc3Mgc3BhY2UNCj4gdG8gbWFr
ZSBsaWZlIGVhc2llciBmb3IgUUVNVS4gIERvbid0IHdlIHR5cGljYWxseSBwdXNoIHN1Y2ggY29t
cGxleGl0eQ0KPiB0byB1c2Vyc3BhY2UgcmF0aGVyIHRoYW4gaW50byB0aGUga2VybmVsPyAgSSdt
IG5vdCBjb252aW5jZWQuICBUaGFua3MsDQo+IA0KDQpJcyBpdCByZWFsbHkgY29tcGxleD8gTm8g
bmVlZCBvZiBhIG5ldyB0cmFja2luZyBzdHJ1Y3R1cmUuIEp1c3QgYWxsb3dpbmcNCnRoZSBNQVAg
aW50ZXJmYWNlIHRvIGNhcnJ5IGEgbmV3IHBhcmFtZXRlciBhbmQgdGhlbiByZWNvcmQgaXQgaW4g
dGhlDQpleGlzdGluZyB2ZmlvX2RtYSBvYmplY3RzLg0KDQpOb3RlIHRoZSBmcmVxdWVuY3kgb2Yg
Z3Vlc3QgRE1BIG1hcC91bm1hcCBjb3VsZCBiZSB2ZXJ5IGhpZ2guIFdlDQpzYXcgPjEwMEsgaW52
b2NhdGlvbnMgcGVyIHNlY29uZCB3aXRoIGEgNDBHIE5JQy4gVG8gZG8gdGhlIHJpZ2h0DQp0cmFu
c2xhdGlvbiBRZW11IHJlcXVpcmVzIGxvZ19zeW5jIGZvciBldmVyeSB1bm1hcCwgYmVmb3JlIHRo
ZQ0KbWFwcGluZyBmb3IgbG9nZ2VkIGRpcnR5IElPVkEgYmVjb21lcyBzdGFsZS4gSW4gY3VycmVu
dCBLaXJ0aSdzIHBhdGNoLA0KZWFjaCBsb2dfc3luYyByZXF1aXJlcyBzZXZlcmFsIHN5c3RlbV9j
YWxscyB0aHJvdWdoIHRoZSBtaWdyYXRpb24NCmluZm8sIGUuZy4gc2V0dGluZyBzdGFydF9wZm4v
cGFnZV9zaXplL3RvdGFsX3BmbnMgYW5kIHRoZW4gcmVhZGluZw0KZGF0YV9vZmZzZXQvZGF0YV9z
aXplLiBUaGF0IGRlc2lnbiBpcyBmaW5lIGZvciBkb2luZyBsb2dfc3luYyBpbiBldmVyeQ0KcHJl
LWNvcHkgcm91bmQsIGJ1dCB0b28gY29zdGx5IGlmIGRvaW5nIHNvIGZvciBldmVyeSBJT1ZBIHVu
bWFwLiBJZg0Kc21hbGwgZXh0ZW5zaW9uIGluIGtlcm5lbCBjYW4gbGVhZCB0byBncmVhdCBvdmVy
aGVhZCByZWR1Y3Rpb24sDQp3aHkgbm90Pw0KDQpUaGFua3MNCktldmluDQo=

