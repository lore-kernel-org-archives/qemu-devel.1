Received: from eggs.gnu.org ([2001:4830:134:3::10]:55053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dv4FS-000455-HJ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dv4FO-0003ik-By
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:22:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dv4FO-0003ge-67
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:22:42 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 21 Sep 2017 13:22:34 -0300
Message-Id: <20170921162234.847-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu.py: Call logging.basicConfig()
 automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>, Fam Zheng <famz@redhat.com>, ldoktor@redhat.com, stefanha@gmail.com, armbru@redhat.com, mreitz@redhat.com

Not all scripts using qemu.py configure the Python logging
module, and end up generating a "No handlers could be found for
logger" message instead of actual log messages.

To avoid requiring every script using qemu.py to configure
logging manually, call basicConfig() when creating a QEMUMachine
object.  This won't affect scripts that already set up logging,
but will ensure that scripts that don't configure logging keep
working.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Fixes: 4738b0a85a0c2031fddc71b51cccebce0c4ba6b1
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 5e02dd8e78..73d6031e02 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -89,6 +89,9 @@ class QEMUMachine(object):
         self._qmp = None
         self._qemu_full_args = None
 
+        # just in case logging wasn't configured by the main script:
+        logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
+
     def __enter__(self):
         return self
 
-- 
2.13.5
