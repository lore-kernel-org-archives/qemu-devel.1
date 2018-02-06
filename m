Received: from eggs.gnu.org ([2001:4830:134:3::10]:53288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christoffer.dall@linaro.org>) id 1eizDW-000456-7X
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christoffer.dall@linaro.org>) id 1eizDT-0006mB-2L
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:07:06 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <christoffer.dall@linaro.org>)
	id 1eizDS-0006lE-Lj
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:07:02 -0500
Received: by mail-wm0-x241.google.com with SMTP id j21-v6so16880290wmh.1
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 01:07:02 -0800 (PST)
Date: Tue, 6 Feb 2018 10:06:59 +0100
From: Christoffer Dall <christoffer.dall@linaro.org>
Message-ID: <20180206090659.GX21802@cbox>
References: <20180201205307.30343-1-christoffer.dall@linaro.org>
	<431ec46d-33dd-71d8-9ea1-f331ba01bd62@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <431ec46d-33dd-71d8-9ea1-f331ba01bd62@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] target/arm/kvm: gic: Prevent creating
 userspace GICv3 with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alex Bennee <alex.bennee@linaro.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Mon, Feb 05, 2018 at 09:10:48PM -0300, Philippe Mathieu-Daud=E9 wrote:
>=20
> On 02/01/2018 05:53 PM, Christoffer Dall wrote:
> > KVM doesn't support emulating a GICv3 in userspace, only GICv2.  We
> > currently attempt this anyway, and as a result a KVM guest doesn't
> > receive interrupts and the user is left wondering why.  Report an error
> > to the user if this particular combination is requested.
> >=20
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> >  target/arm/kvm_arm.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> > index ff53e9fafb..cfb7e5af72 100644
> > --- a/target/arm/kvm_arm.h
> > +++ b/target/arm/kvm_arm.h
> > @@ -234,6 +234,10 @@ static inline const char *gicv3_class_name(void)
>=20
> Any reason why these functions are inlined in this include?

Not really sure what you mean?  What do you think would be a better
approach?

>=20
> Also - not related to your patch - while gicv3_class_name() is
> self-explicit, gic_class_name() isn't (to me at least).

I think I tend to see 'gic' as GICv2 and 'gicv3' as GICv3 in QEMU, but I
don't remember the details of how you make the GIC be a proper GICv2 vs.
the 11mpcore version thingy.

>=20
> There are many check for gic_version 1/2/3 in virt.c, which we could
> clean using more generic functions such gic_class_name(int gic_version)
> and Co.

Possibly.  Do note, that checking "which version of the GIC does this
board contain" is a separate thing from "which particular mechanism do I
use to emulate the GIC".

>=20
> >          exit(1);
> >  #endif
> >      } else {
> > +        if (kvm_enabled()) {
> > +            error_report("Userspace GICv3 is not supported with KVM");
> > +            exit(1);
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> > +        }
> >          return "arm-gicv3";
> >      }
> >  }
> >=20
>=20
Thanks!
-Christoffer

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJaeXAzAAoJEEtpOizt6ddyq0gH/iiQZmmd7EZWOobAFvVEG5vc
xnfi3tR8T1ca1aijpFDTAPS7J6EgO5MHkFIdAguw69cajns+C1/SUwEItcWXH1ZT
LHCKkAmbNHY6zC7sSLc1SS7JPZYcrX+9+7pWiRx7El4o6tP5R7POwi06QxIwXm8+
z0aDeq2PkM6WMHJ+4gjKzw6Wr09rc6Eig+IcUjdVflVBvLtL65Y+U7bUnDtoHSHB
6BpvP0nUq5Kv7SRFur7I8eqAW7Cjugr2hDiUrxjYnt3cyhk452KUlhsWGcuC6+tG
avjPU30hjMkDaQ2Mm2zXm6741rSHxZ8cD58JWgPV9jM/XM6V3GfdpQoJrQvcXOA=
=Xdht
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
