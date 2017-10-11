Received: from eggs.gnu.org ([2001:4830:134:3::10]:38769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2G0j-0006k2-85
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2G0h-0001gk-VM
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:21:17 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-14-mreitz@redhat.com>
	<20171010095836.GG4177@dhcp-200-186.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <711eb725-4ebe-d2ea-7dd1-944b268c55d9@redhat.com>
Date: Wed, 11 Oct 2017 14:20:54 +0200
MIME-Version: 1.0
In-Reply-To: <20171010095836.GG4177@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NHQbvRmUcoAROqRXj62UXHH7tkrkfxGvf"
Subject: Re: [Qemu-devel] [PATCH 13/18] block/mirror: Keep write perm for
 pending writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NHQbvRmUcoAROqRXj62UXHH7tkrkfxGvf
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng
 <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <711eb725-4ebe-d2ea-7dd1-944b268c55d9@redhat.com>
Subject: Re: [PATCH 13/18] block/mirror: Keep write perm for pending writes
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-14-mreitz@redhat.com>
 <20171010095836.GG4177@dhcp-200-186.str.redhat.com>
In-Reply-To: <20171010095836.GG4177@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-10 11:58, Kevin Wolf wrote:
> Am 13.09.2017 um 20:19 hat Max Reitz geschrieben:
>> The owner of the mirror BDS might retire its write permission; but the=
re
>> may still be pending mirror operations so the mirror BDS cannot
>> necessarily retire its write permission for its child then.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> I'm confused. The child of mirror_top_bs is the source, but don't mirro=
r
> operations only write to the target?

I do know that the iotests added in the end fails without this patch, if
it helps. :-)

Right, for some reason I never thought about this...  OK, so the issue
is that if you create a BB, submit a request and then delete it (the
only BB), permissions requirements for the mirror BDS are dropped and
then it in turn also drops its permissions on the source.

The issue now occurs whenever the BB is deleted before the write request
checks the permissions on the source.  In passive mode, this does not
happen because nothing yields before the permission check.

In active mode, however, active_write_prepare() may yield due to
mirror_wait_on_conflicts().  Since active_write_prepare() also creates
an operation (before yielding), this patch "fixes" the issue.

I think the real bug fix would be to also have a counter of (write)
operations running on the source (incremented/decremented in
bdrv_mirror_top_pwritev()) and to evaluate that in
bdrv_mirror_top_child_perm().

Max


--NHQbvRmUcoAROqRXj62UXHH7tkrkfxGvf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlneDKYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AVjcH/RcOJ3rq/tBqPhJDm/hxnHiSX7GAZScu
4wHlhnoUEOCKPvNxckG/rPSYRE20RPADWK0XfZr3VW8kz7B2OIGou62z2aUE8nuN
kA6xoZxTVqZzPKhYL0Ss8Zs996qDGP/prLwryz9a/VQGonDn9gGPHBYtZw+AzNj5
+S2kk81qAx86D13twDQUWAPA18DoMLVFeHAbB2irEsf8NZJEtQHpFyfHdWIzOf+z
AncgdItgKPmyTgxh2OMKGsKeuYg9M3daaabRVLBh+9CnU8cknfgSAm/4h0AOgEFP
Tb1cBSxfKguHaF4KNL2moyWQrOXvomSg2148MzsUPIdBTSDWndTsGNQ=
=Nnjd
-----END PGP SIGNATURE-----

--NHQbvRmUcoAROqRXj62UXHH7tkrkfxGvf--
