Received: from eggs.gnu.org ([2001:4830:134:3::10]:36683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5UHx-0000kp-UO
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5UHu-0007VV-Mo
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:12:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e5UHu-0007UB-HF
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:12:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C0A15D5F4
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 10:12:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Oct 2017 12:12:19 +0200
Message-Id: <20171020101219.2378-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] build: disable -Wmissing-braces on older
 compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, lersek@redhat.com

GCC 4.9 and newer stopped warning for missing braces around the
"universal" C zero initializer {0}.  One such initializer sneaked
into scsi/qemu-pr-helper.c and is breaking the build with such
older GCC versions.

Detect the lack of support for the idiom, and disable the warning
in that case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        Of course it's always possible to use "memset", but {0}
        is neater in my opinion.

 configure | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configure b/configure
index 7766e74125..0b2d595c6e 100755
--- a/configure
+++ b/configure
@@ -1651,6 +1651,19 @@ EOF
   fi
 fi
 
+# Disable -Wmissing-braces on older compilers that warn even for
+# the "universal" C zero initializer {0}.
+cat > $TMPC << EOF
+struct {
+  int a[2];
+} x = {0};
+EOF
+if compile_object "-Werror" "" ; then
+  :
+else
+  QEMU_CFLAGS="$QEMU_CFLAGS -Wno-missing-braces"
+fi
+
 # Workaround for http://gcc.gnu.org/PR55489.  Happens with -fPIE/-fPIC and
 # large functions that use global variables.  The bug is in all releases of
 # GCC, but it became particularly acute in 4.6.x and 4.7.x.  It is fixed in
-- 
2.14.2
