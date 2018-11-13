Received: from eggs.gnu.org ([2001:4830:134:3::10]:35456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gMcAC-0006qZ-Mm
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gMbyn-0005u2-NM
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:55:59 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:33129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1gMbyl-0005hp-Pm
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:55:57 -0500
Received: by mail-qk1-x743.google.com with SMTP id o89so20607640qko.0
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 08:55:50 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue, 13 Nov 2018 14:55:39 -0200
Message-Id: <20181113165539.14376-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/1] qga: update docs with systemd suspend
 support info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, mdroth@linux.vnet.ibm.com, Daniel Henrique Barboza <danielhb413@gmail.com>

Commit 067927d62e ("qga: systemd hibernate/suspend/hybrid-sleep
support") failed to update qapi-schema.json after adding systemd
hibernate/suspend/hybrid-sleep capabilities to guest-suspend-* QGA
commands.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 qga/qapi-schema.json | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c6725b3ec8..61f66fc461 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -532,12 +532,12 @@
 #
 # Suspend guest to disk.
 #
-# This command tries to execute the scripts provided by the pm-utils package.
-# If it's not available, the suspend operation will be performed by manually
-# writing to a sysfs file.
+# This command attempts to suspend the guest using three strategies, in this
+# order:
 #
-# For the best results it's strongly recommended to have the pm-utils
-# package installed in the guest.
+# - systemd hibernate
+# - pm-utils (via pm-hibernate)
+# - manual write into sysfs
 #
 # This command does NOT return a response on success. There is a high chance
 # the command succeeded if the VM exits with a zero exit status or, when
@@ -560,12 +560,12 @@
 #
 # Suspend guest to ram.
 #
-# This command tries to execute the scripts provided by the pm-utils package.
-# If it's not available, the suspend operation will be performed by manually
-# writing to a sysfs file.
+# This command attempts to suspend the guest using three strategies, in this
+# order:
 #
-# For the best results it's strongly recommended to have the pm-utils
-# package installed in the guest.
+# - systemd suspend
+# - pm-utils (via pm-suspend)
+# - manual write into sysfs
 #
 # IMPORTANT: guest-suspend-ram requires QEMU to support the 'system_wakeup'
 # command.  Thus, it's *required* to query QEMU for the presence of the
@@ -592,7 +592,10 @@
 #
 # Save guest state to disk and suspend to ram.
 #
-# This command requires the pm-utils package to be installed in the guest.
+# This command attempts to suspend the guest by executing, in this order:
+#
+# - systemd hybrid-sleep
+# - pm-utils (via pm-suspend-hybrid)
 #
 # IMPORTANT: guest-suspend-hybrid requires QEMU to support the 'system_wakeup'
 # command.  Thus, it's *required* to query QEMU for the presence of the
-- 
2.19.1
