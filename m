Received: from eggs.gnu.org ([2001:4830:134:3::10]:46284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iY-0002Aw-E9
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iX-0000CZ-J7
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:58 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:30 -0500
Message-Id: <20180619014319.28272-5-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 004/113] memfd: fix configure test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Greg Kurz <groug@kaod.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Recent glibc added memfd_create in sys/mman.h.  This conflicts with
the definition in util/memfd.c:

    /builddir/build/BUILD/qemu-2.11.0-rc1/util/memfd.c:40:12: error: static declaration of memfd_create follows non-static declaration

Fix the configure test, and remove the sys/memfd.h inclusion since the
file actually does not exist---it is a typo in the memfd_create(2) man
page.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 75e5b70e6b5dcc4f2219992d7cffa462aa406af0)
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 configure    | 2 +-
 util/memfd.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 0c6e7572db..087a82ac50 100755
--- a/configure
+++ b/configure
@@ -3920,7 +3920,7 @@ fi
 # check if memfd is supported
 memfd=no
 cat > $TMPC << EOF
-#include <sys/memfd.h>
+#include <sys/mman.h>
 
 int main(void)
 {
diff --git a/util/memfd.c b/util/memfd.c
index 4571d1aba8..412e94a405 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -31,9 +31,7 @@
 
 #include "qemu/memfd.h"
 
-#ifdef CONFIG_MEMFD
-#include <sys/memfd.h>
-#elif defined CONFIG_LINUX
+#if defined CONFIG_LINUX && !defined CONFIG_MEMFD
 #include <sys/syscall.h>
 #include <asm/unistd.h>
 
-- 
2.11.0
