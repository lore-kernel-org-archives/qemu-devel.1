Received: from eggs.gnu.org ([209.51.188.92]:39846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hJy2M-0007Yt-SZ
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hJy2L-0003Zs-Ro
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:24:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hJy2L-0003YD-Ja
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:24:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E261A80F83
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Apr 2019 12:24:32 +0200
Message-Id: <20190426102437.16189-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190426102437.16189-1-marcandre.lureau@redhat.com>
References: <20190426102437.16189-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/6] libvhost-user: fix
 -Waddress-of-packed-member
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

/home/elmarco/src/qemu/contrib/libvhost-user/libvhost-user.c: In function=
 =E2=80=98vu_set_mem_table_exec_postcopy=E2=80=99:
/home/elmarco/src/qemu/contrib/libvhost-user/libvhost-user.c:546:31: warn=
ing: taking address of packed member of =E2=80=98struct VhostUserMsg=E2=80=
=99 may result in an unaligned pointer value [-Waddress-of-packed-member]
  546 |     VhostUserMemory *memory =3D &vmsg->payload.memory;
      |                               ^~~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qemu/contrib/libvhost-user/libvhost-user.c: In function=
 =E2=80=98vu_set_mem_table_exec=E2=80=99:
/home/elmarco/src/qemu/contrib/libvhost-user/libvhost-user.c:688:31: warn=
ing: taking address of packed member of =E2=80=98struct VhostUserMsg=E2=80=
=99 may result in an unaligned pointer value [-Waddress-of-packed-member]
  688 |     VhostUserMemory *memory =3D &vmsg->payload.memory;
      |                               ^~~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qemu/contrib/libvhost-user/libvhost-user.c: In function=
 =E2=80=98vu_set_vring_addr_exec=E2=80=99:
/home/elmarco/src/qemu/contrib/libvhost-user/libvhost-user.c:817:36: warn=
ing: taking address of packed member of =E2=80=98struct VhostUserMsg=E2=80=
=99 may result in an unaligned pointer value [-Waddress-of-packed-member]
  817 |     struct vhost_vring_addr *vra =3D &vmsg->payload.addr;
      |                                    ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index e08d6c7b97..dcf4a969f2 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -542,7 +542,7 @@ static bool
 vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
 {
     int i;
-    VhostUserMemory *memory =3D &vmsg->payload.memory;
+    VhostUserMemory m =3D vmsg->payload.memory, *memory =3D &m;
     dev->nregions =3D memory->nregions;
=20
     DPRINT("Nregions: %d\n", memory->nregions);
@@ -684,7 +684,7 @@ static bool
 vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     int i;
-    VhostUserMemory *memory =3D &vmsg->payload.memory;
+    VhostUserMemory m =3D vmsg->payload.memory, *memory =3D &m;
=20
     for (i =3D 0; i < dev->nregions; i++) {
         VuDevRegion *r =3D &dev->regions[i];
@@ -813,7 +813,7 @@ vu_set_vring_num_exec(VuDev *dev, VhostUserMsg *vmsg)
 static bool
 vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
-    struct vhost_vring_addr *vra =3D &vmsg->payload.addr;
+    struct vhost_vring_addr addr =3D vmsg->payload.addr, *vra =3D &addr;
     unsigned int index =3D vra->index;
     VuVirtq *vq =3D &dev->vq[index];
=20
--=20
2.21.0.313.ge35b8cb8e2
