Received: from eggs.gnu.org ([2001:4830:134:3::10]:47938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVI-0004kf-Lj
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVH-0006BA-Q7
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:40 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:40135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVH-0006Af-JB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:39 -0500
Received: by mail-wm0-x242.google.com with SMTP id t6so22233144wmt.5
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:39 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:00 +0100
Message-Id: <1520342370-123606-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/34] cpus: properly inititalize CPU > 1 under
 single-threaded TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

All but the first CPU are currently not fully inititalized (e.g.
cpu->created is never set).

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180209195239.16048-2-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cpus.c b/cpus.c
index 4f5f88e..970390b 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1863,6 +1863,9 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
         /* For non-MTTCG cases we share the thread */
         cpu->thread = single_tcg_cpu_thread;
         cpu->halt_cond = single_tcg_halt_cond;
+        cpu->thread_id = first_cpu->thread_id;
+        cpu->can_do_io = 1;
+        cpu->created = true;
     }
 }
 
-- 
1.8.3.1
