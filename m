Received: from eggs.gnu.org ([2001:4830:134:3::10]:54961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPozI-0008Fl-5i
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPozG-0003w2-NZ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPozG-0003vk-HV
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:54 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 27 Jun 2017 13:48:16 +0200
Message-Id: <1498564100-10045-11-git-send-email-thuth@redhat.com>
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 10/14] pc-bios/s390-ccw: Add timer code for
 the libnet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Jens Freimann <jfreiman@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

The libnet expects certain timer functions to exist, so that it
is able to deal with timeouts etc.
This patch implements these timer functions via the STORE CLOCK (stck)
CPU instruction.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/libnet/Makefile |  2 +-
 pc-bios/s390-ccw/libnet/timer.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/s390-ccw/libnet/timer.c

diff --git a/pc-bios/s390-ccw/libnet/Makefile b/pc-bios/s390-ccw/libnet/Makefile
index 72e12d7..c8235f3 100644
--- a/pc-bios/s390-ccw/libnet/Makefile
+++ b/pc-bios/s390-ccw/libnet/Makefile
@@ -24,7 +24,7 @@ QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
 LDFLAGS += -Wl,-pie -nostdlib
 
 SRCS =	ethernet.c ipv4.c udp.c tcp.c dns.c dhcp.c tftp.c \
-	ipv6.c dhcpv6.c icmpv6.c ndp.c netload.c args.c
+	ipv6.c dhcpv6.c icmpv6.c ndp.c netload.c args.c timer.c
 
 OBJS = $(SRCS:%.c=%.o)
 
diff --git a/pc-bios/s390-ccw/libnet/timer.c b/pc-bios/s390-ccw/libnet/timer.c
new file mode 100644
index 0000000..ddbd7a2
--- /dev/null
+++ b/pc-bios/s390-ccw/libnet/timer.c
@@ -0,0 +1,40 @@
+/*
+ * Timer functions for libnet
+ *
+ * Copyright 2017 Thomas Huth, Red Hat Inc.
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <stdint.h>
+#include "time.h"
+
+static uint64_t dest_timer;
+
+static uint64_t get_timer_ms(void)
+{
+	uint64_t clk;
+
+	asm volatile(" stck %0 " : : "Q"(clk) : "memory");
+
+	/* Bit 51 is incrememented each microsecond */
+	return (clk >> (63 - 51)) / 1000;
+}
+
+void set_timer(int val)
+{
+	dest_timer = get_timer_ms() + val;
+}
+
+int get_timer(void)
+{
+	return dest_timer - get_timer_ms();
+}
+
+int get_sec_ticks(void)
+{
+	return 1000;    /* number of ticks in 1 second */
+}
-- 
1.8.3.1
