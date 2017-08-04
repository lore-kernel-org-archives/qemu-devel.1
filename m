Received: from eggs.gnu.org ([2001:4830:134:3::10]:33714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddkGr-0007CP-1H
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 17:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddkGq-0001kc-7G
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 17:36:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ddkGq-0001in-1D
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 17:36:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 388E2883C1
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 21:36:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  4 Aug 2017 18:36:23 -0300
Message-Id: <20170804213625.3756-4-ehabkost@redhat.com>
In-Reply-To: <20170804213625.3756-1-ehabkost@redhat.com>
References: <20170804213625.3756-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 3/5] qmp-shell: execute_cmdargs()
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
Cc: armbru@redhat.com

This will allow us to execute a command that was already split in
a list.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qmp-shell | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 5fe6162..6113aaf 100755
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
