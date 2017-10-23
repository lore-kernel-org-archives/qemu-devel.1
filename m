Received: from eggs.gnu.org ([2001:4830:134:3::10]:40315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e6dZ5-00016l-1H
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e6dZ3-0000cu-Hi
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:18:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e6dZ3-0000cE-8Q
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:18:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66ED961D1F
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 14:18:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 23 Oct 2017 15:18:12 +0100
Message-Id: <20171023141815.17709-7-marcandre.lureau@redhat.com>
In-Reply-To: <20171023141815.17709-1-marcandre.lureau@redhat.com>
References: <20171023141815.17709-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 6/9] Add memfd based hostmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Add a new memory backend, similar to hostmem-file, except that it
doesn't need to create files. It also enforces memory sealing.

This backend is mainly useful for sharing the memory with other
processes.

Note that Linux supports transparent huge-pages of shmem/memfd memory
since 4.8. It is relatively easier to set up THP than a dedicate
hugepage mount point by using "madvise" in
/sys/kernel/mm/transparent_hugepage/shmem_enabled.

Since 4.14, memfd allows to set hugetlb requirement explicitly.

Usage:
-object memory-backend-memfd,id=3Dmem1,size=3D1G

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem-memfd.c | 168 +++++++++++++++++++++++++++++++++++++++++=
++++++
 backends/Makefile.objs   |   2 +
 qemu-options.hx          |  23 +++++++
 3 files changed, 193 insertions(+)
 create mode 100644 backends/hostmem-memfd.c

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
new file mode 100644
index 0000000000..28f15638c8
--- /dev/null
+++ b/backends/hostmem-memfd.c
@@ -0,0 +1,168 @@
+/*
+ * QEMU host memfd memory backend
+ *
+ * Copyright (C) 2016 Red Hat Inc
+ *
+ * Authors:
+ *   Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "sysemu/hostmem.h"
+#include "sysemu/sysemu.h"
+#include "qom/object_interfaces.h"
+#include "qemu/memfd.h"
+#include "qapi/error.h"
+
+#define TYPE_MEMORY_BACKEND_MEMFD "memory-backend-memfd"
+
+#define MEMORY_BACKEND_MEMFD(obj)                                       =
 \
+    OBJECT_CHECK(HostMemoryBackendMemfd, (obj), TYPE_MEMORY_BACKEND_MEMF=
D)
+
+typedef struct HostMemoryBackendMemfd HostMemoryBackendMemfd;
+
+struct HostMemoryBackendMemfd {
+    HostMemoryBackend parent_obj;
+
+    bool hugetlb;
+    uint64_t hugetlbsize;
+    bool seal;
+};
+
+static void
+memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
+{
+    HostMemoryBackendMemfd *m =3D MEMORY_BACKEND_MEMFD(backend);
+    int fd;
+
+    if (!backend->size) {
+        error_setg(errp, "can't create backend with size 0");
+        return;
+    }
+
+    if (host_memory_backend_mr_inited(backend)) {
+        return;
+    }
+
+    backend->force_prealloc =3D mem_prealloc;
+    fd =3D qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
+                           m->hugetlb, m->hugetlbsize, m->seal ?
+                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0=
,
+                           errp);
+    if (fd =3D=3D -1) {
+        return;
+    }
+
+    memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
+                                   object_get_canonical_path(OBJECT(back=
end)),
+                                   backend->size, true, fd, errp);
+}
+
+static bool
+memfd_backend_get_hugetlb(Object *o, Error **errp)
+{
+    return MEMORY_BACKEND_MEMFD(o)->hugetlb;
+}
+
+static void
+memfd_backend_set_hugetlb(Object *o, bool value, Error **errp)
+{
+    MEMORY_BACKEND_MEMFD(o)->hugetlb =3D value;
+}
+
+static void
+memfd_backend_set_hugetlbsize(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    HostMemoryBackendMemfd *m =3D MEMORY_BACKEND_MEMFD(obj);
+    Error *local_err =3D NULL;
+    uint64_t value;
+
+    if (host_memory_backend_mr_inited(MEMORY_BACKEND(obj))) {
+        error_setg(&local_err, "cannot change property value");
+        goto out;
+    }
+
+    visit_type_size(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    if (!value) {
+        error_setg(&local_err, "Property '%s.%s' doesn't take value '%"
+                   PRIu64 "'", object_get_typename(obj), name, value);
+        goto out;
+    }
+    m->hugetlbsize =3D value;
+out:
+    error_propagate(errp, local_err);
+}
+
+static void
+memfd_backend_get_hugetlbsize(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    HostMemoryBackendMemfd *m =3D MEMORY_BACKEND_MEMFD(obj);
+    uint64_t value =3D m->hugetlbsize;
+
+    visit_type_size(v, name, &value, errp);
+}
+
+static bool
+memfd_backend_get_seal(Object *o, Error **errp)
+{
+    return MEMORY_BACKEND_MEMFD(o)->seal;
+}
+
+static void
+memfd_backend_set_seal(Object *o, bool value, Error **errp)
+{
+    MEMORY_BACKEND_MEMFD(o)->seal =3D value;
+}
+
+static void
+memfd_backend_instance_init(Object *obj)
+{
+    HostMemoryBackendMemfd *m =3D MEMORY_BACKEND_MEMFD(obj);
+
+    /* default to sealed file */
+    m->seal =3D true;
+}
+
+static void
+memfd_backend_class_init(ObjectClass *oc, void *data)
+{
+    HostMemoryBackendClass *bc =3D MEMORY_BACKEND_CLASS(oc);
+
+    bc->alloc =3D memfd_backend_memory_alloc;
+
+    object_class_property_add_bool(oc, "hugetlb",
+                                   memfd_backend_get_hugetlb,
+                                   memfd_backend_set_hugetlb,
+                                   &error_abort);
+    object_class_property_add(oc, "hugetlbsize", "int",
+                              memfd_backend_get_hugetlbsize,
+                              memfd_backend_set_hugetlbsize,
+                              NULL, NULL, &error_abort);
+    object_class_property_add_bool(oc, "seal",
+                                   memfd_backend_get_seal,
+                                   memfd_backend_set_seal,
+                                   &error_abort);
+}
+
+static const TypeInfo memfd_backend_info =3D {
+    .name =3D TYPE_MEMORY_BACKEND_MEMFD,
+    .parent =3D TYPE_MEMORY_BACKEND,
+    .instance_init =3D memfd_backend_instance_init,
+    .class_init =3D memfd_backend_class_init,
+    .instance_size =3D sizeof(HostMemoryBackendMemfd),
+};
+
+static void register_types(void)
+{
+    type_register_static(&memfd_backend_info);
+}
+
+type_init(register_types);
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 0400799efd..67eeeba5fc 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -8,3 +8,5 @@ common-obj-$(CONFIG_LINUX) +=3D hostmem-file.o
=20
 common-obj-y +=3D cryptodev.o
 common-obj-y +=3D cryptodev-builtin.o
