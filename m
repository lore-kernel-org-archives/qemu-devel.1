Received: from eggs.gnu.org ([2001:4830:134:3::10]:49752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd8RY-0002Qk-ND
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 23:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd8RX-00026J-Bp
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 23:40:52 -0500
Date: Mon, 13 Feb 2017 15:40:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170213044039.GX25381@umbus>
References: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hEi834+foqWOL7fK"
Content-Disposition: inline
In-Reply-To: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V2 00/10] target/ppc: Implement
 POWER9 pseries tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com


--hEi834+foqWOL7fK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 04:25:50PM +1100, Suraj Jitindar Singh wrote:
> This is V2 of the patch series to implement tcg emulation support for a
> POWER9 cpu model for the pseries machine type running a legacy kernel.
> That is a kernel which doesn't use the new radix mmu mode or the new hash
> mmu mode with segment tables.
>=20
> To use a POWER9 cpu provide the command line option "-cpu POWER9".
>=20
> This series attempts to avoid precluding KVM-HV support for the POWER9
> cpu model but doesn't attempt to support KVM-PR or the powernv machine
> for the POWER9 cpu model as these aren't currently supported or
> implemented and further code changes will be required in the event these
> are implemented.
>=20
> This series will be followed shortly by one to implement radix support and
> currently trying to boot a kernel with support for radix with this series
> will fail on the H_REGISTER_PROCESS_TABLE hcall.

I've applied 1-4 to ppc-for-2.9.  That leaves something rather
incomplete, but then that's pretty much already true for our POWER9
support.

>=20
> The changes from V1 are as follows:
>=20
>  - Drop patches which have already been merged.
>  - Instead of allocating a whole partition table we allocate a single
>    entry in the sPAPRMachineState and access it via the virtual hypv.
>  - Changes to how we handle SDR1 and renaming of associated functions.
>  - Drop patch to use the new pte format, guest kernels expect the old
>    format anyway, so this will only be applicable when POWER9 powernv
>    support is added, so delay adding support for this until then.
>  - Rename the mmu fault handler to ppc64_v3_handle_mmu_fault.
>  - Move segment table searching into the fault handler instead of in
>    slb_lookup().
>  - Move adding the POWER9 pseries cpu model to the end of the series.
>=20
> Suraj Jitindar Singh (10):
>   target/ppc/POWER9: Add ISAv3.00 MMU definition
>   target/ppc: Fix LPCR DPFD mask define
>   target/ppc/POWER9: Adapt LPCR handling for POWER9
>   target/ppc/POWER9: Direct all instr and data storage interrupts to the
>     hypv
>   target/ppc: Add patb_entry to sPAPRMachineState
>   target/ppc: Don't use SDR1 when running under a POWER9 cpu model
>   target/ppc/POWER9: Add POWER9 mmu fault handler
>   target/ppc/POWER9: Add POWER9 pa-features definition
>   target/ppc/POWER9: Add cpu_has_work function for POWER9
>   hw/ppc/spapr: Add POWER9 to pseries cpu models
>=20
>  hw/ppc/spapr.c              | 37 ++++++++++++++++++
>  hw/ppc/spapr_cpu_core.c     |  3 ++
>  include/hw/ppc/spapr.h      |  1 +
>  target/ppc/cpu-qom.h        |  5 ++-
>  target/ppc/cpu.h            | 24 +++++++++++-
>  target/ppc/kvm.c            |  2 +-
>  target/ppc/machine.c        |  4 +-
>  target/ppc/misc_helper.c    |  3 +-
>  target/ppc/mmu-hash64.c     | 49 +++++++++++++++++++++---
>  target/ppc/mmu-hash64.h     |  2 +-
>  target/ppc/mmu.h            | 50 +++++++++++++++++++++++++
>  target/ppc/mmu_helper.c     | 54 +++++++++++++++++++++++++--
>  target/ppc/translate.c      |  7 +++-
>  target/ppc/translate_init.c | 91 +++++++++++++++++++++++++++++++++++++++=
------
>  14 files changed, 302 insertions(+), 30 deletions(-)
>  create mode 100644 target/ppc/mmu.h
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hEi834+foqWOL7fK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoTjGAAoJEGw4ysog2bOS+UcQALb/txiDg1UFuJgZa4ld9wYR
h7WVdhQBNJc8KlZylSKJ2oVID9J30NGRcylHe14Fc4SvG5os8l98byFNEkE4/AQ1
3ZFoGVSlWlj1Sbgl6p/Hp0K5VCAwMRCGi+LHQIUvr+PsuIeRQ5xhZFavC6OpfQkS
KaSU2VOMguqzetyX/Iqbdk+SW6kCJbRrzg4mmoEc23uc9rkfkCKgCvBJ/JNko9Js
4iGd86Lw+RVtpZRdErIKLulRduNQUGq6/Q7bC/86HJ+39wUEr9tA8htn3eQsOsjh
GeDRZnpGX3raV0E2GZEeYj7bbhMLw6d2b7O1N84cJdrpLvCfDKISwEVZoiDvWf3p
EzDRmPEy7TnMqqZO9UGf2z9vr471M+iUO9HLrFVj9zgBWF3BBW+k8dYtc7WiJK2+
mZOiQqEt9ClbPltN670KYh8fV8wubr1prMN1RQ+KQNAEo3dEAMjaaDhDg0OTIq9t
bo4aFjP3j2uIziihEzZaWbBlI5eWjULy9xdzM90TquvrQOA776COUxsHNZ6n5d02
sxQai61t4N7Ni76v2lIJ9fjOB/RJJISuyfip1f4yZlIfDZO4wl8m/5QqkqK88CL4
6zBnXCfu2l3IBYlnTOUozicCesZkm28qTw4xFjw9GsyFs5/wtEQbZn9OEHu9PKja
51xRC140TLNxQzaC/dZK
=qnTm
-----END PGP SIGNATURE-----

--hEi834+foqWOL7fK--
