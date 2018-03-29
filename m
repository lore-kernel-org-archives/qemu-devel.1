Received: from eggs.gnu.org ([2001:4830:134:3::10]:60987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fGV-0001ha-Lp
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fGU-0008M4-QX
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fGU-0008Ja-Kr
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:22 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:42 -0300
Message-Id: <20180329213857.15499-4-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 03/18] qmp.py: Cleanly handle unexpectedly closed
 socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel@redhat.com>, Amador Pahim <apahim@redhat.com>

QEMUMonitorProtocol.cmd() returns None if the socket was closed,
so callers must handle this case explicltly.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qmp.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index e9cb6b2683..91b537ea04 100644
--- a/scripts/qmp/qmp.py
+++ b/scripts/qmp/qmp.py
@@ -73,6 +73,8 @@ class QEMUMonitorProtocol(object):
             raise QMPConnectError
         # Greeting seems ok, negotiate capabilities
         resp = self.cmd('qmp_capabilities')
+        if resp is None:
+            raise QMPConnectError("QMP connection unexpectedly closed")
         if "return" in resp:
             return greeting
         raise QMPCapabilitiesError
@@ -182,6 +184,8 @@ class QEMUMonitorProtocol(object):
         @param name: command name (string)
         @param args: command arguments (dict)
         @param cmd_id: command id (dict, list, string or int)
+        @return QMP response as a Python dict or None if the connection has
+                been closed
         """
         qmp_cmd = {'execute': name}
         if args:
@@ -195,6 +199,8 @@ class QEMUMonitorProtocol(object):
         Build and send a QMP command to the monitor, report errors if any
         """
         ret = self.cmd(cmd, kwds)
+        if ret is None:
+            raise QMPConnectError("QMP connection unexpectedly closed")
         if "error" in ret:
             raise Exception(ret['error']['desc'])
         return ret['return']
-- 
2.14.3
