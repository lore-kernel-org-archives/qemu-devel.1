Received: from eggs.gnu.org ([2001:4830:134:3::10]:51204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mg-00070f-G2
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mf-0008Mv-II
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34286 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7mf-0008MU-CE
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:57 -0400
Date: Tue, 20 Mar 2018 05:17:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-40-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 39/50] vhost+postcopy: Resolve client address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Resolve fault addresses read off the clients UFD into RAMBlock
and offset, and call back to the postcopy code to ask for the page.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 31 ++++++++++++++++++++++++++++++-
 hw/virtio/trace-events |  3 +++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b47de62..6dee1b5 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -26,6 +26,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <linux/vhost.h>
+#include <linux/userfaultfd.h>
=20
 #define VHOST_MEMORY_MAX_NREGIONS    8
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
@@ -974,7 +975,35 @@ out:
 static int vhost_user_postcopy_fault_handler(struct PostCopyFD *pcfd,
                                              void *ufd)
 {
-    return 0;
+    struct vhost_dev *dev =3D pcfd->data;
+    struct vhost_user *u =3D dev->opaque;
+    struct uffd_msg *msg =3D ufd;
+    uint64_t faultaddr =3D msg->arg.pagefault.address;
+    RAMBlock *rb =3D NULL;
+    uint64_t rb_offset;
+    int i;
+
+    trace_vhost_user_postcopy_fault_handler(pcfd->idstr, faultaddr,
+                                            dev->mem->nregions);
+    for (i =3D 0; i < MIN(dev->mem->nregions, u->region_rb_len); i++) {
+        trace_vhost_user_postcopy_fault_handler_loop(i,
+                u->postcopy_client_bases[i], dev->mem->regions[i].memory=
_size);
+        if (faultaddr >=3D u->postcopy_client_bases[i]) {
+            /* Ofset of the fault address in the vhost region */
+            uint64_t region_offset =3D faultaddr - u->postcopy_client_ba=
ses[i];
+            if (region_offset < dev->mem->regions[i].memory_size) {
+                rb_offset =3D region_offset + u->region_rb_offset[i];
+                trace_vhost_user_postcopy_fault_handler_found(i,
+                        region_offset, rb_offset);
+                rb =3D u->region_rb[i];
+                return postcopy_request_shared_page(pcfd, rb, faultaddr,
+                                                    rb_offset);
+            }
+        }
+    }
+    error_report("%s: Failed to find region for fault %" PRIx64,
+                 __func__, faultaddr);
+    return -1;
 }
=20
 /*
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index d7e9e10..3afd12c 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -7,6 +7,9 @@ vhost_region_add_section_abut(const char *name, uint64_t =
new_size) "%s: 0x%"PRIx
 vhost_section(const char *name, int r) "%s:%d"
=20
 # hw/virtio/vhost-user.c
+vhost_user_postcopy_fault_handler(const char *name, uint64_t fault_addre=
ss, int nregions) "%s: @0x%"PRIx64" nregions:%d"
+vhost_user_postcopy_fault_handler_loop(int i, uint64_t client_base, uint=
64_t size) "%d: client 0x%"PRIx64" +0x%"PRIx64
+vhost_user_postcopy_fault_handler_found(int i, uint64_t region_offset, u=
int64_t rb_offset) "%d: region_offset: 0x%"PRIx64" rb_offset:0x%"PRIx64
 vhost_user_postcopy_listen(void) ""
 vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, i=
nt reply_i, int region_i) "client:0x%"PRIx64" for hva: 0x%"PRIx64" reply =
%d region %d"
 vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t me=
mory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_t of=
fset) "%d:%s: size:0x%"PRIx64" GPA:0x%"PRIx64" QVA/userspace:0x%"PRIx64" =
RB offset:0x%"PRIx64
--=20
MST
