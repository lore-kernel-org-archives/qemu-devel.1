Received: from eggs.gnu.org ([2001:4830:134:3::10]:48392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1fQVnL-000657-3a
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1fQVnJ-0001e5-V0
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:35:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1fQVnJ-0001dv-Qd
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:35:57 -0400
From: P J P <ppandit@redhat.com>
Date: Wed,  6 Jun 2018 16:05:48 +0530
Message-Id: <20180606103549.12031-2-ppandit@redhat.com>
In-Reply-To: <20180606103549.12031-1-ppandit@redhat.com>
References: <20180606103549.12031-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/2] slirp: correct size computation while
 concatenating mbuf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While reassembling incoming fragmented datagrams, 'm_cat' routine
extends the 'mbuf' buffer, if it has insufficient room. It computes
a wrong buffer size, which leads to overwriting adjacent heap buffer
area. Correct this size computation in m_cat.

Reported-by: ZDI Disclosures <zdi-disclosures@trendmicro.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 slirp/mbuf.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Update v1: fixed indentation
    https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg01121.html

diff --git a/slirp/mbuf.c b/slirp/mbuf.c
index 5ff24559fd..6650981fc7 100644
--- a/slirp/mbuf.c
+++ b/slirp/mbuf.c
@@ -137,8 +137,9 @@ m_cat(struct mbuf *m, struct mbuf *n)
 	/*
 	 * If there's no room, realloc
 	 */
-	if (M_FREEROOM(m) < n->m_len)
-		m_inc(m,m->m_size+MINCSIZE);
+    if (M_FREEROOM(m) < n->m_len) {
+        m_inc(m, m->m_len + n->m_len);
+    }
 
 	memcpy(m->m_data+m->m_len, n->m_data, n->m_len);
 	m->m_len += n->m_len;
@@ -158,12 +159,12 @@ m_inc(struct mbuf *m, int size)
 
         if (m->m_flags & M_EXT) {
 	  datasize = m->m_data - m->m_ext;
-          m->m_ext = g_realloc(m->m_ext, size);
+          m->m_ext = g_realloc(m->m_ext, size + datasize);
 	  m->m_data = m->m_ext + datasize;
         } else {
 	  char *dat;
 	  datasize = m->m_data - m->m_dat;
-          dat = g_malloc(size);
+      dat = g_malloc(size + datasize);
 	  memcpy(dat, m->m_dat, m->m_size);
 
 	  m->m_ext = dat;
@@ -171,7 +172,7 @@ m_inc(struct mbuf *m, int size)
 	  m->m_flags |= M_EXT;
         }
 
-        m->m_size = size;
+        m->m_size = size + datasize;
 
 }
 
-- 
2.17.1
