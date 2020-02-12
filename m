Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ACFC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D0420659
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWjk87Ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D0420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sFY-0001XS-AH
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sC6-0002bz-6B
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sC4-0006RX-Dr
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29112
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sC4-0006RF-9S
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VcVfEYyCpEvDzvqbCCpg9pqGNMCa9WNJ3J79QQ6zv3g=;
 b=NWjk87UgFg4Uo7xRCsGXtfyXyDXg3WngdnxK2lznbVDqFYBw6NVDF9fSHzSRffHQMgQpKP
 kS3mqnKyHjPXZ1V7+6HTf53WHqaSuQBELWhAwoUTspFIkBbvT2COGEl0pj7TRfQQcDW4vH
 fVMZ88Yb7ic4s+h3+62BUEC2oeJpOlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-bP6dwfD8MyyjoX6H5RWkxg-1; Wed, 12 Feb 2020 08:36:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9518107ACCC;
 Wed, 12 Feb 2020 13:36:40 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 280E119C69;
 Wed, 12 Feb 2020 13:36:38 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/16] hostmem: Introduce "managed-size" for
 memory-backend-ram
Date: Wed, 12 Feb 2020 14:35:57 +0100
Message-Id: <20200212133601.10555-13-david@redhat.com>
In-Reply-To: <20200212133601.10555-1-david@redhat.com>
References: <20200212133601.10555-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: bP6dwfD8MyyjoX6H5RWkxg-1
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
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtio-mem wants to make use of resizable memory regions. Allow to
create them by the user by specifying "managed-size".

Disallow setting "managed-size" with "prealloc" and "shared". The latter
might theoretically be possible, however has to be wired up internally
first.

Support for memory-backend-ram only for now. Support for other backends
(especially, hugepages), can be added later (and once e.g., virtio-mem
also supports hugepages).

When the memory region gets resized, apply the same settings just as when
allocating the memory.

Fence off the all such memory backends in all existing users. We'll
convert virtio-mem soon.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 backends/hostmem-ram.c   | 18 ++++++++--
 backends/hostmem.c       | 72 ++++++++++++++++++++++++++++++++++++++--
 hw/mem/pc-dimm.c         |  3 +-
 hw/misc/ivshmem.c        |  2 +-
 hw/virtio/virtio-mem.c   |  2 +-
 hw/virtio/virtio-pmem.c  |  2 +-
 include/sysemu/hostmem.h |  8 +++--
 7 files changed, 97 insertions(+), 10 deletions(-)

diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 6aab8d3a73..881276cf6b 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -29,8 +29,21 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Err=
or **errp)
     }
=20
     name =3D host_memory_backend_get_name(backend);
-    memory_region_init_ram_shared_nomigrate(&backend->mr, OBJECT(backend),=
 name,
-                           backend->size, backend->share, errp);
+    if (backend->managed_size) {
+        /*
+         * The size of a memory region must always be > 0 - start with 1. =
The
+         * managing object/device will resize accordingly.
+         */
+        g_assert(!backend->share);
+        memory_region_init_resizeable_ram(&backend->mr, OBJECT(backend), n=
ame,
+                                          1, backend->size,
+                                          host_memory_backend_resized,
+                                          errp);
+    } else {
+        memory_region_init_ram_shared_nomigrate(&backend->mr, OBJECT(backe=
nd),
+                                                name, backend->size,
+                                                backend->share, errp);
+    }
     g_free(name);
 }
=20
@@ -40,6 +53,7 @@ ram_backend_class_init(ObjectClass *oc, void *data)
     HostMemoryBackendClass *bc =3D MEMORY_BACKEND_CLASS(oc);
=20
     bc->alloc =3D ram_backend_memory_alloc;
+    bc->managed_size_supported =3D true;
 }
