Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A3BC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DCF206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DCF206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB5L8-0001Um-3I
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iB5K9-0000fc-Dx
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iB5K7-0004q0-Jv
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:54:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:14272)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iB5K7-0004pg-Bz
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:54:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Sep 2019 15:54:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,526,1559545200"; d="scan'208";a="202377035"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2019 15:54:50 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Sep 2019 15:54:49 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Sep 2019 15:54:49 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.92]) with mapi id 14.03.0439.000;
 Fri, 20 Sep 2019 06:54:47 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: RE: [Qemu-devel] vhost, iova, and dirty page tracking
Thread-Topic: [Qemu-devel] vhost, iova, and dirty page tracking
Thread-Index: AdVsLg/AAnCsYtAES/qfxc77B9v7gf//8I+A//3tsaCAA8b/gP/+jHxggAK7doD//1RiwAA9GJkAAAkwmQAAAXN8gAAAR/kAAAB+N4D//2+WgP//IMoA//z7YsA=
Date: Thu, 19 Sep 2019 22:54:47 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D587E3C@SHSMSX104.ccr.corp.intel.com>
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
In-Reply-To: <1ec55b2e-6a59-f1df-0604-5b524da0f001@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTM4OWJkYWYtMjAxMC00Y2ZhLWE1NGQtOGY3OTkxOTczNTU1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoianRVMVF0ZWc4dUlqbklnN3R1Zm9vVWJDUmdRZUFGbmJZaFhCZElBUDNmMlJCVllYMk9TYU93K0VtZ295dUE1KyJ9
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
Cc: 'Alex Williamson' <alex.williamson@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQYW9sbyBCb256aW5pIFttYWlsdG86cGJvbnppbmlAcmVkaGF0LmNvbV0NCj4gU2Vu
dDogVGh1cnNkYXksIFNlcHRlbWJlciAxOSwgMjAxOSA3OjE0IFBNDQo+IA0KPiBPbiAxOS8wOS8x
OSAwOToxNiwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+PiB3aHkgR1BBMSBhbmQgR1BBMiBzaG91
bGQgYmUgYm90aCBkaXJ0eT8NCj4gPj4+IGV2ZW4gdGhleSBoYXZlIHRoZSBzYW1lIEhWQSBkdWUg
dG8gb3ZlcmxhcGluZyB2aXJ0dWFsIGFkZHJlc3Mgc3BhY2UNCj4gaW4NCj4gPj4+IHR3byBwcm9j
ZXNzZXMsIHRoZXkgc3RpbGwgY29ycmVzcG9uZCB0byB0d28gcGh5c2ljYWwgcGFnZXMuDQo+ID4+
PiBkb24ndCBnZXQgd2hhdCdzIHlvdXIgbWVhbmluZyA6KQ0KPiA+Pg0KPiA+PiBUaGUgcG9pbnQg
aXMgbm90IGxlYXZlIGFueSBjb3JuZXIgY2FzZSB0aGF0IGlzIGhhcmQgdG8gZGVidWcgb3IgZml4
IGluDQo+ID4+IHRoZSBmdXR1cmUuDQo+ID4+DQo+ID4+IExldCdzIGp1c3Qgc3RhcnQgYnkgYSBz
aW5nbGUgcHJvY2VzcywgdGhlIEFQSSBhbGxvd3MgdXNlcnNwYWNlIHRvIG1hcHMNCj4gPj4gSFZB
IHRvIGJvdGggR1BBMSBhbmQgR1BBMi4gU2luY2UgaXQga25vd3MgR1BBMSBhbmQgR1BBMiBhcmUN
Cj4gZXF1aXZhbGVudCwNCj4gPj4gaXQncyBvayB0byBzeW5jIGp1c3QgdGhyb3VnaCBHUEExLiBU
aGF0IG1lYW5zIGlmIHlvdSBvbmx5IGxvZyBHUEEyLCBpdA0KPiA+PiB3b24ndCB3b3JrLg0KPiA+
DQo+ID4gSSBub3RlZCBLVk0gaXRzZWxmIGRvZXNuJ3QgY29uc2lkZXIgc3VjaCBzaXR1YXRpb24g
KG9uZSBIVkEgaXMgbWFwcGVkDQo+ID4gdG8gbXVsdGlwbGUgR1BBcyksIHdoZW4gZG9pbmcgaXRz
IGRpcnR5IHBhZ2UgdHJhY2tpbmcuIElmIHlvdSBsb29rIGF0DQo+ID4ga3ZtX3ZjcHVfbWFya19w
YWdlX2RpcnR5LCBpdCBzaW1wbHkgZmluZHMgdGhlIHVuaXF1ZSBtZW1zbG90IHdoaWNoDQo+ID4g
Y29udGFpbnMgdGhlIGRpcnR5IGdmbiBhbmQgdGhlbiBzZXQgdGhlIGRpcnR5IGJpdCB3aXRoaW4g
dGhhdCBzbG90LiBJdA0KPiA+IGRvZXNuJ3QgYXR0ZW1wdCB0byB3YWxrIGFsbCBtZW1zbG90cyB0
byBmaW5kIG91dCBhbnkgb3RoZXIgR1BBIHdoaWNoDQo+ID4gbWF5IGJlIG1hcHBlZCB0byB0aGUg
c2FtZSBIVkEuDQo+ID4NCj4gPiBTbyB0aGVyZSBtdXN0IGJlIHNvbWUgZGlzY29ubmVjdCBoZXJl
LiBsZXQncyBoZWFyIGZyb20gUGFvbG8gZmlyc3QgYW5kDQo+ID4gdW5kZXJzdGFuZCB0aGUgcmF0
aW9uYWxlIGJlaGluZCBzdWNoIHNpdHVhdGlvbi4NCj4gDQo+IEluIGdlbmVyYWwsIHVzZXJzcGFj
ZSBjYW5ub3QgYXNzdW1lIHRoYXQgaXQncyBva2F5IHRvIHN5bmMganVzdCB0aHJvdWdoDQo+IEdQ
QTEuICBJdCBtdXN0IHN5bmMgdGhlIGhvc3QgcGFnZSBpZiAqZWl0aGVyKiBHUEExIG9yIEdQQTIg
YXJlIG1hcmtlZA0KPiBkaXJ0eS4NCg0KQWdyZWUuIEluIHRoaXMgY2FzZSB0aGUga2VybmVsIG9u
bHkgbmVlZHMgdG8gdHJhY2sgd2hldGhlciBHUEExIG9yDQpHUEEyIGlzIGRpcnRpZWQgYnkgZ3Vl
c3Qgb3BlcmF0aW9ucy4gVGhlIHJlYXNvbiB3aHkgdmhvc3QgaGFzIHRvDQpzZXQgYm90aCBHUEEx
IGFuZCBHUEEyIGlzIGR1ZSB0byBpdHMgb3duIGRlc2lnbiAtIGl0IG1haW50YWlucw0KSU9WQS0+
SFZBIGFuZCBHUEEtPkhWQSBtYXBwaW5ncyB0aHVzIGdpdmVuIGEgSU9WQSB5b3UgaGF2ZQ0KdG8g
cmV2ZXJzZSBsb29rdXAgR1BBLT5IVkEgbWVtVGFibGUgd2hpY2ggZ2l2ZXMgbXVsdGlwbGUgcG9z
c2libGUNCkdQQXMuIEJ1dCBpbiBjb25jZXB0IGlmIHZob3N0IGNhbiBtYWludGFpbiBhIElPVkEt
PkdQQSBtYXBwaW5nLA0KdGhlbiBpdCBpcyBzdHJhaWdodGZvcndhcmQgdG8gc2V0IHRoZSByaWdo
dCBHUEEgZXZlcnkgdGltZSB3aGVuIGEgSU9WQQ0KaXMgdHJhY2tlZC4NCg0KPiANCj4gVGhlIHNp
dHVhdGlvbiByZWFsbHkgb25seSBhcmlzZXMgaW4gc3BlY2lhbCBjYXNlcy4gIEZvciBleGFtcGxl
LA0KPiAweGZmZmUwMDAwLi4weGZmZmZmZmZmIGFuZCAweGUwMDAwLi4weGZmZmZmIG1pZ2h0IGJl
IHRoZSBzYW1lIG1lbW9yeS4NCj4gRnJvbSAiaW5mbyBtdHJlZSIgYmVmb3JlIHRoZSBndWVzdCBi
b290czoNCj4gDQo+ICAgICAwMDAwMDAwMDAwMDAwMDAwLWZmZmZmZmZmZmZmZmZmZmYgKHByaW8g
LTEsIGkvbyk6IHBjaQ0KPiAgICAgICAwMDAwMDAwMDAwMGUwMDAwLTAwMDAwMDAwMDAwZmZmZmYg
KHByaW8gMSwgaS9vKTogYWxpYXMgaXNhLWJpb3MNCj4gQHBjLmJpb3MgMDAwMDAwMDAwMDAyMDAw
MC0wMDAwMDAwMDAwMDNmZmZmDQo+ICAgICAgIDAwMDAwMDAwZmZmYzAwMDAtMDAwMDAwMDBmZmZm
ZmZmZiAocHJpbyAwLCByb20pOiBwYy5iaW9zDQo+IA0KPiBIb3dldmVyLCBub24teDg2IG1hY2hp
bmVzIG1heSBoYXZlIG90aGVyIGNhc2VzIG9mIGFsaWFzZWQgbWVtb3J5IHNvDQo+IGl0J3MNCj4g
YSBjYXNlIHRoYXQgeW91IHNob3VsZCBjb3Zlci4NCj4gDQoNCkFib3ZlIGV4YW1wbGUgaXMgcmVh
ZC1vbmx5LCB0aHVzIHdvbid0IGJlIHRvdWNoZWQgaW4gbG9nZGlydHkgcGF0aC4NCkJ1dCBub3cg
SSBhZ3JlZSB0aGF0IGEgc3BlY2lmaWMgYXJjaGl0ZWN0dXJlIG1heSBkZWZpbmUgdHdvDQp3cml0
YWJsZSBHUEEgcmFuZ2VzIHdpdGggb25lIGFzIHRoZSBhbGlhcyB0byB0aGUgb3RoZXIsIGFzIGxv
bmcgYXMNCnN1Y2ggY2FzZSBpcyBleHBsaWNpdGx5IGRvY3VtZW50ZWQgc28gZ3Vlc3QgT1Mgd29u
J3QgdHJlYXQgdGhlbSBhcw0Kc2VwYXJhdGUgbWVtb3J5IHBhZ2VzLg0KDQpUaGFua3MNCktldmlu
DQo=

