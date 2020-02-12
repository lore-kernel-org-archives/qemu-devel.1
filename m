Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0778C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 17:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A684520658
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 17:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A684520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1vVk-0002YZ-Sm
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 12:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1j1vUm-0001Uc-GN
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1j1vUk-0004j2-OF
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:08:16 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2076 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1j1vUh-0004YK-8F; Wed, 12 Feb 2020 12:08:11 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 41D181161F13F6FE7F59;
 Wed, 12 Feb 2020 17:07:58 +0000 (GMT)
Received: from lhreml708-chm.china.huawei.com (10.201.108.57) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Feb 2020 17:07:19 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml708-chm.china.huawei.com (10.201.108.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 12 Feb 2020 17:07:19 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Wed, 12 Feb 2020 17:07:19 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: RE: [PATCH v2 1/7] exec: Fix for qemu_ram_resize() callback
Thread-Topic: [PATCH v2 1/7] exec: Fix for qemu_ram_resize() callback
Thread-Index: AQHVzV43w2nN4JnxQEOUTwT8NpSKx6gLQ1MAgAAWtoCAACc+AIABYS3wgAAIyYCAAR1e4IAAFJiAgAAHflCAADtYAIABo1pQgARLAwCAAABbwIAABn8AgAN5SJA=
Date: Wed, 12 Feb 2020 17:07:19 +0000
Message-ID: <fad66252aa8f4b46816f21b5315b6358@huawei.com>
References: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
 <20200117174522.22044-2-shameerali.kolothum.thodi@huawei.com>
 <20200204162320.67e5d353@redhat.com>
 <74eaaa45-0d20-9a21-fbf8-6d29deb248eb@redhat.com>
 <4ce41554-8b8e-dbb5-5fe9-43af09950f23@redhat.com>
 <8e0b2c762e914c64bebfab5fc7441661@huawei.com>
 <133f274e-e942-7008-93d2-8edb1bc4d7ae@redhat.com>
 <52fff289cca14874ad493fc25806fe3d@huawei.com>
 <f041380c-afcb-f8d8-89db-8f48c7b46767@redhat.com>
 <e97fa28c653044b8bab66aeca2374682@huawei.com>
 <0ff4d2c1-ebd3-1d2f-07e8-a4f13be07ceb@redhat.com>
 <6bf255ecb88446f1b08ee4ab21a85f02@huawei.com>
 <69848dd3-fac4-ec6b-78a8-a052124f4fc3@redhat.com>
 <49b54eea65cd49ae832cd6ec21eae64a@huawei.com>
 <b4ccf1d9-4514-6b63-5ef9-1d337f539267@redhat.com>
In-Reply-To: <b4ccf1d9-4514-6b63-5ef9-1d337f539267@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.176.76.210
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "lersek@redhat.com" <lersek@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgSGlsZGVuYnJh
bmQgW21haWx0bzpkYXZpZEByZWRoYXQuY29tXQ0KPiBTZW50OiAxMCBGZWJydWFyeSAyMDIwIDA5
OjU0DQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVt
LnRob2RpQGh1YXdlaS5jb20+Ow0KPiBJZ29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQuY29t
Pg0KPiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyB4aWFvZ3Vhbmdyb25nLmVyaWNAZ21h
aWwuY29tOw0KPiBtc3RAcmVkaGF0LmNvbTsgc2hhbm5vbi56aGFvc2xAZ21haWwuY29tOyBxZW11
LWRldmVsQG5vbmdudS5vcmc7DQo+IHh1d2VpIChPKSA8eHV3ZWk1QGh1YXdlaS5jb20+OyBMaW51
eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47DQo+IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgcWVt
dS1hcm1Abm9uZ251Lm9yZzsgbGVyc2VrQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAxLzddIGV4ZWM6IEZpeCBmb3IgcWVtdV9yYW1fcmVzaXplKCkgY2FsbGJhY2sNCj4gDQo+
IE9uIDEwLjAyLjIwIDEwOjUwLCBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIHdyb3RlOg0KPiA+
DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogRGF2aWQg
SGlsZGVuYnJhbmQgW21haWx0bzpkYXZpZEByZWRoYXQuY29tXQ0KPiA+PiBTZW50OiAxMCBGZWJy
dWFyeSAyMDIwIDA5OjI5DQo+ID4+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFt
ZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+Ow0KPiA+PiBJZ29yIE1hbW1lZG92IDxp
bWFtbWVkb0ByZWRoYXQuY29tPg0KPiA+PiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyB4
aWFvZ3Vhbmdyb25nLmVyaWNAZ21haWwuY29tOw0KPiA+PiBtc3RAcmVkaGF0LmNvbTsgc2hhbm5v
bi56aGFvc2xAZ21haWwuY29tOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+ID4+IHh1d2VpIChP
KSA8eHV3ZWk1QGh1YXdlaS5jb20+OyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47DQo+
ID4+IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgcWVtdS1hcm1Abm9uZ251Lm9yZzsgbGVyc2VrQHJl
ZGhhdC5jb20NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzddIGV4ZWM6IEZpeCBmb3Ig
cWVtdV9yYW1fcmVzaXplKCkgY2FsbGJhY2sNCj4gPj4NCj4gPj4+PiBDYW4geW91IGxvb2sgdGhl
IG9yaWdpbmFsIHZhbHVlIHVwIHNvbWVob3cgYW5kIHVzIHRoZSByZXNpemUgY2FsbGJhY2sNCj4g
Pj4+PiBvbmx5IGFzIGEgbm90aWZpY2F0aW9uIHRoYXQgc29tZXRoaW5nIGNoYW5nZWQ/ICh0aGF0
IHZhbHVlIHdvdWxkIGhhdmUgdG8NCj4gPj4+PiBiZSBzdG9yZWQgc29tZXdoZXJlIGFuZCBtaWdy
YXRlZCBJIGFzc3VtZSAtIG1heWJlIHRoYXQncyBhbHJlYWR5DQo+IGJlaW5nDQo+ID4+Pj4gZG9u
ZSkNCj4gPj4+DQo+ID4+PiBPay4gSSB3aWxsIHRha2UgYSBsb29rIGF0IHRoYXQuIEJ1dCBjYW4g
d2UgaW5zdGVhZCBwYXNzIHRoZQ0KPiBibG9jay0+dXNlZF9sZW5ndGgNCj4gPj4gdG8NCj4gPj4+
IGZ3X2NmZ19hZGRfZmlsZV9jYWxsYmFjaygpLiBUaGF0IHdheSB3ZSBkb27igJl0IGhhdmUgdG8g
Y2hhbmdlIHRoZQ0KPiA+PiBxZW11X3JhbV9yZXNpemUoKQ0KPiA+Pj4gYXMgd2VsbC4gSSB0aGlu
ayBJZ29yIGhhcyBzdWdnZXN0ZWQgdGhpcyBiZWZvcmVbMV0gYW5kIEkgaGFkIGEgZ28gYXQgaXQg
YmVmb3JlDQo+ID4+IGNvbWluZyB1cA0KPiA+Pj4gd2l0aCB0aGUgInJlcV9sZW5ndGgiIHByb3Bv
c2FsIGhlcmUuDQo+ID4+DQo+ID4+IFlvdSBtZWFuLCBwYXNzaW5nIHRoZSBvbGQgc2l6ZSBhcyB3
ZWxsPyBJIGRvbid0IHNlZSBob3cgdGhhdCB3aWxsIHNvbHZlDQo+ID4+IHRoZSBpc3N1ZSwgYnV0
IHllYWgsIG5vdGhpbmcgc3BlYWtzIGFnYWluc3Qgc2ltcGx5IHNlbmRpbmcgdGhlIG9sZCBhbmQN
Cj4gPj4gdGhlIG5ldyBzaXplLg0KPiA+DQo+ID4gTm9wZS4gSSBhY3R1YWxseSBtZWFudCB1c2lu
ZyB0aGUgYmxvY2stPnVzZWRfbGVuZ3RoIHRvIHN0b3JlIGluIHRoZQ0KPiA+IHMtPmZpbGVzLT5m
W2luZGV4XS5zaXplLg0KPiA+DQo+ID4gdmlydF9hY3BpX3NldHVwKCkNCj4gPiAgIGFjcGlfYWRk
X3JvbV9ibG9iKCkNCj4gPiAgICAgcm9tX2FkZF9ibG9iKCkNCj4gPiAgICAgICByb21fc2V0X21y
KCkgIC0tPiB1c2VkX2xlbmd0aCAgPSBwYWdlIGFsaWduZWQgYmxvYiBzaXplDQo+ID4gICAgICAg
ICBmd19jZmdfYWRkX2ZpbGVfY2FsbGJhY2soKSAgLS0+IHVzZXMgYWN0dWFsIGJsb2Igc2l6ZS4N
Cj4gPg0KPiA+DQo+ID4gUmlnaHQgbm93IHdoYXQgd2UgZG8gaXMgdXNlIHRoZSBhY3R1YWwgYmxv
YiBzaXplIHRvIHN0b3JlIGluIEZXQ2ZnRW50cnkuDQo+ID4gSW5zdGVhZCBwYXNzIHRoZSBSQU1C
bG9jayB1c2VkX2xlbmd0aCB0byBmd19jZmdfYWRkX2ZpbGVfY2FsbGJhY2soKS4NCj4gPiBPZiBj
b3Vyc2UgYnkgdGhpcywgdGhlIGZpcm13YXJlIHdpbGwgc2VlIGFuIGFsaWduZWQgc2l6ZSwgYnV0
IHRoYXQgaXMgZmluZSBJIHRoaW5rLg0KPiA+IEJ1dCBhdCB0aGUgc2FtZSB0aW1lIHRoaXMgbWVh
bnMgdGhlIHFlbXVfcmFtX3Jlc2l6ZSgpIGNhbiBzdGF5IGFzIGl0IGlzDQo+ID4gYmVjYXVzZSBp
dCB3aWxsIGludm9rZSB0aGUgY2FsbGJhY2sgd2hlbiB0aGUgc2l6ZSBjaGFuZ2VzIGJleW9uZCB0
aGUgYWxpZ25lZA0KPiA+IHBhZ2Ugc2l6ZS4gQW5kIGFsc28gZHVyaW5nIG1pZ3JhdGlvbiwgdGhl
cmUgd29uJ3QgYmUgYW55IGluY29uc2lzdGVuY3kgYXMNCj4gZXZlcnlvbmUNCj4gPiB3b3JrcyBv
biBhbGlnbmVkIHBhZ2Ugc2l6ZS4NCj4gPg0KPiA+IERvZXMgdGhhdCBtYWtlIHNlbnNlPyBPciBJ
IGFtIGFnYWluIG1pc3Npbmcgc29tZXRoaW5nIGhlcmU/DQo+IA0KPiBPaCwgeW91IG1lYW4gc2lt
cGx5IHJvdW5kaW5nIHVwIHRvIGZ1bGwgcGFnZXMgaW4gdGhlIGZ3IGVudHJpZXM/IElmIHdlDQo+
IGNhbiBkcm9wIHRoZSAic3ViLXBhZ2UiIHJlc3RyaWN0aW9uLCB0aGF0IHdvdWxkIGJlIGF3ZXNv
bWUhDQo+IA0KPiBOZWVkIHRvIGRvdWJsZSBjaGVjayBpZiB0aGF0IGNvdWxkIGJlIGFuIGlzc3Vl
IGZvciBmdy9taWdyYXRpb24vd2hhdGV2ZXIuDQoNCkhtbS4uaXQgYnJlYWtzIHg4NiArIHNlYWJp
b3MgYm9vdC4gVGhlIGlzc3VlIGlzIHNlYWJpb3MgZXhwZWN0cyBSU0RQIGluIEZTRUcNCm1lbW9y
eS4gV2l0aCB0aGUgYWJvdmUgcHJvcG9zZWQgY2hhbmdlLCBSU0RQIHdpbGwgYmUgYWxpZ25lZCB0
byBQQUdFX1NJWkUgYW5kDQpzZWFiaW9zIG1lbSBhbGxvY2F0aW9uIGZvciBSU0RQIGZhaWxzIGF0
LA0KDQpodHRwczovL2dpdGh1Yi5jb20vY29yZWJvb3Qvc2VhYmlvcy9ibG9iL21hc3Rlci9zcmMv
Zncvcm9tZmlsZV9sb2FkZXIuYyNMODUNCg0KVG8gZ2V0IHBhc3MgdGhlIGFib3ZlLCBJIGNoYW5n
ZWQgImFsbG9jX2ZzZWciIGZsYWcgdG8gZmFsc2UgaW4gYnVpbGRfcnNkcCgpLCBidXQNCnNlYWJp
b3Mgc2VlbXMgdG8gbWFrZSB0aGUgYXNzdW1wdGlvbiB0aGF0IFJTRFAgaGFzIHRvIGJlIHBsYWNl
ZCBpbiBGU0VHIG1lbW9yeQ0KaGVyZSwNCmh0dHBzOi8vZ2l0aHViLmNvbS9jb3JlYm9vdC9zZWFi
aW9zL2Jsb2IvbWFzdGVyL3NyYy9mdy9iaW9zdGFibGVzLmMjTDEyNg0KDQpTbyBkb2VzbuKAmXQg
bG9vayBsaWtlIHRoZXJlIGlzIGFuIGVhc3kgZml4IGZvciB0aGlzIHdpdGhvdXQgY2hhbmdpbmcg
dGhlIHNlYWJpb3MgY29kZS4NCg0KQmV0d2VlbiwgT1ZNRiB3b3JrcyBmaW5lIHdpdGggdGhlIGFs
aWduZWQgc2l6ZSBvbiB4ODYuDQoNCk9uZSB0aGluZyB3ZSBjYW4gZG8gaXMgdHJlYXQgdGhlIFJT
RFAgY2FzZSBzZXBhcmF0ZWx5IG9yIG9ubHkgdXNlIHRoZSBhbGlnbmVkDQpwYWdlIHNpemUgZm9y
ICJldGMvYWNwaS90YWJsZXMiIGFzIGJlbG93LA0KDQpkaWZmIC0tZ2l0IGEvaHcvY29yZS9sb2Fk
ZXIuYyBiL2h3L2NvcmUvbG9hZGVyLmMNCmluZGV4IGQxYjc4ZjYwY2QuLmYwN2Y2YTdhMzUgMTAw
NjQ0DQotLS0gYS9ody9jb3JlL2xvYWRlci5jDQorKysgYi9ody9jb3JlL2xvYWRlci5jDQpAQCAt
NjAsNiArNjAsNyBAQA0KICNpbmNsdWRlICJody9ib2FyZHMuaCINCiAjaW5jbHVkZSAicWVtdS9j
dXRpbHMuaCINCiAjaW5jbHVkZSAic3lzZW11L3J1bnN0YXRlLmgiDQorI2luY2x1ZGUgImh3L2Fj
cGkvYW1sLWJ1aWxkLmgiDQogDQogI2luY2x1ZGUgPHpsaWIuaD4NCiANCkBAIC0xMDU2LDYgKzEw
NTcsNyBAQCBNZW1vcnlSZWdpb24gKnJvbV9hZGRfYmxvYihjb25zdCBjaGFyICpuYW1lLCBjb25z
dCB2b2lkICpibG9iLCBzaXplX3QgbGVuLA0KICAgICBpZiAoZndfZmlsZV9uYW1lICYmIGZ3X2Nm
Zykgew0KICAgICAgICAgY2hhciBkZXZwYXRoWzEwMF07DQogICAgICAgICB2b2lkICpkYXRhOw0K
KyAgICAgICAgc2l6ZV90IHNpemUgPSByb20tPmRhdGFzaXplOw0KIA0KICAgICAgICAgaWYgKHJl
YWRfb25seSkgew0KICAgICAgICAgICAgIHNucHJpbnRmKGRldnBhdGgsIHNpemVvZihkZXZwYXRo
KSwgIi9yb21AJXMiLCBmd19maWxlX25hbWUpOw0KQEAgLTEwNjYsMTMgKzEwNjgsMjEgQEAgTWVt
b3J5UmVnaW9uICpyb21fYWRkX2Jsb2IoY29uc3QgY2hhciAqbmFtZSwgY29uc3Qgdm9pZCAqYmxv
Yiwgc2l6ZV90IGxlbiwNCiAgICAgICAgIGlmIChtYy0+cm9tX2ZpbGVfaGFzX21yKSB7DQogICAg
ICAgICAgICAgZGF0YSA9IHJvbV9zZXRfbXIocm9tLCBPQkpFQ1QoZndfY2ZnKSwgZGV2cGF0aCwg
cmVhZF9vbmx5KTsNCiAgICAgICAgICAgICBtciA9IHJvbS0+bXI7DQorICAgICAgICAgICAvKg0K
KyAgICAgICAgICAgICogVXNlIHRoZSBSQU1ibGsgdXNlZF9sZW5ndGggZm9yIGFjcGkgdGFibGVz
IGFzIHRoaXMgYXZvaWRzIGFueQ0KKyAgICAgICAgICAgICogaW5jb25zaXN0ZW5jeSB3aXRoIHRh
YmxlIHNpemUgY2hhbmdlcyBkdXJpbmcgaG90IGFkZCBhbmQgZHVyaW5nDQorICAgICAgICAgICAg
KiBtaWdyYXRpb24uDQorICAgICAgICAgICAgKi8NCisgICAgICAgICAgIGlmIChzdHJjbXAoZndf
ZmlsZV9uYW1lLCBBQ1BJX0JVSUxEX1RBQkxFX0ZJTEUpID09IDApIHsNCisgICAgICAgICAgICAg
ICAgc2l6ZSA9IG1lbW9yeV9yZWdpb25fZ2V0X3VzZWRfbGVuZ3RoKG1yKTsNCisgICAgICAgICAg
IH0NCiAgICAgICAgIH0gZWxzZSB7DQogICAgICAgICAgICAgZGF0YSA9IHJvbS0+ZGF0YTsNCiAg
ICAgICAgIH0NCiANCiAgICAgICAgIGZ3X2NmZ19hZGRfZmlsZV9jYWxsYmFjayhmd19jZmcsIGZ3
X2ZpbGVfbmFtZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmd19jYWxsYmFj
aywgTlVMTCwgY2FsbGJhY2tfb3BhcXVlLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGRhdGEsIHJvbS0+ZGF0YXNpemUsIHJlYWRfb25seSk7DQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZGF0YSwgc2l6ZSwgcmVhZF9vbmx5KTsNCiAgICAgfQ0KICAgICByZXR1
cm4gbXI7DQogfQ0KDQoNClRob3VnaHRzPw0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCg0K

