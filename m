Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E00C4BA14
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23AF721556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3Did1uF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AF721556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6z2l-0007Sg-Ar
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 10:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j6z0J-0002aw-NI
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j6z0H-0002av-LZ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:53:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58677
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j6z0H-0002YS-Go
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582732420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M/NO9ujX8YYZ3QrrhXQKFjMK8w9A/HGCMrKEjwOf1Ew=;
 b=C3Did1uFkJM9oLhxmynw0EF2eFZVziIfOdLGMSoRLu7lF4QzY/Mj06EUS8Fd0ftQoSpEJf
 ozjSMwkgF4/1H2t/hcAanZS5d1k9cJqYICTpJb6XvaEXP6PzondRUrRtdEd6KSQ3XDaKpy
 sa0c6umxB8+VJ5PY75xBYRDeykDXiVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-UfpxVpTxPGiiAisvxOWLQw-1; Wed, 26 Feb 2020 10:53:39 -0500
X-MC-Unique: UfpxVpTxPGiiAisvxOWLQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDBCC881293;
 Wed, 26 Feb 2020 15:53:37 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDE10100E7E3;
 Wed, 26 Feb 2020 15:53:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/13] numa: Teach ram block notifiers about resizeable ram
 blocks
Date: Wed, 26 Feb 2020 16:52:54 +0100
Message-Id: <20200226155304.60219-4-david@redhat.com>
In-Reply-To: <20200226155304.60219-1-david@redhat.com>
References: <20200226155304.60219-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paul Durrant <paul@xen.org>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ram block notifiers are currently not aware of resizes. Especially to
handle resizes during migration, but also to implement actually resizeable
ram blocks (make everything between used_length and max_length
inaccessible), we want to teach ram block notifiers about resizeable
ram.

Introduce the basic infrastructure but keep using max_size in the
existing notifiers. Supply the max_size when adding and removing ram
blocks. Also, notify on resizes.

Acked-by: Paul Durrant <paul@xen.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xen-devel@lists.xenproject.org
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c                     | 13 +++++++++++--
 hw/core/numa.c             | 22 +++++++++++++++++-----
 hw/i386/xen/xen-mapcache.c |  7 ++++---
 include/exec/ramlist.h     | 13 +++++++++----
 target/i386/hax-mem.c      |  5 +++--
 target/i386/sev.c          | 18 ++++++++++--------
 util/vfio-helpers.c        | 16 ++++++++--------
 7 files changed, 62 insertions(+), 32 deletions(-)

diff --git a/exec.c b/exec.c
index b2a65b793f..3ee1498761 100644
--- a/exec.c
+++ b/exec.c
@@ -2078,6 +2078,8 @@ static int memory_try_enable_merging(void *addr, size=
_t len)
  */
 int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 {
+    const ram_addr_t oldsize =3D block->used_length;
+
     assert(block);
=20
     newsize =3D HOST_PAGE_ALIGN(newsize);
@@ -2102,6 +2104,11 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t news=
ize, Error **errp)
         return -EINVAL;
     }
=20
+    /* Notify before modifying the ram block and touching the bitmaps. */
+    if (block->host) {
+        ram_block_notify_resize(block->host, oldsize, newsize);
+    }
+
     cpu_physical_memory_clear_dirty_range(block->offset, block->used_lengt=
h);
     block->used_length =3D newsize;
     cpu_physical_memory_set_dirty_range(block->offset, block->used_length,
@@ -2268,7 +2275,8 @@ static void ram_block_add(RAMBlock *new_block, Error =
**errp, bool shared)
             qemu_madvise(new_block->host, new_block->max_length,
                          QEMU_MADV_DONTFORK);
         }
-        ram_block_notify_add(new_block->host, new_block->max_length);
+        ram_block_notify_add(new_block->host, new_block->used_length,
+                             new_block->max_length);
     }
 }
=20
@@ -2448,7 +2456,8 @@ void qemu_ram_free(RAMBlock *block)
     }
=20
     if (block->host) {
-        ram_block_notify_remove(block->host, block->max_length);
+        ram_block_notify_remove(block->host, block->used_length,
+                                block->max_length);
     }
=20
     qemu_mutex_lock_ramlist();
diff --git a/hw/core/numa.c b/hw/core/numa.c
index dc5e5b4046..fe6ca5c50d 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -857,11 +857,12 @@ void query_numa_node_mem(NumaNodeMem node_mem[], Mach=
ineState *ms)
 static int ram_block_notify_add_single(RAMBlock *rb, void *opaque)
 {
     const ram_addr_t max_size =3D qemu_ram_get_max_length(rb);
+    const ram_addr_t size =3D qemu_ram_get_used_length(rb);
     void *host =3D qemu_ram_get_host_addr(rb);
     RAMBlockNotifier *notifier =3D opaque;
=20
     if (host) {
-        notifier->ram_block_added(notifier, host, max_size);
+        notifier->ram_block_added(notifier, host, size, max_size);
     }
     return 0;
 }
