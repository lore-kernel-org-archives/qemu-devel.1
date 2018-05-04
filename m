Received: from eggs.gnu.org ([2001:4830:134:3::10]:34299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV6C-0004Zt-P2
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV6B-0007Vt-Ml
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:48 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 May 2018 09:25:12 +0200
Message-Id: <20180504072514.8450-14-cohuck@redhat.com>
In-Reply-To: <20180504072514.8450-1-cohuck@redhat.com>
References: <20180504072514.8450-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 13/15] pc-bios/s390-ccw/net: Add support for
 .INS config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

The .INS config files can normally be found on CD-ROM ISO images,
so by supporting these files, it is now possible to boot directly
when the TFTP server is set up with the contents of such an CD-ROM
image.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/netmain.c | 100 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 69a82c0d56..600024155b 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -39,8 +39,12 @@
 
 extern char _start[];
 
+#define KERNEL_ADDR             ((void *)0L)
+#define KERNEL_MAX_SIZE         ((long)_start)
+
 char stack[PAGE_SIZE * 8] __attribute__((aligned(PAGE_SIZE)));
 IplParameterBlock iplb __attribute__((aligned(PAGE_SIZE)));
+static char cfgbuf[2048];
 
 static SubChannelId net_schid = { .one = 1 };
 static int ip_version = 4;
@@ -136,9 +140,15 @@ static int tftp_load(filename_ip_t *fnip, void *buffer, int len)
     rc = tftp(fnip, buffer, len, DEFAULT_TFTP_RETRIES, &tftp_err, 1, 1428,
               ip_version);
 
-    if (rc > 0) {
-        printf("  TFTP: Received %s (%d KBytes)\n", fnip->filename,
-               rc / 1024);
+    if (rc < 0) {
+        /* Make sure that error messages are put into a new line */
+        printf("\n  ");
+    }
+
+    if (rc > 1024) {
+        printf("  TFTP: Received %s (%d KBytes)\n", fnip->filename, rc / 1024);
+    } else if (rc > 0) {
+        printf("  TFTP: Received %s (%d Bytes)\n", fnip->filename, rc);
     } else if (rc == -1) {
         puts("unknown TFTP error");
     } else if (rc == -2) {
@@ -275,6 +285,83 @@ static void net_release(filename_ip_t *fn_ip)
     }
 }
 
+/**
+ * Load via information from a .INS file (which can be found on CD-ROMs
+ * for example)
+ */
+static int handle_ins_cfg(filename_ip_t *fn_ip, char *cfg, int cfgsize)
+{
+    char *ptr;
+    int rc = -1, llen;
+    void *destaddr;
+    char *insbuf = cfg;
+
+    ptr = strchr(insbuf, '\n');
+    if (!ptr) {
+        puts("Does not seem to be a valid .INS file");
+        return -1;
+    }
+
+    *ptr = 0;
+    printf("\nParsing .INS file:\n %s\n", &insbuf[2]);
+
+    insbuf = ptr + 1;
+    while (*insbuf && insbuf < cfg + cfgsize) {
+        ptr = strchr(insbuf, '\n');
+        if (ptr) {
+            *ptr = 0;
+        }
+        llen = strlen(insbuf);
+        if (!llen) {
+            insbuf = ptr + 1;
+            continue;
+        }
+        ptr = strchr(insbuf, ' ');
+        if (!ptr) {
+            puts("Missing space separator in .INS file");
+            return -1;
+        }
+        *ptr = 0;
+        strncpy((char *)fn_ip->filename, insbuf, sizeof(fn_ip->filename));
+        destaddr = (char *)atol(ptr + 1);
+        rc = tftp_load(fn_ip, destaddr, (long)_start - (long)destaddr);
+        if (rc <= 0) {
+            break;
+        }
+        insbuf += llen + 1;
+    }
+
+    return rc;
+}
+
+static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
+{
+    int rc;
+    void *loadaddr = (void *)0x2000;  /* Load right after the low-core */
+
+    rc = tftp_load(fn_ip, loadaddr, KERNEL_MAX_SIZE - (long)loadaddr);
+    if (rc < 0) {
+        return rc;
+    } else if (rc < 8) {
+        printf("'%s' is too small (%i bytes only).\n", fn_ip->filename, rc);
+        return -1;
+    }
+
+    /* Check whether it is a configuration file instead of a kernel */
+    if (rc < sizeof(cfgbuf) - 1) {
+        memcpy(cfgbuf, loadaddr, rc);
+        cfgbuf[rc] = 0;    /* Make sure that it is NUL-terminated */
+        if (!strncmp("* ", cfgbuf, 2)) {
+            return handle_ins_cfg(fn_ip, cfgbuf, rc);
+        }
+    }
+
+    /* Move kernel to right location */
+    memmove(KERNEL_ADDR, loadaddr, rc);
+
+    return rc;
+}
+
 void panic(const char *string)
 {
     sclp_print(string);
@@ -356,7 +443,7 @@ static void virtio_setup(void)
 void main(void)
 {
     filename_ip_t fn_ip;
-    int rc;
+    int rc, fnlen;
 
     sclp_setup();
     sclp_print("Network boot starting...\n");
@@ -368,7 +455,10 @@ void main(void)
         panic("Network initialization failed. Halting.\n");
     }
 
-    rc = tftp_load(&fn_ip, NULL, (long)_start);
+    fnlen = strlen((char *)fn_ip.filename);
+    if (fnlen > 0 && fn_ip.filename[fnlen - 1] != '/') {
+        rc = net_try_direct_tftp_load(&fn_ip);
+    }
 
     net_release(&fn_ip);
 
-- 
2.14.3
