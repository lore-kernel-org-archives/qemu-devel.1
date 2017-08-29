Received: from eggs.gnu.org ([2001:4830:134:3::10]:47727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCI-00012i-Dq
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCF-0005Fl-54
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60942
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCE-0005FJ-UY
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:59 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EAdl044225
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:58 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmu3kpe19-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:58 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:15:57 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:02 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-28-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 27/79] target/xtensa: fix return value of
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
Cc: qemu-stable@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>

From: Max Filippov <jcmvbkbc@gmail.com>

Return value of read/write simcalls is not calculated correctly in case
of operations crossing page boundary and in case of short reads/writes.
Read and write simcalls should return the size of data actually
read/written or -1 in case of error.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
(cherry picked from commit 347ec03093f9668a379ef6b7fa1feb332fff039c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.7.4
