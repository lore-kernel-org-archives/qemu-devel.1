Received: from eggs.gnu.org ([2001:4830:134:3::10]:47804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijF-0004Xd-7U
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijB-0002f7-5C
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRijA-0002d7-Tp
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 067B5C04B952
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:24 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-46.ams2.redhat.com
	[10.36.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6A46038181
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 19:03:54 +0100
Message-Id: <20171220180358.29316-16-pbonzini@redhat.com>
In-Reply-To: <20171220180358.29316-1-pbonzini@redhat.com>
References: <20171220180358.29316-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/19] i386: hvf: abort on decoding error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Rather than unsupported situations, some VM_PANIC calls actually
are caused by internal errors.  Convert them to just abort.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c     |  2 +-
 target/i386/hvf/x86_emu.c | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index c87b20fa35..f7fe258a3a 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -762,7 +762,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             env->hvf_emul->fetch_rip = rip;
 
             decode_instruction(env, &decode);
-            VM_PANIC_ON(ins_len != decode.len);
+            assert(ins_len == decode.len);
             exec_instruction(env, &decode);
             store_regs(cpu);
 
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index ff146fa81b..5ecabc4230 100644
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
2.14.3
