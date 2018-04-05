Received: from eggs.gnu.org ([2001:4830:134:3::10]:56423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1f46UF-0001Re-AM
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1f46UB-0007yp-Vq
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:07:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@de.ibm.com>) id 1f46UB-0007yH-MW
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:07:35 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w35F3ctc088535
	for <qemu-devel@nongnu.org>; Thu, 5 Apr 2018 11:07:34 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h5jjrbfkw-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 11:07:34 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@de.ibm.com>;
	Thu, 5 Apr 2018 16:07:31 +0100
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu,  5 Apr 2018 17:07:24 +0200
In-Reply-To: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Message-Id: <1522940844-12336-4-git-send-email-mihajlov@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/3] s390: Do not pass inofficial IPL type to
 the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org

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
---
 pc-bios/s390-ccw/bootmap.c |  7 +++++++
 pc-bios/s390-ccw/iplb.h    | 15 +++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index fc2a9fe..9287b7a 100644
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
index 7dfce4f..5357a36 100644
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
1.9.1
