Received: from eggs.gnu.org ([2001:4830:134:3::10]:52865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJzOc-0006PT-3U
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:19:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJzOb-000280-0C
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:19:46 -0500
Date: Tue, 6 Nov 2018 12:19:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181106111920.GA4758@linux.fritz.box>
References: <20181104180657.7471-1-lbloch@janustech.com>
	<20181104180657.7471-2-lbloch@janustech.com>
	<4b53c025-cee0-9f3d-428a-375698a9ac7e@redhat.com>
	<1ac3ce83-a12c-afd7-9015-01a99589ca7e@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1ac3ce83-a12c-afd7-9015-01a99589ca7e@janustech.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Add a comment to explain
 the origin of sizes' lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>

Am 06.11.2018 um 09:56 hat Leonid Bloch geschrieben:
> Hi Phil, Hi Eric,
>=20
> (Eric, for some reason you weren't CC'd to this thread - sorry.)
>=20
> On 11/5/18 5:58 PM, Philippe Mathieu-Daud=E9 wrote:
> > Hi Leonid,
> >=20
> > On 4/11/18 19:07, Leonid Bloch wrote:
> >> The lookup table for power-of-two sizes was added in commit 540b8492=
618eb
> >> for the purpose of having convenient shortcuts for these sizes in ca=
ses
> >> when the literal number has to be present at compile time, and
> >> expressions as '(1 * KiB)' can not be used. One such case is the
> >> stringification of sizes. Beyond that, it is convenient to use these
> >> shortcuts for all power-of-two sizes, even if they don't have to be
> >> literal numbers.
> >>
> >> Despite its convenience, this table introduced 55 lines of "dumb" co=
de,
> >> the purpose and origin of which are obscure without reading the mess=
age
> >> of the commit which introduced it. This patch fixes that by adding a
> >> comment to the code itself with a brief explanation for the reasonin=
g
> >> behind this table. This comment includes the short AWK script that
> >> generated the table, so that anyone who's interested could make sure
> >> that the values in it are correct (otherwise these values look as if
> >> they were typed manually).
> >>
> >> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> >> ---
> >> =A0 include/qemu/units.h | 18 ++++++++++++++++++
> >> =A0 1 file changed, 18 insertions(+)
> >>
> >> diff --git a/include/qemu/units.h b/include/qemu/units.h
> >> index 68a7758650..1c959d182e 100644
> >> --- a/include/qemu/units.h
> >> +++ b/include/qemu/units.h
> >> @@ -17,6 +17,24 @@
> >> =A0 #define PiB=A0=A0=A0=A0 (INT64_C(1) << 50)
> >> =A0 #define EiB=A0=A0=A0=A0 (INT64_C(1) << 60)
> >> +/*
> >> + * The following lookup table is intended to be used when a literal=
=20
> >> string of
> >> + * the number of bytes is required (for example if it needs to be=20
> >> stringified).
> >> + * It can also be used for generic shortcuts of power-of-two sizes.
> >=20
> > ^ ok
> >=20
> > v this part is not useful in the tree IMHO.
> >=20
> >> + * This table is generated using the AWK script below:
> >> + *
> >> + *=A0 BEGIN {
> >> + *=A0=A0=A0=A0=A0 suffix=3D"KMGTPE";
> >> + *=A0=A0=A0=A0=A0 for(i=3D10; i<64; i++) {
> >> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0 val=3D2**i;
> >> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0 s=3Dsubstr(suffix, int(i/10), 1);
> >> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0 n=3D2**(i%10);
> >> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0 pad=3D21-int(log(n)/log(10));
> >> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf("#define S_%d%siB %*d\n", n, s=
, pad, val);
> >> + *=A0=A0=A0=A0=A0 }
> >> + *=A0 }
> >> + */
> >=20
> > If it is generated and the stringified are also generated, why not=20
> > generate this once via the ./configure, since it is used by machines =
and=20
> > not by humans?
>=20
> You beat me to it! I was just thinking about that last evening. Indeed=20
> it's not so elegant to put generated code in a file that is intended fo=
r=20
> human handling. Generating by ./configure would be prettier.

We can still do this on top (and probably only for 3.2 as we're in
freeze now and it's neither a bug fix nor a documentation improvement or
test).

> A runtime solution that interprets hard-coded expression strings, like=20
> Eric suggested, can also be a possibility, but it seems more complicate=
d=20
> than just generating these at the configuration stage. Plus one gets th=
e=20
> S_* constants that can be used in many places, not only where an=20
> explicit number is needed. What do you think?

I think this is not a good use of our time when we want to use QAPI in
the long run anyway.

> A question though: if it to be generated by ./configure, where do you=20
> suggest to put the generated values?

We already generate a lot of files, you could check where these end up.
But I suppose it might just be the root of the build directory (unless
an include/ exists there?)

> And also: is it OK to assume there's AWK (or another scripting
> language) on the system for generating these?

git grep says that configure already calls awk, so it's probably okay.
Of course, the existing test would just disable libgcrypt instead of
completely failing, so it's still a bit different.

As for other scripting languages, configure itself is written in shell,
and we also assume that Python is available (used e.g. by the QAPI
generators). At least these two are safe, too.

Kevin
