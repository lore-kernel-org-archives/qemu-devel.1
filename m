Received: from eggs.gnu.org ([2001:4830:134:3::10]:37610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkQFD-0003QY-Ev
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkQFA-0006fS-KM
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:43:03 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fkQFA-0006eC-7Z
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:43:00 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 31 Jul 2018 10:42:03 +0200
Message-Id: <20180731084203.29959-4-laurent@vivier.eu>
In-Reply-To: <20180731084203.29959-1-laurent@vivier.eu>
References: <20180731084203.29959-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 3/3] linux-user: ppc64: don't use volatile
 register during safe_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>

From: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>

r11 is a volatile register on PPC as per calling conventions.
The safe_syscall code uses it to check if the signal_pending
is set during the safe_syscall. When a syscall is interrupted
on return from signal handling, the r11 might be corrupted
before we retry the syscall leading to a crash. The registers
r0-r13 are not to be used here as they have
volatile/designated/reserved usages.

Change the code to use r14 which is non-volatile.
Use SP+16 which is a slot for LR, for save/restore of previous value
of r14. SP+16 can be used, as LR is preserved across the syscall.

Steps to reproduce:
On PPC host, issue `qemu-x86_64 /usr/bin/cc -E -`
Attempt Ctrl-C, the issue is reproduced.

Reference:
https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html#REG
https://openpowerfoundation.org/wp-content/uploads/2016/03/ABI64BitOpenPOWERv1.1_16July2015_pub4.pdf

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <153301568965.30312.10498134581068746871.stgit@dhcp-9-109-246-16>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/host/ppc64/safe-syscall.inc.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/linux-user/host/ppc64/safe-syscall.inc.S b/linux-user/host/ppc64/safe-syscall.inc.S
index d30050a67c..8ed73a5b86 100644
--- a/linux-user/host/ppc64/safe-syscall.inc.S
+++ b/linux-user/host/ppc64/safe-syscall.inc.S
@@ -49,7 +49,9 @@ safe_syscall_base:
 	 *               and returns the result in r3
 	 * Shuffle everything around appropriately.
 	 */
-	mr	11, 3	/* signal_pending */
+	std     14, 16(1) /* Preserve r14 in SP+16 */
+	.cfi_offset 14, 16
+	mr	14, 3	/* signal_pending */
 	mr	0, 4	/* syscall number */
 	mr	3, 5	/* syscall arguments */
 	mr	4, 6
@@ -67,12 +69,13 @@ safe_syscall_base:
 	 */
 safe_syscall_start:
 	/* if signal_pending is non-zero, don't do the call */
-	lwz	12, 0(11)
+	lwz	12, 0(14)
 	cmpwi	0, 12, 0
 	bne-	0f
 	sc
 safe_syscall_end:
 	/* code path when we did execute the syscall */
+	ld 14, 16(1) /* restore r14 to its original value */
 	bnslr+
 
 	/* syscall failed; return negative errno */
@@ -81,6 +84,7 @@ safe_syscall_end:
 
 	/* code path when we didn't execute the syscall */
 0:	addi	3, 0, -TARGET_ERESTARTSYS
+	ld 14, 16(1) /* restore r14 to its orginal value */
 	blr
 	.cfi_endproc
 
-- 
2.17.1
