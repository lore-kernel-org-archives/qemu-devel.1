Received: from eggs.gnu.org ([2001:4830:134:3::10]:38068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN7b-00005N-I8
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gKN7Y-0007lW-SN
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 07:39:47 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Nov 2018 16:36:52 +0400
Message-Id: <20181107123652.23417-15-marcandre.lureau@redhat.com>
In-Reply-To: <20181107123652.23417-1-marcandre.lureau@redhat.com>
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v3 14/14] hostmem: use object id for
 memory region name with >= 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, Artyom Tarasenko <atar4qemu@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Berger <stefanb@linux.ibm.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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

Use the object id for -file and -memfd with >=3D 3.1 for consistency.
Having a consistent naming allow to migrate to different hostmem
backends.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/compat.h      | 10 +++++++++-
 include/sysemu/hostmem.h |  3 ++-
 backends/hostmem-file.c  |  8 ++++----
 backends/hostmem-memfd.c |  2 +-
 backends/hostmem-ram.c   |  9 ++++-----
 backends/hostmem.c       | 31 +++++++++++++++++++++++++++++++
 6 files changed, 51 insertions(+), 12 deletions(-)

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
index 639c8d4307..c01a7cdf8d 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -55,16 +55,16 @@ file_backend_memory_alloc(HostMemoryBackend *backend,=
 Error **errp)
     error_setg(errp, "-mem-path not supported on this host");
 #else
     if (!host_memory_backend_mr_inited(backend)) {
-        gchar *path;
+        gchar *name;
         backend->force_prealloc =3D mem_prealloc;
-        path =3D object_get_canonical_path(OBJECT(backend));
+        name =3D host_memory_backend_get_name(backend);
         memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
-                                 path,
+                                 name,
                                  backend->size, fb->align,
                                  (backend->share ? RAM_SHARED : 0) |
                                  (fb->is_pmem ? RAM_PMEM : 0),
                                  fb->mem_path, errp);
-        g_free(path);
+        g_free(name);
     }
 #endif
 }
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index b6836b28e5..c5a4a9b530 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -57,7 +57,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, =
Error **errp)
         return;
     }
=20
-    name =3D object_get_canonical_path(OBJECT(backend));
+    name =3D host_memory_backend_get_name(backend);
     memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
                                    name, backend->size, true, fd, errp);
     g_free(name);
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
index 1a89342039..35c665fca2 100644
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
@@ -386,6 +396,23 @@ static void host_memory_backend_set_share(Object *o,=
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
@@ -432,6 +459,9 @@ host_memory_backend_class_init(ObjectClass *oc, void =
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
@@ -444,6 +474,7 @@ static const TypeInfo host_memory_backend_info =3D {
     .instance_init =3D host_memory_backend_init,
     .interfaces =3D (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
+        { TYPE_COMPAT_PROPS },
         { }
     }
 };
--=20
2.19.1.708.g4ede3d42df
