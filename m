Received: from eggs.gnu.org ([2001:4830:134:3::10]:41636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1drm76-0007CU-Bf
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1drm71-0002fl-GK
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:24:32 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:58956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <JBeulich@suse.com>) id 1drm71-0002ex-A5
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:24:27 -0400
Message-Id: <59B80A35020000780017A344@prv-mh.provo.novell.com>
Date: Tue, 12 Sep 2017 08:24:21 -0600
From: "Jan Beulich" <JBeulich@suse.com>
References: <59B80A35020000780017A344@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] xen_disk: avoid use of g_malloc0_n()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>

Prefer g_new() / g_new0() to be farther backwards compatible with older
glib versions. As there's no point in zeroing the allocation here (the
loop right afterwards fully initializes the memory), use the former.

Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -1232,7 +1232,7 @@ static int blk_connect(struct XenDevice
         return -1;
     }
=20
-    domids =3D g_malloc0_n(blkdev->nr_ring_ref, sizeof(uint32_t));
+    domids =3D g_new(uint32_t, blkdev->nr_ring_ref);
     for (i =3D 0; i < blkdev->nr_ring_ref; i++) {
         domids[i] =3D blkdev->xendev.dom;
     }
