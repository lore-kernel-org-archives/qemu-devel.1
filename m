Received: from eggs.gnu.org ([2001:4830:134:3::10]:50987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGnKG-0007nW-Ee
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGnKD-0003g3-6d
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:13:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dGnKD-0003eb-0j
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:13:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26EB783F45
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 14:13:12 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  2 Jun 2017 18:12:25 +0400
Message-Id: <20170602141229.15326-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170602141229.15326-1-marcandre.lureau@redhat.com>
References: <20170602141229.15326-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/9] ivshmem: use ram_from_fd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
index 475e36a4c7..c2f15907c1 100644
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
2.13.0.91.g00982b8dd
