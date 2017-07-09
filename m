Received: from eggs.gnu.org ([2001:4830:134:3::10]:58081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUGPe-0000ec-QT
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 13:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUGPb-0002mb-Ov
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 13:54:30 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dUGPb-0002lb-IE
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 13:54:27 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun,  9 Jul 2017 18:54:22 +0100
Message-Id: <20170709175422.30185-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] slirp: fork_exec(): Don't close() a negative
 number in fork_exec()
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

In a fork_exec() error path we try to closesocket(s) when s might
be a negative number because the thing that failed was the
qemu_socket() call. Add a guard so we don't do this.

(Spotted by Coverity: CID 1005727 issue 1 of 2.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Issue 2 of 2 in CID 1005727 is trickier -- we need to move as
much as possible of the client-end connect/accept out of the
child process and into the parent as possible. I'm not sure
if it's safe to do it all in the parent without deadlocking...

 slirp/misc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index 88e9d94197..260187b6b6 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -112,7 +112,9 @@ fork_exec(struct socket *so, const char *ex, int do_pty)
 		    bind(s, (struct sockaddr *)&addr, addrlen) < 0 ||
 		    listen(s, 1) < 0) {
 			error_report("Error: inet socket: %s", strerror(errno));
-			closesocket(s);
+			if (s >= 0) {
+			    closesocket(s);
+			}
 
 			return 0;
 		}
-- 
2.11.0
