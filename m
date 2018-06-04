Received: from eggs.gnu.org ([2001:4830:134:3::10]:37023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPz7H-0004km-QX
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 19:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPz7E-0002r9-GS
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 19:42:23 -0400
Date: Tue, 5 Jun 2018 09:42:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180604234211.GC5140@umbus.fritz.box>
References: <152725285229.537901.6934923933763529191.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <152725285229.537901.6934923933763529191.stgit@bahia.lan>
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


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 02:54:12PM +0200, Greg Kurz wrote:
> Since the kernel commit "dbfcf3cb9c68 powerpc/64: Call H_REGISTER_PROC_TBL
> when running as a HPT guest on POWER9", a nested guest running with PR KVM
> hangs at boot:
>=20
> Preparing to boot Linux version 4.16.0-kvm-pr-hang-gku+ (greg@qemu2222.bo=
ston16) (gcc version 8.1.1 20180502 (Red Hat 8.1.1-1) (GCC)) #19 SMP Fri Ma=
y 25 08:41:55 CEST 2018
> Detected machine type: 0000000000000101
> command line: root=3DUUID=3D22128c5c-30b1-4e0a-ac16-95853df31131 ro rhgb =
console=3Dhvc0 early_printk disable-radix=3Don
> Max number of cores passed to firmware: 1024 (NR_CPUS =3D 1024)
> Calling ibm,client-architecture-support... done
> memory layout at init:
>   memory_limit : 0000000000000000 (16 MB aligned)
>   alloc_bottom : 0000000001b80000
>   alloc_top    : 0000000030000000
>   alloc_top_hi : 0000000100000000
>   rmo_top      : 0000000030000000
>   ram_top      : 0000000100000000
> instantiating rtas at 0x000000002fff0000... done
> prom_hold_cpus: skipped
> copying OF device tree...
> Building dt strings...
> Building dt structure...
> Device tree strings 0x0000000003d90000 -> 0x0000000003d90abb
> Device tree struct  0x0000000003da0000 -> 0x0000000003db0000
> Quiescing Open Firmware ...
> Booting Linux via __start() @ 0x0000000000400000 ...
>=20
> This happens because the H_REGISTER_PROC_TBL implementation in QEMU
> always call KVM_PPC_CONFIGURE_V3_MMU when KVM is present. This fails
> in the case of PR KVM, which doesn't implement it, and QEMU returns
> H_PARAMETER to the guest, which is a BUG() condition in linux.
>=20
> In the case of PR, the HPT is allocated in userspace by QEMU, so it
> doesn't make sense to call KVM_PPC_CONFIGURE_V3_MMU in the first
> place. So, skip it in this case and let the guest boot.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>=20
> Note that PR KVM requires this patch from Paul to work on POWER9:
>=20
>     https://patchwork.ozlabs.org/patch/916766/
>=20
> The original request was coming from people who want to run openQA in
> fedora28 under PowerVM on a POWER9 system. This requires PR KVM, which
> will be running in HPT-mode since pHyp doesn't do radix.
>=20
> Cc'ing stable because fedora28 ships QEMU 2.11.x.
> ---
>  hw/ppc/spapr_hcall.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 022f6d810182..12cbb317e5e8 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1420,7 +1420,7 @@ static target_ulong h_register_process_table(PowerP=
CCPU *cpu,
>                    ((flags & FLAG_GTSE) ? LPCR_GTSE : 0),
>                    LPCR_UPRT | LPCR_GTSE);
> =20
> -    if (kvm_enabled()) {
> +    if (kvm_enabled() && !spapr->htab) {
>          return kvmppc_configure_v3_mmu(cpu, flags & FLAG_RADIX,
>                                         flags & FLAG_GTSE, cproc);

Won't this also omit the configure MMU call if the guest is in radix
mode?  We don't want that.

>      }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsVzlMACgkQbDjKyiDZ
s5INGA/+OjLcGV5WUxkrtENLmuGLDS7CAn3uYQVtGgw59rs6ycuFt2IzI0n8A01z
ThpxIGrS+SuSo7TUDqt5zeiheRn5fDlSO6liVWUAayFrtVDE24M/h07eL6QQBZHu
GZTme4ALy0x3BKbrf8KB8xxR8geOK0etvhGcRmLSxEjBtZBahXJVuntw2keldRwj
CBWtSZoNTWnV4A+AUK+liRwLuLgduPhhHum6ej3P+fx8funTV3a4EtOjKMhm6MnF
ei9MCk/vAhP/Ag7nyxd5RMP+hq8qDESIGxxEmZwfDSw6q+iyKuOatUXTujeFXKdP
SEW/I3qbppAX8LpoSA9acW+Vg+oHT/dgZNCxoVnjY9cIFmhNnJiDg/SuCxVf7PQx
O6DxyqWyYVPrN+Ikc1CZVy4RugdN3Qlk4/n5G27sY2cuVoM90odCNptdu/gaEt4J
qniPNe99DiUg2KRZXroNfb9wp92ig4p8uLge1oMz1Wb58fF5BmDodR408GI4nmm1
KcRYR7zSk6PlFMpDxsIb+QBNcrfwUhDQfWqnF1sqhykPyPw85xne2ngyX2pYzU0u
znKMsnQ3MYLR7AbHIeHcq9p9qEdvb2MMzgm6D5Er3zpkdjM7+b4JNG1yfqeJUUyW
EpYh4AX/oytKDxrbtRdTxb5T4VnAI4XaUOJRNziMlZ1CPS1tTk0=
=NnO6
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
