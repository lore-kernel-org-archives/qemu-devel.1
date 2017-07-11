Received: from eggs.gnu.org ([2001:4830:134:3::10]:54713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUvf2-00054T-7q
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUvf0-0004Go-QH
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:57:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dUvf0-0004GZ-Hg
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:57:06 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 11 Jul 2017 15:56:35 +0200
Message-Id: <1499781397-19749-10-git-send-email-thuth@redhat.com>
In-Reply-To: <1499781397-19749-1-git-send-email-thuth@redhat.com>
References: <1499781397-19749-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 09/11] pc-bios/s390-ccw: Add core files for
 the network bootloading program
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

This is just a preparation for the next steps: Add a makefile and a
stripped down copy of pc-bios/s390-ccw/main.c as a basis for the network
bootloader program, linked against the libc from SLOF already (which we
will need for SLOF's libnet). The networking code is not included yet.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/Makefile    |  11 +++-
 pc-bios/s390-ccw/netboot.mak |  41 +++++++++++++
 pc-bios/s390-ccw/netmain.c   | 137 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+), 2 deletions(-)
 create mode 100644 pc-bios/s390-ccw/netboot.mak
 create mode 100644 pc-bios/s390-ccw/netmain.c

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 82b41ef..cbae745 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -16,7 +16,7 @@ QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
 QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
 LDFLAGS += -Wl,-pie -nostdlib
 
-build-all: s390-ccw.img
+build-all: s390-ccw.img s390-netboot.img
 
 s390-ccw.elf: $(OBJECTS)
 	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $(OBJECTS),"BUILD","$(TARGET_DIR)$@")
@@ -28,5 +28,12 @@ s390-ccw.img: s390-ccw.elf
 
 $(OBJECTS): Makefile
 
+ifneq ($(wildcard $(SRC_PATH)/roms/SLOF/lib/libnet),)
+include $(SRC_PATH)/pc-bios/s390-ccw/netboot.mak
+else
+s390-netboot.img:
+	@echo "s390-netboot.img not built since roms/SLOF/ is not available."
+endif
+
 clean:
