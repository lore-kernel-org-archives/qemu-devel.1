Received: from eggs.gnu.org ([2001:4830:134:3::10]:48737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBbx-0006R9-C6
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBbw-0000Fv-AR
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:23:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gUBbw-0000FZ-3H
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:23:40 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A66F3082AFD
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 14:23:39 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  4 Dec 2018 18:20:23 +0400
Message-Id: <20181204142023.15982-20-marcandre.lureau@redhat.com>
In-Reply-To: <20181204142023.15982-1-marcandre.lureau@redhat.com>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v5 19/19] hostmem: use object id for
 memory region name with >= 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

hostmem-file and hostmem-memfd use the whole object path for the
memory region name, and hostname-ram uses only the path component (the
object id, or canonical path basename):

qemu -m 1024 -object memory-backend-file,id=3Dmem,size=3D1G,mem-path=3D/t=
mp/foo -numa node,memdev=3Dmem -monitor stdio
(qemu) info ramblock
              Block Name    PSize              Offset               Used =
             Total
            /objects/mem    4 KiB  0x0000000000000000 0x0000000040000000 =
0x0000000040000000

qemu -m 1024 -object memory-backend-memfd,id=3Dmem,size=3D1G -numa node,m=
emdev=3Dmem -monitor stdio
(qemu) info ramblock
              Block Name    PSize              Offset               Used =
             Total
            /objects/mem    4 KiB  0x0000000000000000 0x0000000040000000 =
0x0000000040000000

qemu -m 1024 -object memory-backend-ram,id=3Dmem,size=3D1G -numa node,mem=
dev=3Dmem -monitor stdio
(qemu) info ramblock
              Block Name    PSize              Offset               Used =
             Total
                     mem    4 KiB  0x0000000000000000 0x0000000040000000 =
0x0000000040000000

For consistency, change to use object id for -file and -memfd as well
with >=3D 4.0.

Having a consistent naming allows to migrate to different hostmem
backends.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/compat.h      | 10 +++++++++-
 include/sysemu/hostmem.h |  3 ++-
 backends/hostmem-file.c  |  8 ++++----
 backends/hostmem-memfd.c |  2 +-
 backends/hostmem-ram.c   |  9 ++++-----
 backends/hostmem.c       | 36 ++++++++++++++++++++++++++++++++++++
 6 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 70958328fe..99cf6b1e03 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -2,7 +2,15 @@
 #define HW_COMPAT_H
=20
 #define HW_COMPAT_3_1 \
-    /* empty */
+    {\
+        .driver   =3D "memory-backend-file",\
+        .property =3D "x-use-canonical-path-for-ramblock-id",\
+        .value    =3D "true",\
+    },{\
+        .driver   =3D "memory-backend-memfd",\
+        .property =3D "x-use-canonical-path-for-ramblock-id",\
+        .value    =3D "true",\
+    },
=20
 #define HW_COMPAT_3_0 \
     /* empty */
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 6e6bd2c1cb..a023b372a4 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -53,7 +53,7 @@ struct HostMemoryBackend {
=20
     /* protected */
     uint64_t size;
-    bool merge, dump;
+    bool merge, dump, use_canonical_path;
     bool prealloc, force_prealloc, is_mapped, share;
     DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
     HostMemPolicy policy;
@@ -67,5 +67,6 @@ MemoryRegion *host_memory_backend_get_memory(HostMemory=
Backend *backend);
 void host_memory_backend_set_mapped(HostMemoryBackend *backend, bool map=
ped);
 bool host_memory_backend_is_mapped(HostMemoryBackend *backend);
 size_t host_memory_backend_pagesize(HostMemoryBackend *memdev);
+char *host_memory_backend_get_name(HostMemoryBackend *backend);
=20
 #endif
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 6630021226..5b87e154f3 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -43,7 +43,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, E=
rror **errp)
 {
     HostMemoryBackendFile *fb =3D MEMORY_BACKEND_FILE(backend);
 #ifdef CONFIG_POSIX
-    gchar *path;
+    gchar *name;
 #endif
=20
     if (!backend->size) {
@@ -58,14 +58,14 @@ file_backend_memory_alloc(HostMemoryBackend *backend,=
 Error **errp)
     error_setg(errp, "-mem-path not supported on this host");
 #else
     backend->force_prealloc =3D mem_prealloc;
-    path =3D object_get_canonical_path(OBJECT(backend));
+    name =3D host_memory_backend_get_name(backend);
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
-                                     path,
+                                     name,
                                      backend->size, fb->align,
                                      (backend->share ? RAM_SHARED : 0) |
                                      (fb->is_pmem ? RAM_PMEM : 0),
                                      fb->mem_path, errp);
-    g_free(path);
+    g_free(name);
 #endif
 }
