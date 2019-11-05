Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DACC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 23:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C232087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 23:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUPeAAFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C232087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS8Vf-0000S5-L8
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 18:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iS8SI-0005gy-6b
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iS8SG-0004i8-KI
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:41:46 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40844)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iS8SG-0004hU-CB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:41:44 -0500
Received: by mail-wm1-x342.google.com with SMTP id f3so1287677wmc.5
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 15:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Sy5cjMuouBWQH2G8fTg0cVy6rCUVCOD5IYH6fYB1xWE=;
 b=uUPeAAFWpsQVgDgX9zK629s/MRIZYqBMA0FkLiJ+dStO1CsqkRMZDjT5RjUrxtr7UM
 wEu1502lhzwyB0p0X39wmN1PL4v58XvjhzGF/n1yD4edCwvXmuQuxVzN/uabeWa8hVMA
 H02fxKdt5547GpIbXOdfQF1u+SPzdTIENnkrFdIpXVBKtKXCCbdwtCkaocUiLsNqeWdW
 XZ6enM+vKC11nJta6W4iZsL1KS0IfjH/M6rfP8JVImloT+0oPCxmQ+Duz59oeuaAvbZ9
 7pBzvWbx0rnPRFJm9er3B/ArQxP1yujQxvYDOl8FLaUL4+qbSfzH+wkD+Dba0cJlSr/K
 GbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Sy5cjMuouBWQH2G8fTg0cVy6rCUVCOD5IYH6fYB1xWE=;
 b=IwvzzKVDxVY8jji2WGkRXSeu00amH1oe19dhOFK7r7cx2m2Hx82z3fjUAdAbTtf160
 +ZW/Eg/ttrOoDXfrvi26B4we5WfsrJA7mqfAiRaOAibGp8MF8eqNmdCtiRtS1i1xAfoP
 Zt8xL8KMSmN3NcKSxcrdHZT2+d90iIU6gtm2nU+Z62QeQ08iza8CJG1K+fVyBJ5cFdGI
 +2WoOwVe48VYPHT1gpIEreuiE7Tw9o+XV021DOXAccIEIGlZ74Zb7jot1zmPf/VfxSpR
 CxTO09Q1PwiJaU7UekTW7WWC7BXIa41fFzz6PzE/SHe2/YNQqSSk4qDcmKbTHpOssvE8
 MmSw==
X-Gm-Message-State: APjAAAUfFcPTxZdxazA2ZkUvFCsinZgTvnpr/vcDBTmGnD57NqHx2DC9
 eLTNPyXaPYKfe29U9C2xWextpftpdJZFkQ==
X-Google-Smtp-Source: APXvYqy4a1ZnKMeH/iJh6Aqh/1SQt4byy5bsJhpPafnwYqoagdkX6GmiD+8k/u0Psncw1+fwkQWDcw==
X-Received: by 2002:a1c:558a:: with SMTP id j132mr1251077wmb.21.1572997302646; 
 Tue, 05 Nov 2019 15:41:42 -0800 (PST)
Received: from moi-limbo-9350.home
 (host86-144-13-94.range86-144.btcentralplus.com. [86.144.13.94])
 by smtp.gmail.com with ESMTPSA id q25sm27295010wra.3.2019.11.05.15.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 15:41:42 -0800 (PST)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] Memory: Enable writeback for given memory region
Date: Tue,  5 Nov 2019 23:40:58 +0000
Message-Id: <20191105234100.22052-3-beata.michalska@linaro.org>
In-Reply-To: <20191105234100.22052-1-beata.michalska@linaro.org>
References: <20191105234100.22052-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, richard.henderson@linaro.org,
 dgilbert@redhat.com, shameerali.kolothum.thodi@huawei.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an option to trigger memory writeback to sync given memory region
with the corresponding backing store, case one is available.
This extends the support for persistent memory, allowing syncing on-demand.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
---
 exec.c                  | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/exec/memory.h   |  6 ++++++
 include/exec/ram_addr.h |  8 ++++++++
 include/qemu/cutils.h   |  1 +
 memory.c                | 12 ++++++++++++
 util/cutils.c           | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 117 insertions(+)

diff --git a/exec.c b/exec.c
index ffdb518..e1f06de 100644
--- a/exec.c
+++ b/exec.c
@@ -65,6 +65,8 @@
 #include "exec/ram_addr.h"
 #include "exec/log.h"
 
+#include "qemu/pmem.h"
+
 #include "migration/vmstate.h"
 
 #include "qemu/range.h"
@@ -2156,6 +2158,47 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
     return 0;
 }
 
