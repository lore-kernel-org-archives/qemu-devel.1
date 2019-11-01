Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B1FCA9EC9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 07:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78B120679
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 07:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78B120679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQRWY-0002F0-Tq
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 03:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tu.guoyi@h3c.com>) id 1iQRVu-0001i6-Jh
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 03:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tu.guoyi@h3c.com>) id 1iQRVt-0000yU-Bz
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 03:38:30 -0400
Received: from smtp.h3c.com ([60.191.123.50]:39081 helo=h3cspam02-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tu.guoyi@h3c.com>)
 id 1iQRVo-0000kf-CA; Fri, 01 Nov 2019 03:38:25 -0400
Received: from DAG2EX06-IDC.srv.huawei-3com.com ([10.8.0.69])
 by h3cspam02-ex.h3c.com with ESMTPS id xA17bZqc031543
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Nov 2019 15:37:35 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX06-IDC.srv.huawei-3com.com (10.8.0.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 1 Nov 2019 15:37:37 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%6])
 with mapi id 15.01.1713.004; Fri, 1 Nov 2019 15:37:37 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: [PATCH v4] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Topic: [PATCH v4] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Index: AdWQhrb0bffMwMc6ShSREntjykPuIg==
Date: Fri, 1 Nov 2019 07:37:35 +0000
Message-ID: <4ba40cd1e7ee4a708b40899952e49f22@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.108.112]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com xA17bZqc031543
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 60.191.123.50
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
Cc: Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Wangyongqing <w_yongqing@h3c.com>, Changlimin <changlimin@h3c.com>,
 Gaoliang <liang_gao@h3c.com>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlcmUgYXJlIHR3byBpc3N1ZXMgaW4gSW4gY2hlY2tfY29uc3RyYWludHNfb25fYml0bWFwKCks
