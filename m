Received: from eggs.gnu.org ([2001:4830:134:3::10]:53944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1euIYt-0008IU-SG
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1euIYp-0003Mm-HC
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:59:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1euIYp-0003Me-CG
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:59:51 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  9 Mar 2018 14:59:45 +0100
Message-Id: <20180309135945.20436-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] build: try improve handling of clang
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This patch disables the pragma diagnostic -Wunused-but-set-variable for
clang in util/coroutine-ucontext.c.

This in turn allows us to remove it from the configure check, so the
CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE will succeed for clang.

With that in place clang builds (linux) will use -Werror by default,
which breaks the build due to warning about unaligned struct members.

Just turning off this warning isn't a good idea as it indicates
portability problems.  So make it a warning again, using
-Wno-error=3Daddress-of-packed-member.  That way it doesn't break the
build but still shows up in the logs.

Now clang builds qemu without errors.  Well, almost.  There are some
left in the rdma code.  Leaving that to the rdma people.  All others can
use --disable-rdma to workarounds this.

Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure                 | 2 +-
 util/coroutine-ucontext.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 6f3921c02a..3a12173c83 100755
--- a/configure
+++ b/configure
@@ -1692,6 +1692,7 @@ gcc_flags=3D"-Wno-missing-include-dirs -Wempty-body=
 -Wnested-externs $gcc_flags"
 gcc_flags=3D"-Wendif-labels -Wno-shift-negative-value $gcc_flags"
 gcc_flags=3D"-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flag=
s"
 gcc_flags=3D"-Wno-string-plus-int $gcc_flags"
+gcc_flags=3D"-Wno-error=3Daddress-of-packed-member $gcc_flags"
 # Note that we do not add -Werror to gcc_flags here, because that would
 # enable it for all configure tests. If a configure test failed due
 # to -Werror this would just silently disable some features,
@@ -4860,7 +4861,6 @@ fi
 pragma_disable_unused_but_set=3Dno
 cat > $TMPC << EOF
 #pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
 #pragma GCC diagnostic ignored "-Wstrict-prototypes"
 #pragma GCC diagnostic pop
=20
diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index 926d3402e3..090ba21a13 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -170,7 +170,7 @@ Coroutine *qemu_coroutine_new(void)
 }
=20
 #ifdef CONFIG_VALGRIND_H
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
+#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
 /* Work around an unused variable in the valgrind.h macro... */
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wunused-but-set-variable"
@@ -179,7 +179,7 @@ static inline void valgrind_stack_deregister(Coroutin=
eUContext *co)
 {
     VALGRIND_STACK_DEREGISTER(co->valgrind_stack_id);
 }
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
+#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
 #pragma GCC diagnostic pop
 #endif
 #endif
--=20
2.9.3
