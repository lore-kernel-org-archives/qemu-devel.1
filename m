Received: from eggs.gnu.org ([2001:4830:134:3::10]:53356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHAI-0001ya-6F
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHAG-0001Pr-9X
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:34:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRHAG-0001Pb-1A
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:34:00 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 358CD468
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:34:00 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 12:33:46 +0100
Message-Id: <20170111113347.7577-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170111113347.7577-1-marcandre.lureau@redhat.com>
References: <20170111113347.7577-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 8/9] Add memfd based hostmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a new memory backend, similar to hostmem-file, except that it
doesn't need to create files. It also enforces memory sealing.

This backend is mainly useful for sharing the memory with other
processes.

Note that Linux supports transparent huge-pages of shmem/memfd memory
since 4.8. It is relatively easier to set up THP than a dedicate
hugepage mount point by using "madvise" in
/sys/kernel/mm/transparent_hugepage/shmem_enabled.

Usage:
-object memory-backend-memfd,id=3Dmem1,size=3D1G

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem-memfd.c | 67 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 backends/Makefile.objs   |  2 ++
 qemu-options.hx          | 11 ++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 backends/hostmem-memfd.c

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
new file mode 100644
index 0000000000..13d300d9ad
--- /dev/null
+++ b/backends/hostmem-memfd.c
@@ -0,0 +1,67 @@
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
+static void
+memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
+{
+    int fd;
+
+    if (!backend->size) {
+        error_setg(errp, "can't create backend with size 0");
+        return;
+    }
+
+    if (!memory_region_size(&backend->mr)) {
+        backend->force_prealloc =3D mem_prealloc;
+        fd =3D qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD,
+                               backend->size,
+                               F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL=
,
+                               true);
+        if (fd =3D=3D -1) {
+            error_setg(errp, "can't allocate memfd backend");
+            return;
+        }
+        memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
+            object_get_canonical_path(OBJECT(backend)),
+            backend->size, true, fd, errp);
+    }
+}
+
+static void
+memfd_backend_class_init(ObjectClass *oc, void *data)
+{
+    HostMemoryBackendClass *bc =3D MEMORY_BACKEND_CLASS(oc);
+
+    bc->alloc =3D memfd_backend_memory_alloc;
+}
+
+static const TypeInfo memfd_backend_info =3D {
+    .name =3D TYPE_MEMORY_BACKEND_MEMFD,
+    .parent =3D TYPE_MEMORY_BACKEND,
+    .class_init =3D memfd_backend_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&memfd_backend_info);
+}
+
+type_init(register_types);
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 18469980e6..1ed7e5b286 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -12,3 +12,5 @@ common-obj-$(CONFIG_LINUX) +=3D hostmem-file.o
=20
 common-obj-y +=3D cryptodev.o
 common-obj-y +=3D cryptodev-builtin.o
+
+common-obj-$(CONFIG_LINUX) +=3D hostmem-memfd.o
diff --git a/qemu-options.hx b/qemu-options.hx
index c534a2f7f9..d48463dd81 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3807,6 +3807,17 @@ The @option{share} boolean option determines wheth=
er the memory
 region is marked as private to QEMU, or shared. The latter allows
 a co-operating external process to access the QEMU memory region.
=20
+@item -object memory-backend-memfd,id=3D@var{id},size=3D@var{size}
+
+Creates an anonymous memory file backend object, which can be used to
+share the memory with a co-operating external process. The memory is
+allocated with memfd and sealing. (Linux only)
+
+The @option{id} parameter is a unique ID that will be used to
+reference this memory region when configuring the @option{-numa}
+argument. The @option{size} option provides the size of the memory
+region, and accepts common suffixes, eg @option{500M}.
+
 @item -object rng-random,id=3D@var{id},filename=3D@var{/dev/random}
=20
 Creates a random number generator backend which obtains entropy from
--=20
2.11.0
