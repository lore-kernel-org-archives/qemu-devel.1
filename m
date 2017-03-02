Received: from eggs.gnu.org ([2001:4830:134:3::10]:56082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1cjI8C-0004s9-79
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 23:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1cjI8A-0001JJ-Vf
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 23:14:20 -0500
MIME-Version: 1.0
In-Reply-To: <820beb1e-20e9-9588-f39d-a7f20ee8af4a@twiddle.net>
References: <1488381854-7275-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<820beb1e-20e9-9588-f39d-a7f20ee8af4a@twiddle.net>
From: Nikunj Dadhania <nikunj.dadhania@gmail.com>
Date: Thu, 2 Mar 2017 09:44:17 +0530
Message-ID: <CALAZu3_dXwjN1T=VS3pfzU-rf40dT2a8zWHhKLfor+mnb6eVwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v1] target/ppc: rewrite
 f[n]m[add, sub] using float64_muladd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, bharata@linux.vnet.ibm.com

On 02-Mar-2017 8:07 AM, "Richard Henderson" <rth@twiddle.net> wrote:

On 03/02/2017 02:24 AM, Nikunj A Dadhania wrote:

> +static void float64_madd_set_vxisi(CPUPPCState *env, float64 a, float64
> b,
> +                                   float64 c, unsigned int flags)
>  {
> +    float64 f =3D float64_mul(a, b, &env->fp_status);
>

What is the point of this multiply?


Only to compute vxisi as stated in the thread
"If the product of x and y is an Infinity and z is an Infinity of the
opposite sign, vxisi_flag is set to 1."

Let me know if I there is an alternative way to achieve this.



> +    /* a*b =3D =E2=88=9E and c =3D =E2=88=9E, find =E2=88=9E - =E2=88=9E=
 case and set VXISI */
> +    if (float64_is_infinity(f) && float64_is_infinity(c)) {
> +        if ((f ^ c) =3D=3D 0) {
> +            /* Both negative/positive inifinity and substraction*/
> +            if (flags & MSUB_FLGS) {
>

I would really prefer you use the float_muladd_* names.


Sure.



+uint64_t helper_##op(CPUPPCState *env, uint64_t arg1,                   \
> +                     uint64_t arg2, uint64_t arg3)                      =
\
> +{                                                                       =
\
> +    if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||
> \
> +                 (float64_is_zero(arg1) && float64_is_infinity(arg2)))) =
{
> \
> +        /* Multiplication of zero by infinity */                        =
\
> +        arg1 =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);  =
   \
> +    } else {                                                            =
\
> +        if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) || =
\
> +                     float64_is_signaling_nan(arg2, &env->fp_status) || =
\
> +                     float64_is_signaling_nan(arg3, &env->fp_status))) {
> \
> +            /* sNaN operation */                                        =
\
> +            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);      =
\
> +        }                                                               =
\
> +                                                                        =
\
> +        float64_madd_set_vxisi(env, arg1, arg2, arg3, madd_flags);      =
\
> +        arg1 =3D float64_muladd(arg1, arg2, arg3, madd_flags,           =
  \
> +                              &env->fp_status);                         =
\
> +        float_check_status(env);                                        =
\
>

I know this is the layout of the bulk of the ppc target, but it's
inefficient. Let's do this one correctly, akin to target/tricore:

  result =3D float64_muladd(args...);
  flags =3D get_float_exception_flags(&env->fp_status);
  if (flags) {
      if (flags & float_flag_invalid) {
          // examine inputs to see why we return NaN
      }
      float_check_status(env);
  }


Sure.

Nikunj
