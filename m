Received: from eggs.gnu.org ([2001:4830:134:3::10]:47724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijC-0004V3-Sr
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijA-0002cz-6n
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRij9-0002bY-Ux
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1626DC047B91
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:23 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-46.ams2.redhat.com
	[10.36.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7B3BE38181
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 19:03:53 +0100
Message-Id: <20171220180358.29316-15-pbonzini@redhat.com>
In-Reply-To: <20171220180358.29316-1-pbonzini@redhat.com>
References: <20171220180358.29316-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/19] i386: hvf: remove ZERO_INIT macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86.c        | 5 +++--
 target/i386/hvf/x86_decode.c | 3 +--
 target/i386/hvf/x86_gen.h    | 2 --
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index ca0ec2968a..efb28c373c 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -53,7 +53,8 @@ bool x86_read_segment_descriptor(struct CPUState *cpu,
     addr_t base;
     uint32_t limit;
 
-    ZERO_INIT(*desc);
+    memset(desc, 0, sizeof(*desc));
+
     /* valid gdt descriptors start from index 1 */
     if (!sel.index && GDT_SEL == sel.ti) {
         return false;
@@ -104,7 +105,7 @@ bool x86_read_call_gate(struct CPUState *cpu, struct x86_call_gate *idt_desc,
     addr_t base  = rvmcs(cpu->hvf_fd, VMCS_GUEST_IDTR_BASE);
     uint32_t limit = rvmcs(cpu->hvf_fd, VMCS_GUEST_IDTR_LIMIT);
 
-    ZERO_INIT(*idt_desc);
+    memset(idt_desc, 0, sizeof(*idt_desc));
     if (gate * 8 >= limit) {
         printf("%s: idt limit\n", __func__);
         return false;
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 759aa38ee0..4bfd85f2df 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -2091,8 +2091,7 @@ static void decode_opcodes(CPUX86State *env, struct x86_decode *decode)
 
 uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
 {
-    ZERO_INIT(*decode);
-
+    memset(decode, 0, sizeof(*decode));
     decode_prefix(env, decode);
     set_addressing_size(env, decode);
     set_operand_size(env, decode);
diff --git a/target/i386/hvf/x86_gen.h b/target/i386/hvf/x86_gen.h
index 69edeffb19..e5739f1de5 100644
--- a/target/i386/hvf/x86_gen.h
+++ b/target/i386/hvf/x86_gen.h
@@ -44,6 +44,4 @@ typedef uint64_t addr_t;
     } \
 }
 
-#define ZERO_INIT(obj) memset((void *) &obj, 0, sizeof(obj))
-
 #endif
-- 
2.14.3
