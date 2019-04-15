Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF48C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5079720825
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5079720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50304 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG1gy-00075V-K2
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 09:30:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1ds-0004jE-Tp
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1dr-00055i-4r
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hG1dq-000557-TN; Mon, 15 Apr 2019 09:27:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A70FFC04D30D;
	Mon, 15 Apr 2019 13:27:21 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 105C61001DDD;
	Mon, 15 Apr 2019 13:27:18 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Apr 2019 15:27:21 +0200
Message-Id: <1555334842-195718-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 15 Apr 2019 13:27:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 4/5] memory: make MemoryRegion alias
 migratable
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
Cc: qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
	Helge Deller <deller@gmx.de>, Cornelia Huck <cohuck@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
	=?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415132721.w7O3c9YMwm58aPSsueW1XIZOUJrppt8IHa3jZvKjOAY@z>

use qemu_ram_alloc_from_ptr() to create aliased RAMBlock
to the part of original memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 exec.c   | 7 ++++---
 memory.c | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/exec.c b/exec.c
index 6ab62f4..0fc10d1 100644
--- a/exec.c
+++ b/exec.c
@@ -2255,7 +2255,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
                                         new_block->used_length,
                                         DIRTY_CLIENTS_ALL);
 
-    if (new_block->host) {
+    if (new_block->host && !new_block->mr->alias) {
         qemu_ram_setup_dump(new_block->host, new_block->max_length);
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUGEPAGE);
         /* MADV_DONTFORK is also needed by KVM in absence of synchronous MMU */
@@ -2613,7 +2613,8 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
 
     rcu_read_lock();
     block = atomic_rcu_read(&ram_list.mru_block);
-    if (block && block->host && host - block->host < block->max_length) {
+    if (block && !block->mr->alias && block->host &&
+        host - block->host < block->max_length) {
         goto found;
     }
 
@@ -2622,7 +2623,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
         if (block->host == NULL) {
             continue;
         }
-        if (host - block->host < block->max_length) {
+        if (!block->mr->alias && host - block->host < block->max_length) {
             goto found;
         }
     }
diff --git a/memory.c b/memory.c
index 9fbca52..687a147 100644
--- a/memory.c
+++ b/memory.c
@@ -1672,6 +1672,11 @@ void memory_region_init_alias(MemoryRegion *mr,
     memory_region_init(mr, owner, name, size);
     mr->alias = orig;
     mr->alias_offset = offset;
+    if (orig->ram_block && size) {
+        mr->ram_block = qemu_ram_alloc_from_ptr(size,
+                                                orig->ram_block->host + offset,
+                                                mr, &error_fatal);
+    }
 }
 
 void memory_region_init_rom_nomigrate(MemoryRegion *mr,
-- 
2.7.4


