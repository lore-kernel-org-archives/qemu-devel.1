Received: from eggs.gnu.org ([2001:4830:134:3::10]:52973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85ZL-00085M-Ui
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85ZJ-0004yN-IO
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:39 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  4 Oct 2018 17:28:44 +0200
Message-Id: <20181004152857.14525-3-cohuck@redhat.com>
In-Reply-To: <20181004152857.14525-1-cohuck@redhat.com>
References: <20181004152857.14525-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 02/15] hw/s390x/css: Remove QEMU_PACKED from
 struct SenseId
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The uint16_t member cu_type of struct SenseId is not naturally aligned,
and since the struct is marked with QEMU_PACKED, this can lead to
unaligned memory accesses - which does not work on architectures like
Sparc. Thus remove the QEMU_PACKED here and rather copy the struct
byte by byte when we do copy_sense_id_to_guest().

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1538036615-32542-3-git-send-email-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c         | 38 ++++++++++++++++++++++----------------
 include/hw/s390x/css.h |  2 +-
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 5a9fe45ce8..04ec5cc970 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -750,20 +750,25 @@ static void sch_handle_halt_func(SubchDev *sch)
 
 }
 
-static void copy_sense_id_to_guest(SenseId *dest, SenseId *src)
+/*
+ * As the SenseId struct cannot be packed (would cause unaligned accesses), we
+ * have to copy the individual fields to an unstructured area using the correct
+ * layout (see SA22-7204-01 "Common I/O-Device Commands").
+ */
+static void copy_sense_id_to_guest(uint8_t *dest, SenseId *src)
 {
     int i;
 
-    dest->reserved = src->reserved;
-    dest->cu_type = cpu_to_be16(src->cu_type);
-    dest->cu_model = src->cu_model;
-    dest->dev_type = cpu_to_be16(src->dev_type);
-    dest->dev_model = src->dev_model;
-    dest->unused = src->unused;
-    for (i = 0; i < ARRAY_SIZE(dest->ciw); i++) {
-        dest->ciw[i].type = src->ciw[i].type;
-        dest->ciw[i].command = src->ciw[i].command;
-        dest->ciw[i].count = cpu_to_be16(src->ciw[i].count);
+    dest[0] = src->reserved;
+    stw_be_p(dest + 1, src->cu_type);
+    dest[3] = src->cu_model;
+    stw_be_p(dest + 4, src->dev_type);
+    dest[6] = src->dev_model;
+    dest[7] = src->unused;
+    for (i = 0; i < ARRAY_SIZE(src->ciw); i++) {
+        dest[8 + i * 4] = src->ciw[i].type;
+        dest[9 + i * 4] = src->ciw[i].command;
+        stw_be_p(dest + 10 + i * 4, src->ciw[i].count);
     }
 }
 
@@ -1044,9 +1049,10 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
         break;
     case CCW_CMD_SENSE_ID:
     {
-        SenseId sense_id;
+        /* According to SA22-7204-01, Sense-ID can store up to 256 bytes */
+        uint8_t sense_id[256];
 
-        copy_sense_id_to_guest(&sense_id, &sch->id);
+        copy_sense_id_to_guest(sense_id, &sch->id);
         /* Sense ID information is device specific. */
         if (check_len) {
             if (ccw.count != sizeof(sense_id)) {
@@ -1060,11 +1066,11 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
          * have enough place to store at least bytes 0-3.
          */
         if (len >= 4) {
-            sense_id.reserved = 0xff;
+            sense_id[0] = 0xff;
         } else {
-            sense_id.reserved = 0;
+            sense_id[0] = 0;
         }
-        ccw_dstream_write_buf(&sch->cds, &sense_id, len);
+        ccw_dstream_write_buf(&sch->cds, sense_id, len);
         sch->curr_status.scsw.count = ccw_dstream_residual_count(&sch->cds);
         ret = 0;
         break;
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 9da5912921..bec82d0e5b 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -48,7 +48,7 @@ typedef struct SenseId {
     uint8_t unused;          /* padding byte */
     /* extended part */
     CIW ciw[MAX_CIWS];       /* variable # of CIWs */
-} QEMU_PACKED SenseId;
+} SenseId;                   /* Note: No QEMU_PACKED due to unaligned members */
 
 /* Channel measurements, from linux/drivers/s390/cio/cmf.c. */
 typedef struct CMB {
-- 
2.14.4
