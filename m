Received: from eggs.gnu.org ([2001:4830:134:3::10]:45108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f8mFh-0000jv-RX
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f8mFg-0003Ib-1t
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:31:57 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 18 Apr 2018 14:31:46 +0200
Message-Id: <1524054707-20663-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1524054707-20663-1-git-send-email-thuth@redhat.com>
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.13 3/4] pc-bios/s390-ccw/net: Add
 support for pxelinux-style config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>

Since it is quite cumbersome to manually create a combined kernel with
initrd image for network booting, we now support loading via pxelinux
configuration files, too. In these files, the kernel, initrd and command
line parameters can be specified seperately, and the firmware then takes
care of glueing everything together in memory after the files have been
downloaded.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/netboot.mak |   5 +-
 pc-bios/s390-ccw/netmain.c   | 203 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 201 insertions(+), 7 deletions(-)

diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
index a25d238..8db9573 100644
--- a/pc-bios/s390-ccw/netboot.mak
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -24,8 +24,9 @@ CTYPE_OBJS = isdigit.o isxdigit.o toupper.o
 %.o : $(SLOF_DIR)/lib/libc/ctype/%.c
 	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
 
-STRING_OBJS = strcat.o strchr.o strcmp.o strcpy.o strlen.o strncmp.o strncpy.o \
-	      strstr.o memset.o memcpy.o memmove.o memcmp.o
+STRING_OBJS = strcasecmp.o strcat.o strchr.o strcmp.o strcpy.o strlen.o \
+	      strncasecmp.o strncmp.o strncpy.o strstr.o \
+	      memset.o memcpy.o memmove.o memcmp.o
 %.o : $(SLOF_DIR)/lib/libc/string/%.c
 	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
 
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index e11ed4e..fa62bfe 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -39,11 +39,17 @@
 
 extern char _start[];
 
+#define KERNEL_ADDR             ((void *)0L)
+#define KERNEL_MAX_SIZE         ((long)_start)
+#define ARCH_COMMAND_LINE_SIZE  896              /* Taken from Linux kernel */
+
 char stack[PAGE_SIZE * 8] __attribute__((aligned(PAGE_SIZE)));
 IplParameterBlock iplb __attribute__((aligned(PAGE_SIZE)));
+static char cfgbuf[2048];
 
 static SubChannelId net_schid = { .one = 1 };
 static int ip_version = 4;
+static uint8_t mac[6];
 static uint64_t dest_timer;
 
 static uint64_t get_timer_ms(void)
@@ -136,9 +142,15 @@ static int tftp_load(filename_ip_t *fnip, void *buffer, int len)
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
@@ -201,7 +213,6 @@ static int tftp_load(filename_ip_t *fnip, void *buffer, int len)
 
 static int net_init(filename_ip_t *fn_ip)
 {
-    uint8_t mac[6];
     int rc;
 
     memset(fn_ip, 0, sizeof(filename_ip_t));
@@ -276,6 +287,183 @@ static void net_uninit(filename_ip_t *fn_ip)
     virtio_net_uninit();
 }
 
