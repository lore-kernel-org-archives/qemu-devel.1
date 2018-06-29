Received: from eggs.gnu.org ([2001:4830:134:3::10]:57608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYlqo-0001I3-0g
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 01:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYlqk-0001pC-Px
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 01:21:41 -0400
Date: Fri, 29 Jun 2018 15:21:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180629052126.GN3422@umbus.fritz.box>
References: <153018086531.336571.17029459443980070626.stgit@bahia.lan>
	<20180628214618.09123598@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uMPAU7A2Er6+wvsD"
Content-Disposition: inline
In-Reply-To: <20180628214618.09123598@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/3] spapr: fix regression with
 older machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


--uMPAU7A2Er6+wvsD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2018 at 09:48:25PM +0200, Greg Kurz wrote:
> On Thu, 28 Jun 2018 12:14:25 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > Since the recent cleanups to hide host configuration details from guest=
s,
> > it isn't possible to start an older machine type with HV KVM [*]:
> >=20
> > qemu-system-ppc64: KVM doesn't support for base page shift 34
> >=20
> > This basically boils down to the fact that it isn't safe to call
> > the kvmppc_hpt_needs_host_contiguous_pages() helper from a class
> > init function because:
> > - KVM isn't initialized yet, and kvm_enabled() always return false
> >   in this case. This causes kvmppc_hpt_needs_host_contiguous_pages()
> >   to do nothing and we end up choosing a 16G default page size
> >   which is not supported by KVM.
> > - even if we drop kvm_enabled() we then have the issue that
> >   kvmppc_hpt_needs_host_contiguous_pages() assumes CPUs are
> >   created, which isn't the case either.
> >=20
> > The choice was made to initialize capabilities during machine
> > init before creating the CPUs, and I don't think we should
> > revert to the previous behavior. Let's go forward instead and
> > ensure we can retrieve the MMU information from KVM before
> > CPUs are created.
> >=20
> > To fix this, we first change kvm_get_smmu_info() so that it
> > doesn't need a CPU object. This allows to stop using first_cpu
> > in kvmppc_hpt_needs_host_contiguous_pages(). Then we delay
> > the setting of the default value to machine init time, so
> > that we're sure that KVM is fully initialized.
> >=20
> > As a bonus, the last patch is a tentative to be able to detect
> > such misuse of *_enabled() accelerator helpers earlier.
> >=20
> > Please comment.
> >=20
> > [*] it also breaks PR KVM actually, but the error is different and
> >     I need to dig some more.
> >=20
>=20
> With current master:
>=20
> 1) qemu-system-ppc64 -machine pseries,accel=3Dkvm,kvm-type=3DPR
>=20
> The guest starts but its kernel oopses at some point:
>=20
> [    0.011328] kernel tried to execute exec-protected page (c000000001611=
244) -exploit attempt? (uid: 0)
> [    0.011379] Unable to handle kernel paging request for instruction fet=
ch
> [    0.011416] Faulting instruction address: 0xc000000001611244
> [    0.011453] Oops: Kernel access of bad area, sig: 11 [#1]
> [    0.011482] LE SMP NR_CPUS=3D1024 NUMA pSeries
> [    0.011512] Modules linked in:
> [    0.011557] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.17.2-200.fc28.=
ppc64le #1
> [    0.011600] NIP:  c000000001611244 LR: c00000000000acec CTR: 000000000=
0000000
> [    0.011643] REGS: c00000003fffba90 TRAP: 0400   Not tainted  (4.17.2-2=
00.fc28.ppc64le)
> [    0.011694] MSR:  b000000010001033 <SF,HV,ME,IR,DR,RI,LE>  CR: 2800084=
8  XER: 20000000
> [    0.011741] CFAR: 0000000000000000 SOFTE: 1=20
> [    0.011741] GPR00: 0000000000000000 c00000003fffbd10 c000000001570b00 =
c00000003fffbd80=20
> [    0.011741] GPR04: c000000000034418 0000000048000000 000000000000000a =
000000004aa21de8=20
> [    0.011741] GPR08: 000000007d410164 0000000000000000 0000000000000002 =
0000000000000900=20
> [    0.011741] GPR12: b000000002009033 c000000001840000 c000000000071a2c =
00000000495de1a4=20
> [    0.011741] GPR16: 0000000000000078 c00000000160fd10 c000000000e705e0 =
000000007c1b03a6=20
> [    0.011741] GPR20: 000000007c1ffaa6 c0000000016125b8 c0000000014253e8 =
000000007c1303a6=20
> [    0.011741] GPR24: 000000007c1643a6 000000007c1a03a6 c00000000160fd08 =
ffffffffebc0f008=20
> [    0.011741] GPR28: ffffffffebc0f000 c0000000000345d8 c0000000000345d8 =
0000000000000000=20
> [    0.012138] NIP [c000000001611244] kvm_tmp+0x1534/0x100000
> [    0.012170] LR [c00000000000acec] soft_nmi_common+0xcc/0xd0
> [    0.012199] Call Trace:
> [    0.012214] Instruction dump:
> [    0.012236] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXX=
XXXX XXXXXXXX=20
> [    0.012289] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXX=
XXXX XXXXXXXX=20
> [    0.012334] ---[ end trace d2ee28832d481d2d ]---
> [    0.012362]=20
> [    1.012387] kernel tried to execute exec-protected page (c000000001611=
808) -exploit attempt? (uid: 0)
> [    1.012433] Unable to handle kernel paging request for instruction fet=
ch
> [    1.012468] Faulting instruction address: 0xc000000001611808
> [    1.012504] Oops: Kernel access of bad area, sig: 11 [#2]
> [    1.012532] LE SMP NR_CPUS=3D1024 NUMA pSeries
> [    1.012561] Modules linked in:
> [    1.012583] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G      D           =
4.17.2-200.fc28.ppc64le #1
> [    1.012641] NIP:  c000000001611808 LR: c0000000001247fc CTR: c00000000=
1840000
> [    1.012684] REGS: c00000003fffb5d0 TRAP: 0400   Tainted: G      D     =
       (4.17.2-200.fc28.ppc64le)
> [    1.012740] MSR:  b000000010001033 <SF,HV,ME,IR,DR,RI,LE>  CR: 4800022=
4  XER: 20000000
> [    1.012785] CFAR: 0000000000000000 SOFTE: 0=20
> [    1.012785] GPR00: c0000000001247fc c00000003fffb850 c000000001570b00 =
0000000000000000=20
> [    1.012785] GPR04: 0000000000000000 c0000000fe9e4900 fffffffffffffffd =
c0000000fe9e4900=20
> [    1.012785] GPR08: 00000000fed50000 b000000000001033 0000000000000009 =
c00000003fffb55f=20
> [    1.012785] GPR12: 0000000000000000 c000000001840000 c000000000071a2c =
00000000495de1a4=20
> [    1.012785] GPR16: 0000000000000078 c00000000160fd10 c000000000e705e0 =
000000007c1b03a6=20
> [    1.012785] GPR20: 000000007c1ffaa6 c0000000016125b8 c0000000014253e8 =
000000007c1303a6=20
> [    1.012785] GPR24: 000000007c1643a6 000000007c1a03a6 c00000000160fd08 =
ffffffffebc0f008=20
> [    1.012785] GPR28: 0000000000000000 000000000000000b 000000000000000b =
c0000000fe9e4900=20
> [    1.013166] NIP [c000000001611808] kvm_tmp+0x1af8/0x100000
> [    1.013196] LR [c0000000001247fc] do_exit+0x12c/0xd30
> [    1.013224] Call Trace:
> [    1.013238] Instruction dump:
> [    1.013260] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXX=
XXXX XXXXXXXX=20
> [    1.013303] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXX=
XXXX XXXXXXXX=20
> [    1.013348] ---[ end trace d2ee28832d481d2e ]---
> [    1.013375]=20
> [    2.013391] Fixing recursive fault but reboot is needed!
>=20
> and the guest gets unresponsive.

Huh, that's a bit weird.

> 2) qemu-system-ppc64 -machine pseries-2.12,accel=3Dkvm,kvm-type=3DPR
>=20
> prints an error message and terminates right away:
>=20
> qemu-system-ppc64: KVM doesn't support page shift 24/12
>=20
> This error is expected: since PR KVM doesn't set KVM_PPC_PAGE_SIZES_REAL,
> ie, we choose to support all possible page sizes, but PR KVM doesn't
> support this page shift combination indeed. Unsurprisingly we get the
> same error with:
>=20
> -machine pseries,accel-kvm,kvm-type=3DPR,cap-hpt-max-page-size=3D${pagesi=
ze}
>=20
> if ${pagesize} is >=3D 16m. This is the result of PR KVM not supporting
> MPSS at all, even though it supports 16m pages in a 16m segment. We
> cannot really fix this in QEMU, unless we completely filter out MPSS
> in spapr_pagesize_cb() but I'm pretty sure we don't want that. :)

