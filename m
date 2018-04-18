Received: from eggs.gnu.org ([2001:4830:134:3::10]:51049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f8nKq-0000jV-Fm
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f8nKk-0004iS-88
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:41:20 -0400
Date: Wed, 18 Apr 2018 15:40:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180418134056.GE4971@localhost.localdomain>
References: <20180405170619.20480-1-kwolf@redhat.com>
	<20180406080406.GA4850@localhost.localdomain>
	<25584b6b-b822-f4f8-2e94-47cf288f2b94@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <25584b6b-b822-f4f8-2e94-47cf288f2b94@redhat.com>
Subject: Re: [Qemu-devel] [RFC][BROKEN] rbd: Allow configuration of
 authentication scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jdurgin@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 18.04.2018 um 15:21 hat Eric Blake geschrieben:
> On 04/06/2018 03:04 AM, Kevin Wolf wrote:
> > Am 05.04.2018 um 19:06 hat Kevin Wolf geschrieben:
> >> The legacy command line syntax supports a "password-secret" option that
> >> allows to pass an authentication key to Ceph. This was not supported in
> >> QMP so far.
> >>
> >> This patch introduces authentication options in the QAPI schema, makes
> >> them do the corresponding rados_conf_set() calls and adds compatibility
> >> code that translates the old "password-secret" option both for opening
> >> and creating images to the new set of options.
> >>
> >> Note that the old option didn't allow to explicitly specify the set of
> >> allowed authentication schemes. The compatibility code assumes that if
> >> "password-secret" is given, only the cephx scheme is allowed. If it's
> >> missing, both none and cephx are allowed because the configuration file
> >> could still provide a key.
> >=20
> > There is another problem here that suggests that maybe this is not the
> > right QAPI schema after all: The defaults needed for command line
> > compatibility and those promised in the QAPI schema are conflicting.
> >=20
> > The required command line behaviour is as described above:
> >=20
> > * password-secret given: only cephx
> > * no options given: cephx, none
> >=20
> > The desired QMP default behaviour is:
> >=20
> > * auth-cephx given: allow cephx
> > * auth-none given: allow none
> > * both given: allow both
> > * no options given: error
> >=20
> > In .bdrv_open() there is no way to distinguish the "no options given" of
> > the command line from that of QMP. The current implementation allows
> > everything if no options are given, i.e. it keeps existing command lines
> > working, but it doesn't correctly implement the behaviour described in
> > the QAPI schema.
>=20
> Can we use a QAPI alternate with an explicit JSON null for the command
> line 'no options given' case?

The fundamental problem is that we can only have a single default value
for both command line and QMP. I don't think an alternate would change
anything there.

Both the commands line and the QMP 'no options given' cases would end up
being represented by a missing key in the options QDict. null would only
be used if explicitly given in blockdev-add (I don't think you can
specify null on the command line at all).

> >=20
> > I don't think changing the description of the QAPI schema would be a
> > good idea, it would be a rather surprising interface.
> >=20
> >> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >> ---
> >>
> >> This doesn't actually work correctly yet because the way that options
> >> are passed through the block layer (QAPI -> QemuOpts -> QDict). Before
> >> we fix or hack around this, let's make sure this is the schema that we
> >> want.
>=20
> Can we skip the intermediate QemuOpts?  If we can go straight from
> command line to QDict using just QAPI, won't that give us what we really
> need?

In fact, I think that's what -blockdev already does. The one that I had
in mind is -drive, which adds the additional QemuOpts step, but we don't
have to support -drive with a new syntax.

However, the problem is with the representation in the QDict, so
skipping QemuOpts doesn't help.

> >>
> >> The two known problems are:
> >>
> >> 1. QDict *options in qemu_rbd_open() may contain options either in the=
ir
> >>    proper QObject types (if passed from blockdev-add) or as strings
> >>    (-drive). Both forms can be mixed in the same options QDict.
> >>
> >>    rbd uses the keyval visitor to convert the options into a QAPI
> >>    object. This means that it requires all options to be strings. This
> >>    patch, however, introduces a bool property, so the visitor breaks
> >>    when it gets its input from blockdev-add.
> >>
> >>    Options to hack around the problem:
> >>
> >>    a. Do an extra conversion step or two and go through QemuOpts like
> >>       some other block drivers. When I offered something like this to
> >>       Markus a while ago in a similar case, he rejected the idea.
> >>
> >>    b. Introduce a qdict_stringify_entries() that just does what its na=
me
> >>       says. It would be called before the running keyval visitor so th=
at
> >>       only strings will be present in the QDict.
> >>
> >>    c. Do a local one-off hack that checks if the entry with the key
> >>       "auth-none" is a QBool, and if so, overwrite it with a string. T=
he
> >>       problem will reappear with the next non-string option.
> >>
> >>    (d. Get rid of the QDict detour and work only with QAPI objects
> >>        everywhere. Support rbd authentication only in QEMU 4.0.)
>=20
> Oh, even one step further than just avoiding QemuOpts, but using REAL
> types everywhere in the block layer!  It might be a nice cleanup, but it
> would probably take a lot of effort in the meantime to get to that point?

Yes, I would like to get there, but it's definitely a long term goal
(that's why I wrote "QEMU 4.0"). It definitely means getting rid of any
options that work on the command line, but are not part of the QAPI
schema (including "internal" options that are only supposed to be added
by .bdrv_parse_filename implementations). And even then, it's probably
far from trivial.

Realistically, only a/b/c are the options we have for 2.13. Or maybe
another option that I'm missing.

> >>
> >> 2. The proposed schema allows 'auth-cephx': {} as a valid option with
> >>    the meaning that the cephx authentication scheme is enabled, but no
> >>    key is given (e.g. it is taken from the config file).
> >>
> >>    However, an empty dict cannot currently be represented by flattened
> >>    QDicts. We need to find a way to enable this. I think this will be
> >>    externally visible because it directly translates into the dotted
> >>    syntax of -blockdev, so we may want to be careful.
>=20
> Can we just require users to give -blockdev with the JSON format (rather
> than dotted format) when they need to use that particular feature on the
> command line?

Yes, requiring -blockdev with the JSON format would be fine. But the
next thing we do with the resulting QDict is flattening it, which loses
empty dicts.

Kevin

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa10roAAoJEH8JsnLIjy/WmrEP/2zAzC+zGlzWV7nbrr1MaCOY
gOeOLc2Nu64jKOKWGlmL4+ZGhCq+XCEm4zHVu0Ob2CrErzYzdHedp6JHGIQiEV9F
FvQ1zu11dZtCxeLydN2qKvBHOEP11nh5z6Snw5Iz8E1XXQA/v7l968K2rq7BN3hE
viqb21bAV3FJ3oxOBF0QDigZXXQVPkwycSqBC7o5WXCdx8yxXCUQG+FxZrmaQP4N
jMe0v80aIJe1hgHG3zigg/PIvCATvGTaK2G/3jKl8tWDe455F+zNvNa5rX1YoT0C
BEPKwuytBLLOxSpQkQRKBw6PuFmUAqzimKnhHXdcqrrF6vqoarK0mDCqU9vRvbMC
rdjLz/lsqB2JGqGyk4JGsesC9Fsdu2QfHDdRSYRw7LOBRwrP26bmZZmbX323O0B3
QvL3p3/KNHcyLpwqVGHs5Jo9Met36C80mB3XxQPQOF0tZ+7fmgFBxLYDdPLe+xrH
yN/vi4sC+6YLAACMeNNt8xFLnwP7/RxMOqGBJOTlhaNO7OfkE0wzMyuqMvkCUXy+
eduiT2vuuyQlIyPYSlXuyTtDnSXFEOywb6diUxezRAw4HUaqoGpoUZltVlVcBUdx
mjruS+fxr3qSUjprP9ItLnv4ZD6Ia73X4AKElWZREthmCM3DaGDDShafPDyNHoAi
IpobZidxuNGQ3Xs8DSYl
=IaZW
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
