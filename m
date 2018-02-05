Received: from eggs.gnu.org ([2001:4830:134:3::10]:45069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSf-0004tn-UA
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSe-0005AK-HJ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:53 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:45700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSe-0005A1-6z
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:52 -0500
Received: by mail-wr0-x22c.google.com with SMTP id h9so17831248wre.12
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:52 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:53 +0100
Message-Id: <1517858941-5538-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 39/47] Add memfd based hostmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add a new memory backend, similar to hostmem-file, except that it
doesn't need to create files. It also enforces memory sealing.

This backend is mainly useful for sharing the memory with other
processes.

Note that Linux supports transparent huge-pages of shmem/memfd memory
since 4.8. It is relatively easier to set up THP than a dedicate
hugepage mount point by using "madvise" in
/sys/kernel/mm/transparent_hugepage/shmem_enabled.

Since 4.14, memfd allows to set hugetlb requirement explicitly.

Pending for merge in 4.16 is memfd sealing support for hugetlb backed
memory.

Usage:
-object memory-backend-memfd,id=mem1,size=1G

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180201132757.23063-5-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/Makefile.objs   |   2 +
 backends/hostmem-memfd.c | 170 +++++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx          |  22 ++++++
 3 files changed, 194 insertions(+)
 create mode 100644 backends/hostmem-memfd.c

diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 0400799..67eeeba 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -8,3 +8,5 @@ common-obj-$(CONFIG_LINUX) += hostmem-file.o
 
 common-obj-y += cryptodev.o
 common-obj-y += cryptodev-builtin.o
+
+common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
new file mode 100644
index 0000000..1e20fe0
--- /dev/null
+++ b/backends/hostmem-memfd.c
@@ -0,0 +1,170 @@
+/*
+ * QEMU host memfd memory backend
+ *
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *   Marc-André Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
+#define MEMORY_BACKEND_MEMFD(obj)                                        \
+    OBJECT_CHECK(HostMemoryBackendMemfd, (obj), TYPE_MEMORY_BACKEND_MEMFD)
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
+    HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(backend);
+    char *name;
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
+    backend->force_prealloc = mem_prealloc;
+    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
+                           m->hugetlb, m->hugetlbsize, m->seal ?
+                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
+                           errp);
+    if (fd == -1) {
+        return;
+    }
+
+    name = object_get_canonical_path(OBJECT(backend));
+    memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
+                                   name, backend->size, true, fd, errp);
+    g_free(name);
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
+    MEMORY_BACKEND_MEMFD(o)->hugetlb = value;
+}
+
+static void
+memfd_backend_set_hugetlbsize(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(obj);
+    Error *local_err = NULL;
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
+    m->hugetlbsize = value;
+out:
+    error_propagate(errp, local_err);
+}
+
+static void
+memfd_backend_get_hugetlbsize(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(obj);
+    uint64_t value = m->hugetlbsize;
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
+    MEMORY_BACKEND_MEMFD(o)->seal = value;
+}
+
+static void
+memfd_backend_instance_init(Object *obj)
+{
+    HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(obj);
+
+    /* default to sealed file */
+    m->seal = true;
+}
+
+static void
+memfd_backend_class_init(ObjectClass *oc, void *data)
+{
+    HostMemoryBackendClass *bc = MEMORY_BACKEND_CLASS(oc);
+
+    bc->alloc = memfd_backend_memory_alloc;
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
+static const TypeInfo memfd_backend_info = {
+    .name = TYPE_MEMORY_BACKEND_MEMFD,
+    .parent = TYPE_MEMORY_BACKEND,
+    .instance_init = memfd_backend_instance_init,
+    .class_init = memfd_backend_class_init,
+    .instance_size = sizeof(HostMemoryBackendMemfd),
+};
+
+static void register_types(void)
+{
+    type_register_static(&memfd_backend_info);
+}
+
+type_init(register_types);
diff --git a/qemu-options.hx b/qemu-options.hx
index 8ce427d..265cf9f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4024,6 +4024,28 @@ Memory backend objects offer more control than the @option{-m} option that is
 traditionally used to define guest RAM. Please refer to
 @option{memory-backend-file} for a description of the options.
 
+@item -object memory-backend-memfd,id=@var{id},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave},seal=@var{on|off},hugetlb=@var{on|off},hugetlbsize=@var{size}
+
+Creates an anonymous memory file backend object, which allows QEMU to
+share the memory with an external process (e.g. when using
+vhost-user). The memory is allocated with memfd and optional
+sealing. (Linux only)
+
+The @option{seal} option creates a sealed-file, that will block
+further resizing the memory ('on' by default).
+
+The @option{hugetlb} option specify the file to be created resides in
+the hugetlbfs filesystem (since Linux 4.14).  Used in conjunction with
+the @option{hugetlb} option, the @option{hugetlbsize} option specify
+the hugetlb page size on systems that support multiple hugetlb page
+sizes (it must be a power of 2 value supported by the system).
+
+In some versions of Linux, the @option{hugetlb} option is incompatible
+with the @option{seal} option (requires at least Linux 4.16).
+
+Please refer to @option{memory-backend-file} for a description of the
+other options.
+
 @item -object rng-random,id=@var{id},filename=@var{/dev/random}
 
 Creates a random number generator backend which obtains entropy from
-- 
1.8.3.1
