Received: from eggs.gnu.org ([2001:4830:134:3::10]:42328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEBG-0004Zw-DZ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEBC-0008Jw-Qi
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:44:02 -0500
Date: Thu, 29 Nov 2018 14:33:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181129033318.GA14697@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-23-clg@kaod.org>
	<20181128055221.GE2251@umbus.fritz.box>
	<c41e5f96-c1f4-6baf-d069-c598b6ca3b03@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <c41e5f96-c1f4-6baf-d069-c598b6ca3b03@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 22/36] spapr/xive: add models for KVM
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 11:45:46PM +0100, C=E9dric Le Goater wrote:
> On 11/28/18 6:52 AM, David Gibson wrote:
> > On Fri, Nov 16, 2018 at 11:57:15AM +0100, C=E9dric Le Goater wrote:
> >> This introduces a set of XIVE models specific to KVM which derive from
> >> the XIVE base models. The interfaces with KVM are a new capability and
> >> a new KVM device for the XIVE native exploitation interrupt mode.
> >>
> >> They handle the initialization of the TIMA and the source ESB memory
> >> regions which have a different type under KVM. These are 'ram device'
> >> memory mappings, similarly to VFIO, exposed to the guest and the
> >> associated VMAs on the host are populated dynamically with the
> >> appropriate pages using a fault handler.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > The logic here looks fine, but I think it would be better to activate
> > it with explicit if (kvm) type logic rather than using a subclass.
>=20
> ok. ARM has taken a different path, the one proposed below, but it should=
=20
> be possible to use a "if (kvm)" type logic. There should be less noise=20
> in the object design.

Yeah, it seemed like a good path when I wrote the XICS code, but
experience with that has led me to decide it wasn't a good idea.  I'm
not sure if the ARM people copied that or came up with it on their
own.

[snip]
> >> +/*
> >> + * XIVE Thread Interrupt Management context (KVM)
> >> + */
> >> +
> >> +static void xive_tctx_kvm_init(XiveTCTX *tctx, Error **errp)
> >> +{
> >> +    sPAPRXive *xive;
> >> +    unsigned long vcpu_id;
> >> +    int ret;
> >> +
> >> +    /* Check if CPU was hot unplugged and replugged. */
> >> +    if (kvm_cpu_is_enabled(tctx->cs)) {
> >> +        return;
> >> +    }
> >> +
> >> +    vcpu_id =3D kvm_arch_vcpu_id(tctx->cs);
> >> +    xive =3D SPAPR_XIVE_KVM(tctx->xrtr);
> >=20
> > Is this the first use of tctx->xrtr?
>=20
> No, the second. the first is the reset_tctx() ops doing the CAM reset.
> But we said that we could remove it.

And I think we can remove it here too.  We know this is PAPR specific
so we can go qdev_get_machine() -> PAPR xive object.

I normally don't like using qdev_get_machine(), but I think it's a
little less ugly than including this backlink (and it is sometimes
necessary to deal with the different abstraction boundaries between
qemu and KVM).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv/XfwACgkQbDjKyiDZ
s5KDqQ//e4iK6/tnncM7L+UslMeyz4SxjsJzudf0bbVSf2AaBQA80RDBf1CkBLDv
EDvIVvQZIXKAEhpmEL3Ihb8E/Sv+z3b9D1wdTLiT6YeRBJ6PJhC8hOzunmuLwmXZ
QJu6vmgjcDyJiOErq1k4Hz5c2KucZCcTEpGhrP+VMechOB0iz9MLpZ79z9kez9VN
Sb+/mn5r5Q9fVMvSyaSF1mc7/ukD5va7vNdJhw2BT7jDE9D1ShBTJRhX9YCkU+gj
Hz/u16OL39MstmbX+7HkCl3cqAX1G4SJJnuFbMA1b280WC6TUstetaeXxROktDKP
TfAuAlDkl8Si35Sjp55ZGYhSnO2GLmLV3eULwHGYsoqMUBSIvu57zip1FOnWf6hh
EDM6qQfabOYtqkzJXe/kWjp2hthnADbo8fZiNDukSeDe6sk3L2R/fhiaDBnaQAst
suYK0miO5hDKa04Vlxm2XoKgIjjyIe+QabtmXGQXnwAo7wn3K385QTjRKDDkqH12
DIlZiQFv+l4/H7sruXHcRAwBlTazUnyVuGxmQrG6WENHwIY73jqx7HY5RaAEb7ok
o0tFvkvXpF8ZPxb8AlaV96RBO4WEiSIHpzMwwWBukkz9eNTLG0NAyA/3C5P13UkU
0T9GnzWxkevhxF8OJVNUHkV5rrhSP+6oOAq50RqhlazadV1Ngl8=
=R/Wo
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
