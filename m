Received: from eggs.gnu.org ([2001:4830:134:3::10]:59890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQt-000454-13
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQq-0005oo-Jc
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:31 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dGPQq-0005oc-Cu
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:28 -0400
Received: by mail-wm0-x243.google.com with SMTP id g15so11031360wmc.2
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:42:28 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 14:41:47 +0200
Message-Id: <1496320911-51305-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/33] i386/kvm: do not zero out segment flags
 if segment is unusable or not present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Pen <roman.penyaev@profitbricks.com>, Mikhail Sennikovskii <mikhail.sennikovskii@profitbricks.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Michael Chapman <mike@very.puzzling.org>

From: Roman Pen <roman.penyaev@profitbricks.com>

This is a fix for the problem [1], where VMCB.CPL was set to 0 and interrupt
was taken on userspace stack.  The root cause lies in the specific AMD CPU
behaviour which manifests itself as unusable segment attributes on SYSRET[2].

Here in this patch flags are not touched even segment is unusable or is not
present, therefore CPL (which is stored in DPL field) should not be lost and
will be successfully restored on kvm/svm kernel side.

Also current patch should not break desired behavior described in this commit:

4cae9c97967a ("target-i386: kvm: clear unusable segments' flags in migration")

since present bit will be dropped if segment is unusable or is not present.

This is the second part of the whole fix of the corresponding problem [1],
first part is related to kvm/svm kernel side and does exactly the same:
segment attributes are not zeroed out.

[1] Message id: CAJrWOzD6Xq==b-zYCDdFLgSRMPM-NkNuTSDFEtX=7MreT45i7Q@mail.gmail.com
[2] Message id: 5d120f358612d73fc909f5bfa47e7bd082db0af0.1429841474.git.luto@kernel.org

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Signed-off-by: Mikhail Sennikovskii <mikhail.sennikovskii@profitbricks.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Michael Chapman <mike@very.puzzling.org>
Cc: qemu-devel@nongnu.org
Message-Id: <20170601085604.12980-1-roman.penyaev@profitbricks.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 82c72d2..6e7c197 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1301,18 +1301,14 @@ static void get_seg(SegmentCache *lhs, const struct kvm_segment *rhs)
     lhs->selector = rhs->selector;
     lhs->base = rhs->base;
     lhs->limit = rhs->limit;
-    if (rhs->unusable) {
-        lhs->flags = 0;
-    } else {
-        lhs->flags = (rhs->type << DESC_TYPE_SHIFT) |
-                     (rhs->present * DESC_P_MASK) |
-                     (rhs->dpl << DESC_DPL_SHIFT) |
-                     (rhs->db << DESC_B_SHIFT) |
-                     (rhs->s * DESC_S_MASK) |
-                     (rhs->l << DESC_L_SHIFT) |
-                     (rhs->g * DESC_G_MASK) |
-                     (rhs->avl * DESC_AVL_MASK);
-    }
+    lhs->flags = (rhs->type << DESC_TYPE_SHIFT) |
+                 ((rhs->present && !rhs->unusable) * DESC_P_MASK) |
+                 (rhs->dpl << DESC_DPL_SHIFT) |
+                 (rhs->db << DESC_B_SHIFT) |
+                 (rhs->s * DESC_S_MASK) |
+                 (rhs->l << DESC_L_SHIFT) |
+                 (rhs->g * DESC_G_MASK) |
+                 (rhs->avl * DESC_AVL_MASK);
 }
 
 static void kvm_getput_reg(__u64 *kvm_reg, target_ulong *qemu_reg, int set)
-- 
1.8.3.1
