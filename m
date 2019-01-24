Received: from eggs.gnu.org ([209.51.188.92]:40928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gmeLJ-0005OU-PY
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:42:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gmeI8-000238-Sk
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:39:36 -0500
Date: Thu, 24 Jan 2019 13:39:20 +0100
From: Christophe Fergeau <cfergeau@redhat.com>
Message-ID: <20190124123920.GW30040@natto.ory.fergeau.eu>
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
	<4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
	<87o98sii5b.fsf@dusky.pond.sub.org>
	<87munqieiv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6ysXqiu0yoUmUNJB"
Content-Disposition: inline
In-Reply-To: <87munqieiv.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, "Richard W. M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>


--6ysXqiu0yoUmUNJB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Jan 24, 2019 at 10:35:52AM +0100, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
>=20
> > Eric Blake <eblake@redhat.com> writes:
> >
> >> On 1/2/19 12:01 PM, Christophe Fergeau wrote:
> >>> Adding Markus to cc: list, I forgot to do it when sending the patch.
> >>
> >> Also worth backporting via qemu-stable, now in cc.
> >>
> >>>=20
> >>> Christophe
> >>>=20
> >>> On Wed, Jan 02, 2019 at 03:05:35PM +0100, Christophe Fergeau wrote:
> >>>> commit 8bca4613 added support for %% in json strings when interpolat=
ing,
> >>>> but in doing so, this broke handling of % when not interpolating as =
the
> >>>> '%' is skipped in both cases.
> >>>> This commit ensures we only try to handle %% when interpolating.
> >
> > Impact?
> >
> > If you're unable to assess, could you give us at least a reproducer?
> >
> >>>> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
> >>>> ---
> >>>>  qobject/json-parser.c | 10 ++++++----
> >>>>  tests/check-qjson.c   |  5 +++++
> >>>>  2 files changed, 11 insertions(+), 4 deletions(-)
> >>>>
> >>
> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> >
> > Patch looks good to me, but I'd like us to improve the commit message.
>=20
> Let me try:
>=20
>     json: Fix % handling when not interpolating
>=20
>     Commit 8bca4613 added support for %% in json strings when interpolati=
ng,
>     but in doing so broke handling of % when not interpolating.
>=20
>     When parse_string() is fed a string token containing '%', it skips the
>     '%' regardless of ctxt->ap, i.e. even it's not interpolating.  If the
>     '%' is the string's last character, it fails an assertion.  Else, it
>     "merely" swallows the '%'.
>=20
>     Fix parse_string() to handle '%' specially only when interpolating.
>=20
>     To gauge the bug's impact, let's review non-interpolating users of th=
is
>     parser, i.e. code passing NULL context to json_message_parser_init():
>=20
>     * tests/check-qjson.c, tests/test-qobject-input-visitor.c,
>       tests/test-visitor-serialization.c
>=20
>       Plenty of tests, but we still failed to cover the buggy case.
>=20
>     * monitor.c: QMP input
>=20
>     * qga/main.c: QGA input
>=20
>     * qobject_from_json():
>=20
>       - qobject-input-visitor.c: JSON command line option arguments of
>         -display and -blockdev
>=20
>         Reproducer: -blockdev '{"%"}'
>=20
>       - block.c: JSON pseudo-filenames starting with "json:"
>=20
>         Reproducer: https://bugzilla.redhat.com/show_bug.cgi?id=3D1668244=
#c3
>=20
>       - block/rbd.c: JSON key pairs
>=20
>         Pseudo-filenames starting with "rbd:".
>=20
>     Command line, QMP and QGA input are trusted.
>=20
>     Filenames are trusted when they come from command line, QMP or HMP.
>     They are untrusted when they come from from image file headers.
>     Example: QCOW2 backing file name.  Note that this is *not* the securi=
ty
>     boundary between host and guest.  It's the boundary between host and =
an
>     image file from an untrusted source.
>=20
>     Neither failing an assertion nor skipping a character in a filename of
>     your choice looks exploitable.  Note that we don't support compiling
>     with NDEBUG.
>=20
>     Fixes: 8bca4613e6cddd948895b8db3def05950463495b
>     Cc: qemu-stable@nongnu.org
>=20
> Comments?

This looks good to me, thanks for the expanded log!

Christophe

--6ysXqiu0yoUmUNJB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlxJsfcACgkQqdjCFCms
bIJEqw/+J8cF525L97hspZ6U0qdBXmBGlrT2ViJcOt1kRN0qO1+b3NOkM/0BlP83
AGOvWlNpczlofIvlK4fxz7GKO3KrSAvOlgXUdRpISczfKvHHhjCxUSI4Iiv8W8cc
o3RdbIJ43M9DYKb+PgYbSSbuv7wyidutuPJAt+LkeYADmzORv7hZr/SGeVcnAckT
+mvi0lXmnr2YvPrHUa6leBidbRG75ZLrviKuWfiQPGpoWc6ZygX7NvBvBhxZJ0ww
pjVKocn9GtV+nDt/az0lnmWBKEBhZK/KvV1XDT+LSsSAKq6WHzUgIwAslifwl6tz
NmFzBN/2I5Qq1k/peu6//0Bhe4EXjpyxG/fwkIiT0VQq5nK5sWlBOqg+iHJhgjiW
INEl/5nCQLGNGT0EGBSzsiaSzcNrmzdI1RGF7Dilqb1Vdg8jgZc84/sqLuRDyJ4u
tmGP1EGGjGRaTs3/A0qdvYHRdCoJGu7R54+OESbJH1s4ZDx+HUiFOA2kJ9ZwpHRv
nxozrWVPs1JHZqkLnMRof1y+gMY7UesmShyHvksw1qu2BeKUTz01RxsSpASgWGbx
ozys25jaTooopb3MDCVGrGuWsRlSEc5Lf0UunnZB6V3rlOytIDaxKgHU7VGAZD+q
sHrw9EVMfkNveLtFVOlJ8H7vkD7CsyroK2P2OL77sA3ccAbRDNs=
=ttpU
-----END PGP SIGNATURE-----

--6ysXqiu0yoUmUNJB--
