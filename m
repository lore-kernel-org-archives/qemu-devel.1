Received: from eggs.gnu.org ([2001:4830:134:3::10]:41229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eHVz8-0000iN-Cm
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eHVz3-0005GP-FK
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:26:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eHVz3-0005FW-6o
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:26:37 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAMEPuqn123277
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 09:26:35 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2edaya0542-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 09:26:34 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 22 Nov 2017 14:26:32 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 22 Nov 2017 15:26:27 +0100
In-Reply-To: <20171122142627.73170-1-borntraeger@de.ibm.com>
References: <20171122142627.73170-1-borntraeger@de.ibm.com>
Message-Id: <20171122142627.73170-3-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] pc-bios/s390-ccw: zero out bss section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

The QEMU ELF loader does not zero the bss segment.
This resulted in several bugs, e.g. see

commit 5d739a4787a5 (s390-ccw.img: Fix sporadic errors with ccw boot image - initialize css)
commit 6a40fa2669d3 (s390-ccw.img: Initialize next_idx)
commit 8775d91a0f42 (pc-bios/s390-ccw: Fix problem with invalid virtio-scsi LUN when rebooting)

Lets fix this once and forever by letting the BIOS zero the bss itself.

Suggested-by: Alexander Graf <agraf@suse.de>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 pc-bios/s390-ccw/start.S | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index 43f9bd2..eb8d024 100644
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
2.9.4
