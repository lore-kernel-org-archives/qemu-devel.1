Received: from eggs.gnu.org ([2001:4830:134:3::10]:60954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fGP-0001b6-37
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fGM-0007vB-SO
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fGM-0007rf-MY
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:14 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:41 -0300
Message-Id: <20180329213857.15499-3-ehabkost@redhat.com>
In-Reply-To: <20180329213857.15499-1-ehabkost@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 02/18] qmp.py: Fix error handling for Python 3
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

socket.error doesn't behave like a tuple in Python 3, but we can
use error.args on both Python 2.7 and 3.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qmp.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index 078ce65f3b..e9cb6b2683 100644
--- a/scripts/qmp/qmp.py
+++ b/scripts/qmp/qmp.py
@@ -108,7 +108,7 @@ class QEMUMonitorProtocol(object):
         try:
             self.__json_read()
         except socket.error as err:
-            if err[0] == errno.EAGAIN:
+            if err.args[0] == errno.EAGAIN:
                 # No data available
                 pass
         self.__sock.setblocking(1)
@@ -168,9 +168,9 @@ class QEMUMonitorProtocol(object):
         try:
             self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
         except socket.error as err:
-            if err[0] == errno.EPIPE:
+            if err.args[0] == errno.EPIPE:
                 return
-            raise socket.error(err)
+            raise
         resp = self.__json_read()
         self.logger.debug("<<< %s", resp)
         return resp
-- 
2.14.3
