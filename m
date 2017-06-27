Received: from eggs.gnu.org ([2001:4830:134:3::10]:54682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPoyv-0007rk-E4
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPoyt-0003dw-Nm
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPoyt-0003dq-FC
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:31 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 27 Jun 2017 13:48:08 +0200
Message-Id: <1498564100-10045-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 02/14] pc-bios/s390-ccw: Start using the
 libc from SLOF
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

Change the Makefiles to make the libc compilable within the
s390-ccw firmware build system, link it and start using it by
switching the implementations of the memset() and memcpy()
functions to the ones from the libc.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure                                 |  5 ++--
 pc-bios/s390-ccw/Makefile                 |  8 ++++++-
 pc-bios/s390-ccw/bootmap.h                |  1 +
 pc-bios/s390-ccw/libc/Makefile            | 38 ++++++++++---------------------
 pc-bios/s390-ccw/libc/ctype/Makefile.inc  |  3 ++-
 pc-bios/s390-ccw/libc/stdio/Makefile.inc  |  9 ++++----
 pc-bios/s390-ccw/libc/stdlib/Makefile.inc |  3 ++-
 pc-bios/s390-ccw/libc/string/Makefile.inc |  3 ++-
 pc-bios/s390-ccw/s390-ccw.h               | 30 +++---------------------
 9 files changed, 37 insertions(+), 63 deletions(-)

diff --git a/configure b/configure
index c571ad1..954c286 100755
--- a/configure
+++ b/configure
@@ -6377,7 +6377,8 @@ fi
 # build tree in object directory in case the source is not in the current directory
 DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests"
 DIRS="$DIRS docs docs/interop fsdev"
-DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
+DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas"
+DIRS="$DIRS pc-bios/s390-ccw pc-bios/s390-ccw/libc"
 DIRS="$DIRS roms/seabios roms/vgabios"
 DIRS="$DIRS qapi-generated"
 FILES="Makefile tests/tcg/Makefile qdict-test-data.txt"
@@ -6385,7 +6386,7 @@ FILES="$FILES tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
 FILES="$FILES tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
 FILES="$FILES pc-bios/optionrom/Makefile pc-bios/keymaps"
 FILES="$FILES pc-bios/spapr-rtas/Makefile"
-FILES="$FILES pc-bios/s390-ccw/Makefile"
+FILES="$FILES pc-bios/s390-ccw/Makefile pc-bios/s390-ccw/libc/Makefile"
 FILES="$FILES roms/seabios/Makefile roms/vgabios/Makefile"
 FILES="$FILES pc-bios/qemu-icon.bmp"
 FILES="$FILES .gdbinit scripts" # scripts needed by relative path in .gdbinit
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index fb88c13..3371c5b 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -7,12 +7,14 @@ include $(SRC_PATH)/rules.mak
 
 $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 
-.PHONY : all clean build-all
+.PHONY : all clean build-all libc.a
 
 OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o
+OBJECTS += libc.a
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
 QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
+QEMU_CFLAGS += -I$(SRC_PATH)/pc-bios/s390-ccw/libc/include
 QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
 LDFLAGS += -Wl,-pie -nostdlib
 
@@ -21,6 +23,9 @@ build-all: s390-ccw.img
 s390-ccw.elf: $(OBJECTS)
 	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $(OBJECTS),"BUILD","$(TARGET_DIR)$@")
 
+libc.a:
+	@$(MAKE) -C libc V="$(V)"
+
 STRIP ?= strip
 
 s390-ccw.img: s390-ccw.elf
@@ -30,3 +35,4 @@ $(OBJECTS): Makefile
 
 clean:
 	rm -f *.o *.d *.img *.elf *~
+	@$(MAKE) -C libc clean
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 7f36782..608bb5d 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -11,6 +11,7 @@
 #ifndef _PC_BIOS_S390_CCW_BOOTMAP_H
 #define _PC_BIOS_S390_CCW_BOOTMAP_H
 
+#include <stddef.h>
 #include "s390-ccw.h"
 #include "virtio.h"
 
diff --git a/pc-bios/s390-ccw/libc/Makefile b/pc-bios/s390-ccw/libc/Makefile
index 0c762ec..12f57e8 100644
--- a/pc-bios/s390-ccw/libc/Makefile
+++ b/pc-bios/s390-ccw/libc/Makefile
@@ -10,52 +10,38 @@
 # *     IBM Corporation - initial implementation
 # ****************************************************************************/
 
