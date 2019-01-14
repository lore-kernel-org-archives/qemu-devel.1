Received: from eggs.gnu.org ([209.51.188.92]:51458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipkQ-0003DA-Jh
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipkP-0006aP-AZ
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:58 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:60312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gipkN-0006Kl-3A
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:57 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 01:02:37 +0100
Message-Id: <20190114000326.29847-17-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
References: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/65] slirp: remove PROBE_CONN dead-code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Nobody cares for over 14y. Somebody can revert or rewrite if
interested by that.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp.c        | 41 -----------------------------------------
 slirp/slirp_config.h |  4 ----
 2 files changed, 45 deletions(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index bab49e83e3..76e94eb1cd 100644
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
--=20
2.20.1
