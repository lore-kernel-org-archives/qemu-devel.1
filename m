Received: from eggs.gnu.org ([2001:4830:134:3::10]:40193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWm-00025v-W1
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWh-0004B8-Hs
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:29 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dzNWh-0004AW-BE
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:23 -0400
Received: by mail-wm0-x241.google.com with SMTP id u138so17040121wmu.4
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:46:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Oct 2017 15:45:39 +0200
Message-Id: <20171003134540.21625-10-pbonzini@redhat.com>
In-Reply-To: <20171003134540.21625-1-pbonzini@redhat.com>
References: <20171003134540.21625-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/10] i386: hvf: simplify and fix in/out
 handling
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

Reading a 32-bit port should clear the upper 32-bits of the register.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 5194b94591..35e39afefd 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -748,16 +748,16 @@ int hvf_vcpu_exec(CPUState *cpu)
                 } else if (size == 2) {
                     AX(env) = val;
                 } else if (size == 4) {
-                    RAX(env) = (uint32_t)val;
+                    RRX(env) = (uint32_t)val;
                 } else {
-                    VM_PANIC("size");
+                    RRX(env) = (uint64_t)val;
                 }
                 RIP(env) += ins_len;
                 store_regs(cpu);
                 break;
             } else if (!string && !in) {
-                RAX(env) = rreg(cpu->hvf_fd, HV_X86_RAX);
-                hvf_handle_io(env, port, &RAX(env), 1, size, 1);
+                RRX(env) = rreg(cpu->hvf_fd, HV_X86_RAX);
+                hvf_handle_io(env, port, &RRX(env), 1, size, 1);
                 macvm_set_rip(cpu, rip + ins_len);
                 break;
             }
-- 
2.13.6