-TOPCMNDIR ?= ../..
+include ../../../config-host.mak
+include $(SRC_PATH)/rules.mak
 
-LIBCCMNDIR = $(shell pwd)
+LIBCCMNDIR = $(SRC_PATH)/pc-bios/s390-ccw/libc
 STRINGCMNDIR = $(LIBCCMNDIR)/string
 CTYPECMNDIR = $(LIBCCMNDIR)/ctype
 STDLIBCMNDIR = $(LIBCCMNDIR)/stdlib
 STDIOCMNDIR = $(LIBCCMNDIR)/stdio
-GETOPTCMNDIR = $(LIBCCMNDIR)/getopt
 
-include $(TOPCMNDIR)/make.rules
-
-
-CPPFLAGS = -I$(LIBCCMNDIR)/include
-LDFLAGS= -nostdlib
+QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
+QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
+QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
+QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
+QEMU_CFLAGS += -I$(LIBCCMNDIR)/include
+LDFLAGS += -Wl,-pie -nostdlib
 
 TARGET = ../libc.a
 
-
 all: $(TARGET)
 
-# Use the following target to build a native version of the lib
-# (for example for debugging purposes):
-native:
-	$(MAKE) CROSS="" CC=$(HOSTCC) NATIVEBUILD=1
-
-
 include $(STRINGCMNDIR)/Makefile.inc
 include $(CTYPECMNDIR)/Makefile.inc
 include $(STDLIBCMNDIR)/Makefile.inc
 include $(STDIOCMNDIR)/Makefile.inc
-include $(GETOPTCMNDIR)/Makefile.inc
-
-OBJS = $(STRING_OBJS) $(CTYPE_OBJS) $(STDLIB_OBJS) $(STDIO_OBJS) $(GETOPT_OBJS)
 
-ifneq ($(NATIVEBUILD),1)
-# These parts of the libc use assembler, so they can only be compiled when
-# we are _not_ building a native version.
-endif
+OBJS = $(STRING_OBJS) $(CTYPE_OBJS) $(STDLIB_OBJS) $(STDIO_OBJS)
 
 
 $(TARGET): $(OBJS)
-	$(AR) -rc $@ $(OBJS)
-	$(RANLIB) $@
-
+	$(call quiet-command,$(AR) -rc $@ $(OBJS),"AR","$(TARGET_DIR)$@")
 
 clean:
-	$(RM) $(TARGET) $(OBJS)
+	rm -f $(TARGET) $(OBJS)
 
 distclean: clean
