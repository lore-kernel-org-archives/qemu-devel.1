Received: from eggs.gnu.org ([2001:4830:134:3::10]:50833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwywf-0007it-90
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwywe-0005Gh-7w
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwywd-0005F7-Uf
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19DA5C047B66
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 23:07:15 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Sep 2017 20:07:05 -0300
Message-Id: <20170926230709.22958-3-ehabkost@redhat.com>
In-Reply-To: <20170926230709.22958-1-ehabkost@redhat.com>
References: <20170926230709.22958-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 2/6] device-crash-test: Log detailed info on
 success too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cleber Rosa <crosa@redhat.com>

Instead of making checkOneCase() return None on success, return
detailed info even if no problems were found.  This will make
handling of device_add errors simpler, and improve debug output.

As logFailure() won't handle only failures, rename it to
logResult() and make it a bit more flexible about missing fields.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 61 ++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 598720ffa9..782d7fd6c2 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -234,6 +234,9 @@ ERROR_WHITELIST = [
     {'exitcode':-11, 'device':'arm-gicv3', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'machine':'isapc', 'device':'.*-iommu', 'loglevel':logging.ERROR, 'expected':True},
 
+    # 0 exit code means test succeeded, so we just log it as logging.DEBUG:
+    {'exitcode':0},
+
     # everything else (including SIGABRT and SIGSEGV) will be a fatal error:
     {'exitcode':None, 'fatal':True, 'loglevel':logging.FATAL},
 ]
@@ -381,8 +384,7 @@ def getBinaryInfo(args, binary):
 def checkOneCase(args, testcase):
     """Check one specific case
 
-    Returns a dictionary containing failure information on error,
-    or None on success
+    Returns a dictionary containing results of test case.
     """
     binary = testcase['binary']
     accel = testcase['accel']
@@ -397,26 +399,21 @@ def checkOneCase(args, testcase):
     dbg("will launch QEMU: %s", cmdline)
     vm = QEMUMachine(binary=binary, args=args)
 
-    exc_traceback = None
+    r = {'testcase':testcase,
+         'cmdline':cmdline}
+
     try:
         vm.launch()
     except KeyboardInterrupt:
         raise
     except:
-        exc_traceback = traceback.format_exc()
+        r['exc_traceback'] = traceback.format_exc()
         dbg("Exception while running test case")
-    finally:
-        vm.shutdown()
-        ec = vm.exitcode()
-        log = vm.get_log()
-
-    if exc_traceback is not None or ec != 0:
-        return {'exc_traceback':exc_traceback,
-                'exitcode':ec,
-                'log':log,
-                'testcase':testcase,
-                'cmdline':cmdline}
 
+    vm.shutdown()
+    r['exitcode'] = vm.exitcode()
+    r['log'] = vm.get_log()
+    return r
 
 def binariesToTest(args, testcase):
     if args.qemu:
@@ -490,17 +487,18 @@ def casesToTest(args, testcase):
     return cases
 
 
-def logFailure(f, level):
+def logResult(f, level):
     t = f['testcase']
-    logger.log(level, "failed: %s", formatTestCase(t))
+    logger.log(level, "result: %s", formatTestCase(t))
     logger.log(level, "cmdline: %s", f['cmdline'])
-    for l in f['log'].strip().split('\n'):
+    for l in f.get('log', '').strip().split('\n'):
         logger.log(level, "log: %s", l)
-    logger.log(level, "exit code: %r", f['exitcode'])
-    if f['exc_traceback']:
+    logger.log(level, "exit code: %r", f.get('exitcode'))
+    if 'exc_traceback' in f:
         logger.log(level, "exception:")
         for l in f['exc_traceback'].split('\n'):
             logger.log(level, "  %s", l.rstrip('\n'))
+    dbg('raw result dictionary: %r', f)
 
 
 def main():
@@ -579,18 +577,17 @@ def main():
         except KeyboardInterrupt:
             break
 
-        if f:
-            i, wl = checkResultWhitelist(f)
-            dbg("testcase: %r, whitelist match: %r", t, wl)
-            wl_stats.setdefault(i, []).append(f)
-            level = wl.get('loglevel', logging.DEBUG)
-            logFailure(f, level)
-            if wl.get('fatal') or (args.strict and level >= logging.WARN):
-                fatal_failures.append(f)
-        else:
-            dbg("success: %s", formatTestCase(t))
-            if expected_match:
-                logger.warn("Didn't fail as expected: %s", formatTestCase(t))
+        i, wl = checkResultWhitelist(f)
+        dbg("testcase: %r, whitelist match: %r", t, wl)
+        wl_stats.setdefault(i, []).append(f)
+        level = wl.get('loglevel', logging.DEBUG)
+        logResult(f, level)
+
+        if wl.get('fatal') or (args.strict and level >= logging.WARN):
+            fatal_failures.append(f)
+
+        if expected_match and expected_match[0] != i:
+            logger.warn("Didn't fail as expected: %s", formatTestCase(t))
 
     logger.info("Total: %d test cases", total)
     if skipped:
-- 
2.13.5
