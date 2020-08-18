Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A69C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2022080C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Let4h30t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2022080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83z3-00010L-A3
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83tD-0006QZ-78
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:07 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:55154)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83t7-0005rj-BN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1597765861; x=1629301861;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8nd5viD+HzYZKsc4W9p+p3Elrd7OLPtuiBz1vW1zvSg=;
 b=Let4h30tixt4Zs1pFKkl1Op8/ZGQkOKpAmpGhLp7kCDISVqSXSNc5ZJw
 PHQBNxbn2/YUPCLSP7ToAzhxLyY62BnKEfeW19FsP00qPqBsQg2cUVOdL
 2bTexz54ykPmQKitst6J5lpwRXSs+2FLzKc0QsJo8wq8/98NmPZEKh9cq 8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Aug 2020 08:50:57 -0700
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP; 18 Aug 2020 08:50:56 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id EDD1018D8; Tue, 18 Aug 2020 10:50:55 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 08/34] Hexagon (target/hexagon) GDB Stub
Date: Tue, 18 Aug 2020 10:50:21 -0500
Message-Id: <1597765847-16637-9-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=199.106.114.38;
 envelope-from=tsimpson@qualcomm.com; helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 11:48:34
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

R0RCIHJlZ2lzdGVyIHJlYWQgYW5kIHdyaXRlIHJvdXRpbmVzCgpTaWduZWQtb2ZmLWJ5OiBUYXls
b3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaW50
ZXJuYWwuaCB8ICAyICsrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgIHwgIDIgKysKIHRhcmdl
dC9oZXhhZ29uL2dkYnN0dWIuYyAgfCA0OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vZ2Ric3R1Yi5jCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vaW50ZXJuYWwuaCBiL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmgKaW5kZXgg
ZDNlNDQxMi4uYWNkZGQ5MSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaAor
KysgYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCkBAIC0zNyw0ICszNyw2IEBAIGV4dGVybiBj
b25zdCBjaGFyICogY29uc3QgaGV4YWdvbl9yZWduYW1lc1tUT1RBTF9QRVJfVEhSRUFEX1JFR1Nd
OwogCiBleHRlcm4gdm9pZCBpbml0X2dlbnB0cih2b2lkKTsKIAorZXh0ZXJuIGludCBoZXhhZ29u
X2dkYl9yZWFkX3JlZ2lzdGVyKENQVVN0YXRlICpjcHUsIEdCeXRlQXJyYXkgKmJ1ZiwgaW50IHJl
Zyk7CitleHRlcm4gaW50IGhleGFnb25fZ2RiX3dyaXRlX3JlZ2lzdGVyKENQVVN0YXRlICpjcHUs
IHVpbnQ4X3QgKmJ1ZiwgaW50IHJlZyk7CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggZDgxMjkxMy4uZTJjODc5YyAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1
LmMKQEAgLTI4NCw2ICsyODQsOCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9jbGFzc19pbml0
KE9iamVjdENsYXNzICpjLCB2b2lkICpkYXRhKQogICAgIGNjLT5kdW1wX3N0YXRlID0gaGV4YWdv
bl9kdW1wX3N0YXRlOwogICAgIGNjLT5zZXRfcGMgPSBoZXhhZ29uX2NwdV9zZXRfcGM7CiAgICAg
Y2MtPnN5bmNocm9uaXplX2Zyb21fdGIgPSBoZXhhZ29uX2NwdV9zeW5jaHJvbml6ZV9mcm9tX3Ri
OworICAgIGNjLT5nZGJfcmVhZF9yZWdpc3RlciA9IGhleGFnb25fZ2RiX3JlYWRfcmVnaXN0ZXI7
CisgICAgY2MtPmdkYl93cml0ZV9yZWdpc3RlciA9IGhleGFnb25fZ2RiX3dyaXRlX3JlZ2lzdGVy
OwogICAgIGNjLT5nZGJfbnVtX2NvcmVfcmVncyA9IFRPVEFMX1BFUl9USFJFQURfUkVHUzsKICAg
ICBjYy0+Z2RiX3N0b3BfYmVmb3JlX3dhdGNocG9pbnQgPSB0cnVlOwogICAgIGNjLT5kaXNhc19z
ZXRfaW5mbyA9IGhleGFnb25fY3B1X2Rpc2FzX3NldF9pbmZvOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vZ2Ric3R1Yi5jIGIvdGFyZ2V0L2hleGFnb24vZ2Ric3R1Yi5jCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLmEyZWE1MjgKLS0tIC9kZXYvbnVsbAorKysgYi90YXJn
ZXQvaGV4YWdvbi9nZGJzdHViLmMKQEAgLTAsMCArMSw0OSBAQAorLyoKKyAqICBDb3B5cmlnaHQo
YykgMjAxOS0yMDIwIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMg
UmVzZXJ2ZWQuCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2Fu
IHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9m
IHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyAqICB0aGUg
RnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNl
LCBvcgorICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisgKgorICogIFRo
aXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNl
ZnVsLAorICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBs
aWVkIHdhcnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFS
VElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IGZvciBtb3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNv
cHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxvbmcgd2l0aCB0aGlz
IHByb2dyYW07IGlmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4KKyAq
LworCisjaW5jbHVkZSAicWVtdS9vc2RlcC5oIgorI2luY2x1ZGUgInFlbXUtY29tbW9uLmgiCisj
aW5jbHVkZSAiZXhlYy9nZGJzdHViLmgiCisjaW5jbHVkZSAiY3B1LmgiCisjaW5jbHVkZSAiaW50
ZXJuYWwuaCIKKworaW50IGhleGFnb25fZ2RiX3JlYWRfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNzLCBH
Qnl0ZUFycmF5ICptZW1fYnVmLCBpbnQgbikKK3sKKyAgICBIZXhhZ29uQ1BVICpjcHUgPSBIRVhB
R09OX0NQVShjcyk7CisgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSAmY3B1LT5lbnY7CisKKyAg
ICBpZiAobiA8IFRPVEFMX1BFUl9USFJFQURfUkVHUykgeworICAgICAgICByZXR1cm4gZ2RiX2dl
dF9yZWdsKG1lbV9idWYsIGVudi0+Z3ByW25dKTsKKyAgICB9CisKKyAgICBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOworICAgIHJldHVybiAwOworfQorCitpbnQgaGV4YWdvbl9nZGJfd3JpdGVfcmVn
aXN0ZXIoQ1BVU3RhdGUgKmNzLCB1aW50OF90ICptZW1fYnVmLCBpbnQgbikKK3sKKyAgICBIZXhh
Z29uQ1BVICpjcHUgPSBIRVhBR09OX0NQVShjcyk7CisgICAgQ1BVSGV4YWdvblN0YXRlICplbnYg
PSAmY3B1LT5lbnY7CisKKyAgICBpZiAobiA8IFRPVEFMX1BFUl9USFJFQURfUkVHUykgeworICAg
ICAgICBlbnYtPmdwcltuXSA9IGxkdHVsX3AobWVtX2J1Zik7CisgICAgICAgIHJldHVybiBzaXpl
b2YodGFyZ2V0X3Vsb25nKTsKKyAgICB9CisKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwor
ICAgIHJldHVybiAwOworfQotLSAKMi43LjQKCg==

