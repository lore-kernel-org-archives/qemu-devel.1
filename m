Received: from eggs.gnu.org ([2001:4830:134:3::10]:53689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkmop-0003pw-9O
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkmok-0007I1-DP
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:44:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dkmok-0007Ho-6g
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:44:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30A4FC047B64
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 07:44:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 24 Aug 2017 08:22:00 +0100
Message-Id: <20170824072202.26818-2-stefanha@redhat.com>
In-Reply-To: <20170824072202.26818-1-stefanha@redhat.com>
References: <20170824072202.26818-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] qemu.py: make VM() a context manager
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

There are a number of ways to ensure that the QEMU process is shut down
when the test ends, including atexit.register(), try: finally:, or
unittest.teardown() methods.  All of these require extra code and the
programmer must remember to add vm.shutdown().

A nice solution is context managers:

  with VM(binary) as vm:
      ...
  # vm is guaranteed to be shut down here

Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qemu.py | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 880e3e8219..4d8ee10943 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -21,7 +21,14 @@ import qmp.qmp
 
 
 class QEMUMachine(object):
-    '''A QEMU VM'''
+    '''A QEMU VM
+
+    Use this object as a context manager to ensure the QEMU process terminates::
+
+        with VM(binary) as vm:
+            ...
+        # vm is guaranteed to be shut down here
+    '''
 
     def __init__(self, binary, args=[], wrapper=[], name=None, test_dir="/var/tmp",
                  monitor_address=None, socket_scm_helper=None, debug=False):
@@ -40,6 +47,13 @@ class QEMUMachine(object):
         self._socket_scm_helper = socket_scm_helper
         self._debug = debug
 
+    def __enter__(self):
+        return self
+
+    def __exit__(self, exc_type, exc_val, exc_tb):
+        self.shutdown()
+        return False
+
     # This can be used to add an unused monitor instance.
     def add_monitor_telnet(self, ip, port):
         args = 'tcp:%s:%d,server,nowait,telnet' % (ip, port)
-- 
2.13.5