+
+common-obj-$(CONFIG_LINUX) +=3D hostmem-memfd.o
diff --git a/qemu-options.hx b/qemu-options.hx
index 3728e9b4dd..3d4dc7880c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4208,6 +4208,29 @@ that @option{discard-data} is only an optimization=
, and QEMU
 might not discard file contents if it aborts unexpectedly or is
 terminated using SIGKILL.
=20
+@item -object memory-backend-memfd,id=3D@var{id},size=3D@var{size},seal=3D=
@var{on|off},hugetlb=3D@var{on|off},hugetlbsize=3D@var{size}
+
+Creates an anonymous memory file backend object, which allows QEMU to
+share the memory with an external process in some cases (e.g. when
+using vhost-user). The memory is allocated with memfd and optional
+sealing. (Linux only)
+
+The @option{id} parameter is a unique ID that will be used to
+reference this memory region when configuring the @option{-numa}
+argument. The @option{size} option provides the size of the memory
+region, and accepts common suffixes, eg @option{500M}. The
+@option{seal} option creates a sealed-file, that will block further
+resizing the memory ('on' by default).
+
+The @option{hugetlb} option specify the file to be created resides in
+the hugetlbfs filesystem.  Used in conjunction with the
+@option{hugetlb} option, the @option{hugetlbsize} option specify the
+hugetlb page size on systems that support multiple hugetlb page sizes
+(it must be a power of 2 value supported by the system).
+
+@option{hugetlb} option is currently incompatible with @option{seal}
+option.
+
 @item -object rng-random,id=3D@var{id},filename=3D@var{/dev/random}
=20
 Creates a random number generator backend which obtains entropy from
--=20
2.15.0.rc0.40.gaefcc5f6f
