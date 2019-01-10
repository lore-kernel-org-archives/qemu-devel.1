Received: from eggs.gnu.org ([209.51.188.92]:49400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1ghZ1m-0001CP-38
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1ghZ1l-00005l-23
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:01:38 -0500
Received: from forwardcorp1j.cmail.yandex.net ([2a02:6b8:0:1630::190]:46728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1ghZ1k-0008SW-AC
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:01:36 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Thu, 10 Jan 2019 15:01:18 +0300
Message-Id: <20190110120120.9943-3-yury-kotov@yandex-team.ru>
In-Reply-To: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
References: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] exec: add RAM_EXTERNAL flag to mark
 non-QEMU allocated blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: wrfsh@yandex-team.ru

This flag allows to determine whether RAM block is available from the out=
side.
E.g. when we use -object memory-backend-file or -mem-path options we have
a RAM block which is mapped to shared file.

We need this flag in the following commits.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 backends/hostmem-file.c | 3 ++-
 exec.c                  | 2 +-
 include/exec/memory.h   | 3 +++
 numa.c                  | 4 ++--
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 7a34e25c43..37fe28f2ac 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -63,7 +63,8 @@ file_backend_memory_alloc(HostMemoryBackend *backend, E=
rror **errp)
                                      name,
                                      backend->size, fb->align,
                                      (backend->share ? RAM_SHARED : 0) |
-                                     (fb->is_pmem ? RAM_PMEM : 0),
+                                     (fb->is_pmem ? RAM_PMEM : 0) |
+                                     RAM_EXTERNAL,
                                      fb->mem_path, errp);
     g_free(name);
 #endif
diff --git a/exec.c b/exec.c
index 6e875f0640..ef2f29d7cb 100644
--- a/exec.c
+++ b/exec.c
@@ -2241,7 +2241,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, M=
emoryRegion *mr,
     int64_t file_size;
=20
     /* Just support these ram flags by now. */
-    assert((ram_flags & ~(RAM_SHARED | RAM_PMEM)) =3D=3D 0);
+    assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_EXTERNAL)) =3D=3D =
0);
=20
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
diff --git a/include/exec/memory.h b/include/exec/memory.h
index ffd23ed8d8..3a9cb34f1e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -126,6 +126,9 @@ typedef struct IOMMUNotifier IOMMUNotifier;
 /* RAM is a persistent kind memory */
 #define RAM_PMEM (1 << 5)
=20
+/* RAM is from external source (e.g. from file) */
+#define RAM_EXTERNAL (1 << 6)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
diff --git a/numa.c b/numa.c
index 50ec016013..653c5a08de 100644
--- a/numa.c
+++ b/numa.c
@@ -482,8 +482,8 @@ static void allocate_system_memory_nonnuma(MemoryRegi=
on *mr, Object *owner,
     if (mem_path) {
 #ifdef __linux__
         Error *err =3D NULL;
-        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0=
,
-                                         mem_path, &err);
+        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0,
+                                         RAM_EXTERNAL, mem_path, &err);
         if (err) {
             error_report_err(err);
             if (mem_prealloc) {
--=20
2.20.1
