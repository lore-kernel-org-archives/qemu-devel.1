Received: from eggs.gnu.org ([209.51.188.92]:45589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCJ-0001j3-PN
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCJ-0003b3-48
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:19 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:41180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCI-0003aG-SV
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:19 -0500
Received: by mail-wr1-x42e.google.com with SMTP id n2so6632541wrw.8
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:18 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:21 +0100
Message-Id: <1551723614-1823-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/54] block: fix recursion in hw/block/dataplane
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>

There are Xen files in hw/block/dataplane that should be compiled even if
virtio-blk is disabled.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/block/Makefile.objs           | 3 ++-
 hw/block/dataplane/Makefile.objs | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index e206b8e..f5f643f 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -12,5 +12,6 @@ common-obj-$(CONFIG_NVME_PCI) += nvme.o
 obj-$(CONFIG_SH4) += tc58128.o
 
 obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
-obj-$(CONFIG_VIRTIO_BLK) += dataplane/
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
+
+obj-y += dataplane/
diff --git a/hw/block/dataplane/Makefile.objs b/hw/block/dataplane/Makefile.objs
index c6c68db..0c52702 100644
--- a/hw/block/dataplane/Makefile.objs
+++ b/hw/block/dataplane/Makefile.objs
@@ -1,2 +1,2 @@
-obj-y += virtio-blk.o
+obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
 obj-$(CONFIG_XEN) += xen-block.o
-- 
1.8.3.1