Yeah.  I think sacrificing PR without special options (or fixing PR)
is the price we have to pay for sane behaviour otherwise here.

> But then, if we go for a 64k limit, we hit 1).
>=20
> An obvious change in the DT since the page size cleanup is:
>=20
>                             [4k seg    [4k pg]] [64k seg      [64k pg]] [=
16m seg      [16m pg]]
> - ibm,segment-page-sizes =3D <0xc 0x0 0x1 0xc 0x0 0x10 0x110 0x1 0x10 0x1=
 0x18 0x100 0x1 0x18 0x0>;
> + ibm,segment-page-sizes =3D <0xc 0x0 0x1 0xc 0x0 0x10 0x110 0x1 0x10 0x1=
>;
>                             [4k seg    [4k pg]] [64k seg      [64k pg]]
>=20
> If I add the 16m entry back, the guest boots just fine.
>=20
> Not sure yet what's happening... any idea ?

No, not sure why lacking 16m pages would break PR.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uMPAU7A2Er6+wvsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls1wdYACgkQbDjKyiDZ
s5JUKxAAmO73DK1F+LveT6fl2otSE/R9/SkzQobZPPAvJbBARZPZPw4LXp/2BqEN
eT8oHOa0+mlkztVsCgikU61xxM2YjT19+iL+51KJnHJAGB/wXpQSYmqCmHNQNVYu
2e9MSdJo1FE4kES4LxIlYaB5OFOQ6roGnfqTeTcPUE9L1NuYFiEDs90LX+Blsw16
yAnVNtq2H9bQERcZyvdAyD5ixHNFLdHVkd8XMBVDt7CI/e66oerDQv8LcverfJlu
/SCbg51S1hg+5tIqwpebrt3y2Mfj0WuQBWZ/WWowYmVKoVG0LyNeIqfJdL82Qzl2
YF+hr/3jIZM2riDFZA9K0OSldqpA/T1+64C0sTKhh3s8JsZtyi1Sw2Tcp46b0bJj
3WuI2Nyr7gmRayjSMDmbAF7g6w4kQCkUj2Xa+F5Vmne29/pb/QWyqtr/RtqEIk0F
A3HrK11CY+eikxSpZxnrsK/Rm2tWnHbUbyXiUiDEb037pMcUZQWPq1yx6M4sdGEs
vWgGU3VexUuIOtZtox4tsc7PYquTD1Gl2MIsojfTk/a73Mf41bHgoR3hnapgdeHj
c771W9Ny4BYhGOCDpFihZizI/Aqt34N3120DRhftkpMZtd5scOhlE1q9xhAyPF9E
jas/OoRjKfUxkNXiWz13rIicPnDqgCDxH8529UNIfSxeERc26u8=
=Dk/W
-----END PGP SIGNATURE-----

--uMPAU7A2Er6+wvsD--
