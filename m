Received: from eggs.gnu.org ([2001:4830:134:3::10]:53993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKPty-0006Ez-BS
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKPtt-0003kV-By
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:33:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eKPtt-0003iF-2r
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:33:17 -0500
Date: Thu, 30 Nov 2017 15:33:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171130143306.GC4039@localhost.localdomain>
References: <3c1d9325-56a9-225d-4ff8-230f8ed52fed@virtuozzo.com>
	<76f5ec24-112f-455a-4ad4-5c97d7182f36@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <76f5ec24-112f-455a-4ad4-5c97d7182f36@redhat.com>
Subject: Re: [Qemu-devel] export root node for write through NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 30.11.2017 um 15:21 hat Max Reitz geschrieben:
> On 2017-11-30 08:47, Vladimir Sementsov-Ogievskiy wrote:
> > Hi all.
> >=20
> > We need the following option: start vm in stopped mode (-S) and write
> > it's disk before start through NBD.
> > It should be absolutely safe, but unfortunately it is disallowed by root
> > role of the disk.
> > Is there any workaround or if not, what is a true way to implement this
> > possibility?
> >=20
> > ----
> > error message:
> > =A0=A0=A0 unable to execute QEMU command 'nbd-server-add': Conflicts wi=
th use
> > by drive0 as 'root', which does not allow 'write' on #block100
>=20
> One thing that comes to mind is adding the guest device only after you
> are done with NBD.
>=20
> The other of course is to set share-rw=3Don for the device.

We already allow this with incoming migration, in that case the
BlockBackend for the guest device stays inactive and doesn't request
permissions yet.

I've been thinking for a while that it would be nice to unify the
startup of "normal" VMs and incoming migration, so that images are
always opened inactive first and then get activated.

The interesting point for you could be that opening the image happens
immediately when the process starts, but activation would only happen
when the VM actually starts running (i.e. on 'cont').

Kevin

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaIBaiAAoJEH8JsnLIjy/WprcQAMcCdkvXvpNclbHMMfkczIFA
dgFbkeJKN2FyDv31NjYuW9bJhsL+j4ykFlyMRzckwII5RPcia0WfAHUfi7tg/Zpr
PgPMrdPk6ZeTy8JjfWX6d2f3nD97AA9v4h7Q3Z/jCKZAe7rrDpICiKMulBxTQx1c
ts2RvOKH2UVW+STbJRjWMxBs9D16nz5koa481LmC+z/TQoXF6eMPPWLq3Gb1uuNg
LGNUpdcpF4xZo84q3+DcD9OZoVb9WGapNJr4IVvQToiEScrVxe3VPBCy3knOx9Ex
9bxA3OI+XXKnf5etcQd0GluPHZO0sll7JDfYAHsuXlo+3h9aCB8cgwDUB2EbnLL/
wykIIEGVitplICMGiwro9iTwSYDgCBOhPzQc7oEeZgV5O9nMqpVp0c6QB03zx1Eu
DT3avCRT4zeLvwcpI0tnPXhrvciYfVijElzxsD7RqAeFl6pHeKgrQSNnwZd70C7U
qZx6/4oOI6iIzEsXrxmmq3HPC6A85/BxjETZIrZVoDldU6h5eo8fufDs3WApR/g4
0SzDegCtu3XbzjNYBXLE2yCmloED+o2DqzSoMn6txLB/OaYHZEUX0uF2mp+hkAeM
J8GO7BFcVp8jQQqF9S+GJi5GNBRX9YP0BvJJKfOAxde4GGTwFa+xLbwj124ZX+Ni
LFPwMnoGiaQzIHO89+3Y
=wQe/
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
