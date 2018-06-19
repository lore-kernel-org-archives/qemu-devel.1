Received: from eggs.gnu.org ([2001:4830:134:3::10]:46651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5j3-0002e3-6A
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iz-0000Ms-2n
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:29 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:28 -0500
Message-Id: <20180619014319.28272-63-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 062/113] s390: Do not pass inofficial IPL type
 to the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

IPL over a virtio-scsi device requires special handling not
available in the real architecture. For this purpose the IPL
type 0xFF has been chosen as means of communication between
QEMU and the pc-bios. However, a guest OS could be confused
by seeing an unknown IPL type.

This change sets the IPL parameter type to 0x02 (CCW) to prevent
this. Pre-existing Linux has looked up the IPL parameters only in
the case of FCP IPL. This means that the behavior should stay
the same even if Linux checks for the IPL type unconditionally.

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Message-Id: <1522940844-12336-4-git-send-email-mihajlov@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit e8c7ef288abb05b741a95418ee2de85c1071e0db)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c |  7 +++++++
 pc-bios/s390-ccw/iplb.h    | 15 +++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 67a6123ed4..bc01bbccbe 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -50,6 +50,13 @@ static void jump_to_IPL_code(uint64_t address)
 {
     /* store the subsystem information _after_ the bootmap was loaded */
     write_subsystem_identification();
+
+    /* prevent unknown IPL types in the guest */
+    if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
+        iplb.pbt = S390_IPL_TYPE_CCW;
+        set_iplb(&iplb);
+    }
+
     /*
      * The IPL PSW is at address 0. We also must not overwrite the
      * content of non-BIOS memory after we loaded the guest, so we
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 890aed9ece..40fc2d8e21 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -77,16 +77,27 @@ extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 #define S390_IPL_TYPE_CCW 0x02
 #define S390_IPL_TYPE_QEMU_SCSI 0xff
 
-static inline bool store_iplb(IplParameterBlock *iplb)
+static inline bool manage_iplb(IplParameterBlock *iplb, bool store)
 {
     register unsigned long addr asm("0") = (unsigned long) iplb;
     register unsigned long rc asm("1") = 0;
 
     asm volatile ("diag %0,%2,0x308\n"
                   : "+d" (addr), "+d" (rc)
-                  : "d" (6)
+                  : "d" (store ? 6 : 5)
                   : "memory", "cc");
     return rc == 0x01;
 }
 
+
+static inline bool store_iplb(IplParameterBlock *iplb)
+{
+    return manage_iplb(iplb, true);
+}
+
+static inline bool set_iplb(IplParameterBlock *iplb)
+{
+    return manage_iplb(iplb, false);
+}
+
 #endif /* IPLB_H */
-- 
2.11.0
