Received: from eggs.gnu.org ([2001:4830:134:3::10]:45133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fRAeM-0007dn-Eo
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fRAeL-0004Jj-Ep
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:26 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:53446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fRAeL-0004JT-8W
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:25 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Fri,  8 Jun 2018 09:13:15 +0300
Message-Id: <20180608061316.4909-5-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180608061316.4909-1-samuel.thibault@ens-lyon.org>
References: <20180608061316.4909-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 4/5] slirp: correct size computation while
 concatenating mbuf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While reassembling incoming fragmented datagrams, 'm_cat' routine
extends the 'mbuf' buffer, if it has insufficient room. It computes
a wrong buffer size, which leads to overwriting adjacent heap buffer
area. Correct this size computation in m_cat.

Reported-by: ZDI Disclosures <zdi-disclosures@trendmicro.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/mbuf.c | 11 +++++------
 slirp/mbuf.h |  8 +++-----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/slirp/mbuf.c b/slirp/mbuf.c
index 5ff24559fd..18cbf759a7 100644
--- a/slirp/mbuf.c
+++ b/slirp/mbuf.c
@@ -138,7 +138,7 @@ m_cat(struct mbuf *m, struct mbuf *n)
 	 * If there's no room, realloc
 	 */
 	if (M_FREEROOM(m) < n->m_len)
-		m_inc(m,m->m_size+MINCSIZE);
+		m_inc(m, m->m_len + n->m_len);
 
 	memcpy(m->m_data+m->m_len, n->m_data, n->m_len);
 	m->m_len += n->m_len;
@@ -147,7 +147,7 @@ m_cat(struct mbuf *m, struct mbuf *n)
 }
 
 
-/* make m size bytes large */
+/* make m 'size' bytes large from m_data */
 void
 m_inc(struct mbuf *m, int size)
 {
@@ -158,12 +158,12 @@ m_inc(struct mbuf *m, int size)
 
         if (m->m_flags & M_EXT) {
 	  datasize = m->m_data - m->m_ext;
-          m->m_ext = g_realloc(m->m_ext, size);
+	  m->m_ext = g_realloc(m->m_ext, size + datasize);
 	  m->m_data = m->m_ext + datasize;
         } else {
 	  char *dat;
 	  datasize = m->m_data - m->m_dat;
-          dat = g_malloc(size);
+	  dat = g_malloc(size + datasize);
 	  memcpy(dat, m->m_dat, m->m_size);
 
 	  m->m_ext = dat;
@@ -171,8 +171,7 @@ m_inc(struct mbuf *m, int size)
 	  m->m_flags |= M_EXT;
         }
 
-        m->m_size = size;
-
+        m->m_size = size + datasize;
 }
 
 
diff --git a/slirp/mbuf.h b/slirp/mbuf.h
index 893601ff9d..33b84485d6 100644
--- a/slirp/mbuf.h
+++ b/slirp/mbuf.h
@@ -33,8 +33,6 @@
 #ifndef MBUF_H
 #define MBUF_H
 
-#define MINCSIZE 4096	/* Amount to increase mbuf if too small */
-
 /*
  * Macros for type conversion
  * mtod(m,t) -	convert mbuf pointer to data pointer of correct type
@@ -72,11 +70,11 @@ struct mbuf {
 	struct	mbuf *m_prevpkt;	/* Flags aren't used in the output queue */
 	int	m_flags;		/* Misc flags */
 
-	int	m_size;			/* Size of data */
+	int	m_size;			/* Size of mbuf, from m_dat or m_ext */
 	struct	socket *m_so;
 
-	caddr_t	m_data;			/* Location of data */
-	int	m_len;			/* Amount of data in this mbuf */
+	caddr_t	m_data;			/* Current location of data */
+	int	m_len;			/* Amount of data in this mbuf, from m_data */
 
 	Slirp *slirp;
 	bool	resolution_requested;
-- 
2.17.1
