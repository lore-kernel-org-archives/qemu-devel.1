Received: from eggs.gnu.org ([2001:4830:134:3::10]:56116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci03P-0005ez-8m
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 09:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci03N-00026W-0G
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 09:44:03 -0500
Received: from hera.aquilenet.fr ([141.255.128.1]:51284)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ci03M-00026N-NE
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 09:44:00 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 26 Feb 2017 15:43:52 +0100
Message-Id: <20170226144353.2502-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170226144353.2502-1-samuel.thibault@ens-lyon.org>
References: <20170226144353.2502-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] slirp: Convert mbufs to use g_malloc() and
 g_free()
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

The mbuf code currently doesn't check the result of doing a malloc()
or realloc() of its data (spotted by Coverity, CID 1238946).
Since the m_inc() API assumes that extending an mbuf must succeed,
just convert to g_malloc() and g_free().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/mbuf.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/slirp/mbuf.c b/slirp/mbuf.c
index 7eddc217e4..5ff24559fd 100644
--- a/slirp/mbuf.c
+++ b/slirp/mbuf.c
@@ -10,7 +10,7 @@
  * FreeBSD.  They are fixed size, determined by the MTU,
  * so that one whole packet can fit.  Mbuf's cannot be
  * chained together.  If there's more data than the mbuf
- * could hold, an external malloced buffer is pointed to
+ * could hold, an external g_malloced buffer is pointed to
  * by m_ext (and the data pointers) and M_EXT is set in
  * the flags
  */
@@ -41,26 +41,26 @@ void m_cleanup(Slirp *slirp)
     while ((struct quehead *) m !=3D &slirp->m_usedlist) {
         next =3D m->m_next;
         if (m->m_flags & M_EXT) {
-            free(m->m_ext);
+            g_free(m->m_ext);
         }
-        free(m);
+        g_free(m);
         m =3D next;
     }
     m =3D (struct mbuf *) slirp->m_freelist.qh_link;
     while ((struct quehead *) m !=3D &slirp->m_freelist) {
         next =3D m->m_next;
-        free(m);
+        g_free(m);
         m =3D next;
     }
 }
=20
 /*
  * Get an mbuf from the free list, if there are none
- * malloc one
+ * allocate one
  *
  * Because fragmentation can occur if we alloc new mbufs and
  * free old mbufs, we mark all mbufs above mbuf_thresh as M_DOFREE,
- * which tells m_free to actually free() it
+ * which tells m_free to actually g_free() it
  */
 struct mbuf *
 m_get(Slirp *slirp)
@@ -71,8 +71,7 @@ m_get(Slirp *slirp)
 	DEBUG_CALL("m_get");
=20
 	if (slirp->m_freelist.qh_link =3D=3D &slirp->m_freelist) {
-		m =3D (struct mbuf *)malloc(SLIRP_MSIZE);
-		if (m =3D=3D NULL) goto end_error;
+                m =3D g_malloc(SLIRP_MSIZE);
 		slirp->mbuf_alloced++;
 		if (slirp->mbuf_alloced > MBUF_THRESH)
 			flags =3D M_DOFREE;
@@ -94,7 +93,6 @@ m_get(Slirp *slirp)
         m->m_prevpkt =3D NULL;
         m->resolution_requested =3D false;
         m->expiration_date =3D (uint64_t)-1;
-end_error:
 	DEBUG_ARG("m =3D %p", m);
 	return m;
 }
@@ -112,15 +110,15 @@ m_free(struct mbuf *m)
 	   remque(m);
=20
 	/* If it's M_EXT, free() it */
-	if (m->m_flags & M_EXT)
-	   free(m->m_ext);
-
+        if (m->m_flags & M_EXT) {
+                g_free(m->m_ext);
+        }
 	/*
 	 * Either free() it or put it on the free list
 	 */
 	if (m->m_flags & M_DOFREE) {
 		m->slirp->mbuf_alloced--;
-		free(m);
+                g_free(m);
 	} else if ((m->m_flags & M_FREELIST) =3D=3D 0) {
 		insque(m,&m->slirp->m_freelist);
 		m->m_flags =3D M_FREELIST; /* Clobber other flags */
@@ -130,7 +128,7 @@ m_free(struct mbuf *m)
=20
 /*
  * Copy data from one mbuf to the end of
- * the other.. if result is too big for one mbuf, malloc()
+ * the other.. if result is too big for one mbuf, allocate
  * an M_EXT data segment
  */
 void
@@ -160,12 +158,12 @@ m_inc(struct mbuf *m, int size)
=20
         if (m->m_flags & M_EXT) {
 	  datasize =3D m->m_data - m->m_ext;
-	  m->m_ext =3D (char *)realloc(m->m_ext,size);
+          m->m_ext =3D g_realloc(m->m_ext, size);
 	  m->m_data =3D m->m_ext + datasize;
         } else {
 	  char *dat;
 	  datasize =3D m->m_data - m->m_dat;
-	  dat =3D (char *)malloc(size);
+          dat =3D g_malloc(size);
 	  memcpy(dat, m->m_dat, m->m_size);
=20
 	  m->m_ext =3D dat;
--=20
2.11.0
