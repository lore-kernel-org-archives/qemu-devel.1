Received: from eggs.gnu.org ([2001:4830:134:3::10]:59777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm3mp-0000h8-RN
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm3mm-0000yu-En
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:31:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cm3mm-0000yN-95
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:31:40 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 124E14E359
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 19:31:38 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  9 Mar 2017 16:31:17 -0300
Message-Id: <20170309193117.24885-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10] kvm: Print MSR information if
 KVM_SET_MSRS failed
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

When a KVM_SET_MSRS ioctl() fails, it is difficult to find out
which MSR caused the problem. Print an error message for
debugging, before we trigger the (ret == cpu->kvm_msr_buf->nmsrs)
assert.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/kvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 887a81268f..3a874e4717 100644
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
-- 
2.11.0.259.g40922b1
