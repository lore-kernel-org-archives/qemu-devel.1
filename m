Received: from eggs.gnu.org ([2001:4830:134:3::10]:56460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyQ-0004jS-E9
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyN-0007Gk-Ke
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:06 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:43968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyN-0007GS-D7
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:03 -0500
Received: by mail-wr0-x242.google.com with SMTP id w68so10469437wrc.10
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:03 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:38 +0100
Message-Id: <1513790098-9815-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 26/46] cpu: suffix cpu address spaces with cpu
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
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Renaming cpu address space names so that they won't be the same when
there are more than one.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20171123092333.16085-4-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 3ab515e..6b5828e 100644
--- a/exec.c
+++ b/exec.c
@@ -710,9 +710,12 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
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
1.8.3.1
