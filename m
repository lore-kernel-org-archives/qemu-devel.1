Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E1AC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C39C20721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+v49/QM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C39C20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygev-0003At-Dc
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iygWd-0000HT-DU
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iygWb-0002Wf-Ki
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28195
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iygWb-0002Vs-Eh
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580754765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBM8jyQDagczZDqEQCbJ/V7WjaqPEAqfu2ia6ljBAj4=;
 b=W+v49/QMcJm5iA/QhcbymQm0FAawFeceLjAoD+t9QMuaf+/4Xrun8hi63sVol+XjKnLc61
 K9PFL18ko8paoWaD3Ep8Xa6jIWg+YMts3nD1G4ggAyxJVaKBNwVUY5YfkmepGg30duZbRQ
 0FkuDNdga7GsMpI82fuMmdr4Na2OZeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-nRMtSB4_O56jRFtQH_uOFQ-1; Mon, 03 Feb 2020 13:32:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F15618B9FC3;
 Mon,  3 Feb 2020 18:32:37 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-77.ams2.redhat.com [10.36.117.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D01B5DA83;
 Mon,  3 Feb 2020 18:32:28 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 13/13] exec: Ram blocks with resizable anonymous
 allocations under POSIX
Date: Mon,  3 Feb 2020 19:31:25 +0100
Message-Id: <20200203183125.164879-14-david@redhat.com>
In-Reply-To: <20200203183125.164879-1-david@redhat.com>
References: <20200203183125.164879-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: nRMtSB4_O56jRFtQH_uOFQ-1
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
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
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

The benefit of actually resizable ram blocks is that e.g., under Linux,
only the actual size will be reserved (even if
"/proc/sys/vm/overcommit_memory" is set to "never"). Additional memory will
be reserved when trying to resize, which allows to have ram blocks that
start small but can theoretically grow very large.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Stefan Weil <sw@weilnetz.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c                    | 68 +++++++++++++++++++++++++++++++++++----
 hw/core/numa.c            | 10 ++++--
 include/exec/cpu-common.h |  2 ++
 include/exec/memory.h     |  8 +++++
 4 files changed, 79 insertions(+), 9 deletions(-)

diff --git a/exec.c b/exec.c
index fc65c4f7ca..a59d1efde3 100644
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
@@ -2139,6 +2149,8 @@ static void qemu_ram_apply_settings(void *host, size_=
t length)
  */
 int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 {
+    const uint64_t oldsize =3D block->used_length;
+
     assert(block);
=20
     newsize =3D HOST_PAGE_ALIGN(newsize);
@@ -2147,7 +2159,7 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsi=
ze, Error **errp)
         return 0;
     }
=20
-    if (!(block->flags & RAM_RESIZEABLE)) {
+    if (!qemu_ram_is_resizable(block)) {
         error_setg_errno(errp, EINVAL,
                          "Length mismatch: %s: 0x" RAM_ADDR_FMT
                          " in !=3D 0x" RAM_ADDR_FMT, block->idstr,
@@ -2163,10 +2175,26 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t new=
size, Error **errp)
         return -EINVAL;
     }
=20
+    if (qemu_ram_is_resizable_alloc(block)) {
+        g_assert(ram_block_notifiers_support_resize());
+        if (qemu_anon_ram_resize(block->host, block->used_length,
+                                 newsize, block->flags & RAM_SHARED) =3D=
=3D NULL) {
+            error_setg_errno(errp, -ENOMEM,
+                             "Could not allocate enough memory.");
+            return -ENOMEM;
+        }
+    }
+
     cpu_physical_memory_clear_dirty_range(block->offset, block->used_lengt=
h);
     block->used_length =3D newsize;
     cpu_physical_memory_set_dirty_range(block->offset, block->used_length,
                                         DIRTY_CLIENTS_ALL);
+    if (block->host && qemu_ram_is_resizable_alloc(block)) {
+        /* re-apply settings that might have been overriden by the resize =
*/
+        qemu_ram_apply_settings(block->host, block->max_length);
+        ram_block_notify_resized(block->host, oldsize, block->used_length)=
;
+    }
+
     memory_region_set_size(block->mr, newsize);
     if (block->resized) {
         block->resized(block->idstr, newsize, block->host);
@@ -2249,6 +2277,28 @@ static void dirty_memory_extend(ram_addr_t old_ram_s=
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
@@ -2271,9 +2321,7 @@ static void ram_block_add(RAMBlock *new_block, Error =
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
@@ -2319,7 +2367,11 @@ static void ram_block_add(RAMBlock *new_block, Error=
 **errp)
=20
     if (new_block->host) {
         qemu_ram_apply_settings(new_block->host, new_block->max_length);
-        ram_block_notify_add(new_block->host, new_block->max_length);
+        if (qemu_ram_is_resizable_alloc(new_block)) {
+            ram_block_notify_add(new_block->host, new_block->used_length);
+        } else {
+            ram_block_notify_add(new_block->host, new_block->max_length);
+        }
     }
 }
=20
@@ -2502,7 +2554,11 @@ void qemu_ram_free(RAMBlock *block)
     }
=20
     if (block->host) {
-        ram_block_notify_remove(block->host, block->max_length);
+        if (qemu_ram_is_resizable_alloc(block)) {
+            ram_block_notify_remove(block->host, block->used_length);
+        } else {
+            ram_block_notify_remove(block->host, block->max_length);
+        }
     }
=20
     qemu_mutex_lock_ramlist();
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 5ccfcbcd41..cb75097b26 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -901,12 +901,16 @@ void query_numa_node_mem(NumaNodeMem node_mem[], Mach=
ineState *ms)
=20
 static int ram_block_notify_add_single(RAMBlock *rb, void *opaque)
 {
-    ram_addr_t size =3D qemu_ram_get_max_length(rb);
     void *host =3D qemu_ram_get_host_addr(rb);
     RAMBlockNotifier *notifier =3D opaque;
=20
-    if (host) {
-        notifier->ram_block_added(notifier, host, size);
+    if (!host) {
+        return 0;
+    }
+    if (qemu_ram_is_resizable_alloc(rb)) {
+        notifier->ram_block_added(notifier, host, qemu_ram_get_used_length=
(rb));
+    } else {
+        notifier->ram_block_added(notifier, host, qemu_ram_get_max_length(=
rb));
     }
     return 0;
 }
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


