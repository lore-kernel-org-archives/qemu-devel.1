Received: from eggs.gnu.org ([2001:4830:134:3::10]:59456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fsUN5-0000Mo-TZ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fsUN2-0003Ki-MM
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:44:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fsUN1-0003Jr-T5
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:44:28 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7MEcrRI109348
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 10:44:26 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2m17s7nycq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 10:44:26 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 22 Aug 2018 15:44:24 +0100
From: Greg Kurz <groug@kaod.org>
Date: Wed, 22 Aug 2018 16:43:40 +0200
In-Reply-To: <20180822144340.91828-1-groug@kaod.org>
References: <20180822144340.91828-1-groug@kaod.org>
Message-Id: <20180822144340.91828-2-groug@kaod.org>
Subject: [Qemu-devel] [PULL 1/1] fsdev: fix compilation with VIRTIO but not
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

hw/9pfs/Makefile.objs uses CONFIG_VIRTIO_9P to guard the definition for
FileOperations structs, while fsdev/Makefile.objs uses CONFIG_VIRTIO
to guard the use.  Mismatch causes linking to fail when CONFIG_VIRTIO
is set but CONFIG_VIRTIO_9P is not.

Fix it and use if/else to clarify that the two lines are for opposite
conditions.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: b5dfdb082fc350f3e68dfa61dc988d97cad28cfe
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/Makefile.objs | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
index fb38017c0b27..24bbb3e75c90 100644
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
2.14.4
