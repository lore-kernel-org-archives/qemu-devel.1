Received: from eggs.gnu.org ([2001:4830:134:3::10]:53292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVwjN-0002qK-Aj
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVwjM-0001g6-Bq
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:22:21 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:36198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fVwjM-0001g1-73
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:22:20 -0400
Received: by mail-qt0-x234.google.com with SMTP id o9-v6so2320716qtp.3
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 03:22:20 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 21 Jun 2018 07:21:52 -0300
Message-Id: <20180621102153.28443-6-danielhb413@gmail.com>
In-Reply-To: <20180621102153.28443-1-danielhb413@gmail.com>
References: <20180621102153.28443-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v2 5/6] qga: systemd
 hibernate/suspend/hybrid-sleep support
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

pmutils isn't being supported by newer OSes like Fedora 27
or Mint. This means that the only suspend option QGA offers
for these guests are writing directly into the Linux sys state
file. This also means that QGA also loses the ability to do
hybrid suspend in those guests - this suspend mode is only
available when using pmutils.

Newer guests can use systemd facilities to do all the suspend
types QGA supports. The mapping in comparison with pmutils is:

- pm-hibernate -> systemctl hibernate
- pm-suspend -> systemctl suspend
- pm-suspend-hybrid -> systemctl hybrid-sleep

To discover whether systemd supports these functions, we inspect
the status of the services that implements them.

With this patch, we can offer hybrid suspend again for newer
guests that do not have pmutils support anymore.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 qga/commands-posix.c | 72 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 925544ae6d..3546b74fed 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1481,6 +1481,63 @@ static int run_process_child(const char *command[], Error **errp)
     return -1;
 }
 
+static bool systemd_supports_mode(SuspendMode mode, Error **errp)
+{
+    Error *local_err = NULL;
+    const char *systemctl_args[3] = {"systemd-hibernate", "systemd-suspend",
+                                     "systemd-hybrid-sleep"};
+    const char *cmd[4] = {"systemctl", "status", systemctl_args[mode], NULL};
+    int status;
+
+    status = run_process_child(cmd, &local_err);
+
+    /*
+     * systemctl status uses LSB return codes so we can expect
+     * status > 0 and be ok. To assert if the guest has support
+     * for the selected suspend mode, status should be < 4. 4 is
+     * the code for unknown service status, the return value when
+     * the service does not exist. A common value is status = 3
+     * (program is not running).
+     */
+    if (status > 0 && status < 4) {
+        return true;
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
+
+    return false;
+}
+
+static void systemd_suspend(SuspendMode mode, Error **errp)
+{
+    Error *local_err = NULL;
+    const char *systemctl_args[3] = {"hibernate", "suspend", "hybrid-sleep"};
+    const char *cmd[3] = {"systemctl", systemctl_args[mode], NULL};
+    int status;
+
+    status = run_process_child(cmd, &local_err);
+
+    if (status == 0) {
+        return;
+    }
+
+    if ((status == -1) && !local_err) {
+        error_setg(errp, "the helper program 'systemctl %s' was not found",
+                   systemctl_args[mode]);
+        return;
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+    } else {
+        error_setg(errp, "the helper program 'systemctl %s' returned an "
+                   "unexpected exit status code (%d)",
+                   systemctl_args[mode], status);
+    }
+}
+
 static bool pmutils_supports_mode(SuspendMode mode, Error **errp)
 {
     Error *local_err = NULL;
@@ -1624,6 +1681,14 @@ static void bios_supports_mode(SuspendMode mode, Error **errp)
     Error *local_err = NULL;
     bool ret;
 
+    ret = systemd_supports_mode(mode, &local_err);
+    if (ret) {
+        return;
+    }
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     ret = pmutils_supports_mode(mode, &local_err);
     if (ret) {
         return;
@@ -1649,6 +1714,13 @@ static void guest_suspend(SuspendMode mode, Error **errp)
         return;
     }
 
+    systemd_suspend(mode, &local_err);
+    if (!local_err) {
+        return;
+    }
+
+    error_free(local_err);
+
     pmutils_suspend(mode, &local_err);
     if (!local_err) {
         return;
-- 
2.17.1
