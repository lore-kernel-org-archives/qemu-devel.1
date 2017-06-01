Received: from eggs.gnu.org ([2001:4830:134:3::10]:35251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcZ-00017H-Fe
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcY-0006Cc-9s
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:51 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcY-00067A-07
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:50 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcL-0007NC-3T
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:37 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:09 +0100
Message-Id: <1496337035-30213-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/27] libvixl: Correct build failures on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Kamil Rytarowski <n54@gmx.com>

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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20170514051820.15985-1-n54@gmx.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 disas/libvixl/Makefile.objs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/disas/libvixl/Makefile.objs b/disas/libvixl/Makefile.objs
index bbe7695..860fb7f 100644
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
2.7.4
