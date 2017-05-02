Received: from eggs.gnu.org ([2001:4830:134:3::10]:58907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5Xyb-0001Kq-6U
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5XyY-0001pK-3Z
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d5XyX-0001oz-Qi
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:22 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42DYIuK076920
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 09:36:20 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a68vwtmgw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 09:36:20 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 2 May 2017 14:36:18 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue,  2 May 2017 15:35:59 +0200
In-Reply-To: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
References: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
Message-Id: <20170502133604.17735-8-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 07/12] pc-bios/s390-ccw: provide a function to
 interpret LOADPARM value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Farhan Ali <alifm@linux.vnet.ibm.com>, Eugene Dvurechenski <jno@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

The LOADPARM value is fetched from SCP Read Info, but it's applied
only at the phase of bootmap interpretation. So let's read the LOARPARM
value and store it. Also provide a parsing function to detect numbers in
the LOADPARM which can be used during bootmap interpretation.

Remove a stray whitespace.

Initial patch from Eugene (jno) Dvurechenski.

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 pc-bios/s390-ccw/main.c     | 27 ++++++++++++++++++++++++++-
 pc-bios/s390-ccw/s390-ccw.h |  1 +
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 393d732353..1cacc1b46f 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -14,6 +14,7 @@
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid = { .one = 1 };
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
+static char loadparm[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
 
 const unsigned char ebc2asc[256] =
       /* 0123456789abcdef0123456789abcdef */
@@ -40,7 +41,6 @@ void write_subsystem_identification(void)
     *zeroes = 0;
 }
 
-
 void panic(const char *string)
 {
     sclp_print(string);
@@ -48,6 +48,26 @@ void panic(const char *string)
     while (1) { }
 }
 
+unsigned int get_loadparm_index(void)
+{
+    const char *lp = loadparm;
+    int i;
+    unsigned int idx = 0;
+
+    for (i = 0; i < 8; i++) {
+        char c = lp[i];
+
+        if (c < '0' || c > '9') {
+            break;
+        }
+
+        idx *= 10;
+        idx += c - '0';
+    }
+
+    return idx;
+}
+
 static bool find_dev(Schib *schib, int dev_no)
 {
     int i, r;
@@ -84,6 +104,7 @@ static void virtio_setup(void)
     int ssid;
     bool found = false;
     uint16_t dev_no;
+    char ldp[] = "LOADPARM=[________]\n";
     VDev *vdev = virtio_get_device();
 
     /*
@@ -93,6 +114,10 @@ static void virtio_setup(void)
      */
     enable_mss_facility();
 
+    sclp_get_loadparm_ascii(loadparm);
+    memcpy(ldp + 10, loadparm, 8);
+    sclp_print(ldp);
+
     if (store_iplb(&iplb)) {
         switch (iplb.pbt) {
         case S390_IPL_TYPE_CCW:
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 903d2ce816..07d8cbcb20 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -62,6 +62,7 @@ void consume_sclp_int(void);
 void panic(const char *string);
 void write_subsystem_identification(void);
 extern char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
+unsigned int get_loadparm_index(void);
 
 /* sclp.c */
 void sclp_print(const char *string);
-- 
2.11.0
