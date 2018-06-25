Received: from eggs.gnu.org ([2001:4830:134:3::10]:60511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXLAW-0006zN-7x
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 02:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXLAU-0006Ig-UH
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 02:40:08 -0400
Date: Mon, 25 Jun 2018 16:36:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180625063651.GE22971@umbus.fritz.box>
References: <20180615152536.30093-1-clg@kaod.org>
	<20180615152536.30093-4-clg@kaod.org>
	<20180618103844.GX25461@umbus.fritz.box>
	<9d1ce421-9caa-08eb-2417-15307dd271ed@kaod.org>
	<20180618121328.GY25461@umbus.fritz.box>
	<048d2369-389f-1118-03b0-b81e6bd565a0@kaod.org>
	<20180620005622.GG3546@umbus.fritz.box>
	<36801260-2573-ce87-7f10-a6c76072ad23@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Content-Disposition: inline
In-Reply-To: <36801260-2573-ce87-7f10-a6c76072ad23@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] ppc/pnv: introduce Pnv8Chip and
 Pnv9Chip models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2018 at 07:29:37AM +0200, C=E9dric Le Goater wrote:
> On 06/20/2018 02:56 AM, David Gibson wrote:
> > On Tue, Jun 19, 2018 at 07:24:44AM +0200, C=E9dric Le Goater wrote:
> >>
> >>>>>  typedef struct PnvChipClass {
> >>>>>      /*< private >*/
> >>>>> @@ -75,6 +95,7 @@ typedef struct PnvChipClass {
> >>>>> =20
> >>>>>      hwaddr       xscom_base;
> >>>>> =20
> >>>>> +    void (*realize)(PnvChip *chip, Error **errp);
> >>>>
> >>>> This looks the wrong way round from how things are usually done.
> >>>> Rather than having the base class realize() call the subclass specif=
ic
> >>>> realize hook, it's more usual for the subclass to set the
> >>>> dc->realize() and have it call a k->parent_realize() to call up the
> >>>> chain.  grep for device_class_set_parent_realize() for some more
> >>>> examples.
> >>>
> >>> Ah. That is more to my liking. There are a couple of models following
> >>> the wrong object pattern, xics, vio. I will check them.
> >>
> >> So XICS is causing some head-aches because the ics-kvm model inherits
> >> from ics-simple which inherits from ics-base. so we have a grand-parent
> >> class to handle.
> >=20
> > Ok.  I mean, we should probably switch ics around to use the
> > parent_realize model, rather than the backwards one it does now.  But
> > it's not immediately obvious to me why having a grandparent class
> > breaks things.
>=20
> If you follow the common realize pattern, you end up with a recursive=20
> loop with one of the realize routine. I didn't dig much the issue.

Hmm.

> >> if we could affiliate ics-kvm directly to ics-base it would make the=
=20
> >> family affair easier. we need to check migration though.
> >=20
> > But that said, I've been thinking for a while that it might make sense
> > to fold ics-kvm into ics-base.  It seems very risky to have two
> > different object classes that are supposed to have guest-identical
> > behaviour.  Certainly adding any migratable state to one not the other
> > would be horribly wrong.
>=20
> yes. clearly. something like bellow would be better:
>=20
>                    +---------------+
>                    |     ICS       |
>          +---------+  common/base  +--------+
>          |         +---------------+        |
>          |                                  |
>          | spapr                    spapr   |
>          |  pnv                             |
>   +------v--------+                +--------v--------+
>   |     ICS       |                |       ICS       |
>   |  simple/QEMU  |                |       KVM       |
>   +---------------+                +-----------------+
>=20
> with only some reset and realize handling in the subclasses. The only
> extra field we could add under the KVM class is the KVM XICS device fd. =
=20

I think that would be an improvement over what we have, yes.  However,
it's not what I actually had in mind.  In fact I was planning on
getting rid of the KVM specific subclass entirely and merging it into
the base/simple classes with explicit if (kvm) logic.

The reason is that having different object classes for devices based
on accelerator is unusual and kind of dangerous.  We get away with it
because we don't have any migration information that gets tied to the
object class name - but that's a pretty non-obvious restriction that
would be easy to break in future.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlswjYIACgkQbDjKyiDZ
s5JRVhAA1nRSQO6528Q0Cxl6+RYpLSu3QQQZ6IfhQYrLcKC5NxfLeNLUlyrFAXe+
21zOdHbij/P/+eXLLvGyhjA04/XvF3VaWu/V7LrSnBjHlY5jP27cmWOHLMCz/gQz
fB9sBBI7aTkV/xUY9K9igjELy0yH1Fxh1uQlxTRFwhXuuYt+NrwuDMCofBZC00se
WWtsjjHfjeQf68mXkh9/z5CeRd8WbWA6p/Xl/IBnRgr7Q6v/3JSIYagrKkIdWdxZ
fwDSqPuwd4mWK/r14cJwoyl1IkVEfl/6R2i8r6tnMchftSljecrRLz6xkzrAL6TQ
6cqS0C1R1qMfetLGa6pO2WHlt9KbZ+akp1TrL8g85oAIGB3AYJPY2pCt2jvuosnx
2HgQ+zM4xIWtWgMhRoOBMfD4C+/CT6E2vfUBjN7aM1Gi/B/3N2DR4GSF9lIaAHv5
c2c2QbmJDdAkrH2Xtji3090PUrP9uUHbqsapHOXEqkm75tAtu4BCSVlv/ats8N90
KPNWEfmcUJjnXrQkLMv7VmlbHGpDzaT1ra6Kus8UQeINHAK6KcjQyJ14JkGXR2ou
SUtZw7V/sTNd91pq1auLjU1LHlKrbCvhLrkOePCY2bLTZDUqyEYrF+NY4BgqCFd3
jB4zI3+bq4TnprMMi8aQfS6Jtdl4AYNMrs2oqPVGYcMLypqN2Pw=
=w4Vs
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--