diff --git a/pc-bios/s390-ccw/libc/ctype/Makefile.inc b/pc-bios/s390-ccw/libc/ctype/Makefile.inc
index 25513a9..6d4bec3 100644
--- a/pc-bios/s390-ccw/libc/ctype/Makefile.inc
+++ b/pc-bios/s390-ccw/libc/ctype/Makefile.inc
@@ -17,4 +17,5 @@ CTYPE_SRCS = $(CTYPE_SRC_C:%=$(CTYPECMNDIR)/%) $(CTYPE_SRC_ASM:%=$(CTYPECMNDIR)/
 CTYPE_OBJS = $(CTYPE_SRC_C:%.c=%.o) $(CTYPE_SRC_ASM:%.S=%.o)
 
 %.o : $(CTYPECMNDIR)/%.c
-	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@
+	$(call quiet-command,$(CC) $(QEMU_CFLAGS) $(CFLAGS) $($@-cflags) \
+		-c -o $@ $<,"CC","$(TARGET_DIR)$@")
diff --git a/pc-bios/s390-ccw/libc/stdio/Makefile.inc b/pc-bios/s390-ccw/libc/stdio/Makefile.inc
index ac5302d..1281b57 100644
--- a/pc-bios/s390-ccw/libc/stdio/Makefile.inc
+++ b/pc-bios/s390-ccw/libc/stdio/Makefile.inc
@@ -11,13 +11,14 @@
 # ****************************************************************************/
 
 
-STDIO_SRC_C = fscanf.c sprintf.c vfprintf.c vsnprintf.c vsprintf.c fprintf.c \
-	      printf.c setvbuf.c putc.c puts.c putchar.c scanf.c stdchnls.c \
-	      vfscanf.c vsscanf.c fileno.c
+STDIO_SRC_C = sprintf.c vfprintf.c vsnprintf.c vsprintf.c fprintf.c \
+	      printf.c setvbuf.c putc.c puts.c putchar.c stdchnls.c \
+	      fileno.c
 
 STDIO_SRC_ASM = 
 STDIO_SRCS = $(STDIO_SRC_C:%=$(STDIOCMNDIR)/%) $(STDIO_SRC_ASM:%=$(STDIOCMNDIR)/%)
 STDIO_OBJS = $(STDIO_SRC_C:%.c=%.o) $(STDIO_SRC_ASM:%.S=%.o)
 
 %.o : $(STDIOCMNDIR)/%.c
-	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@
+	$(call quiet-command,$(CC) $(QEMU_CFLAGS) $(CFLAGS) $($@-cflags) \
+		-c -o $@ $<,"CC","$(TARGET_DIR)$@")
diff --git a/pc-bios/s390-ccw/libc/stdlib/Makefile.inc b/pc-bios/s390-ccw/libc/stdlib/Makefile.inc
index 702f6d7..4b3cd67 100644
--- a/pc-bios/s390-ccw/libc/stdlib/Makefile.inc
+++ b/pc-bios/s390-ccw/libc/stdlib/Makefile.inc
@@ -19,4 +19,5 @@ STDLIB_SRCS = $(STDLIB_SRC_C:%=$(STDLIBCMNDIR)/%) $(STDLIB_SRC_ASM:%=$(STDLIBCMN
 STDLIB_OBJS = $(STDLIB_SRC_C:%.c=%.o) $(STDLIB_SRC_ASM:%.S=%.o)
 
 %.o : $(STDLIBCMNDIR)/%.c
-	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@
+	$(call quiet-command,$(CC) $(QEMU_CFLAGS) $(CFLAGS) $($@-cflags) \
+		-c -o $@ $<,"CC","$(TARGET_DIR)$@")
diff --git a/pc-bios/s390-ccw/libc/string/Makefile.inc b/pc-bios/s390-ccw/libc/string/Makefile.inc
index 7ccf3c4..82cc734 100644
--- a/pc-bios/s390-ccw/libc/string/Makefile.inc
+++ b/pc-bios/s390-ccw/libc/string/Makefile.inc
@@ -19,4 +19,5 @@ STRING_SRCS = $(STRING_SRC_C:%=$(STRINGCMNDIR)/%) $(STRING_SRC_ASM:%=$(STRINGCMN
 STRING_OBJS = $(STRING_SRC_C:%.c=%.o) $(STRING_SRC_ASM:%.S=%.o)
 
 %.o : $(STRINGCMNDIR)/%.c
-	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@
+	$(call quiet-command,$(CC) $(QEMU_CFLAGS) $(CFLAGS) $($@-cflags) \
+		-c -o $@ $<,"CC","$(TARGET_DIR)$@")
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 2089274..410d9ac 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -11,6 +11,8 @@
 #ifndef S390_CCW_H
 #define S390_CCW_H
 
+#include <string.h>
+
 /* #define DEBUG */
 
 typedef unsigned char      u8;
@@ -18,7 +20,6 @@ typedef unsigned short     u16;
 typedef unsigned int       u32;
 typedef unsigned long long u64;
 typedef unsigned long      ulong;
-typedef long               size_t;
 typedef int                bool;
 typedef unsigned char      uint8_t;
 typedef unsigned short     uint16_t;
@@ -39,9 +40,7 @@ typedef unsigned long long __u64;
 #ifndef EBUSY
 #define EBUSY   2
 #endif
-#ifndef NULL
-#define NULL    0
-#endif
+
 #ifndef MIN
 #define MIN(a, b) (((a) < (b)) ? (a) : (b))
 #endif
@@ -88,18 +87,6 @@ ulong get_second(void);
 /* bootmap.c */
 void zipl_load(void);
 
-static inline void *memset(void *s, int c, size_t n)
-{
-    int i;
-    unsigned char *p = s;
-
-    for (i = 0; i < n; i++) {
-        p[i] = c;
-    }
-
-    return s;
-}
-
 static inline void fill_hex(char *out, unsigned char val)
 {
     const char hex[] = "0123456789abcdef";
@@ -169,17 +156,6 @@ static inline void sleep(unsigned int seconds)
     }
 }
 
-static inline void *memcpy(void *s1, const void *s2, size_t n)
-{
-    uint8_t *p1 = s1;
-    const uint8_t *p2 = s2;
-
-    while (n--) {
-        p1[n] = p2[n];
-    }
-    return s1;
-}
-
 static inline void IPL_assert(bool term, const char *message)
 {
     if (!term) {
-- 
1.8.3.1
