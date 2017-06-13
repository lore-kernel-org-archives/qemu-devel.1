Received: from eggs.gnu.org ([2001:4830:134:3::10]:43941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKutP-0005KT-Bu
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKutM-0001wz-Vm
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:06:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKutM-0001wr-Pm
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:06:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E170F85365
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 23:06:31 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 20:06:25 -0300
Message-Id: <20170613230627.17942-2-ehabkost@redhat.com>
In-Reply-To: <20170613230627.17942-1-ehabkost@redhat.com>
References: <20170613230627.17942-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] scripts/qmp: Accept timeout parameter on
 accept()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Shorter timeouts will be useful for test code that needs to catch QEMU
exiting before it connects to the QMP socket.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qmp.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index 62d3651967..1b27064d91 100644
--- a/scripts/qmp/qmp.py
+++ b/scripts/qmp/qmp.py
@@ -132,7 +132,7 @@ class QEMUMonitorProtocol:
         if negotiate:
             return self.__negotiate_capabilities()
 
-    def accept(self):
+    def accept(self, timeout=15):
         """
         Await connection from QMP Monitor and perform capabilities negotiation.
 
@@ -141,7 +141,7 @@ class QEMUMonitorProtocol:
         @raise QMPConnectError if the greeting is not received
         @raise QMPCapabilitiesError if fails to negotiate capabilities
         """
-        self.__sock.settimeout(15)
+        self.__sock.settimeout(timeout)
         self.__sock, _ = self.__sock.accept()
         self.__sockfile = self.__sock.makefile()
         return self.__negotiate_capabilities()
-- 
2.11.0.259.g40922b1
