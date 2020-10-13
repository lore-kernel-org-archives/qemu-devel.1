Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364EEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9452420872
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9452420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEki-0003mE-Pi
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 03:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kSEjM-0002gs-LP; Tue, 13 Oct 2020 03:28:20 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2546 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kSEjK-0004LG-L4; Tue, 13 Oct 2020 03:28:20 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 03D4C96DDA76431286A1;
 Tue, 13 Oct 2020 15:28:07 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 13 Oct 2020 15:28:06 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.75]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0487.000;
 Tue, 13 Oct 2020 15:27:56 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Li Qiang <liq3ea@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Subject: RE: [PATCH] migration/block-dirty-bitmap: fix uninitialized
 variable warning
Thread-Topic: [PATCH] migration/block-dirty-bitmap: fix uninitialized
 variable warning
Thread-Index: AQHWnvWXB6+3xHhZ7kqhgehHhToetKmTlYMAgACocACAAKJqUA==
Date: Tue, 13 Oct 2020 07:27:56 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B9B1FDA@dggemm531-mbx.china.huawei.com>
References: <20201010110730.1575180-1-kuhn.chenqun@huawei.com>
 <2b2bc826-0785-66e2-3515-b98abfac26ca@vivier.eu>
 <CAKXe6SL8fRN=-iqFEiHeWqZm0F+T+8vkc7qJeUz6izQcZQ2Q-A@mail.gmail.com>
In-Reply-To: <CAKXe6SL8fRN=-iqFEiHeWqZm0F+T+8vkc7qJeUz6izQcZQ2Q-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=kuhn.chenqun@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:28:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, ganqixin <ganqixin@huawei.com>,
 "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Qemu Developers <qemu-devel@nongnu.org>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bWlncmF0aW9uL2Jsb2NrLWRpcnR5LWJpdG1hcC5jDQo+ID4gPiBiL21pZ3JhdGlvbi9ibG9jay1k
aXJ0eS1iaXRtYXAuYyBpbmRleCA1YmVmNzkzYWMwLi5lMDllYTRmMjJiIDEwMDY0NA0KPiA+ID4g
LS0tIGEvbWlncmF0aW9uL2Jsb2NrLWRpcnR5LWJpdG1hcC5jDQo+ID4gPiArKysgYi9taWdyYXRp
b24vYmxvY2stZGlydHktYml0bWFwLmMNCj4gPiA+IEBAIC0xMDg0LDkgKzEwODQsNyBAQCBzdGF0
aWMgaW50IGRpcnR5X2JpdG1hcF9sb2FkX2hlYWRlcihRRU1VRmlsZQ0KPiAqZiwgREJNTG9hZFN0
YXRlICpzLA0KPiA+ID4gICAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gPiAgICAgICAgICAgICAg
ICAgIGJpdG1hcF9uYW1lID0gcy0+Yml0bWFwX2FsaWFzOw0KPiA+ID4gICAgICAgICAgICAgIH0N
Cj4gPiA+IC0gICAgICAgIH0NCj4gPiA+DQo+ID4gPiAtICAgICAgICBpZiAoIXMtPmNhbmNlbGxl
ZCkgew0KPiA+ID4gICAgICAgICAgICAgIGdfc3RybGNweShzLT5iaXRtYXBfbmFtZSwgYml0bWFw
X25hbWUsDQo+IHNpemVvZihzLT5iaXRtYXBfbmFtZSkpOw0KPiA+ID4gICAgICAgICAgICAgIHMt
PmJpdG1hcCA9IGJkcnZfZmluZF9kaXJ0eV9iaXRtYXAocy0+YnMsDQo+ID4gPiBzLT5iaXRtYXBf
bmFtZSk7DQo+ID4gPg0KPiA+ID4NCj4gPg0KPiA+IEkgZG9uJ3QgdGhpbmsgaXQncyBjb3JyZWN0
IGFzICJjYW5jZWxfaW5jb21pbmdfbG9ja2VkKHMpIiBjYW4gY2hhbmdlDQo+ID4gdGhlIHZhbHVl
IG9mICJzLT5jYW5jZWxsZWQiLg0KPiA+DQpIaSBMYXVyZW50LA0KICAgWWVzLCB5b3UncmUgcmln
aHQuICBJdCB3aWxsIGJlIG1vZGlmaWVkIHZhbHVlIHdoZW4gY2FuY2VsX2luY29taW5nX2xvY2tl
ZCBpcyBleGVjdXRlZC4NClRoYW5rcy4NCg0KPiBTbyBJIHRoaW5rIHRoaXMgY2FuIHNpbXBseSBh
c3NpZ24gJ2JpdG1hcF9uYW1lJyB0byBOVUxMIHRvIG1ha2UNCj4gY29tcGlsZXIgaGFwcHkuDQo+
DQpIaSBRaWFuZywNCiBJIHRoaW5rIHlvdXIgc3VnZ2VzdGlvbiBpcyBmZWFzaWJsZS4gDQpCdXQg
Y2FuIHdlIGp1c3QgZ2l2ZSBpdCBhIGRlZmF1bHQgdmFsdWUgd2hlbiBkZWZpbmluZyB2YXJpYWJs
ZXM/DQoNCkkgdGhpbmsgdGhlIGRlZmF1bHQgdmFsdWUgY291bGQgYmUgImJpdG1hcF9uYW1lID0g
cy0+Yml0bWFwX2FsaWFzIiwgDQphbmQgdGhlbiB3ZSBjYW4gZGVsZXRlIHRoZSBlbHNlIHN0YXRl
bWVudCBhYm92ZS4NCg0KVGhhbmtzLA0KQ2hlbiBRdW4NCg==

