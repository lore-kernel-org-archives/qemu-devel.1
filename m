Received: from eggs.gnu.org ([2001:4830:134:3::10]:41259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIz-0008QI-It
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIu-0000y4-TR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45664
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1faSIu-0000xW-Ny
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:40 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w63KnAub041155
	for <qemu-devel@nongnu.org>; Tue, 3 Jul 2018 16:53:40 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k0dp9pbyu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 16:53:39 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 3 Jul 2018 14:53:39 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  3 Jul 2018 15:52:20 -0500
In-Reply-To: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
References: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180703205221.24788-14-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 13/14] qga: systemd
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
Cc: peter.maydell@linaro.org, Daniel Henrique Barboza <danielhb413@gmail.com>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

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
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 1559753d85..cdb825993f 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1517,6 +1517,63 @@ static int run_process_child(const char *command[], Error **errp)
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
@@ -1660,6 +1717,14 @@ static void bios_supports_mode(SuspendMode mode, Error **errp)
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
@@ -1689,6 +1754,13 @@ static void guest_suspend(SuspendMode mode, Error **errp)
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
2.11.0
