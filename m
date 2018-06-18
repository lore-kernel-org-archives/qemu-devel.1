Received: from eggs.gnu.org ([2001:4830:134:3::10]:52960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fUvsw-0008Gc-Tb
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fUvst-0004qP-NU
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:16:02 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAFEAcA8Z1J39xTxn+f3K35s88B+x50xNi3WdKG8CxrFg5P1CvQ@mail.gmail.com>
Date: Mon, 18 Jun 2018 11:15:56 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <15282A55-035D-4878-B05D-7F6734F3B593@gmail.com>
References: <20180617155309.1653-1-programmingkidx@gmail.com>
	<CAFEAcA8Z1J39xTxn+f3K35s88B+x50xNi3WdKG8CxrFg5P1CvQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] fpu_helper.c: fix helper_fpscr_clrbit()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc <qemu-ppc@nongnu.org>


> On Jun 18, 2018, at 7:30 AM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On 17 June 2018 at 16:53, John Arbuckle <programmingkidx@gmail.com> =
wrote:
>> Fix the helper_fpscr_clrbit() function so it correctly
>> sets the FEX and VX bits.
>>=20
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>> target/ppc/fpu_helper.c | 57 =
+++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 57 insertions(+)
>>=20
>> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
>> index d31a933cbb..7e697a11d0 100644
>> --- a/target/ppc/fpu_helper.c
>> +++ b/target/ppc/fpu_helper.c
>> @@ -325,6 +325,63 @@ void helper_fpscr_clrbit(CPUPPCState *env, =
uint32_t bit)
>>         case FPSCR_RN:
>>             fpscr_set_rounding_mode(env);
>>             break;
>> +        case FPSCR_VXSNAN:
>> +        case FPSCR_VXISI:
>> +        case FPSCR_VXIDI:
>> +        case FPSCR_VXZDZ:
>> +        case FPSCR_VXIMZ:
>> +        case FPSCR_VXVC:
>> +        case FPSCR_VXSOFT:
>> +        case FPSCR_VXSQRT:
>> +        case FPSCR_VXCVI:
>> +        {
>> +            int vxsnan, vxisi, vxidi, vxzdz, vximz, vxvc, vxsoft, =
vxsqrt, vxcvi;
>> +            vxsnan =3D (env->fpscr >> (31 - FPSCR_VXSNAN)) & 1;
>> +            vxisi =3D (env->fpscr >> (31 - FPSCR_VXISI)) & 1;
>> +            vxidi =3D (env->fpscr >> (31 - FPSCR_VXIDI)) & 1;
>> +            vxzdz =3D (env->fpscr >> (31 - FPSCR_VXZDZ)) & 1;
>> +            vximz =3D (env->fpscr >> (31 - FPSCR_VXIMZ)) & 1;
>> +            vxvc =3D (env->fpscr >> (31 - FPSCR_VXVC)) & 1;
>> +            vxsoft =3D (env->fpscr >> (31 - FPSCR_VXSOFT)) & 1;
>> +            vxsqrt =3D (env->fpscr >> (31 - FPSCR_VXSQRT)) & 1;
>> +            vxcvi =3D (env->fpscr >> (31 - FPSCR_VXCVI)) & 1;
>> +            if (~(vxsnan & vxisi & vxidi & vxzdz & vximz & vxvc & =
vxsoft &
>> +                  vxsqrt & vxcvi)) {
>=20
> If all you're doing is checking "are none of these bits set"
> then you don't need to laboriously extract every bit and then
> AND them together -- you can just use
>    if (!(env->fpscr & some_mask))
> In fact the headers already define a macro which does that mask
> on env->fpscr, so this can just be
>=20
>    if (!fpscr_ix) {
>         env->fpscr &=3D ~(1 << FPSCR_VX);
>    }
>=20
>> +                /* Set VX bit to zero */
>> +                env->fpscr =3D env->fpscr & ~(1 << FPSCR_VX);
>> +            }
>> +        }
>> +            break;
>> +        case FPSCR_VX:
>> +        case FPSCR_OX:
>> +        case FPSCR_UX:
>> +        case FPSCR_ZX:
>> +        case FPSCR_XX:
>> +        case FPSCR_VE:
>> +        case FPSCR_OE:
>> +        case FPSCR_UE:
>> +        case FPSCR_ZE:
>> +        case FPSCR_XE:
>> +        {
>> +            int vx, ox, ux, zx, xx, ve, oe, ue, ze, xe;
>> +            vx =3D (env->fpscr >> (31 - FPSCR_VX)) & 1;
>> +            ox =3D (env->fpscr >> (31 - FPSCR_OX)) & 1;
>> +            ux =3D (env->fpscr >> (31 - FPSCR_UX)) & 1;
>> +            zx =3D (env->fpscr >> (31 - FPSCR_ZX)) & 1;
>> +            xx =3D (env->fpscr >> (31 - FPSCR_XX)) & 1;
>> +            ve =3D (env->fpscr >> (31 - FPSCR_VE)) & 1;
>> +            oe =3D (env->fpscr >> (31 - FPSCR_OE)) & 1;
>> +            ue =3D (env->fpscr >> (31 - FPSCR_UE)) & 1;
>> +            ze =3D (env->fpscr >> (31 - FPSCR_ZE)) & 1;
>> +            xe =3D (env->fpscr >> (31 - FPSCR_XE)) & 1;
>> +            bool fex;
>> +            fex =3D (vx & ve) | (ox & oe) | (ux & ue) | (zx & ze) | =
(xx & xe);
>> +            unsigned int mask;
>> +            mask =3D (1 << FPSCR_FEX);
>> +            /* Set the FEX bit */
>> +            env->fpscr =3D (env->fpscr & ~mask) | (-fex & mask);
>=20
> Similarly I think this is
>    if (!fpscr_eex) {
>       env->fpscr &=3D ~(1 << FPSCR_FEX);
>    }
>=20
>> +        }
>> +            break;
>>         default:
>>             break;
>>         }
>> --
>> 2.14.3 (Apple Git-98)
>>=20
>=20
> thanks
> -- PMM

Your suggestions look great. Thank you. I will be sure to implement your =
suggestions and make a better commit message for version 2 of this =
patch.
