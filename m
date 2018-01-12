Received: from eggs.gnu.org ([2001:4830:134:3::10]:37451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZqlq-0001z4-Vk
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 23:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZqlp-0005Hf-J6
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 23:16:46 -0500
Date: Fri, 12 Jan 2018 14:46:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180112034619.GK24770@umbus.fritz.box>
References: <20180106004722.1152-1-joserz@linux.vnet.ibm.com>
	<20180106004722.1152-2-joserz@linux.vnet.ibm.com>
	<20180111141622.GI24770@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ppIqr1kl39GnwQx"
Content-Disposition: inline
In-Reply-To: <20180111141622.GI24770@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH 1/1] spapr: Check SMT based on
 KVM_CAP_PPC_SMT_POSSIBLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--1ppIqr1kl39GnwQx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2018 at 01:16:22AM +1100, David Gibson wrote:
> On Fri, Jan 05, 2018 at 10:47:22PM -0200, Jose Ricardo Ziviani wrote:
> > Power9 supports 4 HW threads/core but it's possible to emulate
> > doorbells to implement virtual SMT. KVM has the KVM_CAP_PPC_SMT_POSSIBLE
> > which returns a bitmap with all SMT modes supported by the host.
> >=20
> > Today, QEMU forces the SMT mode based on PVR compat table, this is
> > silently done in spapr_fixup_cpu_dt. Then, if user passes thread=3D8 the
> > guest will end up with 4 threads/core without any feedback to the user.
> > It is confusing and will crash QEMU if a cpu is hotplugged in that
> > guest.
> >=20
> > This patch makes use of KVM_CAP_PPC_SMT_POSSIBLE to check if the host
> > supports the SMT mode so it allows Power9 guests to have 8 threads/core
> > if desired.
> >=20
> > Reported-by: Satheesh Rajendran <satheera@in.ibm.com>
> > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > ---
> >  hw/ppc/spapr.c       | 14 +++++++++++++-
> >  hw/ppc/trace-events  |  1 +
> >  target/ppc/kvm.c     |  5 +++++
> >  target/ppc/kvm_ppc.h |  6 ++++++
> >  4 files changed, 25 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index d1acfe8858..ea2503cd2f 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -345,7 +345,19 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMach=
ineState *spapr)
> >          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >          DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
> >          int index =3D spapr_vcpu_id(cpu);
> > -        int compat_smt =3D MIN(smp_threads, ppc_compat_max_threads(cpu=
));
> > +
> > +        /* set smt to maximum for this current pvr if the number
> > +         * passed is higher than defined by PVR compat mode AND
> > +         * if KVM cannot emulate it.*/
> > +        int compat_smt =3D smp_threads;
> > +        if ((kvmppc_cap_smt_possible() & smp_threads) !=3D smp_threads=
 &&
> > +                smp_threads > ppc_compat_max_threads(cpu)) {
> > +            compat_smt =3D ppc_compat_max_threads(cpu);
>=20
> I don't think this is the right approach.  We've been trying to remove
> places where host properties (such as those read from KVM
> capabilities) affect guest visible properties of the VM - like vsmt.
> Places like that break migration and often libvirt expectations as
> well.
>=20
> This is putting one back in, and so a step in the wrong direction.

Following on from this with some more investigation.

I think the discussion is going off the rails because the reason for
this compat threads limit has been forgotten.

*It has nothing to do with the host*.  It's been recoded a bunch, but
the logic was originally introduced by 2a48d993 "spapr: Limit threads
per core according to current compatibility mode".  It states that it
was to avoid confusing the *guest* by presenting more threads than it
expects on an compatible-with-old CPU.

This also explains why it's done in this otherwise weird way - just
truncating the presented threads in the device tree, while the other
threads still "exist" in the qemu and KVM model:

It's because this happens at CAS time, for the benefit of guests which
don't understand newer CPUs, at which point it's really too late to
report an error to the user or renumber the CPUs.

So I think what we actually want to do here is just *remove* the
compat limit for POWER9 cpus.  Strictly it's to do with the host
kernel rather than the cpu, but in practice we can count on POWER9
guests not being confused by >4 threads (since they POWER8 compat
guests running on POWER9 have to anyway).


As a separate matter, we need to validate guest threads-per-core
against what the host's capable of, but that doesn't belong here.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1ppIqr1kl39GnwQx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpYL4kACgkQbDjKyiDZ
s5KXHxAA34TQMIOi29K1MjkkjdjgWRNFu7oEig2zkSe6v1XgEKZhFpww+Wo/vxsh
D84NMLXqkAin2fopFiFdeZV1aV7WI4D9U2sBDmnos2W1/p9WYBsdBpXh+ybld4nw
1N8DVAMMiRtAysw2n8nAjIwAr1HQG8JNQupxH+Ajp+8fVVW5XUQwqPWOKNHBvnKU
42dyHpS5sq/3kG7wv+Xm5WWXuZcM+m6u1VWGVGXOqgzPhZhAqy5PtF4JMgTohOQM
RTtwNFy4EH2yOiPjQ+EVDKMTAv1mw26IV8S9w1yfmVfu0fYgVafD+L4E5JhRQqIJ
PvVMC6B8B/E6LWM8ziFG7NyCKBKer3omyt+w6WahRVDPlPPjeGnPTsl5nRQH1vAC
ncq5zV7wHeajz0Czd95PVafk1aBfJ9lLqlPKxtX+IUW6WCuf+qhkBwYSJPIzilhb
Jay+vihXRLryQIlQfE4XMyt2NfAa0AUquviiNkIctHbNdHb+nAaFpodyaNQMowsw
EakQC1W/ZOGlgwxTxLXyYA0Hgeq7dh8blV8RwlWEnv2naFij6MupH1awUjC+KPz2
EJ6ZIzF64m2vUYRc2UaDedIUmsc8bzlomKsJ1QH9utgF8afOwGZfIMMuRrgUZcGS
jK6gPIcruLEjfQDIwVxb8sYvtx1huKBBa78tDG8QSmGQjA6KRSQ=
=pITa
-----END PGP SIGNATURE-----

--1ppIqr1kl39GnwQx--
