Received: from eggs.gnu.org ([2001:4830:134:3::10]:41962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew52H-0003Zl-8X
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew52G-0004sp-8K
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ew52G-0004se-3A
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:57:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 954078182D16
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 11:57:35 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Mar 2018 11:56:12 +0000
Message-Id: <20180314115618.28831-24-dgilbert@redhat.com>
In-Reply-To: <20180314115618.28831-1-dgilbert@redhat.com>
References: <20180314115618.28831-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 23/29] libvhost-user: mprotect & madvises
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
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 47 +++++++++++++++++++++++++++++=
++----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 6314549b65..5feed52098 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -454,7 +454,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserM=
sg *vmsg)
     int i;
     VhostUserMemory *memory =3D &vmsg->payload.memory;
     dev->nregions =3D memory->nregions;
-    /* TODO: Postcopy specific code */
+
     DPRINT("Nregions: %d\n", memory->nregions);
     for (i =3D 0; i < dev->nregions; i++) {
         void *mmap_addr;
@@ -478,9 +478,12 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUser=
Msg *vmsg)
=20
         /* We don't use offset argument of mmap() since the
          * mapped address has to be page aligned, and we use huge
-         * pages.  */
+         * pages.
+         * In postcopy we're using PROT_NONE here to catch anyone
+         * accessing it before we userfault
+         */
         mmap_addr =3D mmap(0, dev_region->size + dev_region->mmap_offset=
,
-                         PROT_READ | PROT_WRITE, MAP_SHARED,
+                         PROT_NONE, MAP_SHARED,
                          vmsg->fds[i], 0);
=20
         if (mmap_addr =3D=3D MAP_FAILED) {
@@ -519,12 +522,38 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUse=
rMsg *vmsg)
     /* OK, now we can go and register the memory and generate faults */
     for (i =3D 0; i < dev->nregions; i++) {
         VuDevRegion *dev_region =3D &dev->regions[i];
+        int ret;
 #ifdef UFFDIO_REGISTER
         /* We should already have an open ufd. Mark each memory
          * range as ufd.
-         * Note: Do we need any madvises? Well it's not been accessed
-         * yet, still probably need no THP to be safe, discard to be saf=
e?
+         * Discard any mapping we have here; note I can't use MADV_REMOV=
E
+         * or fallocate to make the hole since I don't want to lose
+         * data that's already arrived in the shared process.
+         * TODO: How to do hugepage
          */
+        ret =3D madvise((void *)dev_region->mmap_addr,
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
+        ret =3D madvise((void *)dev_region->mmap_addr,
+                      dev_region->size + dev_region->mmap_offset,
+                      MADV_NOHUGEPAGE);
+        if (ret) {
+            /* Note: This can happen legally on kernels that are configu=
red
+             * without madvise'able hugepages
+             */
+            fprintf(stderr,
+                    "%s: Failed to madvise(NOHUGEPAGE) region %d: %s\n",
+                    __func__, i, strerror(errno));
+        }
         struct uffdio_register reg_struct;
         reg_struct.range.start =3D (uintptr_t)dev_region->mmap_addr;
         reg_struct.range.len =3D dev_region->size + dev_region->mmap_off=
set;
@@ -546,6 +575,14 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUser=
Msg *vmsg)
         }
         DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
                 __func__, i, reg_struct.range.start, reg_struct.range.le=
n);
+        /* Now it's registered we can let the client at it */
+        if (mprotect((void *)dev_region->mmap_addr,
+                     dev_region->size + dev_region->mmap_offset,
+                     PROT_READ | PROT_WRITE)) {
+            vu_panic(dev, "failed to mprotect region %d for postcopy (%s=
)",
+                     i, strerror(errno));
+            return false;
+        }
         /* TODO: Stash 'zero' support flags somewhere */
 #endif
     }
--=20
2.14.3
