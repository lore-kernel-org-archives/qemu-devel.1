Received: from eggs.gnu.org ([2001:4830:134:3::10]:36611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAcss-0007XX-OY
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAcsp-0008WR-NL
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:56:02 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 23 Apr 2018 16:55:48 +0200
Message-Id: <1524495348-435-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1524470305-26484-1-git-send-email-thuth@redhat.com>
References: <1524470305-26484-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/4] pc-bios/s390-ccw/net: Try to load
 pxelinux.cfg file accoring to the UUID
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

With the STSI instruction, we can get the UUID of the current VM instance,
so we can support loading pxelinux config files via UUID in the file name,
too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Sorry, just found out how to get the VM UUID after sending out the v2
 series, so this is now patch 5 of 4 ;-)

 pc-bios/s390-ccw/netmain.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index fdf115e..f75bd7e 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -286,6 +286,37 @@ static void net_release(filename_ip_t *fn_ip)
     }
 }
 
+static int get_uuid(uint8_t *uuid)
+{
+    register int r0 asm("0");
+    register int r1 asm("1");
+    uint8_t *mem, *buf;
+    int i, chk = 0;
+
+    mem = malloc(2 * PAGE_SIZE);
+    if (!mem) {
+        puts("Out of memory ... can not get UUID.");
+        return -12;
+    }
+    buf = (uint8_t *)(((uint64_t)mem + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1));
+    memset(buf, 0, PAGE_SIZE);
+
+    /* Get SYSIB 3.2.2 */
+    r0 = (3 << 28) | 2;
+    r1 = 2;
+    asm volatile(" stsi 0(%2)\n" : : "d" (r0), "d" (r1), "a" (buf)
+                 : "cc", "memory");
+
+    for (i = 0; i < 16; i++) {
+        uuid[i] = buf[8 * 4 + 12 * 4 + i];
+        chk |= uuid[i];
+    }
+
+    free(mem);
+
+    return chk ? 0 : -1;
+}
+
 /* This structure holds the data from one pxelinux.cfg file entry */
 struct lkia {
     const char *label;
@@ -403,6 +434,7 @@ static int net_try_pxelinux_cfgs(filename_ip_t *fn_ip)
     int rc, idx;
     char basedir[256];
     int has_basedir;
+    uint8_t uuid[16];
 
     cfgbuf[sizeof(cfgbuf) - 1] = 0;   /* Make sure that it is NUL-terminated */
 
@@ -419,6 +451,19 @@ static int net_try_pxelinux_cfgs(filename_ip_t *fn_ip)
 
     printf("Trying pxelinux.cfg files...\n");
 
+    /* Try to load config file with name based on the VM UUID */
+    if (get_uuid(uuid) == 0) {
+        sprintf((char *)fn_ip->filename, "%s%02x%02x%02x%02x-%02x%02x-"
+                "%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x", basedir,
+                uuid[0], uuid[1], uuid[2], uuid[3], uuid[4], uuid[5],
+                uuid[6], uuid[7], uuid[8], uuid[9], uuid[10], uuid[11],
+                uuid[12], uuid[13], uuid[14], uuid[15]);
+        rc = tftp_load(fn_ip, cfgbuf, sizeof(cfgbuf) - 1);
+        if (rc > 0) {
+            return handle_pxelinux_cfg(fn_ip, cfgbuf, sizeof(cfgbuf));
+        }
+    }
+
     /* Look for config file with MAC address in its name */
     sprintf((char *)fn_ip->filename, "%s%02x-%02x-%02x-%02x-%02x-%02x",
             basedir, mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
-- 
1.8.3.1
