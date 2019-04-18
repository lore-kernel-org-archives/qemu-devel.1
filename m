Received: from eggs.gnu.org ([209.51.188.92]:54680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0Z-00057j-G6
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0V-0005HN-KW
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0V-0005F6-2Z
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39B3519CBCD
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 09A7C19C79
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:42 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 18 Apr 2019 22:51:35 +0200
Message-Id: <20190418205135.6686-37-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-4.1 36/36] include: Move fprintf_function to
 disas/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The previous commits have eliminated fprintf_function outside
disassemblers, simplifying code and cleaning up the ugly type-punning
fprintf_function seems to attract.  Move fprintf_function to
include/disas/dis-asm.h to reduce the temptation to abuse it.

I considered renaming it to fprintf_ftype (reverting that part of
commit 6e2d864edf5, v0.14.0) to get us closer to binutils, but I
figure the fork is too distant to make this worthwhile.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190417191805.28198-18-armbru@redhat.com>
---
 include/disas/dis-asm.h   |  5 +++--
 include/qemu/fprintf-fn.h | 14 --------------
 2 files changed, 3 insertions(+), 16 deletions(-)
 delete mode 100644 include/qemu/fprintf-fn.h

diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index 41b61c85f9..9240ec32c2 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -9,8 +9,6 @@
 #ifndef DISAS_BFD_H
 #define DISAS_BFD_H
 
-#include "qemu/fprintf-fn.h"
-
 typedef void *PTR;
 typedef uint64_t bfd_vma;
 typedef int64_t bfd_signed_vma;
@@ -243,6 +241,9 @@ typedef struct symbol_cache_entry
     } udata;
 } asymbol;
 
+typedef int (*fprintf_function)(FILE *f, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
+
 enum dis_insn_type {
   dis_noninsn,			/* Not a valid instruction */
   dis_nonbranch,		/* Not a branch instruction */
diff --git a/include/qemu/fprintf-fn.h b/include/qemu/fprintf-fn.h
deleted file mode 100644
index 9068a960b3..0000000000
--- a/include/qemu/fprintf-fn.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * Typedef for fprintf-alike function pointers.
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef QEMU_FPRINTF_FN_H
-#define QEMU_FPRINTF_FN_H
-
-typedef int (*fprintf_function)(FILE *f, const char *fmt, ...)
-    GCC_FMT_ATTR(2, 3);
-
-#endif
-- 
2.17.2
