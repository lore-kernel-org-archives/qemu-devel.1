Received: from eggs.gnu.org ([2001:4830:134:3::10]:50440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diflk-0006hT-Ra
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1difli-0001Mt-N7
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:48:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1difli-0001Mg-Gr
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:48:50 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Aug 2017 13:48:42 +0200
Message-Id: <20170818114844.30061-2-cohuck@redhat.com>
In-Reply-To: <20170818114844.30061-1-cohuck@redhat.com>
References: <20170818114844.30061-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] s390x/tcg: specification exception for
 unknown diag
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
 target/s390x/misc_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index d23ffcd890..5a1eba02ab 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -109,7 +109,7 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     }
 
     if (r) {
-        program_interrupt(env, PGM_OPERATION, ILEN_AUTO);
+        program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
     }
 }
 
-- 
2.13.5
