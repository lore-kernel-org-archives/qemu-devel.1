Received: from eggs.gnu.org ([2001:4830:134:3::10]:40466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eviAl-00044p-0K
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eviAk-0000Hr-3M
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:32:51 -0400
Date: Tue, 13 Mar 2018 12:32:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180313113234.GB4642@localhost.localdomain>
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-8-kwolf@redhat.com>
	<11f93eeb-19f3-9f3e-edb9-00c1bfb86b37@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <11f93eeb-19f3-9f3e-edb9-00c1bfb86b37@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/7] vpc: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.03.2018 um 22:49 hat Max Reitz geschrieben:
> On 2018-03-09 22:46, Kevin Wolf wrote:
> > This adds the .bdrv_co_create driver callback to vpc, which
> > enables image creation over QMP.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-core.json |  33 ++++++++++-
> >  block/vpc.c          | 152 ++++++++++++++++++++++++++++++++++++++-----=
--------
> >  2 files changed, 147 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 3a65909c47..ca645a0067 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -3734,6 +3734,37 @@
> >              '*block-state-zero':    'bool' } }
> > =20
> >  ##
> > +# @BlockdevVpcSubformat:
> > +#
> > +# @dynamic: Growing image file
> > +# @fixed:   Preallocated fixed-size imge file
>=20
> s/imge/image/
>=20
> > +#
> > +# Since: 2.12
> > +##
> > +{ 'enum': 'BlockdevVpcSubformat',
> > +  'data': [ 'dynamic', 'fixed' ] }
> > +
> > +##
> > +# @BlockdevCreateOptionsVpc:
> > +#
> > +# Driver specific image creation options for vpc (VHD).
> > +#
> > +# @file             Node to create the image format on
> > +# @size             Size of the virtual disk in bytes
> > +# @subformat        vhdx subformat (default: dynamic)
> > +# @force-size       Force use of the exact byte size instead of roundi=
ng to the
> > +#                   next size that can be represented in CHS geometry
> > +#                   (default: false)
>=20
> Now that's weird, again considering your previous approach of only
> rounding things in the legacy path and instead throwing errors from
> blockdev-create.  If you think this is OK to have here, than that's OK
> with me, but I'm not sure this is the ideal way.

Hmm... That's a tough one.

There are a two major differences between VHD and the other image
formats: The first is that rounding is part of the VHD spec. The other
is that while other drivers have reasonable alignment restrictions that
never cause a problem anyway (because people say just '8G' instead of
some odd number), CHS alignment is not reasonable (because '8G' and
similar things will most probably fail).

And then there's the well-known problem that MS is inconsistent with
itself, so force-size=3Doff is required to make images that work with
Virtual PC, but force-size=3Don may be needed for unaligned image sizes
that HyperV allows, iirc.

> Alternatives:
>=20
> 1. Swap the default, not sure this is such a good idea either.
>=20
> 2. Maybe add an enum instead.  Default: If the given size doesn't fit
> CHS, generate an error.  Second choice: Use the given size, even if it
> doesn't fit.  Third choice: Round to CHS.

Maybe we should keep force-size, but make it an error if the size isn't
already aligned (consistent with other block drivers).

The legacy code path could still round, but print a deprecation warning.
Once we get rid of the legacy path, users will have to specify sizes
with correct alignment. The error message could suggest using the
rounded value for Virtual PC compatibility or force-share=3Don otherwise.

That wouldn't be very nice to use, but maybe it's the best we can make
out of a messed up format like VHD.

> I don't want to be stuck up, but once it's a public interface...

The good thing is that it's still x-blockdev-create.

Kevin

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJap7bSAAoJEH8JsnLIjy/WOWMQAJNJz0lcERFSI0ZYrE0SZFLX
4OsG+jM6SsX5+L+wKC3Sg60z+wqZRHwCw3j4CT6gBSGGQMy5AMbG9qLqWseBaxOU
ZtakTQacHQZ0mA68MztqrQvqBX9eLCP4dF+39EvxJuComal33Z+kerKYvbD3Z/R6
UdKgkGtSLE77Oy5dkRFgSxaNJoM3NQGh9DlnWXhLRnwtvZH0L10K30RxuZqu0B9Q
MRLpFRi1En2kt300uxdcMnRvagv8944i764zrQdu0v940R1Y3pyOAaGeowBPtsJG
4rG3XL7nK/b9m6Qz320Q2nQM5Rwp+LxSvHfpk5kd+/K2uW2SJlm+uhBZMUJMRaUZ
maIrZQmO73ajKftpCRC8BCfx3GubCFfjktEi9CSFECzbo8mSVglr00DQTpSit89f
1azzq0/Pdoemql3Oz4x7gNkbZU+L3+fBW1MKmwPoSHzWC3J6+QDzk6WxuzWo9cSI
QKbvTXuvIkQsoPcDnHaDWzdBlccnRcKcGtQ0+HvPwyonlOHWoBuPJ1wzhAdwpu02
N6xWNxEDH5G/3JldrTxrCPq4151qnrHtwKqKQUrWCq2N2s5Z5NFF2ztIf41vVZ+p
9zOysQOsqGtnejX2XsfPq8cv21tfFl6sGk7tJoVqcyvMMFKgXfOI9oVVIKrgAxb7
E6gjho3Hrj7BRe8PPm1s
=Go8b
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
