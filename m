Received: from eggs.gnu.org ([2001:4830:134:3::10]:48386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eFNbc-0001zX-9a
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eFNbb-00017U-GK
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:05:36 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 16 Nov 2017 18:05:25 +0100
Message-Id: <20171116170526.12643-3-david@redhat.com>
In-Reply-To: <20171116170526.12643-1-david@redhat.com>
References: <20171116170526.12643-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.11 2/3] s390x/tcg: fix DIAG 308 with >
 1 VCPU (single threaded TCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Currently, single threaded TCG with > 1 VCPU gets stuck during IPL, when
the bios tries to switch to the loaded kernel via DIAG 308.

pause_all_vcpus()/resume_all_vcpus() should not be called from a VCPU.

And there is also no need for it. run_on_cpu() will make sure that the
CPUs exit KVM/TCG, where they get stopped. Once stopped, they will no
longer run.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/diag.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index dbbb9e886f..52bc348808 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -27,7 +27,6 @@ static int modified_clear_reset(S390CPU *cpu)
     S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     CPUState *t;
 
-    pause_all_vcpus();
     cpu_synchronize_all_states();
     CPU_FOREACH(t) {
         run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
@@ -37,7 +36,6 @@ static int modified_clear_reset(S390CPU *cpu)
     s390_crypto_reset();
     scc->load_normal(CPU(cpu));
     cpu_synchronize_all_post_reset();
-    resume_all_vcpus();
     return 0;
 }
 
@@ -53,7 +51,6 @@ static int load_normal_reset(S390CPU *cpu)
     S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     CPUState *t;
 
-    pause_all_vcpus();
     cpu_synchronize_all_states();
     CPU_FOREACH(t) {
         run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
@@ -63,7 +60,6 @@ static int load_normal_reset(S390CPU *cpu)
     scc->initial_cpu_reset(CPU(cpu));
     scc->load_normal(CPU(cpu));
     cpu_synchronize_all_post_reset();
-    resume_all_vcpus();
     return 0;
 }
 
-- 
2.13.6
