Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19522C33CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 08:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D70F620684
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 08:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70F620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1it5kf-0006rn-1C
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 03:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tu.guoyi@h3c.com>) id 1it5jv-0006IJ-1x
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 03:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tu.guoyi@h3c.com>) id 1it5jt-0000jy-Bi
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 03:15:22 -0500
Received: from smtp.h3c.com ([60.191.123.56]:3240 helo=h3cspam01-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tu.guoyi@h3c.com>)
 id 1it5js-0000bI-Mt; Sun, 19 Jan 2020 03:15:21 -0500
Received: from DAG2EX07-IDC.srv.huawei-3com.com ([10.8.0.70])
 by h3cspam01-ex.h3c.com with ESMTPS id 00J8EmVs038158
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 19 Jan 2020 16:14:49 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX07-IDC.srv.huawei-3com.com (10.8.0.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 19 Jan 2020 16:14:51 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%6])
 with mapi id 15.01.1713.004; Sun, 19 Jan 2020 16:14:51 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: util/async: File descriptor leak in aio_context_unref()?
Thread-Topic: util/async: File descriptor leak in aio_context_unref()?
Thread-Index: AdXOnyeauMnbk/akShmIS8k2o6hjwQ==
Date: Sun, 19 Jan 2020 08:14:51 +0000
Message-ID: <c24d031088d5439d99e4b0b915f2e405@h3c.com>
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
X-MAIL: h3cspam01-ex.h3c.com 00J8EmVs038158
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 60.191.123.56
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
Cc: Wangyongqing <w_yongqing@h3c.com>, Wangyong <wang.yongD@h3c.com>,
 Changlimin <changlimin@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Chengchiwen <chengchiwen@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SW4gYWlvX2NvbnRleHRfbmV3KCksIHRoZSBAbm90aWZpZXIgdmFyaWFibGUgd2lsbCBiZSBpbml0
aWFsaXplZCwgYnV0IGl0IA0KZG9uJ3QgZ2V0IGNsZWFuZWQgdXAgaW4gYWlvX2NvbnRleHRfdW5y
ZWYoKSB3aGVuIHJlZmVyZW5jZSBjb3VudCByZWFjaGVzDQp0byAwLCBpdCB3aWxsIGNhdXNlIGZp
bGUgZGVzY3JpcHRvciBsZWFrLg0KLS0NCkJlc3QgcmVnYXJkcywNCkd1b3lpDQoNCg==

