Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2028FC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48D4246A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f7reudp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48D4246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jHY-0006Fc-2o
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ike-0002p7-Bn
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ika-0005XN-SQ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:36 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:13235)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j7ika-0005U6-HB
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1582908272; x=1614444272;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JmQ0o0AOEt12wjIj69o0UKPGB/FBnk4P+Oa5HBoC7zk=;
 b=f7reudp+008OxKwYrhIo8megHxC1xWkywSW0+KKmo11LWtPR3l5Z6paq
 U39jw/unjHFYa/S2oZBVWp8fDBb2ZGvO2I+hM6aQwQ+g6jxslVEEF8570
 CS9taJndoaS54x6Xcao/yraoR6ct2A3gRbCITWCaX7/7KzNiFxx36b+jl Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Feb 2020 08:44:29 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg05-sd.qualcomm.com with ESMTP; 28 Feb 2020 08:44:27 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 69B511163; Fri, 28 Feb 2020 10:44:27 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 06/67] Hexagon Disassembler
Date: Fri, 28 Feb 2020 10:43:02 -0600
Message-Id: <1582908244-304-7-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
References: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
YXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+Ci0tLQogaW5jbHVkZS9kaXNhcy9k
aXMtYXNtLmggfCAgMSArCiBkaXNhcy9oZXhhZ29uLmMgICAgICAgICB8IDYyICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRpc2FzL01ha2VmaWxlLm9i
anMgICAgIHwgIDEgKwogMyBmaWxlcyBjaGFuZ2VkLCA2NCBpbnNlcnRpb25zKCspCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZGlzYXMvaGV4YWdvbi5jCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kaXNhcy9k
aXMtYXNtLmggYi9pbmNsdWRlL2Rpc2FzL2Rpcy1hc20uaAppbmRleCBmODdmNDY4Li5hN2ZhODJk
IDEwMDY0NAotLS0gYS9pbmNsdWRlL2Rpc2FzL2Rpcy1hc20uaAorKysgYi9pbmNsdWRlL2Rpc2Fz
L2Rpcy1hc20uaApAQCAtNDM2LDYgKzQzNiw3IEBAIGludCBwcmludF9pbnNuX2xpdHRsZV9uaW9z
MiAgICAgKGJmZF92bWEsIGRpc2Fzc2VtYmxlX2luZm8qKTsKIGludCBwcmludF9pbnNuX3h0ZW5z
YSAgICAgICAgICAgKGJmZF92bWEsIGRpc2Fzc2VtYmxlX2luZm8qKTsKIGludCBwcmludF9pbnNu
X3Jpc2N2MzIgICAgICAgICAgKGJmZF92bWEsIGRpc2Fzc2VtYmxlX2luZm8qKTsKIGludCBwcmlu
dF9pbnNuX3Jpc2N2NjQgICAgICAgICAgKGJmZF92bWEsIGRpc2Fzc2VtYmxlX2luZm8qKTsKK2lu
dCBwcmludF9pbnNuX2hleGFnb24gICAgICAgICAgKGJmZF92bWEsIGRpc2Fzc2VtYmxlX2luZm8q
KTsKIAogI2lmIDAKIC8qIEZldGNoIHRoZSBkaXNhc3NlbWJsZXIgZm9yIGEgZ2l2ZW4gQkZELCBp
ZiB0aGF0IHN1cHBvcnQgaXMgYXZhaWxhYmxlLiAgKi8KZGlmZiAtLWdpdCBhL2Rpc2FzL2hleGFn
b24uYyBiL2Rpc2FzL2hleGFnb24uYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAw
Li42ZWU4NjUzCi0tLSAvZGV2L251bGwKKysrIGIvZGlzYXMvaGV4YWdvbi5jCkBAIC0wLDAgKzEs
NjIgQEAKKy8qCisgKiAgQ29weXJpZ2h0KGMpIDIwMTktMjAyMCBRdWFsY29tbSBJbm5vdmF0aW9u
IENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorICoKKyAqICBUaGlzIHByb2dyYW0g
aXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQor
ICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
YXMgcHVibGlzaGVkIGJ5CisgKiAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVy
IHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqICAoYXQgeW91ciBvcHRpb24pIGFueSBs
YXRlciB2ZXJzaW9uLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhl
IGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFO
VFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJ
TElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqICBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZb3Ug
c2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZQorICogIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHNlZSA8aHR0cDovL3d3
dy5nbnUub3JnL2xpY2Vuc2VzLz4uCisgKi8KKworLyoKKyAqIFFFTVUgSGV4YWdvbiBEaXNhc3Nl
bWJsZXIKKyAqLworCisjaW5jbHVkZSAicWVtdS9vc2RlcC5oIgorI2luY2x1ZGUgImRpc2FzL2Rp
cy1hc20uaCIKKyNpbmNsdWRlICJ0YXJnZXQvaGV4YWdvbi9jcHVfYml0cy5oIgorCisvKgorICog
V2Ugd2lsbCBkaXNhc3NlbWJsZSBhIHBhY2tldCB3aXRoIHVwIHRvIDQgaW5zdHJ1Y3Rpb25zLCBz
byB3ZSBuZWVkCisgKiBhIGhlZnR5IHNpemUgYnVmZmVyLgorICovCisjZGVmaW5lIFBBQ0tFVF9C
VUZGRVJfTEVOICAgICAgICAgICAgICAgICAgIDEwMjgKKworaW50IHByaW50X2luc25faGV4YWdv
bihiZmRfdm1hIG1lbWFkZHIsIHN0cnVjdCBkaXNhc3NlbWJsZV9pbmZvICppbmZvKQoreworICAg
IHVpbnQzMl90IHdvcmRzW1BBQ0tFVF9XT1JEU19NQVhdOworICAgIGludCBsZW4sIHNsZW47Cisg
ICAgY2hhciBidWZbUEFDS0VUX0JVRkZFUl9MRU5dOworICAgIGludCBzdGF0dXM7CisgICAgaW50
IGk7CisKKyAgICBmb3IgKGkgPSAwOyBpIDwgUEFDS0VUX1dPUkRTX01BWDsgaSsrKSB7CisgICAg
ICAgIHN0YXR1cyA9ICgqaW5mby0+cmVhZF9tZW1vcnlfZnVuYykobWVtYWRkciArIGkgKiBzaXpl
b2YodWludDMyX3QpLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IChiZmRfYnl0ZSAqKSZ3b3Jkc1tpXSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzaXplb2YodWludDMyX3QpLCBpbmZvKTsKKyAgICAgICAgaWYgKHN0YXR1cykg
eworICAgICAgICAgICAgaWYgKGkgPiAwKSB7CisgICAgICAgICAgICAgICAgYnJlYWs7CisgICAg
ICAgICAgICB9CisgICAgICAgICAgICAoKmluZm8tPm1lbW9yeV9lcnJvcl9mdW5jKShzdGF0dXMs
IG1lbWFkZHIsIGluZm8pOworICAgICAgICAgICAgcmV0dXJuIHN0YXR1czsKKyAgICAgICAgfQor
ICAgIH0KKworICAgIGxlbiA9IGRpc2Fzc2VtYmxlX2hleGFnb24od29yZHMsIGksIGJ1ZiwgUEFD
S0VUX0JVRkZFUl9MRU4pOworICAgIHNsZW4gPSBzdHJsZW4oYnVmKTsKKyAgICBpZiAoYnVmW3Ns
ZW4gLSAxXSA9PSAnXG4nKSB7CisgICAgICAgIGJ1ZltzbGVuIC0gMV0gPSAnXDAnOworICAgIH0K
KyAgICAoKmluZm8tPmZwcmludGZfZnVuYykoaW5mby0+c3RyZWFtLCAiJXMiLCBidWYpOworCisg
ICAgcmV0dXJuIGxlbjsKK30KKwpkaWZmIC0tZ2l0IGEvZGlzYXMvTWFrZWZpbGUub2JqcyBiL2Rp
c2FzL01ha2VmaWxlLm9ianMKaW5kZXggM2MxY2RjZS4uMGU4Njk2NCAxMDA2NDQKLS0tIGEvZGlz
YXMvTWFrZWZpbGUub2JqcworKysgYi9kaXNhcy9NYWtlZmlsZS5vYmpzCkBAIC0yNCw2ICsyNCw3
IEBAIGNvbW1vbi1vYmotJChDT05GSUdfU0g0X0RJUykgKz0gc2g0Lm8KIGNvbW1vbi1vYmotJChD
T05GSUdfU1BBUkNfRElTKSArPSBzcGFyYy5vCiBjb21tb24tb2JqLSQoQ09ORklHX0xNMzJfRElT
KSArPSBsbTMyLm8KIGNvbW1vbi1vYmotJChDT05GSUdfWFRFTlNBX0RJUykgKz0geHRlbnNhLm8K
K2NvbW1vbi1vYmotJChDT05GSUdfSEVYQUdPTl9ESVMpICs9IGhleGFnb24ubwogCiAjIFRPRE86
IEFzIGxvbmcgYXMgdGhlIFRDRyBpbnRlcnByZXRlciBhbmQgaXRzIGdlbmVyYXRlZCBjb2RlIGRl
cGVuZAogIyBvbiB0aGUgUUVNVSB0YXJnZXQsIHdlIGNhbm5vdCBjb21waWxlIHRoZSBkaXNhc3Nl
bWJsZXIgaGVyZS4KLS0gCjIuNy40Cgo=

