Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D539C18E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D417020714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D417020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2Oi-0001q3-Vn
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 05:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jH2NM-0000wr-VB
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jH2NL-0008AL-8D
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:31:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:61762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jH2NL-00085M-0w
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:31:03 -0400
IronPort-SDR: fv0Q3Nq+bIFdE2pxZkhkx2UzGRj3i42dCQz/xW/l8+r7jBwufoPaS3Vzv5do/iM+lgXTINK1mG
 tiYAiWt0I4zQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 02:30:57 -0700
IronPort-SDR: ENJVQmTRM4coOaTMc6q37SKG5EVC7/GgEuFqqTwkgl5wOlO1p8nb1IlpWBF/2CoqvL7Ri+wk4v
 EmBJPJwiDS7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; d="scan'208";a="250358864"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga006.jf.intel.com with ESMTP; 25 Mar 2020 02:30:57 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 02:30:54 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 02:30:54 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.96]) with mapi id 14.03.0439.000;
 Wed, 25 Mar 2020 17:30:50 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v1 08/22] vfio: init HostIOMMUContext per-container
Thread-Topic: [PATCH v1 08/22] vfio: init HostIOMMUContext per-container
Thread-Index: AQHWAEW0jB9vKYJM+keTj5bDx+gC8qhWMHmAgAGHKsD//5eLgIABwClw
Date: Wed, 25 Mar 2020 09:30:50 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A201DC5@SHSMSX104.ccr.corp.intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-9-git-send-email-yi.l.liu@intel.com>
 <20200323213943.GR127076@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A2006A9@SHSMSX104.ccr.corp.intel.com>
 <20200324144553.GU127076@xz-x1>
