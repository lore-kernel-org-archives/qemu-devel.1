Received: from eggs.gnu.org ([209.51.188.92]:40070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hH6dT-0004RI-Kj
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hH6dQ-0007Bt-5s
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:59:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8077)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hH6dN-000796-V0
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:59:23 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 18 Apr 2019 14:59:08 +0200
Message-Id: <20190418125908.11928-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190418125908.11928-1-marcandre.lureau@redhat.com>
References: <20190418125908.11928-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] slirp: don't manipulate so_rcv in tcp_emu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

For some reason, EMU_IDENT is not like other "emulated" protocols and
tries to reconstitute the original buffer, if it came in multiple
packets. Unfortunately, it does so wrongly, as it doesn't respect the
sbuf circular buffer appending rules, nor does it maintain some of the
invariants (rptr is incremented without bounds, etc): this leads to
further memory corruption revealed by ASAN or various malloc
errors. Furthermore, the so_rcv buffer is regularly flushed, so there
is no guarantee that buffer reconstruction will do what is expected.

Instead, do what the function comment says: "XXX Assumes the whole
command came in one packet", and don't touch so_rcv.

Related to: https://bugzilla.redhat.com/show_bug.cgi?id=3D1664205

Cc: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/src/tcp_subr.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/slirp/src/tcp_subr.c b/slirp/src/tcp_subr.c
index c43598de48..f4379ae012 100644
--- a/slirp/src/tcp_subr.c
+++ b/slirp/src/tcp_subr.c
@@ -634,20 +634,9 @@ tcp_emu(struct socket *so, struct mbuf *m)
 			struct socket *tmpso;
 			struct sockaddr_in addr;
 			socklen_t addrlen =3D sizeof(struct sockaddr_in);
-			struct sbuf *so_rcv =3D &so->so_rcv;
=20
-			if (m->m_len > so_rcv->sb_datalen
-					- (so_rcv->sb_wptr - so_rcv->sb_data)) {
-			    return 1;
-			}
-
-			memcpy(so_rcv->sb_wptr, m->m_data, m->m_len);
-			so_rcv->sb_wptr +=3D m->m_len;
-			so_rcv->sb_rptr +=3D m->m_len;
-			m_inc(m, m->m_len + 1);
-			m->m_data[m->m_len] =3D 0; /* NULL terminate */
-			if (strchr(m->m_data, '\r') || strchr(m->m_data, '\n')) {
-				if (sscanf(so_rcv->sb_data, "%u%*[ ,]%u", &n1, &n2) =3D=3D 2) {
+			if (g_strstr_len(m->m_data, m->m_len, "\r\n")
+				&& sscanf(m->m_data, "%u%*[ ,]%u\r\n", &n1, &n2) =3D=3D 2) {
 					HTONS(n1);
 					HTONS(n2);
 					/* n2 is the one on our host */
@@ -666,15 +655,10 @@ tcp_emu(struct socket *so, struct mbuf *m)
 					}
 					NTOHS(n1);
 					NTOHS(n2);
-					so_rcv->sb_cc =3D snprintf(so_rcv->sb_data,
-								 so_rcv->sb_datalen,
-								 "%d,%d\r\n", n1, n2);
-					so_rcv->sb_rptr =3D so_rcv->sb_data;
-					so_rcv->sb_wptr =3D so_rcv->sb_data + so_rcv->sb_cc;
+					m->m_len =3D snprintf(m->m_data, m->m_size,
+										"%d,%d\r\n", n1, n2);
 				}
-			}
-			m_free(m);
-			return 0;
+			return 1;
 		}
=20
         case EMU_FTP: /* ftp */
--=20
2.21.0.313.ge35b8cb8e2
