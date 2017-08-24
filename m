Received: from eggs.gnu.org ([2001:4830:134:3::10]:52387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxo5-0002ZD-8y
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxo4-0004vw-BE
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57329)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxo4-0004uz-5o
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:44 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:13 +0100
Message-Id: <20170824192730.8440-16-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 15/32] vhost+postcopy: Register new regions
 with the ufd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When new regions are sent to the client using SET_MEM_TABLE, register
them with the userfaultfd.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index e8accf11db..e6ab059a03 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -449,6 +449,38 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
                    dev_region->mmap_addr);
         }
 
+        if (dev->postcopy_listening) {
+            /* We should already have an open ufd need to mark each memory
+             * range as ufd.
+             * Note: Do we need any madvises? Well it's not been accessed
+             * yet, still probably need no THP to be safe, discard to be safe?
+             */
+            struct uffdio_register reg_struct;
+            reg_struct.range.start = (uintptr_t)dev_region->mmap_addr;
+            reg_struct.range.len = dev_region->size + dev_region->mmap_offset;
+            reg_struct.mode = UFFDIO_REGISTER_MODE_MISSING;
+
+            if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
+                vu_panic(dev, "%s: Failed to userfault region %d "
+                              "@%p + %zx: (ufd=%d)%s\n",
+                         __func__, i,
+                         dev_region->mmap_addr,
+                         dev_region->size + dev_region->mmap_offset,
+                         dev->postcopy_ufd, strerror(errno));
+                continue;
+            }
+            if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
+                vu_panic(dev, "%s Region (%d) doesn't support COPY",
+                         __func__, i);
+                continue;
+            }
+            DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
+                    __func__, i, reg_struct.range.start, reg_struct.range.len);
+            /* TODO: Stash 'zero' support flags somewhere */
+            /* TODO: Get address back to QEMU */
+
+        }
+
         close(vmsg->fds[i]);
     }
 
-- 
2.13.5
