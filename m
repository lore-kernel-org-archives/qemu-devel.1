Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1054BC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCDE206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCDE206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAqhJ-0000bD-Qu
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 03:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iAqgL-00008r-5p
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iAqgJ-0000jE-2e
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:16:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:21151)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iAqgI-0000f7-QP
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:16:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Sep 2019 00:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; d="scan'208";a="189519628"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga003.jf.intel.com with ESMTP; 19 Sep 2019 00:16:38 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Sep 2019 00:16:38 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Sep 2019 00:16:37 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.132]) with mapi id 14.03.0439.000;
 Thu, 19 Sep 2019 15:16:35 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
Thread-Topic: [Qemu-devel] vhost, iova, and dirty page tracking
Thread-Index: AdVsLg/AAnCsYtAES/qfxc77B9v7gf//8I+A//3tsaCAA8b/gP/+jHxggAK7doD//1RiwAA9GJkAAAkwmQAAAXN8gAAAR/kAAAB+N4D//2+WgA==
Date: Thu, 19 Sep 2019 07:16:35 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D57DD2A@SHSMSX104.ccr.corp.intel.com>
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
In-Reply-To: <e0efbdc0-aad9-0d17-ec68-36460865501f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzllMzcxMTItY2ExYS00NWYzLWJhMTUtMDRlMWE0NGJhNWFjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRmt1bEEzWnJMMldpT1RWSkMrTVwvalNVY2hxbTJGazVGRnNYbmF0T3R0VzJOWFJpbTNRa3N2aW9LR3ZhaXltOUwifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 'Alex Williamson' <alex.williamson@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

