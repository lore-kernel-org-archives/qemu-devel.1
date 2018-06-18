Received: from eggs.gnu.org ([2001:4830:134:3::10]:33914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fUiqH-0003FH-Cj
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 21:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fUiqE-0006H1-40
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 21:20:25 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180618003445.GB25461@umbus.fritz.box>
Date: Sun, 17 Jun 2018 21:20:18 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <56C4E888-447F-4FBC-B2E6-6329A807FD6E@gmail.com>
References: <20180617155309.1653-1-programmingkidx@gmail.com>
	<20180618003445.GB25461@umbus.fritz.box>
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, aurelien@aurel32.net, agraf@suse.de, qemu-ppc@nongnu.org


> On Jun 17, 2018, at 8:34 PM, David Gibson =
<david@gibson.dropbear.id.au> wrote:
>=20
> On Sun, Jun 17, 2018 at 11:53:09AM -0400, John Arbuckle wrote:
>> Fix the helper_fpscr_clrbit() function so it correctly
>> sets the FEX and VX bits.
>=20
> This needs a lot more information in the commit message:
>=20
>  * What exactly was wrong with the previous setting of the FEX and VX
>    bits?

Determining the value for the FEX bit is suppose to be done like this:

FEX =3D (VX & VE) | (OX & OE) | (UX & UE) | (ZX & ZE) | (XX & XE))

It is described as "the logical OR of all the floating-point exception =
bits
masked by their respective enable bits". It was not implemented =
correctly. The value of FEX would stay on even when all other bits were =
set to off.

The VX bit is described as "the logical OR of all of the invalid =
operation exceptions". This bit was also not implemented correctly.

>  * Where can we find documentation which describes how they should be
>    set correctly?

My main source of information is an IBM document called:=20

PowerPC Microprocessor Family:
The Programming Environments for 32-Bit Microprocessors

Page 62 is where the FPSCR information is located.

This is an older copy than the one I use but it is still very useful:
=
https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming-env=
ironments-for-32-e3087633.html

I have an G3 and G5 iMac that I used to compare values with QEMU. This =
patch fixed all the problems I was having with these bits.

Please let me know if there is anything else I could provide to help.

>=20
> This is information we need to properly review the patch.
>=20
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
>> +        }
>> +            break;
>>         default:
>>             break;
>>         }
>=20
> --=20
> David Gibson			| I'll have my music baroque, and my =
code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT =
_the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
