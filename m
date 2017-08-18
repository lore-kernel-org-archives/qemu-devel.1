Received: from eggs.gnu.org ([2001:4830:134:3::10]:50475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1difln-0006iK-1q
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diflm-0001Nz-Bj
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:48:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1diflm-0001Nh-5u
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:48:54 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Aug 2017 13:48:44 +0200
Message-Id: <20170818114844.30061-4-cohuck@redhat.com>
In-Reply-To: <20170818114844.30061-1-cohuck@redhat.com>
References: <20170818114844.30061-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] s390x: wire up diag288 in tcg
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
 target/s390x/misc_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 5a1eba02ab..34d730ba73 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -103,6 +103,10 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
         handle_diag_308(env, r1, r3);
         r = 0;
         break;
+    case 0x288:
+        /* time bomb (watchdog) */
+        r = handle_diag_288(env, r1, r3);
+        break;
     default:
         r = -1;
         break;
-- 
2.13.5
