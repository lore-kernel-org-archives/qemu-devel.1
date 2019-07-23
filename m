Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D0CC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623DD223BA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623DD223BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprBT-0007Um-Kf
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 05:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47886)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hprBH-00072D-Ps
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hprBG-0008CN-8x
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:33:59 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2482 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <oscar.zhangbo@huawei.com>)
 id 1hprBF-0008BE-SX
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:33:58 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 2700CFF488D0A16F80FB;
 Tue, 23 Jul 2019 17:33:54 +0800 (CST)
Received: from DGGEML423-HUB.china.huawei.com (10.1.199.40) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 23 Jul 2019 17:33:53 +0800
Received: from DGGEML509-MBX.china.huawei.com ([169.254.1.213]) by
 dggeml423-hub.china.huawei.com ([10.1.199.40]) with mapi id 14.03.0439.000;
 Tue, 23 Jul 2019 17:33:44 +0800
From: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2] pcie: fix device unplug timeout
Thread-Index: AdVBOa+k2REPW1pPTHWvtO0bYVI0tA==
Date: Tue, 23 Jul 2019 09:33:43 +0000
Message-ID: <0259E1C966E8C54AA93AA2B1240828E672DF3D45@dggeml509-mbx.china.huawei.com>
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
X-Received-From: 45.249.212.188
Subject: [Qemu-devel] [PATCH v2] pcie: fix device unplug timeout
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
 "philmd@redhat.com" <philmd@redhat.com>,
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
ZW91dC4NCg0KU2lnbmVkLW9mZi1ieTogTGkgTWluZ3dhbmcgPGxpbWluZ3dhbmdAaHVhd2VpLmNv
bT4NClNpZ25lZC1vZmYtYnk6IEZhbmcgWWluZyA8ZmFuZ3lpbmcxQGh1YXdlaS5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBaaGFuZyBCbyA8b3NjYXIuemhhbmdib0BodWF3ZWkuY29tPg0KLS0tDQogaHcv
cGNpL3BjaWUuYyAgICAgICAgIHwgOCArKy0tLS0tLQ0KIGluY2x1ZGUvaHcvcGNpL3BjaWUuaCB8
IDEgLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaWUuYyBiL2h3L3BjaS9wY2llLmMNCmluZGV4IDE3NGYz
OTIuLmE4MDBmMjMgMTAwNjQ0DQotLS0gYS9ody9wY2kvcGNpZS5jDQorKysgYi9ody9wY2kvcGNp
ZS5jDQpAQCAtNDg1LDcgKzQ4NSw4IEBAIHZvaWQgcGNpZV9jYXBfc2xvdF91bnBsdWdfcmVxdWVz
dF9jYihIb3RwbHVnSGFuZGxlciAqaG90cGx1Z19kZXYsDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFBDSV9FWFBfTE5LU1RBX0RMTExBKTsNCiAgICAgfQ0KIA0KLSAgICBw
Y2llX2NhcF9zbG90X3B1c2hfYXR0ZW50aW9uX2J1dHRvbihQQ0lfREVWSUNFKGhvdHBsdWdfZGV2
KSk7DQorICAgIHBjaWVfY2FwX3Nsb3RfZXZlbnQoUENJX0RFVklDRShob3RwbHVnX2RldiksDQor
ICAgICAgICAgICAgICAgICAgICAgICAgUENJX0VYUF9IUF9FVl9QREMgfCBQQ0lfRVhQX0hQX0VW
X0FCUCk7DQogfQ0KIA0KIC8qIHBjaSBleHByZXNzIHNsb3QgZm9yIHBjaSBleHByZXNzIHJvb3Qv
ZG93bnN0cmVhbSBwb3J0DQpAQCAtNzAxLDExICs3MDIsNiBAQCBpbnQgcGNpZV9jYXBfc2xvdF9w
b3N0X2xvYWQodm9pZCAqb3BhcXVlLCBpbnQgdmVyc2lvbl9pZCkNCiAgICAgcmV0dXJuIDA7DQog
fQ0KIA0KLXZvaWQgcGNpZV9jYXBfc2xvdF9wdXNoX2F0dGVudGlvbl9idXR0b24oUENJRGV2aWNl
ICpkZXYpDQotew0KLSAgICBwY2llX2NhcF9zbG90X2V2ZW50KGRldiwgUENJX0VYUF9IUF9FVl9B
QlApOw0KLX0NCi0NCiAvKiByb290IGNvbnRyb2wvY2FwYWJpbGl0aWVzL3N0YXR1cy4gUE1FIGlz
bid0IGVtdWxhdGVkIGZvciBub3cgKi8NCiB2b2lkIHBjaWVfY2FwX3Jvb3RfaW5pdChQQ0lEZXZp
Y2UgKmRldikNCiB7DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9wY2kvcGNpZS5oIGIvaW5jbHVk
ZS9ody9wY2kvcGNpZS5oDQppbmRleCA4Y2YzMzYxLi4wOTc1YTU0IDEwMDY0NA0KLS0tIGEvaW5j
bHVkZS9ody9wY2kvcGNpZS5oDQorKysgYi9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCkBAIC0xMTIs
NyArMTEyLDYgQEAgdm9pZCBwY2llX2NhcF9zbG90X3dyaXRlX2NvbmZpZyhQQ0lEZXZpY2UgKmRl
diwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQxNl90IG9sZF9zbHRfY3Rs
LCB1aW50MTZfdCBvbGRfc2x0X3N0YSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHVpbnQzMl90IGFkZHIsIHVpbnQzMl90IHZhbCwgaW50IGxlbik7DQogaW50IHBjaWVfY2FwX3Ns
b3RfcG9zdF9sb2FkKHZvaWQgKm9wYXF1ZSwgaW50IHZlcnNpb25faWQpOw0KLXZvaWQgcGNpZV9j
YXBfc2xvdF9wdXNoX2F0dGVudGlvbl9idXR0b24oUENJRGV2aWNlICpkZXYpOw0KIA0KIHZvaWQg
cGNpZV9jYXBfcm9vdF9pbml0KFBDSURldmljZSAqZGV2KTsNCiB2b2lkIHBjaWVfY2FwX3Jvb3Rf
cmVzZXQoUENJRGV2aWNlICpkZXYpOw0KLS0gDQoxLjguMy4xDQo=

