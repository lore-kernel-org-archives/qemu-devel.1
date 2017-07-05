Received: from eggs.gnu.org ([2001:4830:134:3::10]:46546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWk-0004as-3u
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWj-0007ep-3f
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:10 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWi-0007ds-Rl
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:08 -0400
Received: by mail-wm0-x241.google.com with SMTP id u23so30502950wma.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:08 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:18 +0200
Message-Id: <1499238885-26161-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/42] util/oslib-win32: Remove if conditional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>

From: Alistair Francis <alistair.francis@xilinx.com>

The original ready < nhandles - 1 can be re-written as ready + 1 <
nhandles.  The check was actually incorrect because
WAIT_OBJECT_0 was not subtracted from ready; it worked because
WAIT_OBJECT_0 is zero.  After subtracting WAIT_OBJECT_0,
the result is the same condition that we are checking on the first
itteration of the for loop. This means we can remove the if statement
and let the for loop check the code.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Message-Id: <a14083d681951f3999a0e9314605cb706381ae8d.1498756113.git.alistair.francis@xilinx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/oslib-win32.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 80e4668..3de9e77 100644
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
1.8.3.1
