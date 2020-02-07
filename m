Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893A1C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E62520838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E62520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j069O-0001o9-Gr
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1j068U-0000Io-HN
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1j068T-0004XT-2j
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:05:42 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2074 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1j068P-0004Qp-P7; Fri, 07 Feb 2020 11:05:37 -0500
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 758D95F97B0B9C3636AF;
 Fri,  7 Feb 2020 16:05:30 +0000 (GMT)
Received: from lhreml702-chm.china.huawei.com (10.201.108.51) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 7 Feb 2020 16:05:29 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml702-chm.china.huawei.com (10.201.108.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 7 Feb 2020 16:05:29 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Fri, 7 Feb 2020 16:05:29 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: RE: [PATCH v2 1/7] exec: Fix for qemu_ram_resize() callback
Thread-Topic: [PATCH v2 1/7] exec: Fix for qemu_ram_resize() callback
Thread-Index: AQHVzV43w2nN4JnxQEOUTwT8NpSKx6gLQ1MAgAAWtoCAACc+AIABYS3wgAAIyYCAAR1e4IAAFJiAgAAHflCAADtYAIABo1pQ
Date: Fri, 7 Feb 2020 16:05:29 +0000
Message-ID: <6bf255ecb88446f1b08ee4ab21a85f02@huawei.com>
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
In-Reply-To: <0ff4d2c1-ebd3-1d2f-07e8-a4f13be07ceb@redhat.com>
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
bmQgW21haWx0bzpkYXZpZEByZWRoYXQuY29tXQ0KPiBTZW50OiAwNiBGZWJydWFyeSAyMDIwIDE0
OjU1DQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVt
LnRob2RpQGh1YXdlaS5jb20+Ow0KPiBJZ29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQuY29t
Pg0KPiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyB4aWFvZ3Vhbmdyb25nLmVyaWNAZ21h
aWwuY29tOw0KPiBtc3RAcmVkaGF0LmNvbTsgc2hhbm5vbi56aGFvc2xAZ21haWwuY29tOyBxZW11
LWRldmVsQG5vbmdudS5vcmc7DQo+IHh1d2VpIChPKSA8eHV3ZWk1QGh1YXdlaS5jb20+OyBMaW51
eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47DQo+IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgcWVt
dS1hcm1Abm9uZ251Lm9yZzsgbGVyc2VrQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAxLzddIGV4ZWM6IEZpeCBmb3IgcWVtdV9yYW1fcmVzaXplKCkgY2FsbGJhY2sNCj4gDQo+
IE9uIDA2LjAyLjIwIDEyOjI4LCBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIHdyb3RlOg0KPiA+
DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogRGF2aWQg
SGlsZGVuYnJhbmQgW21haWx0bzpkYXZpZEByZWRoYXQuY29tXQ0KPiA+PiBTZW50OiAwNiBGZWJy
dWFyeSAyMDIwIDEwOjU2DQo+ID4+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFt
ZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+Ow0KPiA+PiBJZ29yIE1hbW1lZG92IDxp
bWFtbWVkb0ByZWRoYXQuY29tPg0KPiA+PiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyB4
aWFvZ3Vhbmdyb25nLmVyaWNAZ21haWwuY29tOw0KPiA+PiBtc3RAcmVkaGF0LmNvbTsgc2hhbm5v
bi56aGFvc2xAZ21haWwuY29tOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+ID4+IHh1d2VpIChP
KSA8eHV3ZWk1QGh1YXdlaS5jb20+OyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47DQo+
ID4+IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgcWVtdS1hcm1Abm9uZ251Lm9yZzsgbGVyc2VrQHJl
ZGhhdC5jb20NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzddIGV4ZWM6IEZpeCBmb3Ig
cWVtdV9yYW1fcmVzaXplKCkgY2FsbGJhY2sNCj4gPg0KPiA+IFsuLi5dDQo+ID4NCj4gPj4+IHJv
b3RAdWJ1bnR1Oi8jIGNhdCAvZGV2L3BtZW0NCj4gPj4+IHBtZW0wICBwbWVtMQ0KPiA+Pj4NCj4g
Pj4+IEZyb20gdGhlIGxvZ3MsIGl0IGxvb2tzIGxpa2UgdGhlIHJhbV9sb2FkX3ByZWNvcHkoKSAt
LT4gcWVtdV9yYW1fcmVzaXplKCkNCj4gaXMNCj4gPj4gbm90DQo+ID4+PiBjYWxsZWQgYXMgbGVu
Z3RoID09IHVzZWRfbGVuZ3RoIGFuZCBib3RoIHNlZW1zIHRvIGJlIHBhZ2UgYWxpZ25lZCB2YWx1
ZXMuDQo+ID4+PiBBbmQgZnJvbQ0KPiA+PiBodHRwczovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2Js
b2IvbWFzdGVyL21pZ3JhdGlvbi9yYW0uYyNMMzQyMQ0KPiA+Pj4gcWVtdV9yYW1fcmVzaXplKCkg
aXMgY2FsbGVkIHdpdGggbGVuZ3RoIGlmIGxlbmd0aCAhPSB1c2VkX2xlbmd0aC4NCj4gPj4NCj4g
Pj4gQXNzdW1lIG9uIHlvdXIgc291cmNlLCB0aGUgb2xkIHNpemUgaXMgMTIzNDUgYnl0ZXMuIFNv
IDE2Mzg0IGFsaWduZWQgdXANCj4gPj4gKDQgcGFnZXMpLg0KPiA+Pg0KPiA+PiBBc3N1bWUgb24g
eW91ciB0YXJnZXQsIHRoZSBuZXcgc2l6ZSBpcyAxMjM0NTYgYnl0ZXMsIHNvIDEyNjk3NiBhbGln
bmVkDQo+ID4+IHVwICgzMSBwYWdlcykuDQo+ID4+DQo+ID4+IElmIHlvdSBtaWdyYXRlIGZyb20g
c291cmNlIHRvIGRlc3RpbmF0aW9uLCB0aGUgbWlncmF0aW9uIGNvZGUgd291bGQNCj4gPj4gcmVz
aXplIHRvIDE2Mzg0LCBhbHRob3VnaCB0aGUgImFjdHVhbCBzaXplIiBpcyAxMjM0NS4gVGhlIGNh
bGxiYWNrIHdpbGwNCj4gPj4gYmUgY2FsbGVkIHdpdGggdGhlIGFsaWduZWQgc2l6ZSwgbm90IHRo
ZSBhY3R1YWwgc2l6ZS4gU2FtZSB0aGUgb3RoZXIgd2F5DQo+ID4+IGFyb3VuZC4gVGhhdCdzIHdo
YXQncyBpbmNvbnNpc3RlbnQgSU1ITy4NCj4gPg0KPiA+IFRoYW5rcy4gWW91IGFyZSByaWdodC4g
SSBkaWRu4oCZdCBjb25zaWRlciB0aGUgY2FzZSB3aGVyZSB0aGUgdGFyZ2V0IGNhbiBiZQ0KPiA+
IGNvbmZpZ3VyZWQgd2l0aCBhIGxhcmdlciBudW1iZXIgb2YgZGV2aWNlcyB0aGFuIHRoZSBzb3Vy
Y2UuIEkgY2FuIHJlcGxpY2F0ZQ0KPiA+IHRoZSBzY2VuYXJpbyBub3csDQo+ID4NCj4gPiBTb3Vy
Y2U6DQo+ID4NCj4gPiBmd19jZmdfYWRkX2ZpbGVfY2FsbGJhY2s6IGZpbGVuYW1lIGV0Yy9ib290
LWZhaWwtd2FpdCBzaXplIDB4NA0KPiA+IGZ3X2NmZ19hZGRfZmlsZV9jYWxsYmFjazogZmlsZW5h
bWUgZXRjL2FjcGkvbnZkaW1tLW1lbSBzaXplIDB4MTAwMA0KPiA+IGZ3X2NmZ19hZGRfZmlsZV9j
YWxsYmFjazogZmlsZW5hbWUgZXRjL2FjcGkvdGFibGVzIHNpemUgMHg2MjEwDQo+ID4NCj4gPiBU
YXJnZXQ6DQo+ID4gcmFtX2xvYWRfcHJlY29weTogUmFtIGJsayBtZW0xIGxlbmd0aCAweDQwMDAw
MDAwIHVzZWRfbGVuZ3RoDQo+IDB4NDAwMDAwMDANCj4gPiByYW1fbG9hZF9wcmVjb3B5OiBSYW0g
YmxrIHZpcnQuZmxhc2gwIGxlbmd0aCAweDQwMDAwMDAgdXNlZF9sZW5ndGgNCj4gMHg0MDAwMDAw
DQo+ID4gcmFtX2xvYWRfcHJlY29weTogUmFtIGJsayB2aXJ0LmZsYXNoMSBsZW5ndGggMHg0MDAw
MDAwIHVzZWRfbGVuZ3RoDQo+IDB4NDAwMDAwMA0KPiA+IHJhbV9sb2FkX3ByZWNvcHk6IFJhbSBi
bGsgL3JvbUBldGMvYWNwaS90YWJsZXMgbGVuZ3RoIDB4NzAwMA0KPiB1c2VkX2xlbmd0aCAweDgw
MDANCj4gPiBmd19jZmdfbW9kaWZ5X2ZpbGU6IGZpbGVuYW1lIGV0Yy9hY3BpL3RhYmxlcyBsZW4g
MHg3MDAwDQo+ID4NCj4gPiBUYXJnZXQgdXBkYXRlcyBGV0NmZ0VudHJ5IHdpdGggYSBwYWdlIGFs
aWduZWQgc2l6ZSA6KC4gSSB3aWxsIGxvb2sgaW50byB0aGlzIGFuZA0KPiBzZWUgaG93DQo+ID4g
d2UgY2FuIHNvbHZlIHRoaXMuIEFueSBwb2ludGVycyB3ZWxjb21lLg0KPiANCj4gQ2FuIHlvdSBs
b29rIHRoZSBvcmlnaW5hbCB2YWx1ZSB1cCBzb21laG93IGFuZCB1cyB0aGUgcmVzaXplIGNhbGxi
YWNrDQo+IG9ubHkgYXMgYSBub3RpZmljYXRpb24gdGhhdCBzb21ldGhpbmcgY2hhbmdlZD8gKHRo
YXQgdmFsdWUgd291bGQgaGF2ZSB0bw0KPiBiZSBzdG9yZWQgc29tZXdoZXJlIGFuZCBtaWdyYXRl
ZCBJIGFzc3VtZSAtIG1heWJlIHRoYXQncyBhbHJlYWR5IGJlaW5nDQo+IGRvbmUpDQoNCk9rLiBJ
IHdpbGwgdGFrZSBhIGxvb2sgYXQgdGhhdC4gQnV0IGNhbiB3ZSBpbnN0ZWFkIHBhc3MgdGhlIGJs
b2NrLT51c2VkX2xlbmd0aCB0bw0KZndfY2ZnX2FkZF9maWxlX2NhbGxiYWNrKCkuIFRoYXQgd2F5
IHdlIGRvbuKAmXQgaGF2ZSB0byBjaGFuZ2UgdGhlIHFlbXVfcmFtX3Jlc2l6ZSgpDQphcyB3ZWxs
LiBJIHRoaW5rIElnb3IgaGFzIHN1Z2dlc3RlZCB0aGlzIGJlZm9yZVsxXSBhbmQgSSBoYWQgYSBn
byBhdCBpdCBiZWZvcmUgY29taW5nIHVwDQp3aXRoIHRoZSAicmVxX2xlbmd0aCIgcHJvcG9zYWwg
aGVyZS4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cWVtdS1kZXZlbC8zMjNhYTc0YTkyOTM0YjZhOTg5ZTZlNGRiZTBkZmUyMUBodWF3ZWkuY29tLw0K
DQoNCg==

