Received: from eggs.gnu.org ([2001:4830:134:3::10]:54750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPoz0-0007xN-Vx
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPoyr-0003dY-Mp
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPoyr-0003dF-6f
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:29 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 27 Jun 2017 13:48:07 +0200
Message-Id: <1498564100-10045-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 01/14] pc-bios/s390-ccw: Add the libc from
 the SLOF firmware
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

To be able to use some more advanced libc functions in the s390-ccw
firmware, like printf() and malloc(), we need a better libc here.
This patch adds the C library from the SLOF firmware (taken from
the SLOF commit ID 62674aabe20612a9786fa03e87cf6916ba97a99a). The
files are copied without modifications here and will be adapted for
the s390-ccw firmware by the next patch. I just removed the getopt()
and scanf()-like functions from the libc since we likely do not need
them in the s390-ccw firmware.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/libc/Makefile             |  61 ++++++
 pc-bios/s390-ccw/libc/README.txt           |  49 +++++
 pc-bios/s390-ccw/libc/ctype/Makefile.inc   |  20 ++
 pc-bios/s390-ccw/libc/ctype/isdigit.c      |  25 +++
 pc-bios/s390-ccw/libc/ctype/isprint.c      |  18 ++
 pc-bios/s390-ccw/libc/ctype/isspace.c      |  29 +++
 pc-bios/s390-ccw/libc/ctype/isxdigit.c     |  21 ++
 pc-bios/s390-ccw/libc/ctype/tolower.c      |  18 ++
 pc-bios/s390-ccw/libc/ctype/toupper.c      |  21 ++
 pc-bios/s390-ccw/libc/include/ctype.h      |  24 +++
 pc-bios/s390-ccw/libc/include/errno.h      |  34 ++++
 pc-bios/s390-ccw/libc/include/limits.h     |  32 ++++
 pc-bios/s390-ccw/libc/include/stdarg.h     |  22 +++
 pc-bios/s390-ccw/libc/include/stdbool.h    |  20 ++
 pc-bios/s390-ccw/libc/include/stddef.h     |  25 +++
 pc-bios/s390-ccw/libc/include/stdint.h     |  28 +++
 pc-bios/s390-ccw/libc/include/stdio.h      |  63 ++++++
 pc-bios/s390-ccw/libc/include/stdlib.h     |  34 ++++
 pc-bios/s390-ccw/libc/include/string.h     |  37 ++++
 pc-bios/s390-ccw/libc/include/sys/socket.h |  53 +++++
 pc-bios/s390-ccw/libc/include/unistd.h     |  28 +++
 pc-bios/s390-ccw/libc/stdio/Makefile.inc   |  23 +++
 pc-bios/s390-ccw/libc/stdio/fileno.c       |  19 ++
 pc-bios/s390-ccw/libc/stdio/fprintf.c      |  26 +++
 pc-bios/s390-ccw/libc/stdio/printf.c       |  27 +++
 pc-bios/s390-ccw/libc/stdio/putc.c         |  25 +++
 pc-bios/s390-ccw/libc/stdio/putchar.c      |  21 ++
 pc-bios/s390-ccw/libc/stdio/puts.c         |  28 +++
 pc-bios/s390-ccw/libc/stdio/setvbuf.c      |  28 +++
 pc-bios/s390-ccw/libc/stdio/sprintf.c      |  30 +++
 pc-bios/s390-ccw/libc/stdio/stdchnls.c     |  23 +++
 pc-bios/s390-ccw/libc/stdio/vfprintf.c     |  27 +++
 pc-bios/s390-ccw/libc/stdio/vsnprintf.c    | 298 +++++++++++++++++++++++++++++
 pc-bios/s390-ccw/libc/stdio/vsprintf.c     |  19 ++
 pc-bios/s390-ccw/libc/stdlib/Makefile.inc  |  22 +++
 pc-bios/s390-ccw/libc/stdlib/atoi.c        |  18 ++
 pc-bios/s390-ccw/libc/stdlib/atol.c        |  18 ++
 pc-bios/s390-ccw/libc/stdlib/error.c       |  15 ++
 pc-bios/s390-ccw/libc/stdlib/free.c        |  26 +++
 pc-bios/s390-ccw/libc/stdlib/malloc.c      | 157 +++++++++++++++
 pc-bios/s390-ccw/libc/stdlib/malloc_defs.h |  16 ++
 pc-bios/s390-ccw/libc/stdlib/memalign.c    |  26 +++
 pc-bios/s390-ccw/libc/stdlib/rand.c        |  29 +++
 pc-bios/s390-ccw/libc/stdlib/realloc.c     |  40 ++++
 pc-bios/s390-ccw/libc/stdlib/strtol.c      | 115 +++++++++++
 pc-bios/s390-ccw/libc/stdlib/strtoul.c     | 105 ++++++++++
 pc-bios/s390-ccw/libc/string/Makefile.inc  |  22 +++
 pc-bios/s390-ccw/libc/string/memchr.c      |  29 +++
 pc-bios/s390-ccw/libc/string/memcmp.c      |  30 +++
 pc-bios/s390-ccw/libc/string/memcpy.c      |  27 +++
 pc-bios/s390-ccw/libc/string/memmove.c     |  42 ++++
 pc-bios/s390-ccw/libc/string/memset.c      |  25 +++
 pc-bios/s390-ccw/libc/string/strcasecmp.c  |  28 +++
 pc-bios/s390-ccw/libc/string/strcat.c      |  24 +++
 pc-bios/s390-ccw/libc/string/strchr.c      |  28 +++
 pc-bios/s390-ccw/libc/string/strcmp.c      |  28 +++
 pc-bios/s390-ccw/libc/string/strcpy.c      |  25 +++
 pc-bios/s390-ccw/libc/string/strlen.c      |  27 +++
 pc-bios/s390-ccw/libc/string/strncasecmp.c |  32 ++++
 pc-bios/s390-ccw/libc/string/strncmp.c     |  31 +++
 pc-bios/s390-ccw/libc/string/strncpy.c     |  33 ++++
 pc-bios/s390-ccw/libc/string/strstr.c      |  37 ++++
 pc-bios/s390-ccw/libc/string/strtok.c      |  45 +++++
 63 files changed, 2356 insertions(+)
 create mode 100644 pc-bios/s390-ccw/libc/Makefile
 create mode 100644 pc-bios/s390-ccw/libc/README.txt
 create mode 100644 pc-bios/s390-ccw/libc/ctype/Makefile.inc
 create mode 100644 pc-bios/s390-ccw/libc/ctype/isdigit.c
 create mode 100644 pc-bios/s390-ccw/libc/ctype/isprint.c
 create mode 100644 pc-bios/s390-ccw/libc/ctype/isspace.c
 create mode 100644 pc-bios/s390-ccw/libc/ctype/isxdigit.c
 create mode 100644 pc-bios/s390-ccw/libc/ctype/tolower.c
 create mode 100644 pc-bios/s390-ccw/libc/ctype/toupper.c
 create mode 100644 pc-bios/s390-ccw/libc/include/ctype.h
 create mode 100644 pc-bios/s390-ccw/libc/include/errno.h
 create mode 100644 pc-bios/s390-ccw/libc/include/limits.h
 create mode 100644 pc-bios/s390-ccw/libc/include/stdarg.h
 create mode 100644 pc-bios/s390-ccw/libc/include/stdbool.h
 create mode 100644 pc-bios/s390-ccw/libc/include/stddef.h
 create mode 100644 pc-bios/s390-ccw/libc/include/stdint.h
 create mode 100644 pc-bios/s390-ccw/libc/include/stdio.h
 create mode 100644 pc-bios/s390-ccw/libc/include/stdlib.h
 create mode 100644 pc-bios/s390-ccw/libc/include/string.h
 create mode 100644 pc-bios/s390-ccw/libc/include/sys/socket.h
 create mode 100644 pc-bios/s390-ccw/libc/include/unistd.h
 create mode 100644 pc-bios/s390-ccw/libc/stdio/Makefile.inc
 create mode 100644 pc-bios/s390-ccw/libc/stdio/fileno.c
 create mode 100644 pc-bios/s390-ccw/libc/stdio/fprintf.c
 create mode 100644 pc-bios/s390-ccw/libc/stdio/printf.c
 create mode 100644 pc-bios/s390-ccw/libc/stdio/putc.c
 create mode 100644 pc-bios/s390-ccw/libc/stdio/putchar.c
 create mode 100644 pc-bios/s390-ccw/libc/stdio/puts.c
 create mode 100644 pc-bios/s390-ccw/libc/stdio/setvbuf.c
 create mode 100644 pc-bios/s390-ccw/libc/stdio/sprintf.c
 create mode 100644 pc-bios/s390-ccw/libc/stdio/stdchnls.c
 create mode 100644 pc-bios/s390-ccw/libc/stdio/vfprintf.c
 create mode 100644 pc-bios/s390-ccw/libc/stdio/vsnprintf.c
 create mode 100644 pc-bios/s390-ccw/libc/stdio/vsprintf.c
 create mode 100644 pc-bios/s390-ccw/libc/stdlib/Makefile.inc
 create mode 100644 pc-bios/s390-ccw/libc/stdlib/atoi.c
 create mode 100644 pc-bios/s390-ccw/libc/stdlib/atol.c
 create mode 100644 pc-bios/s390-ccw/libc/stdlib/error.c
 create mode 100644 pc-bios/s390-ccw/libc/stdlib/free.c
 create mode 100644 pc-bios/s390-ccw/libc/stdlib/malloc.c
 create mode 100644 pc-bios/s390-ccw/libc/stdlib/malloc_defs.h
 create mode 100644 pc-bios/s390-ccw/libc/stdlib/memalign.c
 create mode 100644 pc-bios/s390-ccw/libc/stdlib/rand.c
 create mode 100644 pc-bios/s390-ccw/libc/stdlib/realloc.c
 create mode 100644 pc-bios/s390-ccw/libc/stdlib/strtol.c
 create mode 100644 pc-bios/s390-ccw/libc/stdlib/strtoul.c
 create mode 100644 pc-bios/s390-ccw/libc/string/Makefile.inc
 create mode 100644 pc-bios/s390-ccw/libc/string/memchr.c
 create mode 100644 pc-bios/s390-ccw/libc/string/memcmp.c
 create mode 100644 pc-bios/s390-ccw/libc/string/memcpy.c
 create mode 100644 pc-bios/s390-ccw/libc/string/memmove.c
 create mode 100644 pc-bios/s390-ccw/libc/string/memset.c
 create mode 100644 pc-bios/s390-ccw/libc/string/strcasecmp.c
 create mode 100644 pc-bios/s390-ccw/libc/string/strcat.c
 create mode 100644 pc-bios/s390-ccw/libc/string/strchr.c
 create mode 100644 pc-bios/s390-ccw/libc/string/strcmp.c
 create mode 100644 pc-bios/s390-ccw/libc/string/strcpy.c
 create mode 100644 pc-bios/s390-ccw/libc/string/strlen.c
 create mode 100644 pc-bios/s390-ccw/libc/string/strncasecmp.c
 create mode 100644 pc-bios/s390-ccw/libc/string/strncmp.c
 create mode 100644 pc-bios/s390-ccw/libc/string/strncpy.c
 create mode 100644 pc-bios/s390-ccw/libc/string/strstr.c
 create mode 100644 pc-bios/s390-ccw/libc/string/strtok.c