+/* This structure holds the data from one pxelinux.cfg file entry */
+struct lkia {
+    const char *label;
+    const char *kernel;
+    const char *initrd;
+    const char *append;
+};
+
+static int load_kernel_with_initrd(filename_ip_t *fn_ip, struct lkia *kia)
+{
+    int rc;
+
+    printf("Loading pxelinux.cfg entry '%s'\n", kia->label);
+
+    if (!kia->kernel) {
+        printf("Kernel entry is missing!\n");
+        return -1;
+    }
+
+    strncpy((char *)&fn_ip->filename, kia->kernel, sizeof(fn_ip->filename));
+    rc = tftp_load(fn_ip, KERNEL_ADDR, KERNEL_MAX_SIZE);
+    if (rc < 0) {
+        return rc;
+    }
+
+    if (kia->initrd) {
+        uint64_t iaddr = (rc + 0xfff) & ~0xfffUL;
+
+        strncpy((char *)&fn_ip->filename, kia->initrd, sizeof(fn_ip->filename));
+        rc = tftp_load(fn_ip, (void *)iaddr, KERNEL_MAX_SIZE - iaddr);
+        if (rc < 0) {
+            return rc;
+        }
+        /* Patch location and size: */
+        *(uint64_t *)0x10408 = iaddr;
+        *(uint64_t *)0x10410 = rc;
+        rc += iaddr;
+    }
+
+    if (kia->append) {
+        strncpy((char *)0x10480, kia->append, ARCH_COMMAND_LINE_SIZE);
+    }
+
+    return rc;
+}
+
+#define MAX_PXELINUX_ENTRIES 16
+
+/**
+ * Parse a pxelinux-style configuration file.
+ * See the following URL for more inforation about the config file syntax:
+ * https://www.syslinux.org/wiki/index.php?title=PXELINUX
+ */
+static int handle_pxelinux_cfg(filename_ip_t *fn_ip, char *cfg, int cfgsize)
+{
+    struct lkia entries[MAX_PXELINUX_ENTRIES];
+    int num_entries = 0;
+    char *ptr = cfg, *eol, *arg;
+    char *defaultlabel = NULL;
+    int def_ent = 0;
+
+    while (ptr < cfg + cfgsize && num_entries < MAX_PXELINUX_ENTRIES) {
+        eol = strchr(ptr, '\n');
+        if (!eol) {
+            eol = cfg + cfgsize;
+        }
+        if (eol > ptr && *(eol - 1) == '\r') {
+            *(eol - 1) = 0;
+        }
+        *eol = '\0';
+        while (*ptr == ' ' || *ptr == '\t') {
+            ptr++;
+        }
+        if (*ptr == 0 || *ptr == '#') {   /* Ignore comments and empty lines */
+            goto nextline;
+        }
+        arg = strchr(ptr, ' ');    /* Look for space between command and arg */
+        if (!arg) {
+            arg = strchr(ptr, '\t');
+        }
+        if (!arg) {
+            printf("Failed to parse the following line:\n %s\n", ptr);
+            goto nextline;
+        }
+        *arg++ = 0;
+        while (*arg == ' ' || *arg == '\t') {
+            arg++;
+        }
+        if (!strcasecmp("default", ptr)) {
+            defaultlabel = arg;
+        } else if (!strcasecmp("label", ptr)) {
+            entries[num_entries].label = arg;
+            if (defaultlabel && !strcmp(arg, defaultlabel)) {
+                def_ent = num_entries;
+            }
+            num_entries++;
+        } else if (!strcasecmp("kernel", ptr)) {
+            entries[num_entries - 1].kernel = arg;
+        } else if (!strcasecmp("initrd", ptr)) {
+            entries[num_entries - 1].initrd = arg;
+        } else if (!strcasecmp("append", ptr)) {
+            entries[num_entries - 1].append = arg;
+        } else {
+            printf("Command '%s' is not supported.\n", ptr);
+        }
+nextline:
+        ptr = eol + 1;
+    }
+
+    return load_kernel_with_initrd(fn_ip, &entries[def_ent]);
+}
+
+static int net_try_pxelinux_cfgs(filename_ip_t *fn_ip)
+{
+    int rc, idx;
+
+    cfgbuf[sizeof(cfgbuf) - 1] = 0;   /* Make sure that it is NUL-terminated */
+
+    printf("Trying pxelinux.cfg files...\n");
+
+    /* Look for config file with MAC address in its name */
+    sprintf((char *)fn_ip->filename,
+            "pxelinux.cfg/%02x-%02x-%02x-%02x-%02x-%02x",
+            mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
+    rc = tftp_load(fn_ip, cfgbuf, sizeof(cfgbuf) - 1);
+    if (rc > 0) {
+        return handle_pxelinux_cfg(fn_ip, cfgbuf, sizeof(cfgbuf));
+    }
+
+    /* Look for config file with IP address in its name */
+    if (ip_version == 4) {
+        for (idx = 0; idx <= 7; idx++) {
+            sprintf((char *)fn_ip->filename,
+                    "pxelinux.cfg/%02X%02X%02X%02X",
+                    (fn_ip->own_ip >> 24) & 0xff, (fn_ip->own_ip >> 16) & 0xff,
+                    (fn_ip->own_ip >> 8) & 0xff, fn_ip->own_ip & 0xff);
+            fn_ip->filename[strlen((char *)fn_ip->filename) - idx] = 0;
+            rc = tftp_load(fn_ip, cfgbuf, sizeof(cfgbuf) - 1);
+            if (rc > 0) {
+                return handle_pxelinux_cfg(fn_ip, cfgbuf, sizeof(cfgbuf));
+            }
+        }
+    }
+
+    /* Try "default" config file */
+    strcpy((char *)fn_ip->filename, "pxelinux.cfg/default");
+    rc = tftp_load(fn_ip, cfgbuf, sizeof(cfgbuf) - 1);
+    if (rc > 0) {
+        return handle_pxelinux_cfg(fn_ip, cfgbuf, sizeof(cfgbuf));
+    }
+
+    return -1;
+}
+
+static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
+{
+    int rc;
+    void *baseaddr = (void *)0x2000;  /* Load right after the low-core */
+
+    rc = tftp_load(fn_ip, baseaddr, KERNEL_MAX_SIZE - (long)baseaddr);
+
+    if (rc > 0 && rc < sizeof(cfgbuf) - 1) {
+        /* Check whether it is a configuration file instead of a kernel */
+        memcpy(cfgbuf, baseaddr, rc);
+        cfgbuf[rc] = 0;    /* Make sure that it is NUL-terminated */
+        if (!strncasecmp("default", cfgbuf, 7) || !strncmp("# ", cfgbuf, 2)) {
+            /* Looks like it is a pxelinux.cfg */
+            return handle_pxelinux_cfg(fn_ip, cfgbuf, rc);
+        }
+    }
+
+    /* Move kernel to right location */
+    memmove(KERNEL_ADDR, baseaddr, rc);
+
+    return rc;
+}
+
 void panic(const char *string)
 {
     sclp_print(string);
@@ -360,7 +548,12 @@ void main(void)
         panic("Network initialization failed. Halting.\n");
     }
 
-    rc = tftp_load(&fn_ip, NULL, (long)_start);
+    if (strlen((char *)fn_ip.filename) > 0) {
+        rc = net_try_direct_tftp_load(&fn_ip);
+    }
+    if (rc <= 0) {
+        rc = net_try_pxelinux_cfgs(&fn_ip);
+    }
 
     net_uninit(&fn_ip);
 
-- 
1.8.3.1
