Received: from eggs.gnu.org ([2001:4830:134:3::10]:58952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuRX-0000iN-FL
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuRP-0001YC-Bj
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuRN-0001UC-0e
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:41 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:12 +0400
Message-Id: <20181114123643.24091-11-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 10/41] slirp: remove PROBE_CONN
 dead-code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Nobody cares for over 14y. Somebody can revert or rewrite if
interested by that.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/slirp_config.h |  4 ----
 slirp/slirp.c        | 41 -----------------------------------------
 2 files changed, 45 deletions(-)

diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
index c59f655207..721667e3ef 100644
--- a/slirp/slirp_config.h
+++ b/slirp/slirp_config.h
@@ -2,10 +2,6 @@
  * User definable configuration options
  */
=20
-/* Define if you want the connection to be probed */
-/* XXX Not working yet, so ignore this for now */
-#undef PROBE_CONN
-
 /* Define to 1 if you want KEEPALIVE timers */
 #define DO_KEEPALIVE 0
=20
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 979495e88b..2d32debf2a 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -699,47 +699,6 @@ void slirp_pollfds_poll(GArray *pollfds, int select_=
error)
                         }
                     }
                 }
-
-                /*
-                 * Probe a still-connecting, non-blocking socket
-                 * to check if it's still alive
-                 */
-#ifdef PROBE_CONN
-                if (so->so_state & SS_ISFCONNECTING) {
-                    ret =3D qemu_recv(so->s, &ret, 0, 0);
-
-                    if (ret < 0) {
-                        /* XXX */
-                        if (errno =3D=3D EAGAIN || errno =3D=3D EWOULDBL=
OCK ||
-                            errno =3D=3D EINPROGRESS || errno =3D=3D ENO=
TCONN) {
-                            continue; /* Still connecting, continue */
-                        }
-
-                        /* else failed */
-                        so->so_state &=3D SS_PERSISTENT_MASK;
-                        so->so_state |=3D SS_NOFDREF;
-
-                        /* tcp_input will take care of it */
-                    } else {
-                        ret =3D send(so->s, &ret, 0, 0);
-                        if (ret < 0) {
-                            /* XXX */
-                            if (errno =3D=3D EAGAIN || errno =3D=3D EWOU=
LDBLOCK ||
-                                errno =3D=3D EINPROGRESS || errno =3D=3D=
 ENOTCONN) {
-                                continue;
-                            }
-                            /* else failed */
-                            so->so_state &=3D SS_PERSISTENT_MASK;
-                            so->so_state |=3D SS_NOFDREF;
-                        } else {
-                            so->so_state &=3D ~SS_ISFCONNECTING;
-                        }
-
-                    }
-                    tcp_input((struct mbuf *)NULL, sizeof(struct ip), so=
,
-                              so->so_ffamily);
-                } /* SS_ISFCONNECTING */
-#endif
             }
=20
             /*
--=20
2.19.1.708.g4ede3d42df
