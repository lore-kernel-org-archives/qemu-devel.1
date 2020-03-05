Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C493C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 558B721556
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjGo08kC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558B721556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rcA-00082C-Fb
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j9rYZ-0001T9-Or
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:33:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j9rYY-00043Z-0g
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24835
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j9rYX-00043R-Sx
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583418777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OsFV3KXnft3QAx4jh0JvkZ2E+L4aGeQs3QCbGBQNM1E=;
 b=UjGo08kChPo/R52TV63VHRpfsPq5WzsLD2ear+L6Oov8EePduxYF2HHGWTxVlJ7E1suui7
 /UVA8LPPU4jxz4Jd+8J3mYTc5VFcI4KZ/19x9gwBm18Rx9BGOIl0C7IECGudYhEvKDsPsa
 Tab6b08e7VbOjF8J9tcGUIn4IV7YOmU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-ObxFzLjVM2WyJBHYKa-EFg-1; Thu, 05 Mar 2020 09:32:53 -0500
X-MC-Unique: ObxFzLjVM2WyJBHYKa-EFg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32832108BCAE;
 Thu,  5 Mar 2020 14:32:52 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-120-166.rdu2.redhat.com [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 141E191D7A;
 Thu,  5 Mar 2020 14:32:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 15/15] exec: Ram blocks with resizeable anonymous
 allocations under POSIX
Date: Thu,  5 Mar 2020 15:29:45 +0100
Message-Id: <20200305142945.216465-16-david@redhat.com>
In-Reply-To: <20200305142945.216465-1-david@redhat.com>
References: <20200305142945.216465-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can now make use of resizeable anonymous allocations to implement
actually resizeable ram blocks. Resizeable anonymous allocations are
not implemented under WIN32 yet and are not available when using
alternative allocators. Fall back to the existing handling.

We also have to fallback to the existing handling in case any ram block
notifier does not support resizing (esp., AMD SEV, HAX) yet. Remember
in RAM_RESIZEABLE_ALLOC if we are using resizeable anonymous allocations.

Try to grow early, as that can easily fail if out of memory. Shrink late
and ignore errors (nothing will actually break). Warn only.

The benefit of actually resizeable ram blocks is that e.g., under Linux,
only the actual size will be reserved (even if
"/proc/sys/vm/overcommit_memory" is set to "never"). Additional memory will
be reserved when trying to resize, which allows to have ram blocks that
start small but can theoretically grow very large.

Note1: We are not able to create resizeable ram blocks with pre-allocated
       memory yet, so prealloc is not affected.
Note2: mlock should work as it used to as os_mlock() does a
       mlockall(MCL_CURRENT | MCL_FUTURE), which includes future
       mappings.
Note3: Nobody should access memory beyond used_length. Memory notifiers
       already properly take care of this, only ram block notifiers
       violate this constraint and, therefore, have to be special-cased.
       Especially, any ram block notifier that might dynamically
       register at runtime (e.g., vfio) has to support resizes. Add an
       assert for that. Both, HAX and SEV register early, so they are
       fine.

Reviewed-by: Peter Xu <peterx@redhat.com>
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
 exec.c                    | 65 ++++++++++++++++++++++++++++++++++++---
 hw/core/numa.c            |  7 +++++
 include/exec/cpu-common.h |  2 ++
 include/exec/memory.h     |  8 +++++
 4 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/exec.c b/exec.c
index 9c3cc79193..6c6b6e12d2 100644
--- a/exec.c
+++ b/exec.c
@@ -2001,6 +2001,16 @@ void qemu_ram_unset_migratable(RAMBlock *rb)
     rb->flags &=3D ~RAM_MIGRATABLE;
 }
=20
+bool qemu_ram_is_resizeable(RAMBlock *rb)
+{
+    return rb->flags & RAM_RESIZEABLE;
+}
+
+bool qemu_ram_is_resizeable_alloc(RAMBlock *rb)
+{
+    return rb->flags & RAM_RESIZEABLE_ALLOC;
+}
+
 /* Called with iothread lock held.  */
 void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, DeviceState=
 *dev)
 {
@@ -2094,6 +2104,7 @@ static void qemu_ram_apply_settings(void *host, size_=
t length)
  */
 int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 {
+    const bool shared =3D block->flags & RAM_SHARED;
     const ram_addr_t oldsize =3D block->used_length;
=20
     assert(block);
@@ -2104,7 +2115,7 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsi=
ze, Error **errp)
         return 0;
     }
