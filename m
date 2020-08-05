Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1C1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A3B22B40
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A3B22B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Fem-0007BI-3D
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 05:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tu.guoyi@h3c.com>)
 id 1k3Fe5-0006gj-7n; Wed, 05 Aug 2020 05:23:37 -0400
Received: from smtp.h3c.com ([60.191.123.50]:43822 helo=h3cspam02-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tu.guoyi@h3c.com>)
 id 1k3Fe1-0004Y9-JK; Wed, 05 Aug 2020 05:23:36 -0400
Received: from DAG2EX09-IDC.srv.huawei-3com.com ([10.8.0.72])
 by h3cspam02-ex.h3c.com with ESMTPS id 0759Mt4a003231
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Aug 2020 17:22:55 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX09-IDC.srv.huawei-3com.com (10.8.0.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 17:22:58 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7])
 with mapi id 15.01.1713.004; Wed, 5 Aug 2020 17:22:58 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: [PATCH] qcow2-cluster: Fix integer left shift error in
 qcow2_alloc_cluster_link_l2()
Thread-Topic: [PATCH] qcow2-cluster: Fix integer left shift error in
 qcow2_alloc_cluster_link_l2()
Thread-Index: AdZrCV/0aSDyco1VQNa8/fefsiaORg==
Date: Wed, 5 Aug 2020 09:22:58 +0000
Message-ID: <81ba90fe0c014f269621c283269b42ad@h3c.com>
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
X-MAIL: h3cspam02-ex.h3c.com 0759Mt4a003231
Received-SPF: pass client-ip=60.191.123.50; envelope-from=tu.guoyi@h3c.com;
 helo=h3cspam02-ex.h3c.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 05:23:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gaoliang <liang_gao@h3c.com>, Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V2hlbiBjYWxjdWxhdGluZyB0aGUgb2Zmc2V0LCB0aGUgcmVzdWx0IG9mIGxlZnQgc2hpZnQgb3Bl
cmF0aW9uIHdpbGwgYmUgcHJvbW90ZWQNCnRvIHR5cGUgaW50NjQgYXV0b21hdGljYWxseSBiZWNh
dXNlIHRoZSBsZWZ0IG9wZXJhbmQgb2YgKyBvcGVyYXRvciBpcyB1aW50NjRfdC4NCmJ1dCB0aGUg
cmVzdWx0IGFmdGVyIGludGVnZXIgcHJvbW90aW9uIG1heSBiZSBwcm9kdWNlIGFuIGVycm9yIHZh
bHVlIGZvciB1cyBhbmQNCnRyaWdnZXIgdGhlIGZvbGxvd2luZyBhc3NlcnRpbmcgZXJyb3IuDQoN
CkZvciBleGFtcGxlLCBjb25zaWRlciBpPTB4MjAwMCwgY2x1c3Rlcl9iaXRzPTE4LCB0aGUgcmVz
dWx0IG9mIGxlZnQgc2hpZnQNCm9wZXJhdGlvbiB3aWxsIGJlIDB4ODAwMDAwMDAuIENhdXNlIGFy
Z3VtZW50IGkgaXMgb2Ygc2lnbmVkIGludGVnZXIgdHlwZSwNCnRoZSByZXN1bHQgaXMgYXV0b21h
dGljYWxseSBwcm9tb3RlZCB0byAweGZmZmZmZmZmODAwMDAwMDAgd2hpY2ggaXMgbm90DQp3ZSBl
eHBlY3RlZA0KDQpUaGUgd2F5IHRvIHRyaWdnZXIgdGhlIGFzc2VydGlvbiBlcnJvcjoNCiAgcWVt
dS1pbWcgY3JlYXRlIC1mIHFjb3cyIC1vIHByZWFsbG9jYXRpb249ZnVsbCxjbHVzdGVyX3NpemU9
MjU2ayB0bXBkaXNrIDEwRw0KDQpUaGlzIHBhdGNoIGZpeCBpdCBieSBjYXN0aW5nIEBpIHRvIHVp
bnQ2NF90IGJlZm9yZSBkb2luZyBsZWZ0IHNoaWZ0IG9wZXJhdGlvbg0KDQpTaWduZWQtb2ZmLWJ5
OiBHdW95aSBUdSA8dHUuZ3VveWlAaDNjLmNvbT4NCi0tLQ0KIGJsb2NrL3Fjb3cyLWNsdXN0ZXIu
YyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cg0KZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYyBiL2Jsb2NrL3Fjb3cyLWNsdXN0
ZXIuYw0KaW5kZXggYTY3N2JhOS4uNTUwODUwYiAxMDA2NDQNCi0tLSBhL2Jsb2NrL3Fjb3cyLWNs
dXN0ZXIuYw0KKysrIGIvYmxvY2svcWNvdzItY2x1c3Rlci5jDQpAQCAtOTgwLDcgKzk4MCw3IEBA
IGludCBxY293Ml9hbGxvY19jbHVzdGVyX2xpbmtfbDIoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIFFD
b3dMMk1ldGEgKm0pDQogDQogICAgIGFzc2VydChsMl9pbmRleCArIG0tPm5iX2NsdXN0ZXJzIDw9
IHMtPmwyX3NsaWNlX3NpemUpOw0KICAgICBmb3IgKGkgPSAwOyBpIDwgbS0+bmJfY2x1c3RlcnM7
IGkrKykgew0KLSAgICAgICAgdWludDY0X3Qgb2Zmc2V0ID0gY2x1c3Rlcl9vZmZzZXQgKyAoaSA8
PCBzLT5jbHVzdGVyX2JpdHMpOw0KKyAgICAgICAgdWludDY0X3Qgb2Zmc2V0ID0gY2x1c3Rlcl9v
ZmZzZXQgKyAoKHVpbnQ2NF90KWkgPDwgcy0+Y2x1c3Rlcl9iaXRzKTsNCiAgICAgICAgIC8qIGlm
IHR3byBjb25jdXJyZW50IHdyaXRlcyBoYXBwZW4gdG8gdGhlIHNhbWUgdW5hbGxvY2F0ZWQgY2x1
c3Rlcg0KICAgICAgICAgICogZWFjaCB3cml0ZSBhbGxvY2F0ZXMgc2VwYXJhdGUgY2x1c3RlciBh
bmQgd3JpdGVzIGRhdGEgY29uY3VycmVudGx5Lg0KICAgICAgICAgICogVGhlIGZpcnN0IG9uZSB0
byBjb21wbGV0ZSB1cGRhdGVzIGwyIHRhYmxlIHdpdGggcG9pbnRlciB0byBpdHMNCi0tIA0KMi43
LjQNCg0KLS0NCkJlc3QgcmVnYXJkcywNCkd1b3lpDQoNCg==

