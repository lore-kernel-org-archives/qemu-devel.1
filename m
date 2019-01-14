Received: from eggs.gnu.org ([209.51.188.92]:51867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipl1-0003mq-DH
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipkn-0006w6-QC
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:05:26 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:60568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gipkm-0006kC-5C
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:05:20 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 01:03:26 +0100
Message-Id: <20190114000326.29847-66-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
References: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 65/65] slirp: check data length while emulating
 ident function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Kira <864786842@qq.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While emulating identification protocol, tcp_emu() does not check
available space in the 'sc_rcv->sb_data' buffer. It could lead to
heap buffer overflow issue. Add check to avoid it.

Reported-by: Kira <864786842@qq.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/tcp_subr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 4a9a5b5edc..23a841f26e 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -634,6 +634,11 @@ tcp_emu(struct socket *so, struct mbuf *m)
 			socklen_t addrlen =3D sizeof(struct sockaddr_in);
 			struct sbuf *so_rcv =3D &so->so_rcv;
=20
+			if (m->m_len > so_rcv->sb_datalen
+					- (so_rcv->sb_wptr - so_rcv->sb_data)) {
+			    return 1;
+			}
+
 			memcpy(so_rcv->sb_wptr, m->m_data, m->m_len);
 			so_rcv->sb_wptr +=3D m->m_len;
 			so_rcv->sb_rptr +=3D m->m_len;
--=20
2.20.1
