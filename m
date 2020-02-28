Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4045C3F2D3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D86D24699
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D86D24699
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jRm-0007Ox-OX
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1j7ipo-0002iB-17
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1j7ipm-0002Vv-O3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:49:55 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2079 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1j7ipk-0002Sy-1R; Fri, 28 Feb 2020 11:49:52 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id B993E46D76A342E9820D;
 Fri, 28 Feb 2020 16:49:46 +0000 (GMT)
Received: from lhreml706-chm.china.huawei.com (10.201.108.55) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 28 Feb 2020 16:49:45 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml706-chm.china.huawei.com (10.201.108.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 28 Feb 2020 16:49:46 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Fri, 28 Feb 2020 16:49:46 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: RE: [PATCH v2 1/7] exec: Fix for qemu_ram_resize() callback
Thread-Topic: [PATCH v2 1/7] exec: Fix for qemu_ram_resize() callback
Thread-Index: AQHVzV43w2nN4JnxQEOUTwT8NpSKx6gLQ1MAgAAWtoCAACc+AIABYS3wgAAIyYCAAR1e4IAAFJiAgAAHflCAADtYAIABo1pQgARLAwCAAABbwIAABn8AgAN5SJCAADkTAIABctiAgAAIuACAAAKygIAXjGsw
Date: Fri, 28 Feb 2020 16:49:46 +0000
Message-ID: <8f27608fd02147bfb11bdfca38316f4c@huawei.com>
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
 <fad66252aa8f4b46816f21b5315b6358@huawei.com>
 <8f10dd72-9a19-b910-489c-eacc6a772046@redhat.com>
 <04adb50079bc45888f514721edb3cfa3@huawei.com>
 <69ab2339-f4c3-dbd6-1be7-5d6eef28d027@redhat.com>
 <b78f892f-c917-a3a8-4c6b-8d03af02782d@redhat.com>
In-Reply-To: <b78f892f-c917-a3a8-4c6b-8d03af02782d@redhat.com>
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
 Juan Jose Quintela Carreira <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "lersek@redhat.com" <lersek@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgSGlsZGVuYnJh
bmQgW21haWx0bzpkYXZpZEByZWRoYXQuY29tXQ0KPiBTZW50OiAxMyBGZWJydWFyeSAyMDIwIDE3
OjA5DQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVt
LnRob2RpQGh1YXdlaS5jb20+Ow0KPiBJZ29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQuY29t
Pg0KPiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyB4aWFvZ3Vhbmdyb25nLmVyaWNAZ21h
aWwuY29tOw0KPiBtc3RAcmVkaGF0LmNvbTsgc2hhbm5vbi56aGFvc2xAZ21haWwuY29tOyBxZW11
LWRldmVsQG5vbmdudS5vcmc7DQo+IHh1d2VpIChPKSA8eHV3ZWk1QGh1YXdlaS5jb20+OyBMaW51
eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47DQo+IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgcWVt
dS1hcm1Abm9uZ251Lm9yZzsgbGVyc2VrQHJlZGhhdC5jb207DQo+IGRnaWxiZXJ0QHJlZGhhdC5j
b207IEp1YW4gSm9zZSBRdWludGVsYSBDYXJyZWlyYSA8cXVpbnRlbGFAcmVkaGF0LmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzddIGV4ZWM6IEZpeCBmb3IgcWVtdV9yYW1fcmVzaXpl
KCkgY2FsbGJhY2sNCg0KWy4uLl0NCg0KPiA+PiBUaGFua3MgZm9yIHRoYXQuIEkgaGFkIGEgZ28g
d2l0aCB0aGUgYmVsb3cgcGF0Y2ggYW5kIGl0IGluZGVlZCBmaXhlcyB0aGUgaXNzdWUNCj4gPj4g
b2YgY2FsbGJhY2sgbm90IGJlaW5nIGNhbGxlZCBvbiByZXNpemUuIEJ1dCB0aGUgbWlncmF0aW9u
IGZhaWxzIHdpdGggdGhlIGJlbG93DQo+ID4+IGVycm9yLA0KPiA+Pg0KPiA+PiBGb3IgeDg2DQo+
ID4+IC0tLS0tLS0tLQ0KPiA+PiBxZW11LXN5c3RlbS14ODZfNjQ6IFVua25vd24gY29tYmluYXRp
b24gb2YgbWlncmF0aW9uIGZsYWdzOiAweDE0DQo+ID4+IHFlbXUtc3lzdGVtLXg4Nl82NDogZXJy
b3Igd2hpbGUgbG9hZGluZyBzdGF0ZSBmb3IgaW5zdGFuY2UgMHgwIG9mIGRldmljZQ0KPiAncmFt
Jw0KPiA+PiBxZW11LXN5c3RlbS14ODZfNjQ6IGxvYWQgb2YgbWlncmF0aW9uIGZhaWxlZDogSW52
YWxpZCBhcmd1bWVudA0KPiA+Pg0KPiA+PiBGb3IgYXJtNjQNCj4gPj4gLS0tLS0tLS0tLS0tLS0N
Cj4gPj4gcWVtdS1zeXN0ZW0tYWFyY2g2NDogUmVjZWl2ZWQgYW4gdW5leHBlY3RlZCBjb21wcmVz
c2VkIHBhZ2UNCj4gPj4gcWVtdS1zeXN0ZW0tYWFyY2g2NDogZXJyb3Igd2hpbGUgbG9hZGluZyBz
dGF0ZSBmb3IgaW5zdGFuY2UgMHgwIG9mIGRldmljZQ0KPiAncmFtJw0KPiA+PiBxZW11LXN5c3Rl
bS1hYXJjaDY0OiBsb2FkIG9mIG1pZ3JhdGlvbiBmYWlsZWQ6IEludmFsaWQgYXJndW1lbnQNCj4g
Pj4NCj4gPj4gSSBoYXZlbuKAmXQgZGVidWdnZWQgdGhpcyBmdXJ0aGVyIGJ1dCBsb29rcyBsaWtl
IHRoZXJlIGlzIGEgY29ycnVwdGlvbg0KPiBoYXBwZW5pbmcuDQo+ID4+IFBsZWFzZSBsZXQgbWUg
a25vdyBpZiB5b3UgaGF2ZSBhbnkgY2x1ZS4NCj4gPg0KPiA+IFRoZSBpc3N1ZSBpcw0KPiA+DQo+
ID4gcWVtdV9wdXRfYmU2NChmLCByYW1fYnl0ZXNfdG90YWxfY29tbW9uKHRydWUpIHwNCj4gUkFN
X1NBVkVfRkxBR19NRU1fU0laRSkNCj4gPg0KPiA+IFRoZSB0b3RhbCByYW0gc2l6ZSB3ZSBzdG9y
ZSBtdXN0IGJlIHBhZ2UgYWxpZ25lZCwgb3RoZXJ3aXNlIGl0IHdpbGwgYmUNCj4gPiBkZXRlY3Rl
ZCBhcyBmbGFncy4gSG0gLi4uIG1heWJlIHdlIGNhbiByb3VuZCBpdCB1cCAuLi4NCj4gPg0KPiAN
Cj4gSSdtIGFmcmFpZCB3ZSBjYW4ndCBvdGhlcndpc2Ugd2Ugd2lsbCBydW4gaW50byBpc3N1ZXMg
aW4NCj4gcmFtX2xvYWRfcHJlY29weSgpLiBIbSAuLi4NCg0KU29ycnksIHRvb2sgYSB3aGlsZSB0
byBnZXQgYmFjayBvbiB0aGlzLiBZZXMsIHJvdW5kIHVwIGluZGVlZCBicmVha3MgaW4NCnJhbV9s
b2FkX3ByZWNvcHkoKSAuIEkgaGFkIHRoZSBiZWxvdyBvbiB0b3Agb2YgeW91ciBwYXRjaCBhbmQg
dGhhdCANCnNlZW1zIHRvIGRvIHRoZSBqb2IgKHNhbml0eSB0ZXN0ZWQgb24gYXJtL3ZpcnQpLg0K
DQpQbGVhc2UgdGFrZSBhIGxvb2sgYW5kIGxldCBtZSBrbm93IGlmIHlvdSBzZWUgYW55IGlzc3Vl
cyB3aXRoIHRoaXMgYXBwcm9hY2guDQoNClRoYW5rcywNClNoYW1lZXINCg0KZGlmZiAtLWdpdCBh
L21pZ3JhdGlvbi9yYW0uYyBiL21pZ3JhdGlvbi9yYW0uYw0KaW5kZXggMmFjYzRiODVjYS4uNzQ0
N2YwY2VmYSAxMDA2NDQNCi0tLSBhL21pZ3JhdGlvbi9yYW0uYw0KKysrIGIvbWlncmF0aW9uL3Jh
bS5jDQpAQCAtMTc4Miw3ICsxNzgyLDcgQEAgc3RhdGljIHVpbnQ2NF90IHJhbV9ieXRlc190b3Rh
bF9taWdyYXRpb24odm9pZCkNCiAgICAgUkNVX1JFQURfTE9DS19HVUFSRCgpOw0KIA0KICAgICBS
QU1CTE9DS19GT1JFQUNIX01JR1JBVEFCTEUoYmxvY2spIHsNCi0gICAgICAgIHRvdGFsICs9IHJh
bWJsb2NrX3JhbV9ieXRlc19taWdyYXRpb24oYmxvY2spOw0KKyAgICAgICAgdG90YWwgKz0gYmxv
Y2stPnVzZWRfbGVuZ3RoOw0KICAgICB9DQogICAgIHJldHVybiB0b3RhbDsNCiB9DQpAQCAtMzQ3
OSw3ICszNDc5LDcgQEAgc3RhdGljIGludCByYW1fbG9hZF9wcmVjb3B5KFFFTVVGaWxlICpmKQ0K
ICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsNCiAgICAgICAgICAgICAgICAgfQ0K
IA0KLSAgICAgICAgICAgICAgICB0b3RhbF9yYW1fYnl0ZXMgLT0gbGVuZ3RoOw0KKyAgICAgICAg
ICAgICAgICB0b3RhbF9yYW1fYnl0ZXMgLT0gYmxvY2stPnVzZWRfbGVuZ3RoOw0KICAgICAgICAg
ICAgIH0NCiAgICAgICAgICAgICBicmVhazsNCg0KDQoNCg==

