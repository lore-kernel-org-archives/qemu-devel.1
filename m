Received: from eggs.gnu.org ([2001:4830:134:3::10]:50882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwywi-0007ji-Fp
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwywh-0005MB-LL
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwywh-0005LV-Fo
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96DAD81E0A
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 23:07:18 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Sep 2017 20:07:07 -0300
Message-Id: <20170926230709.22958-5-ehabkost@redhat.com>
In-Reply-To: <20170926230709.22958-1-ehabkost@redhat.com>
References: <20170926230709.22958-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 4/6] device-crash-test: Exit immediately on fatal
 failures on quick mode
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

If we're running on quick mode, we won't wait for the full test
run, and will exit immediately if a fatal failure is found.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 0bd599d395..4c23ffa449 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -583,10 +583,14 @@ def main():
 
             if wl.get('fatal') or (args.strict and level >= logging.WARN):
                 fatal_failures.append(r)
+                if args.quick:
+                    break
 
             if expected_match and expected_match[0] != i:
                 logger.warn("Didn't fail as expected: %s", formatTestCase(t))
 
+        if fatal_failures and args.quick:
+            break
 
     logger.info("Total: %d test cases", total)
     if skipped:
-- 
2.13.5
