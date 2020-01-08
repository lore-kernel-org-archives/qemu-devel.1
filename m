Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F95AC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165E72077B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUyIdK3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165E72077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2RM-0008NS-L7
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Hv-00034B-1U
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Ht-0002Xg-UO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:42 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36563)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Ht-0002X6-Ov
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:41 -0500
Received: by mail-pg1-x543.google.com with SMTP id k3so877452pgc.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A0N0dguL22OusnU3Aul2sGZtJ4sR0312gx6xckIIDM8=;
 b=OUyIdK3Mk05zg3M9AcYoDdbWRx4n5r0xRtIyyiN6Fzu4SfyNOy4C+zuUjT5tXZxPR/
 RCLY70Aiv4U1IUY/X9zEVLVMe0QF36ic7ztCRandQ/GtGC2LNQgiNe4P4YwEstBakOQr
 w03D+1baPzaBjv7DOtdg/PmpOeKVZB0zj2JURI3RM7FVmm7HqTOvgLueGUynEGDCPFvn
 HJQmxyJG2pcIlxemfhTK/1z1r0joQXobQiucSxVYSbjIgguO0dwdM/Bqrib1djgx2ShQ
 Gz4w75yFlDcleIGPFu5/C2uW2W5gUM5k6TduBUnIjRpMMVVejftabmfFacLBwakTz0Fp
 NWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A0N0dguL22OusnU3Aul2sGZtJ4sR0312gx6xckIIDM8=;
 b=bNtnJ+uvC8Hpv73zWgzgAwSCtCsW6HaAccQstkQGhznh4FzUWyMnbFVuIj4CVq8v7B
 Y1QagN2yw11GhGqB1mETwNvtTjQ37YFO8OlsvKUa58ILbyZ4LJx+F/2EBjt9WwG4TQlI
 D65PxnmL+4rM22ri+AdYrEFl7NpzGMITda2XEbn1D5BPoa/gNTxqD0rzvZ1jr/LfzhSz
 FSAXoC6D0zoLHp99DABTqXVG2DEDf96rl1/JJcCoGg3XYPh08YMqHr4A1Zhxb1pnWZgq
 vH13slhRo0W4FoWVzlaCkmpY3ZxJsc5roAYeGqiLohfFJJXfZLusrF5Hh8DwQQpLQ+qz
 0m6A==
X-Gm-Message-State: APjAAAWcZ9rxytZvA+QwiJY/yBpVTbflQZEpxAIHvEO6ULJikD0tHwB/
 gNnxfOuCD2msV6sZGv0d8VWyOL/DPQMPWg==
X-Google-Smtp-Source: APXvYqyJLDrXMM8x71veEqmaQt9QNwbweQIITCF5/OlZdXC0t6E1Qedsu4Hc87yXA3R5fcMdj+J3VQ==
X-Received: by 2002:a63:5211:: with SMTP id g17mr3220421pgb.426.1578455140562; 
 Tue, 07 Jan 2020 19:45:40 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:45:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/41] configure: Always detect -no-pie toolchain support
Date: Wed,  8 Jan 2020 14:44:46 +1100
Message-Id: <20200108034523.17349-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CFLAGS_NOPIE and LDFLAGS_NOPIE variables are used
in pc-bios/optionrom/Makefile, which has nothing to do
with the PIE setting of the main qemu executables.

This overrides any operating system default to build
all executables as PIE, which is important for ROMs.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index 351e39795b..f5248f86cd 100755
--- a/configure
+++ b/configure
@@ -2019,26 +2019,24 @@ if ! compile_prog "-Werror" "" ; then
 	"Thread-Local Storage (TLS). Please upgrade to a version that does."
 fi
 
-if test "$pie" != "no" ; then
-  cat > $TMPC << EOF
+cat > $TMPC << EOF
 
 #ifdef __linux__
 #  define THREAD __thread
 #else
 #  define THREAD
 #endif
-
 static THREAD int tls_var;
-
 int main(void) { return tls_var; }
-
 EOF
-  # check we support --no-pie first...
-  if compile_prog "-Werror -fno-pie" "-no-pie"; then
-    CFLAGS_NOPIE="-fno-pie"
-    LDFLAGS_NOPIE="-nopie"
-  fi
 
+# Check we support --no-pie first; we will need this for building ROMs.
+if compile_prog "-Werror -fno-pie" "-no-pie"; then
+  CFLAGS_NOPIE="-fno-pie"
+  LDFLAGS_NOPIE="-no-pie"
+fi
+
+if test "$pie" != "no" ; then
   if compile_prog "-fPIE -DPIE" "-pie"; then
     QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
     LDFLAGS="-pie $LDFLAGS"
-- 
2.20.1


