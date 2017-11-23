Received: from eggs.gnu.org ([2001:4830:134:3::10]:38695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eHnjc-0002Ed-AA
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eHnjb-00066A-E6
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:23:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:4812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eHnjb-000650-8I
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:23:51 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 23 Nov 2017 17:23:33 +0800
Message-Id: <20171123092333.16085-4-peterx@redhat.com>
In-Reply-To: <20171123092333.16085-1-peterx@redhat.com>
References: <20171123092333.16085-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] cpu: suffix cpu address spaces with cpu
 index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Richard Henderson <rth@twiddle.net>, peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>

Renaming cpu address space names so that they won't be the same when
there are more than one.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 exec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index b4abe75931..c6e4c20c8f 100644
--- a/exec.c
+++ b/exec.c
@@ -719,9 +719,12 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
 {
     CPUAddressSpace *newas;
     AddressSpace *as = g_new0(AddressSpace, 1);
+    char *as_name;
 
     assert(mr);
-    address_space_init(as, mr, prefix);
+    as_name = g_strdup_printf("%s-%d", prefix, cpu->cpu_index);
+    address_space_init(as, mr, as_name);
+    g_free(as_name);
 
     /* Target code should have set num_ases before calling us */
     assert(asidx < cpu->num_ases);
-- 
2.14.3
