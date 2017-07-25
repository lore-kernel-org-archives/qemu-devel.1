Received: from eggs.gnu.org ([2001:4830:134:3::10]:34504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1da8ZU-0002Yi-TF
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 18:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1da8ZR-0003Ut-Qp
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 18:44:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58078
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1da8ZR-0003Tp-Lp
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 18:44:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6PMiLJU091550
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 18:44:52 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bxcaaycx0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 18:44:52 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 25 Jul 2017 23:44:50 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 00:44:41 +0200
In-Reply-To: <20170725224442.13383-1-pasic@linux.vnet.ibm.com>
References: <20170725224442.13383-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170725224442.13383-2-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/2] s390x/css: check ccw address validity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

According to the PoP channel command words (CCW) must be doubleword
aligned and 31 bit addressable for format 1 and 24 bit addressable for
format 0 CCWs.

If the channel subsystem encounters ccw address which does not satisfy
this alignment requirement a program-check condition is recognised.

The situation with 31 bit addressable is a bit more complicated: both the
ORB and a format 1 CCW TIC hold the address of the (rest of) the channel
program, that is the address of the next CCW in a word, and the PoP
mandates that bit 0 of that word shall be zero -- or a program-check
condition is to be recognized -- and does not belong to the field holding
the ccw address.

Since in code the corresponding fields span across the whole word (unlike
in PoP where these are defined as 31 bit wide) we can check this by
applying a mask. The 24 addressable case isn't affecting TIC because the
address is composed of a halfword and a byte portion (no additional zero
bit requirements) and just slightly complicates the ORB case where also
bits 1-7 need to be zero.

Let's make our CSS implementation follow the AR more closely.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
Note: Checking for 31 bit addressable ain't strictly necessary:
According to the AR the all zero fields of the ORB may or may not be
checked during the execution of SSCH. We do check the corresponding
single bit field of the ORB and respond to it accordingly. Using
the same mask for TIC and for ORB does not hurt.
---
 hw/s390x/css.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 6a42b95cee..d17e21b7af 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -24,6 +24,9 @@
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 
+/* CCWs are doubleword aligned and addressable by 31 bit */
+#define CCW1_ADDR_MASK 0x80000007
+
 typedef struct CrwContainer {
     CRW crw;
     QTAILQ_ENTRY(CrwContainer) sibling;
@@ -885,6 +888,10 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
             ret = -EINVAL;
             break;
         }
+        if (ccw.cda & CCW1_ADDR_MASK) {
+            ret = -EINVAL;
+            break;
+        }
         sch->channel_prog = ccw.cda;
         ret = -EAGAIN;
         break;
@@ -946,6 +953,17 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
         suspend_allowed = true;
     }
     sch->last_cmd_valid = false;
+    if (sch->channel_prog & (CCW1_ADDR_MASK |
+                             sch->ccw_fmt_1 ? 0 : 0xff000000)) {
+            /* generate channel program check */
+            s->ctrl &= ~SCSW_ACTL_START_PEND;
+            s->cstat = SCSW_CSTAT_PROG_CHECK;
+            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
+            s->ctrl |= SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+                    SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
+            s->cpa = sch->channel_prog + 8;
+            return;
+    }
     do {
         ret = css_interpret_ccw(sch, sch->channel_prog, suspend_allowed);
         switch (ret) {
-- 
2.11.2
