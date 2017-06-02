Received: from eggs.gnu.org ([2001:4830:134:3::10]:50873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGnK6-0007WB-5F
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGnK5-0003UF-86
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:13:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dGnK5-0003TE-0K
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:13:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F00523205E
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 14:13:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  2 Jun 2017 18:12:24 +0400
Message-Id: <20170602141229.15326-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170602141229.15326-1-marcandre.lureau@redhat.com>
References: <20170602141229.15326-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/9] Add memory_region_init_ram_from_fd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Add a new function to initialize a RAM memory region with a file
descriptor to be mmap-ed.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/exec/memory.h | 20 ++++++++++++++++++++
 memory.c              | 16 ++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index bfdc685f24..edf52d7f9e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -458,6 +458,26 @@ void memory_region_init_ram_from_file(MemoryRegion *=
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
index 0ddc4cc28d..b2ace20bac 100644
--- a/memory.c
+++ b/memory.c
@@ -1397,6 +1397,22 @@ void memory_region_init_ram_from_file(MemoryRegion=
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
2.13.0.91.g00982b8dd
