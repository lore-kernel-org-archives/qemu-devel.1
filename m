Received: from eggs.gnu.org ([2001:4830:134:3::10]:40145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWh-000226-Ic
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWb-00047A-NX
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:23 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dzNWb-00046N-Gm
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:17 -0400
Received: by mail-wr0-x244.google.com with SMTP id k10so5927444wrk.3
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:46:17 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Oct 2017 15:45:35 +0200
Message-Id: <20171003134540.21625-6-pbonzini@redhat.com>
In-Reply-To: <20171003134540.21625-1-pbonzini@redhat.com>
References: <20171003134540.21625-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 05/10] i386: hvf: remove ZERO_INIT macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex@alex.org.uk, agraf@suse.de, sergio.g.delreal@gmail.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86.c        | 3 ++-
 target/i386/hvf/x86_decode.c | 3 +--
 target/i386/hvf/x86_gen.h    | 2 --
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index ca0ec2968a..8002a41d30 100644
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
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 24c732d9f1..08b6036f2e 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -2090,8 +2090,7 @@ static void decode_opcodes(CPUX86State *env, struct x86_decode *decode)
 
 uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
 {
-    ZERO_INIT(*decode);
-
+    memset(decode, 0, sizeof(*decode));
     decode_prefix(env, decode);
     set_addressing_size(env, decode);
     set_operand_size(env, decode);
diff --git a/target/i386/hvf/x86_gen.h b/target/i386/hvf/x86_gen.h
index 2045b0e69d..d33dea842e 100644
--- a/target/i386/hvf/x86_gen.h
+++ b/target/i386/hvf/x86_gen.h
@@ -48,6 +48,4 @@ typedef uint64_t addr_t;
     } \
 }
 
-#define ZERO_INIT(obj) memset((void *) &obj, 0, sizeof(obj))
-
 #endif
-- 
2.13.6
