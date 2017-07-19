Received: from eggs.gnu.org ([2001:4830:134:3::10]:53315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1dXrZF-0007U9-PP
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1dXrZE-0000XI-Oc
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:11:17 -0400
Date: Wed, 19 Jul 2017 18:11:11 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20170719161111.GE8266@andariel.pipo.sk>
References: <1500472685-25246-1-git-send-email-kwolf@redhat.com>
	<2e750f9b-8a7f-44be-a673-8046aa73f914@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <2e750f9b-8a7f-44be-a673-8046aa73f914@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2] block: Skip implicit nodes in
 query-block/blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com, armbru@redhat.com, nsoffer@redhat.com, el13635@mail.ntua.gr, qemu-devel@nongnu.org, qemu-stable@nongnu.org


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 09:55:51 -0500, Eric Blake wrote:
> On 07/19/2017 08:58 AM, Kevin Wolf wrote:
> > Commits 0db832f and 6cdbceb introduced the automatic insertion of filter
> > nodes above the top layer of mirror and commit block jobs. The
> > assumption made there was that since libvirt doesn't do node-level
> > management of the block layer yet, it shouldn't be affected by added
> > nodes.
> >=20
> > This is true as far as commands issued by libvirt are concerned. It only
> > uses BlockBackend names to address nodes, so any operations it performs
> > still operate on the root of the tree as intended.
> >=20
> > However, the assumption breaks down when you consider query commands,
> > which return data for the wrong node now. These commands also return
> > information on some child nodes (bs->file and/or bs->backing), which
> > libvirt does make use of, and which refer to the wrong nodes, too.
>=20
> I'm a bit worried about this statement.  Libvirt controls the
> BLOCK_WRITE_THRESHOLD event via block-set-write-threshold, which
> requires the use of a node name (for a qcow2-backed-by-block-device, you
> want the threshold to be tied to the block-device protocol BDS, not the
> qcow2 format BDS).  We need to test that this patch does not break
> write-threshold computation (ie. that libvirt is still able to use the
> query commands to learn WHICH node name to pass to
> block-set-write-threshold).

Libvirt currently uses 'query-named-block-nodes' for this, but the
algorithm is terrible. But dealing with this lately I've figured out
that actually 'query-blockstats' provides the node name information way
more conveniently. Especially the hierarchy and link to the storage node
are very clear.

I'm actually refactoring the nodename detector to use this.

> Or put another way, there are two types of implicit nodes names: the
> implicit node names for protocol BDS (libvirt cares about those), and
> the implicit node names for block job temporary BDS (libvirt does not
> care about those).  If this patch is touching ONLY the block job
> implicit node names, we may be okay - but that's something we want to

The code does this. The boolean suppressing the output to the query
commands is set only to BDSs which are created

> test with libvirt before accepting this patch.  Peter, are you in a
> position to test it faster than me?

Tomorrow at best.

Either way. I've followed the code through and currently it looks like
it should be okay from libvirt's pov.

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAllvhJkACgkQHGwCByjY
1GrxcQ//a7mEYTHe+y9n8ENO+kIpptTYbzaQE+WGXZI9A3gZHyJo94CCE+vCg6bZ
/elXdYVzAVMF9iC37NaeIX+UXlIZk1JddBtBljdp/F9PPkSw5QQMYYl8iXPAlDbB
7vkkW8O5xfyH1DUhisAwYglBDKFKc2+5h6e8Wubh31kJ7DWcaS/yya/NZ9jkJSCm
YtsqxPhGSvnijEe3XK9xgxJGcBscmZGdlXVDmNkt57Gmcu7T9jwFuCBnSKHGYjsW
4dCeAxgpRnA2XS9pfDoYeHFhOLki3yR0shcQWmXm1Sl/KWwHXhxWIqik4h4E3b/e
DHrhyTmCRTinCI1zqIBSBOMuL/oC6GeATHwvDV62NZWN5+uEnONAkFERE0Am47Q5
aE3tMlb/3hVrJ90wksCuZRLGGk03XBsAErwIjefjimLgkJdQ4oGxa8ZEuqQoSMut
xkb/N00D1kb/wMpv+/uG4NcZJQ1oPZmA/BBjhh1xd6y/wSn/CI/w2faI/LepOwKE
MLjlonMSMB3TCnx+0lWIoEYN4/HuHH/HBOYOkLNb0hzEKQtxNmZfI2DyoKKMb1qC
DqYwjpbzUgFRnpyd9KFLFuI2RUX8a15lWFrA+mE+914i+SosUONRZTsGTnYgJluL
A9w7QsFg0B32z1SfSnxWJPFUK5n2CEfU7qMAT0TL3Vt7Q7bADcE=
=3P/3
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
