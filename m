Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39397C352A5
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064FA20848
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OrNUj7fx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064FA20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1JnF-0002tx-50
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 19:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1JcG-0001WM-GJ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1JcE-0006kP-MK
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:28 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:3639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1JcE-0004qc-6V
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381686; x=1612917686;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hmUwGsjfs3Bwk+Uq+fzFQ17/HB9Dq7FWJSLAx39UD4o=;
 b=OrNUj7fxvqrP0IImmA0xKGVZwhHvu1fiOAAw6TQpJ0YeRDt8GbgJHlc7
 GeaQeOipyex0rfcQaFDvw8zRwX8GM0fi4zLkr4nxI23bTID1FcPaSlyXD
 1eSZyYII+3Oi7vhuhl94rUIdIChZ82qAyx1sLLi9pbg4Z9GLb299HyRcZ s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Feb 2020 16:41:01 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg03-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:41:00 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id C69571B76; Mon, 10 Feb 2020 18:41:00 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 36/66] Hexagon TCG generation helpers - step 4
Date: Mon, 10 Feb 2020 18:40:14 -0600
Message-Id: <1581381644-13678-37-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
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

SGVscGVycyByZWZlcmVuY2VkIGluIG1hY3Jvcy5oCgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2lt
cHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vZ2VucHRyX2hl
bHBlcnMuaCB8IDY3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAx
IGZpbGUgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2dlbnB0cl9oZWxwZXJzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5wdHJfaGVscGVycy5oCmlu
ZGV4IDI3Zjk2NWEuLjg1YjQ0OWEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbnB0cl9o
ZWxwZXJzLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyX2hlbHBlcnMuaApAQCAtNDQ5LDQg
KzQ0OSw3MSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX3N0b3JlOGkoVENHdl9lbnYgY3B1X2Vu
diwgVENHdiB2YWRkciwgaW50NjRfdCBzcmMsCiAgICAgdGNnX3RlbXBfZnJlZV9pNjQodG1wKTsK
IH0KIAorc3RhdGljIGlubGluZSBUQ0d2X2k2NCBnZW5fY2FycnlfZnJvbV9hZGQ2NChUQ0d2X2k2
NCByZXN1bHQsIFRDR3ZfaTY0IGEsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFRDR3ZfaTY0IGIsIFRDR3ZfaTY0IGMpCit7CisgICAgVENHdl9pNjQgV09SRCA9
IHRjZ190ZW1wX25ld19pNjQoKTsKKyAgICBUQ0d2X2k2NCB0bXBhID0gdGNnX3RlbXBfbmV3X2k2
NCgpOworICAgIFRDR3ZfaTY0IHRtcGIgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7CisgICAgVENHdl9p
NjQgdG1wYyA9IHRjZ190ZW1wX25ld19pNjQoKTsKKworICAgIHRjZ19nZW5fbW92X2k2NCh0bXBh
LCBmR0VUVVdPUkQoMCwgYSkpOworICAgIHRjZ19nZW5fbW92X2k2NCh0bXBiLCBmR0VUVVdPUkQo
MCwgYikpOworICAgIHRjZ19nZW5fYWRkX2k2NCh0bXBjLCB0bXBhLCB0bXBiKTsKKyAgICB0Y2df
Z2VuX2FkZF9pNjQodG1wYywgdG1wYywgYyk7CisgICAgdGNnX2dlbl9tb3ZfaTY0KHRtcGEsIGZH
RVRVV09SRCgxLCBhKSk7CisgICAgdGNnX2dlbl9tb3ZfaTY0KHRtcGIsIGZHRVRVV09SRCgxLCBi
KSk7CisgICAgdGNnX2dlbl9hZGRfaTY0KHRtcGMsIHRtcGEsIHRtcGIpOworICAgIHRjZ19nZW5f
YWRkX2k2NCh0bXBjLCB0bXBjLCBmR0VUVVdPUkQoMSwgdG1wYykpOworICAgIHRjZ19nZW5fbW92
X2k2NChyZXN1bHQsIGZHRVRVV09SRCgxLCB0bXBjKSk7CisKKyAgICB0Y2dfdGVtcF9mcmVlX2k2
NChXT1JEKTsKKyAgICB0Y2dfdGVtcF9mcmVlX2k2NCh0bXBhKTsKKyAgICB0Y2dfdGVtcF9mcmVl
X2k2NCh0bXBiKTsKKyAgICB0Y2dfdGVtcF9mcmVlX2k2NCh0bXBjKTsKKyAgICByZXR1cm4gcmVz
dWx0OworfQorCitzdGF0aWMgaW5saW5lIFRDR3YgZ2VuXzhiaXRzb2YoVENHdiByZXN1bHQsIFRD
R3YgdmFsdWUpCit7CisgICAgVENHdiB6ZXJvID0gdGNnX2NvbnN0X3RsKDApOworICAgIFRDR3Yg
b25lcyA9IHRjZ19jb25zdF90bCgweGZmKTsKKyAgICB0Y2dfZ2VuX21vdmNvbmRfdGwoVENHX0NP
TkRfTkUsIHJlc3VsdCwgdmFsdWUsIHplcm8sIG9uZXMsIHplcm8pOworICAgIHRjZ190ZW1wX2Zy
ZWUoemVybyk7CisgICAgdGNnX3RlbXBfZnJlZShvbmVzKTsKKworICAgIHJldHVybiByZXN1bHQ7
Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBnZW5fd3JpdGVfbmV3X3BjKFRDR3YgYWRkcikKK3sK
KyAgICAvKiBJZiB0aGVyZSBhcmUgbXVsdGlwbGUgYnJhbmNoZXMgaW4gYSBwYWNrZXQsIGlnbm9y
ZSB0aGUgc2Vjb25kIG9uZSAqLworICAgIFRDR3YgemVybyA9IHRjZ19jb25zdF90bCgwKTsKKyAg
ICB0Y2dfZ2VuX21vdmNvbmRfdGwoVENHX0NPTkRfTkUsIGhleF9uZXh0X1BDLCBoZXhfYnJhbmNo
X3Rha2VuLCB6ZXJvLAorICAgICAgICAgICAgICAgICAgICAgICBoZXhfbmV4dF9QQywgYWRkcik7
CisgICAgdGNnX2dlbl9tb3ZpX3RsKGhleF9icmFuY2hfdGFrZW4sIDEpOworICAgIHRjZ190ZW1w
X2ZyZWUoemVybyk7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBnZW5fc2V0X3Vzcl9maWVsZChp
bnQgZmllbGQsIFRDR3YgdmFsKQoreworICAgIHRjZ19nZW5fZGVwb3NpdF90bChoZXhfZ3ByW0hF
WF9SRUdfVVNSXSwgaGV4X2dwcltIRVhfUkVHX1VTUl0sIHZhbCwKKyAgICAgICAgICAgICAgICAg
ICAgICAgcmVnX2ZpZWxkX2luZm9bZmllbGRdLm9mZnNldCwKKyAgICAgICAgICAgICAgICAgICAg
ICAgcmVnX2ZpZWxkX2luZm9bZmllbGRdLndpZHRoKTsKK30KKworc3RhdGljIGlubGluZSB2b2lk
IGdlbl9zZXRfdXNyX2ZpZWxkaShpbnQgZmllbGQsIGludCB4KQoreworICAgIFRDR3YgdmFsID0g
dGNnX2NvbnN0X3RsKHgpOworICAgIGdlbl9zZXRfdXNyX2ZpZWxkKGZpZWxkLCB2YWwpOworICAg
IHRjZ190ZW1wX2ZyZWUodmFsKTsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGdlbl9jb25kX3Jl
dHVybihUQ0d2IHByZWQsIFRDR3YgYWRkcikKK3sKKyAgICBUQ0d2IHplcm8gPSB0Y2dfY29uc3Rf
dGwoMCk7CisgICAgdGNnX2dlbl9tb3Zjb25kX3RsKFRDR19DT05EX05FLCBoZXhfbmV4dF9QQywg
cHJlZCwgemVybywgYWRkciwgaGV4X25leHRfUEMpOworICAgIHRjZ190ZW1wX2ZyZWUoemVybyk7
Cit9CisKICNlbmRpZgotLSAKMi43LjQKCg==

