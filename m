Received: from eggs.gnu.org ([2001:4830:134:3::10]:53321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHAD-0001up-Sq
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHAD-0001Os-7H
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRHAD-0001OX-1I
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:57 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B2D761BA4
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:33:57 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 12:33:44 +0100
Message-Id: <20170111113347.7577-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170111113347.7577-1-marcandre.lureau@redhat.com>
References: <20170111113347.7577-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 6/9] memory: remove memory_region_set_fd
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

Now unnecessary since ivshmem uses memory_region_init_ram_from_fd.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/exec/memory.h | 11 -----------
 memory.c              | 10 ----------
 2 files changed, 21 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6f98e4df6a..5dbc3d1a6c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -774,17 +774,6 @@ static inline bool memory_region_is_rom(MemoryRegion=
 *mr)
  */
 int memory_region_get_fd(MemoryRegion *mr);
=20
-/**
- * memory_region_set_fd: Mark a RAM memory region as backed by a
- * file descriptor.
- *
- * This function is typically used after memory_region_init_ram_ptr().
- *
- * @mr: the memory region being queried.
- * @fd: the file descriptor that backs @mr.
- */
-void memory_region_set_fd(MemoryRegion *mr, int fd);
-
 /**
  * memory_region_from_host: Convert a pointer into a RAM memory region
  * and an offset within it.
diff --git a/memory.c b/memory.c
index ec894865a2..3833a556d9 100644
--- a/memory.c
+++ b/memory.c
@@ -1807,16 +1807,6 @@ int memory_region_get_fd(MemoryRegion *mr)
     return fd;
 }
=20
-void memory_region_set_fd(MemoryRegion *mr, int fd)
-{
-    rcu_read_lock();
-    while (mr->alias) {
-        mr =3D mr->alias;
-    }
-    mr->ram_block->fd =3D fd;
-    rcu_read_unlock();
-}
-
 void *memory_region_get_ram_ptr(MemoryRegion *mr)
 {
     void *ptr;
--=20
2.11.0
