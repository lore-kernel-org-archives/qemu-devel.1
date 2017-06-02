Received: from eggs.gnu.org ([2001:4830:134:3::10]:51010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGnKL-0007vp-Bw
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGnKK-0003q9-EL
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:13:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dGnKK-0003oR-7o
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:13:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CFCBC0587C3
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 14:13:19 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  2 Jun 2017 18:12:26 +0400
Message-Id: <20170602141229.15326-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170602141229.15326-1-marcandre.lureau@redhat.com>
References: <20170602141229.15326-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 6/9] memory: remove memory_region_set_fd
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

Now unnecessary since ivshmem uses memory_region_init_ram_from_fd.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/exec/memory.h | 11 -----------
 memory.c              | 10 ----------
 2 files changed, 21 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index edf52d7f9e..0ba6ea2b18 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -827,17 +827,6 @@ static inline bool memory_region_is_rom(MemoryRegion=
 *mr)
 int memory_region_get_fd(MemoryRegion *mr);
=20
 /**
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
-/**
  * memory_region_from_host: Convert a pointer into a RAM memory region
  * and an offset within it.
  *
diff --git a/memory.c b/memory.c
index b2ace20bac..e08fa0ae6c 100644
--- a/memory.c
+++ b/memory.c
@@ -1851,16 +1851,6 @@ int memory_region_get_fd(MemoryRegion *mr)
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
2.13.0.91.g00982b8dd
