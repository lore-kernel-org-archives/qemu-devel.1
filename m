Received: from eggs.gnu.org ([2001:4830:134:3::10]:36852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAK-0004r4-8J
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAJ-0001ZY-Hi
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTIAJ-0001Yf-9u
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:23 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67EA2C057FAC
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 01:02:23 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 16 Jan 2017 23:01:59 -0200
Message-Id: <20170117010204.4909-5-ehabkost@redhat.com>
In-Reply-To: <20170117010204.4909-1-ehabkost@redhat.com>
References: <20170117010204.4909-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 4/9] qemu.py: Make logging optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If a test case doesn't make QEMU generate any output, there's no
need to redirect stdout and stderr to a file. On those cases,
logging can be disabled so any errors are included on the test
case output.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Patch originally submitted as part of series:
* [RFC v2 00/20] qmp: Report bus information on 'query-machines'
---
 scripts/qemu.py | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 6d1b6230b7..14682864d8 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -24,13 +24,17 @@ class QEMUMachine(object):
     '''A QEMU VM'''
 
     def __init__(self, binary, args=[], wrapper=[], name=None, test_dir="/var/tmp",
-                 monitor_address=None, socket_scm_helper=None, debug=False):
+                 monitor_address=None, socket_scm_helper=None, debug=False,
+                 logging=True):
         if name is None:
             name = "qemu-%d" % os.getpid()
         if monitor_address is None:
             monitor_address = os.path.join(test_dir, name + "-monitor.sock")
         self._monitor_address = monitor_address
-        self._qemu_log_path = os.path.join(test_dir, name + ".log")
+        if logging:
+            self._qemu_log_path = os.path.join(test_dir, name + ".log")
+        else:
+            self._qemu_log_path = None
         self._popen = None
         self._binary = binary
         self._args = list(args) # Force copy args in case we modify them
@@ -91,6 +95,8 @@ class QEMUMachine(object):
         return self._popen.pid
 
     def _load_io_log(self):
+        if self._qemu_log_path is None:
+            return
         with open(self._qemu_log_path, "r") as fh:
             self._iolog = fh.read()
 
@@ -115,17 +121,24 @@ class QEMUMachine(object):
     def _post_shutdown(self):
         if not isinstance(self._monitor_address, tuple):
             self._remove_if_exists(self._monitor_address)
-        self._remove_if_exists(self._qemu_log_path)
+        if self._qemu_log_path is not None:
+            self._remove_if_exists(self._qemu_log_path)
 
     def launch(self):
         '''Launch the VM and establish a QMP connection'''
         devnull = open('/dev/null', 'rb')
-        qemulog = open(self._qemu_log_path, 'wb')
+        if self._qemu_log_path is not None:
+            qemulog = open(self._qemu_log_path, 'wb')
+            stdout=qemulog
+            stderr=subprocess.STDOUT
+        else:
+            stdout=None
+            stderr=None
         try:
             self._pre_launch()
             args = self._wrapper + [self._binary] + self._base_args() + self._args
-            self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
-                                           stderr=subprocess.STDOUT, shell=False)
+            self._popen = subprocess.Popen(args, stdin=devnull, stdout=stdout,
+                                           stderr=stderr, shell=False)
             self._post_launch()
         except:
             if self._popen:
-- 
2.11.0.259.g40922b1