diff --git a/pc-bios/s390-ccw/libc/Makefile b/pc-bios/s390-ccw/libc/Makefile
new file mode 100644
index 0000000..0c762ec
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/Makefile
@@ -0,0 +1,61 @@
+# *****************************************************************************
+# * Copyright (c) 2004, 2008 IBM Corporation
+# * All rights reserved.
+# * This program and the accompanying materials
+# * are made available under the terms of the BSD License
+# * which accompanies this distribution, and is available at
+# * http://www.opensource.org/licenses/bsd-license.php
+# *
+# * Contributors:
+# *     IBM Corporation - initial implementation
+# ****************************************************************************/
+
+TOPCMNDIR ?= ../..
+
+LIBCCMNDIR = $(shell pwd)
+STRINGCMNDIR = $(LIBCCMNDIR)/string
+CTYPECMNDIR = $(LIBCCMNDIR)/ctype
+STDLIBCMNDIR = $(LIBCCMNDIR)/stdlib
+STDIOCMNDIR = $(LIBCCMNDIR)/stdio
+GETOPTCMNDIR = $(LIBCCMNDIR)/getopt
+
+include $(TOPCMNDIR)/make.rules
+
+
+CPPFLAGS = -I$(LIBCCMNDIR)/include
+LDFLAGS= -nostdlib
+
+TARGET = ../libc.a
+
+
+all: $(TARGET)
+
+# Use the following target to build a native version of the lib
+# (for example for debugging purposes):
+native:
+	$(MAKE) CROSS="" CC=$(HOSTCC) NATIVEBUILD=1
+
+
+include $(STRINGCMNDIR)/Makefile.inc
+include $(CTYPECMNDIR)/Makefile.inc
+include $(STDLIBCMNDIR)/Makefile.inc
+include $(STDIOCMNDIR)/Makefile.inc
+include $(GETOPTCMNDIR)/Makefile.inc
+
+OBJS = $(STRING_OBJS) $(CTYPE_OBJS) $(STDLIB_OBJS) $(STDIO_OBJS) $(GETOPT_OBJS)
+
+ifneq ($(NATIVEBUILD),1)
+# These parts of the libc use assembler, so they can only be compiled when
+# we are _not_ building a native version.
+endif
+
+
+$(TARGET): $(OBJS)
+	$(AR) -rc $@ $(OBJS)
+	$(RANLIB) $@
+
+
+clean:
+	$(RM) $(TARGET) $(OBJS)
+
+distclean: clean
diff --git a/pc-bios/s390-ccw/libc/README.txt b/pc-bios/s390-ccw/libc/README.txt
new file mode 100644
index 0000000..eaafdf4
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/README.txt
@@ -0,0 +1,49 @@
+
+ Standard C library for the SLOF firmware project
+ ================================================
+
+To use this library, link your target against the "libc.a" archive.
+
+However, there are some prerequisites before you can use certain parts of the
+library:
+
+1) If you want to use malloc() and the like, you have to supply an implemen-
+   tation of sbrk() in your own code. malloc() uses sbrk() to get new, free
+   memory regions.
+   
+   Prototype:   void *sbrk(int incr);
+   Description: sbrk() increments the available data space by incr bytes and
+                returns a pointer to the start of the new area.
+   
+   See the man-page of sbrk for details about this function.
+
+2) Before you can use the stdio output functions like printf(), puts() and the
+   like, you have to provide a standard write() function in your code.
+   printf() and the like use write() to print out the strings to the standard
+   output.
+
+   Prototype:   ssize_t write(int fd, const void *buf, size_t cnt);
+   Description: Write cnt byte from the buffer buf to the stream associated
+                with the file descriptor fd.
+
+   The stdio functions will print their output to the stdout channel which is
+   assigned with the file descriptor 1 by default. Note that the stdio
+   functions will not use open() before calling write(), so if the stdout
+   cannel needs to be opened first, you should do that in your start-up code
+   before using the libc functions for the first time.
+   
+3) Before you can use the stdio input functions like scanf() and the
+   like, you have to provide a standard read() function in your code.
+   scanf() and the like use read() to get the characters from the standard
+   input.
+
+   Prototype:   ssize_t read(int fd, void *buf, size_t cnt);
+   Description: Read cnt byte from the stream associated with the file
+                descriptor fd and put them into the buffer buf.
+
+   The stdio functions will get their input from the stdin channel which is
+   assigned with the file descriptor 0 by default. Note that the stdio
+   functions will not use open() before calling read(), so if the stdin
+   cannel needs to be opened first, you should do that in your start-up code
+   before using the libc functions for the first time.
+   
diff --git a/pc-bios/s390-ccw/libc/ctype/Makefile.inc b/pc-bios/s390-ccw/libc/ctype/Makefile.inc
new file mode 100644
index 0000000..25513a9
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/ctype/Makefile.inc
@@ -0,0 +1,20 @@
+# *****************************************************************************
+# * Copyright (c) 2004, 2008 IBM Corporation
+# * All rights reserved.
+# * This program and the accompanying materials
+# * are made available under the terms of the BSD License
+# * which accompanies this distribution, and is available at
+# * http://www.opensource.org/licenses/bsd-license.php
+# *
+# * Contributors:
+# *     IBM Corporation - initial implementation
+# ****************************************************************************/
+
+
+CTYPE_SRC_C = isdigit.c isprint.c isspace.c isxdigit.c tolower.c toupper.c
+CTYPE_SRC_ASM = 
+CTYPE_SRCS = $(CTYPE_SRC_C:%=$(CTYPECMNDIR)/%) $(CTYPE_SRC_ASM:%=$(CTYPECMNDIR)/%)
+CTYPE_OBJS = $(CTYPE_SRC_C:%.c=%.o) $(CTYPE_SRC_ASM:%.S=%.o)
+
+%.o : $(CTYPECMNDIR)/%.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@
diff --git a/pc-bios/s390-ccw/libc/ctype/isdigit.c b/pc-bios/s390-ccw/libc/ctype/isdigit.c
new file mode 100644
index 0000000..62d08a1
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/ctype/isdigit.c
@@ -0,0 +1,25 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <ctype.h>
+
+int isdigit(int ch)
+{
+	switch (ch) {
+	 case '0': case '1': case '2': case '3': case '4':
+	 case '5': case '6': case '7': case '8': case '9':
+		return 1;
+	
+	 default:
+		return 0;
+	}
+}
diff --git a/pc-bios/s390-ccw/libc/ctype/isprint.c b/pc-bios/s390-ccw/libc/ctype/isprint.c
new file mode 100644
index 0000000..c74880f
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/ctype/isprint.c
@@ -0,0 +1,18 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <ctype.h>
+
+int isprint(int ch)
+{
+	return (ch >= 32 && ch < 127);
+}
diff --git a/pc-bios/s390-ccw/libc/ctype/isspace.c b/pc-bios/s390-ccw/libc/ctype/isspace.c
new file mode 100644
index 0000000..5123019
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/ctype/isspace.c
@@ -0,0 +1,29 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <ctype.h>
+
+int isspace(int ch)
+{
+	switch (ch) {
+	 case ' ':
+	 case '\f':
+	 case '\n':
+	 case '\r':
+	 case '\t':
+	 case '\v':
+		return 1;
+	
+	 default:
+		return 0;
+	}
+}
diff --git a/pc-bios/s390-ccw/libc/ctype/isxdigit.c b/pc-bios/s390-ccw/libc/ctype/isxdigit.c
new file mode 100644
index 0000000..9d323f3
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/ctype/isxdigit.c
@@ -0,0 +1,21 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <ctype.h>
+
+int isxdigit(int ch)
+{
+  return ( 
+      (ch >= '0' && ch <= '9') |
+      (ch >= 'A' && ch <= 'F') |
+      (ch >= 'a' && ch <= 'f') );
+}
diff --git a/pc-bios/s390-ccw/libc/ctype/tolower.c b/pc-bios/s390-ccw/libc/ctype/tolower.c
new file mode 100644
index 0000000..f775e90
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/ctype/tolower.c
@@ -0,0 +1,18 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <ctype.h>
+
+int tolower(int c) 
+{
+	return (((c >= 'A') && (c <= 'Z')) ? (c - 'A' + 'a' ) : c);
+}
diff --git a/pc-bios/s390-ccw/libc/ctype/toupper.c b/pc-bios/s390-ccw/libc/ctype/toupper.c
new file mode 100644
index 0000000..9bcee52
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/ctype/toupper.c
@@ -0,0 +1,21 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+
+#include "ctype.h"
+
+int toupper (int cha)
+{
+	if((cha >= 'a') && (cha <= 'z'))
+		return(cha - 'a' + 'A');
+	return(cha);
+}
diff --git a/pc-bios/s390-ccw/libc/include/ctype.h b/pc-bios/s390-ccw/libc/include/ctype.h
new file mode 100644
index 0000000..9051a75
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/include/ctype.h
@@ -0,0 +1,24 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#ifndef _CTYPE_H
+#define _CTYPE_H
+
+int isdigit(int c);
+int isxdigit(int c);
+int isprint(int c);
+int isspace(int c);
+
+int tolower(int c);
+int toupper(int c);
+
+#endif
diff --git a/pc-bios/s390-ccw/libc/include/errno.h b/pc-bios/s390-ccw/libc/include/errno.h
new file mode 100644
index 0000000..d585934
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/include/errno.h
@@ -0,0 +1,34 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#ifndef _ERRNO_H
+#define _ERRNO_H
+
+extern int errno;
+
+/*
+ * Error number definitions
+ */
+#define EPERM		1	/* not permitted */
+#define ENOENT		2	/* file or directory not found */
+#define EIO		5	/* input/output error */
+#define ENOMEM		12	/* not enough space */
+#define EACCES		13	/* permission denied */
+#define EFAULT		14	/* bad address */
+#define EBUSY		16	/* resource busy */
+#define EEXIST		17	/* file already exists */
+#define ENODEV		19	/* device not found */
+#define EINVAL		22	/* invalid argument */
+#define EDOM		33	/* math argument out of domain of func */
+#define ERANGE		34	/* math result not representable */
+
+#endif
diff --git a/pc-bios/s390-ccw/libc/include/limits.h b/pc-bios/s390-ccw/libc/include/limits.h
new file mode 100644
index 0000000..4726835
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/include/limits.h
@@ -0,0 +1,32 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#ifndef _LIMITS_H
+#define _LIMITS_H
+
+#define 	UCHAR_MAX	255
+#define 	SCHAR_MAX	127
+#define 	SCHAR_MIN	(-128)
+
+#define 	USHRT_MAX	65535
+#define 	SHRT_MAX	32767
+#define 	SHRT_MIN	(-32768)
+
+#define 	UINT_MAX	(4294967295U)
+#define 	INT_MAX 	2147483647
+#define 	INT_MIN 	(-2147483648)
+
+#define 	ULONG_MAX	((unsigned long)-1L)
+#define 	LONG_MAX	(ULONG_MAX/2)
+#define 	LONG_MIN	((-LONG_MAX)-1)
+
+#endif
diff --git a/pc-bios/s390-ccw/libc/include/stdarg.h b/pc-bios/s390-ccw/libc/include/stdarg.h
new file mode 100644
index 0000000..d3d12f7
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/include/stdarg.h
@@ -0,0 +1,22 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#ifndef _STDARG_H
+#define _STDARG_H
+
+typedef __builtin_va_list va_list;
+
+#define va_start(v,l)  __builtin_va_start(v,l)
+#define va_arg(v,l)  __builtin_va_arg(v,l)
+#define va_end(v)  __builtin_va_end(v)
+
+#endif
diff --git a/pc-bios/s390-ccw/libc/include/stdbool.h b/pc-bios/s390-ccw/libc/include/stdbool.h
new file mode 100644
index 0000000..5b7d36a
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/include/stdbool.h
@@ -0,0 +1,20 @@
+/******************************************************************************
+ * Copyright (c) 2013 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#ifndef _STDBOOL_H
+#define _STDBOOL_H
+
+#ifndef __cplusplus
+typedef enum { false = 0, true } bool;
+#endif
+
+#endif
diff --git a/pc-bios/s390-ccw/libc/include/stddef.h b/pc-bios/s390-ccw/libc/include/stddef.h
new file mode 100644
index 0000000..ba2d960
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/include/stddef.h
@@ -0,0 +1,25 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#ifndef _STDDEF_H
+#define _STDDEF_H
+
+
+#define NULL ((void *)0)
+
+
+typedef unsigned int size_t;
+
+
+#endif
+
+
diff --git a/pc-bios/s390-ccw/libc/include/stdint.h b/pc-bios/s390-ccw/libc/include/stdint.h
new file mode 100644
index 0000000..518a723
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/include/stdint.h
@@ -0,0 +1,28 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#ifndef _STDINT_H
+#define _STDINT_H
+
+typedef unsigned char uint8_t;
+typedef signed char int8_t;
+
+typedef unsigned short uint16_t;
+typedef signed short int16_t;
+
+typedef unsigned int uint32_t;
+typedef signed int int32_t;
+
+typedef unsigned long long uint64_t;
+typedef signed long long int64_t;
+
+#endif
diff --git a/pc-bios/s390-ccw/libc/include/stdio.h b/pc-bios/s390-ccw/libc/include/stdio.h
new file mode 100644
index 0000000..c54528f
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/include/stdio.h
@@ -0,0 +1,63 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#ifndef _STDIO_H
+#define _STDIO_H
+
+#include <stdarg.h>
+#include "stddef.h"
+
+#define EOF (-1)
+
+#define _IONBF 0
+#define _IOLBF 1
+#define _IOFBF 2
+#define BUFSIZ 80
+
+typedef struct {
+	int fd;
+	int mode;
+	int pos;
+	char *buf;
+	int bufsiz;
+} FILE;
+
+extern FILE stdin_data;
+extern FILE stdout_data;
+extern FILE stderr_data;
+
+#define stdin (&stdin_data)
+#define stdout (&stdout_data)
+#define stderr (&stderr_data)
+
+int fileno(FILE *stream);
+int printf(const char *format, ...) __attribute__((format (printf, 1, 2)));
+int fprintf(FILE *stream, const char *format, ...) __attribute__((format (printf, 2, 3)));
+int sprintf(char *str, const char *format, ...)  __attribute__((format (printf, 2, 3)));
+int vfprintf(FILE *stream, const char *format, va_list);
+int vsprintf(char *str, const char *format, va_list);
+int vsnprintf(char *str, size_t size, const char *format, va_list);
+void setbuf(FILE *stream, char *buf);
+int setvbuf(FILE *stream, char *buf, int mode , size_t size);
+
+int putc(int ch, FILE *stream);
+int putchar(int ch);
+int puts(const char *str);
+
+int scanf(const char *format, ...)  __attribute__((format (scanf, 1, 2)));
+int fscanf(FILE *stream, const char *format, ...) __attribute__((format (scanf, 2, 3)));
+int vfscanf(FILE *stream, const char *format, va_list);
+int vsscanf(const char *str, const char *format, va_list);
+int getc(FILE *stream);
+int getchar(void);
+
+#endif
diff --git a/pc-bios/s390-ccw/libc/include/stdlib.h b/pc-bios/s390-ccw/libc/include/stdlib.h
new file mode 100644
index 0000000..5e0eda9
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/include/stdlib.h
@@ -0,0 +1,34 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#ifndef _STDLIB_H
+#define _STDLIB_H
+
+#include "stddef.h"
+
+#define RAND_MAX 32767
+
+
+void *malloc(size_t size);
+void *realloc(void *ptr, size_t size);
+void free(void *ptr);
+void *memalign(size_t boundary, size_t size);
+
+int atoi(const char *str);
+long atol(const char *str);
+unsigned long int strtoul(const char *nptr, char **endptr, int base);
+long int strtol(const char *nptr, char **endptr, int base);
+
+int rand(void);
+void srand(unsigned int seed);
+
+#endif
diff --git a/pc-bios/s390-ccw/libc/include/string.h b/pc-bios/s390-ccw/libc/include/string.h
new file mode 100644
index 0000000..0163c9a
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/include/string.h
@@ -0,0 +1,37 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#ifndef _STRING_H
+#define _STRING_H
+
+#include "stddef.h"
+
+char *strcpy(char *dest, const char *src);
+char *strncpy(char *dest, const char *src, size_t n);
+char *strcat(char *dest, const char *src);
+int strcmp(const char *s1, const char *s2);
+int strncmp(const char *s1, const char *s2, size_t n);
+int strcasecmp(const char *s1, const char *s2);
+int strncasecmp(const char *s1, const char *s2, size_t n);
+char *strchr(const char *s, int c);
+char *strrchr(const char *s, int c);
+size_t strlen(const char *s);
+char *strstr(const char *hay, const char *needle);
+char *strtok(char *src, const char *pattern);
+
+void *memset(void *s, int c, size_t n);
+void *memchr(const void *s, int c, size_t n);
+void *memcpy(void *dest, const void *src, size_t n);
+void *memmove(void *dest, const void *src, size_t n);
+int memcmp(const void *s1, const void *s2, size_t n);
+
+#endif
diff --git a/pc-bios/s390-ccw/libc/include/sys/socket.h b/pc-bios/s390-ccw/libc/include/sys/socket.h
new file mode 100644
index 0000000..e9175be
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/include/sys/socket.h
@@ -0,0 +1,53 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+
+#ifndef _SOCKET_H
+#define _SOCKET_H
+#include <stdint.h>
+
+#define AF_PACKET 0
+#define AF_INET   1
+#define AF_INET6  2
+
+#define SOCK_RAW    0
+#define SOCK_PACKET 1
+#define SOCK_DGRAM  2
+#define SOCK_STREAM 3
+
+#define INADDR_ANY 0xFFFFFFFF
+
+#define IPPROTO_UDP 1
+
+#define ETH_ALEN 6   /**< HW address length             */
+
+struct sockaddr {
+	uint16_t tra_port;
+
+	uint16_t ipv4_proto;
+	uint32_t ipv4_addr;
+
+	// protocol field is only used by "connect"-handler
+	uint16_t llc_proto;
+	uint8_t  mac_addr[ETH_ALEN];
+};
+
+int socket(int, int, int, char *);
+int sendto(int, const void *, int, int, const void *, int);
+int send(int, const void *, int, int);
+int recv(int, void *, int, int);
+
+#define htonl(x) x
+#define htons(x) x
+
+#endif
+
diff --git a/pc-bios/s390-ccw/libc/include/unistd.h b/pc-bios/s390-ccw/libc/include/unistd.h
new file mode 100644
index 0000000..07210d6
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/include/unistd.h
@@ -0,0 +1,28 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#ifndef _UNISTD_H
+#define _UNISTD_H
+
+#include <stddef.h>
+
+typedef long ssize_t;
+
+extern int open(const char *name, int flags);
+extern int close(int fd);
+extern ssize_t read(int fd, void *buf, size_t count);
+extern ssize_t write(int fd, const void *buf, size_t count);
+extern ssize_t lseek(int fd, long offset, int whence);
+
+extern void *sbrk(int increment);
+
+#endif
diff --git a/pc-bios/s390-ccw/libc/stdio/Makefile.inc b/pc-bios/s390-ccw/libc/stdio/Makefile.inc
new file mode 100644
index 0000000..ac5302d
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdio/Makefile.inc
@@ -0,0 +1,23 @@
+# *****************************************************************************
+# * Copyright (c) 2004, 2008 IBM Corporation
+# * All rights reserved.
+# * This program and the accompanying materials
+# * are made available under the terms of the BSD License
+# * which accompanies this distribution, and is available at
+# * http://www.opensource.org/licenses/bsd-license.php
+# *
+# * Contributors:
+# *     IBM Corporation - initial implementation
+# ****************************************************************************/
+
+
+STDIO_SRC_C = fscanf.c sprintf.c vfprintf.c vsnprintf.c vsprintf.c fprintf.c \
+	      printf.c setvbuf.c putc.c puts.c putchar.c scanf.c stdchnls.c \
+	      vfscanf.c vsscanf.c fileno.c
+
+STDIO_SRC_ASM = 
+STDIO_SRCS = $(STDIO_SRC_C:%=$(STDIOCMNDIR)/%) $(STDIO_SRC_ASM:%=$(STDIOCMNDIR)/%)
+STDIO_OBJS = $(STDIO_SRC_C:%.c=%.o) $(STDIO_SRC_ASM:%.S=%.o)
+
+%.o : $(STDIOCMNDIR)/%.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@
diff --git a/pc-bios/s390-ccw/libc/stdio/fileno.c b/pc-bios/s390-ccw/libc/stdio/fileno.c
new file mode 100644
index 0000000..6e23951
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdio/fileno.c
@@ -0,0 +1,19 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <stdio.h>
+
+int
+fileno(FILE *stream)
+{
+	return stream->fd;
+}
diff --git a/pc-bios/s390-ccw/libc/stdio/fprintf.c b/pc-bios/s390-ccw/libc/stdio/fprintf.c
new file mode 100644
index 0000000..866df39
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdio/fprintf.c
@@ -0,0 +1,26 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include "stdio.h"
+
+
+int fprintf(FILE *stream, const char* fmt, ...)
+{
+	int count;
+	va_list ap;
+    
+	va_start(ap, fmt);
+	count = vfprintf(stream, fmt, ap);
+	va_end(ap);
+    
+	return count;
+}
diff --git a/pc-bios/s390-ccw/libc/stdio/printf.c b/pc-bios/s390-ccw/libc/stdio/printf.c
new file mode 100644
index 0000000..01f4592
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdio/printf.c
@@ -0,0 +1,27 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include "stdio.h"
+
+
+int printf(const char* fmt, ...)
+{
+	int count;
+	va_list ap;
+    
+	va_start(ap, fmt);
+	count = vfprintf(stdout, fmt, ap);
+	va_end(ap);
+    
+	return count;
+}
+
diff --git a/pc-bios/s390-ccw/libc/stdio/putc.c b/pc-bios/s390-ccw/libc/stdio/putc.c
new file mode 100644
index 0000000..230e9d1
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdio/putc.c
@@ -0,0 +1,25 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include "stdio.h"
+#include "unistd.h"
+
+int
+putc(int ch, FILE *stream)
+{
+	unsigned char outchar = ch;
+
+	if (write(stream->fd, &outchar, 1) == 1)
+		return outchar;
+	else
+		return EOF;
+}
diff --git a/pc-bios/s390-ccw/libc/stdio/putchar.c b/pc-bios/s390-ccw/libc/stdio/putchar.c
new file mode 100644
index 0000000..5c750d9
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdio/putchar.c
@@ -0,0 +1,21 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+
+#include "stdio.h"
+
+
+int
+putchar(int ch)
+{
+	return putc(ch, stdout);
+}
diff --git a/pc-bios/s390-ccw/libc/stdio/puts.c b/pc-bios/s390-ccw/libc/stdio/puts.c
new file mode 100644
index 0000000..9a93008
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdio/puts.c
@@ -0,0 +1,28 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+
+#include "stdio.h"
+#include "string.h"
+#include "unistd.h"
+
+
+int
+puts(const char *str)
+{
+	int ret;
+
+	ret = write(stdout->fd, str, strlen(str));
+	write(stdout->fd, "\r\n", 2);
+
+	return ret;
+}
diff --git a/pc-bios/s390-ccw/libc/stdio/setvbuf.c b/pc-bios/s390-ccw/libc/stdio/setvbuf.c
new file mode 100644
index 0000000..9b62dd8
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdio/setvbuf.c
@@ -0,0 +1,28 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <stdio.h>
+
+int setvbuf(FILE *stream, char *buf, int mode , size_t size)
+{
+	if (mode != _IONBF && mode != _IOLBF && mode != _IOFBF)
+		return -1;
+	stream->buf = buf;
+	stream->mode = mode;
+	stream->bufsiz = size;
+	return 0;
+}
+
+void setbuf(FILE *stream, char *buf)
+{
+	setvbuf(stream, buf, buf ? _IOFBF : _IONBF, BUFSIZ);
+}
diff --git a/pc-bios/s390-ccw/libc/stdio/sprintf.c b/pc-bios/s390-ccw/libc/stdio/sprintf.c
new file mode 100644
index 0000000..9c4540e
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdio/sprintf.c
@@ -0,0 +1,30 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <stdio.h>
+
+
+int sprintf(char *buff, const char *format, ...)
+{
+	va_list ar;
+	int count;
+
+	if ((buff==NULL) || (format==NULL))
+		return(-1);
+
+	va_start(ar, format);
+	count = vsprintf(buff, format, ar);
+	va_end(ar);
+	
+	return(count);
+}
+
diff --git a/pc-bios/s390-ccw/libc/stdio/stdchnls.c b/pc-bios/s390-ccw/libc/stdio/stdchnls.c
new file mode 100644
index 0000000..41ed958
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdio/stdchnls.c
@@ -0,0 +1,23 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+
+#include "stdio.h"
+
+static char stdin_buffer[BUFSIZ], stdout_buffer[BUFSIZ];
+
+FILE stdin_data = { .fd = 0, .mode = _IOLBF, .pos = 0,
+		    .buf = stdin_buffer, .bufsiz = BUFSIZ };
+FILE stdout_data = { .fd = 1, .mode = _IOLBF, .pos = 0,
+		     .buf = stdout_buffer, .bufsiz = BUFSIZ };
+FILE stderr_data = { .fd = 2, .mode = _IONBF, .pos = 0,
+		     .buf = NULL, .bufsiz = 0 };
diff --git a/pc-bios/s390-ccw/libc/stdio/vfprintf.c b/pc-bios/s390-ccw/libc/stdio/vfprintf.c
new file mode 100644
index 0000000..765feea
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdio/vfprintf.c
@@ -0,0 +1,27 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include "stdio.h"
+#include "unistd.h"
+
+
+int vfprintf(FILE *stream, const char *fmt, va_list ap)
+{
+	int count;
+	char buffer[320];
+
+	count = vsnprintf(buffer, sizeof(buffer), fmt, ap);
+	write(stream->fd, buffer, count);
+
+	return count;
+}
+
diff --git a/pc-bios/s390-ccw/libc/stdio/vsnprintf.c b/pc-bios/s390-ccw/libc/stdio/vsnprintf.c
new file mode 100644
index 0000000..21dd04d
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdio/vsnprintf.c
@@ -0,0 +1,298 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <stdbool.h>
+#include "stdio.h"
+#include "stdlib.h"
+#include "string.h"
+#include "ctype.h"
+
+static const unsigned long long convert[] = {
+	0x0, 0xFF, 0xFFFF, 0xFFFFFF, 0xFFFFFFFF,
+	0xFFFFFFFFFFULL, 0xFFFFFFFFFFFFULL, 0xFFFFFFFFFFFFFFULL, 0xFFFFFFFFFFFFFFFFULL
+};
+
+static int
+print_str_fill(char **buffer, size_t bufsize, char *sizec,
+					const char *str, char c)
+{
+	int i, sizei, len;
+	char *bstart = *buffer;
+
+	sizei = strtoul(sizec, NULL, 10);
+	len = strlen(str);
+	if (sizei > len) {
+		for (i = 0;
+			(i < (sizei - len)) && ((*buffer - bstart) < bufsize);
+									i++) {
+			**buffer = c;
+			*buffer += 1;
+		}
+	}
+	return 1;
+}
+
+static int
+print_str(char **buffer, size_t bufsize, const char *str)
+{
+	char *bstart = *buffer;
+	size_t i;
+
+	for (i = 0; (i < strlen(str)) && ((*buffer - bstart) < bufsize); i++) {
+		**buffer = str[i];
+		*buffer += 1;
+	}
+	return 1;
+}
+
+static unsigned int
+print_intlen(unsigned long value, unsigned short int base)
+{
+	int i = 0;
+
+	while (value > 0) {
+		value /= base;
+		i++;
+	}
+	if (i == 0)
+		i = 1;
+	return i;
+}
+
+static int
+print_itoa(char **buffer, size_t bufsize, unsigned long value,
+					unsigned short base, bool upper)
+{
+	const char zeichen[] = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
+	char c;
+	size_t i, len;
+
+	if(base <= 2 || base > 16)
+		return 0;
+
+	len = i = print_intlen(value, base);
+
+	/* Don't print to buffer if bufsize is not enough. */
+	if (len > bufsize)
+		return 0;
+
+	do {
+		c = zeichen[value % base];
+		if (upper)
+			c = toupper(c);
+
+		(*buffer)[--i] = c;
+		value /= base;
+	} while(value);
+
+	*buffer += len;
+
+	return 1;
+}
+
+
+
+static int
+print_fill(char **buffer, size_t bufsize, char *sizec, unsigned long size,
+				unsigned short int base, char c, int optlen)
+{
+	int i, sizei, len;
+	char *bstart = *buffer;
+
+	sizei = strtoul(sizec, NULL, 10);
+ 	len = print_intlen(size, base) + optlen;
+	if (sizei > len) {
+		for (i = 0;
+			(i < (sizei - len)) && ((*buffer - bstart) < bufsize);
+									i++) {
+			**buffer = c;
+			*buffer += 1;
+		}
+	}
+
+	return 0;
+}
+
+
+static int
+print_format(char **buffer, size_t bufsize, const char *format, void *var)
+{
+	char *start;
+	unsigned int i = 0, length_mod = sizeof(int);
+	unsigned long value = 0;
+	unsigned long signBit;
+	char *form, sizec[32];
+	char sign = ' ';
+	bool upper = false;
+
+	form  = (char *) format;
+	start = *buffer;
+
+	form++;
+	if(*form == '0' || *form == '.') {
+		sign = '0';
+		form++;
+	}
+
+	while ((*form != '\0') && ((*buffer - start) < bufsize)) {
+		switch(*form) {
+			case 'u':
+			case 'd':
+			case 'i':
+				sizec[i] = '\0';
+				value = (unsigned long) var;
+				signBit = 0x1ULL << (length_mod * 8 - 1);
+				if ((*form != 'u') && (signBit & value)) {
+					**buffer = '-';
+					*buffer += 1;
+					value = (-(unsigned long)value) & convert[length_mod];
+				}
+				print_fill(buffer, bufsize - (*buffer - start),
+						sizec, value, 10, sign, 0);
+				print_itoa(buffer, bufsize - (*buffer - start),
+							value, 10, upper);
+				break;
+			case 'X':
+				upper = true;
+			case 'x':
+				sizec[i] = '\0';
+				value = (unsigned long) var & convert[length_mod];
+				print_fill(buffer, bufsize - (*buffer - start),
+						sizec, value, 16, sign, 0);
+				print_itoa(buffer, bufsize - (*buffer - start),
+							value, 16, upper);
+				break;
+			case 'O':
+			case 'o':
+				sizec[i] = '\0';
+				value = (long int) var & convert[length_mod];
+				print_fill(buffer, bufsize - (*buffer - start),
+						sizec, value, 8, sign, 0);
+				print_itoa(buffer, bufsize - (*buffer - start),
+							value, 8, upper);
+				break;
+			case 'p':
+				sizec[i] = '\0';
+				print_fill(buffer, bufsize - (*buffer - start),
+					sizec, (unsigned long) var, 16, ' ', 2);
+				print_str(buffer, bufsize - (*buffer - start),
+									"0x");
+				print_itoa(buffer, bufsize - (*buffer - start),
+						(unsigned long) var, 16, upper);
+				break;
+			case 'c':
+				sizec[i] = '\0';
+				print_fill(buffer, bufsize - (*buffer - start),
+							sizec, 1, 10, ' ', 0);
+				**buffer = (unsigned long) var;
+				*buffer += 1;
+				break;
+			case 's':
+				sizec[i] = '\0';
+				print_str_fill(buffer,
+					bufsize - (*buffer - start), sizec,
+							(char *) var, ' ');
+
+				print_str(buffer, bufsize - (*buffer - start),
+								(char *) var);
+				break;
+			case 'l':
+				form++;
+				if(*form == 'l') {
+					length_mod = sizeof(long long int);
+				} else {
+					form--;
+					length_mod = sizeof(long int);
+				}
+				break;
+			case 'h':
+				form++;
+				if(*form == 'h') {
+					length_mod = sizeof(signed char);
+				} else {
+					form--;
+					length_mod = sizeof(short int);
+				}
+				break;
+			case 'z':
+				length_mod = sizeof(size_t);
+				break;
+			default:
+				if(*form >= '0' && *form <= '9')
+					sizec[i++] = *form;
+		}
+		form++;
+	}
+
+	
+	return (long int) (*buffer - start);
+}
+
+
+/*
+ * The vsnprintf function prints a formated strings into a buffer.
+ * BUG: buffer size checking does not fully work yet
+ */
+int
+vsnprintf(char *buffer, size_t bufsize, const char *format, va_list arg)
+{
+	char *ptr, *bstart;
+
+	bstart = buffer;
+	ptr = (char *) format;
+
+	/*
+	 * Return from here if size passed is zero, otherwise we would
+	 * overrun buffer while setting NULL character at the end.
+	 */
+	if (!buffer || !bufsize)
+		return 0;
+
+	/* Leave one space for NULL character */
+	bufsize--;
+
+	while(*ptr != '\0' && (buffer - bstart) < bufsize)
+	{
+		if(*ptr == '%') {
+			char formstr[20];
+			int i=0;
+			
+			do {
+				formstr[i] = *ptr;
+				ptr++;
+				i++;
+			} while(!(*ptr == 'd' || *ptr == 'i' || *ptr == 'u' || *ptr == 'x' || *ptr == 'X'
+						|| *ptr == 'p' || *ptr == 'c' || *ptr == 's' || *ptr == '%'
+						|| *ptr == 'O' || *ptr == 'o' )); 
+			formstr[i++] = *ptr;
+			formstr[i] = '\0';
+			if(*ptr == '%') {
+				*buffer++ = '%';
+			} else {
+				print_format(&buffer,
+					bufsize - (buffer - bstart),
+					formstr, va_arg(arg, void *));
+			}
+			ptr++;
+		} else {
+
+			*buffer = *ptr;
+
+			buffer++;
+			ptr++;
+		}
+	}
+	
+	*buffer = '\0';
+
+	return (buffer - bstart);
+}
diff --git a/pc-bios/s390-ccw/libc/stdio/vsprintf.c b/pc-bios/s390-ccw/libc/stdio/vsprintf.c
new file mode 100644
index 0000000..0dfd737
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdio/vsprintf.c
@@ -0,0 +1,19 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include "stdio.h"
+
+int
+vsprintf(char *buffer, const char *format, va_list arg)
+{
+	return vsnprintf(buffer, 0x7fffffff, format, arg);
+}
diff --git a/pc-bios/s390-ccw/libc/stdlib/Makefile.inc b/pc-bios/s390-ccw/libc/stdlib/Makefile.inc
new file mode 100644
index 0000000..702f6d7
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdlib/Makefile.inc
@@ -0,0 +1,22 @@
+# *****************************************************************************
+# * Copyright (c) 2004, 2008 IBM Corporation
+# * All rights reserved.
+# * This program and the accompanying materials
+# * are made available under the terms of the BSD License
+# * which accompanies this distribution, and is available at
+# * http://www.opensource.org/licenses/bsd-license.php
+# *
+# * Contributors:
+# *     IBM Corporation - initial implementation
+# ****************************************************************************/
+
+
+STDLIB_SRC_C =  error.c atoi.c atol.c strtoul.c strtol.c rand.c \
+		 malloc.c memalign.c realloc.c free.c
+		
+STDLIB_SRC_ASM = 
+STDLIB_SRCS = $(STDLIB_SRC_C:%=$(STDLIBCMNDIR)/%) $(STDLIB_SRC_ASM:%=$(STDLIBCMNDIR)/%)
+STDLIB_OBJS = $(STDLIB_SRC_C:%.c=%.o) $(STDLIB_SRC_ASM:%.S=%.o)
+
+%.o : $(STDLIBCMNDIR)/%.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@
diff --git a/pc-bios/s390-ccw/libc/stdlib/atoi.c b/pc-bios/s390-ccw/libc/stdlib/atoi.c
new file mode 100644
index 0000000..d2fb33b
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdlib/atoi.c
@@ -0,0 +1,18 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <stdlib.h>
+
+int atoi(const char *str)
+{
+	return strtol(str, NULL, 0);
+}
diff --git a/pc-bios/s390-ccw/libc/stdlib/atol.c b/pc-bios/s390-ccw/libc/stdlib/atol.c
new file mode 100644
index 0000000..a6aa47b
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdlib/atol.c
@@ -0,0 +1,18 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <stdlib.h>
+
+long atol(const char *str)
+{
+	return strtol(str, NULL, 0);
+}
diff --git a/pc-bios/s390-ccw/libc/stdlib/error.c b/pc-bios/s390-ccw/libc/stdlib/error.c
new file mode 100644
index 0000000..81020ca
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdlib/error.c
@@ -0,0 +1,15 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+
+int errno;
+
diff --git a/pc-bios/s390-ccw/libc/stdlib/free.c b/pc-bios/s390-ccw/libc/stdlib/free.c
new file mode 100644
index 0000000..9005450
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdlib/free.c
@@ -0,0 +1,26 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+
+#include "stdlib.h"
+#include "malloc_defs.h"
+
+void
+free(void *ptr)
+{
+	struct chunk *header;
+
+	header = (struct chunk *) ptr;
+	header--;
+	header->inuse = 0;
+
+}
diff --git a/pc-bios/s390-ccw/libc/stdlib/malloc.c b/pc-bios/s390-ccw/libc/stdlib/malloc.c
new file mode 100644
index 0000000..b2a3138
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdlib/malloc.c
@@ -0,0 +1,157 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+
+#include "stddef.h"
+#include "stdlib.h"
+#include "unistd.h"
+#include "malloc_defs.h"
+
+
+static int clean(void);
+
+
+/* act points to the end of the initialized heap and the start of uninitialized heap */
+static char *act;
+
+/* Pointers to start and end of heap: */
+static char *heap_start, *heap_end;
+
+
+/*
+ * Standard malloc function
+ */
+void *
+malloc(size_t size)
+{
+	char *header;
+	void *data;
+	size_t blksize;         /* size of memory block including the chunk */
+
+	blksize = size + sizeof(struct chunk);
+
+	/* has malloc been called for the first time? */
+	if (act == 0) {
+		size_t initsize;
+		/* add some space so we have a good initial playground */
+		initsize = (blksize + 0x1000) & ~0x0fff;
+		/* get initial memory region with sbrk() */
+		heap_start = sbrk(initsize);
+		if (heap_start == (void*)-1)
+			return NULL;
+		heap_end = heap_start + initsize;
+		act = heap_start;
+	}
+
+	header = act;
+	data = act + sizeof(struct chunk);
+
+	/* Check if there is space left in the uninitialized part of the heap */
+	if (act + blksize > heap_end) {
+		//search at begin of heap
+		header = heap_start;
+
+		while ((((struct chunk *) header)->inuse != 0
+		        || ((struct chunk *) header)->length < size)
+		       && header < act) {
+			header = header + sizeof(struct chunk)
+			         + ((struct chunk *) header)->length;
+		}
+
+		// check if heap is full
+		if (header >= act) {
+			if (clean()) {
+				// merging of free blocks succeeded, so try again
+				return malloc(size);
+			} else if (sbrk(blksize) == heap_end) {
+				// succeeded to get more memory, so try again
+				heap_end += blksize;
+				return malloc(size);
+			} else {
+				// No more memory available
+				return 0;
+			}
+		}
+
+		// Check if we need to split this memory block into two
+		if (((struct chunk *) header)->length > blksize) {
+			//available memory is too big
+			int alt;
+
+			alt = ((struct chunk *) header)->length;
+			((struct chunk *) header)->inuse = 1;
+			((struct chunk *) header)->length = size;
+			data = header + sizeof(struct chunk);
+
+			//mark the rest of the heap
+			header = data + size;
+			((struct chunk *) header)->inuse = 0;
+			((struct chunk *) header)->length =
+			    alt - blksize;
+		} else {
+			//new memory matched exactly in available memory
+			((struct chunk *) header)->inuse = 1;
+			data = header + sizeof(struct chunk);
+		}
+
+	} else {
+
+		((struct chunk *) header)->inuse = 1;
+		((struct chunk *) header)->length = size;
+
+		act += blksize;
+	}
+
+	return data;
+}
+
+
+/*
+ * Merge free memory blocks in initialized heap if possible
+ */
+static int
+clean(void)
+{
+	char *header;
+	char *firstfree = 0;
+	char check = 0;
+
+	header = heap_start;
+	//if (act == 0)		// This should never happen
+	//	act = heap_end;
+
+	while (header < act) {
+
+		if (((struct chunk *) header)->inuse == 0) {
+			if (firstfree == 0) {
+				/* First free block in a row, only save address */
+				firstfree = header;
+
+			} else {
+				/* more than one free block in a row, merge them! */
+				((struct chunk *) firstfree)->length +=
+				    ((struct chunk *) header)->length +
+				    sizeof(struct chunk);
+				check = 1;
+			}
+		} else {
+			firstfree = 0;
+
+		}
+
+		header = header + sizeof(struct chunk)
+		         + ((struct chunk *) header)->length;
+
+	}
+
+	return check;
+}
diff --git a/pc-bios/s390-ccw/libc/stdlib/malloc_defs.h b/pc-bios/s390-ccw/libc/stdlib/malloc_defs.h
new file mode 100644
index 0000000..1933026
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdlib/malloc_defs.h
@@ -0,0 +1,16 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+struct chunk {
+	unsigned inuse : 4;
+	unsigned length : 28;
+} __attribute__((packed));
diff --git a/pc-bios/s390-ccw/libc/stdlib/memalign.c b/pc-bios/s390-ccw/libc/stdlib/memalign.c
new file mode 100644
index 0000000..3b678aa
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdlib/memalign.c
@@ -0,0 +1,26 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+
+#include "stdlib.h"
+
+
+void *
+memalign(size_t blocksize, size_t bytes)
+{
+	void *x;
+
+	x = malloc(bytes + blocksize);
+	x = (void *) (((unsigned long) x + blocksize - 1) & ~(blocksize - 1));
+
+	return (void *) x;
+}
diff --git a/pc-bios/s390-ccw/libc/stdlib/rand.c b/pc-bios/s390-ccw/libc/stdlib/rand.c
new file mode 100644
index 0000000..39f5a9a
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdlib/rand.c
@@ -0,0 +1,29 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <stdlib.h>
+
+
+static unsigned long _rand = 1;
+
+int
+rand(void)
+{
+	_rand = _rand * 1237732973 + 34563;
+
+	return ((unsigned int) (_rand >> 16) & RAND_MAX);
+}
+
+void srand(unsigned int seed)
+{
+	_rand = seed;
+}
diff --git a/pc-bios/s390-ccw/libc/stdlib/realloc.c b/pc-bios/s390-ccw/libc/stdlib/realloc.c
new file mode 100644
index 0000000..652e900
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdlib/realloc.c
@@ -0,0 +1,40 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+
+#include "stdlib.h"
+#include "string.h"
+#include "malloc_defs.h"
+
+void *
+realloc(void *ptr, size_t size)
+{
+	struct chunk *header;
+	char *newptr, *start;
+
+	header = (struct chunk *) ptr;
+	header--;
+
+	if (size <= header->length)
+		return ptr;
+
+	newptr = (char *) malloc(size);
+	if (newptr == NULL)
+		return 0;
+
+	start = newptr;
+	memcpy((void *) newptr, (const void *) ptr, header->length);
+
+	header->inuse = 0;
+
+	return start;
+}
diff --git a/pc-bios/s390-ccw/libc/stdlib/strtol.c b/pc-bios/s390-ccw/libc/stdlib/strtol.c
new file mode 100644
index 0000000..474597a
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdlib/strtol.c
@@ -0,0 +1,115 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <stdlib.h>
+
+long int strtol(const char *S, char **PTR,int BASE)
+{
+	long rval = 0;
+	short int negative = 0;
+	short int digit;
+	// *PTR is S, unless PTR is NULL, in which case i override it with my own ptr
+	char* ptr;
+	if (PTR == 0)
+	{
+		//override
+		PTR = &ptr;
+	}
+	// i use PTR to advance through the string
+	*PTR = (char *) S;
+	//check if BASE is ok
+	if ((BASE < 0) || BASE > 36)
+	{
+		return 0;
+	}
+	// ignore white space at beginning of S
+	while ((**PTR == ' ')
+			|| (**PTR == '\t')
+			|| (**PTR == '\n')
+			|| (**PTR == '\r')
+			)
+	{
+		(*PTR)++;
+	}
+	// check if S starts with "-" in which case the return value is negative
+	if (**PTR == '-')
+	{
+		negative = 1;
+		(*PTR)++;
+	}
+	// if BASE is 0... determine the base from the first chars...
+	if (BASE == 0)
+	{
+		// if S starts with "0x", BASE = 16, else 10
+		if ((**PTR == '0') && (*((*PTR)+1) == 'x'))
+		{
+			BASE = 16;
+			(*PTR)++;
+			(*PTR)++;
+		}
+		else
+		{
+			BASE = 10;
+		}
+	}
+	if (BASE == 16)
+	{
+		// S may start with "0x"
+		if ((**PTR == '0') && (*((*PTR)+1) == 'x'))
+		{
+			(*PTR)++;
+			(*PTR)++;
+		}
+	}
+	//until end of string
+	while (**PTR)
+	{
+		if (((**PTR) >= '0') && ((**PTR) <= '9'))
+		{
+			//digit (0..9)
+			digit = **PTR - '0';
+		}
+		else if (((**PTR) >= 'a') && ((**PTR) <='z'))
+		{
+			//alphanumeric digit lowercase(a (10) .. z (35) )
+			digit = (**PTR - 'a') + 10;
+		}
+		else if (((**PTR) >= 'A') && ((**PTR) <='Z'))
+		{
+			//alphanumeric digit uppercase(a (10) .. z (35) )
+			digit = (**PTR - 'A') + 10;
+		}
+		else
+		{
+			//end of parseable number reached...
+			break;
+		}
+		if (digit < BASE)
+		{
+			rval = (rval * BASE) + digit;
+		}
+		else
+		{
+			//digit found, but its too big for current base
+			//end of parseable number reached...
+			break;
+		}
+		//next...
+		(*PTR)++;
+	}
+	if (negative)
+	{
+		return rval * -1;
+	}
+	//else
+	return rval;
+}
diff --git a/pc-bios/s390-ccw/libc/stdlib/strtoul.c b/pc-bios/s390-ccw/libc/stdlib/strtoul.c
new file mode 100644
index 0000000..754e7db
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/stdlib/strtoul.c
@@ -0,0 +1,105 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <stdlib.h>
+
+unsigned long int strtoul(const char *S, char **PTR,int BASE)
+{
+	unsigned long rval = 0;
+	short int digit;
+	// *PTR is S, unless PTR is NULL, in which case i override it with my own ptr
+	char* ptr;
+	if (PTR == 0)
+	{
+		//override
+		PTR = &ptr;
+	}
+	// i use PTR to advance through the string
+	*PTR = (char *) S;
+	//check if BASE is ok
+	if ((BASE < 0) || BASE > 36)
+	{
+		return 0;
+	}
+	// ignore white space at beginning of S
+	while ((**PTR == ' ')
+			|| (**PTR == '\t')
+			|| (**PTR == '\n')
+			|| (**PTR == '\r')
+			)
+	{
+		(*PTR)++;
+	}
+	// if BASE is 0... determine the base from the first chars...
+	if (BASE == 0)
+	{
+		// if S starts with "0x", BASE = 16, else 10
+		if ((**PTR == '0') && (*((*PTR)+1) == 'x'))
+		{
+			BASE = 16;
+			(*PTR)++;
+			(*PTR)++;
+		}
+		else
+		{
+			BASE = 10;
+		}
+	}
+	if (BASE == 16)
+	{
+		// S may start with "0x"
+		if ((**PTR == '0') && (*((*PTR)+1) == 'x'))
+		{
+			(*PTR)++;
+			(*PTR)++;
+		}
+	}
+	//until end of string
+	while (**PTR)
+	{
+		if (((**PTR) >= '0') && ((**PTR) <='9'))
+		{
+			//digit (0..9)
+			digit = **PTR - '0';
+		}
+		else if (((**PTR) >= 'a') && ((**PTR) <='z'))
+		{
+			//alphanumeric digit lowercase(a (10) .. z (35) )
+			digit = (**PTR - 'a') + 10;
+		}
+		else if (((**PTR) >= 'A') && ((**PTR) <='Z'))
+		{
+			//alphanumeric digit uppercase(a (10) .. z (35) )
+			digit = (**PTR - 'A') + 10;
+		}
+		else
+		{
+			//end of parseable number reached...
+			break;
+		}
+		if (digit < BASE)
+		{
+			rval = (rval * BASE) + digit;
+		}
+		else
+		{
+			//digit found, but its too big for current base
+			//end of parseable number reached...
+			break;
+		}
+		//next...
+		(*PTR)++;
+	}
+	//done
+	return rval;
+}
+
diff --git a/pc-bios/s390-ccw/libc/string/Makefile.inc b/pc-bios/s390-ccw/libc/string/Makefile.inc
new file mode 100644
index 0000000..7ccf3c4
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/Makefile.inc
@@ -0,0 +1,22 @@
+# *****************************************************************************
+# * Copyright (c) 2004, 2008 IBM Corporation
+# * All rights reserved.
+# * This program and the accompanying materials
+# * are made available under the terms of the BSD License
+# * which accompanies this distribution, and is available at
+# * http://www.opensource.org/licenses/bsd-license.php
+# *
+# * Contributors:
+# *     IBM Corporation - initial implementation
+# ****************************************************************************/
+
+
+STRING_SRC_C = strcat.c strchr.c strcmp.c strcpy.c strlen.c strncmp.c \
+		strncpy.c strstr.c memset.c memcpy.c memmove.c memchr.c \
+		memcmp.c strcasecmp.c strncasecmp.c strtok.c
+STRING_SRC_ASM = 
+STRING_SRCS = $(STRING_SRC_C:%=$(STRINGCMNDIR)/%) $(STRING_SRC_ASM:%=$(STRINGCMNDIR)/%)
+STRING_OBJS = $(STRING_SRC_C:%.c=%.o) $(STRING_SRC_ASM:%.S=%.o)
+
+%.o : $(STRINGCMNDIR)/%.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@
diff --git a/pc-bios/s390-ccw/libc/string/memchr.c b/pc-bios/s390-ccw/libc/string/memchr.c
new file mode 100644
index 0000000..c3fe751
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/memchr.c
@@ -0,0 +1,29 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include "string.h"
+
+
+void *
+memchr(const void *ptr, int c, size_t n)
+{
+	unsigned char ch = (unsigned char)c;
+	const unsigned char *p = ptr;
+
+	while (n-- > 0) {
+		if (*p == ch)
+			return (void *)p;
+		p += 1;
+	}
+
+	return NULL;
+}
diff --git a/pc-bios/s390-ccw/libc/string/memcmp.c b/pc-bios/s390-ccw/libc/string/memcmp.c
new file mode 100644
index 0000000..3b69cef
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/memcmp.c
@@ -0,0 +1,30 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include "string.h"
+
+
+int
+memcmp(const void *ptr1, const void *ptr2, size_t n)
+{
+	const unsigned char *p1 = ptr1;
+	const unsigned char *p2 = ptr2;
+
+	while (n-- > 0) {
+		if (*p1 != *p2)
+			return (*p1 - *p2);
+		p1 += 1;
+		p2 += 1;
+	}
+
+	return 0;
+}
diff --git a/pc-bios/s390-ccw/libc/string/memcpy.c b/pc-bios/s390-ccw/libc/string/memcpy.c
new file mode 100644
index 0000000..00f419b
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/memcpy.c
@@ -0,0 +1,27 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include "string.h"
+
+void *
+memcpy(void *dest, const void *src, size_t n)
+{
+	char *cdest;
+	const char *csrc = src;
+
+	cdest = dest;
+	while (n-- > 0) {
+		*cdest++ = *csrc++;
+	}
+
+	return dest;
+}
diff --git a/pc-bios/s390-ccw/libc/string/memmove.c b/pc-bios/s390-ccw/libc/string/memmove.c
new file mode 100644
index 0000000..3acf1a9
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/memmove.c
@@ -0,0 +1,42 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include "string.h"
+
+
+void *
+memmove(void *dest, const void *src, size_t n)
+{
+	char *cdest;
+	const char *csrc;
+	int i;
+
+	/* Do the buffers overlap in a bad way? */
+	if (src < dest && src + n >= dest) {
+		/* Copy from end to start */
+		cdest = dest + n - 1;
+		csrc = src + n - 1;
+		for (i = 0; i < n; i++) {
+			*cdest-- = *csrc--;
+		}
+	}
+	else {
+		/* Normal copy is possible */
+		cdest = dest;
+		csrc = src;
+		for (i = 0; i < n; i++) {
+			*cdest++ = *csrc++;
+		}
+	}
+
+	return dest;
+}
diff --git a/pc-bios/s390-ccw/libc/string/memset.c b/pc-bios/s390-ccw/libc/string/memset.c
new file mode 100644
index 0000000..f8dfbf5
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/memset.c
@@ -0,0 +1,25 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include "string.h"
+
+void *
+memset(void *dest, int c, size_t size)
+{
+	unsigned char *d = (unsigned char *)dest;
+
+	while (size-- > 0) {
+		*d++ = (unsigned char)c;
+	}
+
+	return dest;
+}
diff --git a/pc-bios/s390-ccw/libc/string/strcasecmp.c b/pc-bios/s390-ccw/libc/string/strcasecmp.c
new file mode 100644
index 0000000..f75294f
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/strcasecmp.c
@@ -0,0 +1,28 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <string.h>
+#include <ctype.h>
+
+int
+strcasecmp(const char *s1, const char *s2)
+{
+	while (*s1 != 0 && *s2 != 0) {
+		if (toupper(*s1) != toupper(*s2))
+			break;
+		++s1;
+		++s2;
+	}
+
+	return *s1 - *s2;
+}
+
diff --git a/pc-bios/s390-ccw/libc/string/strcat.c b/pc-bios/s390-ccw/libc/string/strcat.c
new file mode 100644
index 0000000..eb597a0
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/strcat.c
@@ -0,0 +1,24 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <string.h>
+
+char *
+strcat(char *dst, const char *src)
+{
+	int p;
+
+	p = strlen(dst);
+	strcpy(&dst[p], src);
+
+	return dst;
+}
diff --git a/pc-bios/s390-ccw/libc/string/strchr.c b/pc-bios/s390-ccw/libc/string/strchr.c
new file mode 100644
index 0000000..528a319
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/strchr.c
@@ -0,0 +1,28 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <string.h>
+
+char *
+strchr(const char *s, int c)
+{
+	char cb = c;
+
+	while (*s != 0) {
+		if (*s == cb) {
+			return (char *)s;
+		}
+		s += 1;
+	}
+
+	return NULL;
+}
diff --git a/pc-bios/s390-ccw/libc/string/strcmp.c b/pc-bios/s390-ccw/libc/string/strcmp.c
new file mode 100644
index 0000000..48eaed2
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/strcmp.c
@@ -0,0 +1,28 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <string.h>
+
+
+int
+strcmp(const char *s1, const char *s2)
+{
+	while (*s1 != 0 && *s2 != 0) {
+		if (*s1 != *s2)
+			break;
+		s1 += 1;
+		s2 += 1;
+	}
+
+	return *s1 - *s2;
+}
+
diff --git a/pc-bios/s390-ccw/libc/string/strcpy.c b/pc-bios/s390-ccw/libc/string/strcpy.c
new file mode 100644
index 0000000..48eb62c
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/strcpy.c
@@ -0,0 +1,25 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <string.h>
+
+char *
+strcpy(char *dst, const char *src)
+{
+	char *ptr = dst;
+
+	do {
+		*ptr++ = *src;
+	} while (*src++ != 0);
+
+	return dst;
+}
diff --git a/pc-bios/s390-ccw/libc/string/strlen.c b/pc-bios/s390-ccw/libc/string/strlen.c
new file mode 100644
index 0000000..37a1b78
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/strlen.c
@@ -0,0 +1,27 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <string.h>
+
+size_t
+strlen(const char *s)
+{
+	int len = 0;
+
+	while (*s != 0) {
+		len += 1;
+		s += 1;
+	}
+
+	return len;
+}
+
diff --git a/pc-bios/s390-ccw/libc/string/strncasecmp.c b/pc-bios/s390-ccw/libc/string/strncasecmp.c
new file mode 100644
index 0000000..4140931
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/strncasecmp.c
@@ -0,0 +1,32 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <string.h>
+#include <ctype.h>
+
+
+int
+strncasecmp(const char *s1, const char *s2, size_t n)
+{
+	if (n < 1)
+		return 0;
+
+	while (*s1 != 0 && *s2 != 0 && --n > 0) {
+		if (toupper(*s1) != toupper(*s2))
+			break;
+		++s1;
+		++s2;
+	}
+
+	return toupper(*s1) - toupper(*s2);
+}
+
diff --git a/pc-bios/s390-ccw/libc/string/strncmp.c b/pc-bios/s390-ccw/libc/string/strncmp.c
new file mode 100644
index 0000000..a886736
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/strncmp.c
@@ -0,0 +1,31 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <string.h>
+
+
+int
+strncmp(const char *s1, const char *s2, size_t n)
+{
+	if (n < 1)
+		return 0;
+
+	while (*s1 != 0 && *s2 != 0 && --n > 0) {
+		if (*s1 != *s2)
+			break;
+		s1 += 1;
+		s2 += 1;
+	}
+
+	return *s1 - *s2;
+}
+
diff --git a/pc-bios/s390-ccw/libc/string/strncpy.c b/pc-bios/s390-ccw/libc/string/strncpy.c
new file mode 100644
index 0000000..0f41f93
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/strncpy.c
@@ -0,0 +1,33 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <string.h>
+
+char *
+strncpy(char *dst, const char *src, size_t n)
+{
+	char *ret = dst;
+
+	/* Copy string */
+	while (*src != 0 && n > 0) {
+		*dst++ = *src++;
+		n -= 1;
+	}
+
+	/* strncpy always clears the rest of destination string... */
+	while (n > 0) {
+		*dst++ = 0;
+		n -= 1;
+	}
+
+	return ret;
+}
diff --git a/pc-bios/s390-ccw/libc/string/strstr.c b/pc-bios/s390-ccw/libc/string/strstr.c
new file mode 100644
index 0000000..3e090d2
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/strstr.c
@@ -0,0 +1,37 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <string.h>
+
+char *
+strstr(const char *hay, const char *needle)
+{
+	char *pos;
+	int hlen, nlen;
+
+	if (hay == NULL || needle == NULL)
+		return NULL;
+	
+	hlen = strlen(hay);
+	nlen = strlen(needle);
+	if (nlen < 1)
+		return (char *)hay;
+
+	for (pos = (char *)hay; pos < hay + hlen; pos++) {
+		if (strncmp(pos, needle, nlen) == 0) {
+			return pos;
+		}
+	}
+
+	return NULL;
+}
+
diff --git a/pc-bios/s390-ccw/libc/string/strtok.c b/pc-bios/s390-ccw/libc/string/strtok.c
new file mode 100644
index 0000000..665c08d
--- /dev/null
+++ b/pc-bios/s390-ccw/libc/string/strtok.c
@@ -0,0 +1,45 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <string.h>
+
+char *
+strtok(char *src, const char *pattern)
+{
+	static char *nxtTok;
+	char *retVal = NULL;
+
+	if (!src)
+		src = nxtTok;
+
+	while (*src) {
+		const char *pp = pattern;
+		while (*pp) {
+			if (*pp == *src) {
+				break;
+			}
+			pp++;
+		}
+		if (!*pp) {
+			if (!retVal)
+				retVal = src;
+			else if (!src[-1])
+				break;
+		} else
+			*src = '\0';
+		src++;
+	}
+
+	nxtTok = src;
+
+	return retVal;
+}
-- 
1.8.3.1
