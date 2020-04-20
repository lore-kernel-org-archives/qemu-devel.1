Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB2EC55181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6A820782
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EM+ilBcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6A820782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQdt4-0008Lz-VT
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 17:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQdrq-0006na-10
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQdrp-0006qt-GN
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:22:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQdrp-0006m8-2M
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:22:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id j2so13992218wrs.9
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KOErd88B3Ihy9IyTZFkOsxrNfUtKAovKUtVCpnPaODQ=;
 b=EM+ilBcBpdhJU/TQU193eMLKfo1Rs2Cgxf352fuHGupkA8tuLIFqHGtk/OAvzllU++
 xU05slbQE0dtdboUg1PtvGIRxNQJ6yNDlDzOC0BTMUurrrisSruqkkNXHoCU8FRnKydI
 Lpv2FbFF75Oa0uGvgrUQPH4DhOrCaIoyeJ6TuXLf7k0axW6CPTDRDk3tkxBNFqZ1+5ad
 T71wl65Ct5W6UxpWxTEw/bRwvt9+cK65nbvqnZrO3hG5C4S3wU3tjKSUVQHHRaECSjZI
 TSwPbFSFchhB2ZXvhTeE+VY91SntvGXnChF9ki03VS//zHxMFc0rYrQ5r4gt/XDnE4Cq
 cLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KOErd88B3Ihy9IyTZFkOsxrNfUtKAovKUtVCpnPaODQ=;
 b=stDEAhT1qid+esn04Ot+AG6n3swRKoSFBzQaUU6FuDO3WrJnP+d1goEcBaHOMJV+rG
 W81z4vPvt5OUMvPpd0OPBmhF5tBoP58//YkYgYlbqQeYMqn47TY1f09E1M0PkFldC6GK
 ouahxt9E9TEtpupM9xC+sPTrzJneLpsRgVF/hWIZXGtzgZFsVlTGcOoUzO3GmlQ3DJWi
 QXomN5E3sxmitVu1kBeA/vkCsvCLhz8OKbX8Lm76+ljEE8WL9dOR/qLbxAC42wn995IH
 7fZGBF0lNpEuhAnpwqKIvng62gh7ZEllg0gF8YVEn7DcHpk2dsh6FF9n2frqVH2aZZbO
 FlzQ==
X-Gm-Message-State: AGi0Pua9ek6KbeqKXSzT1j9GloTRLCrfNQ9ksSGShLpiGj8rH9Y/unTq
 UlE6rJghsWN+dyhhTmYcObqovaW0tOjwbA==
X-Google-Smtp-Source: APiQypJs9AcGKA03+QZPmqsYPCwgmRuBjZ/mjimpWwpv3YZhECRbn/IFOumsjwn7MGNIrScd3Zsp3g==
X-Received: by 2002:a5d:6091:: with SMTP id w17mr20032471wrt.382.1587417731746; 
 Mon, 20 Apr 2020 14:22:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j10sm823663wmi.18.2020.04.20.14.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 14:22:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/4] linux-user/arm: Remove bogus SVC 0xf0002 handling
Date: Mon, 20 Apr 2020 22:22:04 +0100
Message-Id: <20200420212206.12776-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420212206.12776-1-peter.maydell@linaro.org>
References: <20200420212206.12776-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Cc: omerg681@gmail.com, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We incorrectly treat SVC 0xf0002 as a cacheflush request (which is a
NOP for QEMU).  This is the wrong syscall number, because in the
svc-immediate OABI syscall numbers are all offset by the
ARM_SYSCALL_BASE value and so the correct insn is SVC 0x9f0002.
(This is handled further down in the code with the other Arm-specific
syscalls like NR_breakpoint.)

When this code was initially added in commit 6f1f31c069b20611 in
2004, ARM_NR_cacheflush was defined as (ARM_SYSCALL_BASE + 0xf0000 + 2)
so the value in the comparison took account of the extra 0x900000
offset. In commit fbb4a2e371f2fa7 in 2008, the ARM_SYSCALL_BASE
was removed from the definition of ARM_NR_cacheflush and handling
for this group of syscalls was added below the point where we subtract
ARM_SYSCALL_BASE from the SVC immediate value. However that commit
forgot to remove the now-obsolete earlier handling code.

Remove the spurious ARM_NR_cacheflush condition.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/arm/cpu_loop.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 82d0dd3c312..025887d6b86 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -308,9 +308,7 @@ void cpu_loop(CPUARMState *env)
                     n = insn & 0xffffff;
                 }
 
-                if (n == ARM_NR_cacheflush) {
-                    /* nop */
-                } else if (n == 0 || n >= ARM_SYSCALL_BASE || env->thumb) {
+                if (n == 0 || n >= ARM_SYSCALL_BASE || env->thumb) {
                     /* linux syscall */
                     if (env->thumb || n == 0) {
                         n = env->regs[7];
-- 
2.20.1


