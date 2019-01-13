Received: from eggs.gnu.org ([209.51.188.92]:51885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gik5F-0007VL-12
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 13:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gik5D-0004ln-RX
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 13:02:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gik5D-0004h6-LU
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 13:02:03 -0500
From: P J P <ppandit@redhat.com>
Date: Sun, 13 Jan 2019 23:29:48 +0530
Message-Id: <20190113175948.21076-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] slirp: check data length while emulating
 ident function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, Kira <864786842@qq.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While emulating identification protocol, tcp_emu() does not check
available space in the 'sc_rcv->sb_data' buffer. It could lead to
heap buffer overflow issue. Add check to avoid it.

Reported-by: Kira <864786842@qq.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 slirp/tcp_subr.c | 4 ++++
 1 file changed, 4 insertions(+)

Update v2: return 1 instead of 0
  -> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02182.html

diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index fa61349cbb..8b1bd8c8c0 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -635,6 +635,10 @@ tcp_emu(struct socket *so, struct mbuf *m)
 			socklen_t addrlen =3D sizeof(struct sockaddr_in);
 			struct sbuf *so_rcv =3D &so->so_rcv;
=20
+            if (m->m_len > so_rcv->sb_datalen
+                            - (so_rcv->sb_wptr - so_rcv->sb_data)) {
+                return 1;
+            }
 			memcpy(so_rcv->sb_wptr, m->m_data, m->m_len);
 			so_rcv->sb_wptr +=3D m->m_len;
 			so_rcv->sb_rptr +=3D m->m_len;
--=20
2.20.1
