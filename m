Received: from eggs.gnu.org ([2001:4830:134:3::10]:47357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eu1gR-0003HG-VU
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eu1gR-0006By-0F
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eu1gQ-0006Bm-RN
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47F508182D24
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 19:58:34 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  8 Mar 2018 19:57:56 +0000
Message-Id: <20180308195811.24894-15-dgilbert@redhat.com>
In-Reply-To: <20180308195811.24894-1-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 14/29] libvhost-user+postcopy: Register new
 regions with the ufd
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

When new regions are sent to the client using SET_MEM_TABLE, register
them with the userfaultfd.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 4922b2c722..a18bc74a7c 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -494,6 +494,40 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
         close(vmsg->fds[i]);
     }
 
+    /* TODO: Get address back to QEMU */
+    for (i = 0; i < dev->nregions; i++) {
+        VuDevRegion *dev_region = &dev->regions[i];
+#ifdef UFFDIO_REGISTER
+        /* We should already have an open ufd. Mark each memory
+         * range as ufd.
+         * Note: Do we need any madvises? Well it's not been accessed
+         * yet, still probably need no THP to be safe, discard to be safe?
+         */
+        struct uffdio_register reg_struct;
+        reg_struct.range.start = (uintptr_t)dev_region->mmap_addr;
+        reg_struct.range.len = dev_region->size + dev_region->mmap_offset;
+        reg_struct.mode = UFFDIO_REGISTER_MODE_MISSING;
+
+        if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
+            vu_panic(dev, "%s: Failed to userfault region %d "
+                          "@%p + size:%zx offset: %zx: (ufd=%d)%s\n",
+                     __func__, i,
+                     dev_region->mmap_addr,
+                     dev_region->size, dev_region->mmap_offset,
+                     dev->postcopy_ufd, strerror(errno));
+            return false;
+        }
+        if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
+            vu_panic(dev, "%s Region (%d) doesn't support COPY",
+                     __func__, i);
+            return false;
+        }
+        DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
+                __func__, i, reg_struct.range.start, reg_struct.range.len);
+        /* TODO: Stash 'zero' support flags somewhere */
+#endif
+    }
+
     return false;
 }
 
-- 
2.14.3
