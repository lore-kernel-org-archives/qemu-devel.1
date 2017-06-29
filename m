Received: from eggs.gnu.org ([2001:4830:134:3::10]:52070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQd6f-0003n8-Ft
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQd6e-0000As-Ig
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:19:53 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 29 Jun 2017 10:16:35 -0700
Message-ID: <a14083d681951f3999a0e9314605cb706381ae8d.1498756113.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1498756113.git.alistair.francis@xilinx.com>
References: <cover.1498756113.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 3/3] util/oslib-win32: Remove if conditional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, qemu-block@nongnu.org, philippe@mathieu-daude.net, pbonzini@redhat.com

The original ready < nhandles - 1 can be re-written as ready + 1 <
nhandles which is the same confition that we are checking on the first
itteration of the for loop. This means we can remove the if statement
and let the for loop check the code.

This also has the side effect of removing an invalid check as
WAIT_OBJECT_0 was not subtracted from ready.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 util/oslib-win32.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 7ec0f8e083..d42d695050 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -438,10 +438,8 @@ static int poll_rest(gboolean poll_msgs, HANDLE *handles, gint nhandles,
         if (timeout == 0 && nhandles > 1) {
             /* Remove the handle that fired */
             int i;
-            if (ready < nhandles - 1) {
-                for (i = ready - WAIT_OBJECT_0 + 1; i < nhandles; i++) {
-                    handles[i-1] = handles[i];
-                }
+            for (i = ready - WAIT_OBJECT_0 + 1; i < nhandles; i++) {
+                handles[i-1] = handles[i];
             }
             nhandles--;
             recursed_result = poll_rest(FALSE, handles, nhandles, fds, nfds, 0);
-- 
2.11.0
