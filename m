Received: from eggs.gnu.org ([2001:4830:134:3::10]:40918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dnOQi-0006wv-4L
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dnOQe-00023E-1A
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:18:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35724
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dnOQd-000237-S1
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:18:35 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7VCA2nP011375
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 08:18:35 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cpe3mx4gp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 08:18:35 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 31 Aug 2017 13:18:33 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 31 Aug 2017 14:18:28 +0200
Message-Id: <20170831121828.85885-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] s390x/css: fix cc handling for XSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

The function ioinst_handle_xsch is presenting cc 2 when it's supposed to
present cc 1 and the other way around, because css_do_xsch has the error
codes mixed up. Because cc 1 has precedence over cc 2 we also have to
swap the two checks.

Let us fix this.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reported-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---

Was previously a part of a series (due to an accident the
series had no name). This version also fixes the priority
(aka precedence) problem.

---
 hw/s390x/css.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 1880b1a0ff..e04e0ea3a8 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1276,16 +1276,16 @@ int css_do_xsch(SubchDev *sch)
         goto out;
     }
 
+    if (s->ctrl & SCSW_CTRL_MASK_STCTL) {
+        ret = -EINPROGRESS;
+        goto out;
+    }
+
     if (!(s->ctrl & SCSW_CTRL_MASK_FCTL) ||
         ((s->ctrl & SCSW_CTRL_MASK_FCTL) != SCSW_FCTL_START_FUNC) ||
         (!(s->ctrl &
            (SCSW_ACTL_RESUME_PEND | SCSW_ACTL_START_PEND | SCSW_ACTL_SUSP))) ||
         (s->ctrl & SCSW_ACTL_SUBCH_ACTIVE)) {
-        ret = -EINPROGRESS;
-        goto out;
-    }
-
-    if (s->ctrl & SCSW_CTRL_MASK_STCTL) {
         ret = -EBUSY;
         goto out;
     }
-- 
2.13.5
