Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B752FC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9B62332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9B62332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51181 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UXq-0001B3-PR
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPe-0006vL-OP
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0UPd-0005Rd-Fu
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33624)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0UPd-0005QU-78
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:28:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 917211089041
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:28:44 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E1EF60E1C;
 Wed, 21 Aug 2019 17:28:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 19:28:17 +0200
Message-Id: <1566408501-48680-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
References: <1566408501-48680-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Wed, 21 Aug 2019 17:28:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 09/13] memory: Split zones when do
 coalesced_io_del()
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

It is a workaround of current KVM's KVM_UNREGISTER_COALESCED_MMIO
interface.  The kernel interface only allows to unregister an mmio
device with exactly the zone size when registered, or any smaller zone
that is included in the device mmio zone.  It does not support the
userspace to specify a very large zone to remove all the small mmio
devices within the zone covered.

Logically speaking it would be nicer to fix this from KVM side, though
in all cases we still need to coop with old kernels so let's do this.

Fixes: 3ac7d43a6fbb5d4a3
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190820141328.10009-2-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 49 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/memory.c b/memory.c
index 9a1193a..7124274 100644
--- a/memory.c
+++ b/memory.c
@@ -855,8 +855,39 @@ static void address_space_update_ioeventfds(AddressSpace *as)
     flatview_unref(view);
 }
 
+/*
+ * Notify the memory listeners about the coalesced IO change events of
+ * range `cmr'.  Only the part that has intersection of the specified
+ * FlatRange will be sent.
+ */
+static void flat_range_coalesced_io_notify(FlatRange *fr, AddressSpace *as,
+                                           CoalescedMemoryRange *cmr, bool add)
+{
+    AddrRange tmp;
+
+    tmp = addrrange_shift(cmr->addr,
+                          int128_sub(fr->addr.start,
+                                     int128_make64(fr->offset_in_region)));
+    if (!addrrange_intersects(tmp, fr->addr)) {
+        return;
+    }
+    tmp = addrrange_intersection(tmp, fr->addr);
+
+    if (add) {
+        MEMORY_LISTENER_UPDATE_REGION(fr, as, Forward, coalesced_io_add,
+                                      int128_get64(tmp.start),
+                                      int128_get64(tmp.size));
+    } else {
+        MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
+                                      int128_get64(tmp.start),
+                                      int128_get64(tmp.size));
+    }
+}
+
 static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
 {
+    CoalescedMemoryRange *cmr;
+
     if (!fr->has_coalesced_range) {
         return;
     }
@@ -865,16 +896,15 @@ static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
         return;
     }
 
-    MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
-                                  int128_get64(fr->addr.start),
-                                  int128_get64(fr->addr.size));
+    QTAILQ_FOREACH(cmr, &fr->mr->coalesced, link) {
+        flat_range_coalesced_io_notify(fr, as, cmr, false);
+    }
 }
 
 static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
 {
     MemoryRegion *mr = fr->mr;
     CoalescedMemoryRange *cmr;
-    AddrRange tmp;
 
     if (QTAILQ_EMPTY(&mr->coalesced)) {
         return;
@@ -885,16 +915,7 @@ static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
     }
 
     QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
-        tmp = addrrange_shift(cmr->addr,
-                              int128_sub(fr->addr.start,
-                                         int128_make64(fr->offset_in_region)));
-        if (!addrrange_intersects(tmp, fr->addr)) {
-            continue;
-        }
-        tmp = addrrange_intersection(tmp, fr->addr);
-        MEMORY_LISTENER_UPDATE_REGION(fr, as, Forward, coalesced_io_add,
-                                      int128_get64(tmp.start),
-                                      int128_get64(tmp.size));
+        flat_range_coalesced_io_notify(fr, as, cmr, true);
     }
 }
 
-- 
1.8.3.1



