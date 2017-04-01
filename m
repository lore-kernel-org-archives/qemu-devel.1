Received: from eggs.gnu.org ([2001:4830:134:3::10]:50078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJLn-0008HC-Q5
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJLm-000872-QM
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:45:55 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJLm-00086s-L9
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:45:54 -0400
Received: by mail-oi0-x242.google.com with SMTP id b187so13189560oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:45:54 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:45:53 +0300
Message-ID: <CA+KKJYAhsuTodm3s2rK65hR=-Xi5+Z7Q+M2nJYZQf2wa44HfOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 10/43] s390x: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, agraf@suse.de, rth@twiddle.net

>From ea9cd8f02bd98548435f561e62f4f9b672318bcb Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:26:05 +0300
Subject: [PATCH 10/43] s390x: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 target/s390x/kvm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index ac47154..ac994fe 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -47,15 +47,15 @@
 #include "exec/memattrs.h"
 #include "hw/s390x/s390-virtio-ccw.h"

-/* #define DEBUG_KVM */
-
-#ifdef DEBUG_KVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_KVM
+#define DEBUG_KVM  0
+#endif
+
+#define DPRINTF(fmt, ...) do {                \
+    if (DEBUG_KVM) {                          \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);

 #define kvm_vm_check_mem_attr(s, attr) \
     kvm_vm_check_attr(s, KVM_S390_VM_MEM_CTRL, attr)
-- 
2.8.0.rc3
