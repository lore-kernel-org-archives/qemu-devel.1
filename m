Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FF0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 06:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C437B20862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 06:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C437B20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOybn-00066I-Tg
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 02:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tu.guoyi@h3c.com>) id 1iOyaw-0004dq-BP
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 02:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tu.guoyi@h3c.com>) id 1iOyau-0006Gj-D8
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 02:33:37 -0400
Received: from smtp.h3c.com ([60.191.123.50]:32062 helo=h3cspam02-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tu.guoyi@h3c.com>)
 id 1iOyat-00060B-3c; Mon, 28 Oct 2019 02:33:36 -0400
Received: from DAG2EX02-BASE.srv.huawei-3com.com ([10.8.0.65])
 by h3cspam02-ex.h3c.com with ESMTPS id x9S6X6cd028044
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Oct 2019 14:33:06 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX02-BASE.srv.huawei-3com.com (10.8.0.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Oct 2019 14:33:08 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%6])
 with mapi id 15.01.1713.004; Mon, 28 Oct 2019 14:33:08 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: [PATCH v2] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Topic: [PATCH v2] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Index: AdWNWOAJ7czUdZfnT3+PEnECPxQetw==
Date: Mon, 28 Oct 2019 06:33:08 +0000
Message-ID: <494aedb644bf434f8eee0263aa17aa23@h3c.com>
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
X-MAIL: h3cspam02-ex.h3c.com x9S6X6cd028044
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

SW4gY2hlY2tfY29uc3RyYWludHNfb25fYml0bWFwKCksIHRoZSBzYW5pdHkgY2hlY2sgb24gdGhl
DQpncmFudWxhcml0eSB3aWxsIGNhdXNlIHVpbnQ2NF90IGludGVnZXIgbGVmdC1zaGlmdCBvdmVy
Zmxvdw0Kd2hlbiBjbHVzdGVyX3NpemUgaXMgMk0gYW5kIHRoZSBncmFudWxhcml0eSBpcyBCSUdH
RVIgdGhhbg0KMzJLLiBBcyBhIHJlc3VsdCwgZm9yIGEgcWNvdzIgZGlzayB3aXRoIGNsdXN0ZXJf
c2l6ZSBzZXQgdG8NCjJNLCB3ZSBjb3VsZCBub3QgZXZlbiBjcmVhdGUgYSBkaXJ0eSBiaXRtYXAg
d2l0aCBkZWZhdWx0DQpncmFudWxhcml0eS4gVGhpcyBwYXRjaCBmaXggdGhlIGlzc3VlIGJ5IGRp
dmlkaW5nIEBsZW4gYnkNCmdyYW51bGFyaXR5IGluc3RlYWQuDQoNClNpZ25lZC1vZmYtYnk6IEd1
b3lpIFR1IDx0dS5ndW95aUBoM2MuY29tPg0KLS0tDQogYmxvY2svcWNvdzItYml0bWFwLmMgfCA0
ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzItYml0bWFwLmMgYi9ibG9jay9xY293Mi1iaXRtYXAu
Yw0KaW5kZXggOTgyOTRhNy4uNzFhYzgyMiAxMDA2NDQNCi0tLSBhL2Jsb2NrL3Fjb3cyLWJpdG1h
cC5jDQorKysgYi9ibG9jay9xY293Mi1iaXRtYXAuYw0KQEAgLTE3Miw4ICsxNzIsOCBAQCBzdGF0
aWMgaW50IGNoZWNrX2NvbnN0cmFpbnRzX29uX2JpdG1hcChCbG9ja0RyaXZlclN0YXRlICpicywN
CiAgICAgfQ0KIA0KICAgICBpZiAoKGxlbiA+ICh1aW50NjRfdClCTUVfTUFYX1BIWVNfU0laRSA8
PCBncmFudWxhcml0eV9iaXRzKSB8fA0KLSAgICAgICAgKGxlbiA+ICh1aW50NjRfdClCTUVfTUFY
X1RBQkxFX1NJWkUgKiBzLT5jbHVzdGVyX3NpemUgPDwNCi0gICAgICAgICAgICAgICBncmFudWxh
cml0eV9iaXRzKSkNCisgICAgICAgIChESVZfUk9VTkRfVVAobGVuLCBncmFudWxhcml0eSkgPiAo
dWludDY0X3QpQk1FX01BWF9UQUJMRV9TSVpFICoNCisgICAgICAgICAgICAgICAgcy0+Y2x1c3Rl
cl9zaXplKSkNCiAgICAgew0KICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiVG9vIG11Y2ggc3Bh
Y2Ugd2lsbCBiZSBvY2N1cGllZCBieSB0aGUgYml0bWFwLiAiDQogICAgICAgICAgICAgICAgICAg
ICJVc2UgbGFyZ2VyIGdyYW51bGFyaXR5Iik7DQotLSANCjIuNy40DQo=

