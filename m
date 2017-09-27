Received: from eggs.gnu.org ([2001:4830:134:3::10]:36370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx602-0003YC-Uf
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx601-0000Zp-Jz
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:39:14 -0400
Date: Wed, 27 Sep 2017 16:39:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170927063903.GO12504@umbus>
References: <150633285374.14880.11614678065344980502.stgit@bahia.lan>
	<20170926025739.GF12504@umbus> <20170926091928.50e115ff@bahia.lan>
	<20170926102936.1a099080@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vEfizQhTV1P/vojJ"
Content-Disposition: inline
In-Reply-To: <20170926102936.1a099080@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: move registration of "host" CPU
 core type to machine code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>


--vEfizQhTV1P/vojJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2017 at 10:29:36AM +0200, Igor Mammedov wrote:
> On Tue, 26 Sep 2017 09:19:28 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Tue, 26 Sep 2017 12:57:39 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Mon, Sep 25, 2017 at 11:47:33AM +0200, Greg Kurz wrote: =20
> > > > The CPU core abstraction belongs to the machine code. This also gets
> > > > rid of some code duplication.
> > > >=20
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > >=20
> > > > hw/ppc/spapr_cpu_core.h is also included elsewhere in target/ppc/kv=
m.c
> > > > but this is already handled by the following cleanup patch:   =20
> > >=20
> > > I don't really see what the advantage of this is.  As others have
> > > pointed out it leads to the host type being registered very late,
> > > which could cause problems.
> > >  =20
> >=20
> > Well, the goal was to consolidate the code to register sPAPRCPUCore typ=
es in
> > the spapr code, instead of open-coding it in spapr_cpu_core.c and kvm.c=
=2E..=20
> >=20
> > But now I realize that delaying the registration even more is a bad ide=
a. And,
> > the other way round, registering a static type earlier as asked by Igor=
 would
> > require all parent types to be already registered, which seems to be im=
possible
> > to guarantee with the current code.
> so I'll leave this code as is for now as as it's a bit of topic
> wrt my work on cpu_model removal (or I'll try not to touch it until I hav=
e to)
>=20
> > Maybe we could at least have kvm_ppc_register_host_cpu_type() to call a
> > function in spapr_cpu_core.c instead of duplicating the registration co=
de ?
> Is it possible for other boards (non core based) to use host CPU?
>=20
> but for simplicity sake I'd lave it where it's now.
>=20
> BTW I have an additional question:
> what PPC boards are supposed to support KVM/host cpu?

In theory, any board, but your host has to have a cpu that's suitable
for the board in question.  So, if your host is a POWER8, you can use
-cpu host with a machine type which supports a POWER8 cpu; which is
basically just "pseries".  You couldn't use -cpu host with one of the
embedded board types, since they don't expect a POWER8 vCPU.

If you were on an e500 based host, you could use -cpu host with one of
the various e500 based machine types.  You couldn't use it with
"pseries", since that will only work with a POWER7/8/9 vCPU.

The issue is muddied by the fact that KVM HV (the fast KVM
implementation), a) will only work with a PAPR guest (i.e. pseries
machine type) and b) can't present a vCPU to the guest that differs
=66rom the host (this is a hardware limitation).  If these conditions
aren't met, the host kernel should automatically fall back to KVM PR
(or fail outright if it's not available).  Of course then it's further
muddied by the fact that KVM PR has _some_ ability to present a
different vCPU to the guest than is on the host, but it has some curly
limitations that we might or might not be able to detect in advance.

And, it's muddied even further by the fact that some of the CPU
"variants" are in fact identical cores - the differences are just in
peripherals, pin-level connections, cache etc. which the guest can't
see and doesn't care about.  Unfortunately, there aren't separate ways
for the CPU to advertise core version and other things, so even
trivial variants like this will have a different PVR value as a rule.

> (especially taking in account that aliases get patched to it as well,
> which I very much dislike since user asked for one CPU but got
> another

Uh.. what?  You should never get something different than what you
asked for.  The worst that can happen is if you request something
fuzzy, like "POWER8" instead of "POWER8E_v2.0" then exactly which
thing in that family you get depends on the host.

> and when the same happens on another host migration probably would be
> screwed up)

So, we can migrate between different CPUs if they're similar enough
(say, everything within the POWER8 family).  The guest is able to see
the change in the PVR, but it will be fine in practice.

This is really ugly, but unfortunately there's no away around it in
the hardware, it's simply not possible to virtualize the PVR to
present a different CPU variant to the guest (well, short of putting
the entire guest into user mode, which is what KVM PR does).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vEfizQhTV1P/vojJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnLR4QACgkQbDjKyiDZ
s5K9+BAAw4Wet99Vf3Aic4OE5aKqmLtGV0TNDzgKis7ZyyocgbjV0ndmeXbE4kX6
nOn8KxdAibx1EWNLFaBBMJL1EtCIGpcGRHPEeYV6cUL4unz/kxMUIYDsSmpluMwU
IvRxogG1ldhMoREVxXcitlcGZxr7WC13I3R5VwTNeNsUfA85zCDXWH4dTzjCR5hV
hlDWX/sqU0pm3c01hN6WOqHDnVVQIZaYFP/wmTKc2VpU+PXhcalcNAZ3g02KIf/P
8BnDRMziOvLIr5gftijxsOn7r9dBMBKIK+8rZEf4J6n2puAnQV3bM779eXEr00rK
Bnv7FZa/+z52JXSDMtwae97ip+492mPMIwoRaIPF3yelJBB6pQYT4FEM/++ImdFt
uH6kb534+SfZc1gfGnm8ovFUq/zI1K3Y6OWOLBksrqPIgzM6qAJc6ptVBPRmrNgL
UReF9LX0NvPRTQK1LxYKTidvm4CtBB6XwB9Qv5yP8weXCi25PmXiyPB4MeNkl+eo
HtmHCyF566kRTJjk2nhwcBEJoKzgi9VgZFyJFjNJrYG8UCe78SjF+5NfV20JjHH0
gutfPynE9gDIIQmtNABZF9Xgh+tMtqkaS7/U4DRLm4Vmw7JUmWVoMUd3I47J9mtE
QRwwTFVqV7CHijTAHnoQp4COP+M/uucWWq94y63uh2QzlsCEPE0=
=MiuQ
-----END PGP SIGNATURE-----

--vEfizQhTV1P/vojJ--
