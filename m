Received: from eggs.gnu.org ([2001:4830:134:3::10]:43647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1d9K6m-0006LN-S6
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1d9K6k-0007rm-6q
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:36:28 -0400
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 12 May 2017 16:36:03 -0700
Message-Id: <1494632164-23799-3-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1494632164-23799-1-git-send-email-jcmvbkbc@gmail.com>
References: <1494632164-23799-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 2/3] target/xtensa: fix return value of
 read/write simcalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-stable@nongnu.org

Return value of read/write simcalls is not calculated correctly in case
of operations crossing page boundary and in case of short reads/writes.
Read and write simcalls should return the size of data actually
read/written or -1 in case of error.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/xtensa-semi.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 98ae28c..ffcaf8d 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -166,6 +166,7 @@ void HELPER(simcall)(CPUXtensaState *env)
             uint32_t fd = regs[3];
             uint32_t vaddr = regs[4];
             uint32_t len = regs[5];
+            uint32_t len_done = 0;
 
             while (len > 0) {
                 hwaddr paddr = cpu_get_phys_page_debug(cs, vaddr);
@@ -174,24 +175,38 @@ void HELPER(simcall)(CPUXtensaState *env)
                 uint32_t io_sz = page_left < len ? page_left : len;
                 hwaddr sz = io_sz;
                 void *buf = cpu_physical_memory_map(paddr, &sz, !is_write);
+                uint32_t io_done;
+                bool error = false;
 
                 if (buf) {
                     vaddr += io_sz;
                     len -= io_sz;
-                    regs[2] = is_write ?
+                    io_done = is_write ?
                         write(fd, buf, io_sz) :
                         read(fd, buf, io_sz);
                     regs[3] = errno_h2g(errno);
-                    cpu_physical_memory_unmap(buf, sz, !is_write, sz);
-                    if (regs[2] == -1) {
-                        break;
+                    if (io_done == -1) {
+                        error = true;
+                        io_done = 0;
                     }
+                    cpu_physical_memory_unmap(buf, sz, !is_write, io_done);
                 } else {
-                    regs[2] = -1;
+                    error = true;
                     regs[3] = TARGET_EINVAL;
                     break;
                 }
+                if (error) {
+                    if (!len_done) {
+                        len_done = -1;
+                    }
+                    break;
+                }
+                len_done += io_done;
+                if (io_done < io_sz) {
+                    break;
+                }
             }
+            regs[2] = len_done;
         }
         break;
 
-- 
2.1.4
