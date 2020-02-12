Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A945C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E761020724
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ci+wOv5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E761020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sUs-0003Xp-4O
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sJv-00013B-GO
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sJt-0005CK-OY
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:44:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25766
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sJt-0005Br-KC
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581515089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paiODFbGD5fd47o3hrnj9jzAWs9R0kAqAVdxlWzm1Ig=;
 b=Ci+wOv5JiUuWZzudZDyxGRsmHQfZE+DcrcidU0OEfIH3z9xZ/uCRb17ACS7Qp8wo5zMwbM
 rF4CT4MTxVm4erteL0JuqDIZ2oMp0htWKbGO8VCFUHyd/24QsvVSsoHKx55fU+zT/XJH39
 FM/kPUW5JsDtXAfHkqfO3bft6ew+iPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-HNNGAaqFMSKuyypWtD84UA-1; Wed, 12 Feb 2020 08:44:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8226EDBCC;
 Wed, 12 Feb 2020 13:44:46 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 419961001281;
 Wed, 12 Feb 2020 13:44:44 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 fixed 16/16] exec: Ram blocks with resizable anonymous
 allocations under POSIX
Date: Wed, 12 Feb 2020 14:42:54 +0100
Message-Id: <20200212134254.11073-17-david@redhat.com>
In-Reply-To: <20200212134254.11073-1-david@redhat.com>
References: <20200212134254.11073-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: HNNGAaqFMSKuyypWtD84UA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can now make use of resizable anonymous allocations to implement
actually resizable ram blocks. Resizable anonymous allocations are
not implemented under WIN32 yet and are not available when using
alternative allocators. Fall back to the existing handling.

We also have to fallback to the existing handling in case any ram block
notifier does not support resizing (esp., AMD SEV, HAX) yet. Remember
in RAM_RESIZEABLE_ALLOC if we are using resizable anonymous allocations.

As the mmap()-hackery will invalidate some madvise settings, we have to
re-apply them after resizing. After resizing, notify the ram block
notifiers.

Try to grow early, as that can easily fail if out of memory. Shrink late
and ignore errors (nothing will actually break). Warn only.

The benefit of actually resizable ram blocks is that e.g., under Linux,
only the actual size will be reserved (even if
"/proc/sys/vm/overcommit_memory" is set to "never"). Additional memory will
be reserved when trying to resize, which allows to have ram blocks that
start small but can theoretically grow very large.

Note1: We are not able to create resizable ram blocks with pre-allocated
       memory yet, so prealloc is not affected.
Note2: mlock should work as it used to as os_mlock() does a
       mlockall(MCL_CURRENT | MCL_FUTURE), which includes future
       mappings.
Note3: Nobody should access memory beyond used_length. Memory notifiers
       already properly take care of this, only ram block notifiers
       violate this constraint and, therefore, have to be special-cased.
       Especially, any ram block notifier that might dynamically
       register at runtime (e.g., vfio), has to support resizes. Add an
       assert for that. Both, HAX and SEV register early, so they are
       fine.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Stefan Weil <sw@weilnetz.de>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c                    | 60 ++++++++++++++++++++++++++++++++++++---
 hw/core/numa.c            |  7 +++++
 include/exec/cpu-common.h |  2 ++
 include/exec/memory.h     |  8 ++++++
 4 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index f2d30479b8..71e32dcc11 100644
--- a/exec.c
+++ b/exec.c
@@ -2053,6 +2053,16 @@ void qemu_ram_unset_migratable(RAMBlock *rb)
     rb->flags &=3D ~RAM_MIGRATABLE;
 }
=20
+bool qemu_ram_is_resizable(RAMBlock *rb)
+{
+    return rb->flags & RAM_RESIZEABLE;
+}
+
+bool qemu_ram_is_resizable_alloc(RAMBlock *rb)
+{
+    return rb->flags & RAM_RESIZEABLE_ALLOC;
+}
+
 /* Called with iothread lock held.  */
 void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, DeviceState=
 *dev)
 {
@@ -2139,6 +2149,7 @@ static void qemu_ram_apply_settings(void *host, size_=
t length)
  */
 int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 {
+    const bool shared =3D block->flags & RAM_SHARED;
     const ram_addr_t oldsize =3D block->used_length;
=20
     assert(block);
@@ -2149,7 +2160,7 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsi=
ze, Error **errp)
         return 0;
     }
