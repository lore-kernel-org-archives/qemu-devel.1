Received: from eggs.gnu.org ([2001:4830:134:3::10]:43230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOUEW-0006kw-KT
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOUEK-00020U-LR
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:31:40 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:50852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fOUEK-0001zB-Cs
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:31:28 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu, 31 May 2018 22:31:10 +0200
Message-Id: <20180531203110.17203-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCHv2] slirp: Fix spurious error report when
 sending directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com, f4bug@amsat.org

Move check to where it actually is useful, and reduce scope of 'len'
variable along the way.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---

Difference from v1:
- move check instead of initializing len.

 slirp/socket.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index e2a71c9b04..08fe98907d 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -340,7 +340,7 @@ sosendoob(struct socket *so)
 	struct sbuf *sb = &so->so_rcv;
 	char buff[2048]; /* XXX Shouldn't be sending more oob data than this */
 
-	int n, len;
+	int n;
 
 	DEBUG_CALL("sosendoob");
 	DEBUG_ARG("so = %p", so);
@@ -359,7 +359,7 @@ sosendoob(struct socket *so)
 		 * send it all
 		 */
 		uint32_t urgc = so->so_urgc;
-		len = (sb->sb_data + sb->sb_datalen) - sb->sb_rptr;
+		int len = (sb->sb_data + sb->sb_datalen) - sb->sb_rptr;
 		if (len > urgc) {
 			len = urgc;
 		}
@@ -374,13 +374,13 @@ sosendoob(struct socket *so)
 			len += n;
 		}
 		n = slirp_send(so, buff, len, (MSG_OOB)); /* |MSG_DONTWAIT)); */
-	}
-
 #ifdef DEBUG
-	if (n != len) {
-		DEBUG_ERROR((dfd, "Didn't send all data urgently XXXXX\n"));
-	}
+		if (n != len) {
+			DEBUG_ERROR((dfd, "Didn't send all data urgently XXXXX\n"));
+		}
 #endif
+	}
+
 	if (n < 0) {
 		return n;
 	}
-- 
2.17.0
