Received: from eggs.gnu.org ([2001:4830:134:3::10]:38079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyV0-0007y0-6u
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUu-0008Mc-Dy
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyUu-0008ML-8C
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:12 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 18:00:11 +0200
Message-Id: <20170918160012.4317-27-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 26/27] s390x/tcg: unlock NMI
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

Nothing hindering us anymore from unlocking the restart code (used for
NMI).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 +---
 target/s390x/sigp.c        | 5 -----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 732feb9cff..c5c989f673 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -418,9 +418,7 @@ static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
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
