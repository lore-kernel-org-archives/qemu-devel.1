Received: from eggs.gnu.org ([2001:4830:134:3::10]:52458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eGnta-00062K-NS
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eGntV-0000vQ-0l
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:22:02 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 20 Nov 2017 16:21:42 +0100
Message-Id: <20171120152145.25853-2-cohuck@redhat.com>
In-Reply-To: <20171120152145.25853-1-cohuck@redhat.com>
References: <20171120152145.25853-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11 1/4] s390x: fix storing CPU status
 (again)
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

Looks like the last fix + cleanup introduced another bug. (for now Linux
guests don't seem to care) - we store the crs into ars.

Fixes: 947a38bd6f13 ("s390x/kvm: fix and cleanup storing CPU status")
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171116170526.12643-2-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index f78983dd6a..246ba20f0d 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -279,7 +279,7 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
         sa->ars[i] = cpu_to_be32(cpu->env.aregs[i]);
     }
     for (i = 0; i < 16; ++i) {
-        sa->ars[i] = cpu_to_be64(cpu->env.cregs[i]);
+        sa->crs[i] = cpu_to_be64(cpu->env.cregs[i]);
     }
 
     cpu_physical_memory_unmap(sa, len, 1, len);
-- 
2.13.6
