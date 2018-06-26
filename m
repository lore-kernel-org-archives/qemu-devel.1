Received: from eggs.gnu.org ([2001:4830:134:3::10]:60818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXjmG-00040x-Qe
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXjmG-0007Wn-1p
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:56:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60480 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fXjmF-0007WZ-Sy
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:56:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 651E4401EF14
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 08:56:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 26 Jun 2018 10:56:42 +0200
Message-Id: <20180626085642.4973-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] coverity-model: Fix replay_get_byte()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

Coverity 2018.06 chokes on replay_get_byte():

    $ cov-make-library -of scripts/coverity-model.xmldb scripts/coverity-model.c
    output file: scripts/coverity-model.xmldb
    Compiling scripts/coverity-model.c with command /opt/cov-sa-2018.06/bin/cov-emit --dir /tmp/cov-armbru/930a6fb31e5f464fc1a53354b2deb66b/cov-make-library-emit -w --no_error_recovery --emit_header_functions --no_implicit_decl --preinclude /opt/cov-sa-2018.06/library/decls.h --c scripts/coverity-model.c
    "scripts/coverity-model.c", line 110: error #20: identifier "replay_file" is
              undefined
           if (replay_file) {
               ^

    Emit for file '/work/armbru/qemu/scripts/coverity-model.c' complete.
    [ERROR] 1 error detected in the compilation of "scripts/coverity-model.c".
    ERROR: cov-emit returned with code 1

Broken in commit 04a0afe5285.  Fix by dumbing down.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/coverity-model.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/scripts/coverity-model.c b/scripts/coverity-model.c
index 48b112393b..2c0346ff25 100644
--- a/scripts/coverity-model.c
+++ b/scripts/coverity-model.c
@@ -106,12 +106,8 @@ static int get_keysym(const name2keysym_t *table,
 /* Replay data is considered trusted.  */
 uint8_t replay_get_byte(void)
 {
-     uint8_t byte = 0;
-     if (replay_file) {
-         uint8_t c;
-         byte = c;
-     }
-     return byte;
+    uint8_t byte;
+    return byte;
 }
 
 
-- 
2.17.1
