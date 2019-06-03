Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23A3C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98EE27C57
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98EE27C57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58750 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXguF-0003lA-Sv
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 02:57:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hXgoc-0007qV-MB
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hXgob-0002Nw-IN
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:51:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hXgob-0002N5-DO
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:51:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE63659468
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 06:51:28 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B4B23648B3;
	Mon,  3 Jun 2019 06:51:26 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 14:50:53 +0800
Message-Id: <20190603065056.25211-9-peterx@redhat.com>
In-Reply-To: <20190603065056.25211-1-peterx@redhat.com>
References: <20190603065056.25211-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Mon, 03 Jun 2019 06:51:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 08/11] kvm: Persistent per kvmslot dirty
 bitmap
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	peterx@redhat.com, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When synchronizing dirty bitmap from kernel KVM we do it in a
per-kvmslot fashion and we allocate the userspace bitmap for each of
the ioctl.  This patch instead make the bitmap cache be persistent
then we don't need to g_malloc0() every time.

More importantly, the cached per-kvmslot dirty bitmap will be further
used when we want to add support for the KVM_CLEAR_DIRTY_LOG and this
cached bitmap will be used to guarantee we won't clear any unknown
dirty bits otherwise that can be a severe data loss issue for
migration code.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c      | 10 +++++++---
 include/sysemu/kvm_int.h |  2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b686531586..9fb0694772 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -511,17 +511,19 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
          */
         size = ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
                      /*HOST_LONG_BITS*/ 64) / 8;
-        d.dirty_bitmap = g_malloc0(size);
+        if (!mem->dirty_bmap) {
+            /* Allocate on the first log_sync, once and for all */
+            mem->dirty_bmap = g_malloc0(size);
+        }
 
+        d.dirty_bitmap = mem->dirty_bmap;
         d.slot = mem->slot | (kml->as_id << 16);
         if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) == -1) {
             DPRINTF("ioctl failed %d\n", errno);
-            g_free(d.dirty_bitmap);
             return -1;
         }
 
         kvm_get_dirty_pages_log_range(section, d.dirty_bitmap);
-        g_free(d.dirty_bitmap);
     }
 
     return 0;
@@ -796,6 +798,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         }
 
         /* unregister the slot */
+        g_free(mem->dirty_bmap);
+        mem->dirty_bmap = NULL;
         mem->memory_size = 0;
         mem->flags = 0;
         err = kvm_set_user_memory_region(kml, mem, false);
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index f838412491..687a2ee423 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -21,6 +21,8 @@ typedef struct KVMSlot
     int slot;
     int flags;
     int old_flags;
+    /* Dirty bitmap cache for the slot */
+    unsigned long *dirty_bmap;
 } KVMSlot;
 
 typedef struct KVMMemoryListener {
-- 
2.17.1


