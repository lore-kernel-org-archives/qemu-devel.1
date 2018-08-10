Received: from eggs.gnu.org ([2001:4830:134:3::10]:56368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fo3XZ-00009O-1o
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fo3XV-0002c5-QM
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:17:00 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:4892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fo3XV-0002Zh-Dy
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:16:57 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Fri, 10 Aug 2018 11:16:50 +0200
Message-Id: <20180810091650.14194-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCH] slirp: document mbuf pointers and sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

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
 
     /* some compilers throw up on gotos.  This one we can fake. */
     if (M_ROOM(m) > size) {
@@ -159,17 +159,17 @@ m_inc(struct mbuf *m, int size)
     }
 
     if (m->m_flags & M_EXT) {
-        datasize = m->m_data - m->m_ext;
-        m->m_ext = g_realloc(m->m_ext, size + datasize);
+        gapsize = m->m_data - m->m_ext;
+        m->m_ext = g_realloc(m->m_ext, size + gapsize);
     } else {
-        datasize = m->m_data - m->m_dat;
-        m->m_ext = g_malloc(size + datasize);
+        gapsize = m->m_data - m->m_dat;
+        m->m_ext = g_malloc(size + gapsize);
         memcpy(m->m_ext, m->m_dat, m->m_size);
         m->m_flags |= M_EXT;
     }
 
-    m->m_data = m->m_ext + datasize;
-    m->m_size = size + datasize;
+    m->m_data = m->m_ext + gapsize;
+    m->m_size = size + gapsize;
 }
 
 
diff --git a/slirp/mbuf.h b/slirp/mbuf.h
index 33b84485d6..bfdf8c4577 100644
--- a/slirp/mbuf.h
+++ b/slirp/mbuf.h
@@ -47,6 +47,19 @@
  * free the m_ext.  This is inefficient memory-wise, but who cares.
  */
 
+/*
+ * mbufs allow to have a gap between the start of the allocated buffer (m_ext if
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
-- 
2.18.0
