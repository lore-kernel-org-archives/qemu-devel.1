Received: from eggs.gnu.org ([2001:4830:134:3::10]:51311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robinhe@robinhe-hp.sh.intel.com>) id 1ewT4f-0005ZY-Pl
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robinhe@robinhe-hp.sh.intel.com>) id 1ewT4b-0004nQ-Nl
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:37:41 -0400
Received: from [112.64.68.174] (port=39097 helo=robinhe-hp.sh.intel.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robinhe@robinhe-hp.sh.intel.com>)
	id 1ewT4b-0004lN-64
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:37:37 -0400
From: junyan.he@intel.com
Date: Tue, 13 Mar 2018 16:33:51 +0800
Message-Id: <1520930033-18885-9-git-send-email-junyan.he@intel.com>
In-Reply-To: <1520930033-18885-1-git-send-email-junyan.he@intel.com>
References: <1520930033-18885-1-git-send-email-junyan.he@intel.com>
Subject: [Qemu-devel] [PATCH 08/10] RFC: Add a section_id parameter to
 save_live_iterate call.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, quintela@redhat.com, rth@twiddle.net, dgilbert@redhat.com, famz@redhat.com, Junyan He <junyan.he@intel.com>

From: Junyan He <junyan.he@intel.com>

We need to know the section_id when we do snapshot saving.
Add a parameter to save_live_iterate function call.

Signed-off-by: Junyan He <junyan.he@intel.com>
---
 hw/ppc/spapr.c               | 2 +-
 hw/s390x/s390-stattrib.c     | 2 +-
 include/migration/register.h | 2 +-
 migration/block.c            | 2 +-
 migration/ram.c              | 2 +-
 migration/savevm.c           | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7e1c858..4cde4f4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1974,7 +1974,7 @@ static int htab_save_later_pass(QEMUFile *f, sPAPRMachineState *spapr,
 #define MAX_ITERATION_NS    5000000 /* 5 ms */
 #define MAX_KVM_BUF_SIZE    2048
 
-static int htab_save_iterate(QEMUFile *f, void *opaque)
+static int htab_save_iterate(QEMUFile *f, void *opaque, int section_id)
 {
     sPAPRMachineState *spapr = opaque;
     int fd;
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index adf07ef..18ece84 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -246,7 +246,7 @@ static int cmma_save(QEMUFile *f, void *opaque, int final)
     return ret;
 }
 
-static int cmma_save_iterate(QEMUFile *f, void *opaque)
+static int cmma_save_iterate(QEMUFile *f, void *opaque, int section_id)
 {
     return cmma_save(f, opaque, 0);
 }
diff --git a/include/migration/register.h b/include/migration/register.h
index f4f7bdc..7f7df2c 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -31,7 +31,7 @@ typedef struct SaveVMHandlers {
      * use data that is local to the migration thread or protected
      * by other locks.
      */
-    int (*save_live_iterate)(QEMUFile *f, void *opaque);
+    int (*save_live_iterate)(QEMUFile *f, void *opaque, int section_id);
 
     /* This runs outside the iothread lock!  */
     int (*save_setup)(QEMUFile *f, void *opaque);
diff --git a/migration/block.c b/migration/block.c
index 1f03946..6d4c8a3 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -755,7 +755,7 @@ static int block_save_setup(QEMUFile *f, void *opaque)
     return ret;
 }
 
-static int block_save_iterate(QEMUFile *f, void *opaque)
+static int block_save_iterate(QEMUFile *f, void *opaque, int section_id)
 {
     int ret;
     int64_t last_ftell = qemu_ftell(f);
diff --git a/migration/ram.c b/migration/ram.c
index 3b6c077..d1db422 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2249,7 +2249,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
  * @f: QEMUFile where to send the data
  * @opaque: RAMState pointer
  */
-static int ram_save_iterate(QEMUFile *f, void *opaque)
+static int ram_save_iterate(QEMUFile *f, void *opaque, int section_id)
 {
     RAMState **temp = opaque;
     RAMState *rs = *temp;
diff --git a/migration/savevm.c b/migration/savevm.c
index 3a9b904..ce4133a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1072,7 +1072,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
 
         save_section_header(f, se, QEMU_VM_SECTION_PART);
 
-        ret = se->ops->save_live_iterate(f, se->opaque);
+        ret = se->ops->save_live_iterate(f, se->opaque, se->section_id);
         trace_savevm_section_end(se->idstr, se->section_id, ret);
         save_section_footer(f, se);
 
-- 
2.7.4
