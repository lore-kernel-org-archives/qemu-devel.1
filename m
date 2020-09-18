Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E918C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44AC23719
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="Uq0/KDuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44AC23719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGBm-0000Va-BG
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibinzhang@tencent.com>)
 id 1kJFOp-0003QZ-HC
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:21:59 -0400
Received: from mail4.tencent.com ([183.57.53.109]:44434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibinzhang@tencent.com>)
 id 1kJFOe-0002AK-3H
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:21:55 -0400
Received: from EX-SZ020.tencent.com (unknown [10.28.6.40])
 by mail4.tencent.com (Postfix) with ESMTP id 00962725C0;
 Fri, 18 Sep 2020 20:21:35 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
 s=s202002; t=1600431695;
 bh=IYMzpBxT8A12a+KpXqGnLrWB0pAtzJXfRZDIOY56Ki4=;
 h=From:To:CC:Subject:Date;
 b=Uq0/KDujb9rU0krgpCkUXlQYPQqrw6qD6doJCVpXo48Q7K7Sn4+Ya1Qp3CxWaWC0h
 v0NHYfbaXAZ5AgVh3s4bPbOWOWXpEFDddRhwXTZbXcZeYbudXUaBR1HNwrzZF6X90p
 NiajSOh1IvYrVdN+pfjBmHVcOA6RdCalUw3wQJZU=
