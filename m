Received: from eggs.gnu.org ([2001:4830:134:3::10]:57697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGiAy-0004GH-46
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:15:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGiAw-0003Gl-Es
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:15:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eGiAw-0003GV-6G
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:15:34 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAK9EbKY068550
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 04:15:29 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ebqj1ww47-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 04:15:28 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 20 Nov 2017 09:15:24 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 20 Nov 2017 10:15:20 +0100
Message-Id: <20171120091520.86128-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH] pc-bios/s390-ccw: build s390 bios with
 -fno-zero-initialized-in-bss
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

The QEMU ELF loader does not initialize the bss segment. This has
triggered several bugs in the past, e.g. see commit 5d739a4787a5
("s390-ccw.img: Fix sporadic errors with ccw boot image - initialize
css").

Instead of fixing these things one-by-one we can build the BIOS
with -fno-zero-initialized-in-bss. This will move the zero variables
also into the data segment, which is then part of a LOAD section.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 pc-bios/s390-ccw/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 6d0c2ee..2687590 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -12,7 +12,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
-QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
+QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing -fno-zero-initialized-in-bss
 QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
 LDFLAGS += -Wl,-pie -nostdlib
 
-- 
2.9.4
