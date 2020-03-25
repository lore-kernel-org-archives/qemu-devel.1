Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774ABC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 05:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401FC20777
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 05:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401FC20777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGypI-0003mc-Fi
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 01:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jGyof-0003Mm-Gr
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 01:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jGyod-0004Qd-NO
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 01:43:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:10971)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jGyod-0004K3-F3
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 01:42:59 -0400
IronPort-SDR: OTUcuR4JM/79/8s/JjP+l4KMZBHVM3LOoqRHVSdifQg+13GBTMLFvLffaSK/PJjy6io47Hr0Fr
 sTFlA36g3pAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 22:42:55 -0700
IronPort-SDR: Gasm0RWK8wEVBnQvcQ73BUz5CGLLT+kjWEHMy7LFvOa3n/UTiYLPaBKqJ4A2OGu+OCt7TzsaH5
 gv+2BBVH3YlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; d="scan'208";a="446515187"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga005.fm.intel.com with ESMTP; 24 Mar 2020 22:42:55 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Mar 2020 22:42:55 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Mar 2020 13:42:52 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 25 Mar 2020 13:42:52 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Derek Su <jwsu1986@gmail.com>
Subject: RE: [PATCH v2 1/1] net/colo-compare.c: Fix memory leak in
 packet_enqueue()
Thread-Topic: [PATCH v2 1/1] net/colo-compare.c: Fix memory leak in
 packet_enqueue()
Thread-Index: AQHWAHITxBU5D7mjSkWbPnpdLQyVtKhWi7uA///6NgCAAgGA0P//hVGAgAAkogCAAJ4MoA==
Date: Wed, 25 Mar 2020 05:42:52 +0000
Message-ID: <3ceb0c3014b84657bd9b3b2d28183ad1@intel.com>
References: <20200322174751.12559-1-dereksu@qnap.com>
 <20200322174751.12559-2-dereksu@qnap.com>
 <883bf4e2916f43baa6700f98bbb85523@intel.com>
 <CAFKS8hUJ34Qh7gsggtbVM6GU4hLEn_xBLFM7X5mQrsmQg-Yc7w@mail.gmail.com>
 <2046ed570c754e25ae2b8d5c6c48de2f@intel.com>
 <CAFKS8hXUTYxsHsTgh5cntHL3hMyp-9q9B53d110VipF2BR8_Hg@mail.gmail.com>
 <CAFKS8hVA45jTVGTGtGrHKJJcXJsT2uaJ4yxs_60fRtqvG_xzyw@mail.gmail.com>
