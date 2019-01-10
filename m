Received: from eggs.gnu.org ([209.51.188.92]:33126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghZVv-0006Tw-DA
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:32:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghZVu-0007an-C5
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:32:47 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 10 Jan 2019 13:32:39 +0100
Message-Id: <1547123559-30476-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] pc-bios/s390-ccw: Use proper register names
 for Clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

When compiling the s390-ccw firmware with Clang 7.0.1, I get the
following errors:

pc-bios/s390-ccw/start.S:62:19: error: invalid use of length addressing
        stctg 0,0,0(15)
                  ^
pc-bios/s390-ccw/start.S:63:12: error: invalid use of length addressing
        oi 6(15), 0x2
           ^
pc-bios/s390-ccw/start.S:64:19: error: invalid use of length addressing
        lctlg 0,0,0(15)
                  ^
pc-bios/s390-ccw/start.S:76:19: error: invalid use of length addressing
        stctg 0,0,0(15)
                  ^
pc-bios/s390-ccw/start.S:77:12: error: invalid use of length addressing
        ni 6(15), 0xfd
           ^
pc-bios/s390-ccw/start.S:78:19: error: invalid use of length addressing
        lctlg 0,0,0(15)
                  ^
pc-bios/s390-ccw/start.S:79:12: error: invalid operand for instruction
        br 14
           ^

Let's use proper register names like in the rest of this file to fix it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/start.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index eb8d024..3b7fa3f 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -59,9 +59,9 @@ disabled_wait:
         .globl consume_sclp_int
 consume_sclp_int:
         /* enable service interrupts in cr0 */
-        stctg 0,0,0(15)
-        oi 6(15), 0x2
-        lctlg 0,0,0(15)
+        stctg   %c0,%c0,0(%r15)
+        oi      6(%r15),0x2
+        lctlg   %c0,%c0,0(%r15)
         /* prepare external call handler */
         larl %r1, external_new_code
         stg %r1, 0x1b8
@@ -73,10 +73,10 @@ consume_sclp_int:
 
 external_new_code:
         /* disable service interrupts in cr0 */
-        stctg 0,0,0(15)
-        ni 6(15), 0xfd
-        lctlg 0,0,0(15)
-        br 14
+        stctg   %c0,%c0,0(%r15)
+        ni      6(%r15),0xfd
+        lctlg   %c0,%c0,0(%r15)
+        br      %r14
 
         .align  8
 disabled_wait_psw:
-- 
1.8.3.1
