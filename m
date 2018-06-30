Received: from eggs.gnu.org ([2001:4830:134:3::10]:58263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fZMtH-0006QQ-Tu
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 16:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fZMtE-0002lL-Nx
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 16:54:43 -0400
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <d5eb6e1c-0790-c3a2-34fe-607be2eede4d@linaro.org>
Date: Sat, 30 Jun 2018 16:54:37 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <5955C4AE-747E-4782-8AB8-1F96FEBF10CF@gmail.com>
References: <20180630030606.17288-1-programmingkidx@gmail.com>
	<d5eb6e1c-0790-c3a2-34fe-607be2eede4d@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


On Jun 30, 2018, at 11:43 AM, Richard Henderson wrote:

> On 06/29/2018 08:06 PM, John Arbuckle wrote:
>> When the fdiv instruction divides a finite number by zero,
>> the result actually depends on the FPSCR[ZE] bit. If this
>> bit is set, the return value is the value originally in
>> the destination register. If it is not set
>> the result should be either positive or negative infinity.
>> The sign of this result would depend on the sign of the
>> two inputs. What currently happens is only infinity is
>> returned even if the FPSCR[ZE] bit is set. This patch
>> fixes this problem by actually checking the FPSCR[ZE] bit
>> when deciding what the answer should be.
>>=20
>> fdiv is suppose to only set the FPSCR's FPRF bits during a
>> division by zero situation when the FPSCR[ZE] is not set.
>> What currently happens is these bits are always set. This
>> patch fixes this problem by checking the FPSCR[ZE] bit to
>> decide if the FPRF bits should be set.=20
>>=20
>> =
https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming-env=
ironments-for-32-e3087633.html
>> This document has the information on the fdiv. Page 133 has
>> the information on what action is executed when a division
>> by zero situation takes place.
>>=20
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>> v2 changes:
>> - Added comment for computing sign bit.
>> - Changed return value of helper_fdiv() to return the
>>  original value in the destination register when the
>>  fpscr_ze if condition is encountered.
>> - Patch comment adjusted to reflect returning
>>  destination register's value instead of zero.
>>=20
>> target/ppc/fpu_helper.c            | 21 ++++++++++++++++++++-
>> target/ppc/helper.h                |  2 +-
>> target/ppc/translate/fp-impl.inc.c | 29 ++++++++++++++++++++++++++++-
>> 3 files changed, 49 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
>> index 7714bfe0f9..9ccba1ec3f 100644
>> --- a/target/ppc/fpu_helper.c
>> +++ b/target/ppc/fpu_helper.c
>> @@ -644,7 +644,8 @@ uint64_t helper_fmul(CPUPPCState *env, uint64_t =
arg1, uint64_t arg2)
>> }
>>=20
>> /* fdiv - fdiv. */
>> -uint64_t helper_fdiv(CPUPPCState *env, uint64_t arg1, uint64_t arg2)
>> +uint64_t helper_fdiv(CPUPPCState *env, uint64_t arg1, uint64_t arg2, =
uint64_t
>> +                     old_value)
>=20
> You don't need to pass in the old value,
>=20
>> +    } else if (arg2 =3D=3D 0) {
>> +        /* Division by zero */
>> +        float_zero_divide_excp(env, GETPC());
>> +        if (fpscr_ze) { /* if zero divide exception is enabled */
>> +            /* Keep the value in the destination register the same =
*/
>> +            farg1.ll =3D old_value;
>> +        } else {
>> +            /* Compute sign bit */
>> +            uint64_t sign =3D (farg1.ll ^ farg2.ll) >> 63;
>> +            if (sign) { /* Negative sign bit */
>> +                farg1.ll =3D 0xfff0000000000000; /* Negative =
Infinity */
>> +            } else { /* Positive sign bit */
>> +                farg1.ll =3D 0x7ff0000000000000; /* Positive =
Infinity */
>> +            }
>> +            helper_compute_fprf_float64(env, farg1.d);
>=20
> You don't need any of this.
>=20
>>         farg1.d =3D float64_div(farg1.d, farg2.d, &env->fp_status);
>> +        helper_compute_fprf_float64(env, farg1.d);
>> +        helper_float_check_status(env);
>=20
> You merely need to raise the exception here, which skips
> the code that assigns a new value to the register.
>=20
> You do not want to do *all* of do_float_check_status here,
> because overflow and underflow and inexact exceptions *do*
> write a new value to the destination register (although a
> weird scaled value that we don't handle so far, but still
> an assignment, so the exception must be raised as a separate
> step after assignment is complete.)
>=20
> So, you just need to move the call to float_zero_divide_excp
> out of do_float_check_status to here.  Like
>=20
>    if (unlikely(get_float_exception_flags(&env->fp_status)
>                 & float_flag_divbyzero)) {
>        float_zero_divide_excp(env, GETPC());
>    }
>=20
>=20
> r~

I tried your suggestion but could not figure out how to prevent the =
destination register's value from being changed. Could you know the =
exact code that sets this value?=20

I did manage to simply my patch more, but as-is it doesn't solve the =
problem of leaving the destination register's value alone when it needs =
to.=20

Here is the new patch I am working on:

---
 target/ppc/fpu_helper.c            | 13 ++++++++++---
 target/ppc/translate/fp-impl.inc.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 7714bfe..3939983 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -534,9 +534,7 @@ static void do_float_check_status(CPUPPCState *env, =
uintptr_t raddr)
     CPUState *cs =3D CPU(ppc_env_get_cpu(env));
     int status =3D get_float_exception_flags(&env->fp_status);
=20
-    if (status & float_flag_divbyzero) {
-        float_zero_divide_excp(env, raddr);
-    } else if (status & float_flag_overflow) {
+    if (status & float_flag_overflow) {
         float_overflow_excp(env);
     } else if (status & float_flag_underflow) {
         float_underflow_excp(env);
@@ -664,7 +662,16 @@ uint64_t helper_fdiv(CPUPPCState *env, uint64_t =
arg1, uint64_t arg2)
             /* sNaN division */
             float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
         }
+        if (arg2 =3D=3D 0) {
+            float_zero_divide_excp(env, GETPC());
+        }
         farg1.d =3D float64_div(farg1.d, farg2.d, &env->fp_status);
+        if (!(fpscr_ze && arg2 =3D=3D 0)) {
+            helper_compute_fprf_float64(env, farg1.d);
+        }
+        if (arg2 !=3D 0) {
+            helper_float_check_status(env);
+        }
     }
=20
     return farg1.ll;
diff --git a/target/ppc/translate/fp-impl.inc.c =
b/target/ppc/translate/fp-impl.inc.c
index 2fbd4d4..9b1ea68 100644
--- a/target/ppc/translate/fp-impl.inc.c
+++ b/target/ppc/translate/fp-impl.inc.c
@@ -84,6 +84,31 @@ static void gen_f##name(DisasContext *ctx)            =
                        \
 _GEN_FLOAT_AB(name, name, 0x3F, op2, inval, 0, set_fprf, type);         =
      \
 _GEN_FLOAT_AB(name##s, name, 0x3B, op2, inval, 1, set_fprf, type);
=20
+
+#define _GEN_FLOAT_DIV(name, op, op1, op2, inval, isfloat, set_fprf, =
type)    \
+static void gen_f##name(DisasContext *ctx)                              =
      \
+{                                                                       =
      \
+    if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
+        gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
+        return;                                                         =
      \
+    }                                                                   =
      \
+    gen_reset_fpstatus();                                               =
      \
+    gen_helper_f##op(cpu_fpr[rD(ctx->opcode)], cpu_env,                 =
      \
+                     cpu_fpr[rA(ctx->opcode)],                          =
      \
+                     cpu_fpr[rB(ctx->opcode)]);                         =
      \
+    if (isfloat) {                                                      =
      \
+        gen_helper_frsp(cpu_fpr[rD(ctx->opcode)], cpu_env,              =
      \
+                        cpu_fpr[rD(ctx->opcode)]);                      =
      \
+    }                                                                   =
      \
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {                             =
        \
+        gen_set_cr1_from_fpscr(ctx);                                    =
      \
+    }                                                                   =
      \
+}
+
+#define GEN_FLOAT_DIV(name, op2, inval, set_fprf, type)                 =
      \
+_GEN_FLOAT_DIV(name, name, 0x3F, op2, inval, 0, set_fprf, type);        =
      \
+_GEN_FLOAT_DIV(name##s, name, 0x3B, op2, inval, 1, set_fprf, type);
+
 #define _GEN_FLOAT_AC(name, op, op1, op2, inval, isfloat, set_fprf, =
type)     \
 static void gen_f##name(DisasContext *ctx)                              =
      \
 {                                                                       =
      \
@@ -149,7 +174,7 @@ static void gen_f##name(DisasContext *ctx)           =
                         \
 /* fadd - fadds */
 GEN_FLOAT_AB(add, 0x15, 0x000007C0, 1, PPC_FLOAT);
 /* fdiv - fdivs */
-GEN_FLOAT_AB(div, 0x12, 0x000007C0, 1, PPC_FLOAT);
+GEN_FLOAT_DIV(div, 0x12, 0x000007C0, 1, PPC_FLOAT);
 /* fmul - fmuls */
 GEN_FLOAT_AC(mul, 0x19, 0x0000F800, 1, PPC_FLOAT);
=20
--=20
2.7.2
