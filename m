Received: from eggs.gnu.org ([2001:4830:134:3::10]:49409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drQYG-0004so-Rg
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drQYG-0002IR-1C
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:23:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1drQYF-0002H2-R1
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:23:07 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Sep 2017 17:21:45 +0200
Message-Id: <20170911152150.12535-17-david@redhat.com>
In-Reply-To: <20170911152150.12535-1-david@redhat.com>
References: <20170911152150.12535-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 16/21] s390x: allow cpu hotplug via
 device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

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
