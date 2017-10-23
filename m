Received: from eggs.gnu.org ([2001:4830:134:3::10]:52125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1e6eQ3-00052m-Ps
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1e6ePz-0002EU-Tb
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:13:35 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:46383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1e6ePz-0002Dv-N9
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:13:31 -0400
Received: by mail-wm0-x243.google.com with SMTP id m72so10230301wmc.1
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 08:13:31 -0700 (PDT)
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Mon, 23 Oct 2017 17:13:10 +0200
Message-Id: <20171023151310.6462-5-vadim.galitsyn@profitbricks.com>
In-Reply-To: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
References: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
Subject: [Qemu-devel] [PATCH 4/4] tests: test-hmp: print command execution
 result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vadim.galitsyn@profitbricks.com, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

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
---
 tests/test-hmp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 8e21eee61c..1fd8e44eff 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -79,10 +79,13 @@ static void test_commands(void)
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
2.13.1.394.g41dd433
