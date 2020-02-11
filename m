Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B74C352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4626220733
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EQtCvFGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4626220733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Jge-0001hK-8K
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 19:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbt-0000yP-N5
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbr-00052l-Fy
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:05 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1Jbr-0004pJ-6C
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381663; x=1612917663;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b0zbQn77uceuA8z2KmGY8r73w3JpiAXBpr9bzst7qeQ=;
 b=EQtCvFGZzAJbJL06mletbhB2yKJsD77InBRuJCORBLCbNo76X9ZY1TVQ
 GWxEIQDBhRTpkKoVW2RuC3kzYo5cFpqkuaSvRJcMP0+ZFLQCMSyAV5LWK
 43Jv1XsN/C0W0hIUSchJVWyBbp48E2Vmvitu2FBqYpHqZVq5K85zlwn6l 4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Feb 2020 16:40:58 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg03-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:40:58 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 6A9F51B5F; Mon, 10 Feb 2020 18:40:57 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 05/66] Hexagon Disassembler
Date: Mon, 10 Feb 2020 18:39:43 -0600
Message-Id: <1581381644-13678-6-git-send-email-tsimpson@quicinc.com>
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

VGhlIEhleGFnb24gZGlzYXNzZW1ibGVyIGNhbGxzIGRpc2Fzc2VtYmxlX2hleGFnb24gdG8gZGVj
b2RlIGEgcGFja2V0CmFuZCBmb3JtYXQgaXQgZm9yIHByaW50aW5nCgpTaWduZWQtb2ZmLWJ5OiBU
YXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+Ci0tLQogZGlzYXMvTWFrZWZpbGUu
b2JqcyAgICAgfCAgMSArCiBkaXNhcy9oZXhhZ29uLmMgICAgICAgICB8IDU2ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGluY2x1ZGUvZGlzYXMvZGlz
LWFzbS5oIHwgIDEgKwogMyBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZGlzYXMvaGV4YWdvbi5jCgpkaWZmIC0tZ2l0IGEvZGlzYXMvTWFrZWZpbGUu
b2JqcyBiL2Rpc2FzL01ha2VmaWxlLm9ianMKaW5kZXggM2MxY2RjZS4uMGU4Njk2NCAxMDA2NDQK
LS0tIGEvZGlzYXMvTWFrZWZpbGUub2JqcworKysgYi9kaXNhcy9NYWtlZmlsZS5vYmpzCkBAIC0y
NCw2ICsyNCw3IEBAIGNvbW1vbi1vYmotJChDT05GSUdfU0g0X0RJUykgKz0gc2g0Lm8KIGNvbW1v
bi1vYmotJChDT05GSUdfU1BBUkNfRElTKSArPSBzcGFyYy5vCiBjb21tb24tb2JqLSQoQ09ORklH
X0xNMzJfRElTKSArPSBsbTMyLm8KIGNvbW1vbi1vYmotJChDT05GSUdfWFRFTlNBX0RJUykgKz0g
eHRlbnNhLm8KK2NvbW1vbi1vYmotJChDT05GSUdfSEVYQUdPTl9ESVMpICs9IGhleGFnb24ubwog
CiAjIFRPRE86IEFzIGxvbmcgYXMgdGhlIFRDRyBpbnRlcnByZXRlciBhbmQgaXRzIGdlbmVyYXRl
ZCBjb2RlIGRlcGVuZAogIyBvbiB0aGUgUUVNVSB0YXJnZXQsIHdlIGNhbm5vdCBjb21waWxlIHRo
ZSBkaXNhc3NlbWJsZXIgaGVyZS4KZGlmZiAtLWdpdCBhL2Rpc2FzL2hleGFnb24uYyBiL2Rpc2Fz
L2hleGFnb24uYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5mZDlhZjEwCi0t
LSAvZGV2L251bGwKKysrIGIvZGlzYXMvaGV4YWdvbi5jCkBAIC0wLDAgKzEsNTYgQEAKKy8qCisg
KiAgQ29weXJpZ2h0IChjKSAyMDE5IFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFs
bCBSaWdodHMgUmVzZXJ2ZWQuCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJl
OyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhl
IHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkK
KyAqICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRo
ZSBMaWNlbnNlLCBvcgorICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisg
KgorICogIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdp
bGwgYmUgdXNlZnVsLAorICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVu
IHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1Mg
Rk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1Ymxp
YyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSByZWNl
aXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxvbmcg
d2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5z
ZXMvPi4KKyAqLworCisvKgorICogUUVNVSBIZXhhZ29uIERpc2Fzc2VtYmxlcgorICovCisKKyNp
bmNsdWRlICJxZW11L29zZGVwLmgiCisjaW5jbHVkZSAiZGlzYXMvZGlzLWFzbS5oIgorI2luY2x1
ZGUgInRhcmdldC9oZXhhZ29uL2NwdV9iaXRzLmgiCisKK2ludCBwcmludF9pbnNuX2hleGFnb24o
YmZkX3ZtYSBtZW1hZGRyLCBzdHJ1Y3QgZGlzYXNzZW1ibGVfaW5mbyAqaW5mbykKK3sKKyAgICB1
aW50MzJfdCB3b3Jkc1tQQUNLRVRfV09SRFNfTUFYXTsKKyAgICBpbnQgbGVuLCBzbGVuOworICAg
IGNoYXIgYnVmWzEwMjhdOworICAgIGludCBzdGF0dXM7CisgICAgaW50IGk7CisKKyAgICBmb3Ig
KGkgPSAwOyBpIDwgUEFDS0VUX1dPUkRTX01BWDsgaSsrKSB7CisgICAgICAgIHN0YXR1cyA9ICgq
aW5mby0+cmVhZF9tZW1vcnlfZnVuYykobWVtYWRkciArIGkgKiBzaXplb2YodWludDMyX3QpLAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChiZmRfYnl0ZSAqKSZ3
b3Jkc1tpXSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXpl
b2YodWludDMyX3QpLCBpbmZvKTsKKyAgICAgICAgaWYgKHN0YXR1cykgeworICAgICAgICAgICAg
aWYgKGkgPiAwKSB7CisgICAgICAgICAgICAgICAgYnJlYWs7CisgICAgICAgICAgICB9CisgICAg
ICAgICAgICAoKmluZm8tPm1lbW9yeV9lcnJvcl9mdW5jKShzdGF0dXMsIG1lbWFkZHIsIGluZm8p
OworICAgICAgICAgICAgcmV0dXJuIHN0YXR1czsKKyAgICAgICAgfQorICAgIH0KKworICAgIGxl
biA9IGRpc2Fzc2VtYmxlX2hleGFnb24od29yZHMsIGksIGJ1ZiwgMTAyOCk7CisgICAgc2xlbiA9
IHN0cmxlbihidWYpOworICAgIGlmIChidWZbc2xlbiAtIDFdID09ICdcbicpIHsKKyAgICAgICAg
YnVmW3NsZW4gLSAxXSA9ICdcMCc7CisgICAgfQorICAgICgqaW5mby0+ZnByaW50Zl9mdW5jKShp
bmZvLT5zdHJlYW0sICIlcyIsIGJ1Zik7CisKKyAgICByZXR1cm4gbGVuOworfQorCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2Rpc2FzL2Rpcy1hc20uaCBiL2luY2x1ZGUvZGlzYXMvZGlzLWFzbS5oCmlu
ZGV4IGY4N2Y0NjguLmE3ZmE4MmQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvZGlzYXMvZGlzLWFzbS5o
CisrKyBiL2luY2x1ZGUvZGlzYXMvZGlzLWFzbS5oCkBAIC00MzYsNiArNDM2LDcgQEAgaW50IHBy
aW50X2luc25fbGl0dGxlX25pb3MyICAgICAoYmZkX3ZtYSwgZGlzYXNzZW1ibGVfaW5mbyopOwog
aW50IHByaW50X2luc25feHRlbnNhICAgICAgICAgICAoYmZkX3ZtYSwgZGlzYXNzZW1ibGVfaW5m
byopOwogaW50IHByaW50X2luc25fcmlzY3YzMiAgICAgICAgICAoYmZkX3ZtYSwgZGlzYXNzZW1i
bGVfaW5mbyopOwogaW50IHByaW50X2luc25fcmlzY3Y2NCAgICAgICAgICAoYmZkX3ZtYSwgZGlz
YXNzZW1ibGVfaW5mbyopOworaW50IHByaW50X2luc25faGV4YWdvbiAgICAgICAgICAoYmZkX3Zt
YSwgZGlzYXNzZW1ibGVfaW5mbyopOwogCiAjaWYgMAogLyogRmV0Y2ggdGhlIGRpc2Fzc2VtYmxl
ciBmb3IgYSBnaXZlbiBCRkQsIGlmIHRoYXQgc3VwcG9ydCBpcyBhdmFpbGFibGUuICAqLwotLSAK
Mi43LjQKCg==

