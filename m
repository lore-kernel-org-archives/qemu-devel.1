Received: from eggs.gnu.org ([2001:4830:134:3::10]:53896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX1c-0007a3-Su
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX1b-00068S-JA
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:10:24 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:20 +0100
Message-Id: <20171214171004.25058-3-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 02/46] pc-bios/s390-ccw: zero out bss section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

The QEMU ELF loader does not zero the bss segment.
This resulted in several bugs, e.g. see

commit 5d739a4787a5 (s390-ccw.img: Fix sporadic errors with ccw boot image - initialize css)
commit 6a40fa2669d3 (s390-ccw.img: Initialize next_idx)
commit 8775d91a0f42 (pc-bios/s390-ccw: Fix problem with invalid virtio-scsi LUN when rebooting)

Let's fix this once and forever by letting the BIOS zero the bss itself.

Suggested-by: Alexander Graf <agraf@suse.de>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20171122142627.73170-3-borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw/start.S | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index 43f9bd243e..eb8d024dbb 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -3,7 +3,7 @@
  * into the pc-bios directory of qemu.
  *
  * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
- * Copyright 2013 IBM Corp.
+ * Copyright IBM Corp. 2013, 2017
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or (at
  * your option) any later version. See the COPYING file in the top-level
@@ -13,8 +13,32 @@
         .globl _start
 _start:
 
-larl	%r15, stack + 0x8000    /* Set up stack */
-j	main                    /* And call C */
+	larl   %r15, stack + 0x8000	/* Set up stack */
+
+	/* clear bss */
+	larl %r2, __bss_start
+	larl %r3, _end
+	slgr %r3, %r2		/* get sizeof bss */
+	ltgr	%r3,%r3 	/* bss emtpy? */
+	jz	done
+	aghi	%r3,-1
+	srlg	%r4,%r3,8	/* how many 256 byte chunks? */
+	ltgr	%r4,%r4
+	lgr	%r1,%r2
+	jz	remainder
+loop:
+	xc	0(256,%r1),0(%r1)
+	la	%r1,256(%r1)
+	brctg	%r4,loop
+remainder:
+	larl	%r2,memsetxc
+	ex	%r3,0(%r2)
+done:
+	j      main		/* And call C */
+
+memsetxc:
+	xc	0(1,%r1),0(%r1)
+
 
 /*
  * void disabled_wait(void)
-- 
2.13.6
