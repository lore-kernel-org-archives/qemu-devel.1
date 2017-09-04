Received: from eggs.gnu.org ([2001:4830:134:3::10]:37657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotXS-0004Xl-6x
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotXN-00012w-Ln
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dotXN-00012i-G6
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:45 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon,  4 Sep 2017 17:43:06 +0200
Message-Id: <20170904154316.4148-10-david@redhat.com>
In-Reply-To: <20170904154316.4148-1-david@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/19] target/s390x: use
 trigger_pgm_exception() in s390_cpu_handle_mmu_fault()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

This looks cleaner. linux-user will not use the ilen field, so setting
it doesn't do any harm.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/excp_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 361f970db3..14d3160e92 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -59,8 +59,7 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
 {
     S390CPU *cpu = S390_CPU(cs);
 
-    cs->exception_index = EXCP_PGM;
-    cpu->env.int_pgm_code = PGM_ADDRESSING;
+    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING, ILEN_AUTO);
     /* On real machines this value is dropped into LowMem.  Since this
        is userland, simply put this someplace that cpu_loop can find it.  */
     cpu->env.__excp_addr = address;
-- 
2.13.5
