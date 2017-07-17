Received: from eggs.gnu.org ([2001:4830:134:3::10]:50304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dX6Xp-0000w9-IZ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dX6Xl-0005MU-KW
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:58:41 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dX6Xl-0005Lm-DS
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:58:37 -0400
Received: by mail-wm0-f51.google.com with SMTP id w126so76929676wme.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 06:58:36 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Mon, 17 Jul 2017 15:58:33 +0200
Message-Id: <8c99564250c916aa0bd3484071bbb0f1ad4d8cf3.1500299896.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] qemu-ga: check if utmpx.h is available on the
 system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Commit 161a56a9065 added command guest-get-users and requires the
utmpx.h (defined by POSIX) to work. It is however not always available
(e.g. on OpenBSD) therefor a check for its existence is necessary.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 configure            | 19 +++++++++++++++++++
 qga/commands-posix.c | 17 ++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index a3f0522e8f..e8798cec79 100755
--- a/configure
+++ b/configure
@@ -4915,6 +4915,21 @@ if compile_prog "" "" ; then
 fi
 
 ##########################################
+# check for utmpx.h, it is missing e.g. on OpenBSD
+
+have_utmpx=no
+cat > $TMPC << EOF
+#include <utmpx.h>
+struct utmpx user_info;
+int main(void) {
+    return 0;
+}
+EOF
+if compile_prog "" "" ; then
+    have_utmpx=yes
+fi
+
+##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
 
@@ -5959,6 +5974,10 @@ if test "$have_static_assert" = "yes" ; then
   echo "CONFIG_STATIC_ASSERT=y" >> $config_host_mak
 fi
 
+if test "$have_utmpx" = "yes" ; then
+  echo "HAVE_UTMPX=y" >> $config_host_mak
+fi
+
 # Hold two types of flag:
 #   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the name on
 #                                     a thread we have a handle to
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index d8e412275e..e7a047e4c2 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -15,7 +15,6 @@
 #include <sys/ioctl.h>
 #include <sys/wait.h>
 #include <dirent.h>
-#include <utmpx.h>
 #include "qga/guest-agent-core.h"
 #include "qga-qmp-commands.h"
 #include "qapi/qmp/qerror.h"
@@ -25,6 +24,10 @@
 #include "qemu/base64.h"
 #include "qemu/cutils.h"
 
+#ifdef HAVE_UTMPX
+#include <utmpx.h>
+#endif
+
 #ifndef CONFIG_HAS_ENVIRON
 #ifdef __APPLE__
 #include <crt_externs.h>
@@ -2519,6 +2522,8 @@ void ga_command_state_init(GAState *s, GACommandState *cs)
 #endif
 }
 
+#ifdef HAVE_UTMPX
+
 #define QGA_MICRO_SECOND_TO_SECOND 1000000
 
 static double ga_get_login_time(struct utmpx *user_info)
@@ -2577,3 +2582,13 @@ GuestUserList *qmp_guest_get_users(Error **err)
     g_hash_table_destroy(cache);
     return head;
 }
+
+#else
+
+GuestUserList *qmp_guest_get_users(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
+
+#endif
-- 
2.13.1
