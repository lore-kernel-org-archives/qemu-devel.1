Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6E3C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28681246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="zR1fP3j4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28681246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jRt-0007bh-91
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ilJ-0004EK-NF
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:45:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ilI-0006Pi-Em
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:45:17 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j7ikw-0005V5-8R
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1582908294; x=1614444294;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OxyAc5vby+TObY6b7PeXziCqzZoxlQP+3+9J1vLPfv8=;
 b=zR1fP3j49/iWhcvSwI1njVdVVBKhCaqS/EWxr73ydq7dY9ZNp5TF25ZE
 plNaaEig/JicXTWSgjEhbQxPtM7MmKztlJcHmd32Aqz83j+jqd5gYZQYn
 HJXRJORmvbxFmLUAqeDzYY/gwJfcDoHzACpUR2WaMBDnjzjfLdqVnNMUm s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Feb 2020 08:44:32 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg04-sd.qualcomm.com with ESMTP; 28 Feb 2020 08:44:31 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id E6C6A1191; Fri, 28 Feb 2020 10:44:30 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 36/67] Hexagon TCG generation helpers - step 3
Date: Fri, 28 Feb 2020 10:43:32 -0600
Message-Id: <1582908244-304-37-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
References: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
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

SGVscGVycyBmb3Igc3RvcmUgaW5zdHJ1Y3Rpb25zCgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2lt
cHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vZ2VucHRyX2hl
bHBlcnMuaCB8IDc3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAx
IGZpbGUgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2dlbnB0cl9oZWxwZXJzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5wdHJfaGVscGVycy5oCmlu
ZGV4IGMwZTRjMzkuLjBlMmQ3YjkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbnB0cl9o
ZWxwZXJzLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyX2hlbHBlcnMuaApAQCAtMzg2LDQg
KzM4Niw4MSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX3N0b3JlX2NvbmRpdGlvbmFsOChDUFVI
ZXhhZ29uU3RhdGUgKmVudiwKICAgICB0Y2dfdGVtcF9mcmVlKHRtcCk7CiB9CiAKK3N0YXRpYyBp
bmxpbmUgdm9pZCBnZW5fc3RvcmUzMihUQ0d2IHZhZGRyLCBUQ0d2IHNyYywgaW50IHdpZHRoLCBp
bnQgc2xvdCkKK3sKKyAgICB0Y2dfZ2VuX21vdl90bChoZXhfc3RvcmVfYWRkcltzbG90XSwgdmFk
ZHIpOworICAgIHRjZ19nZW5fbW92aV90bChoZXhfc3RvcmVfd2lkdGhbc2xvdF0sIHdpZHRoKTsK
KyAgICB0Y2dfZ2VuX21vdl90bChoZXhfc3RvcmVfdmFsMzJbc2xvdF0sIHNyYyk7Cit9CisKK3N0
YXRpYyBpbmxpbmUgdm9pZCBnZW5fc3RvcmUxKFRDR3ZfZW52IGNwdV9lbnYsIFRDR3YgdmFkZHIs
IFRDR3Ygc3JjLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRGlzYXNDb250ZXh0ICpj
dHgsIGludCBzbG90KQoreworICAgIFRDR3YgdG1wID0gdGNnX2NvbnN0X3RsKHNsb3QpOworICAg
IGdlbl9zdG9yZTMyKHZhZGRyLCBzcmMsIDEsIHNsb3QpOworICAgIHRjZ190ZW1wX2ZyZWUodG1w
KTsKKyAgICBjdHgtPmN0eF9zdG9yZV93aWR0aFtzbG90XSA9IDE7Cit9CisKK3N0YXRpYyBpbmxp
bmUgdm9pZCBnZW5fc3RvcmUxaShUQ0d2X2VudiBjcHVfZW52LCBUQ0d2IHZhZGRyLCBpbnQzMl90
IHNyYywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEaXNhc0NvbnRleHQgKmN0eCwg
aW50IHNsb3QpCit7CisgICAgVENHdiB0bXAgPSB0Y2dfY29uc3RfdGwoc3JjKTsKKyAgICBnZW5f
c3RvcmUxKGNwdV9lbnYsIHZhZGRyLCB0bXAsIGN0eCwgc2xvdCk7CisgICAgdGNnX3RlbXBfZnJl
ZSh0bXApOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX3N0b3JlMihUQ0d2X2VudiBjcHVf
ZW52LCBUQ0d2IHZhZGRyLCBUQ0d2IHNyYywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IERpc2FzQ29udGV4dCAqY3R4LCBpbnQgc2xvdCkKK3sKKyAgICBUQ0d2IHRtcCA9IHRjZ19jb25z
dF90bChzbG90KTsKKyAgICBnZW5fc3RvcmUzMih2YWRkciwgc3JjLCAyLCBzbG90KTsKKyAgICB0
Y2dfdGVtcF9mcmVlKHRtcCk7CisgICAgY3R4LT5jdHhfc3RvcmVfd2lkdGhbc2xvdF0gPSAyOwor
fQorCitzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX3N0b3JlMmkoVENHdl9lbnYgY3B1X2VudiwgVENH
diB2YWRkciwgaW50MzJfdCBzcmMsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRGlz
YXNDb250ZXh0ICpjdHgsIGludCBzbG90KQoreworICAgIFRDR3YgdG1wID0gdGNnX2NvbnN0X3Rs
KHNyYyk7CisgICAgZ2VuX3N0b3JlMihjcHVfZW52LCB2YWRkciwgdG1wLCBjdHgsIHNsb3QpOwor
ICAgIHRjZ190ZW1wX2ZyZWUodG1wKTsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGdlbl9zdG9y
ZTQoVENHdl9lbnYgY3B1X2VudiwgVENHdiB2YWRkciwgVENHdiBzcmMsCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBEaXNhc0NvbnRleHQgKmN0eCwgaW50IHNsb3QpCit7CisgICAgVENH
diB0bXAgPSB0Y2dfY29uc3RfdGwoc2xvdCk7CisgICAgZ2VuX3N0b3JlMzIodmFkZHIsIHNyYywg
NCwgc2xvdCk7CisgICAgdGNnX3RlbXBfZnJlZSh0bXApOworICAgIGN0eC0+Y3R4X3N0b3JlX3dp
ZHRoW3Nsb3RdID0gNDsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGdlbl9zdG9yZTRpKFRDR3Zf
ZW52IGNwdV9lbnYsIFRDR3YgdmFkZHIsIGludDMyX3Qgc3JjLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIERpc2FzQ29udGV4dCAqY3R4LCBpbnQgc2xvdCkKK3sKKyAgICBUQ0d2IHRt
cCA9IHRjZ19jb25zdF90bChzcmMpOworICAgIGdlbl9zdG9yZTQoY3B1X2VudiwgdmFkZHIsIHRt
cCwgY3R4LCBzbG90KTsKKyAgICB0Y2dfdGVtcF9mcmVlKHRtcCk7Cit9CisKK3N0YXRpYyBpbmxp
bmUgdm9pZCBnZW5fc3RvcmU4KFRDR3ZfZW52IGNwdV9lbnYsIFRDR3YgdmFkZHIsIFRDR3ZfaTY0
IHNyYywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERpc2FzQ29udGV4dCAqY3R4LCBp
bnQgc2xvdCkKK3sKKyAgICBUQ0d2IHRtcCA9IHRjZ19jb25zdF90bChzbG90KTsKKyAgICB0Y2df
Z2VuX21vdl90bChoZXhfc3RvcmVfYWRkcltzbG90XSwgdmFkZHIpOworICAgIHRjZ19nZW5fbW92
aV90bChoZXhfc3RvcmVfd2lkdGhbc2xvdF0sIDgpOworICAgIHRjZ19nZW5fbW92X2k2NChoZXhf
c3RvcmVfdmFsNjRbc2xvdF0sIHNyYyk7CisgICAgdGNnX3RlbXBfZnJlZSh0bXApOworICAgIGN0
eC0+Y3R4X3N0b3JlX3dpZHRoW3Nsb3RdID0gODsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGdl
bl9zdG9yZThpKFRDR3ZfZW52IGNwdV9lbnYsIFRDR3YgdmFkZHIsIGludDY0X3Qgc3JjLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIERpc2FzQ29udGV4dCAqY3R4LCBpbnQgc2xvdCkK
K3sKKyAgICBUQ0d2X2k2NCB0bXAgPSB0Y2dfY29uc3RfaTY0KHNyYyk7CisgICAgZ2VuX3N0b3Jl
OChjcHVfZW52LCB2YWRkciwgdG1wLCBjdHgsIHNsb3QpOworICAgIHRjZ190ZW1wX2ZyZWVfaTY0
KHRtcCk7Cit9CisKICNlbmRpZgotLSAKMi43LjQKCg==

