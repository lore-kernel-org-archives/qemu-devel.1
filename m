Received: from eggs.gnu.org ([2001:4830:134:3::10]:41915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNb-0007EJ-Jp
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNa-0001rw-Ct
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:04:59 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Jun 2018 14:04:32 +0200
Message-Id: <20180619120434.25062-11-cohuck@redhat.com>
In-Reply-To: <20180619120434.25062-1-cohuck@redhat.com>
References: <20180619120434.25062-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 10/12] pc-bios/s390-ccw/net: Try to load
 pxelinux.cfg file accoring to the UUID
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

With the STSI instruction, we can get the UUID of the current VM instance,
so we can support loading pxelinux config files via UUID in the file name,
too.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/netmain.c | 56 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index c059546480..0392131c27 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -44,6 +44,9 @@ extern char _start[];
 #define KERNEL_MAX_SIZE         ((long)_start)
 #define ARCH_COMMAND_LINE_SIZE  896              /* Taken from Linux kernel */
 
+/* STSI 3.2.2 offset of first vmdb + offset of uuid inside vmdb */
+#define STSI322_VMDB_UUID_OFFSET ((8 + 12) * 4)
+
 char stack[PAGE_SIZE * 8] __attribute__((aligned(PAGE_SIZE)));
 IplParameterBlock iplb __attribute__((aligned(PAGE_SIZE)));
 static char cfgbuf[2048];
@@ -235,6 +238,56 @@ static void net_release(filename_ip_t *fn_ip)
     }
 }
 
+/**
+ * Retrieve the Universally Unique Identifier of the VM.
+ * @return UUID string, or NULL in case of errors
+ */
+static const char *get_uuid(void)
+{
+    register int r0 asm("0");
+    register int r1 asm("1");
+    uint8_t *mem, *buf, uuid[16];
+    int i, cc, chk = 0;
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
+    asm volatile(" stsi 0(%[addr])\n"
+                 " ipm  %[cc]\n"
+                 " srl  %[cc],28\n"
+                 : [cc] "=d" (cc)
+                 : "d" (r0), "d" (r1), [addr] "a" (buf)
+                 : "cc", "memory");
+    if (cc) {
+        return NULL;
+    }
+
+    for (i = 0; i < 16; i++) {
+        uuid[i] = buf[STSI322_VMDB_UUID_OFFSET + i];
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
 /**
  * Load a kernel with initrd (i.e. with the information that we've got from
  * a pxelinux.cfg config file)
@@ -285,7 +338,8 @@ static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
     struct pl_cfg_entry entries[MAX_PXELINUX_ENTRIES];
     int num_ent, def_ent = 0;
 
-    num_ent = pxelinux_load_parse_cfg(fn_ip, mac, NULL, DEFAULT_TFTP_RETRIES,
+    num_ent = pxelinux_load_parse_cfg(fn_ip, mac, get_uuid(),
+                                      DEFAULT_TFTP_RETRIES,
                                       cfgbuf, sizeof(cfgbuf),
                                       entries, MAX_PXELINUX_ENTRIES, &def_ent);
     if (num_ent > 0) {
-- 
2.14.4
