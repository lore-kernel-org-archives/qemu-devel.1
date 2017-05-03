Received: from eggs.gnu.org ([2001:4830:134:3::10]:53213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d5t8W-0005Jo-Cu
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d5t8R-0002rF-F7
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:12:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d5t8R-0002lL-8z
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:11:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F91980B20
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 12:11:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  3 May 2017 16:11:42 +0400
Message-Id: <20170503121143.14925-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] libvhost-user: fix
 vu_queue_get_avail_bytes() crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Calling vu_queue_get_avail_bytes() when the queue doesn't yet have
addresses will result in the following crash:

Program received signal SIGSEGV, Segmentation fault.
0x000055c414112ce4 in vring_avail_idx (vq=3D0x55c41582fd68, vq=3D0x55c415=
82fd68)
    at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:940
940            vq->shadow_avail_idx =3D vq->vring.avail->idx;
(gdb) p vq
$1 =3D (VuVirtq *) 0x55c41582fd68
(gdb) p vq->vring
$2 =3D {num =3D 0, desc =3D 0x0, avail =3D 0x0, used =3D 0x0, log_guest_a=
ddr =3D 0, flags =3D 0}

    at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:940
No locals.
    at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:960
        num_heads =3D <optimized out>
    out_bytes=3Dout_bytes@entry=3D0x7fffd035d7c4, max_in_bytes=3Dmax_in_b=
ytes@entry=3D0,
    max_out_bytes=3Dmax_out_bytes@entry=3D0) at /home/dgilbert/git/qemu/c=
ontrib/libvhost-user/libvhost-user.c:1034

Check if vring.avail !=3D null before accessing it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index af4faad60b..f9680b6279 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -1031,6 +1031,10 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, =
unsigned int *in_bytes,
     idx =3D vq->last_avail_idx;
=20
     total_bufs =3D in_total =3D out_total =3D 0;
+    if (!vq->vring.avail) {
+        goto done;
+    }
+
     while ((rc =3D virtqueue_num_heads(dev, vq, idx)) > 0) {
         unsigned int max, num_bufs, indirect =3D 0;
         struct vring_desc *desc;
--=20
2.12.0.191.gc5d8de91d
