Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB94CC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1AE822D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AE822D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UmE-0004ZW-K0
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPl-000777-0c
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPj-0005ZA-PP
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0UPj-0005Yc-Gl
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DC46518C4260
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:28:50 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7942760E1C;
 Wed, 21 Aug 2019 17:28:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 19:28:19 +0200
Message-Id: <1566408501-48680-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
References: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Wed, 21 Aug 2019 17:28:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/13] memory: Fix up
 memory_region_{add|del}_coalescing
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
Cc: Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

The old memory_region_{add|clear}_coalescing() has some defects
because they both changed mr->coalesced before updating the regions
using memory_region_update_coalesced_range_as().  Then when the
regions were updated in memory_region_update_coalesced_range_as() the
mr->coalesced will always be either one more or one less.  So:

- For memory_region_add_coalescing: it'll always trying to remove the
  newly added coalesced region while it shouldn't, and,

- For memory_region_clear_coalescing: when it calls the update there
  will be no coalesced ranges on mr->coalesced because they were all
  removed before hand so the update will probably do nothing for real.

Let's fix this.  Now we've got flat_range_coalesced_io_notify() to
notify a single CoalescedMemoryRange instance change, so use it in the
existing memory_region_update_coalesced_range() logic by only notify
either an addition or deletion.  Then we hammer both the
memory_region_{add|clear}_coalescing() to use it.

Fixes: 3ac7d43a6fbb5d4a3
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190820141328.10009-5-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/memory.c b/memory.c
index 6e4b06e..7fd93b1 100644
--- a/memory.c
+++ b/memory.c
@@ -2243,27 +2243,26 @@ void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize, Error **errp
     qemu_ram_resize(mr->ram_block, newsize, errp);
 }
 
-static void memory_region_update_coalesced_range_as(MemoryRegion *mr, AddressSpace *as)
+/*
+ * Call proper memory listeners about the change on the newly
+ * added/removed CoalescedMemoryRange.
+ */
+static void memory_region_update_coalesced_range(MemoryRegion *mr,
+                                                 CoalescedMemoryRange *cmr,
+                                                 bool add)
 {
+    AddressSpace *as;
     FlatView *view;
     FlatRange *fr;
 
-    view = address_space_get_flatview(as);
-    FOR_EACH_FLAT_RANGE(fr, view) {
-        if (fr->mr == mr) {
-            flat_range_coalesced_io_del(fr, as);
-            flat_range_coalesced_io_add(fr, as);
-        }
-    }
-    flatview_unref(view);
-}
-
-static void memory_region_update_coalesced_range(MemoryRegion *mr)
-{
-    AddressSpace *as;
-
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-        memory_region_update_coalesced_range_as(mr, as);
+        view = address_space_get_flatview(as);
+        FOR_EACH_FLAT_RANGE(fr, view) {
+            if (fr->mr == mr) {
+                flat_range_coalesced_io_notify(fr, as, cmr, add);
+            }
+        }
+        flatview_unref(view);
     }
 }
 
@@ -2281,7 +2280,7 @@ void memory_region_add_coalescing(MemoryRegion *mr,
 
     cmr->addr = addrrange_make(int128_make64(offset), int128_make64(size));
     QTAILQ_INSERT_TAIL(&mr->coalesced, cmr, link);
-    memory_region_update_coalesced_range(mr);
+    memory_region_update_coalesced_range(mr, cmr, true);
     memory_region_set_flush_coalesced(mr);
 }
 
@@ -2299,10 +2298,9 @@ void memory_region_clear_coalescing(MemoryRegion *mr)
     while (!QTAILQ_EMPTY(&mr->coalesced)) {
         cmr = QTAILQ_FIRST(&mr->coalesced);
         QTAILQ_REMOVE(&mr->coalesced, cmr, link);
+        memory_region_update_coalesced_range(mr, cmr, false);
         g_free(cmr);
     }
-
-    memory_region_update_coalesced_range(mr);
 }
 
 void memory_region_set_flush_coalesced(MemoryRegion *mr)
-- 
1.8.3.1



