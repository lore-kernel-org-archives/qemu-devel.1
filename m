Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454E4CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 11:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B73720874
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 11:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B73720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPmRr-0000vm-8a
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 07:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tu.guoyi@h3c.com>) id 1iPmQn-0000Nj-6y
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 07:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tu.guoyi@h3c.com>) id 1iPmQl-00086J-59
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 07:46:28 -0400
Received: from smtp.h3c.com ([60.191.123.50]:12476 helo=h3cspam02-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tu.guoyi@h3c.com>)
 id 1iPmQk-0007tx-JU; Wed, 30 Oct 2019 07:46:27 -0400
Received: from DAG2EX05-BASE.srv.huawei-3com.com ([10.8.0.68])
 by h3cspam02-ex.h3c.com with ESMTPS id x9UBk5fP055025
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Oct 2019 19:46:05 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX05-BASE.srv.huawei-3com.com (10.8.0.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 30 Oct 2019 19:46:09 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%6])
 with mapi id 15.01.1713.004; Wed, 30 Oct 2019 19:46:09 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: [PATCH v3] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Topic: [PATCH v3] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Index: AdWPFo/e/4bra9yKTuSMM3n9Yap7Hg==
Date: Wed, 30 Oct 2019 11:46:08 +0000
Message-ID: <f26933e80e434b5f875e7db24ef9d02f@h3c.com>
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
X-MAIL: h3cspam02-ex.h3c.com x9UBk5fP055025
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
bSBiaXRtYXAgYnl0ZXMgc3VwcG9ydGVkIGJ5IHFlbXUuDQoNClNpZ25lZC1vZmYtYnk6IEd1b3lp
IFR1IDx0dS5ndW95aUBoM2MuY29tPg0KLS0tDQogYmxvY2svcWNvdzItYml0bWFwLmMgfCAxNSAr
KysrKysrKysrKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jIGIvYmxvY2svcWNv
dzItYml0bWFwLmMNCmluZGV4IDk4Mjk0YTcuLjM0OTM1YmIgMTAwNjQ0DQotLS0gYS9ibG9jay9x
Y293Mi1iaXRtYXAuYw0KKysrIGIvYmxvY2svcWNvdzItYml0bWFwLmMNCkBAIC0xNDIsNiArMTQy
LDE0IEBAIHN0YXRpYyBpbnQgY2hlY2tfdGFibGVfZW50cnkodWludDY0X3QgZW50cnksIGludCBj
bHVzdGVyX3NpemUpDQogICAgIHJldHVybiAwOw0KIH0NCiANCitzdGF0aWMgaW5saW5lIGludDY0
X3QgZ2V0X2JpdG1hcF9ieXRlc19uZWVkZWQoaW50NjRfdCBsZW4sDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGdyYW51bGFyaXR5KQ0KK3sN
CisgICAgaW50NjRfdCBudW1fYml0cyA9IERJVl9ST1VORF9VUChsZW4sIGdyYW51bGFyaXR5KTsN
CisNCisgICAgcmV0dXJuIERJVl9ST1VORF9VUChudW1fYml0cywgOCk7DQorfQ0KKw0KIHN0YXRp
YyBpbnQgY2hlY2tfY29uc3RyYWludHNfb25fYml0bWFwKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUs
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgZ3JhbnVs
YXJpdHksDQpAQCAtMTUwLDYgKzE1OCw3IEBAIHN0YXRpYyBpbnQgY2hlY2tfY29uc3RyYWludHNf
b25fYml0bWFwKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KICAgICBCRFJWUWNvdzJTdGF0ZSAqcyA9
IGJzLT5vcGFxdWU7DQogICAgIGludCBncmFudWxhcml0eV9iaXRzID0gY3R6MzIoZ3JhbnVsYXJp
dHkpOw0KICAgICBpbnQ2NF90IGxlbiA9IGJkcnZfZ2V0bGVuZ3RoKGJzKTsNCisgICAgaW50NjRf
dCBiaXRtYXBfYnl0ZXM7DQogDQogICAgIGFzc2VydChncmFudWxhcml0eSA+IDApOw0KICAgICBh
c3NlcnQoKGdyYW51bGFyaXR5ICYgKGdyYW51bGFyaXR5IC0gMSkpID09IDApOw0KQEAgLTE3MSw5
ICsxODAsOSBAQCBzdGF0aWMgaW50IGNoZWNrX2NvbnN0cmFpbnRzX29uX2JpdG1hcChCbG9ja0Ry
aXZlclN0YXRlICpicywNCiAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KICAgICB9DQogDQotICAg
IGlmICgobGVuID4gKHVpbnQ2NF90KUJNRV9NQVhfUEhZU19TSVpFIDw8IGdyYW51bGFyaXR5X2Jp
dHMpIHx8DQotICAgICAgICAobGVuID4gKHVpbnQ2NF90KUJNRV9NQVhfVEFCTEVfU0laRSAqIHMt
PmNsdXN0ZXJfc2l6ZSA8PA0KLSAgICAgICAgICAgICAgIGdyYW51bGFyaXR5X2JpdHMpKQ0KKyAg
ICBiaXRtYXBfYnl0ZXMgPSBnZXRfYml0bWFwX2J5dGVzX25lZWRlZChsZW4sIGdyYW51bGFyaXR5
KTsNCisgICAgaWYgKChiaXRtYXBfYnl0ZXMgPiAodWludDY0X3QpQk1FX01BWF9QSFlTX1NJWkUp
IHx8DQorICAgICAgICAoYml0bWFwX2J5dGVzID4gKHVpbnQ2NF90KUJNRV9NQVhfVEFCTEVfU0la
RSAqIHMtPmNsdXN0ZXJfc2l6ZSkpDQogICAgIHsNCiAgICAgICAgIGVycm9yX3NldGcoZXJycCwg
IlRvbyBtdWNoIHNwYWNlIHdpbGwgYmUgb2NjdXBpZWQgYnkgdGhlIGJpdG1hcC4gIg0KICAgICAg
ICAgICAgICAgICAgICAiVXNlIGxhcmdlciBncmFudWxhcml0eSIpOw0KLS0gDQoyLjcuNA0KDQpb
UGF0Y2ggdjJdOiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwv
MjAxOS0xMC9tc2cwNzQ5MC5odG1sDQo=

