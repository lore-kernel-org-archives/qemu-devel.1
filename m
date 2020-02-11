Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815BEC352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 01:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5188720708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 01:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pXbyIX1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5188720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1KCm-00014r-FW
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 20:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jco-0002YC-SV
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jcn-0002jF-JC
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:42:02 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1Jcn-0004pJ-75
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381721; x=1612917721;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/6Pw0kY6/4r/t/tQn/t1CJ7WIRsF421gW1O+ELjT2Ak=;
 b=pXbyIX1E+P04mWUe+hLSq3gS/cbuu4/Jc54KnBweqiNz6WHQ1oN4APx9
 sPzqXeThrvcaKxTwa10+dLuLhcukQL3AfGxO4a+xJXWzrCvhE5l497lDc
 0jD5tD7LpBMH5RyP9Qp0ns16+EtoKz9/GCNaph85EZDMwvBYR4TC4yk7Q A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Feb 2020 16:41:03 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg02-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:41:02 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id A90F61B53; Mon, 10 Feb 2020 18:41:02 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 54/66] Hexagon HVX support in gdbstub
Date: Mon, 10 Feb 2020 18:40:32 -0600
Message-Id: <1581381644-13678-55-git-send-email-tsimpson@quicinc.com>
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

U2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0K
IHRhcmdldC9oZXhhZ29uL2dkYnN0dWIuYyB8IDYyICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMgYi90YXJnZXQvaGV4YWdvbi9n
ZGJzdHViLmMKaW5kZXggZjA3Y2I5YS4uZTk3YjBhZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vZ2Ric3R1Yi5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2dkYnN0dWIuYwpAQCAtMjEsNiArMjEs
MjggQEAKICNpbmNsdWRlICJjcHUuaCIKICNpbmNsdWRlICJpbnRlcm5hbC5oIgogCitzdGF0aWMg
aW50IGdkYl9nZXRfdnJlZyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDhfdCAqbWVtX2J1Ziwg
aW50IG4pCit7CisgICAgaW50IHRvdGFsID0gMDsKKyAgICBpbnQgaTsKKyAgICBmb3IgKGkgPSAw
OyBpIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gNDsgaSsrKSB7CisgICAgICAgIHRvdGFsICs9IGdk
Yl9nZXRfcmVnbChtZW1fYnVmLCBlbnYtPlZSZWdzW25dLnV3W2ldKTsKKyAgICAgICAgbWVtX2J1
ZiArPSA0OworICAgIH0KKyAgICByZXR1cm4gdG90YWw7Cit9CisKK3N0YXRpYyBpbnQgZ2RiX2dl
dF9xcmVnKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50OF90ICptZW1fYnVmLCBpbnQgbikKK3sK
KyAgICBpbnQgdG90YWwgPSAwOworICAgIGludCBpOworICAgIGZvciAoaSA9IDA7IGkgPCBNQVhf
VkVDX1NJWkVfQllURVMgLyA0IC8gODsgaSsrKSB7CisgICAgICAgIHRvdGFsICs9IGdkYl9nZXRf
cmVnbChtZW1fYnVmLCBlbnYtPlFSZWdzW25dLnV3W2ldKTsKKyAgICAgICAgbWVtX2J1ZiArPSA0
OworICAgIH0KKyAgICByZXR1cm4gdG90YWw7Cit9CisKIGludCBoZXhhZ29uX2dkYl9yZWFkX3Jl
Z2lzdGVyKENQVVN0YXRlICpjcywgdWludDhfdCAqbWVtX2J1ZiwgaW50IG4pCiB7CiAgICAgSGV4
YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUoY3MpOwpAQCAtMjksMTEgKzUxLDQxIEBAIGludCBo
ZXhhZ29uX2dkYl9yZWFkX3JlZ2lzdGVyKENQVVN0YXRlICpjcywgdWludDhfdCAqbWVtX2J1Ziwg
aW50IG4pCiAgICAgaWYgKG4gPCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpIHsKICAgICAgICAgcmV0
dXJuIGdkYl9nZXRfcmVnbChtZW1fYnVmLCBlbnYtPmdwcltuXSk7CiAgICAgfQorICAgIG4gLT0g
VE9UQUxfUEVSX1RIUkVBRF9SRUdTOworCisgICAgaWYgKG4gPCBOVU1fVlJFR1MpIHsKKyAgICAg
ICAgcmV0dXJuIGdkYl9nZXRfdnJlZyhlbnYsIG1lbV9idWYsIG4pOworICAgIH0KKyAgICBuIC09
IE5VTV9WUkVHUzsKKworICAgIGlmIChuIDwgTlVNX1FSRUdTKSB7CisgICAgICAgIHJldHVybiBn
ZGJfZ2V0X3FyZWcoZW52LCBtZW1fYnVmLCBuKTsKKyAgICB9CiAKICAgICBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOwogICAgIHJldHVybiAwOwogfQogCitzdGF0aWMgaW50IGdkYl9wdXRfdnJlZyhD
UFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDhfdCAqbWVtX2J1ZiwgaW50IG4pCit7CisgICAgaW50
IGk7CisgICAgZm9yIChpID0gMDsgaSA8IE1BWF9WRUNfU0laRV9CWVRFUyAvIDQ7IGkrKykgewor
ICAgICAgICBlbnYtPlZSZWdzW25dLnV3W2ldID0gbGR0dWxfcChtZW1fYnVmKTsKKyAgICAgICAg
bWVtX2J1ZiArPSA0OworICAgIH0KKyAgICByZXR1cm4gTUFYX1ZFQ19TSVpFX0JZVEVTOworfQor
CitzdGF0aWMgaW50IGdkYl9wdXRfcXJlZyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDhfdCAq
bWVtX2J1ZiwgaW50IG4pCit7CisgICAgaW50IGk7CisgICAgZm9yIChpID0gMDsgaSA8IE1BWF9W
RUNfU0laRV9CWVRFUyAvIDQgLyA4OyBpKyspIHsKKyAgICAgICAgZW52LT5RUmVnc1tuXS51d1tp
XSA9IGxkdHVsX3AobWVtX2J1Zik7CisgICAgICAgIG1lbV9idWYgKz0gNDsKKyAgICB9CisgICAg
cmV0dXJuIE1BWF9WRUNfU0laRV9CWVRFUyAvIDg7Cit9CisKIGludCBoZXhhZ29uX2dkYl93cml0
ZV9yZWdpc3RlcihDUFVTdGF0ZSAqY3MsIHVpbnQ4X3QgKm1lbV9idWYsIGludCBuKQogewogICAg
IEhleGFnb25DUFUgKmNwdSA9IEhFWEFHT05fQ1BVKGNzKTsKQEAgLTQzLDYgKzk1LDE2IEBAIGlu
dCBoZXhhZ29uX2dkYl93cml0ZV9yZWdpc3RlcihDUFVTdGF0ZSAqY3MsIHVpbnQ4X3QgKm1lbV9i
dWYsIGludCBuKQogICAgICAgICBlbnYtPmdwcltuXSA9IGxkdHVsX3AobWVtX2J1Zik7CiAgICAg
ICAgIHJldHVybiBzaXplb2YodGFyZ2V0X3Vsb25nKTsKICAgICB9CisgICAgbiAtPSBUT1RBTF9Q
RVJfVEhSRUFEX1JFR1M7CisKKyAgICBpZiAobiA8IE5VTV9WUkVHUykgeworICAgICAgICByZXR1
cm4gZ2RiX3B1dF92cmVnKGVudiwgbWVtX2J1Ziwgbik7CisgICAgfQorICAgIG4gLT0gTlVNX1ZS
RUdTOworCisgICAgaWYgKG4gPCBOVU1fUVJFR1MpIHsKKyAgICAgICAgcmV0dXJuIGdkYl9wdXRf
cXJlZyhlbnYsIG1lbV9idWYsIG4pOworICAgIH0KIAogICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVk
KCk7CiAgICAgcmV0dXJuIDA7Ci0tIAoyLjcuNAoK

