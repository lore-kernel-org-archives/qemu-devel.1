Received: from eggs.gnu.org ([2001:4830:134:3::10]:55744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyNv-000708-K1
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyNs-0003Qb-FP
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:03:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40935
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyNs-0003QE-9K
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:03:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EB1mWS068790
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:03:43 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpmhws8gm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:03:43 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:03:41 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:40:53 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-27-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 26/40] pc-bios/s390-ccw: Add core files for the
 network bootloading program
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Thomas Huth <thuth@redhat.com>

This is just a preparation for the next steps: Add a makefile and a
stripped down copy of pc-bios/s390-ccw/main.c as a basis for the network
bootloader program, linked against the libc from SLOF already (which we
will need for SLOF's libnet). The networking code is not included yet.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1499863793-18627-10-git-send-email-thuth@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 pc-bios/s390-ccw/Makefile    |  11 +++-
 pc-bios/s390-ccw/netboot.mak |  47 +++++++++++++++
 pc-bios/s390-ccw/netmain.c   | 136 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+), 2 deletions(-)
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
index 0000000..44b7645
--- /dev/null
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -0,0 +1,47 @@
+
+SLOF_DIR := $(SRC_PATH)/roms/SLOF
+
+NETOBJS := start.o sclp.o virtio.o netmain.o libc.a
+
+LIBC_INC := -nostdinc -I$(SLOF_DIR)/lib/libc/include
+LIBNET_INC := -I$(SLOF_DIR)/lib/libnet
+
+NETLDFLAGS := $(LDFLAGS) -Ttext=0x7800000
+
+$(NETOBJS): QEMU_CFLAGS += $(LIBC_INC) $(LIBNET_INC)
+
+s390-netboot.elf: $(NETOBJS)
+	$(call quiet-command,$(CC) $(NETLDFLAGS) -o $@ $(NETOBJS),"BUILD","$(TARGET_DIR)$@")
+
+s390-netboot.img: s390-netboot.elf
+	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
+
+# libc files:
+
+LIBC_CFLAGS :=  $(QEMU_CFLAGS) $(LIBC_INC) $(LIBNET_INC)
+
+CTYPE_OBJS = isdigit.o isxdigit.o toupper.o
+%.o : $(SLOF_DIR)/lib/libc/ctype/%.c
+	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+STRING_OBJS = strcat.o strchr.o strcmp.o strcpy.o strlen.o strncmp.o strncpy.o \
+	      strstr.o memset.o memcpy.o memmove.o memcmp.o
+%.o : $(SLOF_DIR)/lib/libc/string/%.c
+	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+STDLIB_OBJS = atoi.o atol.o strtoul.o strtol.o rand.o malloc.o free.o
+%.o : $(SLOF_DIR)/lib/libc/stdlib/%.c
+	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+STDIO_OBJS = sprintf.o vfprintf.o vsnprintf.o vsprintf.o fprintf.o \
+	     printf.o putc.o puts.o putchar.o stdchnls.o fileno.o
+%.o : $(SLOF_DIR)/lib/libc/stdio/%.c
+	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+sbrk.o: $(SLOF_DIR)/slof/sbrk.c
+	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+LIBCOBJS := $(STRING_OBJS) $(CTYPE_OBJS) $(STDLIB_OBJS) $(STDIO_OBJS) sbrk.o
+
+libc.a: $(LIBCOBJS)
+	$(call quiet-command,$(AR) -rc $@ $^,"AR","$(TARGET_DIR)$@")
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
new file mode 100644
index 0000000..a69b3dd
--- /dev/null
+++ b/pc-bios/s390-ccw/netmain.c
@@ -0,0 +1,136 @@
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
+    /* Bit 51 is incremented each microsecond */
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
+    IPL_assert(found, "No virtio net device found");
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
2.7.4
