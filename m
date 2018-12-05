Received: from eggs.gnu.org ([2001:4830:134:3::10]:41605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gUfiA-00013B-Ut
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gUfi6-0003nL-2M
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:32:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gUfi5-0003mq-Pd
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:32:01 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed,  5 Dec 2018 22:31:23 +0000
Message-Id: <1544049083-16087-4-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1544049083-16087-1-git-send-email-liam.merwick@oracle.com>
References: <1544049083-16087-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [RFC qboot 3/3] pvh: add benchmark exit point
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com, maran.wilson@oracle.com, liam.merwick@oracle.com

This commit adds a PVH specific VM exit point for use in benchmarking
boot times using a QEMU specific device that terminates the QEMU process
and thus the VM itself when handling those VM exits. Since the VM
terminates right at those exit points, generic tools like time can
be used to measure the time spent between the QEMU startup
and termination moments.

The QEMU device used for those measurement is called isa-debug-exit
for the PC and Q35 machine types. These devices take 2 arguments:
iobase and iosize.  iobase specifies which IO port we need to write
into to have these devices eventually handle the corresponding VM exit.

If for example, QEMU is started with the following argument:

-device isa-debug-exit,iobase=0xf4

then any IO write to 0xf4 will terminate the QEMU process and the
corresponding VM.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 benchmark.h | 3 ++-
 fw_cfg.c    | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/benchmark.h b/benchmark.h
index 089c549b5803..2be08e7b2cec 100644
--- a/benchmark.h
+++ b/benchmark.h
@@ -9,5 +9,6 @@
 #define FW_START    1
 #define LINUX_START_FWCFG 2
 #define LINUX_START_BOOT  3
+#define LINUX_START_PVHBOOT  4
 
-#endif
+#endif /* BENCHMARK_H */
diff --git a/fw_cfg.c b/fw_cfg.c
index e13ec20d0e8b..690ff19e74a0 100644
--- a/fw_cfg.c
+++ b/fw_cfg.c
@@ -240,10 +240,17 @@ void boot_pvh_from_fw_cfg(void)
 	if (!sz)
 		panic();
 
+
 	fw_cfg_select(FW_CFG_KERNEL_ENTRY);
 	kernel_entry = (void *) fw_cfg_readl_le();
 	asm volatile("movl %0, %%ebx" : : "r"(&start_info));
 
+#ifdef BENCHMARK_HACK
+	/* Exit just before jumping to vmlinux, so that it is easy
+	 * to time/profile the firmware.
+	 */
+	outb(LINUX_EXIT_PORT, LINUX_START_PVHBOOT);
+#endif
 	asm volatile("jmp *%2" : : "a" (0x2badb002),
 		     "b"(&start_info), "c"(kernel_entry));
 	panic();
-- 
1.8.3.1
