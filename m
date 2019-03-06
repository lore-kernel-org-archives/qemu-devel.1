Received: from eggs.gnu.org ([209.51.188.92]:51073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1Msn-0005L0-EL
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 22:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1Msm-0003t1-I1
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 22:06:13 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  6 Mar 2019 14:06:01 +1100
Message-Id: <20190306030601.21986-4-david@gibson.dropbear.id.au>
In-Reply-To: <20190306030601.21986-1-david@gibson.dropbear.id.au>
References: <20190306030601.21986-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] virtio-balloon: Restore MADV_WILLNEED hint
 on balloon deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tsirkin <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Prior to f6deb6d9 "virtio-balloon: Remove unnecessary MADV_WILLNEED on
deflate", the balloon device issued an madvise() MADV_WILLNEED on
pages removed from the balloon.  That would hint to the host kernel
that the pages were likely to be needed by the guest in the near
future.

It's unclear if this is actually valuable or not, and so f6deb6d9
removed this, essentially ignoring balloon deflate requests.  However,
concerns have been raised that this might cause a performance
regression by causing extra latency for the guest in certain
configurations.

So, until we can get actual benchmark data to see if that's the case,
this restores the old behaviour, issuing a MADV_WILLNEED when a page is
removed from the balloon.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/virtio/virtio-balloon.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 7412bf8c85..ac36988605 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -118,6 +118,8 @@ static void balloon_deflate_page(VirtIOBalloon *ballo=
on,
     RAMBlock *rb;
     size_t rb_page_size;
     ram_addr_t ram_offset, host_page_base;
+    void *host_addr;
+    int ret;
=20
     /* XXX is there a better way to get to the RAMBlock than via a
      * host address? */
@@ -146,6 +148,17 @@ static void balloon_deflate_page(VirtIOBalloon *ball=
oon,
             balloon->pbp =3D NULL;
         }
     }
+
+    host_addr =3D (void *)((uintptr_t)addr & ~(rb_page_size - 1));
+
+    /* When a page is deflated, we hint the whole host page it lives
+     * on, since we can't do anything smaller */
+    ret =3D qemu_madvise(host_addr, rb_page_size, QEMU_MADV_WILLNEED);
+    if (ret !=3D 0) {
+        warn_report("Couldn't MADV_WILLNEED on balloon deflate: %s",
+                    strerror(errno));
+        /* Otherwise ignore, failing to page hint shouldn't be fatal */
+    }
 }
=20
 static const char *balloon_stat_names[] =3D {
--=20
2.20.1
