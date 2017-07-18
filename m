Received: from eggs.gnu.org ([2001:4830:134:3::10]:48639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXKwK-0000VX-T0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXKwH-0005Zx-N0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:20:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dXKwH-0005ZM-Cn
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:20:53 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6I5JMBt003400
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:20:52 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bs9y7cm6a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:20:52 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 17 Jul 2017 23:20:51 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 00:20:11 -0500
In-Reply-To: <1500355216-23603-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1500355216-23603-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1500355216-23603-4-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/8] qemu-ga: check if utmpx.h is available on
 the system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

From: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

Commit 161a56a9065 added command guest-get-users and requires the
utmpx.h (defined by POSIX) to work. It is however not always available
(e.g. on OpenBSD) therefor a check for its existence is necessary.

Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 configure            | 19 +++++++++++++++++++
 qga/commands-posix.c | 17 ++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index a3f0522..e8798ce 100755
--- a/configure
+++ b/configure
@@ -4915,6 +4915,21 @@ if compile_prog "" "" ; then
 fi
=20
 ##########################################
+# check for utmpx.h, it is missing e.g. on OpenBSD
+
+have_utmpx=3Dno
+cat > $TMPC << EOF
+#include <utmpx.h>
+struct utmpx user_info;
+int main(void) {
+    return 0;
+}
+EOF
+if compile_prog "" "" ; then
+    have_utmpx=3Dyes
+fi
+
+##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
=20
@@ -5959,6 +5974,10 @@ if test "$have_static_assert" =3D "yes" ; then
   echo "CONFIG_STATIC_ASSERT=3Dy" >> $config_host_mak
 fi
=20
+if test "$have_utmpx" =3D "yes" ; then
+  echo "HAVE_UTMPX=3Dy" >> $config_host_mak
+fi
+
 # Hold two types of flag:
 #   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the nam=
e on
 #                                     a thread we have a handle to
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index d8e4122..e7a047e 100644
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
=20
+#ifdef HAVE_UTMPX
+#include <utmpx.h>
+#endif
+
 #ifndef CONFIG_HAS_ENVIRON
 #ifdef __APPLE__
 #include <crt_externs.h>
@@ -2519,6 +2522,8 @@ void ga_command_state_init(GAState *s, GACommandSta=
te *cs)
 #endif
 }
=20
+#ifdef HAVE_UTMPX
+
 #define QGA_MICRO_SECOND_TO_SECOND 1000000
=20
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
--=20
2.7.4
