Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DDDC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 04:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 879F420717
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 04:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879F420717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8zDE-0006eY-ML
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 23:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jianjay.zhou@huawei.com>) id 1j8zCA-000674-M5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 23:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jianjay.zhou@huawei.com>) id 1j8zC9-00046e-J0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 23:30:14 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2454 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
 id 1j8zC9-00046D-91
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 23:30:13 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id C3831BB387B08619B24D;
 Tue,  3 Mar 2020 12:30:06 +0800 (CST)
Received: from DGGEMM528-MBX.china.huawei.com ([169.254.8.90]) by
 DGGEMM406-HUB.china.huawei.com ([10.3.20.214]) with mapi id 14.03.0439.000;
 Tue, 3 Mar 2020 12:29:57 +0800
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
To: Peter Feiner <pfeiner@google.com>
Subject: RE: RFC: Split EPT huge pages in advance of dirty logging
Thread-Topic: RFC: Split EPT huge pages in advance of dirty logging
Thread-Index: AdXmU97BvyK5YKoyS5++my9GnvXVk///1+yA//428yCAA1S3gP/+abuggAMs8gCAAd62AIAAJJ4A//B2yiAD16MpAP/+sSEw
Date: Tue, 3 Mar 2020 04:29:57 +0000
Message-ID: <B2D15215269B544CADD246097EACE7474BB4DD60@DGGEMM528-MBX.china.huawei.com>
References: <B2D15215269B544CADD246097EACE7474BAF9AB6@DGGEMM528-MBX.china.huawei.com>
 <20200218174311.GE1408806@xz-x1>
 <B2D15215269B544CADD246097EACE7474BAFF835@DGGEMM528-MBX.china.huawei.com>
 <20200219171919.GA34517@xz-x1>
 <B2D15215269B544CADD246097EACE7474BB03772@DGGEMM528-MBX.china.huawei.com>
 <CANgfPd-P_=GqcMiwLSSkUhZDt42aMLUsCJt+CPdUN5yR3RLHmQ@mail.gmail.com>
 <cd4626a1-44b5-1a62-cf4b-716950a6db1b@google.com>
 <CAM3pwhGF3ABoew5UOd9xUxtm14VN_o0gr+D=KfR3ZEQjmKgUdQ@mail.gmail.com>
 <B2D15215269B544CADD246097EACE7474BB4A71D@DGGEMM528-MBX.china.huawei.com>
 <CAM3pwhH8xyisEq_=LFTy=sZNA2kRTQTbBqW6GA-0M-AiJy0q1g@mail.gmail.com>
In-Reply-To: <CAM3pwhH8xyisEq_=LFTy=sZNA2kRTQTbBqW6GA-0M-AiJy0q1g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.228.206]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.187
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
Cc: "Liujinsong \(Paul\)" <liu.jinsong@huawei.com>,
 Junaid Shahid <junaids@google.com>, "linfeng \(M\)" <linfeng23@huawei.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "wangxin \(U\)" <wangxinxin.wang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, Ben Gardon <bgardon@google.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Huangweidong \(C\)" <weidong.huang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCkZyb206IFBldGVyIEZlaW5lciBbbWFpbHRvOnBmZWluZXJAZ29vZ2xlLmNvbV0gDQpTZW50
OiBUdWVzZGF5LCBNYXJjaCAzLCAyMDIwIDEyOjI5IEFNDQpUbzogWmhvdWppYW4gKGpheSkgPGpp
YW5qYXkuemhvdUBodWF3ZWkuY29tPg0KQ2M6IEJlbiBHYXJkb24gPGJnYXJkb25AZ29vZ2xlLmNv
bT47IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT47IGt2bUB2Z2VyLmtlcm5lbC5vcmc7IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbTsgZGdpbGJlcnRAcmVkaGF0
LmNvbTsgcXVpbnRlbGFAcmVkaGF0LmNvbTsgTGl1amluc29uZyAoUGF1bCkgPGxpdS5qaW5zb25n
QGh1YXdlaS5jb20+OyBsaW5mZW5nIChNKSA8bGluZmVuZzIzQGh1YXdlaS5jb20+OyB3YW5neGlu
IChVKSA8d2FuZ3hpbnhpbi53YW5nQGh1YXdlaS5jb20+OyBIdWFuZ3dlaWRvbmcgKEMpIDx3ZWlk
b25nLmh1YW5nQGh1YXdlaS5jb20+OyBKdW5haWQgU2hhaGlkIDxqdW5haWRzQGdvb2dsZS5jb20+
DQpTdWJqZWN0OiBSZTogUkZDOiBTcGxpdCBFUFQgaHVnZSBwYWdlcyBpbiBhZHZhbmNlIG9mIGRp
cnR5IGxvZ2dpbmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRl
ciBGZWluZXIgW21haWx0bzpwZmVpbmVyQGdvb2dsZS5jb21dDQoNClsuLi5dDQoNCj5IaSBKYXks
DQo+SSd2ZSBiZWVuIHNpY2sgc2luY2UgSSBzZW50IG15IGxhc3QgZW1haWwsIHNvIEkgaGF2ZW4n
dCBnb3R0ZW4gdG8gdGhpcyBwYXRjaCBzZXQgeWV0LiBJJ2xsIHNlbmQgaXQgaW4gdGhlIG5leHQg
d2VlayBvciB0d28uwqANCg0KT0ssIHBsZWFzZSB0YWtlIGNhcmUgb2YgeW91cnNlbGYuDQoNCg0K
UmVnYXJkcywNCkpheSBaaG91DQo=

