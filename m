Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C90C352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 01:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D690520708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 01:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V3rYvf4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D690520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1K3J-0004K2-Ts
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 20:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1JcP-0001pg-45
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1JcN-0007yJ-Ng
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:36 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1JcN-0004uP-Cg
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381695; x=1612917695;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tCTAwQrhccTZja81gm8eTGQCwBVmjPzsNGRta885dnM=;
 b=V3rYvf4KcLDyfzuTNtB40bI6/n+RFjLAH74F8H+4m/90ko4I8Jes4k+5
 0fmlzIJAqjWnAtrbIYC9SU7hBbLYOqTyRKCNDlRrHa14triURbkehcdYH
 QQMnPWFkElA5LUFIFasVxjzEiPqYpxtrRDyWZMLkHnq5LMlRkKSUkYlzf E=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Feb 2020 16:41:01 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg02-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:41:00 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id A17381B27; Mon, 10 Feb 2020 18:41:00 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 34/66] Hexagon TCG generation helpers - step 2
Date: Mon, 10 Feb 2020 18:40:12 -0600
Message-Id: <1581381644-13678-35-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 Taylor Simpson <tsimpson@quicinc.com>, philmd@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGVscGVycyBmb3IgbG9hZC1sb2NrZWQvc3RvcmUtY29uZGl0aW9uYWwKClNpZ25lZC1vZmYtYnk6
IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdv
bi9nZW5wdHJfaGVscGVycy5oIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vZ2VucHRyX2hlbHBlcnMuaCBiL3RhcmdldC9oZXhhZ29uL2dlbnB0cl9o
ZWxwZXJzLmgKaW5kZXggMmI5MWZkYi4uYjc4MDUyMiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vZ2VucHRyX2hlbHBlcnMuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHJfaGVscGVycy5o
CkBAIC0zMjAsNCArMzIwLDU2IEBAIHN0YXRpYyBpbmxpbmUgVENHdiBnZW5fc2V0X2JpdChpbnQg
aSwgVENHdiByZXN1bHQsIFRDR3Ygc3JjKQogICAgIHJldHVybiByZXN1bHQ7CiB9CiAKK3N0YXRp
YyBpbmxpbmUgdm9pZCBnZW5fbG9hZF9sb2NrZWQ0dShUQ0d2IGRlc3QsIFRDR3YgdmFkZHIsIGlu
dCBtZW1faW5kZXgpCit7CisgICAgdGNnX2dlbl9xZW11X2xkMzJ1KGRlc3QsIHZhZGRyLCBtZW1f
aW5kZXgpOworICAgIHRjZ19nZW5fbW92X3RsKGxsc2NfYWRkciwgdmFkZHIpOworICAgIHRjZ19n
ZW5fbW92X3RsKGxsc2NfdmFsLCBkZXN0KTsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGdlbl9s
b2FkX2xvY2tlZDh1KFRDR3ZfaTY0IGRlc3QsIFRDR3YgdmFkZHIsIGludCBtZW1faW5kZXgpCit7
CisgICAgdGNnX2dlbl9xZW11X2xkNjQoZGVzdCwgdmFkZHIsIG1lbV9pbmRleCk7CisgICAgdGNn
X2dlbl9tb3ZfdGwobGxzY19hZGRyLCB2YWRkcik7CisgICAgdGNnX2dlbl9tb3ZfaTY0KGxsc2Nf
dmFsX2k2NCwgZGVzdCk7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBnZW5fc3RvcmVfY29uZGl0
aW9uYWw0KENQVUhleGFnb25TdGF0ZSAqZW52LAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgRGlzYXNDb250ZXh0ICpjdHgsIGludCBwcmVkbnVtLAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVENHdiBwcmVkLCBUQ0d2IHZhZGRyLCBU
Q0d2IHNyYykKK3sKKyAgICBUQ0d2IHRtcCA9IHRjZ190ZW1wX25ldygpOworICAgIFRDR0xhYmVs
ICpmYWlsID0gZ2VuX25ld19sYWJlbCgpOworCisgICAgdGNnX2dlbl9sZF90bCh0bXAsIGNwdV9l
bnYsIG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgbGxzY19hZGRyKSk7CisgICAgdGNnX2dlbl9i
cmNvbmRfdGwoVENHX0NPTkRfTkUsIHZhZGRyLCB0bXAsIGZhaWwpOworICAgIHRjZ19nZW5fbW92
aV90bCh0bXAsIHByZWRudW0pOworICAgIHRjZ19nZW5fc3RfdGwodG1wLCBjcHVfZW52LCBvZmZz
ZXRvZihDUFVIZXhhZ29uU3RhdGUsIGxsc2NfcmVnKSk7CisgICAgdGNnX2dlbl9zdF90bChzcmMs
IGNwdV9lbnYsIG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgbGxzY19uZXd2YWwpKTsKKyAgICBn
ZW5fZXhjZXB0aW9uKEhFWF9FWENQX1NDNCk7CisKKyAgICBnZW5fc2V0X2xhYmVsKGZhaWwpOwor
ICAgIHRjZ19nZW5fbW92aV90bChwcmVkLCAwKTsKKyAgICB0Y2dfdGVtcF9mcmVlKHRtcCk7Cit9
CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBnZW5fc3RvcmVfY29uZGl0aW9uYWw4KENQVUhleGFnb25T
dGF0ZSAqZW52LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRGlz
YXNDb250ZXh0ICpjdHgsIGludCBwcmVkbnVtLAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgVENHdiBwcmVkLCBUQ0d2IHZhZGRyLCBUQ0d2X2k2NCBzcmMpCit7Cisg
ICAgVENHdiB0bXAgPSB0Y2dfdGVtcF9uZXcoKTsKKyAgICBUQ0dMYWJlbCAqZmFpbCA9IGdlbl9u
ZXdfbGFiZWwoKTsKKworICAgIHRjZ19nZW5fbGRfdGwodG1wLCBjcHVfZW52LCBvZmZzZXRvZihD
UFVIZXhhZ29uU3RhdGUsIGxsc2NfYWRkcikpOworICAgIHRjZ19nZW5fYnJjb25kX3RsKFRDR19D
T05EX05FLCB2YWRkciwgdG1wLCBmYWlsKTsKKyAgICB0Y2dfZ2VuX21vdmlfdGwodG1wLCBwcmVk
bnVtKTsKKyAgICB0Y2dfZ2VuX3N0X3RsKHRtcCwgY3B1X2Vudiwgb2Zmc2V0b2YoQ1BVSGV4YWdv
blN0YXRlLCBsbHNjX3JlZykpOworICAgIHRjZ19nZW5fc3RfaTY0KHNyYywgY3B1X2Vudiwgb2Zm
c2V0b2YoQ1BVSGV4YWdvblN0YXRlLCBsbHNjX25ld3ZhbF9pNjQpKTsKKyAgICBnZW5fZXhjZXB0
aW9uKEhFWF9FWENQX1NDOCk7CisKKyAgICBnZW5fc2V0X2xhYmVsKGZhaWwpOworICAgIHRjZ19n
ZW5fbW92aV90bChwcmVkLCAwKTsKKyAgICB0Y2dfdGVtcF9mcmVlKHRtcCk7Cit9CisKICNlbmRp
ZgotLSAKMi43LjQKCg==