DQoxKSBUaGUgc2FuaXR5IGNoZWNrIG9uIHRoZSBncmFudWxhcml0eSB3aWxsIGNhdXNlIHVpbnQ2
NF90DQppbnRlZ2VyIGxlZnQtc2hpZnQgb3ZlcmZsb3cgd2hlbiBjbHVzdGVyX3NpemUgaXMgMk0g
YW5kIHRoZQ0KZ3JhbnVsYXJpdHkgaXMgQklHR0VSIHRoYW4gMzJLLg0KMikgVGhlIHdheSB0byBj
YWxjdWxhdGUgaW1hZ2Ugc2l6ZSB0aGF0IHRoZSBtYXhpbXVtIGJpdG1hcA0Kc3VwcG9ydGVkIGNh
biBtYXAgdG8gaXMgYSBiaXQgaW5jb3JyZWN0Lg0KVGhpcyBwYXRjaCBmaXggaXQgYnkgYWRkIGEg
aGVscGVyIGZ1bmN0aW9uIHRvIGNhbGN1bGF0ZSB0aGUNCm51bWJlciBvZiBieXRlcyBuZWVkZWQg
YnkgYSBub3JtYWwgYml0bWFwIGluIGltYWdlIGFuZCBjb21wYXJlDQppdCB0byB0aGUgbWF4aW11
bSBiaXRtYXAgYnl0ZXMgc3VwcG9ydGVkIGJ5IHFlbXUuDQoNCkZpeGVzOiA1ZjcyODI2ZTdmYzYy
MTY3Y2YzYQ0KU2lnbmVkLW9mZi1ieTogR3VveWkgVHUgPHR1Lmd1b3lpQGgzYy5jb20+DQotLS0N
CiBibG9jay9xY293Mi1iaXRtYXAuYyB8IDE0ICsrKysrKysrKysrLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDExIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ibG9j
ay9xY293Mi1iaXRtYXAuYyBiL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQppbmRleCA5ODI5NGE3Li5l
ZjllZjYyIDEwMDY0NA0KLS0tIGEvYmxvY2svcWNvdzItYml0bWFwLmMNCisrKyBiL2Jsb2NrL3Fj
b3cyLWJpdG1hcC5jDQpAQCAtMTQyLDYgKzE0MiwxMyBAQCBzdGF0aWMgaW50IGNoZWNrX3RhYmxl
X2VudHJ5KHVpbnQ2NF90IGVudHJ5LCBpbnQgY2x1c3Rlcl9zaXplKQ0KICAgICByZXR1cm4gMDsN
CiB9DQogDQorc3RhdGljIGludDY0X3QgZ2V0X2JpdG1hcF9ieXRlc19uZWVkZWQoaW50NjRfdCBs
ZW4sIHVpbnQzMl90IGdyYW51bGFyaXR5KQ0KK3sNCisgICAgaW50NjRfdCBudW1fYml0cyA9IERJ
Vl9ST1VORF9VUChsZW4sIGdyYW51bGFyaXR5KTsNCisNCisgICAgcmV0dXJuIERJVl9ST1VORF9V
UChudW1fYml0cywgOCk7DQorfQ0KKw0KIHN0YXRpYyBpbnQgY2hlY2tfY29uc3RyYWludHNfb25f
Yml0bWFwKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUsDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDMyX3QgZ3JhbnVsYXJpdHksDQpAQCAtMTUwLDYgKzE1Nyw3IEBA
IHN0YXRpYyBpbnQgY2hlY2tfY29uc3RyYWludHNfb25fYml0bWFwKEJsb2NrRHJpdmVyU3RhdGUg
KmJzLA0KICAgICBCRFJWUWNvdzJTdGF0ZSAqcyA9IGJzLT5vcGFxdWU7DQogICAgIGludCBncmFu
dWxhcml0eV9iaXRzID0gY3R6MzIoZ3JhbnVsYXJpdHkpOw0KICAgICBpbnQ2NF90IGxlbiA9IGJk
cnZfZ2V0bGVuZ3RoKGJzKTsNCisgICAgaW50NjRfdCBiaXRtYXBfYnl0ZXM7DQogDQogICAgIGFz
c2VydChncmFudWxhcml0eSA+IDApOw0KICAgICBhc3NlcnQoKGdyYW51bGFyaXR5ICYgKGdyYW51
bGFyaXR5IC0gMSkpID09IDApOw0KQEAgLTE3MSw5ICsxNzksOSBAQCBzdGF0aWMgaW50IGNoZWNr
X2NvbnN0cmFpbnRzX29uX2JpdG1hcChCbG9ja0RyaXZlclN0YXRlICpicywNCiAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KICAgICB9DQogDQotICAgIGlmICgobGVuID4gKHVpbnQ2NF90KUJNRV9N
QVhfUEhZU19TSVpFIDw8IGdyYW51bGFyaXR5X2JpdHMpIHx8DQotICAgICAgICAobGVuID4gKHVp
bnQ2NF90KUJNRV9NQVhfVEFCTEVfU0laRSAqIHMtPmNsdXN0ZXJfc2l6ZSA8PA0KLSAgICAgICAg
ICAgICAgIGdyYW51bGFyaXR5X2JpdHMpKQ0KKyAgICBiaXRtYXBfYnl0ZXMgPSBnZXRfYml0bWFw
X2J5dGVzX25lZWRlZChsZW4sIGdyYW51bGFyaXR5KTsNCisgICAgaWYgKChiaXRtYXBfYnl0ZXMg
PiAodWludDY0X3QpQk1FX01BWF9QSFlTX1NJWkUpIHx8DQorICAgICAgICAoYml0bWFwX2J5dGVz
ID4gKHVpbnQ2NF90KUJNRV9NQVhfVEFCTEVfU0laRSAqIHMtPmNsdXN0ZXJfc2l6ZSkpDQogICAg
IHsNCiAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIlRvbyBtdWNoIHNwYWNlIHdpbGwgYmUgb2Nj
dXBpZWQgYnkgdGhlIGJpdG1hcC4gIg0KICAgICAgICAgICAgICAgICAgICAiVXNlIGxhcmdlciBn
cmFudWxhcml0eSIpOw0KLS0gDQoyLjcuNA0KDQpbUGF0Y2ggdjNdOiBodHRwczovL2xpc3RzLmdu
dS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOS0xMC9tc2cwNzk4OS5odG1sDQpbUGF0
Y2ggdjJdOiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAx
OS0xMC9tc2cwNzQ5MC5odG1sDQpbUGF0Y2ggdjFdOiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJj
aGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOS0xMC9tc2cwNzMzNi5odG1sDQo=

