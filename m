Received: from eggs.gnu.org ([2001:4830:134:3::10]:41862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNY-0007BA-GJ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNT-0001oz-O9
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:04:56 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Jun 2018 14:04:28 +0200
Message-Id: <20180619120434.25062-7-cohuck@redhat.com>
In-Reply-To: <20180619120434.25062-1-cohuck@redhat.com>
References: <20180619120434.25062-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 06/12] pc-bios/s390-ccw: define loadparm length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>

From: Collin Walling <walling@linux.ibm.com>

Loadparm is defined by the s390 architecture to be 8 bytes
in length. Let's define this size in the s390-ccw bios.

Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/iplb.h | 4 +++-
 pc-bios/s390-ccw/main.c | 8 ++++----
 pc-bios/s390-ccw/sclp.c | 2 +-
 pc-bios/s390-ccw/sclp.h | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index ded20c834e..772d5c57c9 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -12,6 +12,8 @@
 #ifndef IPLB_H
 #define IPLB_H
 
+#define LOADPARM_LEN    8
+
 struct IplBlockCcw {
     uint8_t  reserved0[85];
     uint8_t  ssid;
@@ -61,7 +63,7 @@ struct IplParameterBlock {
     uint8_t  pbt;
     uint8_t  flags;
     uint16_t reserved01;
-    uint8_t  loadparm[8];
+    uint8_t  loadparm[LOADPARM_LEN];
     union {
         IplBlockCcw ccw;
         IplBlockFcp fcp;
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 26f9adf84a..544851d672 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -15,7 +15,7 @@
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid = { .one = 1 };
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
-static char loadparm_str[9] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
+static char loadparm_str[LOADPARM_LEN + 1] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 QemuIplParameters qipl;
 
 #define LOADPARM_PROMPT "PROMPT  "
@@ -80,13 +80,13 @@ static bool find_dev(Schib *schib, int dev_no)
 
 static void menu_setup(void)
 {
-    if (memcmp(loadparm_str, LOADPARM_PROMPT, 8) == 0) {
+    if (memcmp(loadparm_str, LOADPARM_PROMPT, LOADPARM_LEN) == 0) {
         menu_set_parms(QIPL_FLAG_BM_OPTS_CMD, 0);
         return;
     }
 
     /* If loadparm was set to any other value, then do not enable menu */
-    if (memcmp(loadparm_str, LOADPARM_EMPTY, 8) != 0) {
+    if (memcmp(loadparm_str, LOADPARM_EMPTY, LOADPARM_LEN) != 0) {
         return;
     }
 
@@ -117,7 +117,7 @@ static void virtio_setup(void)
     enable_mss_facility();
 
     sclp_get_loadparm_ascii(loadparm_str);
-    memcpy(ldp + 10, loadparm_str, 8);
+    memcpy(ldp + 10, loadparm_str, LOADPARM_LEN);
     sclp_print(ldp);
 
     memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
index 3836cb4716..c0223fab0b 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -114,7 +114,7 @@ void sclp_get_loadparm_ascii(char *loadparm)
     memset((char *)_sccb, 0, sizeof(ReadInfo));
     sccb->h.length = sizeof(ReadInfo);
     if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
-        ebcdic_to_ascii((char *) sccb->loadparm, loadparm, 8);
+        ebcdic_to_ascii((char *) sccb->loadparm, loadparm, LOADPARM_LEN);
     }
 }
 
diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
index 0dd987ff5d..8450161ba7 100644
--- a/pc-bios/s390-ccw/sclp.h
+++ b/pc-bios/s390-ccw/sclp.h
@@ -56,7 +56,7 @@ typedef struct ReadInfo {
     uint16_t rnmax;
     uint8_t rnsize;
     uint8_t reserved[13];
-    uint8_t loadparm[8];
+    uint8_t loadparm[LOADPARM_LEN];
 } __attribute__((packed)) ReadInfo;
 
 typedef struct SCCB {
-- 
2.14.4
