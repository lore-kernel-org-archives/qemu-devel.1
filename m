Received: from eggs.gnu.org ([2001:4830:134:3::10]:47694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCH-00010u-5x
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCD-0005Em-RT
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52700
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCD-0005E4-JT
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EBkT081939
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:57 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmurncras-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:56 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:15:56 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:01 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-27-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 26/79] target/xtensa: fix mapping direction in
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

Read and write simcalls map physical memory to access I/O buffers, but
'read' simcall need to map it for writing and 'write' simcall need to
map it for reading, i.e. the opposite of what they do now. Fix that.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
(cherry picked from commit 30c2afd151cbc38c012f7b441088980807183da6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.7.4
