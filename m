Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3F4C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64672206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64672206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB5Jh-0008L2-Jp
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iB5Ih-0006qa-Dk
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iB56M-0007NG-9W
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:40:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:13393)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iB56M-0007KX-00
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:40:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Sep 2019 15:40:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,526,1559545200"; d="scan'208";a="271365630"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by orsmga001.jf.intel.com with ESMTP; 19 Sep 2019 15:40:34 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Sep 2019 15:40:33 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Sep 2019 15:40:33 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.132]) with mapi id 14.03.0439.000;
 Fri, 20 Sep 2019 06:40:31 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [Qemu-devel] vhost, iova, and dirty page tracking
Thread-Topic: [Qemu-devel] vhost, iova, and dirty page tracking
Thread-Index: AdVsLg/AAnCsYtAES/qfxc77B9v7gf//8I+A//3tsaCABA8DAP/+1FBAgAIp6ID//2W6IABdNuUA//8hEvA=
Date: Thu, 19 Sep 2019 22:40:30 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D587E04@SHSMSX104.ccr.corp.intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
 <20190917085404.3b063e53@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57AFBA@SHSMSX104.ccr.corp.intel.com>
 <a82101bf-f8a7-5ddd-5abe-6060762d9abe@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B785@SHSMSX104.ccr.corp.intel.com>
 <20190919112048.09b3edaa@x1.home>