Received: from EX-SZ008.tencent.com (10.28.6.32) by EX-SZ020.tencent.com
 (10.28.6.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 18 Sep
 2020 20:21:34 +0800
Received: from EX-SZ006.tencent.com (10.28.6.30) by EX-SZ008.tencent.com
 (10.28.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 18 Sep
 2020 20:21:34 +0800
Received: from EX-SZ006.tencent.com ([fe80::a84e:872e:7c90:2930]) by
 EX-SZ006.tencent.com ([fe80::a84e:872e:7c90:2930%2]) with mapi id
 15.01.1847.007; Fri, 18 Sep 2020 20:21:34 +0800
From: =?gb2312?B?aGFpYmluemhhbmco1cW6o7HzKQ==?= <haibinzhang@tencent.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.or" <qemu-arm@nongnu.or>
Subject: [PATCH] hw/arm/virt: use pflash image real size when mapping
Thread-Topic: [PATCH] hw/arm/virt: use pflash image real size when mapping
Thread-Index: AQHWjbY/cNIz15wmREu2TaM+k+G3MQ==
Date: Fri, 18 Sep 2020 12:21:34 +0000
Message-ID: <8084C510-D407-4DC2-9A48-E3341E36B188@tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.113]
Content-Type: text/plain; charset="gb2312"
Content-ID: <585A42339384304595A377FA9C957283@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=183.57.53.109;
 envelope-from=haibinzhang@tencent.com; helo=mail4.tencent.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 08:21:38
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 18 Sep 2020 09:10:55 -0400
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

RGVmYXVsdCBzaXplIG9mIGFybS12aXJ0IHBmbGFzaCBpbWFnZSBpcyA2NE1CIHdoaWNoDQp3aWxs
IGNvc3QgZXh0cmEgMTI4TUIoNjRNQngyKSBtZW1vcnkgcGVyIHFlbXUgcHJvY2Vzcw0KYW5kIDEy
LjVHQiBmb3IgMTAwIHFlbXUgcHJvY2Vzc2VzLiBIb3N0IG1lbW9yeSBpcw0KcHJlY2lvdXMgYW5k
IGl0IGlzIHZhbHVhYmxlIHRvIHJlZHVjZSBwZmxhc2ggaW1hZ2Ugc2l6ZS4NCkZvciBjb21wYXRp
YmlsaXR5IGFybS12aXJ0IHVzZXMgcmVhbCBzaXplIHdoZW4gbWFwcGluZy4NCg0KU2lnbmVkLW9m
Zi1ieTogSGFpYmluIFpoYW5nIDxoYWliaW56aGFuZ0B0ZW5jZW50LmNvbT4NCi0tLQ0KIGh3L2Fy
bS92aXJ0LmMgfCAyMiArKysrKysrKysrKysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIw
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9hcm0vdmly
dC5jIGIvaHcvYXJtL3ZpcnQuYw0KaW5kZXggYWNmOWJmYmVjZS4uMzU0NWUxMjg2NSAxMDA2NDQN
Ci0tLSBhL2h3L2FybS92aXJ0LmMNCisrKyBiL2h3L2FybS92aXJ0LmMNCkBAIC01MCw2ICs1MCw3
IEBADQogI2luY2x1ZGUgInN5c2VtdS9zeXNlbXUuaCINCiAjaW5jbHVkZSAic3lzZW11L3RwbS5o
Ig0KICNpbmNsdWRlICJzeXNlbXUva3ZtLmgiDQorI2luY2x1ZGUgInN5c2VtdS9ibG9jay1iYWNr
ZW5kLmgiDQogI2luY2x1ZGUgImh3L2xvYWRlci5oIg0KICNpbmNsdWRlICJleGVjL2FkZHJlc3Mt
c3BhY2VzLmgiDQogI2luY2x1ZGUgInFlbXUvYml0b3BzLmgiDQpAQCAtMTAwMSwxMCArMTAwMiwy
NyBAQCBzdGF0aWMgdm9pZCB2aXJ0X2ZsYXNoX21hcChWaXJ0TWFjaGluZVN0YXRlICp2bXMsDQog
ICAgICAqLw0KICAgICBod2FkZHIgZmxhc2hzaXplID0gdm1zLT5tZW1tYXBbVklSVF9GTEFTSF0u
c2l6ZSAvIDI7DQogICAgIGh3YWRkciBmbGFzaGJhc2UgPSB2bXMtPm1lbW1hcFtWSVJUX0ZMQVNI
XS5iYXNlOw0KKyAgICBpbnQ2NF90IHJlYWxzaXplOw0KKyAgICBCbG9ja0JhY2tlbmQgKmJsazsN
Cg0KLSAgICB2aXJ0X2ZsYXNoX21hcDEodm1zLT5mbGFzaFswXSwgZmxhc2hiYXNlLCBmbGFzaHNp
emUsDQorICAgIHJlYWxzaXplID0gZmxhc2hzaXplOw0KKyAgICBibGsgPSBwZmxhc2hfY2ZpMDFf
Z2V0X2Jsayh2bXMtPmZsYXNoWzBdKTsNCisgICAgaWYgKGJsaykgew0KKyAgICAgICAgcmVhbHNp
emUgPSBibGtfZ2V0bGVuZ3RoKGJsayk7DQorICAgICAgICByZWFsc2l6ZSA9IHJlYWxzaXplIDwg
Zmxhc2hzaXplID8gcmVhbHNpemUgOiBmbGFzaHNpemU7DQorICAgIH0NCisNCisgICAgdmlydF9m
bGFzaF9tYXAxKHZtcy0+Zmxhc2hbMF0sIGZsYXNoYmFzZSwgcmVhbHNpemUsDQogICAgICAgICAg
ICAgICAgICAgICBzZWN1cmVfc3lzbWVtKTsNCi0gICAgdmlydF9mbGFzaF9tYXAxKHZtcy0+Zmxh
c2hbMV0sIGZsYXNoYmFzZSArIGZsYXNoc2l6ZSwgZmxhc2hzaXplLA0KKw0KKyAgICByZWFsc2l6
ZSA9IGZsYXNoc2l6ZTsNCisgICAgYmxrID0gcGZsYXNoX2NmaTAxX2dldF9ibGsodm1zLT5mbGFz
aFsxXSk7DQorICAgIGlmIChibGspIHsNCisgICAgICAgIHJlYWxzaXplID0gYmxrX2dldGxlbmd0
aChibGspOw0KKyAgICAgICAgcmVhbHNpemUgPSByZWFsc2l6ZSA8IGZsYXNoc2l6ZSA/IHJlYWxz
aXplIDogZmxhc2hzaXplOw0KKyAgICB9DQorDQorICAgIHZpcnRfZmxhc2hfbWFwMSh2bXMtPmZs
YXNoWzFdLCBmbGFzaGJhc2UgKyBmbGFzaHNpemUsIHJlYWxzaXplLA0KICAgICAgICAgICAgICAg
ICAgICAgc3lzbWVtKTsNCiB9DQoNCi0tDQoyLjIzLjANCg0K

