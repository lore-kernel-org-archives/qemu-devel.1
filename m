Received: from eggs.gnu.org ([2001:4830:134:3::10]:37443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyTz-00072L-Oc
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyTw-0007u5-2L
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyTv-0007t5-Sn
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:11 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 17:59:53 +0200
Message-Id: <20170918160012.4317-9-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 08/27] s390x/tcg: a CPU cannot switch state
 due to an interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Going to OPERATING here looks wrong. A CPU should even never be
!OPERATING at this point. Unhalting will already be done in
cpu_handle_halt() if there is work, so we can drop this statement
completely.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/excp_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index ff257ba72e..4dc30e056a 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -432,7 +432,6 @@ void s390_cpu_do_interrupt(CPUState *cs)
     qemu_log_mask(CPU_LOG_INT, "%s: %d at pc=%" PRIx64 "\n",
                   __func__, cs->exception_index, env->psw.addr);
 
-    s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
     /* handle machine checks */
     if ((env->psw.mask & PSW_MASK_MCHECK) &&
         (cs->exception_index == -1)) {
-- 
2.13.5
