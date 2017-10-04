Received: from eggs.gnu.org ([2001:4830:134:3::10]:55456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dzk3h-00067n-Se
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dzk3e-0003mg-0e
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:49:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1dzk3d-0003kw-CQ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:49:53 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94Dn3bk059635
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 09:49:47 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dcufa2y2r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 09:49:47 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 14:49:45 +0100
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed,  4 Oct 2017 15:49:36 +0200
In-Reply-To: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
Message-Id: <1507124979-8880-3-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 2/5] s390x/css: Use AIS AIRQ injection only
 if adapter support AIS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

Testing to use Adapter Interrupt suppression or not depend on AIS
being enabled in the kernel.
To implement AIS emulation we must move this test inside the FLIC
dedicated irq_inject function.

Furthermore, a test to verify that the adapter is subject to the AIS
must be added.

Last, there is no need to crash QEMU if the injection failed, the
guest may recover from it.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 hw/s390x/css.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 901dc6a..6e74a5c 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -672,10 +672,12 @@ void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc)
     }
 
     trace_css_adapter_interrupt(isc);
-    if (fs->ais_supported) {
+    /* Use standard IRQ injection for adapters not supporting AIS */
+    if (adapter->flags & S390_ADAPTER_SUPPRESSIBLE) {
+        /* Use AIRQ injection for adapters subject to AIS */
         if (fsc->inject_airq(fs, type, isc, adapter->flags)) {
             error_report("Failed to inject airq with AIS supported");
-            exit(1);
+            /* Report error - guest will handle not receiving interrupts */
         }
     } else {
         s390_io_interrupt(0, 0, 0, io_int_word);
-- 
2.3.0
