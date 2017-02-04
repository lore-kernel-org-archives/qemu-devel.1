Received: from eggs.gnu.org ([2001:4830:134:3::10]:37439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ca9Rh-0004Gz-0D
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 18:08:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ca9Rd-0007x0-Rv
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 18:08:40 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ca9Rd-0007wk-L2
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 18:08:37 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat,  4 Feb 2017 23:08:33 +0000
Message-Id: <1486249715-5513-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486249715-5513-1-git-send-email-peter.maydell@linaro.org>
References: <1486249715-5513-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/3] slirp: Check qemu_socket() return value in
 udp_listen()
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

Check the return value from qemu_socket() rather than trying to
pass it to bind() as an fd argument even if it's negative.
This wouldn't have caused any negative consequences, because
it won't be a valid fd number and the bind call will fail;
but Coverity complains (CID 1005723).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 slirp/udp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/slirp/udp.c b/slirp/udp.c
index 93d7224..227d779 100644
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -335,6 +335,10 @@ udp_listen(Slirp *slirp, uint32_t haddr, u_int hport, uint32_t laddr,
 	    return NULL;
 	}
 	so->s = qemu_socket(AF_INET,SOCK_DGRAM,0);
+        if (so->s < 0) {
+            sofree(so);
+            return NULL;
+        }
 	so->so_expire = curtime + SO_EXPIRE;
 	insque(so, &slirp->udb);
 
-- 
2.1.4