In-Reply-To: <CAFKS8hVA45jTVGTGtGrHKJJcXJsT2uaJ4yxs_60fRtqvG_xzyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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
Cc: "dereksu@qnap.com" <dereksu@qnap.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "lizhijian@cn.fujitsu.com" <lizhijian@cn.fujitsu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGVyZWsgU3UgPGp3c3Ux
OTg2QGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyNSwgMjAyMCAxMjoxNyBQ
TQ0KPiBUbzogWmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPg0KPiBDYzogcWVtdS1k
ZXZlbEBub25nbnUub3JnOyBsaXpoaWppYW5AY24uZnVqaXRzdS5jb207DQo+IGphc293YW5nQHJl
ZGhhdC5jb207IGRlcmVrc3VAcW5hcC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzFd
IG5ldC9jb2xvLWNvbXBhcmUuYzogRml4IG1lbW9yeSBsZWFrIGluDQo+IHBhY2tldF9lbnF1ZXVl
KCkNCj4gDQo+IEppbmctV2VpIFN1IDxqd3N1MTk4NkBnbWFpbC5jb20+IOaWvCAyMDIw5bm0M+ac
iDI15pelIOmAseS4iSDkuIrljYgxMDowNQ0KPiDlr6vpgZPvvJoNCj4gPg0KPiA+IFpoYW5nLCBD
aGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4g5pa8IDIwMjDlubQz5pyIMjXml6Ug6YCx5LiJIOS4
iuWNiA0KPiA5OjM35a+r6YGT77yaDQo+ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IEppbmctV2VpIFN1IDxqd3N1MTk4
NkBnbWFpbC5jb20+DQo+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDI0LCAyMDIwIDEwOjQ3
IEFNDQo+ID4gPiA+IFRvOiBaaGFuZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+DQo+ID4g
PiA+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IGxpemhpamlhbkBjbi5mdWppdHN1LmNvbTsN
Cj4gPiA+ID4gamFzb3dhbmdAcmVkaGF0LmNvbTsgZGVyZWtzdUBxbmFwLmNvbQ0KPiA+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMV0gbmV0L2NvbG8tY29tcGFyZS5jOiBGaXggbWVtb3J5
IGxlYWsgaW4NCj4gPiA+ID4gcGFja2V0X2VucXVldWUoKQ0KPiA+ID4gPg0KPiA+ID4gPiBaaGFu
ZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+IOaWvCAyMDIw5bm0M+aciDI05pelIOmAseS6
jCDkuIrljYgNCj4gMzoyNA0KPiA+ID4gPiDlr6vpgZPvvJoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiA+ID4gPiBGcm9tOiBEZXJlayBTdSA8andzdTE5ODZAZ21haWwuY29tPg0KPiA+ID4gPiA+ID4g
U2VudDogTW9uZGF5LCBNYXJjaCAyMywgMjAyMCAxOjQ4IEFNDQo+ID4gPiA+ID4gPiBUbzogcWVt
dS1kZXZlbEBub25nbnUub3JnDQo+ID4gPiA+ID4gPiBDYzogWmhhbmcsIENoZW4gPGNoZW4uemhh
bmdAaW50ZWwuY29tPjsNCj4gPiA+ID4gPiA+IGxpemhpamlhbkBjbi5mdWppdHN1LmNvbTsgamFz
b3dhbmdAcmVkaGF0LmNvbTsNCj4gPiA+ID4gPiA+IGRlcmVrc3VAcW5hcC5jb20NCj4gPiA+ID4g
PiA+IFN1YmplY3Q6IFtQQVRDSCB2MiAxLzFdIG5ldC9jb2xvLWNvbXBhcmUuYzogRml4IG1lbW9y
eSBsZWFrIGluDQo+ID4gPiA+ID4gPiBwYWNrZXRfZW5xdWV1ZSgpDQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gVGhlIHBhdGNoIGlzIHRvIGZpeCB0aGUgInBrdCIgbWVtb3J5IGxlYWsgaW4gcGFj
a2V0X2VucXVldWUoKS4NCj4gPiA+ID4gPiA+IFRoZSBhbGxvY2F0ZWQgInBrdCIgbmVlZHMgdG8g
YmUgZnJlZWQgaWYgdGhlIGNvbG8gY29tcGFyZQ0KPiA+ID4gPiA+ID4gcHJpbWFyeSBvciBzZWNv
bmRhcnkgcXVldWUgaXMgdG9vIGJpZy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEhpIERlcmVrLA0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guDQo+ID4gPiA+ID4g
SSByZS10aGluayB0aGlzIGlzc3VlIGluIGEgYmlnIHZpZXcsIGxvb2tzIGp1c3QgZnJlZSB0aGUg
cGtnIGlzDQo+ID4gPiA+ID4gbm90IGVub3VnaCBpbg0KPiA+ID4gPiB0aGlzIHNpdHVhdGlvbi4N
Cj4gPiA+ID4gPiBUaGUgcm9vdCBjYXVzZSBpcyBuZXR3b3JrIGlzIHRvbyBidXN5IHRvIGNvbXBh
cmUsIFNvLCBiZXR0ZXINCj4gPiA+ID4gPiBjaG9pY2UgaXMgbm90aWZ5IENPTE8gZnJhbWUgdG8g
ZG8gYSBjaGVja3BvaW50IGFuZCBjbGVhbiB1cCBhbGwNCj4gPiA+ID4gPiB0aGUgbmV0d29yayBx
dWV1ZS4gVGhpcyB3b3JrIG1heWJlIGRlY3JlYXNlIENPTE8gbmV0d29yaw0KPiA+ID4gPiA+IHBl
cmZvcm1hbmNlIGJ1dCBzZWFtcw0KPiA+ID4gPiBiZXR0ZXIgdGhhbiBkcm9wIGxvdHMgb2YgcGtn
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhhbmtzDQo+ID4gPiA+ID4gWmhhbmcgQ2hlbg0KPiA+
ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEhlbGxvLCBaaGFuZw0KPiA+ID4gPg0KPiA+ID4gPiBH
b3QgaXQuDQo+ID4gPiA+IFdoYXQgaXMgdGhlIGNvbmNlcm4gb2YgdGhlIG1hc3NpdmUgImRyb3Ag
cGFja2V0cyI/DQo+ID4gPiA+IERvZXMgdGhlIGJlaGF2aW9yIG1ha2UgdGhlIENPTE8gZG8gY2hl
Y2twb2ludCBwZXJpb2RpY2FsbHkgKH4yMA0KPiA+ID4gPiBzZWNvbmRzKSBpbnN0ZWFkIG9mIGRv
aW5nIGltbWVkaWF0ZSBjaGVja3BvaW50IHdoZW4gZW5jb3VudGVyaW5nDQo+ID4gPiA+IGRpZmZl
cmVudCByZXNwb25zZSBwYWNrZXRzPw0KPiA+ID4NCj4gPiA+IFRoZSBjb25jZXJuIG9mIHRoZSAi
ZHJvcCBwYWNrZXRzIiBpcyBndWVzdCB3aWxsIGxvc2UgbmV0d29yaw0KPiA+ID4gY29ubmVjdGlv
biB3aXRoIG1vc3Qgb2YgcmVhbCBjbGllbnRzIHVudGlsIG5leHQgcGVyaW9kaWMgZm9yY2UNCj4g
PiA+IGNoZWNrcG9pbnQuIENPTE8gZGVzaWduZWQgZm9yIGR5bmFtaWMgY29udHJvbCBjaGVja3Bv
aW50LCBzbyBJIHRoaW5rIGRvDQo+IGEgY2hlY2twb2ludCBoZXJlIHdpbGwgaGVscCBndWVzdCBz
dXBwbHkgc2VydmljZSBmYXN0ZXIuDQo+ID4gPg0KPiA+DQo+ID4gSSBzZWUuDQo+ID4gSSdsbCB1
cGRhdGUgdGhlIHBhdGNoIHdpdGggeW91ciBzdWdnZXN0aW9uIGxhdGVyLg0KPiA+DQo+IA0KPiBI
aSwgWmhhbmcNCj4gSGVyZSBpcyB0aGUgaWRlYSBhbmQgcHNldWRvIGNvZGUgdG8gaGFuZGxlIHRo
ZSAiZHJvcCBwYWNrZXQiLg0KPiANCj4gYGBgDQo+IHJldCA9IHBhY2tldF9lbnF1ZXVlDQo+ICgx
KSByZXQgPT0gMA0KPiAgICAgICBjb21wYXJlIGNvbm5lY3Rpb24NCj4gKDIpIHJldCA9PSAtMQ0K
PiAgICAgICBzZW5kIHBhY2tldA0KPiAoMykgcmV0ID09IHF1ZXVlIGluc2VydGlvbiBmYWlsDQo+
ICAgICAgIGRvIGNoZWNrcG9pbnQNCj4gICAgICAgc2VuZCBhbGwgcXVldWVkIHByaW1hcnkgcGFj
a2V0cw0KPiAgICAgICByZW1vdmUgYWxsIHF1ZXVlZCBzZWNvbmRhcnkgcGFja2V0cyBgYGANCj4g
DQo+IERvIHlvdSBoYXZlIGFueSBjb21tZW50IGZvciB0aGUgaGFuZGxpbmc/DQoNCkxvb2tzIGdv
b2QgZm9yIG1lLg0KDQpUaGFua3MNClpoYW5nIENoZW4NCg0KPiANCj4gVGhhbmtzDQo+IERlcmVr
DQo+IA0KPiA+ID4gPg0KPiA+ID4gPiBJdCBzZWVtcyB0aGF0IGZyZXF1ZW50IGNoZWNrcG9pbnRz
IGNhdXNlZCBieSB0aGUgZnVsbCBxdWV1ZSAoYnVzeQ0KPiA+ID4gPiBuZXR3b3JrKSBpbnN0ZWFk
IG9mIGRpZmZlcmVudA0KPiA+ID4gPiByZXNwb25zZSBwYWNrZXRzIG1heSBoYXJtIHRoZSBoaWdo
IHNwZWVkIG5ldHdvcmsgKDEwIEdicHMgb3INCj4gPiA+ID4gaGlnaGVyKSBwZXJmb3JtYW5jZSBk
cmFtYXRpY2FsbHkuDQo+ID4gPg0KPiA+ID4gWWVzLCBtYXliZSBJIGNhbiBzZW5kIGEgcGF0Y2gg
dG8gbWFrZSB1c2VyIGFkanVzdCBxdWV1ZSBzaXplIGRlcGVuZCBvbg0KPiBpdCdzIG93biBlbnZp
cm9ubWVudC4NCj4gPiA+IEJ1dCB3aXRoIGxhcmdlciBxdWV1ZSBzaXplLCBjb2xvLWNvbXBhcmUg
d2lsbCBzcGVuZCBtdWNoIHRpbWUgdG8gZG8NCj4gPiA+IGNvbXBhcmUgcGFja2V0IHdoZW4gbmV0
d29yayBJcyByZWFsIGJ1c3kgc3RhdHVzLg0KPiA+DQo+ID4gVGhhbmsgeW91LiBUaGUgdXNlci1j
b25maWd1cmFibGUgcXVldWUgc2l6ZSB3aWxsIGJlIHZlcnkgaGVscGZ1bC4NCj4gPg0KPiA+IFRo
YW5rcy4NCj4gPiBEZXJlayBTdQ0KPiA+DQo+ID4gPg0KPiA+ID4gVGhhbmtzDQo+ID4gPiBaaGFu
ZyBDaGVuDQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGFua3MNCj4gPiA+ID4gRGVyZWsNCj4g
PiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEZXJlayBTdSA8
ZGVyZWtzdUBxbmFwLmNvbT4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gIG5ldC9jb2xv
LWNvbXBhcmUuYyB8IDIzICsrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ID4gPiA+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9jb2xvLWNvbXBhcmUuYyBiL25ldC9jb2xv
LWNvbXBhcmUuYyBpbmRleA0KPiA+ID4gPiA+ID4gN2VlMTdmMmNmOC4uY2RkODdiMmFhOCAxMDA2
NDQNCj4gPiA+ID4gPiA+IC0tLSBhL25ldC9jb2xvLWNvbXBhcmUuYw0KPiA+ID4gPiA+ID4gKysr
IGIvbmV0L2NvbG8tY29tcGFyZS5jDQo+ID4gPiA+ID4gPiBAQCAtMTIwLDYgKzEyMCwxMCBAQCBl
bnVtIHsNCj4gPiA+ID4gPiA+ICAgICAgU0VDT05EQVJZX0lOLA0KPiA+ID4gPiA+ID4gIH07DQo+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gK3N0YXRpYyBjb25zdCBjaGFyICpjb2xvX21vZGVbXSA9
IHsNCj4gPiA+ID4gPiA+ICsgICAgW1BSSU1BUllfSU5dID0gInByaW1hcnkiLA0KPiA+ID4gPiA+
ID4gKyAgICBbU0VDT05EQVJZX0lOXSA9ICJzZWNvbmRhcnkiLCB9Ow0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ICBzdGF0aWMgaW50IGNvbXBhcmVfY2hyX3NlbmQoQ29tcGFyZVN0YXRlICpzLA0K
PiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB1aW50OF90ICpi
dWYsIEBAIC0yMTUsNg0KPiA+ID4gPiA+ID4gKzIxOSw3IEBAIHN0YXRpYyBpbnQgcGFja2V0X2Vu
cXVldWUoQ29tcGFyZVN0YXRlICpzLCBpbnQgbW9kZSwNCj4gPiA+ID4gPiA+IENvbm5lY3Rpb24N
Cj4gPiA+ID4gKipjb24pDQo+ID4gPiA+ID4gPiAgICAgIENvbm5lY3Rpb25LZXkga2V5Ow0KPiA+
ID4gPiA+ID4gICAgICBQYWNrZXQgKnBrdCA9IE5VTEw7DQo+ID4gPiA+ID4gPiAgICAgIENvbm5l
Y3Rpb24gKmNvbm47DQo+ID4gPiA+ID4gPiArICAgIGludCByZXQ7DQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gICAgICBpZiAobW9kZSA9PSBQUklNQVJZX0lOKSB7DQo+ID4gPiA+ID4gPiAgICAg
ICAgICBwa3QgPSBwYWNrZXRfbmV3KHMtPnByaV9ycy5idWYsIEBAIC0yNDMsMTYgKzI0OCwxOCBA
QA0KPiA+ID4gPiA+ID4gc3RhdGljIGludCBwYWNrZXRfZW5xdWV1ZShDb21wYXJlU3RhdGUgKnMs
IGludCBtb2RlLA0KPiA+ID4gPiA+ID4gQ29ubmVjdGlvbg0KPiA+ID4gPiAqKmNvbikNCj4gPiA+
ID4gPiA+ICAgICAgfQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAgICAgaWYgKG1vZGUgPT0g
UFJJTUFSWV9JTikgew0KPiA+ID4gPiA+ID4gLSAgICAgICAgaWYgKCFjb2xvX2luc2VydF9wYWNr
ZXQoJmNvbm4tPnByaW1hcnlfbGlzdCwgcGt0LCAmY29ubi0NCj4gPnBhY2spKSB7DQo+ID4gPiA+
ID4gPiAtICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJjb2xvIGNvbXBhcmUgcHJpbWFyeSBxdWV1
ZSBzaXplIHRvbyBiaWcsIg0KPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAi
ZHJvcCBwYWNrZXQiKTsNCj4gPiA+ID4gPiA+IC0gICAgICAgIH0NCj4gPiA+ID4gPiA+ICsgICAg
ICAgIHJldCA9IGNvbG9faW5zZXJ0X3BhY2tldCgmY29ubi0+cHJpbWFyeV9saXN0LCBwa3QsDQo+
ID4gPiA+ID4gPiArICZjb25uLT5wYWNrKTsNCj4gPiA+ID4gPiA+ICAgICAgfSBlbHNlIHsNCj4g
PiA+ID4gPiA+IC0gICAgICAgIGlmICghY29sb19pbnNlcnRfcGFja2V0KCZjb25uLT5zZWNvbmRh
cnlfbGlzdCwgcGt0LCAmY29ubi0NCj4gPnNhY2spKSB7DQo+ID4gPiA+ID4gPiAtICAgICAgICAg
ICAgZXJyb3JfcmVwb3J0KCJjb2xvIGNvbXBhcmUgc2Vjb25kYXJ5IHF1ZXVlIHNpemUgdG9vIGJp
ZywiDQo+ID4gPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICJkcm9wIHBhY2tldCIp
Ow0KPiA+ID4gPiA+ID4gLSAgICAgICAgfQ0KPiA+ID4gPiA+ID4gKyAgICAgICAgcmV0ID0gY29s
b19pbnNlcnRfcGFja2V0KCZjb25uLT5zZWNvbmRhcnlfbGlzdCwgcGt0LA0KPiA+ID4gPiA+ID4g
KyAmY29ubi0+c2Fjayk7DQo+ID4gPiA+ID4gPiAgICAgIH0NCj4gPiA+ID4gPiA+ICsNCj4gPiA+
ID4gPiA+ICsgICAgaWYgKCFyZXQpIHsNCj4gPiA+ID4gPiA+ICsgICAgICAgIGVycm9yX3JlcG9y
dCgiY29sbyBjb21wYXJlICVzIHF1ZXVlIHNpemUgdG9vIGJpZywiDQo+ID4gPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgImRyb3AgcGFja2V0IiwgY29sb19tb2RlW21vZGVdKTsNCj4gPiA+
ID4gPiA+ICsgICAgICAgIHBhY2tldF9kZXN0cm95KHBrdCwgTlVMTCk7DQo+ID4gPiA+ID4gPiAr
ICAgICAgICBwa3QgPSBOVUxMOw0KPiA+ID4gPiA+ID4gKyAgICB9DQo+ID4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gPiAgICAgICpjb24gPSBjb25uOw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAg
ICAgcmV0dXJuIDA7DQo+ID4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+ID4gMi4xNy4xDQo+ID4gPiA+
ID4NCg==

