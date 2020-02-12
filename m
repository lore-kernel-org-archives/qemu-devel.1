Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A04C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4148B20873
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1+GqAIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4148B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sMa-00048d-87
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sCH-00031L-1T
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sCD-0006ZS-AO
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50887
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sCD-0006Z3-4S
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bTtXEQ8dqtzeP/iMuBtkOVb+vgeMWBv8YNFu0jiydM=;
 b=f1+GqAICYIZos2YhBknDkIMSIafRcd7AsxlZxpzU8JLndZ6u/NxDCz6SWMAL9RblkONyRS
 CCTDjhM9/hsUOfzCh8yDUurlMeVkmFKSnER+AIlaiAlC7oiDJLzAkY2qSN/T55SoBzVED3
 jA50tnlkoXJh9kSocWIeyI71GBLsZmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-GFHUODnPNnSs-TGdmLC1nA-1; Wed, 12 Feb 2020 08:36:51 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DDB5107ACC5;
 Wed, 12 Feb 2020 13:36:50 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77CEB19C69;
 Wed, 12 Feb 2020 13:36:48 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/16] virtio-mem: Support for resizable memory regions
Date: Wed, 12 Feb 2020 14:35:59 +0100
Message-Id: <20200212133601.10555-15-david@redhat.com>
In-Reply-To: <20200212133601.10555-1-david@redhat.com>
References: <20200212133601.10555-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: GFHUODnPNnSs-TGdmLC1nA-1
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
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 168 ++++++++++++++++++++++++++---------------
 1 file changed, 109 insertions(+), 59 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 093b6eb0bb..d28b501778 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -237,30 +237,78 @@ static void virtio_mem_unplug_request(VirtIOMEM *vm, =
VirtQueueElement *elem,
     virtio_mem_send_response_simple(vm, elem, type);
 }
=20
+/*
+ * Try to resize the usable region to hold at least the requested size.
+ */
+static void virtio_mem_resize_usable_region(VirtIOMEM *vm,
+                                            uint64_t requested_size,
+                                            Error **errp)
+{
+    /*
+     * If possible, we size the usable region a little bit bigger than the
+     * requested size, so the guest has more flexibility.
+     */
+    uint64_t newsize =3D MIN(memory_region_max_size(&vm->memdev->mr),
+                           requested_size + VIRTIO_MEM_USABLE_EXTENT);
+    Error *err =3D NULL;
+
+    /*
+     * Size it as small as possible (0 is not valid).
+     */
+    if (!requested_size) {
+        newsize =3D vm->block_size;
+    }
+
+    if (newsize =3D=3D vm->usable_region_size) {
+        return;
+    }
+
+    /* resize the memory region, if supported */
+    if (memory_region_is_resizable(&vm->memdev->mr)) {
+        memory_region_ram_resize(&vm->memdev->mr, newsize, &err);
+    }
+    if (!err) {
+        vm->usable_region_size =3D newsize;
+        fprintf(stderr, "New usable_region_size: %" PRIx64 "\n",
+                vm->usable_region_size);
+    }
+    error_propagate(errp, err);
+}
+
 /*
  * Unplug all memory and shrink the usable region.
  */
-static void virtio_mem_unplug_all(VirtIOMEM *vm)
+static int virtio_mem_unplug_all(VirtIOMEM *vm)
 {
+    Error *err =3D NULL;
+
+    if (virtio_mem_busy()) {
+        return -EBUSY;
+    }
+
+    virtio_mem_resize_usable_region(vm, vm->requested_size, &err);
+    if (err) {
+        /* It's unlikely that shrinking fails. */
+        warn_report_err(err);
+        return -ENOMEM;
+    }
     if (vm->size) {
-        virtio_mem_set_block_state(vm, vm->addr,
-                                   memory_region_size(&vm->memdev->mr), fa=
lse);
+        ram_block_discard_range(vm->memdev->mr.ram_block, 0,
+                                memory_region_size(&vm->memdev->mr));
+        bitmap_clear(vm->bitmap, 0, vm->bitmap_size);
         vm->size =3D 0;
     }
-    vm->usable_region_size =3D MIN(memory_region_size(&vm->memdev->mr),
-                                 vm->requested_size + VIRTIO_MEM_USABLE_EX=
TENT);
+    return 0;
 }
