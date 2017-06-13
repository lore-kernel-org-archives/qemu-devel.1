Received: from eggs.gnu.org ([2001:4830:134:3::10]:43955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKutP-0005KW-Pw
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKutO-0001xJ-TD
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:06:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKutO-0001x9-NK
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:06:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3315C04B936
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 23:06:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 20:06:26 -0300
Message-Id: <20170613230627.17942-3-ehabkost@redhat.com>
In-Reply-To: <20170613230627.17942-1-ehabkost@redhat.com>
References: <20170613230627.17942-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] scripts/qemu: Catch QEMU exit while
 waiting for QMP client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

To avoid waiting for the full 15-second timeout for a connection, check
if QEMU exited once in a while.  Start with a very short timeout (15ms),
and double it on each try.

This will be helpful for scripts/device-crash-test, on cases where QEMU
crashes or exits before connecting to the QMP socket.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 880e3e8219..5416bcfef9 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -17,6 +17,7 @@ import string
 import os
 import sys
 import subprocess
+import socket
 import qmp.qmp
 
 
@@ -118,7 +119,18 @@ class QEMUMachine(object):
                                                 debug=self._debug)
 
     def _post_launch(self):
-        self._qmp.accept()
+        # Wait for a connection while checking if QEMU is still running:
+        timeout = 0.015
+        tries = 10 # 0.015*2**10 = ~15 seconds
+        for i in range(tries):
+            try:
+                self._qmp.accept(timeout=timeout)
+                break
+            except socket.timeout:
+                if self._popen.poll():
+                    raise Exception("QEMU terminated before connecting to QMP")
+                # wait a little longer on the next try:
+                timeout *= 2
 
     def _post_shutdown(self):
         if not isinstance(self._monitor_address, tuple):
-- 
2.11.0.259.g40922b1
