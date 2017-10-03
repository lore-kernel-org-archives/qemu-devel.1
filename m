Received: from eggs.gnu.org ([2001:4830:134:3::10]:40117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWd-0001zO-TA
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzNWc-00047w-W7
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:19 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dzNWc-00047S-Oe
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:46:18 -0400
Received: by mail-wr0-x242.google.com with SMTP id y44so836440wry.2
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:46:18 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Oct 2017 15:45:36 +0200
Message-Id: <20171003134540.21625-7-pbonzini@redhat.com>
In-Reply-To: <20171003134540.21625-1-pbonzini@redhat.com>
References: <20171003134540.21625-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 06/10] i386: hvf: abort on decoding error
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

Rather than unsupported situations, some VM_PANIC calls actually
are caused by internal errors.  Convert them to just abort.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c     |  2 +-
 target/i386/hvf/x86_emu.c | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index ae3ecad2a4..f2dc37d826 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -767,7 +767,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             env->hvf_emul->fetch_rip = rip;
 
             decode_instruction(env, &decode);
-            VM_PANIC_ON(ins_len != decode.len);
+            assert(ins_len == decode.len);
             exec_instruction(env, &decode);
             store_regs(cpu);
 
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 3a995fe687..63c2b5a54d 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -146,7 +146,7 @@ addr_t read_reg(CPUX86State *env, int reg, int size)
     case 8:
         return env->hvf_emul->regs[reg].rrx;
     default:
-        VM_PANIC_ON("read_reg size");
+        abort();
     }
     return 0;
 }
@@ -167,7 +167,7 @@ void write_reg(CPUX86State *env, int reg, addr_t val, int size)
         env->hvf_emul->regs[reg].rrx = val;
         break;
     default:
-        VM_PANIC_ON("write_reg size");
+        abort();
     }
 }
 
@@ -189,8 +189,7 @@ addr_t read_val_from_reg(addr_t reg_ptr, int size)
         val = *(uint64_t *)reg_ptr;
         break;
     default:
-        VM_PANIC_ON_EX(1, "read_val: Unknown size %d\n", size);
-        break;
+        abort();
     }
     return val;
 }
@@ -211,8 +210,7 @@ void write_val_to_reg(addr_t reg_ptr, addr_t val, int size)
         *(uint64_t *)reg_ptr = val;
         break;
     default:
-        VM_PANIC("write_val: Unknown size\n");
-        break;
+        abort();
     }
 }
 
-- 
2.13.6