=20
 static void virtio_mem_unplug_all_request(VirtIOMEM *vm, VirtQueueElement =
*elem)
 {
=20
-    if (virtio_mem_busy()) {
+    if (virtio_mem_unplug_all(vm)) {
         virtio_mem_send_response_simple(vm, elem,  VIRTIO_MEM_RESP_BUSY);
-        return;
+    } else {
+        virtio_mem_send_response_simple(vm, elem,  VIRTIO_MEM_RESP_ACK);
     }
-
-    virtio_mem_unplug_all(vm);
-    virtio_mem_send_response_simple(vm, elem,  VIRTIO_MEM_RESP_ACK);
 }
=20
 static void virtio_mem_state_request(VirtIOMEM *vm, VirtQueueElement *elem=
,
@@ -344,7 +392,7 @@ static void virtio_mem_get_config(VirtIODevice *vdev, u=
int8_t *config_data)
     config->requested_size =3D cpu_to_le64(vm->requested_size);
     config->plugged_size =3D cpu_to_le64(vm->size);
     config->addr =3D cpu_to_le64(vm->addr);
-    config->region_size =3D cpu_to_le64(memory_region_size(&vm->memdev->mr=
));
+    config->region_size =3D cpu_to_le64(memory_region_max_size(&vm->memdev=
->mr));
     config->usable_region_size =3D cpu_to_le64(vm->usable_region_size);
 }
=20
@@ -370,10 +418,6 @@ static void virtio_mem_system_reset(void *opaque)
      * region size. This is, however, not possible in all scenarios. Then,
      * the guest has to deal with this manually (VIRTIO_MEM_REQ_UNPLUG_ALL=
).
      */
-    if (virtio_mem_busy()) {
-        return;
-    }
-
     virtio_mem_unplug_all(vm);
 }
=20
@@ -410,32 +454,32 @@ static void virtio_mem_device_realize(DeviceState *de=
v, Error **errp)
     int nb_numa_nodes =3D ms->numa_state ? ms->numa_state->num_nodes : 0;
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VirtIOMEM *vm =3D VIRTIO_MEM(dev);
-    Error *local_err =3D NULL;
+    Error *err =3D NULL;
     uint64_t page_size;
=20
     /* verify the memdev */
     host_memory_backend_validate(vm->memdev, VIRTIO_MEM_MEMDEV_PROP,
-                                 false, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                                 true, &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
     }
