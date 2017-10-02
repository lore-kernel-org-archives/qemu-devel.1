Received: from eggs.gnu.org ([2001:4830:134:3::10]:39301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dyw8O-0001b5-S7
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dyw8K-0001sX-Tp
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:31:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dyw8K-0001rU-O2
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:31:24 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Mon, 02 Oct 2017 11:30:58 +0300
Message-id: <1506933058-28313-2-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1506933058-28313-1-git-send-email-a.perevalov@samsung.com>
In-reply-to: <20170929143812.GG11930@redhat.com>
References: <1506933058-28313-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171002083119eucas1p1a73232b22e354c9b27dbc4c0b9b78907@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH] Makefile: don't use LINKPROG for
 tests/migration/stress
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, i.maximets@samsung.com, berrange@redhat.com, heetae82.ahn@samsung.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com
List-ID: <qemu-devel.nongnu.org>

This patch just replaces  LINKPROG for CC.
LINKPROG invokes both CXX and CC.
So in case of static linking of C source, static libstdc++
is required by build, but it could be missing in system.
And static libstdc++ may not be needed for whole QEMU.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index abc6707..bf94516 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -803,7 +803,7 @@ tests/numa-test$(EXESUF): tests/numa-test.o
 tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
-	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
+	$(call quiet-command, $(CC) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
 
 INITRD_WORK_DIR=tests/migration/initrd
 
-- 
2.7.4
