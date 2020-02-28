Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259A3C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4586246A3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l5vgXObC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4586246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jGk-0004vu-2I
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ilz-0005Ye-Ob
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:46:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ily-000789-9h
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:45:59 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:13250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j7ilY-0005Uz-Cm
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1582908332; x=1614444332;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KQWwecL0juULl+95H12fiqchUykDtC83+dBOk8X6UD0=;
 b=l5vgXObCBvYR23roAkCDLUb4ysCVbPmct8sr1UB/4xwHc5ccPdR+IYPQ
 mX8RzlPBDZ9YQNCeR+vEdWi5jgm4aHSUXFuqeQ3ffoqiMeJG2MkpfOw1v
 mEuk8mZ5154v98emuaV0qnBY6stIIi/bDKz/R0UrK/ky+XiLnsEP/WriH 8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Feb 2020 08:44:32 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg05-sd.qualcomm.com with ESMTP; 28 Feb 2020 08:44:31 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 31BDFF0B; Fri, 28 Feb 2020 10:44:31 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 39/67] Hexagon TCG generation - step 01
Date: Fri, 28 Feb 2020 10:43:35 -0600
Message-Id: <1582908244-304-40-git-send-email-tsimpson@quicinc.com>
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

SW5jbHVkZSB0aGUgZ2VuZXJhdGVkIGZpbGVzIGFuZCBzZXQgdXAgdGhlIGRhdGEgc3RydWN0dXJl
cwoKU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5oIHwgMjUgKysrKysrKysrKysrKysrKysrKysrCiB0
YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyB8IDU5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgODQgaW5zZXJ0aW9ucygrKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2dlbnB0ci5oCiBjcmVhdGUgbW9kZSAx
MDA2NDQgdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9nZW5wdHIuaCBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDAwMDAwMDAuLmEzYTNkYjEKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdv
bi9nZW5wdHIuaApAQCAtMCwwICsxLDI1IEBACisvKgorICogIENvcHlyaWdodChjKSAyMDE5LTIw
MjAgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4K
KyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorICogIHRoZSBGcmVlIFNvZnR3
YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAg
KGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiAgVGhpcyBwcm9ncmFt
IGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAg
YnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFu
dHkgb2YKKyAqICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBV
UlBPU0UuICBTZWUgdGhlCisgKiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUg
ZGV0YWlscy4KKyAqCisgKiAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUg
R05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsg
aWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+LgorICovCisKKyNpZm5k
ZWYgSEVYQUdPTl9HRU5QVFJfSAorI2RlZmluZSBIRVhBR09OX0dFTlBUUl9ICisKKyNpbmNsdWRl
ICJpbnNuLmgiCisKK2V4dGVybiBzZW1hbnRpY19pbnNuX3Qgb3Bjb2RlX2dlbnB0cltdOworCisj
ZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jIGIvdGFyZ2V0L2hleGFn
b24vZ2VucHRyLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uNWE2MDJiZAot
LS0gL2Rldi9udWxsCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCkBAIC0wLDAgKzEsNTkg
QEAKKy8qCisgKiAgQ29weXJpZ2h0KGMpIDIwMTktMjAyMCBRdWFsY29tbSBJbm5vdmF0aW9uIENl
bnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMg
ZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICog
IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMg
cHVibGlzaGVkIGJ5CisgKiAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZl
cnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRl
ciB2ZXJzaW9uLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhv
cGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7
IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJTElU
WSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqICBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZb3Ugc2hv
dWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZQorICogIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHNlZSA8aHR0cDovL3d3dy5n
bnUub3JnL2xpY2Vuc2VzLz4uCisgKi8KKworI2RlZmluZSBRRU1VX0dFTkVSQVRFCisjaW5jbHVk
ZSAicWVtdS9vc2RlcC5oIgorI2luY2x1ZGUgInFlbXUvbG9nLmgiCisjaW5jbHVkZSAiY3B1Lmgi
CisjaW5jbHVkZSAiaW50ZXJuYWwuaCIKKyNpbmNsdWRlICJ0Y2cvdGNnLW9wLmgiCisjaW5jbHVk
ZSAiaW5zbi5oIgorI2luY2x1ZGUgIm9wY29kZXMuaCIKKyNpbmNsdWRlICJ0cmFuc2xhdGUuaCIK
KyNpbmNsdWRlICJtYWNyb3MuaCIKKyNpbmNsdWRlICJnZW5wdHJfaGVscGVycy5oIgorCisjaW5j
bHVkZSAicWVtdV93cmFwX2dlbmVyYXRlZC5oIgorCisjZGVmaW5lIERFRl9RRU1VKFRBRywgU0hP
UlRDT0RFLCBIRUxQRVIsIEdFTkZOLCBIRUxQRk4pIFwKK3N0YXRpYyB2b2lkIGdlbmVyYXRlXyMj
VEFHKENQVUhleGFnb25TdGF0ZSAqZW52LCBEaXNhc0NvbnRleHQgKmN0eCwgXAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaW5zbl90ICppbnNuKSBcCit7IFwKKyAgICBHRU5GTiBcCit9Cisj
aW5jbHVkZSAicWVtdV9kZWZfZ2VuZXJhdGVkLmgiCisjdW5kZWYgREVGX1FFTVUKKworCisvKiBG
aWxsIGluIHRoZSB0YWJsZSB3aXRoIE5VTExzIGJlY2F1c2Ugbm90IGFsbCB0aGUgb3Bjb2RlcyBo
YXZlIERFRl9RRU1VICovCitzZW1hbnRpY19pbnNuX3Qgb3Bjb2RlX2dlbnB0cltdID0geworI2Rl
ZmluZSBPUENPREUoWCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMCisjaW5jbHVk
ZSAib3Bjb2Rlc19kZWZfZ2VuZXJhdGVkLmgiCisgICAgTlVMTAorI3VuZGVmIE9QQ09ERQorfTsK
KworLyogVGhpcyBmdW5jdGlvbiBvdmVyd3JpdGVzIHRoZSBOVUxMIGVudHJpZXMgd2hlcmUgd2Ug
aGF2ZSBhIERFRl9RRU1VICovCit2b2lkIGluaXRfZ2VucHRyKHZvaWQpCit7CisjZGVmaW5lIERF
Rl9RRU1VKFRBRywgU0hPUlRDT0RFLCBIRUxQRVIsIEdFTkZOLCBIRUxQRk4pIFwKKyAgICBvcGNv
ZGVfZ2VucHRyW1RBR10gPSBnZW5lcmF0ZV8jI1RBRzsKKyNpbmNsdWRlICJxZW11X2RlZl9nZW5l
cmF0ZWQuaCIKKyN1bmRlZiBERUZfUUVNVQorfQorCisKLS0gCjIuNy40Cgo=

