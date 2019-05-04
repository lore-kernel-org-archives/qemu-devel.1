Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51D3C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9882D206DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9882D206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51504 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnTH-000590-M7
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 01:44:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hMnSQ-0004s8-AG
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hMnSP-0007u2-BN
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:43:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:56092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hMnSP-0007rR-2A
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:43:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	03 May 2019 22:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,428,1549958400"; d="scan'208";a="296895795"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga004.jf.intel.com with ESMTP; 03 May 2019 22:43:24 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Sat,  4 May 2019 13:42:55 +0800
Message-Id: <20190504054255.8610-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.31
Subject: [Qemu-devel] [PATCH] migration: don't set MIGRATION dirty range for
 ignored block
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: quintela@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com,
	Wei Yang <richardw.yang@linux.intel.com>, pbonzini@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504054255.EPqRab81GWjzasfto5NHBE7r54FkFT0bBrrMb-ukF-o@z>

The ignored blocks are not migrated and those ranges are not used.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 exec.c                  | 4 +++-
 include/exec/ram_addr.h | 2 ++
 migration/ram.c         | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index 86a38d3b3b..97da155c12 100644
--- a/exec.c
+++ b/exec.c
@@ -2192,6 +2192,8 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
     RAMBlock *last_block = NULL;
     ram_addr_t old_ram_size, new_ram_size;
     Error *err = NULL;
+    uint8_t dirty_memory_clients = ramblock_is_ignored(new_block) ?
+                         DIRTY_CLIENTS_NOMIG : DIRTY_CLIENTS_ALL;
 
     old_ram_size = last_ram_page();
 
@@ -2252,7 +2254,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
 
     cpu_physical_memory_set_dirty_range(new_block->offset,
                                         new_block->used_length,
-                                        DIRTY_CLIENTS_ALL);
+                                        dirty_memory_clients);
 
     if (new_block->host) {
         qemu_ram_setup_dump(new_block->host, new_block->max_length);
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index a7c81bdb32..4765435fb8 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -72,6 +72,7 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
 }
 
 bool ramblock_is_pmem(RAMBlock *rb);
+bool ramblock_is_ignored(RAMBlock *rb);
 
 long qemu_getrampagesize(void);
 
@@ -117,6 +118,7 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
 
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
 #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
+#define DIRTY_CLIENTS_NOMIG   (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_MIGRATION))
 
 void tb_invalidate_phys_range(ram_addr_t start, ram_addr_t end);
 
diff --git a/migration/ram.c b/migration/ram.c
index 1def8122e9..44525e3816 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -159,7 +159,7 @@ out:
     return ret;
 }
 
-static bool ramblock_is_ignored(RAMBlock *block)
+bool ramblock_is_ignored(RAMBlock *block)
 {
     return !qemu_ram_is_migratable(block) ||
            (migrate_ignore_shared() && qemu_ram_is_shared(block));
-- 
2.19.1


