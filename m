Received: from eggs.gnu.org ([2001:4830:134:3::10]:36874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gDgLZ-0000dG-WF
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 21:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gDgLZ-0008Ha-9Z
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 21:46:33 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:43992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gDgLZ-0008Dl-1J
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 21:46:33 -0400
Received: by mail-lf1-x144.google.com with SMTP id p34-v6so26539853lfg.10
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 18:46:32 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 19 Oct 2018 18:46:12 -0700
Message-Id: <20181020014612.29736-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] linux-user: xtensa: enable bFLT support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>

- request bflt support in configure;
- implement custom linux-user/xtensa/target_flat.h that doesn't put envp
  on stack;
- fix #include "target_flat.h" in flatload.c so that it first search for
  arch-customized version of the header.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 configure                       |  1 +
 linux-user/flatload.c           |  2 +-
 linux-user/xtensa/target_flat.h | 10 ++++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 linux-user/xtensa/target_flat.h

diff --git a/configure b/configure
index 18006f0865b7..2c6b850ac690 100755
--- a/configure
+++ b/configure
@@ -7178,6 +7178,7 @@ case "$target_name" in
   ;;
   xtensa|xtensaeb)
     TARGET_ARCH=xtensa
+    bflt="yes"
     mttcg="yes"
     target_compiler=$cross_cc_xtensa
   ;;
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 10c529910fc8..2eefe55e5000 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -37,7 +37,7 @@
 
 #include "qemu.h"
 #include "flat.h"
-#include "target_flat.h"
+#include <target_flat.h>
 
 //#define DEBUG
 
diff --git a/linux-user/xtensa/target_flat.h b/linux-user/xtensa/target_flat.h
new file mode 100644
index 000000000000..732adddb0d1e
--- /dev/null
+++ b/linux-user/xtensa/target_flat.h
@@ -0,0 +1,10 @@
+/* If your arch needs to do custom stuff, create your own target_flat.h
+ * header file in linux-user/<your arch>/
+ */
+#define flat_argvp_envp_on_stack()                           0
+#define flat_reloc_valid(reloc, size)                        ((reloc) <= (size))
+#define flat_old_ram_flag(flag)                              (flag)
+#define flat_get_relocate_addr(relval)                       (relval)
+#define flat_get_addr_from_rp(rp, relval, flags, persistent) (rp)
+#define flat_set_persistent(relval, persistent)              (*persistent)
+#define flat_put_addr_at_rp(rp, addr, relval)                put_user_ual(addr, rp)
-- 
2.11.0
