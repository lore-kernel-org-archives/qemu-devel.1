Received: from eggs.gnu.org ([209.51.188.92]:53795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw12O-0006vg-UD
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw12O-00079C-6Q
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:46:00 -0500
Date: Tue, 19 Feb 2019 09:45:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190219084544.GB4727@localhost.localdomain>
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-7-kwolf@redhat.com>
	<e8d7022b-5946-381f-262c-47b1596cc2a6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <e8d7022b-5946-381f-262c-47b1596cc2a6@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 06/11] qcow2: Don't assume 0 is an
 invalid cluster offset
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


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.02.2019 um 00:13 hat Max Reitz geschrieben:
> On 31.01.19 18:55, Kevin Wolf wrote:
> > The cluster allocation code uses 0 as an invalid offset that is used in
> > case of errors or as "offset not yet determined". With external data
> > files, a host cluster offset of 0 becomes valid, though.
> >=20
> > Define a constant INV_OFFSET (which is not cluster aligned and will
> > therefore never be a valid offset) that can be used for such purposes.
> >=20
> > This removes the additional host_offset =3D=3D 0 check that commit
> > ff52aab2df5 introduced; the confusion between an invalid offset and
> > (erroneous) allocation at offset 0 is removed with this change.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/qcow2.h         |  2 ++
> >  block/qcow2-cluster.c | 59 ++++++++++++++++++++-----------------------
> >  2 files changed, 29 insertions(+), 32 deletions(-)
>=20
> qcow2_get_cluster_offset() still returns 0 for unallocated clusters.
> (And qcow2_co_block_status() tests for that, so it would never report a
> valid offset for the first cluster in an externally allocated qcow2 file.)

I think the bug here is in qcow2_get_cluster_offset(). It shouldn't look
at cluster_offset, but at ret if it wants to know the allocation status.
So I think this needs to become something like:

    if ((ret =3D=3D QCOW2_CLUSTER_NORMAL || ret =3D=3D QCOW2_CLUSTER_ZERO_A=
LLOC) &&
        !s->crypto) {
        ...
    }

> qcow2_alloc_compressed_cluster_offset() should return INV_OFFSET on
> error (yeah, there are no compressed clusters in external files, but
> this seems like the right thing to do still).

Ok, makes sense.

> (And there are cases like qcow2_co_preadv(), where cluster_offset is
> initialized to 0 -- it doesn't make a difference what it's initialized
> to (it's just to silence the compiler, I suppose), but it should still
> use this new constant now.  I think.)

I don't think I would change places where cluster_offset is never used
at all or never used alone without checking the cluster type, too.

qcow2_get_cluster_offset() still returns 0 for unallocated and
non-preallocated zero clusters, and I think that's fine because it also
returns the cluster type, which is information about whether the offset
is even valid.

In theory, it shouldn't matter at all if we return 0, INV_OFFSET or 42
there, but in practice I'd bet neither money nor production images on
this. If it ain't broke, don't fix it.

Kevin

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJca8I4AAoJEH8JsnLIjy/WJwUQAMdVbQXKluqeklnDlAH2Q5qO
Kdjb7ITy57rMfEjHeN10mPjq1MvA9RAy3lIyerDs50/M/DrW/847pcXA2JCWDNTt
snEs8+3GxsJ3JtvsGHuOnbAp6202XZSTVCcSdL+6V/unveaBpZllhmKXCUueSjwr
68kIPBTVDKFL6hS+Rl01ohzAKLi2QZJHQ5ZRPn/0osQqiOVrULBMbJWPNMzIoCX/
BgaWFtGkeKwAE/u+ykmHjityjNDQ30jFDi9EmfIlhskLOMH1dDmlTWxxC5loQOk9
NiwiFyXDpUOSKRIZQH0+RGQfLLLUgoBvxbios94At3sQIQtmk0jqCwU0JBqG1SJP
cWmgHjf/C254ZcgOPPYWTzlZKJC02VakhTE3qZkkD4zEmhUtpPqq3bBfygv9sJ9D
eMrzYoE+q5plulXseZbCCYoqvfW0NvLNij1WrKkB7wESIrNiczsulOBBUGMyFa7A
voPc2dP/pol9hqK8RxoDglV7QK/DqmTaY0bkhZouuwpdR3DDh4cOec+sjmYKI5kN
RJUSYKO5LLUG+KhvEBgkThuTE7o4pnoi9Ovg1f7ZSYg5OT2DXbNhBHpo9AkSyu3+
tJ0pT1B+NyAex+4QdWGjX5lubBFkJodNQshtCEn0xWY360euNAWAedxXbiokF9u4
8Dh4fpZSWu4UYQ2aTp0q
=STu7
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
