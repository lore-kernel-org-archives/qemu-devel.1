Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D248C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 02:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E4A20873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 02:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E4A20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoIkK-0003Eo-H6
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 22:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hoIk9-0002lF-Ip
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 22:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hoIk8-00073D-EM
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 22:35:33 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2048 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <oscar.zhangbo@huawei.com>)
 id 1hoIk6-0006vY-6D; Thu, 18 Jul 2019 22:35:30 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 50EB4CAF12F6956C0995;
 Fri, 19 Jul 2019 10:35:22 +0800 (CST)
Received: from DGGEML423-HUB.china.huawei.com (10.1.199.40) by
 DGGEML404-HUB.china.huawei.com (10.3.17.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 19 Jul 2019 10:35:21 +0800
Received: from DGGEML529-MBS.china.huawei.com ([169.254.5.192]) by
 dggeml423-hub.china.huawei.com ([10.1.199.40]) with mapi id 14.03.0439.000;
 Fri, 19 Jul 2019 10:35:15 +0800
From: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "mst@redhat.com" <mst@redhat.com>
Thread-Topic: Discussion: redundant process during hotplug and missed
 process during unplug
Thread-Index: AdU92onP9moK68IvQMmxmVoIyEEGrQ==
Date: Fri, 19 Jul 2019 02:35:14 +0000
Message-ID: <0259E1C966E8C54AA93AA2B1240828E672DE0920@DGGEML529-MBS.china.huawei.com>
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
Subject: [Qemu-devel] Discussion: redundant process during hotplug and
 missed process during unplug
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
Cc: fangying <fangying1@huawei.com>, Jiangyifei <jiangyifei@huawei.com>,
 "limingwang \(A\)" <limingwang@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgQWxsOg0KSSBoYXZlIDIgcXVlc3Rpb25zIGFib3V0ICh1bilob3RwbHVnIG9uIHBjaWUtcm9v
dC1wb3J0Lg0KRmlyc3QgUXVlc3Rpb24gKGhvdHBsdWcgZmFpbHVyZSBiZWNhdXNlIG9mIHJlZHVu
ZGFudCBQQ0lfRVhQX0xOS1NUQV9ETExMQSBiaXQgc2V0KToNCiAgICBkdXJpbmcgVk0gYm9vdCwg
cWVtdSBzZXRzIFBDSV9FWFBfTE5LU1RBX0RMTExBIGFjY29yZGluZyB0byB0aGlzIHByb2Nlc3M6
DQogICAgICAgIHBjaWVfY2FwX2luaXQoKSAtPiBwY2llX2NhcF92MV9maWxsKCksIA0KICAgIGV2
ZW4gaWYgdGhlcmUncyBubyBwY2llIGRldmljZSBhZGRlZCB0byB0aGUgVk0uDQogICAgSSBub3Rp
Y2VkIHRoYXQgZHVyaW5nIGhvdHBsdWcsIHFlbXUgYWxzbyBzZXRzIFBDSV9FWFBfTE5LU1RBX0RM
TExBIGluIHBjaWVfY2FwX3Nsb3RfaG90cGx1Z19jYigpLg0KICAgIEl0IG1lYW5zIHRoYXQgdGhl
IGJpdCBQQ0lfRVhQX0xOS1NUQV9ETExMQSBpcyBzZXQgVFdJQ0UuDQogICAgd2h5IHNldCB0aGlz
IGJpdCBkdXJpbmcgaW5pdGlhbGl6aW5nIHBjaWUtcm9vdC1wb3J0PyBJdCBzZWVtcyB1bm5lY2Vz
c2FyeS4NCiAgICBUaGUgYmFkIHNpZGUgb2YgdGhpcyBpcyBpdCBjYXVzZXMgSE9UUExVRyBGQUlM
VVJFIGlmIHdlIGJvb3QgdGhlIFZNIGFuZCBob3RwbHVnIGEgcGNpZSBkZXZpY2UgYXQgdGhlIHNh
bWUgdGltZToNCglJbiBWTSBrZXJuZWzvvIxhY2NvcmRpbmcgdG8gdGhpcyBiaXQgc2V0LCBpdCBz
ZW5zZXMgYSBQREMgZXZlbnQsIHRoZSBwcm9jZXNzIGlzOiANCiAgICAgICAgcGNpZWhwX3Byb2Jl
IC0+IHBjaWVfaW5pdCAtPiBwY2llX2luaXRfc2xvdCAtPiBwY2llaHBfcXVldWVfcHVzaGJ1dHRv
bl93b3JrLiANCiAgICBJZiB0aGUgMiBQREMgZXZlbnRzIGdldCB0b28gY2xvc2UsIHRoZSBWTSBr
ZXJuZWwgd2lsbCB3cm9uZ2x5IHVucGx1ZyB0aGUgZGV2aWNlLg0KU3VnZ2VzdGlvbiB0byB0aGUg
MXN0IHByb2JsZW06DQoJQ2FuIEkgcmVtb3ZlIHRoZSBQQ0lfRVhQX0xOS1NUQV9ETExMQSBiaXQg
c2V0IHByb2Nlc3MgZHVyaW5nIHBjaWVfY2FwX2luaXQoKS4NCg0KU2Vjb25kIFF1ZXN0aW9uICh0
aW1lIGNvc3QgdG9vIG11Y2ggZHVyaW5nIHBjaWUgZGV2aWNlIHVucGx1Zyk6DQogICAgcWVtdSBv
bmx5IHNlbmQgQUJQIGV2ZW50IHRvIFZNIGtlcm5lbCBkdXJpbmcgdW5wbHVnaW5nIHBjaWUgZGV2
aWNlcywgVk0ga2VybmVsIHJlY2VpdmVzIHRoZQ0KICAgIEFCUCBldmVudCB0aGVuIHNsZWVwIDVz
IHRvIGV4cGVjdCBhIFBEQyBldmVudCwgd2hpY2ggY2F1c2VzIHVucGx1Z2luZyBkZXZpY2VzIHRh
a2VzIHRvbyBsb25nLiANClN1Z2dlc3Rpb24gdG8gdGhlIDJuZCBwcm9ibGVtOg0KCUNhbiBJIHNl
bmQgQUJQIGFuZCAqUERDKiBldmVudHMgdG8ga2VybmV0IHdoZW4gdW5wbHVnIGRldmljZXMuDQo=

