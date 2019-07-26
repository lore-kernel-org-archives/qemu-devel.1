Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6BAC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 05:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FEE21951
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 05:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FEE21951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqsd5-0002u2-5K
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 01:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58116)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hqscs-0002VC-3s
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 01:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hqscp-0003cc-B1
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 01:18:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:9619)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hqsco-0003FU-WA
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 01:18:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Jul 2019 22:18:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,309,1559545200"; d="scan'208";a="194103352"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga004.fm.intel.com with ESMTP; 25 Jul 2019 22:18:30 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 25 Jul 2019 22:18:29 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 25 Jul 2019 22:18:29 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 25 Jul 2019 22:18:29 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.112]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.163]) with mapi id 14.03.0439.000;
 Fri, 26 Jul 2019 13:18:28 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, David Gibson
 <david@gibson.dropbear.id.au>
Thread-Topic: [RFC v1 05/18] vfio/pci: add pasid alloc/free implementation
Thread-Index: AQHVM+ylZdJ7a+KBXU2HFFh5qj+Ya6bKg4OAgAJ3NWCAALChAIAIjcJAgADufICAAiiQ4P//x3sAgANbHuA=
Date: Fri, 26 Jul 2019 05:18:28 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A022E63@SHSMSX104.ccr.corp.intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-6-git-send-email-yi.l.liu@intel.com>
 <20190715025519.GE3440@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A00D8BB@SHSMSX104.ccr.corp.intel.com>
 <20190717030640.GG9123@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A0140E0@SHSMSX104.ccr.corp.intel.com>
 <20190723035741.GR25073@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A0160C9@SHSMSX104.ccr.corp.intel.com>
 <abf336b6-4c51-7742-44aa-5b51c8ea4af7@redhat.com>
In-Reply-To: <abf336b6-4c51-7742-44aa-5b51c8ea4af7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmI5NjQ3ODYtMjZjMS00MGQxLTg2YzEtOTRiNGU5N2NmYzg3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMlhwV2w1V3kwblZYY1BQSERiUkpXZEUyMGFhSzgweXlicElHc3FtaGNaVkt1eFwvMXRXck45Yno1TkZUWnJLUTgifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] [RFC v1 05/18] vfio/pci: add pasid alloc/free
 implementation
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
 "peterx@redhat.com" <peterx@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBdWdlciBF
cmljIFttYWlsdG86ZXJpYy5hdWdlckByZWRoYXQuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIEp1
bHkgMjQsIDIwMTkgNTozMyBQTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+
OyBEYXZpZCBHaWJzb24gPGRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdT4NCj4gU3ViamVjdDog
UmU6IFtSRkMgdjEgMDUvMThdIHZmaW8vcGNpOiBhZGQgcGFzaWQgYWxsb2MvZnJlZSBpbXBsZW1l
bnRhdGlvbg0KPiANCj4gSGkgWWksIERhdmlkLA0KPiANCj4gT24gNy8yNC8xOSA2OjU3IEFNLCBM
aXUsIFlpIEwgd3JvdGU6DQo+ID4+IEZyb206IGt2bS1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21h
aWx0bzprdm0tb3duZXJAdmdlci5rZXJuZWwub3JnXSBPbg0KPiA+PiBCZWhhbGYgT2YgRGF2aWQg
R2lic29uDQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjMsIDIwMTkgMTE6NTggQU0NCj4gPj4g
VG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1JG
QyB2MSAwNS8xOF0gdmZpby9wY2k6IGFkZCBwYXNpZCBhbGxvYy9mcmVlDQo+ID4+IGltcGxlbWVu
dGF0aW9uDQo+ID4+DQo+ID4+IE9uIE1vbiwgSnVsIDIyLCAyMDE5IGF0IDA3OjAyOjUxQU0gKzAw
MDAsIExpdSwgWWkgTCB3cm90ZToNCj4gPj4+PiBGcm9tOiBrdm0tb3duZXJAdmdlci5rZXJuZWwu
b3JnIFttYWlsdG86a3ZtLW93bmVyQHZnZXIua2VybmVsLm9yZ10NCj4gPj4+PiBPbiBCZWhhbGYg
T2YgRGF2aWQgR2lic29uDQo+ID4+Pj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDE3LCAyMDE5IDEx
OjA3IEFNDQo+ID4+Pj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+Pj4+
IFN1YmplY3Q6IFJlOiBbUkZDIHYxIDA1LzE4XSB2ZmlvL3BjaTogYWRkIHBhc2lkIGFsbG9jL2Zy
ZWUNCj4gPj4+PiBpbXBsZW1lbnRhdGlvbg0KPiA+Pj4+DQo+ID4+Pj4gT24gVHVlLCBKdWwgMTYs
IDIwMTkgYXQgMTA6MjU6NTVBTSArMDAwMCwgTGl1LCBZaSBMIHdyb3RlOg0KPiA+Pj4+Pj4gRnJv
bToga3ZtLW93bmVyQHZnZXIua2VybmVsLm9yZw0KPiA+Pj4+Pj4gW21haWx0bzprdm0tb3duZXJA
dmdlci5rZXJuZWwub3JnXSBPbg0KPiA+Pj4+IEJlaGFsZg0KPiA+Pj4+Pj4gT2YgRGF2aWQgR2li
c29uDQo+ID4+Pj4+PiBTZW50OiBNb25kYXksIEp1bHkgMTUsIDIwMTkgMTA6NTUgQU0NCj4gPj4+
Pj4+IFRvOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPj4+Pj4+IFN1YmplY3Q6
IFJlOiBbUkZDIHYxIDA1LzE4XSB2ZmlvL3BjaTogYWRkIHBhc2lkIGFsbG9jL2ZyZWUNCj4gPj4+
Pj4+IGltcGxlbWVudGF0aW9uDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gT24gRnJpLCBKdWwgMDUsIDIw
MTkgYXQgMDc6MDE6MzhQTSArMDgwMCwgTGl1IFlpIEwgd3JvdGU6DQo+ID4+Pj4+Pj4gVGhpcyBw
YXRjaCBhZGRzIHZmaW8gaW1wbGVtZW50YXRpb24gUENJUEFTSURPcHMuYWxsb2NfcGFzaWQvZnJl
ZV9wYXNpZCgpLg0KPiA+Pj4+Pj4+IFRoZXNlIHR3byBmdW5jdGlvbnMgYXJlIHVzZWQgdG8gcHJv
cGFnYXRlIGd1ZXN0IHBhc2lkIGFsbG9jYXRpb24NCj4gPj4+Pj4+PiBhbmQgZnJlZSByZXF1ZXN0
cyB0byBob3N0IHZpYSB2ZmlvIGNvbnRhaW5lciBpb2N0bC4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBB
cyBJIHNhaWQgaW4gYW4gZWFybGllciBjb21tZW50LCBJIHRoaW5rIGRvaW5nIHRoaXMgb24gdGhl
IGRldmljZQ0KPiA+Pj4+Pj4gaXMgY29uY2VwdHVhbGx5IGluY29ycmVjdC4gIEkgdGhpbmsgd2Ug
bmVlZCBhbiBleHBsY2l0IG5vdGlvbiBvZg0KPiA+Pj4+Pj4gYW4gU1ZNIGNvbnRleHQgKGkuZS4g
dGhlIG5hbWVzcGFjZSBpbiB3aGljaCBhbGwgdGhlIFBBU0lEcyBsaXZlKQ0KPiA+Pj4+Pj4gLSB3
aGljaCB3aWxsIElJVUMgdXN1YWxseSBiZSBzaGFyZWQgYW1vbmdzdCBtdWx0aXBsZSBkZXZpY2Vz
Lg0KPiA+Pj4+Pj4gVGhlIGNyZWF0ZSBhbmQgZnJlZSBQQVNJRCByZXF1ZXN0cyBzaG91bGQgYmUg
b24gdGhhdCBvYmplY3QuDQo+ID4+Pj4+DQo+ID4+Pj4+IEFjdHVhbGx5LCB0aGUgYWxsb2NhdGlv
biBpcyBub3QgZG9pbmcgb24gdGhpcyBkZXZpY2UuIFN5c3RlbSB3aWRlLA0KPiA+Pj4+PiBpdCBp
cyBkb25lIG9uIGEgY29udGFpbmVyLiBTbyBub3Qgc3VyZSBpZiBpdCBpcyB0aGUgQVBJIGludGVy
ZmFjZQ0KPiA+Pj4+PiBnaXZlcyB5b3UgYSBzZW5zZSB0aGF0IHRoaXMgaXMgZG9uZSBvbiBkZXZp
Y2UuDQo+ID4+Pj4NCj4gPj4+PiBTb3JyeSwgSSBzaG91bGQgaGF2ZSBiZWVuIGNsZWFyZXIuICBJ
IGNhbiBzZWUgdGhhdCBhdCB0aGUgVkZJTw0KPiA+Pj4+IGxldmVsIGl0IGlzIGRvbmUgb24gdGhl
IGNvbnRhaW5lci4gIEhvd2V2ZXIgdGhlIGZ1bmN0aW9uIGhlcmUgdGFrZXMNCj4gPj4+PiBhIGJ1
cyBhbmQgZGV2Zm4sIHNvIHRoaXMgcWVtdSBpbnRlcm5hbCBpbnRlcmZhY2UgaXMgcGVyLWRldmlj
ZSwNCj4gPj4+PiB3aGljaCBkb2Vzbid0IHJlYWxseSBtYWtlIHNlbnNlLg0KPiA+Pj4NCj4gPj4+
IEdvdCBpdC4gVGhlIHJlYXNvbiBoZXJlIGlzIHRvIHBhc3MgdGhlIGJ1cyBhbmQgZGV2Zm4gaW5m
bywgc28gdGhhdA0KPiA+Pj4gVkZJTyBjYW4gZmlndXJlIG91dCBhIGNvbnRhaW5lciBmb3IgdGhl
IG9wZXJhdGlvbi4gU28gZmFyIGluIFFFTVUsDQo+ID4+PiB0aGVyZSBpcyBubyBnb29kIHdheSB0
byBjb25uZWN0IHRoZSB2SU9NTVUgZW11bGF0b3IgYW5kIFZGSU8gcmVnYXJkcw0KPiA+Pj4gdG8g
U1ZNLg0KPiA+Pg0KPiA+PiBSaWdodCwgYW5kIEkgdGhpbmsgdGhhdCdzIGFuIGluZGljYXRpb24g
dGhhdCB3ZSdyZSBub3QgbW9kZWxsaW5nDQo+ID4+IHNvbWV0aGluZyBpbiBxZW11IHRoYXQgd2Ug
c2hvdWxkIGJlLg0KPiA+Pg0KPiA+Pj4gaHcvcGNpIGxheWVyIGlzIGEgY2hvaWNlIGJhc2VkIG9u
IHNvbWUgcHJldmlvdXMgZGlzY3Vzc2lvbi4gQnV0IHllcywNCj4gPj4+IEkgYWdyZWUgd2l0aCB5
b3UgdGhhdCB3ZSBtYXkgbmVlZCB0byBoYXZlIGFuIGV4cGxpY2l0IG5vdGlvbiBmb3INCj4gPj4+
IFNWTS4gRG8geW91IHRoaW5rIGl0IGlzIGdvb2QgdG8gaW50cm9kdWNlIGEgbmV3IGFic3RyYWN0
IGxheWVyIGZvcg0KPiA+Pj4gU1ZNIChtYXkgbmFtZSBhcyBTVk1Db250ZXh0KS4NCj4gPj4NCj4g
Pj4gSSB0aGluayBzbywgeWVzLg0KPiA+Pg0KPiA+PiBJZiBub3RoaW5nIGVsc2UsIEkgZXhwZWN0
IHdlJ2xsIG5lZWQgdGhpcyBjb25jZXB0IGlmIHdlIGV2ZXIgd2FudCB0bw0KPiA+PiBiZSBhYmxl
IHRvIGltcGxlbWVudCBTVk0gZm9yIGVtdWxhdGVkIGRldmljZXMgKHdoaWNoIGNvdWxkIGJlIHVz
ZWZ1bA0KPiA+PiBmb3IgZGVidWdnaW5nLCBldmVuIGlmIGl0J3Mgbm90IHNvbWV0aGluZyB5b3Un
ZCBkbyBpbiBwcm9kdWN0aW9uKS4NCj4gPj4NCj4gPj4+IFRoZSBpZGVhIHdvdWxkIGJlIHRoYXQg
dklPTU1VIG1haW50YWluIHRoZSBTVk1Db250ZXh0IGluc3RhbmNlcyBhbmQNCj4gPj4+IGV4cG9z
ZSBleHBsaWNpdCBpbnRlcmZhY2UgZm9yIFZGSU8gdG8gZ2V0IGl0LiBUaGVuIFZGSU8gcmVnaXN0
ZXINCj4gPj4+IG5vdGlmaWVycyBvbiB0byB0aGUgU1ZNQ29udGV4dC4gV2hlbiB2SU9NTVUgZW11
bGF0b3Igd2FudHMgdG8gZG8NCj4gPj4+IFBBU0lEIGFsbG9jL2ZyZWUsIGl0IGZpcmVzIHRoZSBj
b3JyZXNwb25kaW5nIG5vdGlmaWVyLiBBZnRlciBjYWxsDQo+ID4+PiBpbnRvIFZGSU8sIHRoZSBu
b3RpZmllciBmdW5jdGlvbiBpdHNlbGYgZmlndXJlIG91dCB0aGUgY29udGFpbmVyIGl0DQo+ID4+
PiBpcyBib3VuZC4gSW4gdGhpcyB3YXksIGl0J3MgdGhlIGR1dHkgb2YgdklPTU1VIGVtdWxhdG9y
IHRvIGZpZ3VyZQ0KPiA+Pj4gb3V0IGEgcHJvcGVyIG5vdGlmaWVyIHRvIGZpcmUuIEZyb20gaW50
ZXJmYWNlIHBvaW50IG9mIHZpZXcsIGl0IGlzDQo+ID4+PiBubyBsb25nZXIgcGVyLWRldmljZS4N
Cj4gPj4NCj4gPj4gRXhhY3RseS4NCj4gPg0KPiA+IENvb2wsIGxldCBtZSBwcmVwYXJlIGFub3Ro
ZXIgdmVyc2lvbiB3aXRoIHRoZSBpZGVhcy4gVGhhbmtzIGZvciB5b3VyDQo+ID4gcmV2aWV3LiA6
LSkNCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gWWkgTGl1DQo+ID4NCj4gPj4+IEFsc28sIGl0IGxl
YXZlcyB0aGUgUEFTSUQgbWFuYWdlbWVudCBkZXRhaWxzIHRvIHZJT01NVSBlbXVsYXRvciBhcw0K
PiA+Pj4gaXQgY2FuIGJlIHZlbmRvciBzcGVjaWZpYy4gRG9lcyBpdCBtYWtlIHNlbnNlPw0KPiA+
Pj4gQWxzbywgSSdkIGxpa2UgdG8ga25vdyBpZiB5b3UgaGF2ZSBhbnkgb3RoZXIgaWRlYSBvbiBp
dC4gVGhhdCB3b3VsZA0KPiA+Pj4gc3VyZWx5IGJlIGhlbHBmdWwuIDotKQ0KPiA+Pj4NCj4gPj4+
Pj4gQWxzbywgY3VyaW91cyBvbiB0aGUgU1ZNIGNvbnRleHQNCj4gPj4+Pj4gY29uY2VwdCwgZG8g
eW91IG1lYW4gaXQgYSBwZXItVk0gY29udGV4dCBvciBhIHBlci1TVk0gdXNhZ2UgY29udGV4dD8N
Cj4gPj4+Pj4gTWF5IHlvdSBlbGFib3JhdGUgYSBsaXR0bGUgbW9yZS4gOi0pDQo+ID4+Pj4NCj4g
Pj4+PiBTb3JyeSwgSSdtIHN0cnVnZ2xpbmcgdG8gZmluZCBhIGdvb2QgdGVybSBmb3IgdGhpcy4g
IEJ5ICJjb250ZXh0IiBJDQo+ID4+Pj4gbWVhbiBhIG5hbWVzcGFjZSBjb250YWluaW5nIGEgYnVu
Y2ggb2YgUEFTSUQgYWRkcmVzcyBzcGFjZXMsIHRob3NlDQo+ID4+Pj4gUEFTSURzIGFyZSB0aGVu
IHZpc2libGUgdG8gc29tZSBncm91cCBvZiBkZXZpY2VzLg0KPiA+Pj4NCj4gPj4+IEkgc2VlLiBN
YXkgYmUgdGhlIFNWTUNvbnRleHQgaW5zdGFuY2UgYWJvdmUgY2FuIGluY2x1ZGUgbXVsdGlwbGUN
Cj4gPj4+IFBBU0lEIGFkZHJlc3Mgc3BhY2VzLiBBbmQgYWdhaW4sIEkgdGhpbmsgdGhpcyByZWxh
dGlvbnNoaXAgc2hvdWxkIGJlDQo+ID4+PiBtYWludGFpbmVkIGluIHZJT01NVSBlbXVsYXRvci4N
Cj4gPg0KPiBTbyBpZiBJIHVuZGVyc3RhbmQgd2Ugbm93IGhlYWQgdG93YXJkcyBpbnRyb2R1Y2lu
ZyBuZXcgbm90aWZpZXJzIHRha2luZyBhDQo+ICJTVk1Db250ZXh0IiBhcyBhcmd1bWVudCBpbnN0
ZWFkIG9mIGFuIElPTU1VTWVtb3J5UmVnaW9uLg0KDQp5ZXMsIHRoaXMgaXMgdGhlIHJvdWdoIGlk
ZWEuDQogDQo+IEkgdGhpbmsgd2UgbmVlZCB0byBiZSBjbGVhciBhYm91dCBob3cgYm90aCBhYnN0
cmFjdGlvbnMgKFNWTUNvbnRleHQgYW5kDQo+IElPTU1VTWVtb3J5UmVnaW9uKSBkaWZmZXIuIEkg
d291bGQgYWxzbyBuZWVkICJTVk1Db250ZXh0IiBhYnN0cmFjdGlvbiBmb3INCj4gMnN0YWdlIFNN
TVUgaW50ZWdyYXRpb24gKHRvIG5vdGlmeSBzdGFnZSAxIGNvbmZpZyBjaGFuZ2VzIGFuZCBNU0kN
Cj4gYmluZGluZ3MpIHNvIEkgd291bGQgbmVlZCB0aGlzIG5ldyBvYmplY3QgdG8gYmUgbm90IHRv
byBtdWNoIHRpZWQgdG8gU1ZNIHVzZSBjYXNlLg0KDQpJIGFncmVlLiBTVk1Db250ZXh0IGlzIGp1
c3QgYSBwcm9wb3NlZCBuYW1lLiBXZSBtYXkgaGF2ZSBiZXR0ZXIgbmFtaW5nIGZvciBpdA0KYXMg
bG9uZyBhcyB0aGUgdGhpbmcgd2Ugd2FudCB0byBoYXZlIGlzIGEgbmV3IGFic3RyYWN0IGxheWVy
IGJldHdlZW4gVkZJTyBhbmQNCnZJT01NVS4gUGVyIG15IHVuZGVyc3RhbmRpbmcsIHRoZSBJT01N
VU1lbW9yeVJlZ2lvbiBhYnN0cmFjdGlvbiBpcyBmb3INCnRoZSBub3RpZmljYXRpb25zIGFyb3Vu
ZCBndWVzdCBtZW1vcnkgY2hhbmdlcy4gZS5nLiBWRklPIG5lZWRzIHRvIGJlIG5vdGlmaWVkDQp3
aGVuIHRoZXJlIGlzIE1BUC9VTk1BUCBoYXBwZW5lZC4gSG93ZXZlciwgZm9yIHRoZSBTVk1Db250
ZXh0LCBpdCBhaW1zIHRvDQpiZSBhbiBhYnN0cmFjdGlvbiBmb3IgU1ZNL1BBU0lEIHJlbGF0ZWQg
b3BlcmF0aW9ucywgd2hpY2ggaGFzIG5vIGRpcmVjdA0KcmVsYXRpb25zaGlwIHdpdGggbWVtb3J5
LiBlLmcuIGZvciBWVC1kLCBwYXNpZCBhbGxvY2F0aW9uLCBwYXNpZCBiaW5kL3VuYmluZCwNCnBh
c2lkIGJhc2VkLWlvdGxiIGZsdXNoLiBJIHRoaW5rIHBhc2lkIGJpbmQvdW5iaW5kIGFuZCBwYXNp
ZCBiYXNlZC1pb3RsYiBmbHVzaCBpcw0KZXF1aXZhbGVudCB3aXRoIHRoZSBzdGFnZSAxIGNvbmZp
ZyBjaGFuZ2VzIGluIFNNTVUuIElmIHlvdSBhZ3JlZSB0byB1c2UgaXQNCmFsbCB0aGUgc2FtZSwg
aG93IGFib3V0IG5hbWluZyBpdCBhcyBJT01NVUNvbmV4dD8gQWxzbywgcGxzIGZlZWwgZnJlZSB0
bw0KcHJvcG9zZSB5b3VyIHN1Z2dlc3Rpb24uIDotKQ0KDQpUaGFua3MsDQpZaSBMaXUNCg0KY2hh
bmdlcy4NCg0KPiBUaGFua3MNCj4gDQo+IEVyaWMNCg0K

