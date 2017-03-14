Received: from eggs.gnu.org ([2001:4830:134:3::10]:36607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9b-0003Py-NY
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9a-0006ZG-NR
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:31 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9a-0006YY-Hp
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:30 -0400
Received: by mail-wm0-x242.google.com with SMTP id n11so609809wma.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:30 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:07 +0100
Message-Id: <1489508300-48184-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/18] kvm: Print MSR information if KVM_{GET,
 SET}_MSRS failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

When a KVM_{GET,SET}_MSRS ioctl() fails, it is difficult to find
out which MSR caused the problem. Print an error message for
debugging, before we trigger the (ret == cpu->kvm_msr_buf->nmsrs)
assert.

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170309194634.28457-1-ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 472399f..55865db 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1824,6 +1824,12 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
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
@@ -2189,6 +2195,12 @@ static int kvm_get_msrs(X86CPU *cpu)
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
1.8.3.1
