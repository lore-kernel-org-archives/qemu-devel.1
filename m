Received: from eggs.gnu.org ([2001:4830:134:3::10]:43354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw5Pa-0004Z0-Qu
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw5PX-0001eZ-Mc
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:17:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cw5PX-0001eB-DJ
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:17:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v36BET24105676
	for <qemu-devel@nongnu.org>; Thu, 6 Apr 2017 07:17:06 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29nkk5455j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 07:17:05 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 6 Apr 2017 12:17:03 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu,  6 Apr 2017 13:16:45 +0200
In-Reply-To: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
References: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
Message-Id: <20170406111646.12624-10-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.10 09/10] s390x/flic: cache flic in
 s390_get_flic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Fei Li <sherrylf@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Fei Li <sherrylf@linux.vnet.ibm.com>

s390_get_flic() is called many times to obtain the flic. This wastes a
lot of time as it calls object_resolve_path() every time. Let's cache
S390FLICState by defining it as static.

Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/intc/s390_flic.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index bef4caf980..711c11454f 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -21,11 +21,14 @@
 
 S390FLICState *s390_get_flic(void)
 {
-    S390FLICState *fs;
+    static S390FLICState *fs;
 
-    fs = S390_FLIC_COMMON(object_resolve_path(TYPE_KVM_S390_FLIC, NULL));
     if (!fs) {
-        fs = S390_FLIC_COMMON(object_resolve_path(TYPE_QEMU_S390_FLIC, NULL));
+        fs = S390_FLIC_COMMON(object_resolve_path(TYPE_KVM_S390_FLIC, NULL));
+        if (!fs) {
+            fs = S390_FLIC_COMMON(object_resolve_path(TYPE_QEMU_S390_FLIC,
+                                                      NULL));
+        }
     }
     return fs;
 }
-- 
2.11.0
