Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B48AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F379F214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9HxsF2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F379F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifXq1-0007L4-4W
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 18:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ifXo2-00058r-0c
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ifXo0-0007A8-U8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:23:37 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:36250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ifXo0-00076v-3D
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:23:36 -0500
Received: by mail-lj1-x244.google.com with SMTP id r19so562381ljg.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 15:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1jW23x514kt70s8XqE8SuYRUf2hmwVse172rx0/Tu34=;
 b=M9HxsF2N0djCUjwIRB3zyIA2trlGOZlaP0IXoo8gIoMPviNnOseGo2Fyg0tN+ZIcSI
 a+xgRUCZzG/ZJYZ9C3Jk2r41T+89ds0oKpcvbYODPbZuBExOUElKsnu1n6cQTJ7zYaga
 nJ+1TTGXEaScljZFAogNlgRNXSX6AAhI1YyaONIgMDylPwY8FH6DAd8qEHkewLsjpg2u
 VAWpISIBIkpWX4JFXl3eOkXyCfwwNpb3C/fNNhzfUAMHMYtcoZtMMHDy0ZnJ8JbkQLEo
 vrYz7KQC8LBm9iyo7zl6ZiTZKB1AZ1kW5XvpMbZss8PbZzMej3eSXUP/IZZzVct2kAEj
 o3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1jW23x514kt70s8XqE8SuYRUf2hmwVse172rx0/Tu34=;
 b=VsnOIM0UGpSWaaDdX1KVIq2Yu6IImD+2EvL36jSsIl0Y6+w+VjXII6Ji7fY1GPMSfS
 EPSzovLVat2WNQ+sHkfvOeuP6Jrp1++/gWKpiq87hCsnV5l2Q/V8FySkUgtLOaH1lBRb
 3tF7rsWU3i1iJwFbWz82/IItBhXSPVEDSarSKrXPmFW5kWul+a9FZ2u3pYyTTuAwclur
 ROaGfh7eiMjp9BU3d72oxIoJyj4Ip5AXF2c06KtvWf6Wr6dzA/KZ0A5OTGPe2aACu0th
 s1EsOd20uedXObXsKbgPUjlfI+hvVkf2k79zBTyql6Q1IboOHs9elSvBfGCvl1Dx++vL
 x67g==
X-Gm-Message-State: APjAAAWwn6yodpOx6XOWNfAsePBcq+hTsLS6JPNlNW66gZhq1+FcaqVv
 mIqUBV1AT/Z8Q0eQqtFll7aHd+Ogbuk=
X-Google-Smtp-Source: APXvYqytfdFY20sZm+N4vyu1RL/gFUYWVgU24hU55nZLXIK26F26B7VmdNqPsov/DlOYRqBpPEqteA==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr7280962ljk.220.1576193013802; 
 Thu, 12 Dec 2019 15:23:33 -0800 (PST)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id j19sm4107859lfb.90.2019.12.12.15.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 15:23:33 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/xtensa: use MPU background map from core
 configuration
Date: Thu, 12 Dec 2019 15:23:18 -0800
Message-Id: <20191212232318.2840-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212232318.2840-1-jcmvbkbc@gmail.com>
References: <20191212232318.2840-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Configuration overlay may define MPU background map. Import
core-matmap.h from the overlay and use XCHAL_MPU_BACKGROUND_MAP macro
if it's defined.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/import_core.sh |  4 +++-
 target/xtensa/overlay_tool.h | 15 ++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/import_core.sh b/target/xtensa/import_core.sh
index 97c3219debf0..8f844cf9e2a6 100755
--- a/target/xtensa/import_core.sh
+++ b/target/xtensa/import_core.sh
@@ -20,7 +20,8 @@ exit
 [ $# -ge 3 ] && FREQ="$3"
 mkdir -p "$TARGET"
 tar -xf "$OVERLAY" -C "$TARGET" --strip-components=2 \
-    xtensa/config/core-isa.h
+    xtensa/config/core-isa.h \
+    xtensa/config/core-matmap.h
 tar -xf "$OVERLAY" -O gdb/xtensa-config.c | \
     sed -n '1,/*\//p;/XTREG/,/XTREG_END/p' > "$TARGET"/gdb-config.inc.c
 #
@@ -44,6 +45,7 @@ cat <<EOF > "${TARGET}.c"
 #include "qemu/host-utils.h"
 
 #include "core-$NAME/core-isa.h"
+#include "core-$NAME/core-matmap.h"
 #include "overlay_tool.h"
 
 #define xtensa_modules xtensa_modules_$NAME
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index f0cc33adfe05..cab532095c9e 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -373,15 +373,28 @@
 #elif XCHAL_HAVE_MPU
 
 #ifndef XTENSA_MPU_BG_MAP
+#ifdef XCHAL_MPU_BACKGROUND_MAP
+#define XCHAL_MPU_BGMAP(s, vaddr_start, vaddr_last, rights, memtype, x...) \
+    { .vaddr = (vaddr_start), .attr = ((rights) << 8) | ((memtype) << 12), },
+
+#define XTENSA_MPU_BG_MAP (xtensa_mpu_entry []){\
+    XCHAL_MPU_BACKGROUND_MAP(0) \
+}
+
+#define XTENSA_MPU_BG_MAP_ENTRIES XCHAL_MPU_BACKGROUND_ENTRIES
+#else
 #define XTENSA_MPU_BG_MAP (xtensa_mpu_entry []){\
     { .vaddr = 0, .attr = 0x00006700, }, \
 }
+
+#define XTENSA_MPU_BG_MAP_ENTRIES 1
+#endif
 #endif
 
 #define TLB_SECTION \
     .mpu_align = XCHAL_MPU_ALIGN, \
     .n_mpu_fg_segments = XCHAL_MPU_ENTRIES, \
-    .n_mpu_bg_segments = 1, \
+    .n_mpu_bg_segments = XTENSA_MPU_BG_MAP_ENTRIES, \
     .mpu_bg = XTENSA_MPU_BG_MAP
 
 #ifndef XCHAL_SYSROM0_PADDR
-- 
2.20.1


