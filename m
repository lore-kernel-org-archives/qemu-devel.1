Received: from eggs.gnu.org ([209.51.188.92]:50328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ghsCc-00031i-5h
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:30:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ghsCa-0008Gr-8n
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:30:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1ghsCY-0008CW-56
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:30:02 -0500
From: P J P <ppandit@redhat.com>
Date: Fri, 11 Jan 2019 13:49:09 +0530
Message-Id: <20190111081909.11896-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] slirp: check data length while emulating ident
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, Kira <864786842@qq.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While emulating identification protocol, tcp_emu() does not check
available space in the 'sc_rcv->sb_data' buffer. It could lead to
heap buffer overflow issue. Add check to avoid it.

Reported-by: Kira <864786842@qq.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 slirp/tcp_subr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index fa61349cbb..4415801fbb 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -635,6 +635,11 @@ tcp_emu(struct socket *so, struct mbuf *m)
 			socklen_t addrlen =3D sizeof(struct sockaddr_in);
 			struct sbuf *so_rcv =3D &so->so_rcv;
=20
+            if (m->m_len > so_rcv->sb_datalen
+                            - (so_rcv->sb_wptr - so_rcv->sb_data)) {
+                m_free(m);
+                return 0;
+            }
 			memcpy(so_rcv->sb_wptr, m->m_data, m->m_len);
 			so_rcv->sb_wptr +=3D m->m_len;
 			so_rcv->sb_rptr +=3D m->m_len;
--=20
2.20.1
