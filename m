Received: from eggs.gnu.org ([2001:4830:134:3::10]:59255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vu8-0003FI-S0
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vu8-0003ly-1o
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:56 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:54:01 +0200
Message-Id: <20171020115418.2050-30-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 29/46] s390x/tcg: unlock NMI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Nothing hindering us anymore from unlocking the restart code (used for
NMI).

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-29-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 +---
 target/s390x/sigp.c        | 5 -----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a403645baa..e4474587aa 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -398,9 +398,7 @@ static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
 {
     CPUState *cs = qemu_get_cpu(cpu_index);
 
-    if (s390_cpu_restart(S390_CPU(cs))) {
-        error_setg(errp, QERR_UNSUPPORTED);
-    }
+    s390_cpu_restart(S390_CPU(cs));
 }
 
 static void ccw_machine_class_init(ObjectClass *oc, void *data)
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index c5a5dac911..964c75a736 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -480,11 +480,6 @@ int s390_cpu_restart(S390CPU *cpu)
 {
     SigpInfo si = {};
 
-    if (tcg_enabled()) {
-        /* FIXME TCG */
-        return -ENOSYS;
-    }
-
     run_on_cpu(CPU(cpu), sigp_restart, RUN_ON_CPU_HOST_PTR(&si));
     return 0;
 }
-- 
2.13.6
