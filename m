Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7F4C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F852080C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WNzJxc4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F852080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83xq-00075M-Ry
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83tE-0006UC-NF
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:08 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:12941)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83tB-0005sP-Ij
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1597765865; x=1629301865;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s1u8JQbARlfH+H2WTQJPfQbDWHNxdrb8HeOG7yyYTC0=;
 b=WNzJxc4wta4+dDwwuFOOJFFBPdL6IawUrWfdkfG0XHeopGOnXKI5GNgA
 ByYUZKZ3z0AQeDBoVDVXCF8O3Y/pHf/q7ALaKnQMpkXJBcuYAVCviWcx7
 fswZuvcSp512EX+iP1oktBCeNb8n1tSEJEB2TmozMdPCzGfvCGOC5zgm7 o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Aug 2020 08:50:57 -0700
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg01-sd.qualcomm.com with ESMTP; 18 Aug 2020 08:50:56 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id B94681737; Tue, 18 Aug 2020 10:50:55 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 06/34] Hexagon (disas) disassembler
Date: Tue, 18 Aug 2020 10:50:19 -0500
Message-Id: <1597765847-16637-7-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=199.106.114.39;
 envelope-from=tsimpson@qualcomm.com; helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 11:50:57
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: ale@rev.ng, riku.voipio@iki.fi, richard.henderson@linaro.org,
 laurent@vivier.eu, tsimpson@quicinc.com, philmd@redhat.com,
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
aXMtYXNtLmggYi9pbmNsdWRlL2Rpc2FzL2Rpcy1hc20uaAppbmRleCA5ODU2YmY3Li4xNGZmMmJl
IDEwMDY0NAotLS0gYS9pbmNsdWRlL2Rpc2FzL2Rpcy1hc20uaAorKysgYi9pbmNsdWRlL2Rpc2Fz
L2Rpcy1hc20uaApAQCAtNDYwLDYgKzQ2MCw3IEBAIGludCBwcmludF9pbnNuX3h0ZW5zYSAgICAg
ICAgICAgKGJmZF92bWEsIGRpc2Fzc2VtYmxlX2luZm8qKTsKIGludCBwcmludF9pbnNuX3Jpc2N2
MzIgICAgICAgICAgKGJmZF92bWEsIGRpc2Fzc2VtYmxlX2luZm8qKTsKIGludCBwcmludF9pbnNu
X3Jpc2N2NjQgICAgICAgICAgKGJmZF92bWEsIGRpc2Fzc2VtYmxlX2luZm8qKTsKIGludCBwcmlu
dF9pbnNuX3J4KGJmZF92bWEsIGRpc2Fzc2VtYmxlX2luZm8gKik7CitpbnQgcHJpbnRfaW5zbl9o
ZXhhZ29uKGJmZF92bWEsIGRpc2Fzc2VtYmxlX2luZm8gKik7CiAKICNpZiAwCiAvKiBGZXRjaCB0
aGUgZGlzYXNzZW1ibGVyIGZvciBhIGdpdmVuIEJGRCwgaWYgdGhhdCBzdXBwb3J0IGlzIGF2YWls
YWJsZS4gICovCmRpZmYgLS1naXQgYS9kaXNhcy9oZXhhZ29uLmMgYi9kaXNhcy9oZXhhZ29uLmMK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uNmVlODY1MwotLS0gL2Rldi9udWxs
CisrKyBiL2Rpc2FzL2hleGFnb24uYwpAQCAtMCwwICsxLDYyIEBACisvKgorICogIENvcHlyaWdo
dChjKSAyMDE5LTIwMjAgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0
cyBSZXNlcnZlZC4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBj
YW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorICogIHRo
ZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vu
c2UsIG9yCisgKiAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiAg
VGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1
c2VmdWwsCisgKiAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGlt
cGxpZWQgd2FycmFudHkgb2YKKyAqICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQ
QVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCisgKiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEg
Y29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqICBhbG9uZyB3aXRoIHRo
aXMgcHJvZ3JhbTsgaWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+Lgor
ICovCisKKy8qCisgKiBRRU1VIEhleGFnb24gRGlzYXNzZW1ibGVyCisgKi8KKworI2luY2x1ZGUg
InFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJkaXNhcy9kaXMtYXNtLmgiCisjaW5jbHVkZSAidGFy
Z2V0L2hleGFnb24vY3B1X2JpdHMuaCIKKworLyoKKyAqIFdlIHdpbGwgZGlzYXNzZW1ibGUgYSBw
YWNrZXQgd2l0aCB1cCB0byA0IGluc3RydWN0aW9ucywgc28gd2UgbmVlZAorICogYSBoZWZ0eSBz
aXplIGJ1ZmZlci4KKyAqLworI2RlZmluZSBQQUNLRVRfQlVGRkVSX0xFTiAgICAgICAgICAgICAg
ICAgICAxMDI4CisKK2ludCBwcmludF9pbnNuX2hleGFnb24oYmZkX3ZtYSBtZW1hZGRyLCBzdHJ1
Y3QgZGlzYXNzZW1ibGVfaW5mbyAqaW5mbykKK3sKKyAgICB1aW50MzJfdCB3b3Jkc1tQQUNLRVRf
V09SRFNfTUFYXTsKKyAgICBpbnQgbGVuLCBzbGVuOworICAgIGNoYXIgYnVmW1BBQ0tFVF9CVUZG
RVJfTEVOXTsKKyAgICBpbnQgc3RhdHVzOworICAgIGludCBpOworCisgICAgZm9yIChpID0gMDsg
aSA8IFBBQ0tFVF9XT1JEU19NQVg7IGkrKykgeworICAgICAgICBzdGF0dXMgPSAoKmluZm8tPnJl
YWRfbWVtb3J5X2Z1bmMpKG1lbWFkZHIgKyBpICogc2l6ZW9mKHVpbnQzMl90KSwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoYmZkX2J5dGUgKikmd29yZHNbaV0s
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHVpbnQz
Ml90KSwgaW5mbyk7CisgICAgICAgIGlmIChzdGF0dXMpIHsKKyAgICAgICAgICAgIGlmIChpID4g
MCkgeworICAgICAgICAgICAgICAgIGJyZWFrOworICAgICAgICAgICAgfQorICAgICAgICAgICAg
KCppbmZvLT5tZW1vcnlfZXJyb3JfZnVuYykoc3RhdHVzLCBtZW1hZGRyLCBpbmZvKTsKKyAgICAg
ICAgICAgIHJldHVybiBzdGF0dXM7CisgICAgICAgIH0KKyAgICB9CisKKyAgICBsZW4gPSBkaXNh
c3NlbWJsZV9oZXhhZ29uKHdvcmRzLCBpLCBidWYsIFBBQ0tFVF9CVUZGRVJfTEVOKTsKKyAgICBz
bGVuID0gc3RybGVuKGJ1Zik7CisgICAgaWYgKGJ1ZltzbGVuIC0gMV0gPT0gJ1xuJykgeworICAg
ICAgICBidWZbc2xlbiAtIDFdID0gJ1wwJzsKKyAgICB9CisgICAgKCppbmZvLT5mcHJpbnRmX2Z1
bmMpKGluZm8tPnN0cmVhbSwgIiVzIiwgYnVmKTsKKworICAgIHJldHVybiBsZW47Cit9CisKZGlm
ZiAtLWdpdCBhL2Rpc2FzL01ha2VmaWxlLm9ianMgYi9kaXNhcy9NYWtlZmlsZS5vYmpzCmluZGV4
IDNjMWNkY2UuLjBlODY5NjQgMTAwNjQ0Ci0tLSBhL2Rpc2FzL01ha2VmaWxlLm9ianMKKysrIGIv
ZGlzYXMvTWFrZWZpbGUub2JqcwpAQCAtMjQsNiArMjQsNyBAQCBjb21tb24tb2JqLSQoQ09ORklH
X1NINF9ESVMpICs9IHNoNC5vCiBjb21tb24tb2JqLSQoQ09ORklHX1NQQVJDX0RJUykgKz0gc3Bh
cmMubwogY29tbW9uLW9iai0kKENPTkZJR19MTTMyX0RJUykgKz0gbG0zMi5vCiBjb21tb24tb2Jq
LSQoQ09ORklHX1hURU5TQV9ESVMpICs9IHh0ZW5zYS5vCitjb21tb24tb2JqLSQoQ09ORklHX0hF
WEFHT05fRElTKSArPSBoZXhhZ29uLm8KIAogIyBUT0RPOiBBcyBsb25nIGFzIHRoZSBUQ0cgaW50
ZXJwcmV0ZXIgYW5kIGl0cyBnZW5lcmF0ZWQgY29kZSBkZXBlbmQKICMgb24gdGhlIFFFTVUgdGFy
Z2V0LCB3ZSBjYW5ub3QgY29tcGlsZSB0aGUgZGlzYXNzZW1ibGVyIGhlcmUuCi0tIAoyLjcuNAoK

