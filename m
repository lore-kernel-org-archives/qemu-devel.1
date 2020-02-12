Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C51C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2085520659
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jerp3UMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2085520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sJx-0000e0-9u
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sC5-0002Zb-8g
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sC3-0006Qz-RR
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29648
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sC3-0006Qc-MK
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZUf9MBvUfXb89MQdNiypc4nmR7uxN7T1oAnnhpxVMFk=;
 b=Jerp3UMaRD60krAqYxr65eGHUfKs9JV7+MxO9aSyJm/tqaVlXdVmxd9GtFGgu+/a7dCbRu
 jfD+b8d1wCS+EP32u3FtIIAViSCVnYfWfxHwad66Seq0IwN8PDxddd0hVXMNpCXcYmS3Ww
 CPxrc1AVTJ7WV8DytYDLIzZqGI1Biyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-oLMdlnxAPYCTf40ncjO_xw-1; Wed, 12 Feb 2020 08:36:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC3C719057A1;
 Wed, 12 Feb 2020 13:36:38 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1092319C69;
 Wed, 12 Feb 2020 13:36:36 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/16] hostmem: Factor out common checks into
 host_memory_backend_validate()
Date: Wed, 12 Feb 2020 14:35:56 +0100
Message-Id: <20200212133601.10555-12-david@redhat.com>
In-Reply-To: <20200212133601.10555-1-david@redhat.com>
References: <20200212133601.10555-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: oLMdlnxAPYCTf40ncjO_xw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

All users want to perform similar checks. Lat's factor it out to prepare
for more checks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 backends/hostmem.c       | 14 ++++++++++++++
 hw/mem/pc-dimm.c         | 12 +++++-------
 hw/misc/ivshmem.c        | 11 ++++-------
 hw/virtio/virtio-mem.c   | 15 +++++----------
 hw/virtio/virtio-pmem.c  | 13 ++++---------
 include/sysemu/hostmem.h |  2 ++
 6 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 2c8e4567e1..de37f1bf5d 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -291,6 +291,20 @@ bool host_memory_backend_is_mapped(HostMemoryBackend *=
backend)
     return backend->is_mapped;
 }
=20
+void host_memory_backend_validate(HostMemoryBackend *backend,
+                                  const char *property, Error **errp)
+{
+    char *path =3D object_get_canonical_path_component(OBJECT(backend));
+
+    if (!backend) {
+        error_setg(errp, "'%s' property is not set", property);
+    } else if (host_memory_backend_is_mapped(backend)) {
+        error_setg(errp, "'%s' property specifies a busy memdev: %s",
+                   property, path);
+    }
+    g_free(path);
+}
+
 #ifdef __linux__
 size_t host_memory_backend_pagesize(HostMemoryBackend *memdev)
 {
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 8f50b8afea..9ee634ee89 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -174,16 +174,14 @@ static void pc_dimm_realize(DeviceState *dev, Error *=
*errp)
     PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
     MachineState *ms =3D MACHINE(qdev_get_machine());
     int nb_numa_nodes =3D ms->numa_state->num_nodes;
+    Error *err =3D NULL;
=20
-    if (!dimm->hostmem) {
-        error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property is not set");
-        return;
-    } else if (host_memory_backend_is_mapped(dimm->hostmem)) {
-        char *path =3D object_get_canonical_path_component(OBJECT(dimm->ho=
stmem));
-        error_setg(errp, "can't use already busy memdev: %s", path);
-        g_free(path);
+    host_memory_backend_validate(dimm->hostmem, PC_DIMM_MEMDEV_PROP, &err)=
;
+    if (err) {
+        error_propagate(errp, err);
         return;
     }
+
     if (((nb_numa_nodes > 0) && (dimm->node >=3D nb_numa_nodes)) ||
         (!nb_numa_nodes && dimm->node)) {
         error_setg(errp, "'DIMM property " PC_DIMM_NODE_PROP " has value %=
"
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 1a0fad74e1..39bffceadf 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1035,14 +1035,11 @@ static Property ivshmem_plain_properties[] =3D {
 static void ivshmem_plain_realize(PCIDevice *dev, Error **errp)
 {
     IVShmemState *s =3D IVSHMEM_COMMON(dev);
+    Error *err =3D NULL;
=20
-    if (!s->hostmem) {
-        error_setg(errp, "You must specify a 'memdev'");
-        return;
-    } else if (host_memory_backend_is_mapped(s->hostmem)) {
-        char *path =3D object_get_canonical_path_component(OBJECT(s->hostm=
em));
-        error_setg(errp, "can't use already busy memdev: %s", path);
-        g_free(path);
+    host_memory_backend_validate(s->hostmem, "memdev", &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
     }
=20
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 2f759578fe..4b7b4cf950 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -414,16 +414,11 @@ static void virtio_mem_device_realize(DeviceState *de=
v, Error **errp)
     uint64_t page_size;
=20
     /* verify the memdev */
-    if (!vm->memdev) {
-        error_setg(&local_err, "'%s' property must be set",
-                   VIRTIO_MEM_MEMDEV_PROP);
-        goto out;
-    } else if (host_memory_backend_is_mapped(vm->memdev)) {
-        char *path =3D object_get_canonical_path_component(OBJECT(vm->memd=
ev));
-
-        error_setg(&local_err, "can't use already busy memdev: %s", path);
-        g_free(path);
-        goto out;
+    host_memory_backend_validate(vm->memdev, VIRTIO_MEM_MEMDEV_PROP,
+                                 &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
     }
=20
     /* verify the node */
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index 97287e923b..85cb337ed5 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -105,16 +105,11 @@ static void virtio_pmem_realize(DeviceState *dev, Err=
or **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VirtIOPMEM *pmem =3D VIRTIO_PMEM(dev);
+    Error *err =3D NULL;
=20
-    if (!pmem->memdev) {
-        error_setg(errp, "virtio-pmem memdev not set");
-        return;
-    }
-
-    if (host_memory_backend_is_mapped(pmem->memdev)) {
-        char *path =3D object_get_canonical_path_component(OBJECT(pmem->me=
mdev));
-        error_setg(errp, "can't use already busy memdev: %s", path);
-        g_free(path);
+    host_memory_backend_validate(pmem->memdev, "memdev", &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
     }
=20
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 4dbdadd39e..d4dbf108ca 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -65,6 +65,8 @@ MemoryRegion *host_memory_backend_get_memory(HostMemoryBa=
ckend *backend);
=20
 void host_memory_backend_set_mapped(HostMemoryBackend *backend, bool mappe=
d);
 bool host_memory_backend_is_mapped(HostMemoryBackend *backend);
+void host_memory_backend_validate(HostMemoryBackend *backend,
+                                  const char *property, Error **errp);
 size_t host_memory_backend_pagesize(HostMemoryBackend *memdev);
 char *host_memory_backend_get_name(HostMemoryBackend *backend);
=20
--=20
2.24.1


