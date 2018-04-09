Received: from eggs.gnu.org ([2001:4830:134:3::10]:47564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5YWJ-00063e-ST
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5YWI-0005PV-Ru
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:15:47 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  9 Apr 2018 17:15:29 +0200
Message-Id: <20180409151533.2253-5-cohuck@redhat.com>
In-Reply-To: <20180409151533.2253-1-cohuck@redhat.com>
References: <20180409151533.2253-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.12 4/8] s390: Do not pass inofficial IPL
 type to the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

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
---
 pc-bios/s390-ccw/bootmap.c |  7 +++++++
 pc-bios/s390-ccw/iplb.h    | 15 +++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index fc2a9fe33b..9287b7a70f 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -70,6 +70,13 @@ static void jump_to_IPL_code(uint64_t address)
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
index 7dfce4fbcf..5357a36d51 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -97,16 +97,27 @@ extern QemuIplParameters qipl;
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
2.14.3
