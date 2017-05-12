Received: from eggs.gnu.org ([2001:4830:134:3::10]:43646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1d9K6m-0006LM-S8
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1d9K6i-0007qf-Cv
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:36:28 -0400
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 12 May 2017 16:36:02 -0700
Message-Id: <1494632164-23799-2-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1494632164-23799-1-git-send-email-jcmvbkbc@gmail.com>
References: <1494632164-23799-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 1/3] target/xtensa: fix mapping direction in
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

Read and write simcalls map physical memory to access I/O buffers, but
'read' simcall need to map it for writing and 'write' simcall need to
map it for reading, i.e. the opposite of what they do now. Fix that.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/xtensa-semi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index a888a9d..98ae28c 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -173,7 +173,7 @@ void HELPER(simcall)(CPUXtensaState *env)
                     TARGET_PAGE_SIZE - (vaddr & (TARGET_PAGE_SIZE - 1));
                 uint32_t io_sz = page_left < len ? page_left : len;
                 hwaddr sz = io_sz;
-                void *buf = cpu_physical_memory_map(paddr, &sz, is_write);
+                void *buf = cpu_physical_memory_map(paddr, &sz, !is_write);
 
                 if (buf) {
                     vaddr += io_sz;
@@ -182,7 +182,7 @@ void HELPER(simcall)(CPUXtensaState *env)
                         write(fd, buf, io_sz) :
                         read(fd, buf, io_sz);
                     regs[3] = errno_h2g(errno);
-                    cpu_physical_memory_unmap(buf, sz, is_write, sz);
+                    cpu_physical_memory_unmap(buf, sz, !is_write, sz);
                     if (regs[2] == -1) {
                         break;
                     }
-- 
2.1.4
