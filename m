Received: from eggs.gnu.org ([209.51.188.92]:40038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hH6dM-0004Kd-60
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hH6dK-00076U-5o
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:59:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hH6dJ-000746-Ts
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:59:18 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 18 Apr 2019 14:59:07 +0200
Message-Id: <20190418125908.11928-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190418125908.11928-1-marcandre.lureau@redhat.com>
References: <20190418125908.11928-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] slirp: ensure there is enough space in
 mbuf to null-terminate
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

Prevents from buffer overflows.
Related to: https://bugzilla.redhat.com/show_bug.cgi?id=3D1664205

Cc: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/src/tcp_subr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/slirp/src/tcp_subr.c b/slirp/src/tcp_subr.c
index fde9207b0c..c43598de48 100644
--- a/slirp/src/tcp_subr.c
+++ b/slirp/src/tcp_subr.c
@@ -644,6 +644,7 @@ tcp_emu(struct socket *so, struct mbuf *m)
 			memcpy(so_rcv->sb_wptr, m->m_data, m->m_len);
 			so_rcv->sb_wptr +=3D m->m_len;
 			so_rcv->sb_rptr +=3D m->m_len;
+			m_inc(m, m->m_len + 1);
 			m->m_data[m->m_len] =3D 0; /* NULL terminate */
 			if (strchr(m->m_data, '\r') || strchr(m->m_data, '\n')) {
 				if (sscanf(so_rcv->sb_data, "%u%*[ ,]%u", &n1, &n2) =3D=3D 2) {
@@ -677,6 +678,7 @@ tcp_emu(struct socket *so, struct mbuf *m)
 		}
=20
         case EMU_FTP: /* ftp */
+                m_inc(m, m->m_len + 1);
                 *(m->m_data+m->m_len) =3D 0; /* NUL terminate for strstr=
 */
 		if ((bptr =3D (char *)strstr(m->m_data, "ORT")) !=3D NULL) {
 			/*
@@ -774,6 +776,7 @@ tcp_emu(struct socket *so, struct mbuf *m)
 		/*
 		 * Need to emulate DCC CHAT, DCC SEND and DCC MOVE
 		 */
+		m_inc(m, m->m_len + 1);
 		*(m->m_data+m->m_len) =3D 0; /* NULL terminate the string for strstr *=
/
 		if ((bptr =3D (char *)strstr(m->m_data, "DCC")) =3D=3D NULL)
 			 return 1;
--=20
2.21.0.313.ge35b8cb8e2
