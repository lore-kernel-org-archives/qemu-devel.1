Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF479C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE8C2087E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE8C2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htU3p-0002y3-QW
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 05:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1htU1m-00072N-9L
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1htU1l-00010D-6W
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:39:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1htU1l-0000zn-1B; Fri, 02 Aug 2019 05:39:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56CAF83F45;
 Fri,  2 Aug 2019 09:39:08 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B56AB19C6A;
 Fri,  2 Aug 2019 09:39:06 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 05:38:53 -0400
Message-Id: <20190802093854.5343-4-imammedo@redhat.com>
In-Reply-To: <20190802093854.5343-1-imammedo@redhat.com>
References: <20190802093854.5343-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 02 Aug 2019 09:39:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC v2 3/4] memory: make MemoryRegion alias
 migratable
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, dgilbert@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

use qemu_ram_alloc_from_ptr() to create aliased RAMBlock
to the part of original memory region.

Change is migration safe as we do not migrate every existing RAMBlock
anymore, to make it migratable code has to explicitly call
vmstate_register_ram() on MemoryRegion that owns RAMBlock.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
PS:
tested ping-pong migration between new and old QEMU for x86 pc/q35
and s390 machines.

CC: dgilbert@redhat.com

 exec.c   | 9 +++++----
 memory.c | 6 ++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 3e78de3b8f..f5e9699632 100644
--- a/exec.c
+++ b/exec.c
@@ -2313,7 +2313,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
                                         new_block->used_length,
                                         DIRTY_CLIENTS_ALL);
 
-    if (new_block->host) {
+    if (new_block->host && !new_block->mr->alias) {
         qemu_ram_setup_dump(new_block->host, new_block->max_length);
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUGEPAGE);
         /* MADV_DONTFORK is also needed by KVM in absence of synchronous MMU */
@@ -2497,7 +2497,7 @@ void qemu_ram_free(RAMBlock *block)
         return;
     }
 
-    if (block->host) {
+    if (block->host && !block->mr->alias) {
         ram_block_notify_remove(block->host, block->max_length);
     }
 
@@ -2671,7 +2671,8 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
 
     rcu_read_lock();
     block = atomic_rcu_read(&ram_list.mru_block);
-    if (block && block->host && host - block->host < block->max_length) {
+    if (block && !block->mr->alias && block->host &&
+        host - block->host < block->max_length) {
         goto found;
     }
 
@@ -2680,7 +2681,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
         if (block->host == NULL) {
             continue;
         }
-        if (host - block->host < block->max_length) {
+        if (!block->mr->alias && host - block->host < block->max_length) {
             goto found;
         }
     }
diff --git a/memory.c b/memory.c
index 5d8c9a9234..d7c3609ce3 100644
--- a/memory.c
+++ b/memory.c
@@ -1678,6 +1678,12 @@ void memory_region_init_alias(MemoryRegion *mr,
     memory_region_init(mr, owner, name, size);
     mr->alias = orig;
     mr->alias_offset = offset;
+    if (orig->ram_block && size) {
+        mr->destructor = memory_region_destructor_ram;
+        mr->ram_block = qemu_ram_alloc_from_ptr(size,
+                                                orig->ram_block->host + offset,
+                                                mr, &error_fatal);
+    }
 }
 
 void memory_region_init_rom_nomigrate(MemoryRegion *mr,
-- 
2.18.1


