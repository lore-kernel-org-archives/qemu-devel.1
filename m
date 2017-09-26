Received: from eggs.gnu.org ([2001:4830:134:3::10]:50853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwywg-0007jU-Kl
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwywf-0005KE-SF
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwywf-0005Ig-Lh
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4F46883AE
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 23:07:16 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Sep 2017 20:07:06 -0300
Message-Id: <20170926230709.22958-4-ehabkost@redhat.com>
In-Reply-To: <20170926230709.22958-1-ehabkost@redhat.com>
References: <20170926230709.22958-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 3/6] device-crash-test: Allow checkOneCase() to
 report multiple results
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

This will allow the test code to be improved to test multiple
devices in a single run.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 782d7fd6c2..0bd599d395 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -384,7 +384,8 @@ def getBinaryInfo(args, binary):
 def checkOneCase(args, testcase):
     """Check one specific case
 
-    Returns a dictionary containing results of test case.
+    Generates a list of dictionaries containing results of testing.  If
+    multiple devices are being tested, multiple entries can be returned.
     """
     binary = testcase['binary']
     accel = testcase['accel']
@@ -413,7 +414,7 @@ def checkOneCase(args, testcase):
     vm.shutdown()
     r['exitcode'] = vm.exitcode()
     r['log'] = vm.get_log()
-    return r
+    yield r
 
 def binariesToTest(args, testcase):
     if args.qemu:
@@ -572,22 +573,20 @@ def main():
         if args.dry_run:
             continue
 
-        try:
-            f = checkOneCase(args, t)
-        except KeyboardInterrupt:
-            break
 
-        i, wl = checkResultWhitelist(f)
-        dbg("testcase: %r, whitelist match: %r", t, wl)
-        wl_stats.setdefault(i, []).append(f)
-        level = wl.get('loglevel', logging.DEBUG)
-        logResult(f, level)
+        for r in checkOneCase(args, t):
+            i, wl = checkResultWhitelist(r)
+            dbg("testcase: %r, whitelist match: %r", t, wl)
+            wl_stats.setdefault(i, []).append(r)
+            level = wl.get('loglevel', logging.DEBUG)
+            logResult(r, level)
+
+            if wl.get('fatal') or (args.strict and level >= logging.WARN):
+                fatal_failures.append(r)
 
-        if wl.get('fatal') or (args.strict and level >= logging.WARN):
-            fatal_failures.append(f)
+            if expected_match and expected_match[0] != i:
+                logger.warn("Didn't fail as expected: %s", formatTestCase(t))
 
-        if expected_match and expected_match[0] != i:
-            logger.warn("Didn't fail as expected: %s", formatTestCase(t))
 
     logger.info("Total: %d test cases", total)
     if skipped:
-- 
2.13.5
