Received: from eggs.gnu.org ([2001:4830:134:3::10]:53201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR9C-0008Ry-MM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR99-0007oy-TA
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:22:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38224 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evR99-0007og-Os
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:22:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6CC4976FB9
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 17:22:03 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 12 Mar 2018 17:21:16 +0000
Message-Id: <20180312172124.56461-22-dgilbert@redhat.com>
In-Reply-To: <20180312172124.56461-1-dgilbert@redhat.com>
References: <20180312172124.56461-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 21/29] vhost+postcopy: Add vhost waker
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

Register a waker function in vhost-user code to be notified when
pages arrive or requests to previously mapped pages get requested.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/trace-events |  3 +++
 hw/virtio/vhost-user.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 3afd12cfea..fe5e0ff856 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -13,6 +13,9 @@ vhost_user_postcopy_fault_handler_found(int i, uint64_t=
 region_offset, uint64_t
 vhost_user_postcopy_listen(void) ""
 vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, i=
nt reply_i, int region_i) "client:0x%"PRIx64" for hva: 0x%"PRIx64" reply =
%d region %d"
 vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t me=
mory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_t of=
fset) "%d:%s: size:0x%"PRIx64" GPA:0x%"PRIx64" QVA/userspace:0x%"PRIx64" =
RB offset:0x%"PRIx64
+vhost_user_postcopy_waker(const char *rb, uint64_t rb_offset) "%s + 0x%"=
PRIx64
+vhost_user_postcopy_waker_found(uint64_t client_addr) "0x%"PRIx64
+vhost_user_postcopy_waker_nomatch(const char *rb, uint64_t rb_offset) "%=
s + 0x%"PRIx64
=20
 # hw/virtio/virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned=
 out_num) "elem %p size %zd in_num %u out_num %u"
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 6dee1b565c..a785aefd3e 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1006,6 +1006,35 @@ static int vhost_user_postcopy_fault_handler(struc=
t PostCopyFD *pcfd,
     return -1;
 }
=20
+static int vhost_user_postcopy_waker(struct PostCopyFD *pcfd, RAMBlock *=
rb,
+                                     uint64_t offset)
+{
+    struct vhost_dev *dev =3D pcfd->data;
+    struct vhost_user *u =3D dev->opaque;
+    int i;
+
+    trace_vhost_user_postcopy_waker(qemu_ram_get_idstr(rb), offset);
+
+    if (!u) {
+        return 0;
+    }
+    /* Translate the offset into an address in the clients address space=
 */
+    for (i =3D 0; i < MIN(dev->mem->nregions, u->region_rb_len); i++) {
+        if (u->region_rb[i] =3D=3D rb &&
+            offset >=3D u->region_rb_offset[i] &&
+            offset < (u->region_rb_offset[i] +
+                      dev->mem->regions[i].memory_size)) {
+            uint64_t client_addr =3D (offset - u->region_rb_offset[i]) +
+                                   u->postcopy_client_bases[i];
+            trace_vhost_user_postcopy_waker_found(client_addr);
+            return postcopy_wake_shared(pcfd, client_addr, rb);
+        }
+    }
+
+    trace_vhost_user_postcopy_waker_nomatch(qemu_ram_get_idstr(rb), offs=
et);
+    return 0;
+}
+
 /*
  * Called at the start of an inbound postcopy on reception of the
  * 'advise' command.
@@ -1051,6 +1080,7 @@ static int vhost_user_postcopy_advise(struct vhost_=
dev *dev, Error **errp)
     u->postcopy_fd.fd =3D ufd;
     u->postcopy_fd.data =3D dev;
     u->postcopy_fd.handler =3D vhost_user_postcopy_fault_handler;
+    u->postcopy_fd.waker =3D vhost_user_postcopy_waker;
     u->postcopy_fd.idstr =3D "vhost-user"; /* Need to find unique name *=
/
     postcopy_register_shared_ufd(&u->postcopy_fd);
     return 0;
--=20
2.14.3
