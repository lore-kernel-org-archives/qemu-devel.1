Received: from eggs.gnu.org ([2001:4830:134:3::10]:56710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ekEjC-0001Le-2K
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ekEj7-0002yl-Q3
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:52:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1ekEj7-0002xt-LL
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:52:53 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  9 Feb 2018 20:52:37 +0100
Message-Id: <20180209195239.16048-2-david@redhat.com>
In-Reply-To: <20180209195239.16048-1-david@redhat.com>
References: <20180209195239.16048-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/3] cpus: properly inititalize CPU > 1
 under single-threaded TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

All but the first CPU are currently not fully inititalized (e.g.
cpu->created is never set).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 cpus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cpus.c b/cpus.c
index f298b659f4..ade1651032 100644
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
2.14.3
