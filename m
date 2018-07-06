Received: from eggs.gnu.org ([2001:4830:134:3::10]:35022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fbMei-0006HX-4Z
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fbMed-0002Q6-2o
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:03:56 -0400
References: <20180703151732.29843-1-richard.henderson@linaro.org>
	<20180703151732.29843-8-richard.henderson@linaro.org>
	<B9095EFA-A3D5-4EEE-A5DA-E4284FD8881E@gmail.com>
	<128b92a6-7b0e-5e27-2bad-63da14bb3a6a@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3ed18a14-886b-a40b-7c63-176297b5171b@ilande.co.uk>
Date: Fri, 6 Jul 2018 10:03:36 +0100
MIME-Version: 1.0
In-Reply-To: <128b92a6-7b0e-5e27-2bad-63da14bb3a6a@linaro.org>
Content-Type: multipart/mixed; boundary="------------DD4FB7EF8191D2B9CFCA7B38"
Content-Language: en-GB
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 7/7] target/ppc: Use
 non-arithmetic conversions for fp load/store
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Programmingkid <programmingkidx@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

This is a multi-part message in MIME format.
--------------DD4FB7EF8191D2B9CFCA7B38
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/07/18 17:48, Richard Henderson wrote:

> On 07/05/2018 09:31 AM, Programmingkid wrote:
>>> On Jul 3, 2018, at 11:17 AM, Richard Henderson <richard.henderson@linaro.org> wrote:
>>>
>>> Memory operations have no side effects on fp state.
>>> The use of a "real" conversions between float64 and float32
>>> would raise exceptions for SNaN and out-of-range inputs.
>>
>> Would you have any documentation that tells us about converting
>> between 64 bit and 32 bit floating points?
> 
> Spelled out right at the beginning of sections 4.6 (load) and 4.7 (store) of
> Book 1 of the Power ISA manual (version 3.0B) [0].
> 
> I've double-checked vs RISU[1] testing of LFS and STFS, with master traces
> generated on Power 8 ppc64le, so I don't see anything immediately wrong with
> the patch.  But I haven't had time to look further than that.

I've had a quick look at this with the attached patch to compare the 
helper results before your patch and after, writing any differences to 
the console.

With this patch applied to ppc-for-3.1 I've booted MacOS 9 and recorded 
the output below:


$ ./qemu-system-ppc -cdrom MacOS921-macsbug.iso -boot d -M mac99

helper_todouble diff for arg: 3f800000  d.ll: 3ff0000000000000  ret: 
3bf0000000000000
helper_todouble diff for arg: 3f800000  d.ll: 3ff0000000000000  ret: 
3bf0000000000000

(note: MacOS 9 will hang here unless the line marked "Uncommenting this 
allows MacOS to run" in my patch is enabled)

helper_todouble diff for arg: 3f000000  d.ll: 3fe0000000000000  ret: 
3be0000000000000
helper_todouble diff for arg: 3f000000  d.ll: 3fe0000000000000  ret: 
3be0000000000000
helper_todouble diff for arg: 3f800000  d.ll: 3ff0000000000000  ret: 
3bf0000000000000
helper_todouble diff for arg: 3f800000  d.ll: 3ff0000000000000  ret: 
3bf0000000000000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_todouble diff for arg: be61b08a  d.ll: bfcc361140000000  ret: 
bbcc361140000000
helper_todouble diff for arg: 3fdf81a5  d.ll: 3ffbf034a0000000  ret: 
3bfbf034a0000000
helper_todouble diff for arg: bf402647  d.ll: bfe804c8e0000000  ret: 
bbe804c8e0000000
helper_todouble diff for arg: 3e61b08a  d.ll: 3fcc361140000000  ret: 
3bcc361140000000
helper_tosingle diff for arg: bfcc361140000000  f.l: be61b08a  ret: 9e61b08a
helper_todouble diff for arg: 3f0ccccd  d.ll: 3fe19999a0000000  ret: 
3be19999a0000000
helper_tosingle diff for arg: 3ffbf034a0000000  f.l: 3fdf81a5  ret: 1fdf81a5
helper_tosingle diff for arg: bfe804c8e0000000  f.l: bf402647  ret: 9f402647
helper_tosingle diff for arg: 3fcc361140000000  f.l: 3e61b08a  ret: 1e61b08a
helper_tosingle diff for arg: 3fe19999a0000000  f.l: 3f0ccccd  ret: 1f0ccccd
helper_todouble diff for arg: 3b800000  d.ll: 3f70000000000000  ret: 
3b70000000000000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_todouble diff for arg: 3b800000  d.ll: 3f70000000000000  ret: 
3b70000000000000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000
helper_tosingle diff for arg: 3ff0000000000000  f.l: 3f800000  ret: 1f800000


It looks like the differences are related to a flag or flags in the MSB 
byte of ret.


ATB,

Mark.

--------------DD4FB7EF8191D2B9CFCA7B38
Content-Type: text/x-patch;
 name="qemu-ppc-fp-helper-compare.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="qemu-ppc-fp-helper-compare.patch"

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index cb82e6e842..aedf5d1e3b 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -52,10 +52,15 @@ static inline bool fp_exceptions_enabled(CPUPPCState *env)
  * This is the non-arithmatic conversion that happens e.g. on loads.
  * In the Power ISA pseudocode, this is called DOUBLE.
  */
-uint64_t helper_todouble(uint32_t arg)
+uint64_t helper_todouble(CPUPPCState *env, uint32_t arg)
 {
     uint32_t abs_arg = arg & 0x7fffffff;
     uint64_t ret;
+    CPU_FloatU f;
+    CPU_DoubleU d;
+
+    f.l = arg;
+    d.d = float32_to_float64(f.f, &env->fp_status);
 
     if (likely(abs_arg >= 0x00800000)) {
         /* Normalized operand, or Inf, or NaN.  */
@@ -73,6 +78,13 @@ uint64_t helper_todouble(uint32_t arg)
             ret |= abs_arg << (shift + 29);
         }
     }
+
+    if (d.ll != ret) {
+        printf("helper_todouble diff for arg: %x  d.ll: %lx  ret: %lx\n", arg, d.ll, ret);
+        // Uncommenting this allows MacOS to run
+        //ret = d.ll;
+    }
+
     return ret;
 }
 
