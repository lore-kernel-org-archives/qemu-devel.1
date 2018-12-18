Received: from eggs.gnu.org ([2001:4830:134:3::10]:40792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORB-0000Om-PG
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORA-00053Y-5j
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:05 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOR9-0004I9-Jo
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:03 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:10 +0100
Message-Id: <20181218230442.27887-33-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/64] slirp: replace compile time DO_KEEPALIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Use a global variable instead (similar to slirp_debug)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp.c        |  3 +++
 slirp/slirp.h        |  6 +++---
 slirp/slirp_config.h | 12 ------------
 slirp/tcp_input.c    |  2 +-
 slirp/tcp_timer.c    |  2 +-
 5 files changed, 8 insertions(+), 17 deletions(-)
 delete mode 100644 slirp/slirp_config.h

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 4fd957be89..3261a04236 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -35,6 +35,9 @@
 #include <net/if.h>
 #endif
=20
+/* Define to 1 if you want KEEPALIVE timers */
+bool slirp_do_keepalive;
+
 /* host loopback address */
 struct in_addr loopback_addr;
 /* host loopback network mask */
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 4bbbba046e..05c203c8c7 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -1,8 +1,6 @@
 #ifndef SLIRP_H
 #define SLIRP_H
=20
-#include "slirp_config.h"
-
 #ifdef _WIN32
=20
 typedef char *caddr_t;
@@ -219,7 +217,9 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, int=
 pkt_len);
 #include <netdb.h>
 #endif
=20
-#define SO_OPTIONS DO_KEEPALIVE
+
+extern bool slirp_do_keepalive;
+
 #define TCP_MAXIDLE (TCPTV_KEEPCNT * TCPTV_KEEPINTVL)
=20
 /* dnssearch.c */
diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
deleted file mode 100644
index 7147e0de04..0000000000
--- a/slirp/slirp_config.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * User definable configuration options
- */
-
-/* Define to 1 if you want KEEPALIVE timers */
-#define DO_KEEPALIVE 0
-
-/*********************************************************/
-/*
- * Autoconf defined configuration options
- * You shouldn't need to touch any of these
- */
diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index d073ef9525..922dbe32eb 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -481,7 +481,7 @@ findso:
 	 * Reset idle time and keep-alive timer.
 	 */
 	tp->t_idle =3D 0;
-	if (SO_OPTIONS)
+	if (slirp_do_keepalive)
 	   tp->t_timer[TCPT_KEEP] =3D TCPTV_KEEPINTVL;
 	else
 	   tp->t_timer[TCPT_KEEP] =3D TCPTV_KEEP_IDLE;
diff --git a/slirp/tcp_timer.c b/slirp/tcp_timer.c
index 52ef5f9100..d953a16386 100644
--- a/slirp/tcp_timer.c
+++ b/slirp/tcp_timer.c
@@ -262,7 +262,7 @@ tcp_timers(register struct tcpcb *tp, int timer)
 		if (tp->t_state < TCPS_ESTABLISHED)
 			goto dropit;
=20
-		if ((SO_OPTIONS) && tp->t_state <=3D TCPS_CLOSE_WAIT) {
+		if (slirp_do_keepalive && tp->t_state <=3D TCPS_CLOSE_WAIT) {
 		    	if (tp->t_idle >=3D TCPTV_KEEP_IDLE + TCP_MAXIDLE)
 				goto dropit;
 			/*
--=20
2.19.2
