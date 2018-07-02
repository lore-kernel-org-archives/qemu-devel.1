Received: from eggs.gnu.org ([2001:4830:134:3::10]:46101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fa1jc-0003Gr-MJ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fa1jb-0002CI-RQ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:31:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fa1jb-0002C8-MQ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:31:27 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  2 Jul 2018 18:31:25 +0200
Message-Id: <20180702163125.28729-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] fsdev: fix compilation with VIRTIO but not
 VIRTIO_9P
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: groug@kaod.org

hw/9pfs/Makefile.objs uses CONFIG_VIRTIO_9P to guard the definition for
FileOperations structs, while fsdev/Makefile.objs uses CONFIG_VIRTIO
to guard the use.  Mismatch causes linking to fail when CONFIG_VIRTIO
is set but CONFIG_VIRTIO_9P is not.

Fix it and use if/else to clarify that the two lines are for opposite
conditions.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: b5dfdb082fc350f3e68dfa61dc988d97cad28cfe
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 fsdev/Makefile.objs | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
index fb38017c0b..24bbb3e75c 100644
--- a/fsdev/Makefile.objs
+++ b/fsdev/Makefile.objs
@@ -1,7 +1,10 @@
 # Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
 # only pull in the actual 9p backend if we also enabled virtio or xen.
-common-obj-$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO),$(CONFIG_XEN))) = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
-common-obj-$(call lnot,$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO),$(CONFIG_XEN)))) = qemu-fsdev-dummy.o
+ifeq ($(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO_9P),$(CONFIG_XEN))),y)
+common-obj-y = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
+else
+common-obj-y = qemu-fsdev-dummy.o
+endif
 common-obj-y += qemu-fsdev-opts.o qemu-fsdev-throttle.o
 
 # Toplevel always builds this; targets without virtio will put it in
-- 
2.17.1
