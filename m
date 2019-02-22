Received: from eggs.gnu.org ([209.51.188.92]:56337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gxCur-0007vK-B2
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gxCuq-0005UP-GS
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:39:09 -0500
Date: Fri, 22 Feb 2019 16:38:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190222153853.GC8035@dhcp-200-176.str.redhat.com>
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-9-kwolf@redhat.com>
	<67996e1d-1d6f-2990-3b96-22554f261029@redhat.com>
	<20190219085141.GC4727@localhost.localdomain>
	<1a598bde-1921-3253-ff83-967927e45669@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <1a598bde-1921-3253-ff83-967927e45669@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 08/11] qcow2: Add basic data-file
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, qemu-devel@nongnu.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.02.2019 um 15:12 hat Max Reitz geschrieben:
> On 19.02.19 09:51, Kevin Wolf wrote:
> > Am 19.02.2019 um 00:57 hat Max Reitz geschrieben:
> >> On 31.01.19 18:55, Kevin Wolf wrote:
> >>> This adds a .bdrv_open option to specify the external data file node.
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>> ---
> >>>  qapi/block-core.json |  3 ++-
> >>>  block/qcow2.h        |  4 +++-
> >>>  block/qcow2.c        | 25 +++++++++++++++++++++++--
> >>>  3 files changed, 28 insertions(+), 4 deletions(-)
> >>
> >> [...]
> >>
> >>> diff --git a/block/qcow2.h b/block/qcow2.h
> >>> index c161970882..e2114900b4 100644
> >>> --- a/block/qcow2.h
> >>> +++ b/block/qcow2.h
> >>
> >> [...]
> >>
> >>> @@ -205,7 +206,8 @@ enum {
> >>>      QCOW2_INCOMPAT_DATA_FILE        =3D 1 << QCOW2_INCOMPAT_DATA_FIL=
E_BITNR,
> >>> =20
> >>>      QCOW2_INCOMPAT_MASK          =3D QCOW2_INCOMPAT_DIRTY
> >>> -                                 | QCOW2_INCOMPAT_CORRUPT,
> >>> +                                 | QCOW2_INCOMPAT_CORRUPT
> >>> +                                 | QCOW2_INCOMPAT_DATA_FILE,
> >>
> >> This hunk seems to belong somewhere else.
> >=20
> > Isn't this the first patch that actually allows opening images that have
> > QCOW2_INCOMPAT_DATA_FILE set in their header?
>=20
> Oh, sorry.  I thought the mask was the mask of all incompatible
> features, but it's actually the mask of supported incompatible features.
>  Yep, then it's correct here.
>=20
> >>>  };
> >>> =20
> >>>  /* Compatible feature bits */
> >>> diff --git a/block/qcow2.c b/block/qcow2.c
> >>> index ac9934b3ed..376232d3f0 100644
> >>> --- a/block/qcow2.c
> >>> +++ b/block/qcow2.c
> >>> @@ -1441,8 +1441,22 @@ static int coroutine_fn qcow2_do_open(BlockDri=
verState *bs, QDict *options,
> >>>          goto fail;
> >>>      }
> >>> =20
> >>> -    /* TODO Open external data file */
> >>> -    s->data_file =3D bs->file;
> >>> +    /* Open external data file */
> >>> +    if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
> >>> +        s->data_file =3D bdrv_open_child(NULL, options, "data-file",=
 bs,
> >>> +                                       &child_file, false, errp);
> >>> +        if (!s->data_file) {
> >>> +            ret =3D -EINVAL;
> >>> +            goto fail;
> >>> +        }
> >>> +    } else if (qdict_get(options, QCOW2_OPT_DATA_FILE)) {
> >>
> >> I get the idea, but this isn't crumpled so this key may not exist (but
> >> data-file.driver and data-file.filename may).  Of course the fact that
> >> these options remain unused will be caught by the block layer, but that
> >> makes the error message below a bit less useful.
> >=20
> > Hmm, good point... So you'd just leave out the check and always let the
> > block layer complain (with a less than helpful message)? Or are you
> > suggesting I should try and catch all cases somehow, even if that makes
> > things quite a bit more complicated?
>=20
> I don't mind either way.  Nice error messages are nice as long as
> they're not too much trouble.  It's just that this current state feels a
> bit half-baked.

I think catching everything is just not worth the effort. So I
considered dropping the check. But then I thought that this half baked
check will make sure that we'll get full coverage once qcow2 is
converted to a QAPI-based open interface instead of forgetting to bring
the check back. So I'm leaning towards just leaving it as it is now. If
you like, I can add a comment that we know this is half baked.

Kevin

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJccBeNAAoJEH8JsnLIjy/WzH4P/RH1OI2+HJ4HX1aiR4EQaHWI
/sCye5xhXIXCKFnUmWBN1PxEYUUzyxtqdNrXmptxf1hmwNj9QaE66jx9iYaC8Oxh
ll9SHDt2B0WMZJlpPnYXWMQ4XM5oGb+4R6dp3mEDqzAOSbARxtlny3+L/ogYHhHg
FTMGJ7rHeKl0tSf0loALETYkYRd/+xKOsjaud8RMoTdndzceMDN6YcVy1CbV79mH
S321bvfErXSLXQT4oMinzFQmTUlwzx9y44yG5qEzT/FmyCfAuYXNepgfEzccLDkI
H0NqxSsK7uwc9/txPcT5HWgu+XZ+Loj44i1RmARFR3lDXTJY+B/XKWMM2eFgT6WO
A5J+1WAJiWBl2kQUL6Ov2O70XvVJFO1hFtgtqVT03mYhz70Ly1Fb+zJTvRoXYewT
2R3bjzy3V5faHOT83GjtbB5rQ+wdtOtqoUfEhjJq5fTHB+1bIrvip4L0fCA2n3ve
bzMb19QWKUCRQbsF+jgbv0+XEguvmRp0u8M4VzzbIA8r6pXZc+0P2g+mWjjDPvro
vIaxiSUtg6+EqtN6rghTjU2jYRTzgR0MXFnKDK/WmpddPQy8yWC5YNclpa3kQYjB
XpY+B7/M+zNKQJ/NzTwn28f2zFUNSAqozW46TY01Jw7yxgPqD7lxfLbh8CNdi1u8
OxILY7lgpo6Tjp8bqey0
=pUxc
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
