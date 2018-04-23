Received: from eggs.gnu.org ([2001:4830:134:3::10]:36567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAWMz-0003yW-F3
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 03:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAWMv-0003d3-UT
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 03:58:41 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 23 Apr 2018 09:58:24 +0200
Message-Id: <1524470305-26484-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1524470305-26484-1-git-send-email-thuth@redhat.com>
References: <1524470305-26484-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] pc-bios/s390-ccw/net: Add support for
 .INS config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

The .INS config files can normally be found on CD-ROM ISO images,
so by supporting these files, it is now possible to boot directly
when the TFTP server is set up with the contents of such an CD-ROM
image.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/netmain.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 129f009..e5418a9 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -453,6 +453,55 @@ static int net_try_pxelinux_cfgs(filename_ip_t *fn_ip)
     return -1;
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
 static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
 {
     int rc;
@@ -473,6 +522,8 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
         if (!strncasecmp("default", cfgbuf, 7) || !strncmp("# ", cfgbuf, 2)) {
             /* Looks like it is a pxelinux.cfg */
             return handle_pxelinux_cfg(fn_ip, cfgbuf, rc);
+        } else if (!strncmp("* ", cfgbuf, 2)) {
+            return handle_ins_cfg(fn_ip, cfgbuf, rc);
         }
     }
 
-- 
1.8.3.1
