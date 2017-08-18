Received: from eggs.gnu.org ([2001:4830:134:3::10]:42903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dif0p-0000iz-NZ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dif0m-0002xH-F7
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:00:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dif0m-0002wj-8T
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:00:20 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Aug 2017 13:00:15 +0200
Message-Id: <20170818110015.25310-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH] s390x/tcg: specification exception for unknown
 diag
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

While the PoP is silent on the issue, z/VM documentation states
that unknown diagnose codes trigger a specification exception.
We already do that when running with kvm, so change tcg to do so
as well.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

This is on top of "s390x: wire up diag288 in tcg".

---
 target/s390x/misc_helper.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 80a13a1b66..34d730ba73 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -106,10 +106,6 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     case 0x288:
         /* time bomb (watchdog) */
         r = handle_diag_288(env, r1, r3);
-        if (r) {
-            program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
-            r = 0;
-        }
         break;
     default:
         r = -1;
@@ -117,7 +113,7 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     }
 
     if (r) {
-        program_interrupt(env, PGM_OPERATION, ILEN_AUTO);
+        program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
     }
 }
 
-- 
2.13.5
