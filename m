Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26007C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA09208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA09208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjEP-0006Da-V0
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jGjDf-0005Pj-2A
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jGjDX-0002cb-Bh
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:03:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:19249)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jGjDX-0002b5-36
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:03:39 -0400
IronPort-SDR: 5rDQ+GA5x45koJI/+WKgNAvXPk91s4sJndJogIX9UdEuCuw4bEJ8aJrTVG/4YasxvrPaiDnsa/
 185WqJXh1FBA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 06:03:34 -0700
IronPort-SDR: 5ThqQqo8aI1d7ydTssgOC1bEa6RdoLha2dI7wvT8h2UeFE+JX5/bMcCTEJZiCxvi7f3PmNa5s8
 dBOxzakRjMAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; d="scan'208";a="447868723"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga006.fm.intel.com with ESMTP; 24 Mar 2020 06:03:34 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Mar 2020 06:03:33 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Mar 2020 06:03:33 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Mar 2020 06:03:33 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.50]) with mapi id 14.03.0439.000;
 Tue, 24 Mar 2020 21:03:29 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v1 08/22] vfio: init HostIOMMUContext per-container
Thread-Topic: [PATCH v1 08/22] vfio: init HostIOMMUContext per-container
Thread-Index: AQHWAEW0jB9vKYJM+keTj5bDx+gC8qhWMHmAgAGHKsA=
Date: Tue, 24 Mar 2020 13:03:28 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A2006A9@SHSMSX104.ccr.corp.intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-9-git-send-email-yi.l.liu@intel.com>
 <20200323213943.GR127076@xz-x1>
In-Reply-To: <20200323213943.GR127076@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.31
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1h
cmNoIDI0LCAyMDIwIDU6NDAgQU0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA4LzIyXSB2ZmlvOiBpbml0IEhvc3RJT01NVUNv
bnRleHQgcGVyLWNvbnRhaW5lcg0KPiANCj4gT24gU3VuLCBNYXIgMjIsIDIwMjAgYXQgMDU6MzY6
MDVBTSAtMDcwMCwgTGl1IFlpIEwgd3JvdGU6DQo+ID4gQWZ0ZXIgY29uZmlybWluZyBkdWFsIHN0
YWdlIERNQSB0cmFuc2xhdGlvbiBzdXBwb3J0IHdpdGgga2VybmVsIGJ5DQo+ID4gY2hlY2tpbmcg
VkZJT19UWVBFMV9ORVNUSU5HX0lPTU1VLCBWRklPIGluaXRzIEhvc3RJT01NVUNvbnRldCBpbnN0
YW5jZQ0KPiA+IGFuZCBleHBvc2VzIGl0IHRvIFBDSSBsYXllci4gVGh1cyB2SU9NTVUgZW11YWx0
b3JzIG1heSBtYWtlIHVzZSBvZg0KPiA+IHN1Y2ggY2FwYWJpbGl0eSBieSBsZXZlcmFnaW5nIHRo
ZSBtZXRob2RzIHByb3ZpZGVkIGJ5IEhvc3RJT01NVUNvbnRleHQuDQo+ID4NCj4gPiBDYzogS2V2
aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+ID4gQ2M6IEphY29iIFBhbiA8amFjb2Iu
anVuLnBhbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0
LmNvbT4NCj4gPiBDYzogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPiA+IENj
OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4gPiBDYzogRGF2aWQgR2lic29u
IDxkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXU+DQo+ID4gQ2M6IEFsZXggV2lsbGlhbXNvbiA8
YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGl1IFlpIEwg
PHlpLmwubGl1QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvdmZpby9jb21tb24uYyAgICAg
ICAgICAgICAgICAgICAgICB8IDgwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gIGh3L3ZmaW8vcGNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMyArKysrKysN
Cj4gPiAgaW5jbHVkZS9ody9pb21tdS9ob3N0X2lvbW11X2NvbnRleHQuaCB8ICAzICsrDQo+ID4g
IGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oICAgICAgICAgfCAgNCArKw0KPiA+ICA0IGZp
bGVzIGNoYW5nZWQsIDEwMCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcv
dmZpby9jb21tb24uYyBiL2h3L3ZmaW8vY29tbW9uLmMNCj4gPiBpbmRleCBjMjc2NzMyLi5lNGY1
ZjEwIDEwMDY0NA0KPiA+IC0tLSBhL2h3L3ZmaW8vY29tbW9uLmMNCj4gPiArKysgYi9ody92Zmlv
L2NvbW1vbi5jDQo+ID4gQEAgLTExNzksMTAgKzExNzksNTUgQEAgc3RhdGljIGludCB2ZmlvX2dl
dF9pb21tdV90eXBlKFZGSU9Db250YWluZXINCj4gKmNvbnRhaW5lciwNCj4gPiAgICAgIHJldHVy
biAtRUlOVkFMOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCB2ZmlvX2hvc3RfaWN4X3Bh
c2lkX2FsbG9jKEhvc3RJT01NVUNvbnRleHQgKmhvc3RfaWN4LA0KPiANCj4gSSdtIG5vdCBzdXJl
IGFib3V0IEFsZXgsIGJ1dCAuLi4gaWN4IGlzIGNvbmZ1c2luZyB0byBtZS4gIE1heWJlICJjdHgi
DQo+IGFzIHlvdSBhbHdheXMgdXNlZD8NCg0KQXQgZmlyc3QgSSB1c2VkIHZmaW9faG9zdF9pb21t
dV9jdHhfcGFzaWRfYWxsb2MoKSwgZm91bmQgaXQgaXMgbG9uZywgc28gSQ0Kc3dpdGNoZWQgdG8g
ImljeCIgd2hpY2ggbWVhbnMgaW9tbXVfY29udGV4dC4gTWF5YmUgdGhlIGZvcm1lciBvbmUNCmxv
b2tzIGJldHRlciBhcyBpdCBnaXZlcyBtb3JlIHByZWNpc2UgaW5mby4NCg0KUmVnYXJkcywNCllp
IExpdQ0K

