Received: from eggs.gnu.org ([2001:4830:134:3::10]:53357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYo-0003ij-FO
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYn-00036I-O7
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfYn-000367-Hq
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:29 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:45 +0200
Message-Id: <20170928203708.9376-8-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/30] s390x/tcg: a CPU cannot switch state
 due to an interrupt
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Going to OPERATING here looks wrong. A CPU should even never be
!OPERATING at this point. Unhalting will already be done in
cpu_handle_halt() if there is work, so we can drop this statement
completely.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/excp_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index fe68de5a77..f6747f3877 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -437,7 +437,6 @@ void s390_cpu_do_interrupt(CPUState *cs)
     qemu_log_mask(CPU_LOG_INT, "%s: %d at pc=%" PRIx64 "\n",
                   __func__, cs->exception_index, env->psw.addr);
 
-    s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
     /* handle machine checks */
     if (cs->exception_index == -1 && s390_cpu_has_mcck_int(cpu)) {
         cs->exception_index = EXCP_MCHK;
-- 
2.13.5
