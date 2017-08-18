Received: from eggs.gnu.org ([2001:4830:134:3::10]:54961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1didik-0007Fd-Jn
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1didih-0000RF-HN
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:37:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1didih-0000R1-Aj
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:37:35 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Aug 2017 11:37:30 +0200
Message-Id: <20170818093730.23971-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH] s390x: wire up diag288 in tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, Cornelia Huck <cohuck@redhat.com>

Make the diag288 watchdog useable via tcg as well.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/misc_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index d23ffcd890..80a13a1b66 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -103,6 +103,14 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
         handle_diag_308(env, r1, r3);
         r = 0;
         break;
+    case 0x288:
+        /* time bomb (watchdog) */
+        r = handle_diag_288(env, r1, r3);
+        if (r) {
+            program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
+            r = 0;
+        }
+        break;
     default:
         r = -1;
         break;
-- 
2.13.5
