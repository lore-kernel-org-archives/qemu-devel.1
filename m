Received: from eggs.gnu.org ([2001:4830:134:3::10]:41683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCNDs-0003WG-OK
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCNDk-00072p-V4
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:04:40 -0500
Date: Wed, 8 Nov 2017 11:04:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171108100417.GA30890@localhost.localdomain>
References: <20171107172638.29942-1-kwolf@redhat.com>
	<9306085c-07c4-b6f7-5222-2b73ee706dac@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <9306085c-07c4-b6f7-5222-2b73ee706dac@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Deprecate bdrv_set_read_only() and
 users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.11.2017 um 21:29 hat Eric Blake geschrieben:
> On 11/07/2017 11:26 AM, Kevin Wolf wrote:
> > bdrv_set_read_only() is used by some block drivers to override the
> > read-only option given by the user. This is not how read-only images
> > generally work in QEMU: Instead of second guessing what the user really
> > meant (which currently includes making an image read-only even if the
> > user didn't only use the default, but explicitly said read-only=3Doff),=
 we
> > should error out if we can't provide what the user requested.
> >=20
> > This adds deprecation warnings to all callers of bdrv_set_read_only() so
> > that the behaviour can be corrected after the usual deprecation period.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block.c       |  5 +++++
> >  block/bochs.c | 13 ++++++++++---
> >  block/cloop.c | 13 ++++++++++---
> >  block/dmg.c   | 12 +++++++++---
> >  block/rbd.c   | 14 ++++++++++----
> >  block/vvfat.c |  6 +++++-
> >  6 files changed, 49 insertions(+), 14 deletions(-)
>=20
> Dan pointed out the missing documentation, but for the code itself, the
> approach looks sane (especially since it was my attempt to make it worse
> by extending the idiom to NBD that triggered you to write this patch).
>=20
> Other documentation: In qapi/block-core.json, @BlockdevOptions, we
> probably ought to mention under @read-only that some block drivers
> require the use of an explicit read-only.

Well, they don't only need an explicitly set option, but the important
point is that they don't work with the default value. But I can add
something to this effect.

> > +++ b/block/vvfat.c
> > @@ -1259,7 +1259,11 @@ static int vvfat_open(BlockDriverState *bs, QDic=
t *options, int flags,
> >                         "Unable to set VVFAT to 'rw' when drive is read=
-only");
> >              goto fail;
> >          }
> > -    } else  {
> > +    } else  if (!bdrv_is_read_only(bs)) {
> > +        error_report("Opening non-rw vvfat images without an explicit "
> > +                     "read-only=3Don option is deprecated. Future vers=
ions "
> > +                     "will refuse to open the image instead of "
> > +                     "automatically marking the image read-only.");
> >          /* read only is the default for safety */
> >          ret =3D bdrv_set_read_only(bs, true, &local_err);
>=20
> Is this also a good time to deprecate vvfat's duplication of rw vs.
> read-only, and consolidate that into a single option?  No other device
> defaults to read-only, so the deprecation period is a good point to warn
> that a future version may default to read-write without an explicit
> read-only.  I guess vvfat is the only driver with a device-specific QAPI
> change (for 'rw') that might be impacted if you make that additional chan=
ge.

I would love to get rid of the duplication, but there's a reason why
vvfat defaults to read-only. I think we're relatively confident that a
read-only vvfat can be safely implemented (and hopefully is), but write
support is really a clever hack that may or may not work reliably
depending on how crazy the guest OS goes.

So if we removed the 'rw' option, would we want 'read-only' to default
to true for vvfat? I'm not sure if we want to go there, it would mean
making the default value of some base BlockdevOptions depend on the
driver.

On the other hand, I'm not sure how useful 'read-only' even is apart
=66rom the protocol layer... Should it have been driver-specific? But it's
too late for that anyway.

Kevin

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaAtahAAoJEH8JsnLIjy/WN6kQALU8COHZOgtI6ZZFAA8n4vw9
tqUvu3tnGvB03SC9K0X6RV+fVCOK0OomfTi5MyAVfd5VRVJ2b1HJASdeJkyidkOw
sI2fMOJAYlCuRhC2k67+om50ZNzIFeIOuxT+UIjKueq4RfkaC8yIbrc8zOKaAqhs
7KiROJV2/oTrdKK2FFFwPufnJBdw31wc7kAUpmtO9Yft4hu16nup1nQs5WU6d3wh
TjqhpEt75eGSOjeom+LvO1+ggh7ef9YwgkNcakeWhXkyjtmq3tLz2iihlZA01ckS
f3lqXne5RK6n2eAh1DRTr5QT72cTY0MKUQmzzH9R3Y1mlWQ00FAMjYuhWla4HM79
QjNRG11g3vlkVNbys8797Orx8WnTFnv/W2D8tD2Ho/sZQw4ppf+vCN5pxcjaBYVS
OupfUatfOKfaltrRXkrk4VKi71mAMcx6b0j/hKR/t++0a+wdwCi05inj47kiZNpp
KQu6pg7TTHNuD87kKmH3eg+SwLgjZsQHAGebdafaaMLm8vvojx4hoElqZ8TWWXWt
wWja7LTgIN8M21Leri3BU0LjE4wU3ntRIGEM3gEEqJEXZUXtzb3o7zNMONDS4E4q
4WmjYrbycx40j4K0g/3oEqoJ350F0xBSS5Wuoc+rYdAwJgEyrCp8CZdCt9Bks0OE
Eit0Tt5K48N+Gx7DViIP
=g4zU
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
