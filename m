Received: from eggs.gnu.org ([2001:4830:134:3::10]:59921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkBO-0001aX-2V
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkBJ-00073p-HK
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dnkBJ-00073d-BH
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:32:13 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri,  1 Sep 2017 13:28:28 +0200
Message-Id: <20170901112829.2571-13-apahim@redhat.com>
In-Reply-To: <20170901112829.2571-1-apahim@redhat.com>
References: <20170901112829.2571-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v8 12/13] qemu.py: launch vm only if it's not
 running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com, Amador Pahim <apahim@redhat.com>

A new call to launch() with a running VM will fall in exception and
consequently call shutdown().

This patch makes launch() to raise an exception when it's called with VM
already running.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 03e4cc34b7..363f649a7e 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -165,6 +165,9 @@ class QEMUMachine(object):
         Try to launch the VM and make sure we cleanup and expose the
         command line/output in case of exception.
         '''
+        if self.is_running():
+            raise QEMUMachineError('VM already running')
+
         self._iolog = None
         self._qemu_full_args = None
         try:
-- 
2.13.5
