Received: from eggs.gnu.org ([2001:4830:134:3::10]:33720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fuBlr-0000L0-E1
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fuBlq-0007RK-Hy
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:17:07 -0400
References: <20180823103818.31189-1-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <0d9483b2-eab3-3361-8d10-bd31bb11e169@greensocs.com>
Date: Mon, 27 Aug 2018 09:16:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180823103818.31189-1-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hdW4xaa2HNUcyl3Yo8L6EbvSp3oqdDfmk"
Subject: Re: [Qemu-devel] [PATCH v2] hw/intc/arm_gic: Document QEMU interface
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
--hdW4xaa2HNUcyl3Yo8L6EbvSp3oqdDfmk
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <0d9483b2-eab3-3361-8d10-bd31bb11e169@greensocs.com>
Subject: Re: [PATCH v2] hw/intc/arm_gic: Document QEMU interface
References: <20180823103818.31189-1-peter.maydell@linaro.org>
In-Reply-To: <20180823103818.31189-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 8/23/18 12:38 PM, Peter Maydell wrote:
> The GICv2's QEMU interface (sysbus MMIO regions, IRQs,
> etc) is now quite complicated with the addition of the
> virtualization extensions. Add a comment in the header
> file which documents it.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I needed to write this out to figure out what I was
> connecting to what in the a15mpcore object :-)
>=20
> v1->v2 changes: fixed errors in sysbus IRQ and per-cpu GICH
> memory region docs pointed out by Luc.
>=20
>  include/hw/intc/arm_gic.h | 43 +++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 43 insertions(+)
>=20
> diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
> index 42bb535fd45..1af5051ed5d 100644
> --- a/include/hw/intc/arm_gic.h
> +++ b/include/hw/intc/arm_gic.h
> @@ -18,6 +18,49 @@
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
I think here it's "where P is the number of SPIs".

Apart from that:

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

--=20
Luc

> + *    [0..P-1]  SPIs
> + *    [P..P+31] PPIs for CPU 0
> + *    [P+32..P+63] PPIs for CPU 1
> + *    ...
> + *  + sysbus IRQs: (in order; number will vary depending on number of =
cores)
> + *    - IRQ for CPU 0
> + *    - IRQ for CPU 1
> + *      ...
> + *    - FIQ for CPU 0
> + *    - FIQ for CPU 1
> + *      ...
> + *    - VIRQ for CPU 0 (exists even if virt extensions not present)
> + *    - VIRQ for CPU 1 (exists even if virt extensions not present)
> + *      ...
> + *    - VFIQ for CPU 0 (exists even if virt extensions not present)
> + *    - VFIQ for CPU 1 (exists even if virt extensions not present)
> + *      ...
> + *    - maintenance IRQ for CPU i/f 0 (only if virt extensions present=
)
> + *    - maintenance IRQ for CPU i/f 1 (only if virt extensions present=
)
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
> + *    - CPU 0 virtual interface control registers (only if virt extns =
present)
> + *    - CPU 1 virtual interface control registers (only if virt extns =
present)
> + *      ...
> + */
> +
>  #ifndef HW_ARM_GIC_H
>  #define HW_ARM_GIC_H
> =20
>=20


--hdW4xaa2HNUcyl3Yo8L6EbvSp3oqdDfmk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAluDpV0ACgkQd8knW3Qn
Tr5abg/8DvqdBhWgDNK9EOIWiBMnypgdwr0gONeXjjnWbXmVkV5gXdZVdDJajsLX
X4W8Y+gEZ/bKVaFL1Hfw7HlFI8VtB2D7xXJjikIz65N6CExScxVc/E9QslrmmP19
/4jHdzugFIAc+whVdmwO5ijpfyUWa0TviNyJBOPaiZEb0wjnYovpj4B0+If+ULIw
yGJaQcSsuDPcuemo+RjmGRT6fYZ4OlbwbEwXMm0anSYlGHPmjeugZ4bsxPYa0/Ko
XIR7mIWKdEwrO8qvBfoIf4sND5uYwwexcVJmS735zchCnl6VgzKFIXR+O19cuIDB
QZA4Hy6DzlKVpcdeEtjb45V4E2W+w94dzrE87eNtYOdRnisz+31elSWmCcXz/BRJ
RSt9GP2vKgbtTUZLB+1OrVg2cQ83LkR0dE/nmoqw/x1b2YHZkx2X7Z8059gh6ve1
FBTbD3w5cxJwDXM4IGJ5Bh1S/OSk/kR/F2+m0HoVkUOC37WjwASqA7Q8kGj8gYd/
rk0A5NE29qRKX5dHl/9R/ZzD/iP/hv90CuPdKsVf4yN1thXn6WlXlmscQrjNz484
yfu5NX4D/PfURY470BdwY3KmfkE5UfmM/yVoFkpqCVPTSYPGR9ajNNtcu/8rXdS7
94eO4LbWL8fHXqYNZ1GGsPx+JMX8g4H2g5blO6Ibmg+5Je0n81s=
=kzpr
-----END PGP SIGNATURE-----

--hdW4xaa2HNUcyl3Yo8L6EbvSp3oqdDfmk--
