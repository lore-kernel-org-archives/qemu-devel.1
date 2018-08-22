Received: from eggs.gnu.org ([2001:4830:134:3::10]:38795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOJP-0004zV-2S
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOJN-0004e2-6B
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:16:19 -0400
References: <20180821132811.17675-1-peter.maydell@linaro.org>
	<20180821132811.17675-2-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <7421acd0-4c9d-95ca-dbd2-a903ef0ee2b8@greensocs.com>
Date: Wed, 22 Aug 2018 10:15:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180821132811.17675-2-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E9r24IIsJoWN0pfovn6XKiYHCmb2EPysw"
Subject: Re: [Qemu-devel] [PATCH 1/9] hw/intc/arm_gic: Document QEMU
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E9r24IIsJoWN0pfovn6XKiYHCmb2EPysw
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <7421acd0-4c9d-95ca-dbd2-a903ef0ee2b8@greensocs.com>
Subject: Re: [PATCH 1/9] hw/intc/arm_gic: Document QEMU interface
References: <20180821132811.17675-1-peter.maydell@linaro.org>
 <20180821132811.17675-2-peter.maydell@linaro.org>
In-Reply-To: <20180821132811.17675-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 8/21/18 3:28 PM, Peter Maydell wrote:
> The GICv2's QEMU interface (sysbus MMIO regions, IRQs,
> etc) is now quite complicated with the addition of the
> virtualization extensions. Add a comment in the header
> file which documents it.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I needed to write this out to figure out what I was
> connecting to what in the a15mpcore object :-)
> ---
>  include/hw/intc/arm_gic.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
> index 42bb535fd45..989bc837606 100644
> --- a/include/hw/intc/arm_gic.h
> +++ b/include/hw/intc/arm_gic.h
> @@ -18,6 +18,41 @@
>   * with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
> =20
> +/*
> + * QEMU interface:
> + *  + QOM property "num-cpu": number of CPUs to support
> + *  + QOM property "num-irq": number of IRQs (including both SPIs and =
PPIs)
> + *  + QOM property "revision": GIC version (1 or 2), or 0 for the 11MP=
Core GIC
> + *  + QOM property "has-security-extensions": set true if the GIC shou=
ld
> + *    implement the security extensions
> + *  + QOM property "has-virtualization-extensions": set true if the GI=
C should
> + *    implement the virtualization extensions
> + *  + unnamed GPIO inputs: (where P is number of PPIs, i.e. num-irq - =
32)
"where P is the number of SPIs"
> + *    [0..P-1]  SPIs
> + *    [P..P+31] PPIs for CPU 0
> + *    [P+32..P+63] PPIs for CPU 1
> + *    ...
> + *  + sysbus IRQ 0 : IRQ
> + *  + sysbus IRQ 1 : FIQ
> + *  + sysbus IRQ 2 : VIRQ (exists even if virt extensions not present)=

> + *  + sysbus IRQ 3 : VFIQ (exists even if virt extensions not present)=

> + *  + sysbus IRQ 4 : maintenance IRQ for CPU i/f 0 (only if virt extns=
 present)
> + *  + sysbus IRQ 5 : maintenance IRQ for CPU i/f 1 (only if virt extns=
 present)
I think it's more like

For a GIC supporting N CPUs:
  + sysbus IRQ 0: IRQ for CPU 0
  + ...
  + sysbus IRQ N-1: IRQ for CPU N-1

  + sysbus IRQ N: FIQ for CPU 0
  + ...
  + sysbus IRQ 2*N-1: FIQ for CPU N-1

  + sysbus IRQ 2*N: VIRQ for CPU 0
  + ...
  + sysbus IRQ 3*N-1: VIRQ for CPU N-1

  + sysbus IRQ 3*N: VFIQ for CPU 0
  + ...
  + sysbus IRQ 4*N-1: VFIQ for CPU N-1

  + sysbus IRQ 4*N: maintenance IRQ for CPU i/f 0 (only if virt extns
present)
  + ...
  + sysbus IRQ 5*N-1: maintenance IRQ for CPU i/f N-1 (only if virt
extns present)

> + *    ...
> + *  + sysbus MMIO regions: (in order; numbers will vary depending on
> + *    whether virtualization extensions are present and on number of c=
ores)
> + *    - distributor registers (GICD*)
> + *    - CPU interface for the accessing core (GICC*)
> + *    - virtual interface control registers (GICH*) (only if virt extn=
s present)
> + *    - virtual CPU interface for the accessing core (GICV*) (only if =
virt)
> + *    - CPU 0 CPU interface registers
> + *    - CPU 1 CPU interface registers
> + *      ...
> + *    - CPU 0 VCPU interface registers (only if virt extns present)
CPU 0 virtual interface (GICH*)
> + *    - CPU 1 VCPU interface registers (only if virt extns present)
CPU 1 virtual interface (GICH*)
> + *      ...> + */
> +
>  #ifndef HW_ARM_GIC_H
>  #define HW_ARM_GIC_H
> =20
>=20


--E9r24IIsJoWN0pfovn6XKiYHCmb2EPysw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt9G78ACgkQd8knW3Qn
Tr777w/8D6tHmil9ayMGzOUe+nn+qMsboQKeEzs7WRrWYyp3gbsGC1LvHNGRghMI
9jRJ3UZd7Ps3aGRpqjq2kyfkVrIGr0SiUW8QyHxFNwde+9UMCrZBRCzbh4p7gxhC
+s1PPvhNGmwG+vI1h0UEhK7jSIOeFF6VSb6cy/tjEaGe2vpPUWYa2ujYSIYEzSTP
vDJSoVtpxbJKKWGrXjA+k1m7McVksb8DnL+FcYPyGz0h/WRek21Z0tx9XJa4k7wK
68EBkusKfatvaXCaxOGycI5mcTVaf0i5RUFNIaczB840RTTFAwFRJJx6QxAA7oZa
yLvrIJIHyjly84LngOwm1VBItuCMqnNwzDxsfa4B26+zFOSIOcjoEmADtV9C4dFk
+hwd7ZBpme2dynp+SAsiFxgUibBc+QV6fsFlNU1mVHaXat7maGgiVCfde3GF7pQx
h0m6rUETAF3k0FqdzZUNS3pCLcvVafeO/yyHUig32j6yOkyBSC8W7zf7ui48T5lX
LbHnoNyhDciwUY1MedSkxT5y41TYYOduSebc/m8edb7efFrXT4iz66R/XJ0cJ/BK
WHUiQT6S0oD2vT9PEYyA/pZ6HoSqbFHKtNVPLJYt5tqVUR1ula1C/2cc02zvc11q
TThCRbY4V7M0G/bSvqyc0CJkx99oo9Wp0CqL3PVe5K21WAifecs=
=ahCz
-----END PGP SIGNATURE-----

--E9r24IIsJoWN0pfovn6XKiYHCmb2EPysw--