@@ -80,10 +92,15 @@ uint64_t helper_todouble(uint32_t arg)
  * This is the non-arithmatic conversion that happens e.g. on stores.
  * In the Power ISA pseudocode, this is called SINGLE.
  */
-uint32_t helper_tosingle(uint64_t arg)
+uint32_t helper_tosingle(CPUPPCState *env, uint64_t arg)
 {
     int exp = extract64(arg, 52, 11);
     uint32_t ret;
+    CPU_FloatU f;
+    CPU_DoubleU d;
+
+    d.ll = arg;
+    f.f = float64_to_float32(d.d, &env->fp_status);
 
     if (likely(exp > 896)) {
         /* No denormalization required (includes Inf, NaN).  */
@@ -101,6 +118,11 @@ uint32_t helper_tosingle(uint64_t arg)
             ret |= ((1ULL << 52) | extract64(arg, 0, 52)) >> (896 + 30 - exp);
         }
     }
+
+    if (f.l != ret) {
+        printf("helper_tosingle diff for arg: %lx  f.l: %x  ret: %x\n", arg, f.l, ret);
+    }
+
     return ret;
 }
 
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index ef64248bc4..94b5f4fd8c 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -61,8 +61,8 @@ DEF_HELPER_2(compute_fprf_float64, void, env, i64)
 DEF_HELPER_3(store_fpscr, void, env, i64, i32)
 DEF_HELPER_2(fpscr_clrbit, void, env, i32)
 DEF_HELPER_2(fpscr_setbit, void, env, i32)
-DEF_HELPER_FLAGS_1(todouble, TCG_CALL_NO_RWG_SE, i64, i32)
-DEF_HELPER_FLAGS_1(tosingle, TCG_CALL_NO_RWG_SE, i32, i64)
+DEF_HELPER_FLAGS_2(todouble, TCG_CALL_NO_RWG_SE, i64, env, i32)
+DEF_HELPER_FLAGS_2(tosingle, TCG_CALL_NO_RWG_SE, i32, env, i64)
 
 DEF_HELPER_4(fcmpo, void, env, i64, i64, i32)
 DEF_HELPER_4(fcmpu, void, env, i64, i64, i32)
diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp-impl.inc.c
index a6f522b85c..16ecca3048 100644
--- a/target/ppc/translate/fp-impl.inc.c
+++ b/target/ppc/translate/fp-impl.inc.c
@@ -664,7 +664,7 @@ static void gen_qemu_ld32fs(DisasContext *ctx, TCGv_i64 dest, TCGv addr)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
     tcg_gen_qemu_ld_i32(tmp, addr, ctx->mem_idx, DEF_MEMOP(MO_UL));
-    gen_helper_todouble(dest, tmp);
+    gen_helper_todouble(dest, cpu_env, tmp);
     tcg_temp_free_i32(tmp);
 }
 
@@ -836,7 +836,7 @@ GEN_STXF(name, stop, 0x17, op | 0x00, type)
 static void gen_qemu_st32fs(DisasContext *ctx, TCGv_i64 src, TCGv addr)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    gen_helper_tosingle(tmp, src);
+    gen_helper_tosingle(tmp, cpu_env, src);
     tcg_gen_qemu_st_i32(tmp, addr, ctx->mem_idx, DEF_MEMOP(MO_UL));
     tcg_temp_free_i32(tmp);
 }

--------------DD4FB7EF8191D2B9CFCA7B38--
