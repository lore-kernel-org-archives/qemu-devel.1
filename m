Received: from eggs.gnu.org ([2001:4830:134:3::10]:50120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5yg-0007Ff-3J
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5yc-0006GG-Vl
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54920
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dn5yc-0006Fp-Px
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:26 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7UGTBMS138568
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:24 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cnx0xp95j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:24 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 30 Aug 2017 17:36:22 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 18:36:01 +0200
In-Reply-To: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170830163609.50260-2-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/9] s390x/css: fix cc handling for XSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

The function ioinst_handle_xsch is presenting cc 2 when it's supposed to
present cc 1 and the other way around, because css_do_xsch has the error
codes mixed up. Fixing the error codes also fixes the priority.

Let us fix this.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reported-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
---
 hw/s390x/css.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 1880b1a0ff..a50fb0727e 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1281,12 +1281,12 @@ int css_do_xsch(SubchDev *sch)
         (!(s->ctrl &
            (SCSW_ACTL_RESUME_PEND | SCSW_ACTL_START_PEND | SCSW_ACTL_SUSP))) ||
         (s->ctrl & SCSW_ACTL_SUBCH_ACTIVE)) {
-        ret = -EINPROGRESS;
+        ret = -EBUSY;
         goto out;
     }
 
     if (s->ctrl & SCSW_CTRL_MASK_STCTL) {
-        ret = -EBUSY;
+        ret = -EINPROGRESS;
         goto out;
     }
 
-- 
2.13.5
