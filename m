Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26504C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D566120873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEI+Wq+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D566120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46817 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j255x-0003gH-0i
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 22:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j255B-0002BP-95
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j255A-0008W3-7e
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:29 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j255A-0008Uj-2M
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:28 -0500
Received: by mail-pl1-x642.google.com with SMTP id t6so1750871plj.5
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 19:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b0SUyaJJjQZuc34rLJlUYZCom+bkortVckKDUk4LlxA=;
 b=tEI+Wq+MT+AsYiUz4cgA7Dp9LDe139xyevHXaao51NWk4Qy+oHi8p3FQTzxyP6TQoL
 vn3yo3aKQhiqaWVSgTQBnM/i1ZWcF5GRjHnqZqpIKSop9zahZmSW2lPkOX/K6XirkBqm
 /hEGcr3q0MjJCWTwiswI8i2EZOSz4V9Sot3kp/G5Jn0xXD8rkcDjqidnN4iRidn+LqYn
 CL0QQQPBoVyX1fX+aG0+o5NWXugfdCywTMVZr0ky8Jl71dNhDP1GxrSAI0cSSXXvXP/L
 qubE268Myx0bhtFagMfU4vyfzI6m5q6blBQnJK5Yu3TiEkvqqwctKFggO0iwgVl/PAua
 rVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b0SUyaJJjQZuc34rLJlUYZCom+bkortVckKDUk4LlxA=;
 b=f5KhhQ7ouOqjRD1qePlmcoiYc/ZdLcd+1DwgoY5WItmNHCaxBy5ueaYsmZo3BH4OnW
 56gkZJjrqUiyy7vCNNUYs7Q5aZFeqZulBaJ5P5pxgkFcENsojOtjicf6+LncNSIp4B1W
 FCaDoxvLRNfe8YPQS2kobvmFrsjsx5G5IkOMybGvAIqoODk3XPzHXExpOInOJmpj6Hia
 cWsS1k88XpbEBDyxqamrlTzCsbi4MmGiODywfJSa4P8IQj5Ss+pKgsdV/hnf9f3jgJB+
 XHoRVkEiMUnicuTWELG/jqtmZ/eECjvQdoc6f6JTTEVxvlDUjDxScTTxAezJ6aKnaSEH
 y8Lg==
X-Gm-Message-State: APjAAAWxg+NATTcSOE4LDEJ8C9eWP6aU9bs58/MF6DYAHHNjTbX5OsbD
 uAwwl+zaIO8376E9kyRSmcnLX/VDHDs=
X-Google-Smtp-Source: APXvYqwfbIZVmRRrcKRrI/Zf0x2uc2Ci6u8Lf9830+GAo06JS18B/AG1p2+VTYZEwfxWryFoWSgQvg==
X-Received: by 2002:a17:90a:bf83:: with SMTP id
 d3mr2634922pjs.77.1581564146790; 
 Wed, 12 Feb 2020 19:22:26 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l15sm536067pgi.31.2020.02.12.19.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 19:22:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/5] target/i386: Renumber EXCP_SYSCALL
Date: Wed, 12 Feb 2020 19:22:19 -0800
Message-Id: <20200213032223.14643-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213032223.14643-1-richard.henderson@linaro.org>
References: <20200213032223.14643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are not short of numbers for EXCP_*.  There is no need to confuse things
by having EXCP_VMEXIT and EXCP_SYSCALL overlap, even though the former is
only used for system mode and the latter is only used for user mode.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 576f309bbf..08b4422f36 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -999,9 +999,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define EXCP11_ALGN	17
 #define EXCP12_MCHK	18
 
-#define EXCP_SYSCALL    0x100 /* only happens in user only emulation
-                                 for syscall instruction */
-#define EXCP_VMEXIT     0x100
+#define EXCP_VMEXIT     0x100 /* only for system emulation */
+#define EXCP_SYSCALL    0x101 /* only for user emulation */
 
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
-- 
2.20.1


