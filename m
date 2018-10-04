Received: from eggs.gnu.org ([2001:4830:134:3::10]:52825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85ZC-0007wO-9p
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85Z8-0004om-FT
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:28 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  4 Oct 2018 17:28:45 +0200
Message-Id: <20181004152857.14525-4-cohuck@redhat.com>
In-Reply-To: <20181004152857.14525-1-cohuck@redhat.com>
References: <20181004152857.14525-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 03/15] hw/s390x/ioinst: Fix alignment problem in
 struct SubchDev
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

struct SubchDev embeds several other structures which are marked with
QEMU_PACKED. This causes the compiler to not care for proper alignment
of these structures. When we later pass around pointers to the unaligned
struct members during migration, this causes problems on host architectures
like Sparc that can not do unaligned memory access.

Most of the structs in ioinst.h are naturally aligned, so we can fix
most of the problem by removing the QEMU_PACKED statements (and use
QEMU_BUILD_BUG_MSG() statements instead to make sure that there is no
padding). However, for the struct SCHIB, we have to keep the QEMU_PACKED
since the compiler adds some padding here otherwise. Move this struct
to the beginning of struct SubchDev instead to fix the alignment problem
here, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1538036615-32542-4-git-send-email-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 include/hw/s390x/css.h    |  4 ++--
 include/hw/s390x/ioinst.h | 21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index bec82d0e5b..aae19c4272 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -118,11 +118,12 @@ typedef enum IOInstEnding {
 typedef struct SubchDev SubchDev;
 struct SubchDev {
     /* channel-subsystem related things: */
+    SCHIB curr_status;           /* Needs alignment and thus must come first */
+    ORB orb;
     uint8_t cssid;
     uint8_t ssid;
     uint16_t schid;
     uint16_t devno;
-    SCHIB curr_status;
     uint8_t sense_data[32];
     hwaddr channel_prog;
     CCW1 last_cmd;
@@ -131,7 +132,6 @@ struct SubchDev {
     bool thinint_active;
     uint8_t ccw_no_data_cnt;
     uint16_t migrated_schid; /* used for missmatch detection */
-    ORB orb;
     CcwDataStream cds;
     /* transport-provided data: */
     int (*ccw_cb) (SubchDev *, CCW1);
diff --git a/include/hw/s390x/ioinst.h b/include/hw/s390x/ioinst.h
index 5f2db6949d..c6737a30d4 100644
--- a/include/hw/s390x/ioinst.h
+++ b/include/hw/s390x/ioinst.h
@@ -25,7 +25,8 @@ typedef struct SCSW {
     uint8_t dstat;
     uint8_t cstat;
     uint16_t count;
-} QEMU_PACKED SCSW;
+} SCSW;
+QEMU_BUILD_BUG_MSG(sizeof(SCSW) != 12, "size of SCSW is wrong");
 
 #define SCSW_FLAGS_MASK_KEY 0xf000
 #define SCSW_FLAGS_MASK_SCTL 0x0800
@@ -94,7 +95,8 @@ typedef struct PMCW {
     uint8_t  pam;
     uint8_t  chpid[8];
     uint32_t chars;
-} QEMU_PACKED PMCW;
+} PMCW;
+QEMU_BUILD_BUG_MSG(sizeof(PMCW) != 28, "size of PMCW is wrong");
 
 #define PMCW_FLAGS_MASK_QF 0x8000
 #define PMCW_FLAGS_MASK_W 0x4000
@@ -127,7 +129,8 @@ typedef struct IRB {
     uint32_t esw[5];
     uint32_t ecw[8];
     uint32_t emw[8];
-} QEMU_PACKED IRB;
+} IRB;
+QEMU_BUILD_BUG_MSG(sizeof(IRB) != 96, "size of IRB is wrong");
 
 /* operation request block */
 typedef struct ORB {
@@ -136,7 +139,8 @@ typedef struct ORB {
     uint8_t lpm;
     uint8_t ctrl1;
     uint32_t cpa;
-} QEMU_PACKED ORB;
+} ORB;
+QEMU_BUILD_BUG_MSG(sizeof(ORB) != 12, "size of ORB is wrong");
 
 #define ORB_CTRL0_MASK_KEY 0xf000
 #define ORB_CTRL0_MASK_SPND 0x0800
@@ -165,7 +169,8 @@ typedef struct CCW0 {
         uint8_t flags;
         uint8_t reserved;
         uint16_t count;
-} QEMU_PACKED CCW0;
+} CCW0;
+QEMU_BUILD_BUG_MSG(sizeof(CCW0) != 8, "size of CCW0 is wrong");
 
 /* channel command word (type 1) */
 typedef struct CCW1 {
@@ -173,7 +178,8 @@ typedef struct CCW1 {
     uint8_t flags;
     uint16_t count;
     uint32_t cda;
-} QEMU_PACKED CCW1;
+} CCW1;
+QEMU_BUILD_BUG_MSG(sizeof(CCW1) != 8, "size of CCW1 is wrong");
 
 #define CCW_FLAG_DC              0x80
 #define CCW_FLAG_CC              0x40
@@ -192,7 +198,8 @@ typedef struct CCW1 {
 typedef struct CRW {
     uint16_t flags;
     uint16_t rsid;
-} QEMU_PACKED CRW;
+} CRW;
+QEMU_BUILD_BUG_MSG(sizeof(CRW) != 4, "size of CRW is wrong");
 
 #define CRW_FLAGS_MASK_S 0x4000
 #define CRW_FLAGS_MASK_R 0x2000
-- 
2.14.4
