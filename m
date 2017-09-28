Received: from eggs.gnu.org ([2001:4830:134:3::10]:53721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfaP-00057H-Nd
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfaO-0003mA-2Q
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:39:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfaN-0003lq-T5
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:39:08 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:37:06 +0200
Message-Id: <20170928203708.9376-29-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 28/30] s390x/tcg: unlock NMI
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

Nothing hindering us anymore from unlocking the restart code (used for
NMI).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 +---
 target/s390x/sigp.c        | 5 -----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3a23fd3f27..7f7e4908b1 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -402,9 +402,7 @@ static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
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
2.13.5
