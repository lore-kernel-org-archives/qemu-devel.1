Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3549EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1052076B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IACMPDIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1052076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYHqX-0001FR-1s
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 20:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kYHop-00082F-Be
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 19:58:59 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:54410)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kYHom-0004L0-Nf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 19:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1604015936; x=1635551936;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aDEyM1fv9oRr0Su6HcOS/2lGOJ5PWbgNGrfSnVEqwUo=;
 b=IACMPDIFIfWaU7h3sujwvEBR2Gqg6KIzcPvAkcPVWo3ozcSlPTvm3tmm
 ukN5RdZOFZCHI8ai6Zm4umaic/EIS0I3C1VH1PD6i9gsvEVP8HbM/+PtJ
 E4NMjXYxgHcgKNPIdYrcQ0rz2ENfX7P73U29Bcavs4sssdtoQqIRtz3Lo 8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Oct 2020 16:58:53 -0700
X-QCInternal: smtphost
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg01-sd.qualcomm.com with ESMTP; 29 Oct 2020 16:58:52 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 963694116; Thu, 29 Oct 2020 18:58:52 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: tsimpson@quicinc.com
Subject: [RFC PATCH v5 03/33] Hexagon (include/elf.h) ELF machine definition
Date: Thu, 29 Oct 2020 18:58:20 -0500
Message-Id: <1604015931-23005-4-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604015931-23005-1-git-send-email-tsimpson@quicinc.com>
References: <1604015931-23005-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=199.106.114.38;
 envelope-from=tsimpson@qualcomm.com; helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 19:58:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RGVmaW5lIEVNX0hFWEFHT04gMTY0CgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNp
bXBzb25AcXVpY2luYy5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8
cGhpbG1kQHJlZGhhdC5jb20+ClRlc3RlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQu
aGVuZGVyc29uQGxpbmFyby5vcmc+Ci0tLQogaW5jbHVkZS9lbGYuaCB8IDEgKwogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9lbGYuaCBiL2luY2x1
ZGUvZWxmLmgKaW5kZXggN2E0MThlZS4uZjRmYTNjMSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9lbGYu
aAorKysgYi9pbmNsdWRlL2VsZi5oCkBAIC0xNzYsNiArMTc2LDcgQEAgdHlwZWRlZiBzdHJ1Y3Qg
bWlwc19lbGZfYWJpZmxhZ3NfdjAgewogCiAjZGVmaW5lIEVNX1VOSUNPUkUzMiAgICAxMTAgICAg
IC8qIFVuaUNvcmUzMiAqLwogCisjZGVmaW5lIEVNX0hFWEFHT04gICAgICAxNjQgICAgIC8qIFF1
YWxjb21tIEhleGFnb24gKi8KICNkZWZpbmUgRU1fUlggICAgICAgICAgIDE3MyAgICAgLyogUmVu
ZXNhcyBSWCBmYW1pbHkgKi8KIAogI2RlZmluZSBFTV9SSVNDViAgICAgICAgMjQzICAgICAvKiBS
SVNDLVYgKi8KLS0gCjIuNy40Cgo=

