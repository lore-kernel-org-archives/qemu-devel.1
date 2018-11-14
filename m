Received: from eggs.gnu.org ([2001:4830:134:3::10]:58781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuQn-00007S-Bm
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuQi-00016M-Ly
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuQi-000166-F2
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:00 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:08 +0400
Message-Id: <20181114123643.24091-7-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 06/41] slirp: add a callback for
 qemu_chr_fe_write_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Replace strong dependency on QEMU.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h | 1 +
 net/slirp.c      | 6 ++++++
 slirp/slirp.c    | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 36d5fb9163..16ced2aa0f 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -7,6 +7,7 @@ typedef struct Slirp Slirp;
=20
 typedef struct SlirpCb {
     void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
+    int (*chr_write_all)(void *chr, const void *buf, size_t len);
 } SlirpCb;
=20
=20
diff --git a/net/slirp.c b/net/slirp.c
index 233f66b1ef..5c1f676487 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -140,8 +140,14 @@ static NetClientInfo net_slirp_info =3D {
     .cleanup =3D net_slirp_cleanup,
 };
=20
+static int net_slirp_chr_write_all(void *chr, const void *buf, size_t le=
n)
+{
+    return qemu_chr_fe_write_all(chr, buf, len);
+}
+
 static SlirpCb slirp_cb =3D {
     .output =3D net_slirp_output,
+    .chr_write_all =3D net_slirp_chr_write_all,
 };
=20
 static int net_slirp_init(NetClientState *peer, const char *model,
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 7213915bf3..4e809e5d7f 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1099,7 +1099,7 @@ ssize_t slirp_send(struct socket *so, const void *b=
uf, size_t len, int flags)
     if (so->s =3D=3D -1 && so->chardev) {
         /* XXX this blocks entire thread. Rewrite to use
          * qemu_chr_fe_write and background I/O callbacks */
-        qemu_chr_fe_write_all(so->chardev, buf, len);
+        so->slirp->cb->chr_write_all(so->chardev, buf, len);
         return len;
     }
=20
--=20
2.19.1.708.g4ede3d42df
