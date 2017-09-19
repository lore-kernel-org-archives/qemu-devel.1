Received: from eggs.gnu.org ([2001:4830:134:3::10]:46080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJzd-0004K8-SA
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJza-0000jI-Di
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:59:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duJza-0000iV-8F
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:59:18 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 16:56:20 +0200
Message-Id: <20170919145636.9389-23-cohuck@redhat.com>
In-Reply-To: <20170919145636.9389-1-cohuck@redhat.com>
References: <20170919145636.9389-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 22/38] target/s390x: set cpu->id for linux user
 when realizing
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

scc->next_cpu_id is updated when realizing. Setting it just before that
point looks cleaner.

Reviewed-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170913132417.24384-13-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 74b3e4fd0d..5f9315fb16 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -194,7 +194,11 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
                    ", max allowed: %d", cpu->id, max_cpus - 1);
         goto out;
     }
+#else
+    /* implicitly set for linux-user only */
+    cpu->id = scc->next_cpu_id;
 #endif
+
     if (cpu_exists(cpu->id)) {
         error_setg(&err, "Unable to add CPU: %" PRIi64
                    ", it already exists", cpu->id);
@@ -306,13 +310,6 @@ static void s390_cpu_initfn(Object *obj)
         inited = true;
         s390x_translate_init();
     }
-
-#if defined(CONFIG_USER_ONLY)
-    {
-        S390CPUClass *scc = S390_CPU_GET_CLASS(obj);
-        cpu->id = scc->next_cpu_id;
-    }
-#endif
 }
 
 static void s390_cpu_finalize(Object *obj)
-- 
2.13.5
