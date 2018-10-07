Received: from eggs.gnu.org ([2001:4830:134:3::10]:54581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1g9DQn-0008VG-MN
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 14:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1g9DQk-000116-OW
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 14:05:29 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:54630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1g9DQi-0000vJ-3U
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 14:05:24 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun,  7 Oct 2018 20:05:16 +0200
Message-Id: <20181007180518.5212-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181007180518.5212-1-samuel.thibault@ens-lyon.org>
References: <20181007180518.5212-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] slirp: document mbuf pointers and sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Peter Maydell <peter.maydell@linaro.org>

and fix confusing datasize name into gapsize in m_inc.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/mbuf.c | 14 +++++++-------
 slirp/mbuf.h | 13 +++++++++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/slirp/mbuf.c b/slirp/mbuf.c
index 1b7868355a..aa1f28afb1 100644
--- a/slirp/mbuf.c
+++ b/slirp/mbuf.c
@@ -151,7 +151,7 @@ m_cat(struct mbuf *m, struct mbuf *n)
 void
 m_inc(struct mbuf *m, int size)
 {
-    int datasize;
+    int gapsize;
=20
     /* some compilers throw up on gotos.  This one we can fake. */
     if (M_ROOM(m) > size) {
@@ -159,17 +159,17 @@ m_inc(struct mbuf *m, int size)
     }
=20
     if (m->m_flags & M_EXT) {
-        datasize =3D m->m_data - m->m_ext;
-        m->m_ext =3D g_realloc(m->m_ext, size + datasize);
+        gapsize =3D m->m_data - m->m_ext;
+        m->m_ext =3D g_realloc(m->m_ext, size + gapsize);
     } else {
-        datasize =3D m->m_data - m->m_dat;
-        m->m_ext =3D g_malloc(size + datasize);
+        gapsize =3D m->m_data - m->m_dat;
+        m->m_ext =3D g_malloc(size + gapsize);
         memcpy(m->m_ext, m->m_dat, m->m_size);
         m->m_flags |=3D M_EXT;
     }
=20
-    m->m_data =3D m->m_ext + datasize;
-    m->m_size =3D size + datasize;
+    m->m_data =3D m->m_ext + gapsize;
+    m->m_size =3D size + gapsize;
 }
=20
=20
diff --git a/slirp/mbuf.h b/slirp/mbuf.h
index 33b84485d6..bfdf8c4577 100644
--- a/slirp/mbuf.h
+++ b/slirp/mbuf.h
@@ -47,6 +47,19 @@
  * free the m_ext.  This is inefficient memory-wise, but who cares.
  */
=20
+/*
+ * mbufs allow to have a gap between the start of the allocated buffer (=
m_ext if
+ * M_EXT is set, m_dat otherwise) and the in-use data:
+ *
+ *  |--gapsize----->|---m_len------->
+ *  |----------m_size------------------------------>
+ *                  |----M_ROOM-------------------->
+ *                                   |-M_FREEROOM-->
+ *
+ *  ^               ^                               ^
+ *  m_dat/m_ext     m_data                          end of buffer
+ */
+
 /*
  * How much room is in the mbuf, from m_data to the end of the mbuf
  */
--=20
2.19.0
