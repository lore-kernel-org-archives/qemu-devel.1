Received: from eggs.gnu.org ([2001:4830:134:3::10]:40022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLeh-0007Fd-6T
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLeg-0003wW-AC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:45:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLeg-0003vW-5A
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:45:50 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:25 +0200
Message-Id: <20170919164337.18555-27-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 26/38] s390x: allow cpu hotplug via device_add
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

E.g. the following now works:
    device_add host-s390-cpu,id=cpu1,core-id=1

The system will perform the same checks as when using cpu_add:
- If the core_id is already in use
- If the next sequential core_id isn't used
- If core-id >= max_cpu is specified

In addition, mixed CPU models are checked. E.g. if starting with
-cpu host and trying to hotplug "qemu-s390-cpu":
    "Mixed CPU models are not supported on s390x."

Reviewed-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170913132417.24384-17-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 8c1c644057..5724dffb88 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -467,6 +467,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     scc->parent_realize = dc->realize;
     dc->realize = s390_cpu_realizefn;
     dc->props = s390x_cpu_properties;
+    dc->user_creatable = true;
 
     scc->parent_reset = cc->reset;
 #if !defined(CONFIG_USER_ONLY)
-- 
2.13.5