=20
 static const TypeInfo ram_backend_info =3D {
diff --git a/backends/hostmem.c b/backends/hostmem.c
index de37f1bf5d..c3c453753a 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -238,7 +238,10 @@ static void host_memory_backend_set_prealloc(Object *o=
bj, bool value,
         return;
     }
=20
-    if (value && !backend->prealloc) {
+    if (value && backend->managed_size) {
+        error_setg(errp, "'prealloc' is not compatible with 'managed-size'=
");
+        return;
+    } else if (value && !backend->prealloc) {
         int fd =3D memory_region_get_fd(&backend->mr);
         void *ptr =3D memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz =3D memory_region_size(&backend->mr);
@@ -292,7 +295,8 @@ bool host_memory_backend_is_mapped(HostMemoryBackend *b=
ackend)
 }
=20
 void host_memory_backend_validate(HostMemoryBackend *backend,
-                                  const char *property, Error **errp)
+                                  const char *property,
+                                  bool managed_size_support, Error **errp)
 {
     char *path =3D object_get_canonical_path_component(OBJECT(backend));
=20
@@ -301,6 +305,10 @@ void host_memory_backend_validate(HostMemoryBackend *b=
ackend,
     } else if (host_memory_backend_is_mapped(backend)) {
         error_setg(errp, "'%s' property specifies a busy memdev: %s",
                    property, path);
+    } else if (backend->managed_size && !managed_size_support) {
+        error_setg(errp,
+                   "'%s' property does not support a memdev with a managed=
 size: %s",
+                   property, path);
     }
     g_free(path);
 }
@@ -395,6 +403,24 @@ static void host_memory_backend_apply_settings(HostMem=
oryBackend *backend,
     }
 }
=20
+void host_memory_backend_resized(Object *owner, const char *idstr,
+                                 uint64_t size, void *host)
+{
+    HostMemoryBackend *backend =3D MEMORY_BACKEND(owner);
+    Error *local_err =3D NULL;
+
+    /*
+     * Just apply the settings for all (resized) memory again. Note that
+     * "shared" and "prealloc" is currently not compatible with resizable =
memory
+     * regions ("managed-size"). Warn only.
+     */
+    host_memory_backend_apply_settings(backend, &local_err);
+    if (local_err) {
+         warn_report_err(local_err);
+         local_err =3D NULL;
+    }
+}
+
 static void
 host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
 {
@@ -441,6 +467,9 @@ static void host_memory_backend_set_share(Object *o, bo=
ol value, Error **errp)
     if (host_memory_backend_mr_inited(backend)) {
         error_setg(errp, "cannot change property value");
         return;
+    } else if (value && backend->managed_size) {
+        error_setg(errp, "'prealloc' is not compatible with 'managed-size'=
");
+        return;
     }
     backend->share =3D value;
 }
@@ -462,6 +491,39 @@ host_memory_backend_set_use_canonical_path(Object *obj=
, bool value,
     backend->use_canonical_path =3D value;
 }
=20
+static bool
+ram_backend_get_managed_size(Object *obj, Error **errp)
+{
+    return MEMORY_BACKEND(obj)->managed_size;
+}
+
+static void
+ram_backend_set_managed_size(Object *obj, bool value, Error **errp)
+{
+    HostMemoryBackend *backend =3D MEMORY_BACKEND(obj);
+    HostMemoryBackendClass *bc =3D MEMORY_BACKEND_GET_CLASS(obj);
+
+    if (host_memory_backend_mr_inited(backend)) {
+        error_setg(errp, "cannot change property @managed_size'");
+        return;
+    } else if (value && !bc->managed_size_supported) {
+        error_setg(errp,
+                   "'managed-size' is not supported yet for %s",
+                   object_get_typename(obj));
+        return;
+    } else if (value && (backend->force_prealloc || backend->prealloc)) {
+        error_setg(errp,
+                   "'managed-size' is not compatible with preallocated mem=
ory");
+        return;
+    } else if (value && backend->share) {
+        error_setg(errp,
+                   "'managed-size' is not compatible with shared memory");
+        return;
+    }
+
+    backend->managed_size =3D value;
+}
+
 static void
 host_memory_backend_class_init(ObjectClass *oc, void *data)
 {
@@ -511,6 +573,12 @@ host_memory_backend_class_init(ObjectClass *oc, void *=
data)
     object_class_property_add_bool(oc, "x-use-canonical-path-for-ramblock-=
id",
         host_memory_backend_get_use_canonical_path,
         host_memory_backend_set_use_canonical_path, &error_abort);
+    object_class_property_add_bool(oc, "managed-size",
+                                   ram_backend_get_managed_size,
+                                   ram_backend_set_managed_size, &error_ab=
ort);
+    object_class_property_set_description(oc, "managed-size",
+        "The owner manages the actual size, 'size' is an upper limit",
+                                          &error_abort);
 }
=20
 static const TypeInfo host_memory_backend_info =3D {
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 9ee634ee89..5021cb347d 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -176,7 +176,8 @@ static void pc_dimm_realize(DeviceState *dev, Error **e=
rrp)
     int nb_numa_nodes =3D ms->numa_state->num_nodes;
     Error *err =3D NULL;
=20
-    host_memory_backend_validate(dimm->hostmem, PC_DIMM_MEMDEV_PROP, &err)=
;
+    host_memory_backend_validate(dimm->hostmem, PC_DIMM_MEMDEV_PROP, false=
,
+                                 &err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 39bffceadf..69d16c2dca 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1037,7 +1037,7 @@ static void ivshmem_plain_realize(PCIDevice *dev, Err=
or **errp)
     IVShmemState *s =3D IVSHMEM_COMMON(dev);
     Error *err =3D NULL;
=20
-    host_memory_backend_validate(s->hostmem, "memdev", &err);
+    host_memory_backend_validate(s->hostmem, "memdev", false, &err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 4b7b4cf950..093b6eb0bb 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -415,7 +415,7 @@ static void virtio_mem_device_realize(DeviceState *dev,=
 Error **errp)
=20
     /* verify the memdev */
     host_memory_backend_validate(vm->memdev, VIRTIO_MEM_MEMDEV_PROP,
-                                 &local_err);
+                                 false, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index 85cb337ed5..51f01e52fd 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -107,7 +107,7 @@ static void virtio_pmem_realize(DeviceState *dev, Error=
 **errp)
     VirtIOPMEM *pmem =3D VIRTIO_PMEM(dev);
     Error *err =3D NULL;
=20
-    host_memory_backend_validate(pmem->memdev, "memdev", &err);
+    host_memory_backend_validate(pmem->memdev, "memdev", false, &err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index d4dbf108ca..f5ef7016bc 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -37,6 +37,7 @@ struct HostMemoryBackendClass {
     ObjectClass parent_class;
=20
     void (*alloc)(HostMemoryBackend *backend, Error **errp);
+    bool managed_size_supported;
 };
=20
 /**
@@ -53,7 +54,7 @@ struct HostMemoryBackend {
     /* protected */
     uint64_t size;
     bool merge, dump, use_canonical_path;
-    bool prealloc, force_prealloc, is_mapped, share;
+    bool prealloc, force_prealloc, is_mapped, share, managed_size;
     DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
     HostMemPolicy policy;
=20
@@ -61,12 +62,15 @@ struct HostMemoryBackend {
 };
=20
 bool host_memory_backend_mr_inited(HostMemoryBackend *backend);
+void host_memory_backend_resized(Object *owner, const char *idstr,
+                                 uint64_t size, void *host);
 MemoryRegion *host_memory_backend_get_memory(HostMemoryBackend *backend);
=20
 void host_memory_backend_set_mapped(HostMemoryBackend *backend, bool mappe=
d);
 bool host_memory_backend_is_mapped(HostMemoryBackend *backend);
 void host_memory_backend_validate(HostMemoryBackend *backend,
-                                  const char *property, Error **errp);
+                                  const char *property,
+                                  bool managed_size_support, Error **errp)=
;
 size_t host_memory_backend_pagesize(HostMemoryBackend *memdev);
 char *host_memory_backend_get_name(HostMemoryBackend *backend);
=20
--=20
2.24.1


