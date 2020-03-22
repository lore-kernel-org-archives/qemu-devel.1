Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1533C4332B
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 19:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B4920724
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 19:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/dWmYjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B4920724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG6CE-0005vV-Kk
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 15:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jG6Bc-0005RN-GN
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 15:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jG6Ba-00080u-Vb
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 15:23:04 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jG6Ba-0007zu-NB
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 15:23:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id l20so12288771wmi.3
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 12:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ev/rARBqmxuXFlqAqZsGEHnb8NKhJeii6ub3R0/lfxI=;
 b=h/dWmYjvSLHhRegqt5P69A6otdshUfg5oJHRLswClGJmwC3LEf1IEuXyunIE7TmII7
 rWstGizYTrMUGvkHV+w28a0n8LigZBs7HAb163DlpHTxIcngYm3ZVkk5f58xt4zruwge
 u72iAd6DsWPd1HgLVRYIp2JUC7BYh7veqzZ8Ht/T82K5zCQ7NDJaSts42UkiD5ofc7l7
 jg8OC0vSM0BxFVUSvtVgjx/YIa0plmgcTRdCMl9fe0JG8XTf9hZZGF1kvsmd7ZVAFIyH
 QKbqD5k3HVARGXcujU35AnQZY881VDfRWdLMEvDj/aebGJbuwrsP8u1OxEh26WAIo+VC
 H2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ev/rARBqmxuXFlqAqZsGEHnb8NKhJeii6ub3R0/lfxI=;
 b=e7oMr9HLweS23g8Du6t+QA2QJOx9NNIe7xiOU8Gfig1fq2WWIg2W/c7iHoIVt3s6ar
 c3nVTdpLE3LmxkMd/E6PJn0fcpjiq+2VCxQtssbdrsmtYRFtwa1kpP+MCn+gVySS+DCW
 tscgTtVF8lSOmKatBPF4h9+GWmw5FZcLcrculAqBcqLLNnw1s6S8taj+UFthTsM5AKuG
 tNMwf6eF1QDr64cn75LFsuYU14vuOsiJLcgtiGkIekaaPBGfEWBWwSDgJkckZ4B/Vmv4
 O4+AhIUBVaPxS1jeQIXdbbkMGl9kDpM8h0HUnzvK2Gx3KWoa+033xN7p+oudF/PSIaDS
 7lWg==
X-Gm-Message-State: ANhLgQ05/PaVU6Oq1YIHii53TnmasgW9Bm2NP6OpI9RTrijZ0WTO3umj
 rCa7Cgx/VxYhJZGosjWH+g5Nu53KM7QcYA==
X-Google-Smtp-Source: ADFU+vszxio4Oa257JqLaP9HfXhCsVkrRthK/a3qDKsWT7/B3yygCxCN6gdnlnxWKHOeFmyGR22ZaQ==
X-Received: by 2002:a1c:4645:: with SMTP id t66mr23561871wma.6.1584904981078; 
 Sun, 22 Mar 2020 12:23:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q8sm12086755wmj.22.2020.03.22.12.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 12:23:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] hw/ppc: Take QEMU lock when calling
 ppc_dcr_read/write()
Date: Sun, 22 Mar 2020 19:22:58 +0000
Message-Id: <20200322192258.14039-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Amit Lazar <abasarlaz@hotmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ppc_dcr_read() and ppc_dcr_write() functions call into callbacks
in device code, so we need to hold the QEMU iothread lock while
calling them.  This is the case already for the callsites in
kvmppc_handle_dcr_read/write(), but we must also take the lock when
calling the helpers from TCG.

This fixes a bug where attempting to initialise the PPC405EP
SDRAM will cause an assertion when sdram_map_bcr() attempts
to remap memory regions.

Reported-by: Amit Lazar <abasarlaz@hotmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Amit reported this bug via IRC.

 target/ppc/timebase_helper.c | 40 +++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 703bd9ed18b..d16360ab667 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -21,6 +21,7 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 
 /*****************************************************************************/
 /* SPR accesses */
@@ -167,13 +168,19 @@ target_ulong helper_load_dcr(CPUPPCState *env, target_ulong dcrn)
         raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
                                POWERPC_EXCP_INVAL |
                                POWERPC_EXCP_INVAL_INVAL, GETPC());
-    } else if (unlikely(ppc_dcr_read(env->dcr_env,
-                                     (uint32_t)dcrn, &val) != 0)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "DCR read error %d %03x\n",
-                      (uint32_t)dcrn, (uint32_t)dcrn);
-        raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
-                               POWERPC_EXCP_INVAL |
-                               POWERPC_EXCP_PRIV_REG, GETPC());
+    } else {
+        int ret;
+
+        qemu_mutex_lock_iothread();
+        ret = ppc_dcr_read(env->dcr_env, (uint32_t)dcrn, &val);
+        qemu_mutex_unlock_iothread();
+        if (unlikely(ret != 0)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "DCR read error %d %03x\n",
+                          (uint32_t)dcrn, (uint32_t)dcrn);
+            raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
+                                   POWERPC_EXCP_INVAL |
+                                   POWERPC_EXCP_PRIV_REG, GETPC());
+        }
     }
     return val;
 }
@@ -185,12 +192,17 @@ void helper_store_dcr(CPUPPCState *env, target_ulong dcrn, target_ulong val)
         raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
                                POWERPC_EXCP_INVAL |
                                POWERPC_EXCP_INVAL_INVAL, GETPC());
-    } else if (unlikely(ppc_dcr_write(env->dcr_env, (uint32_t)dcrn,
-                                      (uint32_t)val) != 0)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "DCR write error %d %03x\n",
-                      (uint32_t)dcrn, (uint32_t)dcrn);
-        raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
-                               POWERPC_EXCP_INVAL |
-                               POWERPC_EXCP_PRIV_REG, GETPC());
+    } else {
+        int ret;
+        qemu_mutex_lock_iothread();
+        ret = ppc_dcr_write(env->dcr_env, (uint32_t)dcrn, (uint32_t)val);
+        qemu_mutex_unlock_iothread();
+        if (unlikely(ret != 0)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "DCR write error %d %03x\n",
+                          (uint32_t)dcrn, (uint32_t)dcrn);
+            raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
+                                   POWERPC_EXCP_INVAL |
+                                   POWERPC_EXCP_PRIV_REG, GETPC());
+        }
     }
 }
-- 
2.20.1


