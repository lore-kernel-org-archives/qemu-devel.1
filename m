Received: from eggs.gnu.org ([2001:4830:134:3::10]:58045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQ83e-0001hJ-Hs
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQ83a-0004Ss-HB
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:15:14 -0400
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:60415)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQ83a-0004Qj-7s
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:15:10 -0400
Received: from player796.ha.ovh.net (unknown [10.109.108.125])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id BB811161BA2
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 11:15:06 +0200 (CEST)
Date: Tue, 5 Jun 2018 11:14:53 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180605111453.25c35c92@bahia.lan>
In-Reply-To: <20180604234211.GC5140@umbus.fritz.box>
References: <152725285229.537901.6934923933763529191.stgit@bahia.lan>
	<20180604234211.GC5140@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/YOIIxCOwrXH6QVj_=U86JFq";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, qemu-stable@nongnu.org

--Sig_/YOIIxCOwrXH6QVj_=U86JFq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Jun 2018 09:42:11 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, May 25, 2018 at 02:54:12PM +0200, Greg Kurz wrote:
> > Since the kernel commit "dbfcf3cb9c68 powerpc/64: Call H_REGISTER_PROC_=
TBL
> > when running as a HPT guest on POWER9", a nested guest running with PR =
KVM
> > hangs at boot:
> >=20
> > Preparing to boot Linux version 4.16.0-kvm-pr-hang-gku+ (greg@qemu2222.=
boston16) (gcc version 8.1.1 20180502 (Red Hat 8.1.1-1) (GCC)) #19 SMP Fri =
May 25 08:41:55 CEST 2018
> > Detected machine type: 0000000000000101
> > command line: root=3DUUID=3D22128c5c-30b1-4e0a-ac16-95853df31131 ro rhg=
b console=3Dhvc0 early_printk disable-radix=3Don
> > Max number of cores passed to firmware: 1024 (NR_CPUS =3D 1024)
> > Calling ibm,client-architecture-support... done
> > memory layout at init:
> >   memory_limit : 0000000000000000 (16 MB aligned)
> >   alloc_bottom : 0000000001b80000
> >   alloc_top    : 0000000030000000
> >   alloc_top_hi : 0000000100000000
> >   rmo_top      : 0000000030000000
> >   ram_top      : 0000000100000000
> > instantiating rtas at 0x000000002fff0000... done
> > prom_hold_cpus: skipped
> > copying OF device tree...
> > Building dt strings...
> > Building dt structure...
> > Device tree strings 0x0000000003d90000 -> 0x0000000003d90abb
> > Device tree struct  0x0000000003da0000 -> 0x0000000003db0000
> > Quiescing Open Firmware ...
> > Booting Linux via __start() @ 0x0000000000400000 ...
> >=20
> > This happens because the H_REGISTER_PROC_TBL implementation in QEMU
> > always call KVM_PPC_CONFIGURE_V3_MMU when KVM is present. This fails
> > in the case of PR KVM, which doesn't implement it, and QEMU returns
> > H_PARAMETER to the guest, which is a BUG() condition in linux.
> >=20
> > In the case of PR, the HPT is allocated in userspace by QEMU, so it
> > doesn't make sense to call KVM_PPC_CONFIGURE_V3_MMU in the first
> > place. So, skip it in this case and let the guest boot.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >=20
> > Note that PR KVM requires this patch from Paul to work on POWER9:
> >=20
> >     https://patchwork.ozlabs.org/patch/916766/
> >=20
> > The original request was coming from people who want to run openQA in
> > fedora28 under PowerVM on a POWER9 system. This requires PR KVM, which
> > will be running in HPT-mode since pHyp doesn't do radix.
> >=20
> > Cc'ing stable because fedora28 ships QEMU 2.11.x.
> > ---
> >  hw/ppc/spapr_hcall.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 022f6d810182..12cbb317e5e8 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1420,7 +1420,7 @@ static target_ulong h_register_process_table(Powe=
rPCCPU *cpu,
> >                    ((flags & FLAG_GTSE) ? LPCR_GTSE : 0),
> >                    LPCR_UPRT | LPCR_GTSE);
> > =20
> > -    if (kvm_enabled()) {
> > +    if (kvm_enabled() && !spapr->htab) {
> >          return kvmppc_configure_v3_mmu(cpu, flags & FLAG_RADIX,
> >                                         flags & FLAG_GTSE, cproc); =20
>=20
> Won't this also omit the configure MMU call if the guest is in radix
> mode?  We don't want that.
>=20

Hmm... not sure how we can have an HPT allocated in userspace if the
guest is radix... or maybe if the guest was hash and then it is
rebooted with a new kernel that only supports radix ?

Anyway, Paul added a minimal implementation of KVM_PPC_CONFIGURE_V3_MMU
to PR KVM, that allow nested guests to run recent kernels:

https://patchwork.ozlabs.org/patch/922688/

So I guess we don't need to patch QEMU.

> >      }
> >  =20
>=20


--Sig_/YOIIxCOwrXH6QVj_=U86JFq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsWVI0ACgkQcdTV5YIv
c9YS/g/8CVjIOBYvG4oyJirWvEGnOHeM88N8M2WP5VvP3FP/F0Hhgg6CUaRVzGAt
v5nUbWVOUq/tqTW6jAaR1XPyEiRZmDORJCNAtV1ppvLbrpBNW/Ixxd18KBGr+75q
7nxh5Xsx53wAKBwZj4ZZkDUsvR2++GsF8/Gr9Bh6Tx2LA8QzT/eCl6EwhzsE9UGN
r2dV3K3U9Y2vCkEJ8TAlarg1nrChlpGx+LNXyfbWGPCRmYA4hZnp1Gcp+x73sbjq
3f1uZsutu3QSKM96tkdaYd6Kv9C/oWADBBfziu0Pb5b70kAu2TlzteR1s0RleVvN
MkqkHlduEvut66plm2FRwV6YY3v68wF5r8oo/8uXlmESEjDAe+8jb5Gpbw1icfC9
T4Jxq+1dvGu2xoygzkYd/ysogqqcDtLSiHmnnjYiC+ktCxsVujgxpPLuKPOCE8RT
Mh1/1FAlE8VgVNV35H+buUlV0LKFNc8f2p3CeEDELAsvCoT4WdeI44bEQE9xf4kd
er7skAUs28xsnxVJiNKbWRaiQjhzzNCbkWuzVzaen2OsM+Qzo7FxcZmmSY6FkW45
gvxKQcpKlPtLkw8Isuu3bIV7lxm7wn0POLTPnX6B2ltgu7kkFGW5PXLUf3qQ3h0c
8OV/9iW5KGOe/XV7tM3pFX9psn6v9h83x7E1eUpJdfBNJ57icHU=
=sCnt
-----END PGP SIGNATURE-----

--Sig_/YOIIxCOwrXH6QVj_=U86JFq--
