Received: from eggs.gnu.org ([2001:4830:134:3::10]:36030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm41J-0004Vi-TA
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm41I-00066b-JM
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:46:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cm41I-00066L-DD
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:46:40 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 725B33D94F
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 19:46:40 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  9 Mar 2017 16:46:34 -0300
Message-Id: <20170309194634.28457-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 v2] kvm: Print MSR information if
 KVM_{GET, SET}_MSRS failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When a KVM_{GET,SET}_MSRS ioctl() fails, it is difficult to find
out which MSR caused the problem. Print an error message for
debugging, before we trigger the (ret == cpu->kvm_msr_buf->nmsrs)
assert.

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Print error message on KVM_GET_MSRS too
  * Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 target/i386/kvm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 887a81268f..705e971a63 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1807,6 +1807,12 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         return ret;
     }
 
+    if (ret < cpu->kvm_msr_buf->nmsrs) {
+        struct kvm_msr_entry *e = &cpu->kvm_msr_buf->entries[ret];
+        error_report("error: failed to set MSR 0x%" PRIx32 " to 0x%" PRIx64,
+                     (uint32_t)e->index, (uint64_t)e->data);
+    }
+
     assert(ret == cpu->kvm_msr_buf->nmsrs);
     return 0;
 }
@@ -2172,6 +2178,12 @@ static int kvm_get_msrs(X86CPU *cpu)
         return ret;
     }
 
+    if (ret < cpu->kvm_msr_buf->nmsrs) {
+        struct kvm_msr_entry *e = &cpu->kvm_msr_buf->entries[ret];
+        error_report("error: failed to get MSR 0x%" PRIx32,
+                     (uint32_t)e->index);
+    }
+
     assert(ret == cpu->kvm_msr_buf->nmsrs);
     /*
      * MTRR masks: Each mask consists of 5 parts
-- 
2.11.0.259.g40922b1
