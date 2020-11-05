Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BB5C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 05:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FC42083B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 05:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FC42083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaY1L-0003qL-S0
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 00:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tu.guoyi@h3c.com>)
 id 1kaY0f-0003L8-TK; Thu, 05 Nov 2020 00:40:33 -0500
Received: from smtp.h3c.com ([60.191.123.56]:56563 helo=h3cspam01-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tu.guoyi@h3c.com>)
 id 1kaY0Y-0001t2-W9; Thu, 05 Nov 2020 00:40:33 -0500
Received: from DAG2EX02-BASE.srv.huawei-3com.com ([10.8.0.65])
 by h3cspam01-ex.h3c.com with ESMTPS id 0A55e425049535
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Nov 2020 13:40:04 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX02-BASE.srv.huawei-3com.com (10.8.0.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 5 Nov 2020 13:40:06 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7])
 with mapi id 15.01.2106.002; Thu, 5 Nov 2020 13:40:06 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: [PATCH] block: Fix integer promotion error in bdrv_getlength()
Thread-Topic: [PATCH] block: Fix integer promotion error in bdrv_getlength()
Thread-Index: AdazNZvDJjXIINNtSs2+W7uMUYNirQ==
Date: Thu, 5 Nov 2020 05:40:06 +0000
Message-ID: <c0d398ea9d7141bcbb9b3746f97852b4@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.108.131]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 0A55e425049535
Received-SPF: pass client-ip=60.191.123.56; envelope-from=tu.guoyi@h3c.com;
 helo=h3cspam01-ex.h3c.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 00:40:18
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QXMgQkRSVl9TRUNUT1JfU0laRSBpcyBvZiB0eXBlIHVpbnQ2NF90LCB0aGUgZXhwcmVzc2lvbiB3
aWxsDQphdXRvbWF0aWNhbGx5IGNvbnZlcnQgdGhlIEByZXQgdG8gdWludDY0X3QuIFdoZW4gYW4g
ZXJyb3IgY29kZQ0KcmV0dXJuZWQgZnJvbSBiZHJ2X25iX3NlY3RvcnMoKSwgdGhlIHByb21vdGVk
IEByZXQgd2lsbCBiZSBhIHZlcnkNCmxhcmdlIG51bWJlciwgYXMgYSByZXN1bHQgdGhlIC1FRkJJ
RyB3aWxsIGJlIHJldHVybmVkIHdoaWNoIGlzIG5vdCB0aGUNCnJlYWwgZXJyb3IgY29kZS4NCg0K
U2lnbmVkLW9mZi1ieTogR3VveWkgVHUgPHR1Lmd1b3lpQGgzYy5jb20+DQotLS0NCiBibG9jay5j
IHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
DQpkaWZmIC0tZ2l0IGEvYmxvY2suYyBiL2Jsb2NrLmMNCmluZGV4IDQzMGVkZjcuLmYxNDI1NGMg
MTAwNjQ0DQotLS0gYS9ibG9jay5jDQorKysgYi9ibG9jay5jDQpAQCAtNTA4Miw3ICs1MDgyLDcg
QEAgaW50NjRfdCBiZHJ2X2dldGxlbmd0aChCbG9ja0RyaXZlclN0YXRlICpicykNCiB7DQogICAg
IGludDY0X3QgcmV0ID0gYmRydl9uYl9zZWN0b3JzKGJzKTsNCiANCi0gICAgcmV0ID0gcmV0ID4g
SU5UNjRfTUFYIC8gQkRSVl9TRUNUT1JfU0laRSA/IC1FRkJJRyA6IHJldDsNCisgICAgcmV0ID0g
cmV0ID4gSU5UNjRfTUFYIC8gKGludDY0X3QpQkRSVl9TRUNUT1JfU0laRSA/IC1FRkJJRyA6IHJl
dDsNCiAgICAgcmV0dXJuIHJldCA8IDAgPyByZXQgOiByZXQgKiBCRFJWX1NFQ1RPUl9TSVpFOw0K
IH0NCiANCi0tIA0KMi43LjQNCg0KUGxlYXNlIGlnbm9yZSB0aGUgW1BBVENIXSBibG9jazogUmV0
dXJuIHRoZSByZWFsIGVycm9yIGNvZGUgaW4gYmRydl9nZXRsZW5ndGgNCg0KLS0NCkJlc3QgcmVn
YXJkcywNCkd1b3lpDQo=

