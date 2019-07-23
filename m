Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355B3C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4E3223BA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4E3223BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpr9H-0005bj-9M
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 05:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47169)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hpr96-0005DP-I5
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hpr95-0006zv-J8
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:31:44 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2050 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <oscar.zhangbo@huawei.com>)
 id 1hpr95-0006xq-8k
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:31:43 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 0E2E4C2AC3043D82F029;
 Tue, 23 Jul 2019 17:31:38 +0800 (CST)
Received: from DGGEML422-HUB.china.huawei.com (10.1.199.39) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 23 Jul 2019 17:31:37 +0800
Received: from DGGEML509-MBX.china.huawei.com ([169.254.1.213]) by
 dggeml422-hub.china.huawei.com ([10.1.199.39]) with mapi id 14.03.0439.000;
 Tue, 23 Jul 2019 17:31:31 +0800
From: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2] pcie: fix device hotplug failure at the meantime of
 VM boot
Thread-Index: AdVBOS0yfVqcQ/jfSjiRBqDIjyMExA==
Date: Tue, 23 Jul 2019 09:31:30 +0000
Message-ID: <0259E1C966E8C54AA93AA2B1240828E672DF3D38@dggeml509-mbx.china.huawei.com>
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
Subject: [Qemu-devel] [PATCH v2] pcie: fix device hotplug failure at the
 meantime of VM boot
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

SWYgdGhlIFBDSV9FWFBfTE5LU1RBX0RMTExBIGNhcGFiaWxpdHkgaXMgc2V0IGJ5IGRlZmF1bHQs
IGxpbnV4IGtlcm5lbCB3aWxsIHNlbmQgDQpQREMgZXZlbnQgdG8gZGV0ZWN0IHdoZXRoZXIgdGhl
cmUgaXMgYSBkZXZpY2UgaW4gcGNpZSBzbG90LiBJZiBhIGRldmljZSBpcyBwbHVnZWQNCmluIHRo
ZSBwY2llLXJvb3QtcG9ydCBhdCB0aGUgc2FtZSB0aW1lLCBob3QtcGx1ZyBkZXZpY2Ugd2lsbCBz
ZW5kIEFCUCArIFBEQw0KZXZlbnRzIHRvIHRoZSBrZXJuZWwuIFRoZSBWTSBrZXJuZWwgd2lsbCB3
cm9uZ2x5IHVucGx1ZyB0aGUgZGV2aWNlIGlmIHR3byBQREMNCmV2ZW50cyBnZXQgdG9vIGNsb3Nl
LiBUaHVzIHdlJ2QgYmV0dGVyIHNldCB0aGUgUENJX0VYUF9MTktTVEFfRExMTEENCmNhcGFiaWxp
dHkgb25seSBpbiBob3RwbHVnIGNhbGxiYWNrLg0KDQpCeSB0aGUgd2F5LCB3ZSBzaG91bGQgY2xl
YW4gdXAgdGhlIFBDSV9FWFBfTE5LU1RBX0RMTExBIGNhcGFiaWxpdHkgZHVyaW5nDQp1bnBsdWcg
dG8gYXZvaWQgVk0gcmVzdGFydCBvciBtaWdyYXRpb24gZmFpbHVyZSB3aGljaCB3aWxsIGVudGVy
IHRoZSBzYW1lDQphYm5vcm1hbCBzY2VuYXJpbyBhcyBhYm92ZS4NCg0KU2lnbmVkLW9mZi1ieTog
TGkgTWluZ3dhbmcgPGxpbWluZ3dhbmdAaHVhd2VpLmNvbT4NClNpZ25lZC1vZmYtYnk6IEZhbmcg
WWluZyA8ZmFuZ3lpbmcxQGh1YXdlaS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBaaGFuZyBCbyA8b3Nj
YXIuemhhbmdib0BodWF3ZWkuY29tPg0KLS0tDQogaHcvcGNpL3BjaWUuYyB8IDkgKysrKystLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2h3L3BjaS9wY2llLmMgYi9ody9wY2kvcGNpZS5jDQppbmRleCBhNmJlYjU2Li4x
NzRmMzkyIDEwMDY0NA0KLS0tIGEvaHcvcGNpL3BjaWUuYw0KKysrIGIvaHcvcGNpL3BjaWUuYw0K
QEAgLTc1LDEwICs3NSw2IEBAIHBjaWVfY2FwX3YxX2ZpbGwoUENJRGV2aWNlICpkZXYsIHVpbnQ4
X3QgcG9ydCwgdWludDhfdCB0eXBlLCB1aW50OF90IHZlcnNpb24pDQogICAgICAgICAgICAgICAg
ICBRRU1VX1BDSV9FWFBfTE5LU1RBX05MVyhRRU1VX1BDSV9FWFBfTE5LX1gxKSB8DQogICAgICAg
ICAgICAgICAgICBRRU1VX1BDSV9FWFBfTE5LU1RBX0NMUyhRRU1VX1BDSV9FWFBfTE5LXzJfNUdU
KSk7DQogDQotICAgIGlmIChkZXYtPmNhcF9wcmVzZW50ICYgUUVNVV9QQ0lFX0xOS1NUQV9ETExM
QSkgew0KLSAgICAgICAgcGNpX3dvcmRfdGVzdF9hbmRfc2V0X21hc2soZXhwX2NhcCArIFBDSV9F
WFBfTE5LU1RBLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUENJX0VYUF9M
TktTVEFfRExMTEEpOw0KLSAgICB9DQogDQogICAgIC8qIFdlIGNoYW5nZWQgbGluayBzdGF0dXMg
Yml0cyBvdmVyIHRpbWUsIGFuZCBjaGFuZ2luZyB0aGVtIGFjcm9zcw0KICAgICAgKiBtaWdyYXRp
b25zIGlzIGdlbmVyYWxseSBmaW5lIGFzIGhhcmR3YXJlIGNoYW5nZXMgdGhlbSB0b28uDQpAQCAt
NDg0LDYgKzQ4MCwxMSBAQCB2b2lkIHBjaWVfY2FwX3Nsb3RfdW5wbHVnX3JlcXVlc3RfY2IoSG90
cGx1Z0hhbmRsZXIgKmhvdHBsdWdfZGV2LA0KICAgICAgICAgcmV0dXJuOw0KICAgICB9DQogDQor
ICAgIGlmIChwY2lfZGV2LT5jYXBfcHJlc2VudCAmIFFFTVVfUENJRV9MTktTVEFfRExMTEEpIHsN
CisgICAgICAgIHBjaV93b3JkX3Rlc3RfYW5kX2NsZWFyX21hc2soZXhwX2NhcCArIFBDSV9FWFBf
TE5LU1RBLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQ0lfRVhQX0xO
S1NUQV9ETExMQSk7DQorICAgIH0NCisNCiAgICAgcGNpZV9jYXBfc2xvdF9wdXNoX2F0dGVudGlv
bl9idXR0b24oUENJX0RFVklDRShob3RwbHVnX2RldikpOw0KIH0NCiANCi0tIA0KMS44LjMuMQ0K

