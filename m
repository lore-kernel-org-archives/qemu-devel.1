Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0C4CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8755A2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ro1JCFa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8755A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNenE-0008E0-HZ
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdim-0007DL-Ns
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdil-0007fj-Jx
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:12 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdil-0007fO-Dv
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:11 -0400
Received: by mail-wr1-x443.google.com with SMTP id o28so26220755wro.7
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XLu8pI7WGdyihkGj3zvR1VjIQBcJDdmLEAnpGb6JmbI=;
 b=ro1JCFa7K7/sOdiZQmuLBW2JMyn/QVKeYTyTRkPLNC4ZI26s00byG38j95twkdfBsq
 g1mbTjrSS+TPifWtdtiJQYbRQkBD6LP1l2JGv+dn373Q+twMuCK1Sebhs76mKvSYAIUa
 RMXhbSYSdG0ESnCa+9OEBgxUWAMC10BZT9vgkYcZm7V80NvgG14H6pw+N9qXoHMLS4Dx
 hc2U3tLxARs+jLOCKvwtNay0/FWrMtPbdjKL/47NRWkuFR61A304nqZ3ESRCFjWTK5dS
 MyHfiytNvbEbRVVro4WGJBVfsQD8I/Qmr1uDQdY5XFgI4+WaBDlZY5lmUn9X/aFiNOky
 fNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=XLu8pI7WGdyihkGj3zvR1VjIQBcJDdmLEAnpGb6JmbI=;
 b=rnyY5hg31asRbYB8jIGW1u/X94w3mXWjNUvsGq8FKC+1BmP+gVBOJ5OMTXXJVyPV92
 w7AaTdc4DPawS52IXepNyNV0uJU/RzV94Y6ZnkbbheR0e06R24u41L4LXE4V2UMUm20R
 8Q0a9LnmUala+17O2IZeTQLqw3fR8xFSvTlLJB+WWkR74npNYHgmVM/T1Rfvirti68jQ
 10eqky0+b9lWBxtuXItLHeYv14hjWRkT7JLn/XCDLGkzhydVJCR4uo0cRiyQNhbXC41o
 Z/kpqCHy3mUn+ApeSmJJozOJBDAbrdyLcOQJmES4R/lDdZs6AiM5xzxnvbkbcAq97cy1
 iYPA==
X-Gm-Message-State: APjAAAXmW5qc+IupCkw4q86eburKKgDn60jvKSCUg0wi1KYuqLcjjtB1
 ZXozG27AaJDuK159aq4ADQWBeGK1
X-Google-Smtp-Source: APXvYqxY0MuMFPY+fnBWfrA2mFZz+HiRjMfhzJ2FJgXJ6/tYbCxBCibh9wEPiSqbBl1EkZGZJvf3sw==
X-Received: by 2002:adf:9185:: with SMTP id 5mr4252458wri.389.1571925849710;
 Thu, 24 Oct 2019 07:04:09 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/39] hw/i386/pc: replace use of strtol with qemu_strtoui in
 x86_load_linux()
Date: Thu, 24 Oct 2019 16:03:26 +0200
Message-Id: <1571925835-31930-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

Follow checkpatch.pl recommendation and replace the use of strtol with
qemu_strtoui in x86_load_linux().

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/pc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 75a97c2..b5b660f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -68,6 +68,7 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "qemu/cutils.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/boards.h"
@@ -1202,6 +1203,7 @@ static void x86_load_linux(PCMachineState *pcms,
     vmode = strstr(kernel_cmdline, "vga=");
     if (vmode) {
         unsigned int video_mode;
+        int ret;
         /* skip "vga=" */
         vmode += 4;
         if (!strncmp(vmode, "normal", 6)) {
@@ -1211,7 +1213,12 @@ static void x86_load_linux(PCMachineState *pcms,
         } else if (!strncmp(vmode, "ask", 3)) {
             video_mode = 0xfffd;
         } else {
-            video_mode = strtol(vmode, NULL, 0);
+            ret = qemu_strtoui(vmode, NULL, 0, &video_mode);
+            if (ret != 0) {
+                fprintf(stderr, "qemu: can't parse 'vga' parameter: %s\n",
+                        strerror(-ret));
+                exit(1);
+            }
         }
         stw_p(header + 0x1fa, video_mode);
     }
-- 
1.8.3.1



