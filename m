Received: from eggs.gnu.org ([2001:4830:134:3::10]:56023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhxx-0004EW-Cs
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhxv-0006wP-6d
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:37 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhxu-0006vk-Sd
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:35 -0500
Received: by mail-wr0-x244.google.com with SMTP id h1so22876631wre.12
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:34 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:13 +0100
Message-Id: <1513790098-9815-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/46] memfd: fix configure test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Recent glibc added memfd_create in sys/mman.h.  This conflicts with
the definition in util/memfd.c:

    /builddir/build/BUILD/qemu-2.11.0-rc1/util/memfd.c:40:12: error: static declaration of memfd_create follows non-static declaration

Fix the configure test, and remove the sys/memfd.h inclusion since the
file actually does not exist---it is a typo in the memfd_create(2) man
page.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure    | 2 +-
 util/memfd.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 9c8aa5a..99ccc17 100755
--- a/configure
+++ b/configure
@@ -3923,7 +3923,7 @@ fi
 # check if memfd is supported
 memfd=no
 cat > $TMPC << EOF
-#include <sys/memfd.h>
+#include <sys/mman.h>
 
 int main(void)
 {
diff --git a/util/memfd.c b/util/memfd.c
index 4571d1a..412e94a 100644
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
1.8.3.1