=20
     /* verify the node */
     if ((nb_numa_nodes && vm->node >=3D nb_numa_nodes) ||
         (!nb_numa_nodes && vm->node)) {
-        error_setg(&local_err, "Property '%s' has value '%" PRIu32
+        error_setg(errp, "Property '%s' has value '%" PRIu32
                    "', which exceeds the number of numa nodes: %d",
                    VIRTIO_MEM_NODE_PROP, vm->node,
                    nb_numa_nodes ? nb_numa_nodes : 1);
-        goto out;
+        return;
     }
=20
     /* mmap/madvise changes have to be reflected in guest physical memory =
*/
     if (kvm_enabled() && !kvm_has_sync_mmu()) {
-        error_set(&local_err, ERROR_CLASS_KVM_MISSING_CAP,
+        error_set(errp, ERROR_CLASS_KVM_MISSING_CAP,
                   "Using KVM without synchronous MMU, virtio-mem unavailab=
le");
-        goto out;
+        return;
     }
=20
     /*
@@ -443,8 +487,14 @@ static void virtio_mem_device_realize(DeviceState *dev=
, Error **errp)
      * to temporarily unlock and relock at the right places to make it wor=
k.
      */
     if (enable_mlock) {
-        error_setg(&local_err, "Memory is locked, virtio-mem unavailable")=
;
-        goto out;
+        error_setg(errp, "Memory is locked, virtio-mem unavailable");
+        return;
+    }
+
+    if (virtio_mem_busy()) {
+        error_setg(errp, "virtio-mem devices cannot be created while migra=
ting,"
+                   " while dumping, or when certain vfio devices are used.=
");
+        return;
     }
=20
     g_assert(memory_region_is_ram(&vm->memdev->mr));
@@ -458,37 +508,37 @@ static void virtio_mem_device_realize(DeviceState *de=
v, Error **errp)
      */
     page_size =3D qemu_ram_pagesize(vm->memdev->mr.ram_block);
     if (page_size !=3D getpagesize()) {
-        error_setg(&local_err, "'%s' page size (0x%" PRIx64 ") not support=
ed",
+        error_setg(errp, "'%s' page size (0x%" PRIx64 ") not supported",
                    VIRTIO_MEM_MEMDEV_PROP, page_size);
-        goto out;
+        return;
     }
=20
     /* now that memdev and block_size is fixed, verify the properties */
     if (vm->block_size < page_size) {
-        error_setg(&local_err, "'%s' has to be at least the page size (0x%=
"
+        error_setg(errp, "'%s' has to be at least the page size (0x%"
                    PRIx64 ")", VIRTIO_MEM_BLOCK_SIZE_PROP, page_size);
-        goto out;
+        return;
     } else if (!QEMU_IS_ALIGNED(vm->requested_size, vm->block_size)) {
         error_setg(errp, "'%s' has to be multiples of '%s' (0x%" PRIx32
                    ")", VIRTIO_MEM_REQUESTED_SIZE_PROP,
                    VIRTIO_MEM_BLOCK_SIZE_PROP, vm->block_size);
-    } else if (!QEMU_IS_ALIGNED(memory_region_size(&vm->memdev->mr),
+        return;
+    } else if (!QEMU_IS_ALIGNED(memory_region_max_size(&vm->memdev->mr),
                                 vm->block_size)) {
-        error_setg(&local_err, "'%s' size has to be multiples of '%s' (0x%=
"
+        error_setg(errp, "'%s' size has to be multiples of '%s' (0x%"
                    PRIx32 ")", VIRTIO_MEM_MEMDEV_PROP,
                    VIRTIO_MEM_BLOCK_SIZE_PROP, vm->block_size);
-        goto out;
+        return;
     }
=20
-    /*
-     * If possible, we size the usable region a little bit bigger than the
-     * requested size, so the guest has more flexibility.
-     */
-    vm->usable_region_size =3D MIN(memory_region_size(&vm->memdev->mr),
-                                 vm->requested_size + VIRTIO_MEM_USABLE_EX=
TENT);
+    virtio_mem_resize_usable_region(vm, vm->requested_size, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
=20
     /* allocate the bitmap for tracking the state of a block */
-    vm->bitmap_size =3D memory_region_size(&vm->memdev->mr) / vm->block_si=
ze;
+    vm->bitmap_size =3D memory_region_max_size(&vm->memdev->mr) / vm->bloc=
k_size;
     vm->bitmap =3D bitmap_new(vm->bitmap_size);
=20
     /* all memory is unplugged initially */
@@ -505,8 +555,6 @@ static void virtio_mem_device_realize(DeviceState *dev,=
 Error **errp)
     vm->postcopy_notifier.notify =3D virtio_mem_postcopy_notifier;
     postcopy_add_notifier(&vm->postcopy_notifier);
     qemu_register_reset(virtio_mem_system_reset, vm);
-out:
-    error_propagate(errp, local_err);
 }
=20
 static void virtio_mem_device_unrealize(DeviceState *dev, Error **errp)
@@ -603,7 +651,7 @@ static void virtio_mem_fill_device_info(const VirtIOMEM=
 *vmem,
     vi->node =3D vmem->node;
     vi->requested_size =3D vmem->requested_size;
     vi->size =3D vmem->size;
-    vi->max_size =3D memory_region_size(&vmem->memdev->mr);
+    vi->max_size =3D memory_region_max_size(&vmem->memdev->mr);
     vi->block_size =3D vmem->block_size;
     vi->memdev =3D object_get_canonical_path(OBJECT(vmem->memdev));
 }
@@ -651,14 +699,6 @@ static void virtio_mem_set_requested_size(Object *obj,=
 Visitor *v,
         return;
     }
=20
-    /* Growing the usable region might later not be possible, disallow it.=
 */
-    if (virtio_mem_busy() && value > vm->requested_size) {
-        error_setg(errp, "'%s' cannot be increased while migrating,"
-                   " while dumping, or when certain vfio devices are used.=
",
-                   name);
-        return;
-    }
-
     /*
      * The block size and memory backend are not fixed until the device wa=
s
      * realized. realize() will verify these properties then.
@@ -669,22 +709,32 @@ static void virtio_mem_set_requested_size(Object *obj=
, Visitor *v,
                        ")", name, VIRTIO_MEM_BLOCK_SIZE_PROP,
                        vm->block_size);
             return;
-        } else if (value > memory_region_size(&vm->memdev->mr)) {
+        } else if (value > memory_region_max_size(&vm->memdev->mr)) {
             error_setg(errp, "'%s' cannot exceed the memory backend size"
                        "(0x%" PRIx64 ")", name,
-                       memory_region_size(&vm->memdev->mr));
+                       memory_region_max_size(&vm->memdev->mr));
             return;
         }
=20
         if (value !=3D vm->requested_size) {
-            uint64_t tmp_size;
-
+            if (virtio_mem_busy()) {
+                error_setg(errp, "'%s' cannot be changed while migrating,"
+                           " while dumping, or when certain vfio devices a=
re used.",
+                           name);
+                return;
+            }
+
+            /* We are only allowed to grow the region */
+            if (value > vm->requested_size) {
+                Error *err =3D NULL;
+
+                virtio_mem_resize_usable_region(vm, value, &err);
+                if (err) {
+                    error_propagate(errp, err);
+                    return;
+                }
+            }
             vm->requested_size =3D value;
-
-            /* Grow the usable region if required */
-            tmp_size =3D MIN(memory_region_size(&vm->memdev->mr),
-                           vm->requested_size + VIRTIO_MEM_USABLE_EXTENT);
-            vm->usable_region_size =3D MAX(vm->usable_region_size, tmp_siz=
e);
         }
         /*
          * Trigger a config update so the guest gets notified. We trigger
--=20
2.24.1


