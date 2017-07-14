Received: from eggs.gnu.org ([2001:4830:134:3::10]:58382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVyWO-0006fu-0r
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVyWN-0006zt-3H
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:12:31 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dVyWM-0006zL-Su
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:12:31 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 12:12:24 +0100
Message-Id: <1500030745-10619-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500030745-10619-1-git-send-email-peter.maydell@linaro.org>
References: <1500030745-10619-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 1/2] slirp: Handle error returns from
 slirp_send() in sosendoob()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

The code in sosendoob() assumes that slirp_send() always
succeeds, but it might return an OS error code (for instance
if the other end has disconnected). Catch these and return
the caller either -1 on error or the number of urgent bytes
actually written. (None of the callers check this return
value currently, though.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-id: 1496679576-14336-2-git-send-email-peter.maydell@linaro.org
---
 slirp/socket.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index 3b49a69..a17caa9 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -345,33 +345,40 @@ sosendoob(struct socket *so)
 	if (sb->sb_rptr < sb->sb_wptr) {
 		/* We can send it directly */
 		n = slirp_send(so, sb->sb_rptr, so->so_urgc, (MSG_OOB)); /* |MSG_DONTWAIT)); */
-		so->so_urgc -= n;
-
-		DEBUG_MISC((dfd, " --- sent %d bytes urgent data, %d urgent bytes left\n", n, so->so_urgc));
 	} else {
 		/*
 		 * Since there's no sendv or sendtov like writev,
 		 * we must copy all data to a linear buffer then
 		 * send it all
 		 */
+		uint32_t urgc = so->so_urgc;
 		len = (sb->sb_data + sb->sb_datalen) - sb->sb_rptr;
-		if (len > so->so_urgc) len = so->so_urgc;
+		if (len > urgc) {
+			len = urgc;
+		}
 		memcpy(buff, sb->sb_rptr, len);
-		so->so_urgc -= len;
-		if (so->so_urgc) {
+		urgc -= len;
+		if (urgc) {
 			n = sb->sb_wptr - sb->sb_data;
-			if (n > so->so_urgc) n = so->so_urgc;
+			if (n > urgc) {
+				n = urgc;
+			}
 			memcpy((buff + len), sb->sb_data, n);
-			so->so_urgc -= n;
 			len += n;
 		}
 		n = slirp_send(so, buff, len, (MSG_OOB)); /* |MSG_DONTWAIT)); */
+	}
+
 #ifdef DEBUG
-		if (n != len)
-		   DEBUG_ERROR((dfd, "Didn't send all data urgently XXXXX\n"));
+	if (n != len) {
+		DEBUG_ERROR((dfd, "Didn't send all data urgently XXXXX\n"));
+	}
 #endif
-		DEBUG_MISC((dfd, " ---2 sent %d bytes urgent data, %d urgent bytes left\n", n, so->so_urgc));
+	if (n < 0) {
+		return n;
 	}
+	so->so_urgc -= n;
+	DEBUG_MISC((dfd, " ---2 sent %d bytes urgent data, %d urgent bytes left\n", n, so->so_urgc));
 
 	sb->sb_cc -= n;
 	sb->sb_rptr += n;
-- 
2.7.4