@@ -878,20 +879,31 @@ void ram_block_notifier_remove(RAMBlockNotifier *n)
     QLIST_REMOVE(n, next);
 }
=20
-void ram_block_notify_add(void *host, size_t size)
+void ram_block_notify_add(void *host, size_t size, size_t max_size)
 {
     RAMBlockNotifier *notifier;
=20
     QLIST_FOREACH(notifier, &ram_list.ramblock_notifiers, next) {
-        notifier->ram_block_added(notifier, host, size);
+        notifier->ram_block_added(notifier, host, size, max_size);
     }
 }
=20
-void ram_block_notify_remove(void *host, size_t size)
+void ram_block_notify_remove(void *host, size_t size, size_t max_size)
 {
     RAMBlockNotifier *notifier;
=20
     QLIST_FOREACH(notifier, &ram_list.ramblock_notifiers, next) {
-        notifier->ram_block_removed(notifier, host, size);
+        notifier->ram_block_removed(notifier, host, size, max_size);
+    }
+}
+
+void ram_block_notify_resize(void *host, size_t old_size, size_t new_size)
+{
+    RAMBlockNotifier *notifier;
+
+    QLIST_FOREACH(notifier, &ram_list.ramblock_notifiers, next) {
+        if (notifier->ram_block_resized) {
+            notifier->ram_block_resized(notifier, host, old_size, new_size=
);
+        }
     }
 }
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index 5b120ed44b..d6dcea65d1 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -169,7 +169,8 @@ static void xen_remap_bucket(MapCacheEntry *entry,
=20
     if (entry->vaddr_base !=3D NULL) {
         if (!(entry->flags & XEN_MAPCACHE_ENTRY_DUMMY)) {
-            ram_block_notify_remove(entry->vaddr_base, entry->size);
+            ram_block_notify_remove(entry->vaddr_base, entry->size,
+                                    entry->size);
         }
         if (munmap(entry->vaddr_base, entry->size) !=3D 0) {
             perror("unmap fails");
@@ -211,7 +212,7 @@ static void xen_remap_bucket(MapCacheEntry *entry,
     }
=20
     if (!(entry->flags & XEN_MAPCACHE_ENTRY_DUMMY)) {
-        ram_block_notify_add(vaddr_base, size);
+        ram_block_notify_add(vaddr_base, size, size);
     }
=20
     entry->vaddr_base =3D vaddr_base;
@@ -452,7 +453,7 @@ static void xen_invalidate_map_cache_entry_unlocked(uin=
t8_t *buffer)
     }
=20
     pentry->next =3D entry->next;
-    ram_block_notify_remove(entry->vaddr_base, entry->size);
+    ram_block_notify_remove(entry->vaddr_base, entry->size, entry->size);
     if (munmap(entry->vaddr_base, entry->size) !=3D 0) {
         perror("unmap fails");
         exit(-1);
diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
index bc4faa1b00..293c0ddabe 100644
--- a/include/exec/ramlist.h
+++ b/include/exec/ramlist.h
@@ -65,15 +65,20 @@ void qemu_mutex_lock_ramlist(void);
 void qemu_mutex_unlock_ramlist(void);
=20
 struct RAMBlockNotifier {
-    void (*ram_block_added)(RAMBlockNotifier *n, void *host, size_t size);
-    void (*ram_block_removed)(RAMBlockNotifier *n, void *host, size_t size=
);
+    void (*ram_block_added)(RAMBlockNotifier *n, void *host, size_t size,
+                            size_t max_size);
+    void (*ram_block_removed)(RAMBlockNotifier *n, void *host, size_t size=
,
+                              size_t max_size);
+    void (*ram_block_resized)(RAMBlockNotifier *n, void *host, size_t old_=
size,
+                              size_t new_size);
     QLIST_ENTRY(RAMBlockNotifier) next;
 };
=20
 void ram_block_notifier_add(RAMBlockNotifier *n);
 void ram_block_notifier_remove(RAMBlockNotifier *n);
-void ram_block_notify_add(void *host, size_t size);
-void ram_block_notify_remove(void *host, size_t size);
+void ram_block_notify_add(void *host, size_t size, size_t max_size);
+void ram_block_notify_remove(void *host, size_t size, size_t max_size);
+void ram_block_notify_resize(void *host, size_t old_size, size_t new_size)=
;
=20
 void ram_block_dump(Monitor *mon);
=20
diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
index 6bb5a24917..454d7fb212 100644
--- a/target/i386/hax-mem.c
+++ b/target/i386/hax-mem.c
@@ -293,7 +293,8 @@ static MemoryListener hax_memory_listener =3D {
     .priority =3D 10,
 };
=20
-static void hax_ram_block_added(RAMBlockNotifier *n, void *host, size_t si=
ze)
+static void hax_ram_block_added(RAMBlockNotifier *n, void *host, size_t si=
ze,
+                                size_t max_size)
 {
     /*
      * We must register each RAM block with the HAXM kernel module, or
@@ -304,7 +305,7 @@ static void hax_ram_block_added(RAMBlockNotifier *n, vo=
id *host, size_t size)
      * host physical pages for the RAM block as part of this registration
      * process, hence the name hax_populate_ram().
      */
-    if (hax_populate_ram((uint64_t)(uintptr_t)host, size) < 0) {
+    if (hax_populate_ram((uint64_t)(uintptr_t)host, max_size) < 0) {
         fprintf(stderr, "HAX failed to populate RAM\n");
         abort();
     }
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 024bb24e51..6b4cee24a2 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -129,7 +129,8 @@ sev_set_guest_state(SevState new_state)
 }
=20
 static void
-sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
+sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
+                    size_t max_size)
 {
     int r;
     struct kvm_enc_region range;
@@ -146,19 +147,20 @@ sev_ram_block_added(RAMBlockNotifier *n, void *host, =
size_t size)
     }
=20
     range.addr =3D (__u64)(unsigned long)host;
-    range.size =3D size;
+    range.size =3D max_size;
=20
-    trace_kvm_memcrypt_register_region(host, size);
+    trace_kvm_memcrypt_register_region(host, max_size);
     r =3D kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
     if (r) {
         error_report("%s: failed to register region (%p+%#zx) error '%s'",
-                     __func__, host, size, strerror(errno));
+                     __func__, host, max_size, strerror(errno));
         exit(1);
     }
 }
=20
 static void
-sev_ram_block_removed(RAMBlockNotifier *n, void *host, size_t size)
+sev_ram_block_removed(RAMBlockNotifier *n, void *host, size_t size,
+                      size_t max_size)
 {
     int r;
     struct kvm_enc_region range;
@@ -175,13 +177,13 @@ sev_ram_block_removed(RAMBlockNotifier *n, void *host=
, size_t size)
     }
=20
     range.addr =3D (__u64)(unsigned long)host;
-    range.size =3D size;
+    range.size =3D max_size;
=20
-    trace_kvm_memcrypt_unregister_region(host, size);
+    trace_kvm_memcrypt_unregister_region(host, max_size);
     r =3D kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_UNREG_REGION, &range)=