K1Bhb2xvIHRvIGhlbHAgY2xhcmlmeSBoZXJlLg0KDQo+IEZyb206IEphc29uIFdhbmcgW21haWx0
bzpqYXNvd2FuZ0ByZWRoYXQuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDE5LCAy
MDE5IDI6MzIgUE0NCj4gDQo+IA0KPiBPbiAyMDE5LzkvMTkg5LiL5Y2IMjoxNywgWWFuIFpoYW8g
d3JvdGU6DQo+ID4gT24gVGh1LCBTZXAgMTksIDIwMTkgYXQgMDI6MDk6NTNQTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToNCj4gPj4gT24gMjAxOS85LzE5IOS4i+WNiDE6MjgsIFlhbiBaaGFvIHdy
b3RlOg0KPiA+Pj4gT24gVGh1LCBTZXAgMTksIDIwMTkgYXQgMDk6MDU6MTJBTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToNCj4gPj4+PiBPbiAyMDE5LzkvMTgg5LiL5Y2INDozNywgVGlhbiwgS2V2
aW4gd3JvdGU6DQo+ID4+Pj4+PiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86amFzb3dhbmdAcmVk
aGF0LmNvbV0NCj4gPj4+Pj4+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDE4LCAyMDE5IDI6
MTAgUE0NCj4gPj4+Pj4+DQo+ID4+Pj4+Pj4+IE5vdGUgdGhhdCB0aGUgSFZBIHRvIEdQQSBtYXBw
aW5nIGlzIG5vdCBhbiAxOjEgbWFwcGluZy4gT25lDQo+IEhWQQ0KPiA+Pj4+Pj4gcmFuZ2UNCj4g
Pj4+Pj4+Pj4gY291bGQgYmUgbWFwcGVkIHRvIHNldmVyYWwgR1BBIHJhbmdlcy4NCj4gPj4+Pj4+
PiBUaGlzIGlzIGZpbmUuIEN1cnJlbnRseSB2ZmlvX2RtYSBtYWludGFpbnMgSU9WQS0+SFZBIG1h
cHBpbmcuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBidHcgdW5kZXIgd2hhdCBjb25kaXRpb24gSFZB
LT5HUEEgaXMgbm90IDE6MSBtYXBwaW5nPyBJIGRpZG4ndA0KPiByZWFsaXplIGl0Lg0KPiA+Pj4+
Pj4gSSBkb24ndCByZW1lbWJlciB0aGUgZGV0YWlscyBlLmcgbWVtb3J5IHJlZ2lvbiBhbGlhcz8g
QW5kIG5laXRoZXINCj4ga3ZtDQo+ID4+Pj4+PiBub3Iga3ZtIEFQSSBkb2VzIGZvcmJpZCB0aGlz
IGlmIG15IG1lbW9yeSBpcyBjb3JyZWN0Lg0KPiA+Pj4+Pj4NCj4gPj4+Pj4gSSBjaGVja2VkIGh0
dHBzOi8vcWVtdS53ZWlsbmV0ei5kZS9kb2MvZGV2ZWwvbWVtb3J5Lmh0bWwsIHdoaWNoDQo+ID4+
Pj4+IHByb3ZpZGVzIGFuIGV4YW1wbGUgb2YgYWxpYXNlZCBsYXlvdXQuIEhvd2V2ZXIsIGl0cyBh
bGlhc2luZyBpcyBhbGwNCj4gPj4+Pj4gMToxLCBpbnN0ZWFkIG9mIE46MS4gRnJvbSBndWVzdCBw
Lm8udiBldmVyeSB3cml0YWJsZSBHUEEgaW1wbGllcyBhbg0KPiA+Pj4+PiB1bmlxdWUgbG9jYXRp
b24uIFdoeSB3b3VsZCB3ZSBoaXQgdGhlIHNpdHVhdGlvbiB3aGVyZSBtdWx0aXBsZQ0KPiA+Pj4+
PiB3cml0ZS1hYmxlIEdQQXMgYXJlIG1hcHBlZCB0byB0aGUgc2FtZSBIVkEgKGkuZS4gc2FtZSBw
aHlzaWNhbA0KPiA+Pj4+PiBtZW1vcnkgbG9jYXRpb24pPw0KPiA+Pj4+IEkgZG9uJ3Qga25vdywg
anVzdCB3YW50IHRvIHNheSBjdXJyZW50IEFQSSBkb2VzIG5vdCBmb3JiaWQgdGhpcy4gU28gd2UN
Cj4gPj4+PiBwcm9iYWJseSBuZWVkIHRvIHRha2UgY2FyZSBpdC4NCj4gPj4+Pg0KPiA+Pj4geWVz
LCBpbiBLVk0gQVBJIGxldmVsLCBpdCBkb2VzIG5vdCBmb3JiaWQgdHdvIHNsb3RzIHRvIGhhdmUg
dGhlIHNhbWUNCj4gSFZBKHNsb3QtPnVzZXJzcGFjZV9hZGRyKS4NCj4gPj4+IEJ1dA0KPiA+Pj4g
KDEpIHRoZXJlJ3Mgb25seSBvbmUga3ZtIGluc3RhbmNlIGZvciBlYWNoIHZtIGZvciBlYWNoIHFl
bXUgcHJvY2Vzcy4NCj4gPj4+ICgyKSBhbGwgcmFtYmxvY2stPmhvc3QgKGNvcnJlc3BvbmRzIHRv
IEhWQSBhbmQgc2xvdC0+dXNlcnNwYWNlX2FkZHIpDQo+IGluIG9uZSBxZW11DQo+ID4+PiBwcm9j
ZXNzIGlzIG5vbi1vdmVybGFwcGluZyBhcyBpdCdzIG9idGFpbmVkIGZyb20gbW1tYXAoKS4NCj4g
Pj4+ICgzKSBxZW11IGVuc3VyZXMgdHdvIGt2bSBzbG90cyB3aWxsIG5vdCBwb2ludCB0byB0aGUg
c2FtZSBzZWN0aW9uIG9mDQo+IG9uZSByYW1ibG9jay4NCj4gPj4+DQo+ID4+PiBTbywgYXMgbG9u
ZyBhcyBrdm0gaW5zdGFuY2UgaXMgbm90IHNoYXJlZCBpbiB0d28gcHJvY2Vzc2VzLCBhbmQNCj4g
Pj4+IHRoZXJlJ3Mgbm8gYnVnIGluIHFlbXUsIHdlIGNhbiBhc3N1cmUgdGhhdCBIVkEgdG8gR1BB
IGlzIDE6MS4NCj4gPj4NCj4gPj4gV2VsbCwgeW91IGxlYXZlIHRoaXMgQVBJIGZvciB1c2Vyc3Bh
Y2UsIHNvIHlvdSBjYW4ndCBhc3N1bWUgcWVtdSBpcyB0aGUNCj4gPj4gb25seSB1c2VyIG9yIGFu
eSBpdHMgYmVoYXZpb3IuIElmIHlvdSBoYWQgeW91IHNob3VsZCBsaW1pdCBpdCBpbiB0aGUgQVBJ
DQo+ID4+IGxldmVsIGluc3RlYWQgb2Ygb3BlbiB3aW5kb3cgZm9yIHRoZW0uDQo+ID4+DQo+ID4+
DQo+ID4+PiBCdXQgZXZlbiBpZiB0aGVyZSBhcmUgdHdvIHByb2Nlc3NlcyBvcGVyYXRpbmcgb24g
dGhlIHNhbWUga3ZtDQo+IGluc3RhbmNlDQo+ID4+PiBhbmQgbWFuaXB1bGF0aW5nIG9uIG1lbW9y
eSBzbG90cywgYWRkaW5nIGFuIGV4dHJhIEdQQSBhbG9uZyBzaWRlDQo+IGN1cnJlbnQNCj4gPj4+
IElPVkEgJiBIVkEgdG8gaW9jdGwgVkZJT19JT01NVV9NQVBfRE1BIGNhbiBzdGlsbCBsZXQgZHJp
dmVyIGtub3dzDQo+IHRoZQ0KPiA+Pj4gcmlnaHQgSU9WQS0+R1BBIG1hcHBpbmcsIHJpZ2h0Pw0K
PiA+Pg0KPiA+PiBJdCBsb29rcyBmcmFnaWxlLiBDb25zaWRlciBIVkEgd2FzIG1hcHBlZCB0byBi
b3RoIEdQQTEgYW5kIEdQQTIuDQo+IEd1ZXN0DQo+ID4+IG1hcHMgSU9WQSB0byBHUEEyLCBzbyB3
ZSBoYXZlIElPVkEgR1BBMiBIVkEgaW4gdGhlIG5ldyBpb2N0bCBhbmQNCj4gdGhlbg0KPiA+PiBs
b2cgdGhyb3VnaCBHUEEyLiBJZiB1c2Vyc3BhY2UgaXMgdHJ5aW5nIHRvIHN5bmMgdGhyb3VnaCBH
UEExLCBpdCB3aWxsDQo+ID4+IG1pc3MgdGhlIGRpcnR5IHBhZ2UuIFNvIGZvciBzYWZldHkgd2Ug
bmVlZCBsb2cgYm90aCBHUEExIGFuZCBHUEEyLiAoU2VlDQo+ID4+IHdoYXQgaGFzIGJlZW4gZG9u
ZSBpbiBsb2dfd3JpdGVfaHZhKCkgaW4gdmhvc3QuYykuIFRoZSBvbmx5IHdheSB0byBkbw0KPiA+
PiB0aGF0IGlzIHRvIG1haW50YWluIGFuIGluZGVwZW5kZW50IEhWQSB0byBHUEEgbWFwcGluZyBs
aWtlIHdoYXQgS1ZNDQo+IG9yDQo+ID4+IHZob3N0IGRpZC4NCj4gPj4NCj4gPiB3aHkgR1BBMSBh
bmQgR1BBMiBzaG91bGQgYmUgYm90aCBkaXJ0eT8NCj4gPiBldmVuIHRoZXkgaGF2ZSB0aGUgc2Ft
ZSBIVkEgZHVlIHRvIG92ZXJsYXBpbmcgdmlydHVhbCBhZGRyZXNzIHNwYWNlIGluDQo+ID4gdHdv
IHByb2Nlc3NlcywgdGhleSBzdGlsbCBjb3JyZXNwb25kIHRvIHR3byBwaHlzaWNhbCBwYWdlcy4N
Cj4gPiBkb24ndCBnZXQgd2hhdCdzIHlvdXIgbWVhbmluZyA6KQ0KPiANCj4gDQo+IFRoZSBwb2lu
dCBpcyBub3QgbGVhdmUgYW55IGNvcm5lciBjYXNlIHRoYXQgaXMgaGFyZCB0byBkZWJ1ZyBvciBm
aXggaW4NCj4gdGhlIGZ1dHVyZS4NCj4gDQo+IExldCdzIGp1c3Qgc3RhcnQgYnkgYSBzaW5nbGUg
cHJvY2VzcywgdGhlIEFQSSBhbGxvd3MgdXNlcnNwYWNlIHRvIG1hcHMNCj4gSFZBIHRvIGJvdGgg
R1BBMSBhbmQgR1BBMi4gU2luY2UgaXQga25vd3MgR1BBMSBhbmQgR1BBMiBhcmUgZXF1aXZhbGVu
dCwNCj4gaXQncyBvayB0byBzeW5jIGp1c3QgdGhyb3VnaCBHUEExLiBUaGF0IG1lYW5zIGlmIHlv
dSBvbmx5IGxvZyBHUEEyLCBpdA0KPiB3b24ndCB3b3JrLg0KPiANCg0KSSBub3RlZCBLVk0gaXRz
ZWxmIGRvZXNuJ3QgY29uc2lkZXIgc3VjaCBzaXR1YXRpb24gKG9uZSBIVkEgaXMgbWFwcGVkDQp0
byBtdWx0aXBsZSBHUEFzKSwgd2hlbiBkb2luZyBpdHMgZGlydHkgcGFnZSB0cmFja2luZy4gSWYg
eW91IGxvb2sgYXQNCmt2bV92Y3B1X21hcmtfcGFnZV9kaXJ0eSwgaXQgc2ltcGx5IGZpbmRzIHRo
ZSB1bmlxdWUgbWVtc2xvdCB3aGljaA0KY29udGFpbnMgdGhlIGRpcnR5IGdmbiBhbmQgdGhlbiBz
ZXQgdGhlIGRpcnR5IGJpdCB3aXRoaW4gdGhhdCBzbG90LiBJdA0KZG9lc24ndCBhdHRlbXB0IHRv
IHdhbGsgYWxsIG1lbXNsb3RzIHRvIGZpbmQgb3V0IGFueSBvdGhlciBHUEEgd2hpY2gNCm1heSBi
ZSBtYXBwZWQgdG8gdGhlIHNhbWUgSFZBLiANCg0KU28gdGhlcmUgbXVzdCBiZSBzb21lIGRpc2Nv
bm5lY3QgaGVyZS4gbGV0J3MgaGVhciBmcm9tIFBhb2xvIGZpcnN0IGFuZA0KdW5kZXJzdGFuZCB0
aGUgcmF0aW9uYWxlIGJlaGluZCBzdWNoIHNpdHVhdGlvbi4NCg0KVGhhbmtzDQpLZXZpbg0K

