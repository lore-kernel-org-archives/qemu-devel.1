Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B50EC7618E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 07:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F7721BF6
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 07:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F7721BF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hppXH-00046I-1J
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 03:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46723)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hppWx-0003Dj-Bb
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 03:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hppWw-0004wL-5a
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 03:48:15 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2049 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <oscar.zhangbo@huawei.com>)
 id 1hppWv-0004u1-Pe
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 03:48:14 -0400
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 37A392BD08075E719FBD;
 Tue, 23 Jul 2019 15:48:10 +0800 (CST)
Received: from DGGEML423-HUB.china.huawei.com (10.1.199.40) by
 DGGEML402-HUB.china.huawei.com (10.3.17.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 23 Jul 2019 15:48:09 +0800
Received: from DGGEML509-MBX.china.huawei.com ([169.254.1.213]) by
 dggeml423-hub.china.huawei.com ([10.1.199.40]) with mapi id 14.03.0439.000;
 Tue, 23 Jul 2019 15:48:00 +0800
From: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] pcie: fix device unplug timeout
Thread-Index: AdVBKcKkGyAqa5gqR9GDySD3jrl0FA==
Date: Tue, 23 Jul 2019 07:48:00 +0000
Message-ID: <0259E1C966E8C54AA93AA2B1240828E672DF1C9F@dggeml509-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.17.158]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.189
Subject: [Qemu-devel] [PATCH] pcie: fix device unplug timeout
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
Cc: fangying <fangying1@huawei.com>, "dengkai \(A\)" <dengkai1@huawei.com>,
 "limingwang \(A\)" <limingwang@huawei.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SWYgdGhlIGxpbnV4IGtlcm5lbCBvbmx5IHJlY2VpdmVzIGFuIEFCUCBldmVudCBkdXJpbmcgcGNp
