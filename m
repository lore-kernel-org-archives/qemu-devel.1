Received: from eggs.gnu.org ([2001:4830:134:3::10]:40306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLf6-0007aM-2D
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLf4-0004F2-Vz
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:46:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLf4-0004Eb-R9
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:46:14 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:31 +0200
Message-Id: <20170919164337.18555-33-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 32/38] s390x: allow CPU hotplug in random
 core-id order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

SCLP correctly indicates the core-id aka. CPU address for each available
CPU.

As the core-id corresponds to cpu_index, also a newly created kvm vcpu
gets assigned this core-id as vcpu id. So SIGP in the kernel works
correctly (it uses the vcpu id to lookup the correct CPU).

So there should be nothing hindering us from hotplugging CPUs in random
core-id order.

This now makes sure that the output from "query-hotpluggable-cpus"
is completely true. Until now, a specific order is implicit. Performance
vice, hotplugging CPUs in non-sequential order might not be the best thing
to do, as VCPU lookup inside KVM might be a little slower. But that
doesn't hinder us from supporting it.

next_core_id is now used by linux user only.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170913132417.24384-23-david@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 5724dffb88..34538c3ab9 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -199,6 +199,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
 #else
     /* implicitly set for linux-user only */
     cpu->env.core_id = scc->next_core_id;
+    scc->next_core_id++;
 #endif
 
     if (cpu_exists(cpu->env.core_id)) {
@@ -206,12 +207,6 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
                    ", it already exists", cpu->env.core_id);
         goto out;
     }
-    if (cpu->env.core_id != scc->next_core_id) {
-        error_setg(&err, "Unable to add CPU with core-id: %" PRIu32
-                   ", the next available core-id is %" PRIu32, cpu->env.core_id,
-                   scc->next_core_id);
-        goto out;
-    }
 
     /* sync cs->cpu_index and env->core_id. The latter is needed for TCG. */
     cs->cpu_index = env->core_id;
@@ -219,7 +214,6 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     if (err != NULL) {
         goto out;
     }
-    scc->next_core_id++;
 
 #if !defined(CONFIG_USER_ONLY)
     qemu_register_reset(s390_cpu_machine_reset_cb, cpu);
-- 
2.13.5
