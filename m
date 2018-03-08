Received: from eggs.gnu.org ([2001:4830:134:3::10]:47562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eu1gf-0003Wu-Av
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eu1ge-0006NQ-63
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40198 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eu1ge-0006Mj-0w
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 783214040073
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 19:58:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  8 Mar 2018 19:58:05 +0000
Message-Id: <20180308195811.24894-24-dgilbert@redhat.com>
In-Reply-To: <20180308195811.24894-1-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 23/29] libvhost-user: mprotect & madvises
 for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Clear the area and turn off THP.
PROT_NONE the area until after we've userfault advised it
to catch any unexpected changes.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 46 +++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index e02e5d6f46..1b224af706 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -454,7 +454,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
     int i;
     VhostUserMemory *memory = &vmsg->payload.memory;
     dev->nregions = memory->nregions;
-    /* TODO: Postcopy specific code */
+
     DPRINT("Nregions: %d\n", memory->nregions);
     for (i = 0; i < dev->nregions; i++) {
         void *mmap_addr;
@@ -478,9 +478,12 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
 
         /* We don't use offset argument of mmap() since the
          * mapped address has to be page aligned, and we use huge
-         * pages.  */
+         * pages.
+         * In postcopy we're using PROT_NONE here to catch anyone
+         * accessing it before we userfault
+         */
         mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
-                         PROT_READ | PROT_WRITE, MAP_SHARED,
+                         PROT_NONE, MAP_SHARED,
                          vmsg->fds[i], 0);
 
         if (mmap_addr == MAP_FAILED) {
@@ -519,12 +522,38 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
     /* OK, now we can go and register the memory and generate faults */
     for (i = 0; i < dev->nregions; i++) {
         VuDevRegion *dev_region = &dev->regions[i];
+        int ret;
 #ifdef UFFDIO_REGISTER
         /* We should already have an open ufd. Mark each memory
          * range as ufd.
-         * Note: Do we need any madvises? Well it's not been accessed
-         * yet, still probably need no THP to be safe, discard to be safe?
+         * Discard any mapping we have here; note I can't use MADV_REMOVE
+         * or fallocate to make the hole since I don't want to lose
+         * data that's already arrived in the shared process.
+         * TODO: How to do hugepage
          */
+        ret = madvise((void *)dev_region->mmap_addr,
+                      dev_region->size + dev_region->mmap_offset,
+                      MADV_DONTNEED);
+        if (ret) {
+            fprintf(stderr,
+                    "%s: Failed to madvise(DONTNEED) region %d: %s\n",
+                    __func__, i, strerror(errno));
+        }
+        /* Turn off transparent hugepages so we dont get lose wakeups
+         * in neighbouring pages.
+         * TODO: Turn this backon later.
+         */
+        ret = madvise((void *)dev_region->mmap_addr,
+                      dev_region->size + dev_region->mmap_offset,
+                      MADV_NOHUGEPAGE);
+        if (ret) {
+            /* Note: This can happen legally on kernels that are configured
+             * without madvise'able hugepages
+             */
+            fprintf(stderr,
+                    "%s: Failed to madvise(NOHUGEPAGE) region %d: %s\n",
+                    __func__, i, strerror(errno));
+        }
         struct uffdio_register reg_struct;
         reg_struct.range.start = (uintptr_t)dev_region->mmap_addr;
         reg_struct.range.len = dev_region->size + dev_region->mmap_offset;
@@ -546,6 +575,13 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
         }
         DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
                 __func__, i, reg_struct.range.start, reg_struct.range.len);
+        /* Now it's registered we can let the client at it */
+        if (mprotect((void *)dev_region->mmap_addr,
+                     dev_region->size + dev_region->mmap_offset,
+                     PROT_READ | PROT_WRITE)) {
+            vu_panic(dev, "failed to mprotect region %d for postcopy", i);
+            return false;
+        }
         /* TODO: Stash 'zero' support flags somewhere */
 #endif
     }
-- 
2.14.3
