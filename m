Received: from eggs.gnu.org ([2001:4830:134:3::10]:51297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURq-000504-If
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURl-00020L-Pt
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:18 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeURl-000205-Ha
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:13 -0500
Received: by mail-pg0-x241.google.com with SMTP id r19so3821589pgn.1
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:27:13 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	z19sm9760028pfh.185.2018.01.24.15.27.11 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jan 2018 15:27:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:26:09 -0800
Message-Id: <20180124232625.30105-30-richard.henderson@linaro.org>
In-Reply-To: <20180124232625.30105-1-richard.henderson@linaro.org>
References: <20180124232625.30105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 29/45] target/hppa: Add system registers to
 gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/gdbstub.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index fc27aec073..e2e9c4d77f 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -41,15 +41,93 @@ int hppa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
     case 33:
         val = env->iaoq_f;
         break;
+    case 34:
+        val = env->iasq_f >> 32;
+        break;
     case 35:
         val = env->iaoq_b;
         break;
+    case 36:
+        val = env->iasq_b >> 32;
+        break;
+    case 37:
+        val = env->cr[CR_EIEM];
+        break;
+    case 38:
+        val = env->cr[CR_IIR];
+        break;
+    case 39:
+        val = env->cr[CR_ISR];
+        break;
+    case 40:
+        val = env->cr[CR_IOR];
+        break;
+    case 41:
+        val = env->cr[CR_IPSW];
+        break;
+    case 43:
+        val = env->sr[4] >> 32;
+        break;
+    case 44:
+        val = env->sr[0] >> 32;
+        break;
+    case 45:
+        val = env->sr[1] >> 32;
+        break;
+    case 46:
+        val = env->sr[2] >> 32;
+        break;
+    case 47:
+        val = env->sr[3] >> 32;
+        break;
+    case 48:
+        val = env->sr[5] >> 32;
+        break;
+    case 49:
+        val = env->sr[6] >> 32;
+        break;
+    case 50:
+        val = env->sr[7] >> 32;
+        break;
+    case 51:
+        val = env->cr[CR_RC];
+        break;
+    case 52:
+        val = env->cr[8];
+        break;
+    case 53:
+        val = env->cr[9];
+        break;
+    case 54:
+        val = env->cr[CR_SCRCCR];
+        break;
+    case 55:
+        val = env->cr[12];
+        break;
+    case 56:
+        val = env->cr[13];
+        break;
+    case 57:
+        val = env->cr[24];
+        break;
+    case 58:
+        val = env->cr[25];
+        break;
     case 59:
         val = env->cr[26];
         break;
     case 60:
         val = env->cr[27];
         break;
+    case 61:
+        val = env->cr[28];
+        break;
+    case 62:
+        val = env->cr[29];
+        break;
+    case 63:
+        val = env->cr[30];
+        break;
     case 64 ... 127:
         val = extract64(env->fr[(n - 64) / 2], (n & 1 ? 0 : 32), 32);
         break;
@@ -94,15 +172,93 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     case 33:
         env->iaoq_f = val;
         break;
+    case 34:
+        env->iasq_f = (uint64_t)val << 32;
+        break;
     case 35:
         env->iaoq_b = val;
         break;
+    case 36:
+        env->iasq_b = (uint64_t)val << 32;
+        break;
+    case 37:
+        env->cr[CR_EIEM] = val;
+        break;
+    case 38:
+        env->cr[CR_IIR] = val;
+        break;
+    case 39:
+        env->cr[CR_ISR] = val;
+        break;
+    case 40:
+        env->cr[CR_IOR] = val;
+        break;
+    case 41:
+        env->cr[CR_IPSW] = val;
+        break;
+    case 43:
+        env->sr[4] = (uint64_t)val << 32;
+        break;
+    case 44:
+        env->sr[0] = (uint64_t)val << 32;
+        break;
+    case 45:
+        env->sr[1] = (uint64_t)val << 32;
+        break;
+    case 46:
+        env->sr[2] = (uint64_t)val << 32;
+        break;
+    case 47:
+        env->sr[3] = (uint64_t)val << 32;
+        break;
+    case 48:
+        env->sr[5] = (uint64_t)val << 32;
+        break;
+    case 49:
+        env->sr[6] = (uint64_t)val << 32;
+        break;
+    case 50:
+        env->sr[7] = (uint64_t)val << 32;
+        break;
+    case 51:
+        env->cr[CR_RC] = val;
+        break;
+    case 52:
+        env->cr[8] = val;
+        break;
+    case 53:
+        env->cr[9] = val;
+        break;
+    case 54:
+        env->cr[CR_SCRCCR] = val;
+        break;
+    case 55:
+        env->cr[12] = val;
+        break;
+    case 56:
+        env->cr[13] = val;
+        break;
+    case 57:
+        env->cr[24] = val;
+        break;
+    case 58:
+        env->cr[25] = val;
+        break;
     case 59:
         env->cr[26] = val;
         break;
     case 60:
         env->cr[27] = val;
         break;
+    case 61:
+        env->cr[28] = val;
+        break;
+    case 62:
+        env->cr[29] = val;
+        break;
+    case 63:
+        env->cr[30] = val;
+        break;
     case 64:
         env->fr[0] = deposit64(env->fr[0], 32, 32, val);
         cpu_hppa_loaded_fr0(env);
-- 
2.14.3
