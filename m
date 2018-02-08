Received: from eggs.gnu.org ([2001:4830:134:3::10]:54268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZQ-0006LT-En
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZN-0008Pr-9E
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52432 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejrZN-0008PY-4A
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:17 -0500
Date: Thu, 8 Feb 2018 21:09:15 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-21-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/26] libvhost-user: Fix resource leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yongji Xie <elohimes@gmail.com>, Yongji Xie <xieyongji@baidu.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Yongji Xie <elohimes@gmail.com>

Free the mmaped memory when we need to mmap new memory
space on vu_set_mem_table_exec() and vu_set_log_base_exec() to
avoid memory leak.

Also close the corresponding fd after mmap() on
vu_set_log_base_exec() to avoid fd leak.

Signed-off-by: Yongji Xie <xieyongji@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 27cc597..54dbc93 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -407,6 +407,15 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg=
)
 {
     int i;
     VhostUserMemory *memory =3D &vmsg->payload.memory;
+
+    for (i =3D 0; i < dev->nregions; i++) {
+        VuDevRegion *r =3D &dev->regions[i];
+        void *m =3D (void *) (uintptr_t) r->mmap_addr;
+
+        if (m) {
+            munmap(m, r->size + r->mmap_offset);
+        }
+    }
     dev->nregions =3D memory->nregions;
=20
     DPRINT("Nregions: %d\n", memory->nregions);
@@ -472,9 +481,14 @@ vu_set_log_base_exec(VuDev *dev, VhostUserMsg *vmsg)
=20
     rc =3D mmap(0, log_mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd=
,
               log_mmap_offset);
+    close(fd);
     if (rc =3D=3D MAP_FAILED) {
         perror("log mmap error");
     }
+
+    if (dev->log_table) {
+        munmap(dev->log_table, dev->log_size);
+    }
     dev->log_table =3D rc;
     dev->log_size =3D log_mmap_size;
=20
--=20
MST
