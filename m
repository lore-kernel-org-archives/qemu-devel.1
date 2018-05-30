Received: from eggs.gnu.org ([2001:4830:134:3::10]:34522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fNxE9-0002Re-VI
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fNxE9-00072M-2r
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:17:05 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 30 May 2018 11:16:58 +0200
Message-Id: <1527671818-23809-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1527671818-23809-1-git-send-email-thuth@redhat.com>
References: <1527671818-23809-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] pc-bios/s390-ccw/net: Try to load
 pxelinux.cfg file accoring to the UUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

With the STSI instruction, we can get the UUID of the current VM instance,
so we can support loading pxelinux config files via UUID in the file name,
too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/netmain.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index e84bb2b..7ece302 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -235,6 +235,49 @@ static void net_release(filename_ip_t *fn_ip)
 }
 
 /**
+ * Retrieve the Universally Unique Identifier of the VM.
+ * @return UUID string, or NULL in case of errors
+ */
+static const char *get_uuid(void)
+{
+    register int r0 asm("0");
+    register int r1 asm("1");
+    uint8_t *mem, *buf, uuid[16];
+    int i, chk = 0;
+    static char uuid_str[37];
+
+    mem = malloc(2 * PAGE_SIZE);
+    if (!mem) {
+        puts("Out of memory ... can not get UUID.");
+        return NULL;
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
+    free(mem);
+    if (!chk) {
+        return NULL;
+    }
+
+    sprintf(uuid_str, "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-"
+            "%02x%02x%02x%02x%02x%02x", uuid[0], uuid[1], uuid[2], uuid[3],
+            uuid[4], uuid[5], uuid[6], uuid[7], uuid[8], uuid[9], uuid[10],
+            uuid[11], uuid[12], uuid[13], uuid[14], uuid[15]);
+
+    return uuid_str;
+}
+
+/**
  * Load a kernel with initrd (i.e. with the information that we've got from
  * a pxelinux.cfg config file)
  */
@@ -284,7 +327,8 @@ static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
     struct pl_cfg_entry entries[MAX_PXELINUX_ENTRIES];
     int num_ent, def_ent = 0;
 
-    num_ent = pxelinux_load_parse_cfg(fn_ip, mac, NULL, DEFAULT_TFTP_RETRIES,
+    num_ent = pxelinux_load_parse_cfg(fn_ip, mac, get_uuid(),
+                                      DEFAULT_TFTP_RETRIES,
                                       cfgbuf, sizeof(cfgbuf),
                                       entries, MAX_PXELINUX_ENTRIES, &def_ent);
     if (num_ent > 0) {
-- 
1.8.3.1
