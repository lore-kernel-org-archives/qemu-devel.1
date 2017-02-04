Received: from eggs.gnu.org ([2001:4830:134:3::10]:40792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ca9qL-0000Dv-V9
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 18:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ca9qG-0000wV-Iu
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 18:34:09 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ca9qG-0000vE-CY
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 18:34:04 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat,  4 Feb 2017 23:08:35 +0000
Message-Id: <1486249715-5513-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486249715-5513-1-git-send-email-peter.maydell@linaro.org>
References: <1486249715-5513-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/3] slirp: tcp_listen(): Don't try to close()
 an fd we never opened
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

Coverity points out (CID 1005725) that an error-exit path in tcp_listen()
will try to close(s) even if the reason it got there was that the
qemu_socket() failed and s was never opened.  Not only that, this isn't even
the right function to use, because we need closesocket() to do the right
thing on Windows.  Change to using the right function and only calling it if
needed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 slirp/socket.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index 6c18971..8692772 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -713,7 +713,9 @@ tcp_listen(Slirp *slirp, uint32_t haddr, u_int hport, uint32_t laddr,
 	    (listen(s,1) < 0)) {
 		int tmperrno = errno; /* Don't clobber the real reason we failed */
 
-		close(s);
+                if (s >= 0) {
+                    closesocket(s);
+                }
 		sofree(so);
 		/* Restore the real errno */
 #ifdef _WIN32
-- 
2.1.4
