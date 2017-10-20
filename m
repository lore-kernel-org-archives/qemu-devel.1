Received: from eggs.gnu.org ([2001:4830:134:3::10]:59538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuX-0003cQ-KX
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuV-00040M-B3
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:21 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:54:09 +0200
Message-Id: <20171020115418.2050-38-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 37/46] s390x/css: IO instr handler ending control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

CSS code needs to tell the IO instruction handlers located in ioinst.c
how the emulated instruction should be ended. Currently this is done by
returning generic (POSIX) error codes, and mapping them to outcomes like
condition codes. This makes bugs easy to create and hard to recognize.

As a preparation for moving away from (mis)using generic error codes for
flow control let us introduce a type which tells the instruction
handler function how to end the instruction, in a more straight-forward
and less ambiguous way.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Message-Id: <20171017140453.51099-3-pasic@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
[CH: cosmetic changes]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 include/hw/s390x/css.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 69b374730e..08ad1a14cf 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -99,6 +99,22 @@ typedef struct CcwDataStream {
     hwaddr cda;
 } CcwDataStream;
 
+/*
+ * IO instructions conclude according to this. Currently we have only
+ * cc codes. Valid values are 0, 1, 2, 3 and the generic semantic for
+ * IO instructions is described briefly. For more details consult the PoP.
+ */
+typedef enum IOInstEnding {
+    /* produced expected result */
+    IOINST_CC_EXPECTED = 0,
+    /* status conditions were present or produced alternate result */
+    IOINST_CC_STATUS_PRESENT = 1,
+    /* inst. ineffective because busy with previously initiated function */
+    IOINST_CC_BUSY = 2,
+    /* inst. ineffective because not operational */
+    IOINST_CC_NOT_OPERATIONAL = 3
+} IOInstEnding;
+
 typedef struct SubchDev SubchDev;
 struct SubchDev {
     /* channel-subsystem related things: */
-- 
2.13.6
