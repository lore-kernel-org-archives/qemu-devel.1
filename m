Received: from eggs.gnu.org ([2001:4830:134:3::10]:37174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e57Pf-0006HH-QE
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e57Pe-0001lu-Kq
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:46:51 -0400
Date: Thu, 19 Oct 2017 17:24:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171019062440.GY2776@umbus.fritz.box>
References: <20171016052004.31397-1-aik@ozlabs.ru>
	<20171016093641.GH2776@umbus.fritz.box>
	<e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RacQGezy2Y99S6cT"
Content-Disposition: inline
In-Reply-To: <e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v3] RFC: ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>, slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>


--RacQGezy2Y99S6cT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2017 at 04:55:03PM +1100, Alexey Kardashevskiy wrote:
> On 16/10/17 20:36, David Gibson wrote:
> > On Mon, Oct 16, 2017 at 04:20:04PM +1100, Alexey Kardashevskiy
> wrote:
[snip]
> >> +static const VMStateDescription vmstate_spapr_dtb =3D {
> >> +    .name =3D "spapr_dtb",
> >> +    .version_id =3D 1,
> >> +    .minimum_version_id =3D 1,
> >> +    .needed =3D spapr_dtb_needed,
> >> +    .fields =3D (VMStateField[]) {
> >> +        VMSTATE_UINT32(fdt_initial_size, sPAPRMachineState),
> >=20
> > I'm not sure you need to migrate initial size.  The destination can
> > work this out itself.. > unless we skip the reset when we have an
> > incoming migration, I'm not sure.
>=20
>=20
> Nah, ppc_spapr_reset() is called when incoming migration and does not do
> anything different than normal reset situation so I'll remove this.

Ok.

[snip]
> >> +static target_ulong h_update_dt(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
> >> +                                target_ulong opcode, target_ulong *ar=
gs)
> >> +{
> >> +    target_ulong dt =3D ppc64_phys_to_real(args[0]);
> >> +    struct fdt_header hdr =3D { 0 };
> >> +    unsigned cb;
> >> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> >> +
> >> +    cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
> >> +    cb =3D fdt32_to_cpu(hdr.totalsize);
> >> +
> >> +    if (fdt_check_header(&hdr) ||
> >> +        fdt32_to_cpu(hdr.boot_cpuid_phys) ||
> >=20
> > A nonzero boot cpuid is potentially valid, we shouldn't fail that.
>=20
> Already discovered...


Ok :)

> >> +        fdt32_to_cpu(hdr.off_dt_struct) >=3D cb ||
> >> +        fdt32_to_cpu(hdr.off_dt_strings) >=3D cb ||
> >> +        fdt32_to_cpu(hdr.off_mem_rsvmap) >=3D cb ||
> >=20
> > Just checking the offset isn't very useful.  You need to check two
> > things for each of the blocks:
> > 	off + size >=3D off	; this checks there's no overflow
> > 	off + size <=3D totalsize	; checks the block fits in the blob
> >=20
> > With the additional complication that you don't actually have a size
> > for the rsvmap - so you have to step through it to verify that.  For a
> > v16 blob you don't have one for the structure blob either, but you
> > could simply reject v16 blobs.
>=20
> Ok, v17 it is.
>=20
>=20
> >=20
> >> +        fdt32_to_cpu(hdr.totalsize) !=3D fdt32_to_cpu(hdr.size_dt_str=
ings) +
> >> +                fdt32_to_cpu(hdr.size_dt_struct) +
> >> +                sizeof(struct fdt_reserve_entry) +
> >> +                sizeof(hdr)
> >=20
> > This check is invalid.  It's allowed to have gaps between the blocks
> > in the FDT, which could increase the size.  In some cases it's even
> > required, to meet the alignment requirements for each block.
>=20
>=20
> Invalid? At the moment what SLOF provides passes this check and it will,
> and we only expect these blobs to come from SLOF - no need to protect from
> who knows what.

Well, "invalid" in the sense of unnecessarily restrictive.  Sure, SLOF
satisfies it at the moment, but it's not something qemu actually
*needs*, so all this accomplishes is making qemu more fragile against
SLOF changes (i.e. evil "coupling" in 1st year Comp Sci terminology).

> > ||
> >=20
> > Yeah.. this is all a bit complicated, I'm really thinking about a
> > fdt_fsck() function for libfdt.
>=20
>=20
> Oh. So what now? Do as below or wait for libdtc update?

So I started hacking on this.  It's a bit fiddlier to get right than I
anticipated.  How about you make a placeholder function to "test" the
tree for now, with a comment that it will be updated once the libfdt
extensions are there.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RacQGezy2Y99S6cT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnoRSUACgkQbDjKyiDZ
s5LlbRAAzxK59GAsaCDQ+a5NrzbQmFw2hl9AfjYlqhM1q9lKo+wmbBEUTp7x5rFE
Hwts6MxYWEW7ZSFaN/0PnF39ddjRFORnysHAH5kWtPXgUIQIgNFvhfTaebzkDD/I
aEviOUS0QAwbbN6IGJp7PLlf+JBLHq1j/DiCqVP8jtVoNOBgUYJryJqc7+R8D+lr
wLKlthk75fV4DV/co2JGziJg0SoG0q09ynY5X+p3ZkNZ40vHv3LhrPLjsXjJYhgo
ElvXp1DYd/5KS7ILX9IBeJzj/T8Noypxl4mVm7aN/fgmi/kxndEaJ60QFlq5v4r1
nXmNR9RFHiwJxv34GbiPJv/+HCTiWmibabK4S1/Cyolin5kgirQ1ycYfn7pn1ax9
OH4m1SEsRbHwtOl+LUbO5EX8UQT5ogxxwqLPy1NQ6ZPUAQ7bjsUKWYHsTt1lv7IS
5sNIigimzoE45V8ikqpuZmCwqSv9RJd+Rf/2HLGpzzR2HF3U7hi+5AQ+jav/Qmvl
Pc8JbW2Balwfrnbs5JyuLgg3JwnR/KcFzG+fl6h6HhleY20t17pqpG4icUiWs/el
FDWtsr2TIiINFyKUNxKdoGJeyqyrFgOXPe9kAqUSl9L7C+u7knlGzZegyxELG2dK
WXmAQij/jDqU1lBVGyeEP1AI8yjQpBYYFgSahgHgh2/g1zfhMF4=
=gGff
-----END PGP SIGNATURE-----

--RacQGezy2Y99S6cT--
