Received: from eggs.gnu.org ([2001:4830:134:3::10]:53310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHAC-0001tp-SY
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHAC-0001OR-0B
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRHAB-0001OC-Qh
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:55 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0363A4481A
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:33:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 12:33:43 +0100
Message-Id: <20170111113347.7577-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170111113347.7577-1-marcandre.lureau@redhat.com>
References: <20170111113347.7577-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/9] ivshmem: use ram_from_fd()
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

Instead of having its own mmap handling code, reuse the code from
exec.c.

Note: memory_region_init_ram_from_fd() adds some restrictions
(check for xen, kvm sync-mmu, etc) and changes (such as size
alignment). This may actually be more correct.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/misc/ivshmem.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index abeaf3da08..49db6a27aa 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -491,9 +491,9 @@ static void setup_interrupt(IVShmemState *s, int vect=
or, Error **errp)
=20
 static void process_msg_shmem(IVShmemState *s, int fd, Error **errp)
 {
+    Error *local_err =3D NULL;
     struct stat buf;
     size_t size;
-    void *ptr;
=20
     if (s->ivshmem_bar2) {
         error_setg(errp, "server sent unexpected shared memory message")=
;
@@ -522,15 +522,13 @@ static void process_msg_shmem(IVShmemState *s, int =
fd, Error **errp)
     }
=20
     /* mmap the region and map into the BAR2 */
-    ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-    if (ptr =3D=3D MAP_FAILED) {
-        error_setg_errno(errp, errno, "Failed to mmap shared memory");
-        close(fd);
+    memory_region_init_ram_from_fd(&s->server_bar2, OBJECT(s),
+                                   "ivshmem.bar2", size, true, fd, &loca=
l_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         return;
     }
-    memory_region_init_ram_ptr(&s->server_bar2, OBJECT(s),
-                               "ivshmem.bar2", size, ptr);
-    memory_region_set_fd(&s->server_bar2, fd);
+
     s->ivshmem_bar2 =3D &s->server_bar2;
 }
=20
--=20
2.11.0
