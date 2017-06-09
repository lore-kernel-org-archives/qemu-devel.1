Received: from eggs.gnu.org ([2001:4830:134:3::10]:33715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dJK3l-0000ff-67
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dJK3e-0006nI-2R
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:34:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dJK3d-0006n4-TK
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:34:34 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  9 Jun 2017 15:34:25 +0200
Message-Id: <20170609133426.11447-2-david@redhat.com>
In-Reply-To: <20170609133426.11447-1-david@redhat.com>
References: <20170609133426.11447-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] target/s390x: specification exceptions
 are suppressing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, david@redhat.com

The PSW in the old PSW has to point at the next instruction, as
specification exceptions are defined to be "suppressing or completed",
but not nullified.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index a8d20c5..42a2465 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -737,6 +737,6 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     if (retaddr) {
         cpu_restore_state(cs, retaddr);
     }
-    program_interrupt(env, PGM_SPECIFICATION, ILEN_LATER);
+    program_interrupt(env, PGM_SPECIFICATION, ILEN_LATER_INC);
 }
 #endif /* CONFIG_USER_ONLY */
-- 
2.9.3