In-Reply-To: <20200324144553.GU127076@xz-x1>
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
X-Received-From: 134.134.136.24
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
cmNoIDI0LCAyMDIwIDEwOjQ2IFBNDQo+IFRvOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwOC8yMl0gdmZpbzogaW5pdCBIb3N0SU9NTVVD
b250ZXh0IHBlci1jb250YWluZXINCj4gDQo+IE9uIFR1ZSwgTWFyIDI0LCAyMDIwIGF0IDAxOjAz
OjI4UE0gKzAwMDAsIExpdSwgWWkgTCB3cm90ZToNCj4gPiA+IEZyb206IFBldGVyIFh1IDxwZXRl
cnhAcmVkaGF0LmNvbT4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDI0LCAyMDIwIDU6NDAg
QU0NCj4gPiA+IFRvOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjEgMDgvMjJdIHZmaW86IGluaXQgSG9zdElPTU1VQ29udGV4dA0KPiA+
ID4gcGVyLWNvbnRhaW5lcg0KPiA+ID4NCj4gPiA+IE9uIFN1biwgTWFyIDIyLCAyMDIwIGF0IDA1
OjM2OjA1QU0gLTA3MDAsIExpdSBZaSBMIHdyb3RlOg0KPiA+ID4gPiBBZnRlciBjb25maXJtaW5n
IGR1YWwgc3RhZ2UgRE1BIHRyYW5zbGF0aW9uIHN1cHBvcnQgd2l0aCBrZXJuZWwgYnkNCj4gPiA+
ID4gY2hlY2tpbmcgVkZJT19UWVBFMV9ORVNUSU5HX0lPTU1VLCBWRklPIGluaXRzIEhvc3RJT01N
VUNvbnRldA0KPiA+ID4gPiBpbnN0YW5jZSBhbmQgZXhwb3NlcyBpdCB0byBQQ0kgbGF5ZXIuIFRo
dXMgdklPTU1VIGVtdWFsdG9ycyBtYXkNCj4gPiA+ID4gbWFrZSB1c2Ugb2Ygc3VjaCBjYXBhYmls
aXR5IGJ5IGxldmVyYWdpbmcgdGhlIG1ldGhvZHMgcHJvdmlkZWQgYnkNCj4gSG9zdElPTU1VQ29u
dGV4dC4NCj4gPiA+ID4NCj4gPiA+ID4gQ2M6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwu
Y29tPg0KPiA+ID4gPiBDYzogSmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNv
bT4NCj4gPiA+ID4gQ2M6IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4gPiA+ID4gQ2M6
IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4gPiA+ID4gQ2M6IFlpIFN1biA8
eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPiA+ID4gPiBDYzogRGF2aWQgR2lic29uIDxkYXZp
ZEBnaWJzb24uZHJvcGJlYXIuaWQuYXU+DQo+ID4gPiA+IENjOiBBbGV4IFdpbGxpYW1zb24gPGFs
ZXgud2lsbGlhbXNvbkByZWRoYXQuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMaXUgWWkg
TCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGh3L3ZmaW8vY29t
bW9uLmMgICAgICAgICAgICAgICAgICAgICAgfCA4MA0KPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ID4gPiAgaHcvdmZpby9wY2kuYyAgICAgICAgICAgICAgICAgICAg
ICAgICB8IDEzICsrKysrKw0KPiA+ID4gPiAgaW5jbHVkZS9ody9pb21tdS9ob3N0X2lvbW11X2Nv
bnRleHQuaCB8ICAzICsrDQo+ID4gPiA+ICBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCAg
ICAgICAgIHwgIDQgKysNCj4gPiA+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTAwIGluc2VydGlvbnMo
KykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY29tbW9uLmMgYi9ody92
ZmlvL2NvbW1vbi5jIGluZGV4DQo+ID4gPiA+IGMyNzY3MzIuLmU0ZjVmMTAgMTAwNjQ0DQo+ID4g
PiA+IC0tLSBhL2h3L3ZmaW8vY29tbW9uLmMNCj4gPiA+ID4gKysrIGIvaHcvdmZpby9jb21tb24u
Yw0KPiA+ID4gPiBAQCAtMTE3OSwxMCArMTE3OSw1NSBAQCBzdGF0aWMgaW50DQo+ID4gPiA+IHZm
aW9fZ2V0X2lvbW11X3R5cGUoVkZJT0NvbnRhaW5lcg0KPiA+ID4gKmNvbnRhaW5lciwNCj4gPiA+
ID4gICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiA+ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4gK3N0
YXRpYyBpbnQgdmZpb19ob3N0X2ljeF9wYXNpZF9hbGxvYyhIb3N0SU9NTVVDb250ZXh0ICpob3N0
X2ljeCwNCj4gPiA+DQo+ID4gPiBJJ20gbm90IHN1cmUgYWJvdXQgQWxleCwgYnV0IC4uLiBpY3gg
aXMgY29uZnVzaW5nIHRvIG1lLiAgTWF5YmUgImN0eCINCj4gPiA+IGFzIHlvdSBhbHdheXMgdXNl
ZD8NCj4gPg0KPiA+IEF0IGZpcnN0IEkgdXNlZCB2ZmlvX2hvc3RfaW9tbXVfY3R4X3Bhc2lkX2Fs
bG9jKCksIGZvdW5kIGl0IGlzIGxvbmcsDQo+ID4gc28gSSBzd2l0Y2hlZCB0byAiaWN4IiB3aGlj
aCBtZWFucyBpb21tdV9jb250ZXh0LiBNYXliZSB0aGUgZm9ybWVyIG9uZQ0KPiA+IGxvb2tzIGJl
dHRlciBhcyBpdCBnaXZlcyBtb3JlIHByZWNpc2UgaW5mby4NCj4gDQo+IHZmaW9faG9zdF9pb21t
dV9jdHhfcGFzaWRfYWxsb2MoKSBpc24ndCB0aGF0IGJhZCBpbWhvLiAgSSdsbCBvbWl0IHRoZSAi
Y3R4IiBpZiBJIHdhbnQNCj4gdG8gbWFrZSBpdCBldmVuIHNob3J0ZXIsIGJ1dCAiaWN4IiBtaWdo
dCBiZSBhbWJpZ3VvdXMuDQoNCkdvdCBpdC4gbGV0IG1lIG1vZGlmeSB0aGUgcHJlZml4Lg0KDQpS
ZWdhcmRzLA0KWWkgTGl1DQo=

