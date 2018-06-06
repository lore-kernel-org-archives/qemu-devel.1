Received: from eggs.gnu.org ([2001:4830:134:3::10]:55002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQNaa-0005II-6t
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 21:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQNaY-0000oN-Qo
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 21:50:16 -0400
Date: Wed, 6 Jun 2018 11:43:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180606014332.GG17757@umbus.fritz.box>
References: <152725285229.537901.6934923933763529191.stgit@bahia.lan>
	<20180604234211.GC5140@umbus.fritz.box>
	<20180605111453.25c35c92@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eMnpOGXCMazMAbfp"
Content-Disposition: inline
In-Reply-To: <20180605111453.25c35c92@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: don't call KVM_PPC_CONFIGURE_V3_MMU
 if HPT is in userspace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, qemu-stable@nongnu.org


--eMnpOGXCMazMAbfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 11:14:53AM +0200, Greg Kurz wrote:
> On Tue, 5 Jun 2018 09:42:11 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, May 25, 2018 at 02:54:12PM +0200, Greg Kurz wrote:
> > > Since the kernel commit "dbfcf3cb9c68 powerpc/64: Call H_REGISTER_PRO=
C_TBL
> > > when running as a HPT guest on POWER9", a nested guest running with P=
R KVM
> > > hangs at boot:
> > >=20
> > > Preparing to boot Linux version 4.16.0-kvm-pr-hang-gku+ (greg@qemu222=
2.boston16) (gcc version 8.1.1 20180502 (Red Hat 8.1.1-1) (GCC)) #19 SMP Fr=
i May 25 08:41:55 CEST 2018
> > > Detected machine type: 0000000000000101
> > > command line: root=3DUUID=3D22128c5c-30b1-4e0a-ac16-95853df31131 ro r=
hgb console=3Dhvc0 early_printk disable-radix=3Don
> > > Max number of cores passed to firmware: 1024 (NR_CPUS =3D 1024)
> > > Calling ibm,client-architecture-support... done
> > > memory layout at init:
> > >   memory_limit : 0000000000000000 (16 MB aligned)
> > >   alloc_bottom : 0000000001b80000
> > >   alloc_top    : 0000000030000000
> > >   alloc_top_hi : 0000000100000000
> > >   rmo_top      : 0000000030000000
> > >   ram_top      : 0000000100000000
> > > instantiating rtas at 0x000000002fff0000... done
> > > prom_hold_cpus: skipped
> > > copying OF device tree...
> > > Building dt strings...
> > > Building dt structure...
> > > Device tree strings 0x0000000003d90000 -> 0x0000000003d90abb
> > > Device tree struct  0x0000000003da0000 -> 0x0000000003db0000
> > > Quiescing Open Firmware ...
> > > Booting Linux via __start() @ 0x0000000000400000 ...
> > >=20
> > > This happens because the H_REGISTER_PROC_TBL implementation in QEMU
> > > always call KVM_PPC_CONFIGURE_V3_MMU when KVM is present. This fails
> > > in the case of PR KVM, which doesn't implement it, and QEMU returns
> > > H_PARAMETER to the guest, which is a BUG() condition in linux.
> > >=20
> > > In the case of PR, the HPT is allocated in userspace by QEMU, so it
> > > doesn't make sense to call KVM_PPC_CONFIGURE_V3_MMU in the first
> > > place. So, skip it in this case and let the guest boot.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >=20
> > > Note that PR KVM requires this patch from Paul to work on POWER9:
> > >=20
> > >     https://patchwork.ozlabs.org/patch/916766/
> > >=20
> > > The original request was coming from people who want to run openQA in
> > > fedora28 under PowerVM on a POWER9 system. This requires PR KVM, which
> > > will be running in HPT-mode since pHyp doesn't do radix.
> > >=20
> > > Cc'ing stable because fedora28 ships QEMU 2.11.x.
> > > ---
> > >  hw/ppc/spapr_hcall.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > > index 022f6d810182..12cbb317e5e8 100644
> > > --- a/hw/ppc/spapr_hcall.c
> > > +++ b/hw/ppc/spapr_hcall.c
> > > @@ -1420,7 +1420,7 @@ static target_ulong h_register_process_table(Po=
werPCCPU *cpu,
> > >                    ((flags & FLAG_GTSE) ? LPCR_GTSE : 0),
> > >                    LPCR_UPRT | LPCR_GTSE);
> > > =20
> > > -    if (kvm_enabled()) {
> > > +    if (kvm_enabled() && !spapr->htab) {
> > >          return kvmppc_configure_v3_mmu(cpu, flags & FLAG_RADIX,
> > >                                         flags & FLAG_GTSE, cproc); =
=20
> >=20
> > Won't this also omit the configure MMU call if the guest is in radix
> > mode?  We don't want that.
> >=20
>=20
> Hmm... not sure how we can have an HPT allocated in userspace if the
> guest is radix... or maybe if the guest was hash and then it is
> rebooted with a new kernel that only supports radix ?

Oops, got my sense reversed.  Rather, couldn't this call
configure_v3_mmu() on PR when you do have a Radix guest, which would
still cause problems.

> Anyway, Paul added a minimal implementation of KVM_PPC_CONFIGURE_V3_MMU
> to PR KVM, that allow nested guests to run recent kernels:
>=20
> https://patchwork.ozlabs.org/patch/922688/
>=20
> So I guess we don't need to patch QEMU.

Yeah, I think that's a better solution.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eMnpOGXCMazMAbfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsXPEEACgkQbDjKyiDZ
s5IgcRAAtu02+Ddyc36sJW8JgfQkn8WppR1A+OJ1coY25j2FI0yO6vmgVCnwweP2
G14rP1C0wks5Ba5XXTFTfZg7i3PpEL3g/UR3F3QCGbp2BIRFHrSvKDamGFkd1GIs
9gkobwhESWDp7/EbNdq/o8Wg0vzz88ThfymDm5lZzApMkxChPF+jwpQti1lmpZug
JYudqr/4D9IuJvU/prR/VT+J3YrP6wR+spPCvI2FGRT1A1Vu+e86nOadPuFaDxiv
bWQPnGzu4+YflJXsOMpkIl0UIMMe8XcRXWqcgZ++b66oqwFpfHKw2Rf/JV7gQ2L+
5q1TKGHS+vdlvLiOSCDE08k0S1duwkJp9QrRUReeWrhUgspBc6terOo856O17J5M
RPykp/bCdczOKnKx/p5+fCIJ6ZsxNVJKXoGL/zV7+V4OiRdl+ZVCkuLc//9eKDl8
oC2dMNOgXlHrPCW6zacAUWu/zy+QEZn4fSVovB0i9Xjg5WhX8BTuJvlheeTUwFLg
ZIGOCOHN0sOL+KUaBDr+8ExtCTpousfpGrDv1qaPVkCD4646Y6bH5iX2QcHsKvqm
ifNRTM/etsLF+viJdAgQmdtfHAI/70YCe1A6EaxJRWbw3UOlDNsyLqOLZc3JPNSI
hKUtRo0saRYgmOrqNbgtlR08P1eW/jKDKYn53g1cZeee1QABzBU=
=ZK1E
-----END PGP SIGNATURE-----

--eMnpOGXCMazMAbfp--
