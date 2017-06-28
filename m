Received: from eggs.gnu.org ([2001:4830:134:3::10]:40896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEi-0005Rl-K3
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEh-00008W-EN
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIEh-00008E-63
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:47 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:41 +0100
Message-Id: <20170628190047.26159-24-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 23/29] vub+postcopy: madvises
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Clear the area and turn off THP.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 0658b6e847..ceddeac74f 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -451,11 +451,39 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
         }
 
         if (dev->postcopy_listening) {
+            int ret;
             /* We should already have an open ufd need to mark each memory
              * range as ufd.
-             * Note: Do we need any madvises? Well it's not been accessed
-             * yet, still probably need no THP to be safe, discard to be safe?
              */
+
+            /* Discard any mapping we have here; note I can't use MADV_REMOVE
+             * or fallocate to make the hole since I don't want to lose
+             * data that's already arrived in the shared process.
+             * TODO: How to do hugepage
+             */
+            ret = madvise((void *)dev_region->mmap_addr,
+                          dev_region->size + dev_region->mmap_offset,
+                          MADV_DONTNEED);
+            if (ret) {
+                fprintf(stderr,
+                        "%s: Failed to madvise(DONTNEED) region %d: %s\n",
+                        __func__, i, strerror(errno));
+            }
+            /* Turn off transparent hugepages so we dont get lose wakeups
+             * in neighbouring pages.
+             * TODO: Turn this backon later.
+             */
+            ret = madvise((void *)dev_region->mmap_addr,
+                          dev_region->size + dev_region->mmap_offset,
+                          MADV_NOHUGEPAGE);
+            if (ret) {
+                /* Note: This can happen legally on kernels that are configured
+                 * without madvise'able hugepages
+                 */
+                fprintf(stderr,
+                        "%s: Failed to madvise(NOHUGEPAGE) region %d: %s\n",
+                        __func__, i, strerror(errno));
+            }
             struct uffdio_register reg_struct;
             /* Note: We might need to go back to using mmap_addr and
              * len + mmap_offset for * huge pages, but then we do hope not to
-- 
2.13.0
