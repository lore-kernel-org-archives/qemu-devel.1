Received: from eggs.gnu.org ([2001:4830:134:3::10]:51183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPagD-0005jH-Ll
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPag9-0003ba-7d
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPag8-0003Zm-VK
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:01 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:34 +0400
Message-Id: <20181121220647.18844-18-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 17/30] slirp: replace a DEBUG
 block with WITH_ICMP_ERROR_MSG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

icmp_send_error() doesnt actually log messages when DEBUG is enabled.
Let's use a different define that describes better the tweaked
behaviour of the function, and avoid uncompiled code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
2.20.0.rc1
