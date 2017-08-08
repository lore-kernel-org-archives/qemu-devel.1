Received: from eggs.gnu.org ([2001:4830:134:3::10]:57728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dfBID-0008LU-AD
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dfBIB-0000Sw-Vn
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:39:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dfBIB-0000SS-PI
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:39:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD65F3A92E3
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 20:39:54 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  8 Aug 2017 17:39:33 -0300
Message-Id: <20170808203935.30021-4-ehabkost@redhat.com>
In-Reply-To: <20170808203935.30021-1-ehabkost@redhat.com>
References: <20170808203935.30021-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 v2 3/5] qmp-shell: execute_cmdargs()
 method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>

This will allow us to execute a command that was already split in
a list.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* (none)
---
 scripts/qmp/qmp-shell | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index f93c1cf..4b9a420 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -260,7 +260,9 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         print str(jsobj)
 
     def _execute_cmd(self, cmdline):
-        cmdargs = cmdline.split()
+        return self.execute_cmdargs(cmdline.split())
+
+    def execute_cmdargs(self, cmdargs):
         try:
             qmpcmd = self.__build_cmd(cmdargs)
         except Exception as e:
@@ -386,6 +388,9 @@ class HMPShell(QMPShell):
             print '%s: %s' % (resp['error']['class'], resp['error']['desc'])
         return True
 
+    def execute_cmdargs(self, cmdargs):
+        return self._execute_cmd(' '.join(cmdargs))
+
     def show_banner(self):
         QMPShell.show_banner(self, msg='Welcome to the HMP shell!')
 
-- 
2.9.4