;
     if (r) {
         error_report("%s: failed to unregister region (%p+%#zx)",
-                     __func__, host, size);
+                     __func__, host, max_size);
     }
 }
=20
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 260570ae19..9ec01bfe26 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -372,26 +372,26 @@ fail_container:
     return ret;
 }
=20
-static void qemu_vfio_ram_block_added(RAMBlockNotifier *n,
-                                      void *host, size_t size)
+static void qemu_vfio_ram_block_added(RAMBlockNotifier *n, void *host,
+                                      size_t size, size_t max_size)
 {
     QEMUVFIOState *s =3D container_of(n, QEMUVFIOState, ram_notifier);
     int ret;
=20
-    trace_qemu_vfio_ram_block_added(s, host, size);
-    ret =3D qemu_vfio_dma_map(s, host, size, false, NULL);
+    trace_qemu_vfio_ram_block_added(s, host, max_size);
+    ret =3D qemu_vfio_dma_map(s, host, max_size, false, NULL);
     if (ret) {
-        error_report("qemu_vfio_dma_map(%p, %zu) failed: %s", host, size,
+        error_report("qemu_vfio_dma_map(%p, %zu) failed: %s", host, max_si=
ze,
                      strerror(-ret));
     }
 }
=20
-static void qemu_vfio_ram_block_removed(RAMBlockNotifier *n,
-                                        void *host, size_t size)
+static void qemu_vfio_ram_block_removed(RAMBlockNotifier *n, void *host,
+                                        size_t size, size_t max_size)
 {
     QEMUVFIOState *s =3D container_of(n, QEMUVFIOState, ram_notifier);
     if (host) {
-        trace_qemu_vfio_ram_block_removed(s, host, size);
+        trace_qemu_vfio_ram_block_removed(s, host, max_size);
         qemu_vfio_dma_unmap(s, host);
     }
 }
--=20
2.24.1


