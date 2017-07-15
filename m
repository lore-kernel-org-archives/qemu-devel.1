Received: from eggs.gnu.org ([2001:4830:134:3::10]:35834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWMDv-00059J-13
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 08:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWMDu-000643-1A
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 08:31:03 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:52260)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWMDt-00063p-QO
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 08:31:01 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 15 Jul 2017 14:30:55 +0200
Message-Id: <20170715123057.8529-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170715123057.8529-1-samuel.thibault@ens-lyon.org>
References: <20170715123057.8529-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 2/4] slirp: fork_exec(): Don't close() a
 negative number in fork_exec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Peter Maydell <peter.maydell@linaro.org>

In a fork_exec() error path we try to closesocket(s) when s might
be a negative number because the thing that failed was the
qemu_socket() call. Add a guard so we don't do this.

(Spotted by Coverity: CID 1005727 issue 1 of 2.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
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
2.13.2
