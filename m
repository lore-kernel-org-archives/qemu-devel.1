Received: from eggs.gnu.org ([2001:4830:134:3::10]:59625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYkoY-0002to-Tl
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 21:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYkoX-0004se-Le
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 21:38:30 -0500
Date: Wed, 1 Feb 2017 13:22:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201022259.GJ30639@umbus.fritz.box>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<20170201021600.GI30639@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z8yxTSU1mh2gsre7"
Content-Disposition: inline
In-Reply-To: <20170201021600.GI30639@umbus.fritz.box>
Subject: Re: [Qemu-devel] [RFC PATCH 00/17] target/ppc: Implement POWER9
 pseries tcg legacy kernel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--Z8yxTSU1mh2gsre7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2017 at 01:16:00PM +1100, David Gibson wrote:
> On Fri, Jan 13, 2017 at 05:28:06PM +1100, Suraj Jitindar Singh wrote:
> > This patch set provides the initial implementation of support for the=
=20
> > POWER9 processor running in tcg mode under the pseries machine type.
> >=20
> > To use a POWER9 cpu provide the command line option "-cpu POWER9".
> >=20
> > This is the initial work to make the mmu emulation model look like a PO=
WER9
> >=20
> > Currently only legacy kernels are supported (hash without segment table=
s).
> >=20
> > This patch set will be followed by two more in the near future to suppo=
rt
> > the new process table capabilities added in ISAv3.00; hash via segment
> > tables and radix. Kernels with support for this will currently fail when
> > they try to register a process table as this isn't yet implemented.
> >=20
> > The assumption is that we're running a legacy kernel, in the event the
> > guest registers a process table (when support exists) we will handle it
> > accordingly.
> >=20
> > The main changes are:
> >  - Define a new mmu model and fault handler
> >  - Add new LPCR fields and check them accordingly
> >  - Add a partition table entry to the machine state
> >  - Point to the partition table entry in the cpu state
> >  - Remove SDR1
> >  - Adapt to new pte format
> >  - NOOP the cp_abort instruction
> >  - Small bug fixes
> >=20
> > This was intially one huge patch so I've tried to break it up into what=
 I
> > think are logical chunks, how exactly this should be split up is up for=
=20
> > debate.
> >=20
> > A current upstream kernel with POWER9 support added to the architecture
> > vector should correctly report a POWER9 cpu under /proc/cpuinfo.
>=20
> I've merged 14-16/17 since they seem to stand on their own as fixes.

And 17/17 as well.

>=20
> >=20
> > Suraj Jitindar Singh (17):
> >   powerpc/cpu-models: rename ISAv3.00 logical PVR definition
> >   hw/ppc/spapr: Add POWER9 to pseries cpu models
> >   target/ppc: Add pcr_supported to POWER9 cpu class definition
> >   target/ppc/POWER9: Add ISAv3.00 MMU definition
> >   target/ppc/POWER9: Adapt LPCR handling for POWER9
> >   target/ppc/POWER9: Direct all instr and data storage interrupts to the
> >     hypv
> >   target/ppc/POWER9: Add partition table pointer to sPAPRMachineState
> >   target/ppc/POWER9: Add external partition table pointer to cpu state
> >   target/ppc/POWER9: Remove SDR1 register
> >   target/ppc/POWER9: Add POWER9 mmu fault handler
> >   target/ppc/POWER9: Update to new pte format for POWER9 accesses
> >   target/ppc/POWER9: Add POWER9 pa-features definition
> >   target/ppc/POWER9: Add cpu_has_work function for POWER9
> >   target/ppc/debug: Print LPCR register value if register exists
> >   tcg/POWER9: NOOP the cp_abort instruction
> >   target/ppc/mmu_hash64: Fix printing unsigned as signed int
> >   target/ppc/mmu_hash64: Fix incorrect shift value in amr calculation
> >=20
> >  hw/ppc/spapr.c              | 56 ++++++++++++++++++++++++---
> >  hw/ppc/spapr_cpu_core.c     | 15 +++++++-
> >  hw/ppc/spapr_hcall.c        | 51 +++++++++++++------------
> >  include/hw/ppc/spapr.h      |  1 +
> >  target/ppc/cpu-models.h     |  2 +-
> >  target/ppc/cpu-qom.h        |  5 ++-
> >  target/ppc/cpu.h            | 24 +++++++++++-
> >  target/ppc/kvm.c            | 10 ++++-
> >  target/ppc/mmu-hash64.c     | 68 +++++++++++++++++++++++++++------
> >  target/ppc/mmu-hash64.h     | 73 +++++++++++++++++++++++++----------
> >  target/ppc/mmu.h            | 27 +++++++++++++
> >  target/ppc/mmu_helper.c     | 61 ++++++++++++++++++++++++++++++
> >  target/ppc/translate.c      | 14 ++++++-
> >  target/ppc/translate_init.c | 92 +++++++++++++++++++++++++++++++++++++=
++------
> >  14 files changed, 418 insertions(+), 81 deletions(-)
> >  create mode 100644 target/ppc/mmu.h
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Z8yxTSU1mh2gsre7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkUaDAAoJEGw4ysog2bOSvnMQAM5N31DjdQnfsM1NFxrhSqUv
mGe0VbQA6XOTcjv7YLqRZ7eNUFOCRTj37h3ZNWs4WqWJ3Rwo2bY9XnrUnIGL/AH3
igmcN8m6nFPHk3j2Ur1TArs1OUYsHZwbgoj9XlnbO0Y4fOxb0rDa3qbARxN4rc3t
6CfWLqgjgomrGq3CMgdLZlKrzfnbH7wOP84fnc8Fit3sr5paY6gpavJ9oV3X656M
kZ6HCMel5g3NxiTWgQGgd8e878gy8lAz8BBav20NlTBLZRwnJLO+hGF0tzQCvW4w
Tsn7LnM61ms9aw0JEod92o96I+WAiWPKoIuw29qQvq63YoUoE4amIENUeUrniZll
7V6oTt8EjSn20J0nBKwbdJQ5Opxe8SP5iH9wyv2xcs4ida6R9w4WvDRn6I7Fafhp
pw9UD/7Yxe7t11xuDjlQwcg7ghRwzN/QUp4BAO9uX040AWBxm2HEH6yRId5Hl8VI
Gd2JVZhm7gOw3ULA2nT8iPUO9UUDC+UaLAZ24Y3/RjbXza8GDXTghFwMKLfgmgQq
fX6h3/j8+3UewR+D1vC2aOsrF1K83JjQPVb3JjsUbC+LBzxIgTa+GcFiIU58qkyV
d9ZfC8U0RRKWKkujoa4ILNz0LszdGBhWUA6eNwXlTfCKciVVFy62gfyEjv+TECMR
NsRFw5TXhdWOi526qBYe
=RpND
-----END PGP SIGNATURE-----

--Z8yxTSU1mh2gsre7--
