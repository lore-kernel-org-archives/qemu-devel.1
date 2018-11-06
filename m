Received: from eggs.gnu.org ([2001:4830:134:3::10]:35615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK33L-0004DP-PK
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK33E-0004mJ-7U
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:14:03 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gK33D-0004AK-Sy
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:13:56 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Nov 2018 15:13:20 +0000
Message-Id: <20181106151323.16154-2-peter.maydell@linaro.org>
In-Reply-To: <20181106151323.16154-1-peter.maydell@linaro.org>
References: <20181106151323.16154-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1 1/4] slirp: Don't pass possibly -1 fd
 to send()
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

Coverity complains (CID 1005726) that we might pass -1 as the fd
argument to send() in slirp_send(), because we previously checked for
"so->s == -1 && so->extra".  The case of "so->s == -1 but so->extra
NULL" should not in theory happen, but it is hard to guarantee
because various places in the code do so->s = qemu_socket(...) and so
will end up with so->s == -1 on failure, and not all the paths which
call that always throw away the socket in that case (eg
tcp_fconnect()).  So just check specifically for the condition and
fail slirp_send().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is to some extent just placating Coverity.
---
 slirp/slirp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 51de41fc021..3c3c03b22f7 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1091,6 +1091,17 @@ ssize_t slirp_send(struct socket *so, const void *buf, size_t len, int flags)
         return len;
     }
 
+    if (so->s == -1) {
+        /*
+         * This should in theory not happen but it is hard to be
+         * sure because some code paths will end up with so->s == -1
+         * on a failure but don't dispose of the struct socket.
+         * Check specifically, so we don't pass -1 to send().
+         */
+        errno = EBADF;
+        return -1;
+    }
+
     return send(so->s, buf, len, flags);
 }
 
-- 
2.19.1
