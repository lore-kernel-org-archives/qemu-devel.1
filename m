Received: from eggs.gnu.org ([2001:4830:134:3::10]:41008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORY-0000gz-5Y
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORT-0005EK-1O
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:27 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:41896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZORL-0004wt-Fu
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:17 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:30 +0100
Message-Id: <20181218230442.27887-53-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 52/64] slirp: replace a DEBUG block with
 WITH_ICMP_ERROR_MSG
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

icmp_send_error() doesnt actually log messages when DEBUG is enabled.
Let's use a different define that describes better the tweaked
behaviour of the function, and avoid uncompiled code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip_icmp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index af11cfcefe..6c7e375ff8 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -34,6 +34,10 @@
 #include "slirp.h"
 #include "ip_icmp.h"
=20
+#ifndef WITH_ICMP_ERROR_MSG
+#define WITH_ICMP_ERROR_MSG 0
+#endif
+
 /* The message sent when emulating PING */
 /* Be nice and tell them it's just a pseudo-ping packet */
 static const char icmp_ping_msg[] =3D "This is a pseudo-PING packet used=
 by Slirp to emulate ICMP ECHO-REQUEST packets.\n";
@@ -319,8 +323,7 @@ icmp_send_error(struct mbuf *msrc, u_char type, u_cha=
r code, int minsize,
   HTONS(icp->icmp_ip.ip_id);
   HTONS(icp->icmp_ip.ip_off);
=20
-#ifdef DEBUG
-  if(message) {           /* DEBUG : append message to ICMP packet */
+  if (message && WITH_ICMP_ERROR_MSG) { /* append message to ICMP packet=
 */
     int message_len;
     char *cpnt;
     message_len=3Dstrlen(message);
@@ -329,7 +332,6 @@ icmp_send_error(struct mbuf *msrc, u_char type, u_cha=
r code, int minsize,
     memcpy(cpnt, message, message_len);
     m->m_len+=3Dmessage_len;
   }
-#endif
=20
   icp->icmp_cksum =3D 0;
   icp->icmp_cksum =3D cksum(m, m->m_len);
--=20
2.19.2
