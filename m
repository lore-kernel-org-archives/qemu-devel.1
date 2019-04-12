Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020C0C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B801C2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B801C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35794 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvRD-0005jC-0K
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:37:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFb-00024Y-Ge
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFZ-0002Pw-NX
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hEvFY-0002OJ-FI; Fri, 12 Apr 2019 08:25:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 525AA3082129;
	Fri, 12 Apr 2019 12:25:43 +0000 (UTC)
Received: from thuth.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8ACA05D9CC;
	Fri, 12 Apr 2019 12:25:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: cohuck@redhat.com,
	qemu-s390x@nongnu.org
Date: Fri, 12 Apr 2019 14:25:11 +0200
Message-Id: <20190412122523.24111-6-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 12 Apr 2019 12:25:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 05/17] s390-bios:
 Decouple channel i/o logic from virtio
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412122511.m4AITkpcRgKlzk14l2EBbutsbVjO_P4BdtxCwHaaNCU@z>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Create a separate library for channel i/o related code. This decouples
channel i/o operations from virtio and allows us to make use of them for
the real dasd boot path.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1554388475-18329-6-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/Makefile    |  2 +-
 pc-bios/s390-ccw/cio.c       | 44 ++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/cio.h       |  3 +++
 pc-bios/s390-ccw/main.c      |  1 +
 pc-bios/s390-ccw/netboot.mak |  2 +-
 pc-bios/s390-ccw/netmain.c   |  1 +
 pc-bios/s390-ccw/s390-ccw.h  |  1 -
 pc-bios/s390-ccw/virtio.c    | 27 ++--------------------
 8 files changed, 53 insertions(+), 28 deletions(-)
 create mode 100644 pc-bios/s390-ccw/cio.c

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 1eb316b02f..12ad9c1d58 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -10,7 +10,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 .PHONY : all clean build-all
=20
 OBJECTS =3D start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
-	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o
+	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o cio.o
=20
 QEMU_CFLAGS :=3D $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS +=3D -ffreestanding -fno-delete-null-pointer-checks -msoft-f=
loat
diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
new file mode 100644
index 0000000000..87c6b34e88
--- /dev/null
+++ b/pc-bios/s390-ccw/cio.c
@@ -0,0 +1,44 @@
+/*
+ * S390 Channel I/O
+ *
+ * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
+ * Copyright (c) 2019 IBM Corp.
+ *
+ * Author(s): Jason J. Herne <jjherne@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "libc.h"
+#include "s390-ccw.h"
+#include "cio.h"
+
+static char chsc_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)))=
;
+
+int enable_mss_facility(void)
+{
+    int ret;
+    ChscAreaSda *sda_area =3D (ChscAreaSda *) chsc_page;
+
+    memset(sda_area, 0, PAGE_SIZE);
+    sda_area->request.length =3D 0x0400;
+    sda_area->request.code =3D 0x0031;
+    sda_area->operation_code =3D 0x2;
+
+    ret =3D chsc(sda_area);
+    if ((ret =3D=3D 0) && (sda_area->response.code =3D=3D 0x0001)) {
+        return 0;
+    }
+    return -EIO;
+}
+
+void enable_subchannel(SubChannelId schid)
+{
+    Schib schib;
+
+    stsch_err(schid, &schib);
+    schib.pmcw.ena =3D 1;
+    msch(schid, &schib);
+}
diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index ed5b2cbf72..218fd96ea3 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -213,6 +213,9 @@ typedef struct irb {
     __u32 emw[8];
 }  __attribute__ ((packed, aligned(4))) Irb;
=20
+int enable_mss_facility(void);
+void enable_subchannel(SubChannelId schid);
+
 /*
  * Some S390 specific IO instructions as inline
  */
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 67df42191b..10f04c6906 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -10,6 +10,7 @@
=20
 #include "libc.h"
 #include "s390-ccw.h"
+#include "cio.h"
 #include "virtio.h"
=20
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
index 14e96b2aa6..5eefb7c289 100644
--- a/pc-bios/s390-ccw/netboot.mak
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -1,7 +1,7 @@
=20
 SLOF_DIR :=3D $(SRC_PATH)/roms/SLOF
=20
-NETOBJS :=3D start.o sclp.o virtio.o virtio-net.o jump2ipl.o netmain.o \
+NETOBJS :=3D start.o sclp.o cio.o virtio.o virtio-net.o jump2ipl.o netma=
in.o \
 	   libnet.a libc.a
=20
 LIBC_INC :=3D -nostdinc -I$(SLOF_DIR)/lib/libc/include
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 0392131c27..5189c0fc39 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -33,6 +33,7 @@
 #include <pxelinux.h>
=20
 #include "s390-ccw.h"
+#include "cio.h"
 #include "virtio.h"
=20
 #define DEFAULT_BOOT_RETRIES 10
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 241c6d0b69..b39ee5d323 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -72,7 +72,6 @@ unsigned long virtio_load_direct(ulong rec_list1, ulong=
 rec_list2,
 bool virtio_is_supported(SubChannelId schid);
 void virtio_blk_setup_device(SubChannelId schid);
 int virtio_read(ulong sector, void *load_addr);
-int enable_mss_facility(void);
 u64 get_clock(void);
 ulong get_second(void);
=20
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index cdb66f459e..aa9da7253f 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -10,6 +10,7 @@
=20
 #include "libc.h"
 #include "s390-ccw.h"
+#include "cio.h"
 #include "virtio.h"
 #include "virtio-scsi.h"
 #include "bswap.h"
@@ -20,8 +21,6 @@ static VRing block[VIRTIO_MAX_VQS];
 static char ring_area[VIRTIO_RING_SIZE * VIRTIO_MAX_VQS]
                      __attribute__((__aligned__(PAGE_SIZE)));
=20
-static char chsc_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)))=
;
-
 static VDev vdev =3D {
     .nr_vqs =3D 1,
     .vrings =3D block,
@@ -94,14 +93,9 @@ static int run_ccw(VDev *vdev, int cmd, void *ptr, int=
 len)
 {
     Ccw1 ccw =3D {};
     CmdOrb orb =3D {};
-    Schib schib;
     int r;
=20
-    /* start command processing */
-    stsch_err(vdev->schid, &schib);
-    /* enable the subchannel for IPL device */
-    schib.pmcw.ena =3D 1;
-    msch(vdev->schid, &schib);
+    enable_subchannel(vdev->schid);
=20
     /* start subchannel command */
     orb.fmt =3D 1;
@@ -343,20 +337,3 @@ bool virtio_is_supported(SubChannelId schid)
     }
     return false;
 }
-
-int enable_mss_facility(void)
-{
-    int ret;
-    ChscAreaSda *sda_area =3D (ChscAreaSda *) chsc_page;
-
-    memset(sda_area, 0, PAGE_SIZE);
-    sda_area->request.length =3D 0x0400;
-    sda_area->request.code =3D 0x0031;
-    sda_area->operation_code =3D 0x2;
-
-    ret =3D chsc(sda_area);
-    if ((ret =3D=3D 0) && (sda_area->response.code =3D=3D 0x0001)) {
-        return 0;
-    }
-    return -EIO;
-}
--=20
2.21.0


