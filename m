Received: from eggs.gnu.org ([2001:4830:134:3::10]:36337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePSw5-00055z-Lu
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:48:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePSw2-0006GC-1U
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:48:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ePSw1-0006Ey-S2
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:48:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 112FB356D3
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 12:48:21 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-117-51.ams2.redhat.com
	[10.36.117.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 83D7160C9F
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 12:48:20 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 14 Dec 2017 12:48:17 +0000
Message-Id: <20171214124817.2567-3-dgilbert@redhat.com>
In-Reply-To: <20171214124817.2567-1-dgilbert@redhat.com>
References: <20171214124817.2567-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] tests: test-hmp: print command execution
 result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>

Provide HMP monitor command execution result as it would be seen
by user who established an HMP monitor session.

Currently many commands may silently fail without any sign of that.
This patch let this info to be printed once test is running in
verbose mode.

For the future it might be useful to fail the test if command has
failed, however it would require a bit of rework inside test
engine itself.

A simple example of silent failure without reporting it would to
add some non-existent HMP command into 'hmp_cmds' list. In this case
test will report it successfully passed without error.

Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org
Message-Id: <20171023151310.6462-5-vadim.galitsyn@profitbricks.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/test-hmp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 5677fbf775..5b7e447b6a 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -78,10 +78,13 @@ static void test_commands(void)
     int i;
 
     for (i = 0; hmp_cmds[i] != NULL; i++) {
+        response = hmp("%s", hmp_cmds[i]);
         if (verbose) {
-            fprintf(stderr, "\t%s\n", hmp_cmds[i]);
+            fprintf(stderr,
+                    "\texecute HMP command: %s\n"
+                    "\tresult             : %s\n",
+                    hmp_cmds[i], response);
         }
-        response = hmp("%s", hmp_cmds[i]);
         g_free(response);
     }
 
-- 
2.14.3
