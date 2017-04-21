Received: from eggs.gnu.org ([2001:4830:134:3::10]:40751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBe-000170-Kt
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBb-0000gA-Cf
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:41:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47907
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d1TBb-0000fs-0U
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:59 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3L7cr4g128255
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:40:58 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29xwu7f086-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:40:58 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 21 Apr 2017 08:40:56 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 21 Apr 2017 09:40:36 +0200
In-Reply-To: <20170421074038.774-1-cornelia.huck@de.ibm.com>
References: <20170421074038.774-1-cornelia.huck@de.ibm.com>
Message-Id: <20170421074038.774-10-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 09/11] s390x/flic: cache flic in s390_get_flic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Fei Li <sherrylf@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

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
