Received: from eggs.gnu.org ([2001:4830:134:3::10]:54798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJe7d-00071T-9q
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJe7Z-0000Bv-AM
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:32:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eJe7Z-0000Bn-4v
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:32:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46C4F6A7C2
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 11:32:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 Nov 2017 12:32:04 +0100
Message-Id: <20171128113204.22912-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] memfd: fix configure test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: crobinso@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Recent glibc added memfd_create in sys/mman.h.  This conflicts with
the definition in util/memfd.c:

    /builddir/build/BUILD/qemu-2.11.0-rc1/util/memfd.c:40:12: error: stat=
ic declaration of memfd_create follows non-static declaration

Fix the configure test, and remove the sys/memfd.h inclusion since the
file actually does not exist---it is a typo in the memfd_create(2) man
page.

Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure    | 2 +-
 util/memfd.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index e31d6a7fee..11eac205ec 100755
--- a/configure
+++ b/configure
@@ -3910,7 +3910,7 @@ fi
 # check if memfd is supported
 memfd=3Dno
 cat > $TMPC << EOF
-#include <sys/memfd.h>
+#include <sys/mman.h>
=20
 int main(void)
 {
diff --git a/util/memfd.c b/util/memfd.c
index 4571d1aba8..412e94a405 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -31,9 +31,7 @@
=20
 #include "qemu/memfd.h"
=20
-#ifdef CONFIG_MEMFD
-#include <sys/memfd.h>
-#elif defined CONFIG_LINUX
+#if defined CONFIG_LINUX && !defined CONFIG_MEMFD
 #include <sys/syscall.h>
 #include <asm/unistd.h>
=20
--=20
2.14.3
