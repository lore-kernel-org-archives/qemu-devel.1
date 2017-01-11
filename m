Received: from eggs.gnu.org ([2001:4830:134:3::10]:53339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHAG-0001wy-7V
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHAA-0001O3-P0
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:34:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRHAA-0001Ne-K4
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:54 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C05DEC049D59
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:33:54 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 12:33:42 +0100
Message-Id: <20170111113347.7577-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170111113347.7577-1-marcandre.lureau@redhat.com>
References: <20170111113347.7577-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/9] Add memory_region_init_ram_from_fd()
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

Add a new function to initialize a RAM memory region with a file
descriptor to be mmap-ed.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/exec/memory.h | 20 ++++++++++++++++++++
 memory.c              | 16 ++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index bec9756667..6f98e4df6a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -429,6 +429,26 @@ void memory_region_init_ram_from_file(MemoryRegion *=
mr,
                                       bool share,
                                       const char *path,
                                       Error **errp);
+
+/**
+ * memory_region_init_ram_from_fd:  Initialize RAM memory region with a
+ *                                  mmap-ed backend.
+ *
+ * @mr: the #MemoryRegion to be initialized.
+ * @owner: the object that tracks the region's reference count
+ * @name: the name of the region.
+ * @size: size of the region.
+ * @share: %true if memory must be mmaped with the MAP_SHARED flag
+ * @fd: the fd to mmap.
+ * @errp: pointer to Error*, to store an error if it happens.
+ */
+void memory_region_init_ram_from_fd(MemoryRegion *mr,
+                                    struct Object *owner,
+                                    const char *name,
+                                    uint64_t size,
+                                    bool share,
+                                    int fd,
+                                    Error **errp);
 #endif
=20
 /**
diff --git a/memory.c b/memory.c
index 2bfc37f65c..ec894865a2 100644
--- a/memory.c
+++ b/memory.c
@@ -1401,6 +1401,22 @@ void memory_region_init_ram_from_file(MemoryRegion=
 *mr,
     mr->ram_block =3D qemu_ram_alloc_from_file(size, mr, share, path, er=
rp);
     mr->dirty_log_mask =3D tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
 }
+
+void memory_region_init_ram_from_fd(MemoryRegion *mr,
+                                    struct Object *owner,
+                                    const char *name,
+                                    uint64_t size,
+                                    bool share,
+                                    int fd,
+                                    Error **errp)
+{
+    memory_region_init(mr, owner, name, size);
+    mr->ram =3D true;
+    mr->terminates =3D true;
+    mr->destructor =3D memory_region_destructor_ram;
+    mr->ram_block =3D qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
+    mr->dirty_log_mask =3D tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
+}
 #endif
=20
 void memory_region_init_ram_ptr(MemoryRegion *mr,
--=20
2.11.0