-	rm -f *.o *.d *.img *.elf *~
+	$(RM) *.o *.d *.img *.elf *~ *.a
diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
new file mode 100644
index 0000000..1eaa0d8
--- /dev/null
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -0,0 +1,41 @@
+
+SLOF_DIR := $(SRC_PATH)/roms/SLOF
+
+NETOBJS := start.o sclp.o virtio.o netmain.o sbrk.o libc.a
+
+LIBC_INC := -I$(SLOF_DIR)/lib/libc/include
+LIBNET_INC := -I$(SLOF_DIR)/lib/libnet
+
+NETLDFLAGS := $(LDFLAGS) -Ttext=0x7800000
+
+$(NETOBJS): CFLAGS += $(LIBC_INC) $(LIBNET_INC)
+
+s390-netboot.elf: $(NETOBJS)
+	$(call quiet-command,$(CC) $(NETLDFLAGS) -o $@ $(NETOBJS),"BUILD","$(TARGET_DIR)$@")
+
+s390-netboot.img: s390-netboot.elf
+	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
+
+
+LIBCCMNDIR = $(SLOF_DIR)/lib/libc
+STRINGCMNDIR = $(LIBCCMNDIR)/string
+CTYPECMNDIR = $(LIBCCMNDIR)/ctype
+STDLIBCMNDIR = $(LIBCCMNDIR)/stdlib
+STDIOCMNDIR = $(LIBCCMNDIR)/stdio
+
+include $(STRINGCMNDIR)/Makefile.inc
+include $(CTYPECMNDIR)/Makefile.inc
+include $(STDLIBCMNDIR)/Makefile.inc
+include $(STDIOCMNDIR)/Makefile.inc
+
+STDIO_OBJS = sprintf.o vfprintf.o vsnprintf.o vsprintf.o fprintf.o \
+	     printf.o putc.o puts.o putchar.o stdchnls.o fileno.o
+
+LIBCOBJS := $(STRING_OBJS) $(CTYPE_OBJS) $(STDLIB_OBJS) $(STDIO_OBJS)
+$(LIBCOBJS): CFLAGS += $(LIBC_INC) $(QEMU_CFLAGS)
+
+libc.a: $(LIBCOBJS)
+	$(call quiet-command,$(AR) -rc $@ $^,"AR","$(TARGET_DIR)$@")
+
+sbrk.o: $(SLOF_DIR)/slof/sbrk.c
+	$(call quiet-command,$(CC) $(QEMU_CFLAGS) $(LIBC_INC) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
new file mode 100644
index 0000000..d604623
--- /dev/null
+++ b/pc-bios/s390-ccw/netmain.c
@@ -0,0 +1,137 @@
+/*
+ * S390 virtio-ccw network boot loading program
+ *
+ * Copyright 2017 Thomas Huth, Red Hat Inc.
+ *
+ * Based on the S390 virtio-ccw loading program (main.c)
+ * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <time.h>
+
+#include "s390-ccw.h"
+#include "virtio.h"
+
+extern char _start[];
+
+char stack[PAGE_SIZE * 8] __attribute__((aligned(PAGE_SIZE)));
+IplParameterBlock iplb __attribute__((aligned(PAGE_SIZE)));
+
+static SubChannelId net_schid = { .one = 1 };
+static uint64_t dest_timer;
+
+static uint64_t get_timer_ms(void)
+{
+    uint64_t clk;
+
+    asm volatile(" stck %0 " : : "Q"(clk) : "memory");
+
+    /* Bit 51 is incrememented each microsecond */
+    return (clk >> (63 - 51)) / 1000;
+}
+
+void set_timer(int val)
+{
+    dest_timer = get_timer_ms() + val;
+}
+
+int get_timer(void)
+{
+    return dest_timer - get_timer_ms();
+}
+
+int get_sec_ticks(void)
+{
+    return 1000;    /* number of ticks in 1 second */
+}
+
+void panic(const char *string)
+{
+    sclp_print(string);
+    for (;;) {
+        disabled_wait();
+    }
+}
+
+static bool find_net_dev(Schib *schib, int dev_no)
+{
+    int i, r;
+
+    for (i = 0; i < 0x10000; i++) {
+        net_schid.sch_no = i;
+        r = stsch_err(net_schid, schib);
+        if (r == 3 || r == -EIO) {
+            break;
+        }
+        if (!schib->pmcw.dnv) {
+            continue;
+        }
+        if (!virtio_is_supported(net_schid)) {
+            continue;
+        }
+        if (virtio_get_device_type() != VIRTIO_ID_NET) {
+            continue;
+        }
+        if (dev_no < 0 || schib->pmcw.dev == dev_no) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static void virtio_setup(void)
+{
+    Schib schib;
+    int ssid;
+    bool found = false;
+    uint16_t dev_no;
+
+    /*
+     * We unconditionally enable mss support. In every sane configuration,
+     * this will succeed; and even if it doesn't, stsch_err() can deal
+     * with the consequences.
+     */
+    enable_mss_facility();
+
+    if (store_iplb(&iplb)) {
+        IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
+        dev_no = iplb.ccw.devno;
+        debug_print_int("device no. ", dev_no);
+        net_schid.ssid = iplb.ccw.ssid & 0x3;
+        debug_print_int("ssid ", net_schid.ssid);
+        found = find_net_dev(&schib, dev_no);
+    } else {
+        for (ssid = 0; ssid < 0x3; ssid++) {
+            net_schid.ssid = ssid;
+            found = find_net_dev(&schib, -1);
+            if (found) {
+                break;
+            }
+        }
+    }
+
+    IPL_assert(found && virtio_get_device_type() == VIRTIO_ID_NET,
+               "No virtio net device found");
+}
+
+void main(void)
+{
+    sclp_setup();
+    sclp_print("Network boot starting...\n");
+
+    virtio_setup();
+
+    panic("Failed to load OS from network\n");
+}
-- 
1.8.3.1
