Received: from eggs.gnu.org ([2001:4830:134:3::10]:53090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR92-0008HW-L1
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR8y-0007eD-Mn
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:21:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56692 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evR8y-0007dn-IH
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:21:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37AAF4040856
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 17:21:52 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 12 Mar 2018 17:21:09 +0000
Message-Id: <20180312172124.56461-15-dgilbert@redhat.com>
In-Reply-To: <20180312172124.56461-1-dgilbert@redhat.com>
References: <20180312172124.56461-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 14/29] libvhost-user+postcopy: Register new
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
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 34 +++++++++++++++++++++++++++++=
+++++
 1 file changed, 34 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index b2de8ed0a8..7c8cd5878e 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -494,6 +494,40 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUser=
Msg *vmsg)
         close(vmsg->fds[i]);
     }
=20
+    /* TODO: Get address back to QEMU */
+    for (i =3D 0; i < dev->nregions; i++) {
+        VuDevRegion *dev_region =3D &dev->regions[i];
+#ifdef UFFDIO_REGISTER
+        /* We should already have an open ufd. Mark each memory
+         * range as ufd.
+         * Note: Do we need any madvises? Well it's not been accessed
+         * yet, still probably need no THP to be safe, discard to be saf=
e?
+         */
+        struct uffdio_register reg_struct;
+        reg_struct.range.start =3D (uintptr_t)dev_region->mmap_addr;
+        reg_struct.range.len =3D dev_region->size + dev_region->mmap_off=
set;
+        reg_struct.mode =3D UFFDIO_REGISTER_MODE_MISSING;
+
+        if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
+            vu_panic(dev, "%s: Failed to userfault region %d "
+                          "@%p + size:%zx offset: %zx: (ufd=3D%d)%s\n",
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
+                __func__, i, reg_struct.range.start, reg_struct.range.le=
n);
+        /* TODO: Stash 'zero' support flags somewhere */
+#endif
+    }
+
     return false;
 }
=20
--=20
2.14.3
