Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77B8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E117620719
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E117620719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaVgv-0007Yk-Nd
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 22:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tu.guoyi@h3c.com>)
 id 1kaVgL-00072Z-Bn; Wed, 04 Nov 2020 22:11:25 -0500
Received: from smtp.h3c.com ([60.191.123.50]:40662 helo=h3cspam02-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tu.guoyi@h3c.com>)
 id 1kaVgG-0004nd-D3; Wed, 04 Nov 2020 22:11:25 -0500
Received: from DAG2EX04-BASE.srv.huawei-3com.com ([10.8.0.67])
 by h3cspam02-ex.h3c.com with ESMTPS id 0A53AqCC005662
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Nov 2020 11:10:52 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX04-BASE.srv.huawei-3com.com (10.8.0.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 5 Nov 2020 11:10:54 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7])
 with mapi id 15.01.2106.002; Thu, 5 Nov 2020 11:10:54 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: [PATCH] block: Return the real error code in bdrv_getlength
Thread-Topic: [PATCH] block: Return the real error code in bdrv_getlength
Thread-Index: AdazIT2D4zpMc6pIQHiDry0tmEuvDw==
Date: Thu, 5 Nov 2020 03:10:53 +0000
Message-ID: <b6591409899545d89c6cbeb9fd7caffd@h3c.com>
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
X-MAIL: h3cspam02-ex.h3c.com 0A53AqCC005662
Received-SPF: pass client-ip=60.191.123.50; envelope-from=tu.guoyi@h3c.com;
 helo=h3cspam02-ex.h3c.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:11:07
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIHJldHVybiBjb2RlIGZyb20gIGJkcnZfbmJfc2VjdG9ycygpIHNob3VsZCBiZSBjaGVja2Vk
IGJlZm9yZSBkb2luZw0KdGhlIGZvbGxvd2luZyBzYW5pdHkgY2hlY2suDQoNClNpZ25lZC1vZmYt
Ynk6IEd1b3lpIFR1IDx0dS5ndW95aUBoM2MuY29tPg0KLS0tDQogYmxvY2suYyB8IDQgKysrKw0K
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Jsb2NrLmMg
Yi9ibG9jay5jDQppbmRleCA0MzBlZGY3Li4xOWViYmMwIDEwMDY0NA0KLS0tIGEvYmxvY2suYw0K
KysrIGIvYmxvY2suYw0KQEAgLTUwODIsNiArNTA4MiwxMCBAQCBpbnQ2NF90IGJkcnZfZ2V0bGVu
Z3RoKEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0KIHsNCiAgICAgaW50NjRfdCByZXQgPSBiZHJ2X25i
X3NlY3RvcnMoYnMpOw0KIA0KKyAgICBpZiAocmV0IDwgMCkgew0KKyAgICAgICAgcmV0dXJuIHJl
dDsNCisgICAgfQ0KKw0KICAgICByZXQgPSByZXQgPiBJTlQ2NF9NQVggLyBCRFJWX1NFQ1RPUl9T
SVpFID8gLUVGQklHIDogcmV0Ow0KICAgICByZXR1cm4gcmV0IDwgMCA/IHJldCA6IHJldCAqIEJE
UlZfU0VDVE9SX1NJWkU7DQogfQ0KLS0gDQoyLjcuNA0KDQoNCi0tDQpCZXN0IHJlZ2FyZHMsDQpH
dW95aQ0KDQoNCg==

