Received: from eggs.gnu.org ([2001:4830:134:3::10]:52546)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1d9m34-0007sI-VG
	for qemu-devel@nongnu.org; Sun, 14 May 2017 01:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1d9m31-0001Xi-Q4
	for qemu-devel@nongnu.org; Sun, 14 May 2017 01:26:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:50769)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1d9m31-0001Wa-F6
	for qemu-devel@nongnu.org; Sun, 14 May 2017 01:26:27 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Sun, 14 May 2017 07:18:20 +0200
Message-Id: <20170514051820.15985-1-n54@gmx.com>
Subject: [Qemu-devel] [PATCH] libvixl: Correct build failures on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, claudio.fontana@gmail.com, f4bug@amsat.org, Kamil Rytarowski <n54@gmx.com>

Ensure that C99 macros are defined regardless of the inclusion order of
headers in vixl. This is required at least on NetBSD.

The vixl/globals.h headers defines __STDC_CONSTANT_MACROS and must be
included before other system headers.

This file defines unconditionally the following macros, without altering
the original sources:
 - __STDC_CONSTANT_MACROS
 - __STDC_LIMIT_MACROS
 - __STDC_FORMAT_MACROS

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
---
 disas/libvixl/Makefile.objs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/disas/libvixl/Makefile.objs b/disas/libvixl/Makefile.objs
index bbe7695fdb..860fb7f384 100644
--- a/disas/libvixl/Makefile.objs
+++ b/disas/libvixl/Makefile.objs
@@ -7,5 +7,8 @@ libvixl_OBJS = vixl/utils.o \
 # The -Wno-sign-compare is needed only for gcc 4.6, which complains about
 # some signed-unsigned equality comparisons which later gcc versions do not.
 $(addprefix $(obj)/,$(libvixl_OBJS)): QEMU_CFLAGS := -I$(SRC_PATH)/disas/libvixl $(QEMU_CFLAGS) -Wno-sign-compare
+# Ensure that C99 macros are defined regardless of the inclusion order of
+# headers in vixl. This is required at least on NetBSD.
+$(addprefix $(obj)/,$(libvixl_OBJS)): QEMU_CFLAGS += -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -D__STDC_FORMAT_MACROS
 
 common-obj-$(CONFIG_ARM_A64_DIS) += $(libvixl_OBJS)
-- 
2.12.2
