Received: from eggs.gnu.org ([2001:4830:134:3::10]:52192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eI8VK-0002y8-7k
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eI8VJ-0004py-D1
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:34:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eI8VJ-0004pX-7R
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:34:29 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 24 Nov 2017 15:34:16 +0800
Message-Id: <20171124073417.4342-3-peterx@redhat.com>
In-Reply-To: <20171124073417.4342-1-peterx@redhat.com>
References: <20171124073417.4342-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] cpu: suffix cpu address spaces with cpu
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, peterx@redhat.com

Renaming cpu address space names so that they won't be the same when
there are more than one.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 exec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index d845542139..41f89f8164 100644
--- a/exec.c
+++ b/exec.c
@@ -713,9 +713,12 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
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
