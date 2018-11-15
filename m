Received: from eggs.gnu.org ([2001:4830:134:3::10]:46498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asanchez@kryptoslogic.com>) id 1gN6ZY-0005Z6-EV
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 20:35:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asanchez@kryptoslogic.com>) id 1gN6ZU-0006H7-Bi
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 20:35:56 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asanchez@kryptoslogic.com>)
	id 1gN6ZS-0006EM-Lo
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 20:35:52 -0500
Received: by mail-wr1-x444.google.com with SMTP id k15-v6so19329711wre.12
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 17:35:48 -0800 (PST)
From: Alexandro Sanchez Bach <asanchez@kryptoslogic.com>
Date: Wed, 14 Nov 2018 17:33:30 -0800
Message-Id: <20181115013331.65820-1-asanchez@kryptoslogic.com>
In-Reply-To: <87y39vd7jn.fsf@linaro.org>
References: <87y39vd7jn.fsf@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hax: Support for Linux hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yu.ning@intel.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alexandro Sanchez Bach <asanchez@kryptoslogic.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Intel HAXM supports now 32-bit and 64-bit Linux hosts. This patch includes
the corresponding userland changes.

Since the Darwin userland backend is POSIX-compliant, the hax-darwin.{c,h}
files have been renamed to hax-posix.{c,h}. This prefix is consistent with
the naming used in the rest of QEMU.

Signed-off-by: Alexandro Sanchez Bach <asanchez@kryptoslogic.com>
---
 target/i386/Makefile.objs                 | 4 +++-
 target/i386/hax-i386.h                    | 6 +++---
 target/i386/{hax-darwin.c => hax-posix.c} | 0
 target/i386/{hax-darwin.h => hax-posix.h} | 0
 4 files changed, 6 insertions(+), 4 deletions(-)
 rename target/i386/{hax-darwin.c => hax-posix.c} (100%)
 rename target/i386/{hax-darwin.h => hax-posix.h} (100%)

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 04678f5503..070e701856 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -12,8 +12,10 @@ obj-$(call lnot,$(CONFIG_SEV)) += sev-stub.o
 ifdef CONFIG_WIN32
 obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
 endif
+ifdef CONFIG_POSIX
+obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-posix.o
+endif
 ifdef CONFIG_DARWIN
-obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-darwin.o
 obj-$(CONFIG_HVF) += hvf/
 endif
 obj-$(CONFIG_WHPX) += whpx-all.o
diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
index 6abc156f88..f13fa4638f 100644
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
2.19.1
