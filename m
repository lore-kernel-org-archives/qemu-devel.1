Received: from eggs.gnu.org ([2001:4830:134:3::10]:50499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emNS1-0007HO-Tm
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:36:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emNRy-0001Fl-Qc
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:36:05 -0500
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:38385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emNRy-0001Fe-Lw
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:36:02 -0500
Received: by mail-qt0-x22c.google.com with SMTP id k13so595962qtg.5
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 09:36:02 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 14:35:39 -0300
Message-Id: <20180215173539.11033-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] capstone: fix building using system package
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Mike Frysinger <vapier@gentoo.org>, Sergei Trofimovich <slyfox@gentoo.org>, =?UTF-8?q?Zolt=C3=A1n=20Mizsei?= <miqlas@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

The use of <capstone/capstone.h> is recommended by the upstream project:
  http://www.capstone-engine.org/lang_c.html
However when building the in-tree cloned submodule, the header is accessible
via <capstone.h>.

This fixes building on Gentoo (and Haiku OS - not supported since 898be3e0415):
    CC      disas.o
  /sources/qemu-2.11.0/include/disas/capstone.h:6:22: fatal error: capstone.h: No such file or directory
  #include <capstone.h>
           ^~~~~~~~~~~~

On Haiku `pkg-config --cflags capstone` reports "-I/usr/develop/headers".

Bug: https://bugs.gentoo.org/647570
Reported-by: Zoltán Mizsei <miqlas@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because this might be a Gentoo portage issue.

 configure                | 1 +
 include/disas/capstone.h | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 913e14839d..3657a61a35 100755
--- a/configure
+++ b/configure
@@ -7017,6 +7017,7 @@ if [ "$dtc_internal" = "yes" ]; then
   echo "config-host.h: subdir-dtc" >> $config_host_mak
 fi
 if [ "$capstone" = "git" -o "$capstone" = "internal" ]; then
+  echo "CONFIG_LIBCAPSTONE_INTERNAL=y" >> $config_host_mak
   echo "config-host.h: subdir-capstone" >> $config_host_mak
 fi
 if test -n "$LIBCAPSTONE"; then
diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index 84e214956d..aea9601f41 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -3,9 +3,13 @@
 
 #ifdef CONFIG_CAPSTONE
 
+#ifdef CONFIG_LIBCAPSTONE_INTERNAL
 #include <capstone.h>
-
 #else
+#include <capstone/capstone.h>
+#endif /* CONFIG_LIBCAPSTONE_INTERNAL */
+
+#else /* CONFIG_CAPSTONE */
 
 /* Just enough to allow backends to init without ifdefs.  */
 
-- 
2.16.1