+/*
+ * Trigger sync on the given ram block for range [start, start + length]
+ * with the backing store if one is available.
+ * Otherwise no-op.
+ * @Note: this is supposed to be a synchronous op.
+ */
+void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length)
+{
+    void *addr = ramblock_ptr(block, start);
+
+    /*
+     * The requested range might spread up to the very end of the block
+     */
+    if ((start + length) > block->used_length) {
+        qemu_log("%s: sync range outside the block boundaries: "
+                     "start: " RAM_ADDR_FMT " length: " RAM_ADDR_FMT
+                     " block length: " RAM_ADDR_FMT " Narrowing down ..." ,
+                     __func__, start, length, block->used_length);
+        length = block->used_length - start;
+    }
+
+#ifdef CONFIG_LIBPMEM
+    /* The lack of support for pmem should not block the sync */
+    if (ramblock_is_pmem(block)) {
+        pmem_persist(addr, length);
+    } else
+#endif
+    if (block->fd >= 0) {
+        /**
+         * Case there is no support for PMEM or the memory has not been
+         * specified as persistent (or is not one) - use the msync.
+         * Less optimal but still achieves the same goal
+         */
+        if (qemu_msync(addr, length, qemu_host_page_size, block->fd)) {
+            warn_report("%s: failed to sync memory range: start: "
+                    RAM_ADDR_FMT " length: " RAM_ADDR_FMT,
+                    __func__, start, length);
+        }
+    }
+}
+
 /* Called with ram_list.mutex held */
 static void dirty_memory_extend(ram_addr_t old_ram_size,
                                 ram_addr_t new_ram_size)
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e499dc2..27a84e0 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1265,6 +1265,12 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr);
  */
 void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize,
                               Error **errp);
+/**
+ * memory_region_do_writeback: Trigger writeback for selected address range
+ * [addr, addr + size]
+ *
+ */
+void memory_region_do_writeback(MemoryRegion *mr, hwaddr addr, hwaddr size);
 
 /**
  * memory_region_set_log: Turn dirty logging on or off for a region.
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index bed0554..5adebb0 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -174,6 +174,14 @@ void qemu_ram_free(RAMBlock *block);
 
 int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
 
+void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length);
+
+/* Clear whole block of mem */
+static inline void qemu_ram_block_writeback(RAMBlock *block)
+{
+    qemu_ram_writeback(block, 0, block->used_length);
+}
+
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
 #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
 
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index b54c847..41c5fa9 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -130,6 +130,7 @@ const char *qemu_strchrnul(const char *s, int c);
 #endif
 time_t mktimegm(struct tm *tm);
 int qemu_fdatasync(int fd);
+int qemu_msync(void *addr, size_t length, size_t alignment, int fd);
 int fcntl_setfl(int fd, int flag);
 int qemu_parse_fd(const char *param);
 int qemu_strtoi(const char *nptr, const char **endptr, int base,
diff --git a/memory.c b/memory.c
index c952eab..15734a0 100644
--- a/memory.c
+++ b/memory.c
@@ -2214,6 +2214,18 @@ void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize, Error **errp
     qemu_ram_resize(mr->ram_block, newsize, errp);
 }
 
+
+void memory_region_do_writeback(MemoryRegion *mr, hwaddr addr, hwaddr size)
+{
+    /*
+     * Might be extended case needed to cover
+     * different types of memory regions
+     */
+    if (mr->ram_block && mr->dirty_log_mask) {
+        qemu_ram_writeback(mr->ram_block, addr, size);
+    }
+}
+
 /*
  * Call proper memory listeners about the change on the newly
  * added/removed CoalescedMemoryRange.
diff --git a/util/cutils.c b/util/cutils.c
index fd591ca..7a50dbc 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -164,6 +164,53 @@ int qemu_fdatasync(int fd)
 #endif
 }
 
+/**
+ * Sync changes made to the memory mapped file back to the backing
+ * storage. For POSIX compliant systems this will simply fallback
+ * to regular msync call (thus the required alignment). Otherwise
+ * it will trigger whole file sync (including the metadata case
+ * there is no support to skip that otherwise)
+ *
+ * @addr   - start of the memory area to be synced
+ * @length - length of the are to be synced
+ * @align  - alignment (expected to be PAGE_SIZE)
+ * @fd     - file descriptor for the file to be synced
+ *           (mandatory only for POSIX non-compliant systems)
+ */
+int qemu_msync(void *addr, size_t length, size_t align, int fd)
+{
+#ifdef CONFIG_POSIX
+    size_t align_mask;
+
+    /* Bare minimum of sanity checks on the alignment */
+    /* The start address needs to be a multiple of PAGE_SIZE */
+    align = MAX(align, qemu_real_host_page_size);
+    align_mask = ~(qemu_real_host_page_size - 1);
+    align = (align + ~align_mask) & align_mask;
+
+    align_mask = ~(align - 1);
+    /**
+     * There are no strict reqs as per the length of mapping
+     * to be synced. Still the length needs to follow the address
+     * alignment changes. Additionally - round the size to the multiple
+     * of requested alignment (expected as PAGE_SIZE)
+     */
+    length += ((uintptr_t)addr & (align - 1));
+    length = (length + ~align_mask) & align_mask;
+
+    addr = (void *)((uintptr_t)addr & align_mask);
+
+    return msync(addr, length, MS_SYNC);
+#else /* CONFIG_POSIX */
+    /**
+     * Perform the sync based on the file descriptor
+     * The sync range will most probably be wider than the one
+     * requested - but it will still get the job done
+     */
+    return qemu_fdatasync(fd);
+#endif /* CONFIG_POSIX */
+}
+
 #ifndef _WIN32
 /* Sets a specific flag */
 int fcntl_setfl(int fd, int flag)
-- 
2.7.4