ZSB1bnBsdWcsIGl0IHdpbGwgc2xlZXAgNXMgDQp0byBleHBlY3QgYSBQREMgZXZlbnQsIHdoaWNo
IHdpbGwgY2F1c2UgZGV2aWNlIHVucGx1ZyB0aW1lb3V0Lg0KDQpJbiB0aGUgbWVhbndoaWxlLCBp
ZiB0aGUga2VybmVsIG9ubHkgcmVjZWl2ZXMgYSBQREMgZXZlbnQgZHVyaW5nIHRoZSB1bnBsdWcs
IGl0DQp3aWxsIHdhaXQgZm9yIGF0IGxlYXN0IDEgc2Vjb25kIGJlZm9yZSBjaGVja2luZyBjYXJk
IHByZXNlbnQgYXMgZGF0YSBsaW5rIGxheWVyDQpzdGF0ZSBjaGFuZ2VkIChsaW5rIGRvd24pIGV2
ZW50IHJlcG9ydGVkIHByaW9yIHRvIHByZXNlbmNlIGRldGVjdCBjaGFuZ2VkDQooY2FyZCBpcyBu
b3QgcHJlc2VudCkuDQoNClRoZXJlZm9yZSB3ZSBjYW4gc2VuZCBib3RoIEFCUCBhbmQgUERDIGV2
ZW50cyB0byB0aGUga2VybmVsIGluIHVucGx1ZyBwcm9jZXNzDQp0byBhdm9pZCB1bnBsdWcgdGlt
ZW91dC4NCg0KU2lnbmVkLW9mZi1ieTogbGltaW5nd2FuZ0BodWF3ZWkuY29tDQpTaWduZWQtb2Zm
LWJ5OiBmYW5neWluZzFAaHVhd2VpLmNvbQ0KU2lnbmVkLW9mZi1ieTogb3NjYXIuemhhbmdib0Bo
dWF3ZWkuY29tDQotLS0NCiBody9wY2kvcGNpZS5jICAgICAgICAgfCA4ICsrLS0tLS0tDQogaW5j
bHVkZS9ody9wY2kvcGNpZS5oIHwgMSAtDQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9wY2kvcGNpZS5jIGIvaHcvcGNp
L3BjaWUuYw0KaW5kZXggMTc0ZjM5Mi4uYTgwMGYyMyAxMDA2NDQNCi0tLSBhL2h3L3BjaS9wY2ll
LmMNCisrKyBiL2h3L3BjaS9wY2llLmMNCkBAIC00ODUsNyArNDg1LDggQEAgdm9pZCBwY2llX2Nh
cF9zbG90X3VucGx1Z19yZXF1ZXN0X2NiKEhvdHBsdWdIYW5kbGVyICpob3RwbHVnX2RldiwNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUENJX0VYUF9MTktTVEFfRExMTEEp
Ow0KICAgICB9DQogDQotICAgIHBjaWVfY2FwX3Nsb3RfcHVzaF9hdHRlbnRpb25fYnV0dG9uKFBD
SV9ERVZJQ0UoaG90cGx1Z19kZXYpKTsNCisgICAgcGNpZV9jYXBfc2xvdF9ldmVudChQQ0lfREVW
SUNFKGhvdHBsdWdfZGV2KSwNCisgICAgICAgICAgICAgICAgICAgICAgICBQQ0lfRVhQX0hQX0VW
X1BEQyB8IFBDSV9FWFBfSFBfRVZfQUJQKTsNCiB9DQogDQogLyogcGNpIGV4cHJlc3Mgc2xvdCBm
b3IgcGNpIGV4cHJlc3Mgcm9vdC9kb3duc3RyZWFtIHBvcnQNCkBAIC03MDEsMTEgKzcwMiw2IEBA
IGludCBwY2llX2NhcF9zbG90X3Bvc3RfbG9hZCh2b2lkICpvcGFxdWUsIGludCB2ZXJzaW9uX2lk
KQ0KICAgICByZXR1cm4gMDsNCiB9DQogDQotdm9pZCBwY2llX2NhcF9zbG90X3B1c2hfYXR0ZW50
aW9uX2J1dHRvbihQQ0lEZXZpY2UgKmRldikNCi17DQotICAgIHBjaWVfY2FwX3Nsb3RfZXZlbnQo
ZGV2LCBQQ0lfRVhQX0hQX0VWX0FCUCk7DQotfQ0KLQ0KIC8qIHJvb3QgY29udHJvbC9jYXBhYmls
aXRpZXMvc3RhdHVzLiBQTUUgaXNuJ3QgZW11bGF0ZWQgZm9yIG5vdyAqLw0KIHZvaWQgcGNpZV9j
YXBfcm9vdF9pbml0KFBDSURldmljZSAqZGV2KQ0KIHsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3
L3BjaS9wY2llLmggYi9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCmluZGV4IDhjZjMzNjEuLjA5NzVh
NTQgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCisrKyBiL2luY2x1ZGUvaHcv
cGNpL3BjaWUuaA0KQEAgLTExMiw3ICsxMTIsNiBAQCB2b2lkIHBjaWVfY2FwX3Nsb3Rfd3JpdGVf
Y29uZmlnKFBDSURldmljZSAqZGV2LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWludDE2X3Qgb2xkX3NsdF9jdGwsIHVpbnQxNl90IG9sZF9zbHRfc3RhLA0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgYWRkciwgdWludDMyX3QgdmFsLCBpbnQgbGVu
KTsNCiBpbnQgcGNpZV9jYXBfc2xvdF9wb3N0X2xvYWQodm9pZCAqb3BhcXVlLCBpbnQgdmVyc2lv
bl9pZCk7DQotdm9pZCBwY2llX2NhcF9zbG90X3B1c2hfYXR0ZW50aW9uX2J1dHRvbihQQ0lEZXZp
Y2UgKmRldik7DQogDQogdm9pZCBwY2llX2NhcF9yb290X2luaXQoUENJRGV2aWNlICpkZXYpOw0K
IHZvaWQgcGNpZV9jYXBfcm9vdF9yZXNldChQQ0lEZXZpY2UgKmRldik7DQotLSANCjEuOC4zLjEN
Cg==

