Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D497C352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 01:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E8020708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 01:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EKs1E3Xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E8020708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1K5L-0008Da-6N
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 20:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1JcR-0001qw-93
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1JcP-0008Ab-1d
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:39 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59197)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1JcO-0004rC-M7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381696; x=1612917696;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q0XwbfrLMoK+KahDeXGLUZ7mZb4Qbt8SKYm+YrynLvo=;
 b=EKs1E3XvYbsNWbM94QwH90DAA48OhOfHKUk1QNawvZrPdlo8bbxuW7R3
 nek9QJ2Wn5v0ISUzmAXOHAznfpU6R3JcWp3tGpL7V0yr8bSjDF2GwCLUQ
 MwHPJSza6pRm9g6AFswdxfav67sw6G0oTOsODWZOeu4P+tOk0hsyBbbz8 o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Feb 2020 16:41:01 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg05-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:41:01 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id F0D9E1BB2; Mon, 10 Feb 2020 18:41:00 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 38/66] Hexagon TCG generation - step 01
Date: Mon, 10 Feb 2020 18:40:16 -0600
Message-Id: <1581381644-13678-39-git-send-email-tsimpson@quicinc.com>
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

SW5jbHVkZSB0aGUgZ2VuZXJhdGVkIGZpbGVzIGFuZCBzZXQgdXAgdGhlIGRhdGEgc3RydWN0dXJl
cwoKU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jIHwgNjAgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vZ2VucHRyLmggfCAyNSAr
KysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgODUgaW5zZXJ0aW9ucygrKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jCiBjcmVhdGUgbW9kZSAx
MDA2NDQgdGFyZ2V0L2hleGFnb24vZ2VucHRyLmgKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9nZW5wdHIuYyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDAwMDAwMDAuLjJhNTBiZTAKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdv
bi9nZW5wdHIuYwpAQCAtMCwwICsxLDYwIEBACisvKgorICogIENvcHlyaWdodCAoYykgMjAxOSBR
dWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorICoK
KyAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUg
aXQgYW5kL29yIG1vZGlmeQorICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisgKiAgdGhlIEZyZWUgU29mdHdhcmUg
Rm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqICAoYXQg
eW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMg
ZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQg
V0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBv
ZgorICogIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9T
RS4gIFNlZSB0aGUKKyAqICBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRh
aWxzLgorICoKKyAqICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBu
b3QsIHNlZSA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uCisgKi8KKworI2luY2x1ZGUg
PHN0ZGlvLmg+CisjZGVmaW5lIFFFTVVfR0VORVJBVEUKKyNpbmNsdWRlICJxZW11L29zZGVwLmgi
CisjaW5jbHVkZSAicWVtdS9sb2cuaCIKKyNpbmNsdWRlICJjcHUuaCIKKyNpbmNsdWRlICJpbnRl
cm5hbC5oIgorI2luY2x1ZGUgInRjZy90Y2ctb3AuaCIKKyNpbmNsdWRlICJpbnNuLmgiCisjaW5j
bHVkZSAib3Bjb2Rlcy5oIgorI2luY2x1ZGUgInRyYW5zbGF0ZS5oIgorI2luY2x1ZGUgIm1hY3Jv
cy5oIgorI2luY2x1ZGUgImdlbnB0cl9oZWxwZXJzLmgiCisKKyNpbmNsdWRlICJxZW11X3dyYXBf
Z2VuZXJhdGVkLmgiCisKKyNkZWZpbmUgREVGX1FFTVUoVEFHLCBTSE9SVENPREUsIEhFTFBFUiwg
R0VORk4sIEhFTFBGTikgXAorc3RhdGljIHZvaWQgZ2VuZXJhdGVfIyNUQUcoQ1BVSGV4YWdvblN0
YXRlICplbnYsIERpc2FzQ29udGV4dCAqY3R4LCBcCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpbnNuX3QgKmluc24pIFwKK3sgXAorICAgIEdFTkZOIFwKK30KKyNpbmNsdWRlICJxZW11X2Rl
Zl9nZW5lcmF0ZWQuaCIKKyN1bmRlZiBERUZfUUVNVQorCisKKy8qIEZpbGwgaW4gdGhlIHRhYmxl
IHdpdGggTlVMTHMgYmVjYXVzZSBub3QgYWxsIHRoZSBvcGNvZGVzIGhhdmUgREVGX1FFTVUgKi8K
K3NlbWFudGljX2luc25fdCBvcGNvZGVfZ2VucHRyW10gPSB7CisjZGVmaW5lIE9QQ09ERShYKSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwKKyNpbmNsdWRlICJvcGNvZGVzX2RlZl9n
ZW5lcmF0ZWQuaCIKKyAgICBOVUxMCisjdW5kZWYgT1BDT0RFCit9OworCisvKiBUaGlzIGZ1bmN0
aW9uIG92ZXJ3cml0ZXMgdGhlIE5VTEwgZW50cmllcyB3aGVyZSB3ZSBoYXZlIGEgREVGX1FFTVUg
Ki8KK3ZvaWQgaW5pdF9nZW5wdHIodm9pZCkKK3sKKyNkZWZpbmUgREVGX1FFTVUoVEFHLCBTSE9S
VENPREUsIEhFTFBFUiwgR0VORk4sIEhFTFBGTikgXAorICAgIG9wY29kZV9nZW5wdHJbVEFHXSA9
IGdlbmVyYXRlXyMjVEFHOworI2luY2x1ZGUgInFlbXVfZGVmX2dlbmVyYXRlZC5oIgorI3VuZGVm
IERFRl9RRU1VCit9CisKKwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmggYi90
YXJnZXQvaGV4YWdvbi9nZW5wdHIuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAw
Li5mMTc4ZjcyCi0tLSAvZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmgKQEAg
LTAsMCArMSwyNSBAQAorLyoKKyAqICBDb3B5cmlnaHQgKGMpIDIwMTkgUXVhbGNvbW0gSW5ub3Zh
dGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KKyAqCisgKiAgVGhpcyBwcm9n
cmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2Rp
ZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlIGFzIHB1Ymxpc2hlZCBieQorICogIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVp
dGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAgKGF0IHlvdXIgb3B0aW9uKSBh
bnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGlu
IHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgYnV0IFdJVEhPVVQgQU5ZIFdB
UlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICBNRVJDSEFO
VEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCisg
KiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiAg
WW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UKKyAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCBzZWUgPGh0dHA6
Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+LgorICovCisKKyNpZm5kZWYgR0VOUFRSX0gKKyNkZWZp
bmUgR0VOUFRSX0gKKworI2luY2x1ZGUgImluc24uaCIKKworZXh0ZXJuIHNlbWFudGljX2luc25f
dCBvcGNvZGVfZ2VucHRyW107CisKKyNlbmRpZgotLSAKMi43LjQKCg==

