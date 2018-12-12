Received: from eggs.gnu.org ([2001:4830:134:3::10]:52047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MO-0000f7-FZ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MK-0008WJ-OP
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:38 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:55383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MI-0008S8-Nm
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:36 -0500
Received: by mail-wm1-x329.google.com with SMTP id y139so6132455wmc.5
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:32 +0100
Message-Id: <1544628195-37728-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/54] hax: Support for Linux hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexandro Sanchez Bach <asanchez@kryptoslogic.com>

From: Alexandro Sanchez Bach <asanchez@kryptoslogic.com>

Intel HAXM supports now 32-bit and 64-bit Linux hosts. This patch includes
the corresponding userland changes.

Since the Darwin userland backend is POSIX-compliant, the hax-darwin.{c,h}
files have been renamed to hax-posix.{c,h}. This prefix is consistent with
the naming used in the rest of QEMU.

Signed-off-by: Alexandro Sanchez Bach <asanchez@kryptoslogic.com>
Message-Id: <20181115013331.65820-1-asanchez@kryptoslogic.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/Makefile.objs                 | 6 +++---
 target/i386/hax-i386.h                    | 6 +++---
 target/i386/{hax-darwin.c => hax-posix.c} | 0
 target/i386/{hax-darwin.h => hax-posix.h} | 0
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename target/i386/{hax-darwin.c => hax-posix.c} (100%)
 rename target/i386/{hax-darwin.h => hax-posix.h} (100%)

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 32bf966..cb9c265 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -12,10 +12,10 @@ obj-$(call lnot,$(CONFIG_HYPERV)) += hyperv-stub.o
 ifeq ($(CONFIG_WIN32),y)
 obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
 endif
-ifeq ($(CONFIG_DARWIN),y)
-obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-darwin.o
-obj-$(CONFIG_HVF) += hvf/
+ifeq ($(CONFIG_POSIX),y)
+obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-posix.o
 endif
+obj-$(CONFIG_HVF) += hvf/
 obj-$(CONFIG_WHPX) += whpx-all.o
 endif
 obj-$(CONFIG_SEV) += sev.o
diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
index 6abc156..f13fa46 100644
--- a/target/i386/hax-i386.h
+++ b/target/i386/hax-i386.h
@@ -16,7 +16,7 @@
 #include "cpu.h"
 #include "sysemu/hax.h"
 
-#ifdef CONFIG_DARWIN
+#ifdef CONFIG_POSIX
 typedef int hax_fd;
 #endif
 
@@ -82,8 +82,8 @@ hax_fd hax_mod_open(void);
 void hax_memory_init(void);
 
 
-#ifdef CONFIG_DARWIN
-#include "target/i386/hax-darwin.h"
+#ifdef CONFIG_POSIX
+#include "target/i386/hax-posix.h"
 #endif
 
 #ifdef CONFIG_WIN32
diff --git a/target/i386/hax-darwin.c b/target/i386/hax-posix.c
similarity index 100%
rename from target/i386/hax-darwin.c
rename to target/i386/hax-posix.c
diff --git a/target/i386/hax-darwin.h b/target/i386/hax-posix.h
similarity index 100%
rename from target/i386/hax-darwin.h
rename to target/i386/hax-posix.h
-- 
1.8.3.1
