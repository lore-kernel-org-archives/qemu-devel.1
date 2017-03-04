Received: from eggs.gnu.org ([2001:4830:134:3::10]:56750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cjzNQ-0001Co-UY
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 21:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cjzNQ-0006Oc-5B
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 21:24:56 -0500
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.56219.1488535159.22740.qemu-ppc@nongnu.org>
Date: Fri, 3 Mar 2017 21:24:49 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <3AA8BBB4-FF53-423E-86F6-9F95E7DAB5C6@gmail.com>
References: <mailman.56219.1488535159.22740.qemu-ppc@nongnu.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/3] target/ppc: fmadd check for
 excp independently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>


On Mar 3, 2017, at 4:59 AM, qemu-ppc-request@nongnu.org wrote:

>=20
> Current order of checking does not confirm with the spec
> (ISA 3.0: MultiplyAddDP page-469). Change the order and make them
> independent of each other.
>=20
> For example: a =3D infinity, b =3D zero, c =3D SNaN, this should set =
both
> VXIMZ and VXNAN
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
> target/ppc/fpu_helper.c | 20 ++++++++++++--------
> 1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 0535ad0..a547f58 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -747,17 +747,21 @@ static void =
float64_maddsub_update_excp(CPUPPCState *env, float64 arg1,
>                                         float64 arg2, float64 arg3,
>                                         unsigned int madd_flags)
> {
> +    if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) ||
> +                 float64_is_signaling_nan(arg2, &env->fp_status) ||
> +                 float64_is_signaling_nan(arg3, &env->fp_status))) {
> +        /* sNaN operation */
> +        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
> +    }
> +
>     if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) =
||
>                  (float64_is_zero(arg1) && =
float64_is_infinity(arg2)))) {
>         /* Multiplication of zero by infinity */
> -        arg1 =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, =
1);
> -    } else if (unlikely(float64_is_signaling_nan(arg1, =
&env->fp_status) ||
> -                        float64_is_signaling_nan(arg2, =
&env->fp_status) ||
> -                        float64_is_signaling_nan(arg3, =
&env->fp_status))) {
> -        /* sNaN operation */
> -        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
> -    } else if ((float64_is_infinity(arg1) || =
float64_is_infinity(arg2)) &&
> -               float64_is_infinity(arg3)) {
> +        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
> +    }
> +
> +    if ((float64_is_infinity(arg1) || float64_is_infinity(arg2)) &&
> +        float64_is_infinity(arg3)) {
>         uint8_t aSign, bSign, cSign;
>=20
>         aSign =3D float64_is_neg(arg1);
> --=20
> 2.7.4


I'm having difficulty applying this patch. I took a look at =
float64_maddsub_update_excp() in fpu_helper.c and found out why. This =
function doesn't exist. Are you missing a patch?=