=20
-    if (!(block->flags & RAM_RESIZEABLE)) {
+    if (!qemu_ram_is_resizable(block)) {
         error_setg_errno(errp, EINVAL,
                          "Length mismatch: %s: 0x" RAM_ADDR_FMT
                          " in !=3D 0x" RAM_ADDR_FMT, block->idstr,
@@ -2165,6 +2176,12 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t news=
ize, Error **errp)
         return -EINVAL;
     }
=20
+    if (oldsize < newsize && qemu_ram_is_resizable_alloc(block) &&
+        !qemu_anon_ram_resize(block->host, oldsize, newsize, shared)) {
+        error_setg_errno(errp, -ENOMEM, "Cannot allocate enough memory.");
+        return -ENOMEM;
+    }
+
     cpu_physical_memory_clear_dirty_range(block->offset, block->used_lengt=
h);
     block->used_length =3D newsize;
     cpu_physical_memory_set_dirty_range(block->offset, block->used_length,
@@ -2178,6 +2195,21 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t news=
ize, Error **errp)
     if (block->resized) {
         block->resized(block->idstr, newsize, block->host);
     }
+
+    /*
+     * Shrinking will only fail in rare scenarios (e.g., maximum number of
+     * mappings reached), and can be ignored. Warn only.
+     */
+    if (newsize < oldsize && qemu_ram_is_resizable_alloc(block) &&
+        !qemu_anon_ram_resize(block->host, oldsize, newsize, shared)) {
+        warn_report("Shrinking memory allocation failed.");
+    }
+
+    if (block->host && qemu_ram_is_resizable_alloc(block)) {
+        /* re-apply settings that might have been overriden by the resize =
*/
+        qemu_ram_apply_settings(block->host, block->max_length);
+    }
+
     return 0;
 }
=20
@@ -2256,6 +2288,28 @@ static void dirty_memory_extend(ram_addr_t old_ram_s=
ize,
     }
 }
=20
+static void ram_block_alloc_ram(RAMBlock *rb)
+{
+    const bool shared =3D qemu_ram_is_shared(rb);
+
+    /*
+     * If we can, try to allocate actually resizable ram. Will also fail
+     * if qemu_anon_ram_alloc_resizable() is not implemented.
+     */
+    if (phys_mem_alloc =3D=3D qemu_anon_ram_alloc &&
+        qemu_ram_is_resizable(rb) &&
+        ram_block_notifiers_support_resize()) {
+        rb->host =3D qemu_anon_ram_alloc_resizable(rb->used_length,
+                                                 rb->max_length, &rb->mr->=
align,
+                                                 shared);
+        if (rb->host) {
+            rb->flags |=3D RAM_RESIZEABLE_ALLOC;
+            return;
+        }
+    }
+    rb->host =3D phys_mem_alloc(rb->max_length, &rb->mr->align, shared);
+}
+
 static void ram_block_add(RAMBlock *new_block, Error **errp)
 {
     RAMBlock *block;
@@ -2278,9 +2332,7 @@ static void ram_block_add(RAMBlock *new_block, Error =
**errp)
                 return;
             }
         } else {
-            new_block->host =3D phys_mem_alloc(new_block->max_length,
-                                             &new_block->mr->align,
-                                             qemu_ram_is_shared(new_block)=
);
+            ram_block_alloc_ram(new_block);
             if (!new_block->host) {
                 error_setg_errno(errp, errno,
                                  "cannot set up guest memory '%s'",
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 5b20dc726d..601cf9f603 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -907,6 +907,13 @@ static int ram_block_notify_add_single(RAMBlock *rb, v=
oid *opaque)
     RAMBlockNotifier *notifier =3D opaque;
=20
     if (host) {
+        /*
+         * Dynamically adding notifiers that don't support resizes is forb=
idden
+         * when dealing with resizable ram blocks that have actually resiz=
able
+         * allocations.
+         */
+        g_assert(!qemu_ram_is_resizable_alloc(rb) ||
+                 notifier->ram_block_resized);
         notifier->ram_block_added(notifier, host, size, max_size);
     }
     return 0;
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 9760ac9068..a9c76bd5ef 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -66,6 +66,8 @@ void qemu_ram_set_uf_zeroable(RAMBlock *rb);
 bool qemu_ram_is_migratable(RAMBlock *rb);
 void qemu_ram_set_migratable(RAMBlock *rb);
 void qemu_ram_unset_migratable(RAMBlock *rb);
+bool qemu_ram_is_resizable(RAMBlock *rb);
+bool qemu_ram_is_resizable_alloc(RAMBlock *rb);
=20
 size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e85b7de99a..19417943a2 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -129,6 +129,14 @@ typedef struct IOMMUNotifier IOMMUNotifier;
 /* RAM is a persistent kind memory */
 #define RAM_PMEM (1 << 5)
=20
+/*
+ * Implies RAM_RESIZEABLE. Memory beyond the used_length is inaccessible
+ * (esp. initially and after resizing). For such memory blocks, only the
+ * used_length is reserved in the OS - resizing might fail. Will only be
+ * used with host OS support and if all ram block notifiers support resizi=
ng.
+ */
+#define RAM_RESIZEABLE_ALLOC (1 << 6)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
--=20
2.24.1


