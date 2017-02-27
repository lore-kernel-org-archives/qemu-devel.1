Received: from eggs.gnu.org ([2001:4830:134:3::10]:60311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciM0R-0000TC-V0
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciM0Q-0000Xf-Vg
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:10:27 -0500
Date: Mon, 27 Feb 2017 15:10:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170227141017.GF6356@noname.redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-23-git-send-email-kwolf@redhat.com>
	<a6bf4bc1-c673-17fa-336d-f9d45686cba5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
In-Reply-To: <a6bf4bc1-c673-17fa-336d-f9d45686cba5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 22/54] block: Request real permissions in
 bdrv_attach_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.02.2017 um 15:31 hat Max Reitz geschrieben:
> On 21.02.2017 15:58, Kevin Wolf wrote:
> > Now that all block drivers with children tell us what permissions they
> > need from each of their children, bdrv_attach_child() can use this
> > information and make the right requirements while trying to attach new
> > children.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/block.c b/block.c
> > index 1c5f211..054e6f0 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -1659,10 +1659,14 @@ BdrvChild *bdrv_attach_child(BlockDriverState *=
parent_bs,
> >                               Error **errp)
> >  {
> >      BdrvChild *child;
> > +    uint64_t perm, shared_perm;
> > +
> > +    assert(parent_bs->drv);
> > +    parent_bs->drv->bdrv_child_perm(parent_bs, NULL, child_role,
> > +                                    0, BLK_PERM_ALL, &perm, &shared_pe=
rm);
>=20
> Another Second Thought=E2=84=A2: Why do we request no permissions for the=
 new
> child here? Seems weird to me. Shouldn't the caller specify the
> necessary permissions and what can be shared?

Actually not the caller, but we should calculate the cumulative
permissions of parent_bs, like in bdrv_update_perm().

Kevin

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYtDNJAAoJEH8JsnLIjy/WRlYP/RfFUcrOsbM0sn/sHv07oUuI
HHaN4u8vAM9io+Un+p5WkwDvM90FgdWaLBe9JnP8tJ9ocKb6Tqwo8NpuEeBf5qRG
ropFfWJ/lxFItt+tYVh69LfnOFKni6currhblkP+iZJj7++9LHZYZFZHj9iOm1EK
e9mzXyFYKavWAzeK+2f4GMkE+kOF6RUGLCf3gAh/0dlf8jyPm0xMHCO2PvgKWYGV
v4f5+ceIIUUxoN7y69G4r5qtPOR8SEdijFM+sJNNFLdRvlCMfxEywIxy5RjB/uSU
wVaFqhStnIyjKZ20Mcmfgq19PPm+DlVFplQXWu5Na1trvzTepS1utFIJ0Jmwr9Ha
zDzH6uEKZKghxboAIcGAHhGzdiksWHl/NQEoKAjx7lMimM4IdtL+FbzwuB6rqLKY
uwe7r/xZ6mMce0qvT1Y5U+EvogykDV8kL2P9LoCHDevirX8Ky6EXgmp8C8M0ZYAP
9QLFFD/9xTzInH29v/FAawQbFXDk4w4g7YHgs0D3lEj1wzw8R2YWcktKZnX65iL6
X1KK/NMDlJA3YHtrcQMM1zO1FjyLLWpqoC1vuGH5vLuQIGQD1Rx2IwDX46OS/+Gr
SWDVq3eXWEDmiXTyCjYE5OGZcZman32QG+8HoEEibbufOhOru8luwznDu0aSfOZg
f6tMlqtWkK0RmYQnKQto
=SRcG
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
