Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB637C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B09E20862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B09E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9FX-0002Fw-Mn
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 04:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iA9AJ-0005ph-5K
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iA9AG-0002qj-QW
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:48:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:4258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iA9AG-0002gZ-AS
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:48:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Sep 2019 01:48:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,515,1559545200"; d="scan'208";a="187399750"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga007.fm.intel.com with ESMTP; 17 Sep 2019 01:48:39 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Sep 2019 01:48:39 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Sep 2019 01:48:38 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.53]) with mapi id 14.03.0439.000;
 Tue, 17 Sep 2019 16:48:36 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>
Thread-Topic: [Qemu-devel] vhost, iova, and dirty page tracking
Thread-Index: AdVsLg/AAnCsYtAES/qfxc77B9v7gf//8I+A//3tsaA=
Date: Tue, 17 Sep 2019 08:48:36 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
In-Reply-To: <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGIzZDBjY2EtMTA0My00NDBjLTk0OTYtZDAxN2I2YzdiMzAwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTjY2VHJOQUhiWWVKNDNrVEFCMXV2SHVjcTExam1kd1NmS1ZuQ1BZVklaUkRLUmdnVWFvaGFDaUdNd2hmT1cxRCJ9
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
Cc: 'Alex Williamson' <alex.williamson@redhat.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gU2VudDog
TW9uZGF5LCBTZXB0ZW1iZXIgMTYsIDIwMTkgNDozMyBQTQ0KPiANCj4gDQo+IE9uIDIwMTkvOS8x
NiDkuIrljYg5OjUxLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPiBIaSwgSmFzb24NCj4gPg0KPiA+
IFdlIGhhZCBhIGRpc2N1c3Npb24gYWJvdXQgZGlydHkgcGFnZSB0cmFja2luZyBpbiBWRklPLCB3
aGVuIHZJT01NVQ0KPiA+IGlzIGVuYWJsZWQ6DQo+ID4NCj4gPiBodHRwczovL2xpc3RzLm5vbmdu
dS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOS0NCj4gMDkvbXNnMDI2OTAuaHRtbA0K
PiA+DQo+ID4gSXQncyBhY3R1YWxseSBhIHNpbWlsYXIgbW9kZWwgYXMgdmhvc3QgLSBRZW11IGNh
bm5vdCBpbnRlcnBvc2UgdGhlIGZhc3QtDQo+IHBhdGgNCj4gPiBETUFzIHRodXMgcmVsaWVzIG9u
IHRoZSBrZXJuZWwgcGFydCB0byB0cmFjayBhbmQgcmVwb3J0IGRpcnR5IHBhZ2UNCj4gaW5mb3Jt
YXRpb24uDQo+ID4gQ3VycmVudGx5IFFlbXUgdHJhY2tzIGRpcnR5IHBhZ2VzIGluIEdGTiBsZXZl
bCwgdGh1cyBkZW1hbmRpbmcgYQ0KPiB0cmFuc2xhdGlvbg0KPiA+IGZyb20gSU9WQSB0byBHUEEu
IFRoZW4gdGhlIG9wZW4gaW4gb3VyIGRpc2N1c3Npb24gaXMgd2hlcmUgdGhpcw0KPiB0cmFuc2xh
dGlvbg0KPiA+IHNob3VsZCBoYXBwZW4uIERvaW5nIHRoZSB0cmFuc2xhdGlvbiBpbiBrZXJuZWwg
aW1wbGllcyBhIGRldmljZSBpb3RsYg0KPiBmbGF2b3IsDQo+ID4gd2hpY2ggaXMgd2hhdCB2aG9z
dCBpbXBsZW1lbnRzIHRvZGF5LiBJdCByZXF1aXJlcyBwb3RlbnRpYWxseSBsYXJnZQ0KPiB0cmFj
a2luZw0KPiA+IHN0cnVjdHVyZXMgaW4gdGhlIGhvc3Qga2VybmVsLCBidXQgbGV2ZXJhZ2luZyB0
aGUgZXhpc3RpbmcgbG9nX3N5bmMgZmxvdyBpbg0KPiBRZW11Lg0KPiA+IE9uIHRoZSBvdGhlciBo
YW5kLCBRZW11IG1heSBwZXJmb3JtIGxvZ19zeW5jIGZvciBldmVyeSByZW1vdmFsIG9mDQo+IElP
VkENCj4gPiBtYXBwaW5nIGFuZCB0aGVuIGRvIHRoZSB0cmFuc2xhdGlvbiBpdHNlbGYsIHRoZW4g
YXZvaWRpbmcgdGhlIEdQQQ0KPiBhd2FyZW5lc3MNCj4gPiBpbiB0aGUga2VybmVsIHNpZGUuIEl0
IG5lZWRzIHNvbWUgY2hhbmdlIHRvIGN1cnJlbnQgUWVtdSBsb2ctc3luYyBmbG93LA0KPiBhbmQN
Cj4gPiBtYXkgYnJpbmcgbW9yZSBvdmVyaGVhZCBpZiBJT1ZBIGlzIGZyZXF1ZW50bHkgdW5tYXBw
ZWQuDQo+ID4NCj4gPiBTbyB3ZSdkIGxpa2UgdG8gaGVhciBhYm91dCB5b3VyIG9waW5pb25zLCBl
c3BlY2lhbGx5IGFib3V0IGhvdyB5b3UgY2FtZQ0KPiA+IGRvd24gdG8gdGhlIGN1cnJlbnQgaW90
bGIgYXBwcm9hY2ggZm9yIHZob3N0Lg0KPiANCj4gDQo+IFdlIGRvbid0IGNvbnNpZGVyIHRvbyBt
dWNoIGluIHRoZSBwb2ludCB3aGVuIGludHJvZHVjaW5nIHZob3N0LiBBbmQNCj4gYmVmb3JlIElP
VExCLCB2aG9zdCBoYXMgYWxyZWFkeSBrbm93IEdQQSB0aHJvdWdoIGl0cyBtZW0gdGFibGUNCj4g
KEdQQS0+SFZBKS4gU28gaXQncyBuYXR1cmUgYW5kIGVhc2llciB0byB0cmFjayBkaXJ0eSBwYWdl
cyBhdCBHUEEgbGV2ZWwNCj4gdGhlbiBpdCB3b24ndCBhbnkgY2hhbmdlcyBpbiB0aGUgZXhpc3Rp
bmcgQUJJLg0KDQpUaGlzIGlzIHRoZSBzYW1lIHNpdHVhdGlvbiBhcyBWRklPLg0KDQo+IA0KPiBG
b3IgVkZJTyBjYXNlLCB0aGUgb25seSBhZHZhbnRhZ2VzIG9mIHVzaW5nIEdQQSBpcyB0aGF0IHRo
ZSBsb2cgY2FuIHRoZW4NCj4gYmUgc2hhcmVkIGFtb25nIGFsbCB0aGUgZGV2aWNlcyB0aGF0IGJl
bG9uZ3MgdG8gdGhlIFZNLiBPdGhlcndpc2UNCj4gc3luY2luZyB0aHJvdWdoIElPVkEgaXMgY2xl
YW5lci4NCg0KSSBzdGlsbCB3b3JyeSBhYm91dCB0aGUgcG90ZW50aWFsIHBlcmZvcm1hbmNlIGlt
cGFjdCB3aXRoIHRoaXMgYXBwcm9hY2guDQpJbiBjdXJyZW50IG1kZXYgbGl2ZSBtaWdyYXRpb24g
c2VyaWVzLCB0aGVyZSBhcmUgbXVsdGlwbGUgc3lzdGVtIGNhbGxzIA0KaW52b2x2ZWQgd2hlbiBy
ZXRyaWV2aW5nIHRoZSBkaXJ0eSBiaXRtYXAgaW5mb3JtYXRpb24gZm9yIGEgZ2l2ZW4gbWVtb3J5
DQpyYW5nZS4gSU9WQSBtYXBwaW5ncyBtaWdodCBiZSBjaGFuZ2VkIGZyZXF1ZW50bHkuIFRob3Vn
aCBvbmUgbWF5DQphcmd1ZSB0aGF0IGZyZXF1ZW50IElPVkEgY2hhbmdlIGFscmVhZHkgaGFzIGJh
ZCBwZXJmb3JtYW5jZSwgaXQncyBzdGlsbA0Kbm90IGdvb2QgdG8gaW50cm9kdWNlIGZ1cnRoZXIg
bm9uLW5lZ2xpZ2libGUgb3ZlcmhlYWQgaW4gc3VjaCBzaXR1YXRpb24uDQoNCk9uIHRoZSBvdGhl
ciBoYW5kLCBJIHJlYWxpemVkIHRoYXQgYWRkaW5nIElPVkEgYXdhcmVuZXNzIGluIFZGSU8gaXMN
CmFjdHVhbGx5IGVhc3kuIFRvZGF5IFZGSU8gYWxyZWFkeSBtYWludGFpbnMgYSBmdWxsIGxpc3Qg
b2YgSU9WQSBhbmQgaXRzIA0KYXNzb2NpYXRlZCBIVkEgaW4gdmZpb19kbWEgc3RydWN0dXJlLCBh
Y2NvcmRpbmcgdG8gVkZJT19NQVAgYW5kIA0KVkZJT19VTk1BUC4gQXMgbG9uZyBhcyB3ZSBhbGxv
dyB0aGUgbGF0dGVyIHR3byBvcGVyYXRpb25zIHRvIGFjY2VwdCANCmFub3RoZXIgcGFyYW1ldGVy
IChHUEEpLCBJT1ZBLT5HUEEgbWFwcGluZyBjYW4gYmUgbmF0dXJhbGx5IGNhY2hlZCANCmluIGV4
aXN0aW5nIHZmaW9fZG1hIG9iamVjdHMuIFRob3NlIG9iamVjdHMgYXJlIGFsd2F5cyB1cGRhdGVk
IGFjY29yZGluZyANCnRvIE1BUCBhbmQgVU5NQVAgaW9jdGxzIHRvIGJlIHVwLXRvLWRhdGUuIFFl
bXUgdGhlbiB1bmlmb3JtbHkgDQpyZXRyaWV2ZXMgdGhlIFZGSU8gZGlydHkgYml0bWFwIGZvciB0
aGUgZW50aXJlIEdQQSByYW5nZSBpbiBldmVyeSBwcmUtY29weSANCnJvdW5kLCByZWdhcmRsZXNz
IG9mIHdoZXRoZXIgdklPTU1VIGlzIGVuYWJsZWQuIFRoZXJlIGlzIG5vIG5lZWQgb2YgDQphbm90
aGVyIElPVExCIGltcGxlbWVudGF0aW9uLCB3aXRoIHRoZSBtYWluIGFzayBvbiBhIHYyIE1BUC9V
Tk1BUCANCmludGVyZmFjZS4gDQoNCkFsZXgsIHlvdXIgdGhvdWdodHM/DQoNClRoYW5rcw0KS2V2
aW4NCg==