In-Reply-To: <20190919112048.09b3edaa@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzBlNTJkOTAtNzI3MC00MTgzLTg4NTEtMDM0YTllZTM5MmE1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicEp4TDhuYTdyZVh0UnBWb0dTWTA1WXBPbFNPUWtONmx6UUlcL0ljQjdHaFZOS0lidCttWHl3YmZPYWNNeFBYaGsifQ==
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
bV0NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjAsIDIwMTkgMToyMSBBTQ0KPiANCj4gT24g
V2VkLCAxOCBTZXAgMjAxOSAwNzoyMTowNSArMDAwMA0KPiAiVGlhbiwgS2V2aW4iIDxrZXZpbi50
aWFuQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4gRnJvbTogSmFzb24gV2FuZyBbbWFpbHRv
Omphc293YW5nQHJlZGhhdC5jb21dDQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAx
OCwgMjAxOSAyOjA0IFBNDQo+ID4gPg0KPiA+ID4gT24gMjAxOS85LzE4IOS4iuWNiDk6MzEsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+ID4gPj4gRnJvbTogQWxleCBXaWxsaWFtc29uIFttYWlsdG86
YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb21dDQo+ID4gPiA+PiBTZW50OiBUdWVzZGF5LCBTZXB0
ZW1iZXIgMTcsIDIwMTkgMTA6NTQgUE0NCj4gPiA+ID4+DQo+ID4gPiA+PiBPbiBUdWUsIDE3IFNl
cCAyMDE5IDA4OjQ4OjM2ICswMDAwDQo+ID4gPiA+PiAiVGlhbiwgS2V2aW4iPGtldmluLnRpYW5A
aW50ZWwuY29tPiAgd3JvdGU6DQo+ID4gPiA+Pg0KPiA+ID4gPj4+PiBGcm9tOiBKYXNvbiBXYW5n
IFttYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gPiA+ID4+Pj4gU2VudDogTW9uZGF5LCBT
ZXB0ZW1iZXIgMTYsIDIwMTkgNDozMyBQTQ0KPiA+ID4gPj4+Pg0KPiA+ID4gPj4+Pg0KPiA+ID4g
Pj4+PiBPbiAyMDE5LzkvMTYg5LiK5Y2IOTo1MSwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiA+
Pj4+PiBIaSwgSmFzb24NCj4gPiA+ID4+Pj4+DQo+ID4gPiA+Pj4+PiBXZSBoYWQgYSBkaXNjdXNz
aW9uIGFib3V0IGRpcnR5IHBhZ2UgdHJhY2tpbmcgaW4gVkZJTywgd2hlbg0KPiA+ID4gdklPTU1V
DQo+ID4gPiA+Pj4+PiBpcyBlbmFibGVkOg0KPiA+ID4gPj4+Pj4NCj4gPiA+ID4+Pj4+IGh0dHBz
Oi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LQ0KPiA+ID4g
Pj4+PiAwOS9tc2cwMjY5MC5odG1sDQo+ID4gPiA+Pj4+PiBJdCdzIGFjdHVhbGx5IGEgc2ltaWxh
ciBtb2RlbCBhcyB2aG9zdCAtIFFlbXUgY2Fubm90IGludGVycG9zZSB0aGUNCj4gPiA+IGZhc3Qt
DQo+ID4gPiA+Pj4+IHBhdGgNCj4gPiA+ID4+Pj4+IERNQXMgdGh1cyByZWxpZXMgb24gdGhlIGtl
cm5lbCBwYXJ0IHRvIHRyYWNrIGFuZCByZXBvcnQgZGlydHkgcGFnZQ0KPiA+ID4gPj4+PiBpbmZv
cm1hdGlvbi4NCj4gPiA+ID4+Pj4+IEN1cnJlbnRseSBRZW11IHRyYWNrcyBkaXJ0eSBwYWdlcyBp
biBHRk4gbGV2ZWwsIHRodXMgZGVtYW5kaW5nIGENCj4gPiA+ID4+Pj4gdHJhbnNsYXRpb24NCj4g
PiA+ID4+Pj4+IGZyb20gSU9WQSB0byBHUEEuIFRoZW4gdGhlIG9wZW4gaW4gb3VyIGRpc2N1c3Np
b24gaXMgd2hlcmUgdGhpcw0KPiA+ID4gPj4+PiB0cmFuc2xhdGlvbg0KPiA+ID4gPj4+Pj4gc2hv
dWxkIGhhcHBlbi4gRG9pbmcgdGhlIHRyYW5zbGF0aW9uIGluIGtlcm5lbCBpbXBsaWVzIGEgZGV2
aWNlDQo+IGlvdGxiDQo+ID4gPiA+Pj4+IGZsYXZvciwNCj4gPiA+ID4+Pj4+IHdoaWNoIGlzIHdo
YXQgdmhvc3QgaW1wbGVtZW50cyB0b2RheS4gSXQgcmVxdWlyZXMgcG90ZW50aWFsbHkNCj4gbGFy
Z2UNCj4gPiA+ID4+Pj4gdHJhY2tpbmcNCj4gPiA+ID4+Pj4+IHN0cnVjdHVyZXMgaW4gdGhlIGhv
c3Qga2VybmVsLCBidXQgbGV2ZXJhZ2luZyB0aGUgZXhpc3RpbmcgbG9nX3N5bmMNCj4gPiA+IGZs
b3cNCj4gPiA+ID4+IGluDQo+ID4gPiA+Pj4+IFFlbXUuDQo+ID4gPiA+Pj4+PiBPbiB0aGUgb3Ro
ZXIgaGFuZCwgUWVtdSBtYXkgcGVyZm9ybSBsb2dfc3luYyBmb3IgZXZlcnkNCj4gcmVtb3ZhbA0K
PiA+ID4gb2YNCj4gPiA+ID4+Pj4gSU9WQQ0KPiA+ID4gPj4+Pj4gbWFwcGluZyBhbmQgdGhlbiBk
byB0aGUgdHJhbnNsYXRpb24gaXRzZWxmLCB0aGVuIGF2b2lkaW5nIHRoZSBHUEENCj4gPiA+ID4+
Pj4gYXdhcmVuZXNzDQo+ID4gPiA+Pj4+PiBpbiB0aGUga2VybmVsIHNpZGUuIEl0IG5lZWRzIHNv
bWUgY2hhbmdlIHRvIGN1cnJlbnQgUWVtdSBsb2ctDQo+IHN5bmMNCj4gPiA+ID4+IGZsb3csDQo+
ID4gPiA+Pj4+IGFuZA0KPiA+ID4gPj4+Pj4gbWF5IGJyaW5nIG1vcmUgb3ZlcmhlYWQgaWYgSU9W
QSBpcyBmcmVxdWVudGx5IHVubWFwcGVkLg0KPiA+ID4gPj4+Pj4NCj4gPiA+ID4+Pj4+IFNvIHdl
J2QgbGlrZSB0byBoZWFyIGFib3V0IHlvdXIgb3BpbmlvbnMsIGVzcGVjaWFsbHkgYWJvdXQgaG93
DQo+IHlvdQ0KPiA+ID4gPj4gY2FtZQ0KPiA+ID4gPj4+Pj4gZG93biB0byB0aGUgY3VycmVudCBp
b3RsYiBhcHByb2FjaCBmb3Igdmhvc3QuDQo+ID4gPiA+Pj4+IFdlIGRvbid0IGNvbnNpZGVyIHRv
byBtdWNoIGluIHRoZSBwb2ludCB3aGVuIGludHJvZHVjaW5nIHZob3N0Lg0KPiBBbmQNCj4gPiA+
ID4+Pj4gYmVmb3JlIElPVExCLCB2aG9zdCBoYXMgYWxyZWFkeSBrbm93IEdQQSB0aHJvdWdoIGl0
cyBtZW0gdGFibGUNCj4gPiA+ID4+Pj4gKEdQQS0+SFZBKS4gU28gaXQncyBuYXR1cmUgYW5kIGVh
c2llciB0byB0cmFjayBkaXJ0eSBwYWdlcyBhdCBHUEENCj4gbGV2ZWwNCj4gPiA+ID4+Pj4gdGhl
biBpdCB3b24ndCBhbnkgY2hhbmdlcyBpbiB0aGUgZXhpc3RpbmcgQUJJLg0KPiA+ID4gPj4+IFRo
aXMgaXMgdGhlIHNhbWUgc2l0dWF0aW9uIGFzIFZGSU8uDQo+ID4gPiA+PiBJdCBpcz8gIFZGSU8g
ZG9lc24ndCBrbm93IEdQQXMsIGl0IG9ubHkga25vd3MgSFZBLCBIUEEsIGFuZCBJT1ZBLg0KPiBJ
bg0KPiA+ID4gPj4gc29tZSBjYXNlcyBJT1ZBIGlzIEdQQSwgYnV0IG5vdCBhbGwuDQo+ID4gPiA+
IFdlbGwsIEkgdGhvdWdodCB2aG9zdCBoYXMgYSBzaW1pbGFyIGRlc2lnbiwgdGhhdCB0aGUgaW5k
ZXggb2YgaXRzIG1lbQ0KPiB0YWJsZQ0KPiA+ID4gPiBpcyBHUEEgd2hlbiB2SU9NTVUgaXMgb2Zm
IGFuZCB0aGVuIGJlY29tZXMgSU9WQSB3aGVuIHZJT01NVSBpcw0KPiBvbi4NCj4gPiA+ID4gQnV0
IEkgbWF5IGJlIHdyb25nIGhlcmUuIEphc29uLCBjYW4geW91IGhlbHAgY2xhcmlmeT8gSSBzYXcg
dHdvDQo+ID4gPiA+IGludGVyZmFjZXMgd2hpY2ggcG9rZSB0aGUgbWVtIHRhYmxlOiBWSE9TVF9T
RVRfTUVNX1RBQkxFIChmb3INCj4gR1BBKQ0KPiA+ID4gPiBhbmQgVkhPU1RfSU9UTEJfVVBEQVRF
IChmb3IgSU9WQSkuIEFyZSB0aGV5IHVzZWQgZXhjbHVzaXZlbHkgb3INCj4gPiA+IHRvZ2V0aGVy
Pw0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IEFjdHVhbGx5LCB2aG9zdCBtYWludGFpbnMgdHdvIGlu
dGVydmFsIHRyZWVzLCBtZW0gdGFibGUgR1BBLT5IVkEsIGFuZA0KPiA+ID4gZGV2aWNlIElPVExC
IElPVkEtPkhWQS4gRGV2aWNlIElPVExCIGlzIG9ubHkgdXNlZCB3aGVuIHZJT01NVSBpcw0KPiA+
ID4gZW5hYmxlZCwgYW5kIGluIHRoYXQgY2FzZSBtZW0gdGFibGUgaXMgdXNlZCBvbmx5IHdoZW4g
dmhvc3QgbmVlZCB0bw0KPiA+ID4gdHJhY2sgZGlydHkgcGFnZXMgKGRvIHJldmVyc2UgbG9va3Vw
IG9mIG1lbXRhYmxlIHRvIGdldCBIVkEtPkdQQSkuIFNvDQo+IGluDQo+ID4gPiBjb25jbHVzaW9u
LCBmb3IgZGF0YXBhdGgsIHRoZXkgYXJlIHVzZWQgZXhjbHVzaXZlbHksIGJ1dCB0aGV5IG5lZWQN
Cj4gPiA+IGNvd29yayBmb3IgbG9nZ2luZyBkaXJ0eSBwYWdlcyB3aGVuIGRldmljZSBJT1RMQiBp
cyBlbmFibGVkLg0KPiA+ID4NCj4gPg0KPiA+IE9LLiBUaGVuIGl0J3MgZGlmZmVyZW50IGZyb20g
Y3VycmVudCBWRklPIGRlc2lnbiwgd2hpY2ggbWFpbnRhaW5zIG9ubHkNCj4gPiBvbmUgdHJlZSB3
aGljaCBpcyBpbmRleGVkIGJ5IGVpdGhlciBHUEEgb3IgSU9WQSBleGNsdXNpdmVseSwgdXBvbg0K
PiA+IHdoZXRoZXIgdklPTU1VIGlzIGluIHVzZS4NCj4gDQo+IE5pdCwgdGhlIFZGSU8gdHJlZSBp
cyBvbmx5IGV2ZXIgaW5kZXhlZCBieSBJT1ZBLiAgVGhlIE1BUF9ETUEgaW9jdGwgaXMNCj4gb25s
eSBldmVyIHBlcmZvcm1lZCB3aXRoIGFuIElPVkEuICBVc2Vyc3BhY2UgZGVjaWRlcyBob3cgdGhh
dCBJT1ZBDQo+IG1hcHMNCj4gdG8gR1BBLCBWRklPIG9ubHkgbmVlZHMgdG8ga25vdyBob3cgdGhl
IElPVkEgbWFwcyB0byBIUEEgdmlhIHRoZSBIVkEuDQo+IFRoYW5rcywNCj4gDQoNCkkgd2FzIG9u
bHkgcmVmZXJyaW5nIHRvIGl0cyBhY3R1YWwgbWVhbmluZyBmcm9tIHVzYWdlIHAuby52LCBub3Qg
dGhlIA0KcGFyYW1ldGVyIG5hbWUgKHdoaWNoIGlzIGFsd2F5cyBjYWxsZWQgaW92YSkgaW4gdmZp
by4gDQoNClRoYW5rcw0KS2V2aW4NCg==

