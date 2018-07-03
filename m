Received: from eggs.gnu.org ([2001:4830:134:3::10]:41325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSJ1-0008Qc-GD
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIw-0000yv-27
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56956
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1faSIv-0000yb-SQ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w63KnCd7063035
	for <qemu-devel@nongnu.org>; Tue, 3 Jul 2018 16:53:41 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k0ft1snua-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 16:53:41 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 3 Jul 2018 14:53:40 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  3 Jul 2018 15:52:21 -0500
In-Reply-To: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
References: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180703205221.24788-15-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 14/14] qga: removing bios_supports_mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Daniel Henrique Barboza <danielhb413@gmail.com>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

bios_support_mode verifies if the guest has support for a certain
suspend mode but it doesn't inform back which suspend tool
provides it. The caller, guest_suspend, executes all suspend
strategies in order again.

After adding systemd suspend support, bios_support_mode now will
verify for support for systemd, then pmutils, then Linux sys state
file. In a worst case scenario where both systemd and pmutils isn't
supported but Linux sys state is:

- bios_supports_mode will check for systemd, then pmutils, then
Linux sys state. It will tell guest_suspend that there is support,
but it will not tell who provides it;

- guest_suspend will try to execute (and fail) systemd suspend,
then pmutils suspend, to only then use the Linux sys suspend.
The time spent executing systemd and pmutils suspend was wasted
and could be avoided, but only bios_support_mode knew it but
didn't inform it back.

A quicker approach is to nuke bios_supports_mode and control
whether we found support at all with a bool flag inside
guest_suspend. guest_suspend will search for suspend support
and execute it as soon as possible. If the a given suspend
mechanism fails, continue to the next. If no suspend
support is found, the "not supported" message is still being
sent back to the user.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 58 ++++++++++++++++------------------------------------
 1 file changed, 18 insertions(+), 40 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index cdb825993f..233f78a406 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1712,64 +1712,42 @@ static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
 
 }
 
-static void bios_supports_mode(SuspendMode mode, Error **errp)
-{
-    Error *local_err = NULL;
-    bool ret;
-
-    ret = systemd_supports_mode(mode, &local_err);
-    if (ret) {
-        return;
-    }
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-    ret = pmutils_supports_mode(mode, &local_err);
-    if (ret) {
-        return;
-    }
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-    ret = linux_sys_state_supports_mode(mode, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-    if (!ret) {
-        error_setg(errp,
-                   "the requested suspend mode is not supported by the guest");
-    }
-}
-
 static void guest_suspend(SuspendMode mode, Error **errp)
 {
     Error *local_err = NULL;
+    bool mode_supported = false;
 
-    bios_supports_mode(mode, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+    if (systemd_supports_mode(mode, &local_err)) {
+        mode_supported = true;
+        systemd_suspend(mode, &local_err);
     }
 
-    systemd_suspend(mode, &local_err);
     if (!local_err) {
         return;
     }
 
     error_free(local_err);
 
-    pmutils_suspend(mode, &local_err);
+    if (pmutils_supports_mode(mode, &local_err)) {
+        mode_supported = true;
+        pmutils_suspend(mode, &local_err);
+    }
+
     if (!local_err) {
         return;
     }
 
     error_free(local_err);
 
-    linux_sys_state_suspend(mode, &local_err);
-    if (local_err) {
+    if (linux_sys_state_supports_mode(mode, &local_err)) {
+        mode_supported = true;
+        linux_sys_state_suspend(mode, &local_err);
+    }
+
+    if (!mode_supported) {
+        error_setg(errp,
+                   "the requested suspend mode is not supported by the guest");
+    } else if (local_err) {
         error_propagate(errp, local_err);
     }
 }
-- 
2.11.0
