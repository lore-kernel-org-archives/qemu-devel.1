Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F814C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 14:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488AF2072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 14:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9pSqAn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488AF2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9UPY-00056E-5u
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 10:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9UOj-0004fA-0a
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 10:21:33 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9UOh-0002Z5-C9
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 10:21:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id x9so439773wmi.2
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f+1QVYQOzQZYw50deyHBN5VIG7WppOlPOHIOiqTBVMk=;
 b=o9pSqAn2f+dCyOL/24UH+orbyKvqw6Jy0LneInKT2i44r743Q3ucMrucbcE6mW4+gn
 /01OtZknplqpWOJVVySFb4ZgnDHa8zAPXPetjbzARMBGBaA6Sxs8tMBx2CJA8mr+uCom
 82xQheOqiYPoJ1mXs5dvMxMfWq7QEb8fPco3YwJ12huEiQVOYbgmAu5sLyhhEjdkYGWQ
 WZdkcFauEWUhdMuQt7iElmDXdD+qt04KgnfrRjT4vbJPx9pFOUWYGAQBPxOcRNHzrcv1
 FpbZ+0zjAWbhzdau4JY3mCvlaqq+nQ9c3x/A8V7pR4CUehslVjGgx44j6rL33MNjN5mb
 higw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=f+1QVYQOzQZYw50deyHBN5VIG7WppOlPOHIOiqTBVMk=;
 b=RzWA5nmcHDLlExiduKV4zQFSjfw5oT0uG3fZ0maUdJ+SkpTKIsMEDkJXFIjIPEKCWN
 CRPbc3yFhXOvDq9mXOrcQ+DBW2k4eWcjjDeW6a7gpwtFTQUHq6a3vWsujlzcdHPtZc3t
 zF3744bQyga3XunGkCgvGkCisxp7d0QpJxRWRIgX9Y7BiVkmkuRnCDDAubg+vei9Ohwh
 4GXf1i+vM6sJr+aJD7BtGjoeLoKkyNNwqVpt/mYV6QguNpRKPFatb8dSDQqnwSa7qZNg
 6Gn2ygUTvHYPNOLnJaBN+29+CaamJY+6p7QwsLpWAYcwROp7NE0IoYKEiPmySP+mxOkx
 OBIQ==
X-Gm-Message-State: AOAM533dNFnuRmCSEz8EM7obe3CKDOpHvJXm9AUJrdJWX4iLO2wwCPpC
 1aoR0x2CzMitlZxkoFE6vu0b+kTpAhY=
X-Google-Smtp-Source: ABdhPJwCU95iMOyOmMPVpPVgHcQHBzHALqhPCIgLB9Rn1/FBmmk5TfdsjVYwqh689r5GYaPSJnL1AA==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr7497451wme.132.1598106089455; 
 Sat, 22 Aug 2020 07:21:29 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id f16sm11385740wro.34.2020.08.22.07.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2020 07:21:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2] hw/display/tcx: Allow 64-bit accesses to framebuffer
 stippler and blitter
Date: Sat, 22 Aug 2020 16:21:27 +0200
Message-Id: <20200822142127.1316231-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Michael Lorenz <macallan@NetBSD.org>, 1892540@bugs.launchpad.net,
 Andreas Gustafsson <gson@gson.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The S24/TCX datasheet is listed as "Unable to locate" on [1].

However the NetBSD revision 1.32 of the driver introduced
64-bit accesses to the stippler and blitter [2]. It is safe
to assume these memory regions are 64-bit accessible.
QEMU implementation is 32-bit, so fill the 'impl' fields.

[1] http://web.archive.org/web/20111209011516/http://wikis.sun.com/display/FOSSdocs/Home
[2] http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/sbus/tcx.c.diff?r1=1.31&r2=1.32

Reported-by: Andreas Gustafsson <gson@gson.org>
Buglink: https://bugs.launchpad.net/bugs/1892540
Fixes: 55d7bfe2293 ("tcx: Implement hardware acceleration")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v1:
- added missing uncommitted staged changes... (tcx_blit_ops)
---
 hw/display/tcx.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 1fb45b1aab8..96c6898b149 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -548,20 +548,28 @@ static const MemoryRegionOps tcx_stip_ops = {
     .read = tcx_stip_readl,
     .write = tcx_stip_writel,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
+    .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
 };
 
 static const MemoryRegionOps tcx_rstip_ops = {
     .read = tcx_stip_readl,
     .write = tcx_rstip_writel,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
+    .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
 };
 
 static uint64_t tcx_blit_readl(void *opaque, hwaddr addr,
@@ -650,10 +658,14 @@ static const MemoryRegionOps tcx_rblit_ops = {
     .read = tcx_blit_readl,
     .write = tcx_rblit_writel,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
+    .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
 };
 
 static void tcx_invalidate_cursor_position(TCXState *s)
-- 
2.26.2


