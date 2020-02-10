Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACF5C3B184
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E28208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E28208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j15jD-0005Zb-N2
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 04:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1j15i8-0004sL-81
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1j15i7-0007sx-6Y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:50:36 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2075 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1j15i4-0007mA-Kf; Mon, 10 Feb 2020 04:50:32 -0500
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 122535701E639931E78C;
 Mon, 10 Feb 2020 09:50:23 +0000 (GMT)
Received: from lhreml702-chm.china.huawei.com (10.201.108.51) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 10 Feb 2020 09:50:22 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml702-chm.china.huawei.com (10.201.108.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 10 Feb 2020 09:50:22 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Mon, 10 Feb 2020 09:50:22 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: RE: [PATCH v2 1/7] exec: Fix for qemu_ram_resize() callback
Thread-Topic: [PATCH v2 1/7] exec: Fix for qemu_ram_resize() callback
Thread-Index: AQHVzV43w2nN4JnxQEOUTwT8NpSKx6gLQ1MAgAAWtoCAACc+AIABYS3wgAAIyYCAAR1e4IAAFJiAgAAHflCAADtYAIABo1pQgARLAwCAAABbwA==
Date: Mon, 10 Feb 2020 09:50:22 +0000
Message-ID: <49b54eea65cd49ae832cd6ec21eae64a@huawei.com>
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
In-Reply-To: <69848dd3-fac4-ec6b-78a8-a052124f4fc3@redhat.com>
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
OjI5DQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVt
LnRob2RpQGh1YXdlaS5jb20+Ow0KPiBJZ29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQuY29t
Pg0KPiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyB4aWFvZ3Vhbmdyb25nLmVyaWNAZ21h
aWwuY29tOw0KPiBtc3RAcmVkaGF0LmNvbTsgc2hhbm5vbi56aGFvc2xAZ21haWwuY29tOyBxZW11
LWRldmVsQG5vbmdudS5vcmc7DQo+IHh1d2VpIChPKSA8eHV3ZWk1QGh1YXdlaS5jb20+OyBMaW51
eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47DQo+IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgcWVt
dS1hcm1Abm9uZ251Lm9yZzsgbGVyc2VrQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAxLzddIGV4ZWM6IEZpeCBmb3IgcWVtdV9yYW1fcmVzaXplKCkgY2FsbGJhY2sNCj4gDQo+
ID4+IENhbiB5b3UgbG9vayB0aGUgb3JpZ2luYWwgdmFsdWUgdXAgc29tZWhvdyBhbmQgdXMgdGhl
IHJlc2l6ZSBjYWxsYmFjaw0KPiA+PiBvbmx5IGFzIGEgbm90aWZpY2F0aW9uIHRoYXQgc29tZXRo
aW5nIGNoYW5nZWQ/ICh0aGF0IHZhbHVlIHdvdWxkIGhhdmUgdG8NCj4gPj4gYmUgc3RvcmVkIHNv
bWV3aGVyZSBhbmQgbWlncmF0ZWQgSSBhc3N1bWUgLSBtYXliZSB0aGF0J3MgYWxyZWFkeSBiZWlu
Zw0KPiA+PiBkb25lKQ0KPiA+DQo+ID4gT2suIEkgd2lsbCB0YWtlIGEgbG9vayBhdCB0aGF0LiBC
dXQgY2FuIHdlIGluc3RlYWQgcGFzcyB0aGUgYmxvY2stPnVzZWRfbGVuZ3RoDQo+IHRvDQo+ID4g
ZndfY2ZnX2FkZF9maWxlX2NhbGxiYWNrKCkuIFRoYXQgd2F5IHdlIGRvbuKAmXQgaGF2ZSB0byBj
aGFuZ2UgdGhlDQo+IHFlbXVfcmFtX3Jlc2l6ZSgpDQo+ID4gYXMgd2VsbC4gSSB0aGluayBJZ29y
IGhhcyBzdWdnZXN0ZWQgdGhpcyBiZWZvcmVbMV0gYW5kIEkgaGFkIGEgZ28gYXQgaXQgYmVmb3Jl
DQo+IGNvbWluZyB1cA0KPiA+IHdpdGggdGhlICJyZXFfbGVuZ3RoIiBwcm9wb3NhbCBoZXJlLg0K
PiANCj4gWW91IG1lYW4sIHBhc3NpbmcgdGhlIG9sZCBzaXplIGFzIHdlbGw/IEkgZG9uJ3Qgc2Vl
IGhvdyB0aGF0IHdpbGwgc29sdmUNCj4gdGhlIGlzc3VlLCBidXQgeWVhaCwgbm90aGluZyBzcGVh
a3MgYWdhaW5zdCBzaW1wbHkgc2VuZGluZyB0aGUgb2xkIGFuZA0KPiB0aGUgbmV3IHNpemUuDQoN
Ck5vcGUuIEkgYWN0dWFsbHkgbWVhbnQgdXNpbmcgdGhlIGJsb2NrLT51c2VkX2xlbmd0aCB0byBz
dG9yZSBpbiB0aGUgDQpzLT5maWxlcy0+ZltpbmRleF0uc2l6ZS4gDQoNCnZpcnRfYWNwaV9zZXR1
cCgpDQogIGFjcGlfYWRkX3JvbV9ibG9iKCkNCiAgICByb21fYWRkX2Jsb2IoKQ0KICAgICAgcm9t
X3NldF9tcigpICAtLT4gdXNlZF9sZW5ndGggID0gcGFnZSBhbGlnbmVkIGJsb2Igc2l6ZQ0KICAg
ICAgICBmd19jZmdfYWRkX2ZpbGVfY2FsbGJhY2soKSAgLS0+IHVzZXMgYWN0dWFsIGJsb2Igc2l6
ZS4NCg0KDQpSaWdodCBub3cgd2hhdCB3ZSBkbyBpcyB1c2UgdGhlIGFjdHVhbCBibG9iIHNpemUg
dG8gc3RvcmUgaW4gRldDZmdFbnRyeS4NCkluc3RlYWQgcGFzcyB0aGUgUkFNQmxvY2sgdXNlZF9s
ZW5ndGggdG8gZndfY2ZnX2FkZF9maWxlX2NhbGxiYWNrKCkuDQpPZiBjb3Vyc2UgYnkgdGhpcywg
dGhlIGZpcm13YXJlIHdpbGwgc2VlIGFuIGFsaWduZWQgc2l6ZSwgYnV0IHRoYXQgaXMgZmluZSBJ
IHRoaW5rLg0KQnV0IGF0IHRoZSBzYW1lIHRpbWUgdGhpcyBtZWFucyB0aGUgcWVtdV9yYW1fcmVz
aXplKCkgY2FuIHN0YXkgYXMgaXQgaXMgDQpiZWNhdXNlIGl0IHdpbGwgaW52b2tlIHRoZSBjYWxs
YmFjayB3aGVuIHRoZSBzaXplIGNoYW5nZXMgYmV5b25kIHRoZSBhbGlnbmVkDQpwYWdlIHNpemUu
IEFuZCBhbHNvIGR1cmluZyBtaWdyYXRpb24sIHRoZXJlIHdvbid0IGJlIGFueSBpbmNvbnNpc3Rl
bmN5IGFzIGV2ZXJ5b25lDQp3b3JrcyBvbiBhbGlnbmVkIHBhZ2Ugc2l6ZS4NCg0KRG9lcyB0aGF0
IG1ha2Ugc2Vuc2U/IE9yIEkgYW0gYWdhaW4gbWlzc2luZyBzb21ldGhpbmcgaGVyZT8NCg0KVGhh
bmtzLA0KU2hhbWVlcg0KDQo+IC0tDQo+IFRoYW5rcywNCj4gDQo+IERhdmlkIC8gZGhpbGRlbmIN
Cg0K

