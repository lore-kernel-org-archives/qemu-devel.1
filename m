Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544D6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D482080C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y4aF6ule"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D482080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83uO-0000Bv-Bs
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83tH-0006aP-7T
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:11 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:55167)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83tE-0005sR-Aa
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1597765868; x=1629301868;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/qoiXkEzfaCI0ol+W8quYQq/oAU06sdlpKFFijH6zBg=;
 b=Y4aF6uleKOgr5K7ElAIVDKF+UITz1jv0XnrCLendJqgNzOXr6Dybvmw0
 8Du4y88SX3Lpc9MSjeckqQv2sAW+l7T+aynSwTV9Vn+9Yy3AJy14ew2xU
 R2XLmqUO/FDr20l6IWN/stT3ZFppLP0oljGL2uyk4n2KKy1CMuu191QIW 4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Aug 2020 08:50:58 -0700
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg05-sd.qualcomm.com with ESMTP; 18 Aug 2020 08:50:55 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 64C34EB5; Tue, 18 Aug 2020 10:50:55 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 03/34] Hexagon (include/elf.h) ELF machine definition
Date: Tue, 18 Aug 2020 10:50:16 -0500
Message-Id: <1597765847-16637-4-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

RGVmaW5lIEVNX0hFWEFHT04gMTY0CgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNp
bXBzb25AcXVpY2luYy5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8
cGhpbG1kQHJlZGhhdC5jb20+ClRlc3RlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEByZWRoYXQuY29tPgotLS0KIGluY2x1ZGUvZWxmLmggfCAyICsrCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9lbGYuaCBiL2luY2x1ZGUv
ZWxmLmgKaW5kZXggNWIwNmI1NS4uNDQ3ZGEwOCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9lbGYuaAor
KysgYi9pbmNsdWRlL2VsZi5oCkBAIC0xNzIsNiArMTcyLDggQEAgdHlwZWRlZiBzdHJ1Y3QgbWlw
c19lbGZfYWJpZmxhZ3NfdjAgewogCiAjZGVmaW5lIEVNX1VOSUNPUkUzMiAgICAxMTAgICAgIC8q
IFVuaUNvcmUzMiAqLwogCisjZGVmaW5lIEVNX0hFWEFHT04gICAgIDE2NCAgICAgLyogUXVhbGNv
bW0gSGV4YWdvbiAqLworCiAjZGVmaW5lIEVNX1JJU0NWICAgICAgICAyNDMgICAgIC8qIFJJU0Mt
ViAqLwogCiAjZGVmaW5lIEVNX05BTk9NSVBTICAgICAyNDkgICAgIC8qIFdhdmUgQ29tcHV0aW5n
IG5hbm9NSVBTICovCi0tIAoyLjcuNAoK

