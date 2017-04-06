Received: from eggs.gnu.org ([2001:4830:134:3::10]:43259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw5PR-0004J5-In
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw5PO-0001b5-E7
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:17:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cw5PO-0001an-4S
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:16:58 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v36BDtMb038824
	for <qemu-devel@nongnu.org>; Thu, 6 Apr 2017 07:16:56 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29nm639v8s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 07:16:56 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 6 Apr 2017 12:16:53 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu,  6 Apr 2017 13:16:38 +0200
In-Reply-To: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
References: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
Message-Id: <20170406111646.12624-3-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.10 02/10] s390x/kvm: make printf always
 compile in debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Danil Antonov <g.danil.anto@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Danil Antonov <g.danil.anto@gmail.com>

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
Message-Id: <CA+KKJYAhsuTodm3s2rK65hR=-Xi5+Z7Q+M2nJYZQf2wa44HfOg@mail.gmail.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target/s390x/kvm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index ac47154b83..1a249d8359 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -47,16 +47,16 @@
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
+#ifndef DEBUG_KVM
+#define DEBUG_KVM  0
 #endif
 
+#define DPRINTF(fmt, ...) do {                \
+    if (DEBUG_KVM) {                          \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);
+
 #define kvm_vm_check_mem_attr(s, attr) \
     kvm_vm_check_attr(s, KVM_S390_VM_MEM_CTRL, attr)
 
-- 
2.11.0
