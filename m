Received: from eggs.gnu.org ([209.51.188.92]:54512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h12Mh-0001Ch-Kj
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h12Mg-0005pe-S1
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:11:43 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  5 Mar 2019 16:11:34 +1100
Message-Id: <20190305051134.27930-3-david@gibson.dropbear.id.au>
In-Reply-To: <20190305051134.27930-1-david@gibson.dropbear.id.au>
References: <20190305051134.27930-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 2/2] virtio-balloon: Restore MADV_WILLNEED hint
 on balloon deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, david@redhat.com
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
this restores (by default) the old behaviour, issuing a MADV_WILLNEED
when a page is removed from the balloon.  A new property on the
balloon device "hint-on-deflate" can be set to false to remove this
behaviour for testing.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/virtio/virtio-balloon.c         | 15 +++++++++++++++
 include/hw/virtio/virtio-balloon.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index e5e82b556d..69968502d9 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -146,6 +146,20 @@ static void balloon_deflate_page(VirtIOBalloon *ball=
oon,
             balloon->pbp =3D NULL;
         }
     }
+
+    if (balloon->hint_on_deflate) {
+        void *host_addr =3D (void *)((uintptr_t)addr & ~(rb_page_size - =
1));
+        int ret;
+
+        /* When a page is deflated, we hint the whole host page it
+         * lives on, since we can't do anything smaller */
+        ret =3D qemu_madvise(host_addr, rb_page_size, QEMU_MADV_WILLNEED=
);
+        if (ret !=3D 0) {
+            warn_report("Couldn't MADV_WILLNEED on balloon deflate: %s",
+                        strerror(errno));
+            /* Otherwise ignore, failing to page hint shouldn't be fatal=
 */
+        }
+    }
 }
=20
 static const char *balloon_stat_names[] =3D {
@@ -622,6 +636,7 @@ static const VMStateDescription vmstate_virtio_balloo=
n =3D {
 static Property virtio_balloon_properties[] =3D {
     DEFINE_PROP_BIT("deflate-on-oom", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
+    DEFINE_PROP_BOOL("hint-on-deflate", VirtIOBalloon, hint_on_deflate, =
true),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virti=
o-balloon.h
index 99dcd6d105..69732cedaa 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -45,6 +45,7 @@ typedef struct VirtIOBalloon {
     int64_t stats_poll_interval;
     uint32_t host_features;
     PartiallyBalloonedPage *pbp;
+    bool hint_on_deflate;
 } VirtIOBalloon;
=20
 #endif
--=20
2.20.1
