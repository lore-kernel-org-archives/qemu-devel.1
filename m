Received: from eggs.gnu.org ([209.51.188.92]:52268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7b-0004wj-Qn
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7a-0001Hg-IE
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:39 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Jan 2019 13:19:16 +0100
Message-Id: <20190118121925.24468-3-cohuck@redhat.com>
In-Reply-To: <20190118121925.24468-1-cohuck@redhat.com>
References: <20190118121925.24468-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 02/11] pc-bios/s390-ccw: Use proper register
 names for Clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

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
Message-Id: <1547123559-30476-1-git-send-email-thuth@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw/start.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index eb8d024dbb..5c22cb0849 100644
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
2.17.2