=20
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 2eb9c827a5..98c9bf3240 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -53,7 +53,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, =
Error **errp)
         return;
     }
=20
-    name =3D object_get_canonical_path(OBJECT(backend));
+    name =3D host_memory_backend_get_name(backend);
     memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
                                    name, backend->size,
                                    backend->share, fd, errp);
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 7ddd08d370..24b65d9ae3 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -16,21 +16,20 @@
=20
 #define TYPE_MEMORY_BACKEND_RAM "memory-backend-ram"
=20
-
 static void
 ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
-    char *path;
+    char *name;
=20
     if (!backend->size) {
         error_setg(errp, "can't create backend with size 0");
         return;
     }
=20
-    path =3D object_get_canonical_path_component(OBJECT(backend));
-    memory_region_init_ram_shared_nomigrate(&backend->mr, OBJECT(backend=
), path,
+    name =3D host_memory_backend_get_name(backend);
+    memory_region_init_ram_shared_nomigrate(&backend->mr, OBJECT(backend=
), name,
                            backend->size, backend->share, errp);
-    g_free(path);
+    g_free(name);
 }
=20
 static void
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 1a89342039..c7a7020fed 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -28,6 +28,16 @@ QEMU_BUILD_BUG_ON(HOST_MEM_POLICY_BIND !=3D MPOL_BIND)=
;
 QEMU_BUILD_BUG_ON(HOST_MEM_POLICY_INTERLEAVE !=3D MPOL_INTERLEAVE);
 #endif
=20
+char *
+host_memory_backend_get_name(HostMemoryBackend *self)
+{
+    if (!self->use_canonical_path) {
+        return object_get_canonical_path_component(OBJECT(self));
+    }
+
+    return object_get_canonical_path(OBJECT(self));
+}
+
 static void
 host_memory_backend_get_size(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
@@ -238,6 +248,11 @@ static void host_memory_backend_init(Object *obj)
     backend->prealloc =3D mem_prealloc;
 }
=20
+static void host_memory_backend_post_init(Object *obj)
+{
+    object_apply_compat_props(obj);
+}
+
 bool host_memory_backend_mr_inited(HostMemoryBackend *backend)
 {
     /*
@@ -386,6 +401,23 @@ static void host_memory_backend_set_share(Object *o,=
 bool value, Error **errp)
     backend->share =3D value;
 }
=20
+static bool
+host_memory_backend_get_use_canonical_path(Object *obj, Error **errp)
+{
+    HostMemoryBackend *self =3D MEMORY_BACKEND(obj);
+
+    return self->use_canonical_path;
+}
+
+static void
+host_memory_backend_set_use_canonical_path(Object *obj, bool value,
+                                           Error **errp)
+{
+    HostMemoryBackend *self =3D MEMORY_BACKEND(obj);
+
+    self->use_canonical_path =3D value;
+}
+
 static void
 host_memory_backend_class_init(ObjectClass *oc, void *data)
 {
@@ -432,6 +464,9 @@ host_memory_backend_class_init(ObjectClass *oc, void =
*data)
         &error_abort);
     object_class_property_set_description(oc, "share",
         "Mark the memory as private to QEMU or shared", &error_abort);
+    object_class_property_add_bool(oc, "x-use-canonical-path-for-rambloc=
k-id",
+        host_memory_backend_get_use_canonical_path,
+        host_memory_backend_set_use_canonical_path, &error_abort);
 }
=20
 static const TypeInfo host_memory_backend_info =3D {
@@ -442,6 +477,7 @@ static const TypeInfo host_memory_backend_info =3D {
     .class_init =3D host_memory_backend_class_init,
     .instance_size =3D sizeof(HostMemoryBackend),
     .instance_init =3D host_memory_backend_init,
+    .instance_post_init =3D host_memory_backend_post_init,
     .interfaces =3D (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
--=20
2.20.0.rc1
