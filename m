Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B11C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93039206EE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d15FKVHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93039206EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihPwE-0000h7-EJ
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 22:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPs8-0004CN-GJ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPs7-0002mi-EX
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:36 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42849)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihPs7-0002lQ-8s
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:35 -0500
Received: by mail-pl1-x641.google.com with SMTP id p9so307256plk.9
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 19:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o0Btsp+XuBjjSu9t/pnVNpY24aVKknJmQRq/Lz0GJe4=;
 b=d15FKVHPFr6axZ4COedyrHYLMZvtPPJVkLja7j7bZoeOGr5raNuBbsFAcXbY8O9NTM
 9yGD7zkpjmYq/xsxIa7Q9I+ybwAtUW3SeunqtG29l/DT2TrmhuyPOCcvxO9LcYaf58UP
 XDmJHZkugZEyqmW5qxVPCuzR3kUc4eiA/PehgH7qsH2qhQF6wgY24dKbLMwObPP1z2Fh
 0shYr0BC63SFVXvQRBx4z2c91JjXElXJOFK+k6WAyxNwgg1YDqfCEhHDEJT85xWPN3C7
 0C6xOgBtiPL0KPWlOxefV2cEiIBYFVlz5nNWZKAJRgcbsAt6+3uwKkl922PUZomgi4aW
 W51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o0Btsp+XuBjjSu9t/pnVNpY24aVKknJmQRq/Lz0GJe4=;
 b=n1R+2OqYncuAGLgFMx1y13qzJL/E+gDYmBegkhu8gHM0cT/LCYCunLeguyzeAYQl69
 2/MDOnNKySX3IQFeKK8ojrNa0aP/RSvtT1etp8oiLwTWt/eUQ8qTF8LLgKEeN9ORRlIJ
 TKvv2VCJs+P1WFaaPqaIn0ah4781dMR1TH2mYVx/TBA3dPSrd6nbsRuutRGbcCJhEJVm
 DpxURoTU677yNszjivH1/krxLDpFPZT0mQ4BAvE8OtdPLWabS6IY+25+gIKliIsjz1xk
 +qTDndQ2NgUWTKZW7eJuebyNyve37MDWZ/P9OEnRmu1XqHL7eLxiwIyGpWYjG/B1Ac+c
 sHWg==
X-Gm-Message-State: APjAAAUwMDdW/1RS/vCQNbZZ4knj48ubB8wnGLYx+HUL8G4YhWm/5j5U
 ILOl2eTFVJmMTHoXvjT7DkDhmIc/SUw=
X-Google-Smtp-Source: APXvYqxgJc1qNkADxBp1Lx4lA2njspWXjR9X5mj2i/KJb/n6GliuR4EMrDz86wzPEteIQ8SJ5/MCJg==
X-Received: by 2002:a17:90a:fe02:: with SMTP id ck2mr62354pjb.10.1576639172806; 
 Tue, 17 Dec 2019 19:19:32 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id k27sm404870pfp.66.2019.12.17.19.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 19:19:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] configure: Override the os default with --disable-pie
Date: Tue, 17 Dec 2019 17:19:19 -1000
Message-Id: <20191218031920.6414-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218031920.6414-1-richard.henderson@linaro.org>
References: <20191218031920.6414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: philmd@redhat.com, i@maskray.me, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some distributions, e.g. Ubuntu 19.10, enable PIE by default.
If for some reason one wishes to build a non-pie binary, we
must provide additional options to override.

At the same time, reorg the code to an elif chain.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index f8981eec15..1645a58b3a 100755
--- a/configure
+++ b/configure
@@ -2029,19 +2029,18 @@ if compile_prog "-Werror -fno-pie" "-no-pie"; then
   LDFLAGS_NOPIE="-no-pie"
 fi
 
-if test "$pie" != "no" ; then
-  if compile_prog "-fPIE -DPIE" "-pie"; then
-    QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
-    LDFLAGS="-pie $LDFLAGS"
-    pie="yes"
-  else
-    if test "$pie" = "yes"; then
-      error_exit "PIE not available due to missing toolchain support"
-    else
-      echo "Disabling PIE due to missing toolchain support"
-      pie="no"
-    fi
-  fi
+if test "$pie" = "no"; then
+  QEMU_CFLAGS="$CFLAGS_NOPIE $QEMU_CFLAGS"
+  LDFLAGS="$LDFLAGS_NOPIE $LDFLAGS"
+elif compile_prog "-fPIE -DPIE" "-pie"; then
+  QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
+  LDFLAGS="-pie $LDFLAGS"
+  pie="yes"
+elif test "$pie" = "yes"; then
+  error_exit "PIE not available due to missing toolchain support"
+else
+  echo "Disabling PIE due to missing toolchain support"
+  pie="no"
 fi
 
 # Detect support for DT_BIND_NOW.
-- 
2.20.1


