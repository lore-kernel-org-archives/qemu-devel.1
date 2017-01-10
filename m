Received: from eggs.gnu.org ([2001:4830:134:3::10]:55298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cQltX-0001n3-5U
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 21:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cQltT-0008P9-QO
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 21:10:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48886
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cQltT-0008Oy-DA
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 21:10:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0A28wXv126461
	for <qemu-devel@nongnu.org>; Mon, 9 Jan 2017 21:10:35 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27vmy4u446-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 21:10:34 -0500
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 10 Jan 2017 00:10:33 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 00:10:08 -0200
In-Reply-To: <1484014214-32533-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1484014214-32533-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1484014214-32533-2-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 1/7] host-utils: Move 128-bit guard macro to
 .c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, eblake@redhat.com

It is not possible to implement functions in host-utils.c for
architectures with quadwords because the guard is implemented in the
Makefile. This patch move the guard out of the Makefile to the
implementation file.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 util/Makefile.objs | 2 +-
 util/host-utils.c  | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/util/Makefile.objs b/util/Makefile.objs
index ad0f9c7..39ae26e 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -11,7 +11,7 @@ util-obj-$(CONFIG_POSIX) += memfd.o
 util-obj-$(CONFIG_WIN32) += oslib-win32.o
 util-obj-$(CONFIG_WIN32) += qemu-thread-win32.o
 util-obj-y += envlist.o path.o module.o
-util-obj-$(call lnot,$(CONFIG_INT128)) += host-utils.o
+util-obj-y += host-utils.o
 util-obj-y += bitmap.o bitops.o hbitmap.o
 util-obj-y += fifo8.o
 util-obj-y += acl.o
diff --git a/util/host-utils.c b/util/host-utils.c
index b166e57..3495262 100644
--- a/util/host-utils.c
+++ b/util/host-utils.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 
+#ifndef CONFIG_INT128
 /* Long integer helpers */
 static inline void mul64(uint64_t *plow, uint64_t *phigh,
                          uint64_t a, uint64_t b)
@@ -158,4 +159,5 @@ int divs128(int64_t *plow, int64_t *phigh, int64_t divisor)
 
     return overflow;
 }
+#endif
 
-- 
2.7.4
