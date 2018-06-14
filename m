Received: from eggs.gnu.org ([2001:4830:134:3::10]:40075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTTd9-0007AW-SO
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTTd5-0006W3-Pz
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:53:43 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 14 Jun 2018 16:53:22 +0200
Message-Id: <1528988003-21855-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1528988003-21855-1-git-send-email-thuth@redhat.com>
References: <1528988003-21855-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 6/7] pc-bios/s390-ccw: Optimize
 the s390-netboot.img for size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

The -O2 optimization flag is passed via CFLAGS to the firmware Makefile,
but in netbook.mak, we've got some rules that only use QEMU_CFLAGS for
compiling the libc and libnet from SLOF, so these files get compiled
without optimization so far. Use CFLAGS here, too, to create faster
and smaller code.

We can additionally save some more bytes in the firmware images by compi-
ling the code with -fno-asynchronous-unwind-tables. This will omit some
ELF sections (used for stack unwinding for example) from the image that
we do not need in the firmware.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/Makefile    | 1 +
 pc-bios/s390-ccw/netboot.mak | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 439e3cc..1eb316b 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -15,6 +15,7 @@ OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
 QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
+QEMU_CFLAGS += -fno-asynchronous-unwind-tables
 QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
 LDFLAGS += -Wl,-pie -nostdlib
 
diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
index 8af0cfd..14e96b2 100644
--- a/pc-bios/s390-ccw/netboot.mak
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -19,7 +19,7 @@ s390-netboot.img: s390-netboot.elf
 
 # libc files:
 
-LIBC_CFLAGS :=  $(QEMU_CFLAGS) $(LIBC_INC) $(LIBNET_INC)
+LIBC_CFLAGS :=  $(QEMU_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC)
 
 CTYPE_OBJS = isdigit.o isxdigit.o toupper.o
 %.o : $(SLOF_DIR)/lib/libc/ctype/%.c
@@ -52,7 +52,7 @@ libc.a: $(LIBCOBJS)
 
 LIBNETOBJS := args.o dhcp.o dns.o icmpv6.o ipv6.o tcp.o udp.o bootp.o \
 	      dhcpv6.o ethernet.o ipv4.o ndp.o tftp.o pxelinux.o
-LIBNETCFLAGS := $(QEMU_CFLAGS) -DDHCPARCH=0x1F $(LIBC_INC) $(LIBNET_INC)
+LIBNETCFLAGS := $(QEMU_CFLAGS) $(CFLAGS) -DDHCPARCH=0x1F $(LIBC_INC) $(LIBNET_INC)
 
 %.o : $(SLOF_DIR)/lib/libnet/%.c
 	$(call quiet-command,$(CC) $(LIBNETCFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-- 
1.8.3.1