=20
-    if (!(block->flags & RAM_RESIZEABLE)) {
+    if (!qemu_ram_is_resizeable(block)) {
         error_setg_errno(errp, EINVAL,
                          "Length mismatch: %s: 0x" RAM_ADDR_FMT
                          " in !=3D 0x" RAM_ADDR_FMT, block->idstr,
@@ -2120,6 +2131,15 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t news=
ize, Error **errp)
         return -EINVAL;
     }
=20
+    if (oldsize < newsize && qemu_ram_is_resizeable_alloc(block)) {
+        if (!qemu_anon_ram_resize(block->host, oldsize, newsize, shared)) =
{
+            error_setg_errno(errp, -ENOMEM, "Cannot allocate enough memory=
.");
+            return -ENOMEM;
+        }
+        /* apply settings for the newly accessible memory */
+        qemu_ram_apply_settings(block->host + oldsize, newsize - oldsize);
+    }
+
     /* Notify before modifying the ram block and touching the bitmaps. */
     if (block->host) {
         ram_block_notify_resize(block->host, oldsize, newsize);
@@ -2133,6 +2153,16 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t news=
ize, Error **errp)
     if (block->resized) {
         block->resized(block->idstr, newsize, block->host);
     }
+
+    /*
+     * Shrinking will only fail in rare scenarios (e.g., maximum number of
+     * mappings reached), and can be ignored. Warn only.
+     */
+    if (newsize < oldsize && qemu_ram_is_resizeable_alloc(block) &&
+        !qemu_anon_ram_resize(block->host, oldsize, newsize, shared)) {
+        warn_report("Shrinking memory allocation failed.");
+    }
+
     return 0;
 }
=20
@@ -2211,6 +2241,29 @@ static void dirty_memory_extend(ram_addr_t old_ram_s=
ize,
     }
 }
=20
+static void ram_block_alloc_ram(RAMBlock *rb)
+{
+    const bool shared =3D qemu_ram_is_shared(rb);
+
+    assert(!(rb->flags & RAM_RESIZEABLE_ALLOC));
+    /*
+     * If we can, try to allocate actually resizeable ram. Will also fail
+     * if qemu_anon_ram_alloc_resizeable() is not implemented.
+     */
+    if (phys_mem_alloc =3D=3D qemu_anon_ram_alloc &&
+        qemu_ram_is_resizeable(rb) &&
+        ram_block_notifiers_support_resize()) {
+        rb->host =3D qemu_anon_ram_alloc_resizeable(rb->used_length,
+                                                  rb->max_length,
+                                                  &rb->mr->align, shared);
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
@@ -2233,9 +2286,7 @@ static void ram_block_add(RAMBlock *new_block, Error =
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
@@ -2280,7 +2331,11 @@ static void ram_block_add(RAMBlock *new_block, Error=
 **errp)
                                         DIRTY_CLIENTS_ALL);
=20
     if (new_block->host) {
-        qemu_ram_apply_settings(new_block->host, new_block->max_length);
+        if (qemu_ram_is_resizeable_alloc(new_block)) {
+            qemu_ram_apply_settings(new_block->host, new_block->used_lengt=
h);
+        } else {
+            qemu_ram_apply_settings(new_block->host, new_block->max_length=
);
+        }
         ram_block_notify_add(new_block->host, new_block->used_length,
                              new_block->max_length);
     }
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 1d5288c22c..c547549e49 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -862,6 +862,13 @@ static int ram_block_notify_add_single(RAMBlock *rb, v=
oid *opaque)
     RAMBlockNotifier *notifier =3D opaque;
=20
     if (host) {
+        /*
+         * Dynamically adding notifiers that don't support resizes is forb=
idden
+         * when dealing with resizeable ram blocks that have actually resi=
zeable
+         * allocations.
+         */
+        g_assert(!qemu_ram_is_resizeable_alloc(rb) ||
+                 notifier->ram_block_resized);
         notifier->ram_block_added(notifier, host, size, max_size);
     }
     return 0;
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 09decb8d93..aacbf33b85 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -66,6 +66,8 @@ void qemu_ram_set_uf_zeroable(RAMBlock *rb);
 bool qemu_ram_is_migratable(RAMBlock *rb);
 void qemu_ram_set_migratable(RAMBlock *rb);
 void qemu_ram_unset_migratable(RAMBlock *rb);
+bool qemu_ram_is_resizeable(RAMBlock *rb);
+bool qemu_ram_is_resizeable_alloc(RAMBlock *rb);
=20
 size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index b9b9470a56..74805dd448 100644
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


