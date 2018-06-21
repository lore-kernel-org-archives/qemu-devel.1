Received: from eggs.gnu.org ([2001:4830:134:3::10]:53308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVwjP-0002s4-D0
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVwjO-0001gf-Dv
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:22:23 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:34308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fVwjO-0001gW-8e
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:22:22 -0400
Received: by mail-qt0-x236.google.com with SMTP id d3-v6so2336071qto.1
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 03:22:22 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 21 Jun 2018 07:21:53 -0300
Message-Id: <20180621102153.28443-7-danielhb413@gmail.com>
In-Reply-To: <20180621102153.28443-1-danielhb413@gmail.com>
References: <20180621102153.28443-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v2 6/6] qga: removing bios_supports_mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, marcandre.lureau@gmail.com, Daniel Henrique Barboza <danielhb413@gmail.com>

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
---
 qga/commands-posix.c | 54 +++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 36 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 3546b74fed..d0d38cb7d9 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1676,60 +1676,42 @@ static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
 
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
2.17.1
