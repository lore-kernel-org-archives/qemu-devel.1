Received: from eggs.gnu.org ([2001:4830:134:3::10]:43184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28p-0000Ul-9c
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28n-0003jY-SJ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ28l-0003NR-0P
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:35 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:36 +0100
Message-Id: <20181217231700.24482-12-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/35] hax: Support for Linux hosts
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

Intel HAXM supports now 32-bit and 64-bit Linux hosts. This patch include=
s
the corresponding userland changes.

Since the Darwin userland backend is POSIX-compliant, the hax-darwin.{c,h=
}
files have been renamed to hax-posix.{c,h}. This prefix is consistent wit=
h
the naming used in the rest of QEMU.

Signed-off-by: Alexandro Sanchez Bach <asanchez@kryptoslogic.com>
Message-Id: <20181115013331.65820-1-asanchez@kryptoslogic.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/Makefile.objs                 | 6 +++---
 target/i386/hax-i386.h                    | 6 +++---
 target/i386/{hax-darwin.c =3D> hax-posix.c} | 0
 target/i386/{hax-darwin.h =3D> hax-posix.h} | 0
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename target/i386/{hax-darwin.c =3D> hax-posix.c} (100%)
 rename target/i386/{hax-darwin.h =3D> hax-posix.h} (100%)

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 32bf966300..cb9c265525 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -12,10 +12,10 @@ obj-$(call lnot,$(CONFIG_HYPERV)) +=3D hyperv-stub.o
 ifeq ($(CONFIG_WIN32),y)
 obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-windows.o
 endif
-ifeq ($(CONFIG_DARWIN),y)
-obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-darwin.o
-obj-$(CONFIG_HVF) +=3D hvf/
+ifeq ($(CONFIG_POSIX),y)
+obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-posix.o
 endif
+obj-$(CONFIG_HVF) +=3D hvf/
 obj-$(CONFIG_WHPX) +=3D whpx-all.o
 endif
 obj-$(CONFIG_SEV) +=3D sev.o
diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
index 6abc156f88..f13fa4638f 100644
--- a/target/i386/hax-i386.h
+++ b/target/i386/hax-i386.h
@@ -16,7 +16,7 @@
 #include "cpu.h"
 #include "sysemu/hax.h"
=20
-#ifdef CONFIG_DARWIN
+#ifdef CONFIG_POSIX
 typedef int hax_fd;
 #endif
=20
@@ -82,8 +82,8 @@ hax_fd hax_mod_open(void);
 void hax_memory_init(void);
=20
=20
-#ifdef CONFIG_DARWIN
-#include "target/i386/hax-darwin.h"
+#ifdef CONFIG_POSIX
+#include "target/i386/hax-posix.h"
 #endif
=20
 #ifdef CONFIG_WIN32
diff --git a/target/i386/hax-darwin.c b/target/i386/hax-posix.c
similarity index 100%
rename from target/i386/hax-darwin.c
rename to target/i386/hax-posix.c
diff --git a/target/i386/hax-darwin.h b/target/i386/hax-posix.h
similarity index 100%
rename from target/i386/hax-darwin.h
rename to target/i386/hax-posix.h
--=20
2.20.1
