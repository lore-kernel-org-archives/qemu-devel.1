Received: from eggs.gnu.org ([2001:4830:134:3::10]:53938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbhat@linux.vnet.ibm.com>) id 1fia57-0006uv-Hv
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 02:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbhat@linux.vnet.ibm.com>) id 1fia54-0007Th-JX
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 02:49:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbhat@linux.vnet.ibm.com>)
	id 1fia54-0007TX-9R
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 02:48:58 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6Q6mpoP015104
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 02:48:56 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kf5w7f5qu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 02:48:55 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbhat@linux.vnet.ibm.com>;
	Thu, 26 Jul 2018 07:48:53 +0100
From: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Date: Thu, 26 Jul 2018 12:18:47 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <153258768962.6738.11319866502689416568.stgit@dhcp-9-109-246-16>
Subject: [Qemu-devel] [PATCH] linux-user: ppc64: don't use volatile register
 during safe_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgibson@redhat.com, riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu
Cc: sbhat@linux.vnet.ibm.com, qemu-devel@nongnu.org

r11 is a volatile register on PPC as per calling conventions.
The safe_syscall code uses it to check if the signal_pending
is set during the safe_syscall. When a syscall is interrupted
on return from signal handling, the r11 might be corrupted
before we retry the syscall leading to a crash. The registers
r0-r13 are not to be used here as they have
volatile/designated/reserved usages. Change the code to use
r14 which is non-volatile and is appropriate for local use in
safe_syscall.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
---
Steps to reproduce:
On PPC host, issue `qemu-ppc64le /usr/bin/cc -E -`
Attempt Ctrl-C, the issue is reproduced.

Reference:
https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html#REG

 linux-user/host/ppc64/safe-syscall.inc.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/host/ppc64/safe-syscall.inc.S b/linux-user/host/ppc64/safe-syscall.inc.S
index d30050a67c..b0cbbe6a69 100644
--- a/linux-user/host/ppc64/safe-syscall.inc.S
+++ b/linux-user/host/ppc64/safe-syscall.inc.S
@@ -49,7 +49,7 @@ safe_syscall_base:
 	 *               and returns the result in r3
 	 * Shuffle everything around appropriately.
 	 */
-	mr	11, 3	/* signal_pending */
+	mr	14, 3	/* signal_pending */
 	mr	0, 4	/* syscall number */
 	mr	3, 5	/* syscall arguments */
 	mr	4, 6
@@ -67,7 +67,7 @@ safe_syscall_base:
 	 */
 safe_syscall_start:
 	/* if signal_pending is non-zero, don't do the call */
-	lwz	12, 0(11)
+	lwz	12, 0(14)
 	cmpwi	0, 12, 0
 	bne-	0f
 	sc
