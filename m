Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5B8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4E4206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3kC0Ix0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4E4206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEeY-0000HN-Po
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbN-0003xE-Sn
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbM-0004M3-PC
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id y20so1872668wmi.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NV7x1nwKQefefjiR50/F9HWNP0Eyv5YxWPD+mxgxVTQ=;
 b=U3kC0Ix0oRJ2nnyFMFHHeP1CIl891xjAR/JIaT3hyCD/Z5/bsRndwDKaKQNKLyN6F0
 L3ELgba1oVBAMrNDeUGkL4b2Q9x6G5XOZmycNMmbIYYTzVAOKRz4FkASdqCNGjLhrPIU
 cLfcHKbX1i98kCcmIGsdvgpVhyUIeT0Jc4Sb2CKfxJc+fM5Vlxk8mH1PEI1MEJ7M1uCc
 wucp9mJJPH9t6IkT/zNY/Vdtee8ALdcf9xguOwqbWKzDQFnfOaEgOMPXZrMsgAFP+R4q
 aKozoy2oojxoq1Ave8GIhxeL93ocoA9/CF9JIc+dISZztDhJHeCBYkE+nW6evSbc+7EI
 cWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NV7x1nwKQefefjiR50/F9HWNP0Eyv5YxWPD+mxgxVTQ=;
 b=XoFk29+3I3jRZB/iH+0r3takpYRhGJQ9Vw/FcmLzVyp1Gph5VB48z2XFunlq4i/f/a
 zy1igVrJK0fjjqLXWXnsMgVINfZxyYykpJ4ID64pSNNYCRj1n6kcxYMqAvaNmIG0sd7z
 uNZYoJqYmzH5ZAV9SVjDLM4BxbTTkQA68RTRsncGaKDsUZEVGgde1cY39DTxXOZgxCTf
 kTRL3QmT6+R6QaZOIlzAHWp/6MUy7JjRbYN9c9Pwku/6+nNkNfJkKjIdLV3MLTCgf7Vn
 Fl0nk/Z8rrlPwJremMiZhGm+caSS+5NOFEkIcFnKjTim6z2RLNq0RfFxJugOyqSpgGHP
 p9Kg==
X-Gm-Message-State: AOAM532q5Ewztyfeequ3mgz+QvxkEsBB+Biutcg+gm+LDstkTrWeRhWW
 8NVpw/DJ+EEo3K2AoVD6c/DBtw==
X-Google-Smtp-Source: ABdhPJwOMlKf3X1qd4u7cuMfAiw+CwgsSxjdQOheSu63ap3Bbs+x4biX8FW4PjQfUroOF0I6HDSiEw==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr3296678wmi.58.1591372187361;
 Fri, 05 Jun 2020 08:49:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y14sm1500181wma.25.2020.06.05.08.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 08:49:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0527C1FF99;
 Fri,  5 Jun 2020 16:49:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 10/14] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
Date: Fri,  5 Jun 2020 16:49:25 +0100
Message-Id: <20200605154929.26910-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605154929.26910-1-alex.bennee@linaro.org>
References: <20200605154929.26910-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The purpose of vhost_section is to identify RAM regions that need to
be made available to a vhost client. However when running under TCG
all RAM sections have DIRTY_MEMORY_CODE set which leads to problems
down the line.

Re-factor the code so:

  - steps are clearer to follow
  - reason for rejection is recorded in the trace point
  - we allow DIRTY_MEMORY_CODE

We expand the comment to explain that kernel based vhost has specific
support for migration tracking.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Fabiano Rosas <farosas@linux.ibm.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200604134022.10564-1-alex.bennee@linaro.org>

---
v3
  - more tweaks to comments
  - merge the flag setting into one line
---
 hw/virtio/vhost.c      | 57 ++++++++++++++++++++++++++++++------------
 hw/virtio/trace-events |  3 ++-
 2 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index aff98a0ede5..e3e21812905 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,6 +27,7 @@
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
 #include "sysemu/dma.h"
+#include "sysemu/tcg.h"
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
@@ -403,26 +404,50 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
     return r;
 }
 
+/*
+ * vhost_section: identify sections needed for vhost access
+ *
+ * We only care about RAM sections here (where virtqueue and guest
+ * internals accessed by virtio might live). If we find one we still
+ * allow the backend to potentially filter it out of our list.
+ */
 static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
 {
-    bool result;
-    bool log_dirty = memory_region_get_dirty_log_mask(section->mr) &
-                     ~(1 << DIRTY_MEMORY_MIGRATION);
-    result = memory_region_is_ram(section->mr) &&
-        !memory_region_is_rom(section->mr);
-
-    /* Vhost doesn't handle any block which is doing dirty-tracking other
-     * than migration; this typically fires on VGA areas.
-     */
-    result &= !log_dirty;
+    MemoryRegion *mr = section->mr;
+
+    if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
+        uint8_t dirty_mask = memory_region_get_dirty_log_mask(mr);
+        uint8_t handled_dirty;
+
+        /*
+         * Kernel based vhost doesn't handle any block which is doing
+         * dirty-tracking other than migration for which it has
+         * specific logging support. However for TCG the kernel never
+         * gets involved anyway so we can also ignore it's
+         * self-modiying code detection flags. However a vhost-user
+         * client could still confuse a TCG guest if it re-writes
+         * executable memory that has already been translated.
+         */
+        handled_dirty = (1 << DIRTY_MEMORY_MIGRATION) |
+            (1 << DIRTY_MEMORY_CODE);
 
-    if (result && dev->vhost_ops->vhost_backend_mem_section_filter) {
-        result &=
-            dev->vhost_ops->vhost_backend_mem_section_filter(dev, section);
-    }
+        if (dirty_mask & ~handled_dirty) {
+            trace_vhost_reject_section(mr->name, 1);
+            return false;
+        }
+
+        if (dev->vhost_ops->vhost_backend_mem_section_filter &&
+            !dev->vhost_ops->vhost_backend_mem_section_filter(dev, section)) {
+            trace_vhost_reject_section(mr->name, 2);
+            return false;
+        }
 
-    trace_vhost_section(section->mr->name, result);
-    return result;
+        trace_vhost_section(mr->name);
+        return true;
+    } else {
+        trace_vhost_reject_section(mr->name, 3);
+        return false;
+    }
 }
 
 static void vhost_begin(MemoryListener *listener)
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index e83500bee92..6427a0047df 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -5,7 +5,8 @@ vhost_commit(bool started, bool changed) "Started: %d Changed: %d"
 vhost_region_add_section(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
 vhost_region_add_section_merge(const char *name, uint64_t new_size, uint64_t gpa, uint64_t owr) "%s: size: 0x%"PRIx64 " gpa: 0x%"PRIx64 " owr: 0x%"PRIx64
 vhost_region_add_section_aligned(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
-vhost_section(const char *name, int r) "%s:%d"
+vhost_section(const char *name) "%s"
+vhost_reject_section(const char *name, int d) "%s:%d"
 vhost_iotlb_miss(void *dev, int step) "%p step %d"
 
 # vhost-user.c
-- 
2.20.1


