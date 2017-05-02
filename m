Received: from eggs.gnu.org ([2001:4830:134:3::10]:58857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5XyY-0001IO-AJ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5XyV-0001oB-6o
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39990
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d5XyV-0001o5-1F
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42DYKvv045256
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 09:36:18 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a6hy1uruv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 09:36:18 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 2 May 2017 14:36:16 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue,  2 May 2017 15:35:58 +0200
In-Reply-To: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
References: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
Message-Id: <20170502133604.17735-7-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 06/12] pc-bios/s390-ccw: get LOADPARM stored in
 SCP Read Info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

Obtain the loadparm value stored in SCP Read Info by performing
a SCLP Read Info request.

Rename sclp-ascii.c to sclp.c to reflect the changed scope of
the file.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 pc-bios/s390-ccw/Makefile                 |  2 +-
 pc-bios/s390-ccw/s390-ccw.h               |  3 ++-
 pc-bios/s390-ccw/{sclp-ascii.c => sclp.c} | 12 ++++++++++++
 pc-bios/s390-ccw/sclp.h                   |  2 ++
 4 files changed, 17 insertions(+), 2 deletions(-)
 rename pc-bios/s390-ccw/{sclp-ascii.c => sclp.c} (87%)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 0339c24789..79a46b6735 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -9,7 +9,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 
 .PHONY : all clean build-all
 
-OBJECTS = start.o main.o bootmap.o sclp-ascii.o virtio.o virtio-scsi.o
+OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
 QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 4e0aab27d3..903d2ce816 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -63,9 +63,10 @@ void panic(const char *string);
 void write_subsystem_identification(void);
 extern char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 
-/* sclp-ascii.c */
+/* sclp.c */
 void sclp_print(const char *string);
 void sclp_setup(void);
+void sclp_get_loadparm_ascii(char *loadparm);
 
 /* virtio.c */
 unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
diff --git a/pc-bios/s390-ccw/sclp-ascii.c b/pc-bios/s390-ccw/sclp.c
similarity index 87%
rename from pc-bios/s390-ccw/sclp-ascii.c
rename to pc-bios/s390-ccw/sclp.c
index dc1c3e4f4d..a1639baed7 100644
--- a/pc-bios/s390-ccw/sclp-ascii.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -80,3 +80,15 @@ void sclp_print(const char *str)
 
     sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
 }
+
+void sclp_get_loadparm_ascii(char *loadparm)
+{
+
+    ReadInfo *sccb = (void *)_sccb;
+
+    memset((char *)_sccb, 0, sizeof(ReadInfo));
+    sccb->h.length = sizeof(ReadInfo);
+    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
+        ebcdic_to_ascii((char *) sccb->loadparm, loadparm, 8);
+    }
+}
diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
index 3cbfb78930..0dd987ff5d 100644
--- a/pc-bios/s390-ccw/sclp.h
+++ b/pc-bios/s390-ccw/sclp.h
@@ -55,6 +55,8 @@ typedef struct ReadInfo {
     SCCBHeader h;
     uint16_t rnmax;
     uint8_t rnsize;
+    uint8_t reserved[13];
+    uint8_t loadparm[8];
 } __attribute__((packed)) ReadInfo;
 
 typedef struct SCCB {
-- 
2.11.0
