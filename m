Received: from eggs.gnu.org ([2001:4830:134:3::10]:42465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtyfq-0000z1-Lk
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtyfp-0006LW-Cj
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:13:30 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-3-mreitz@redhat.com>
	<20170918034431.GA15551@lemon.lan>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <85fd9e96-4135-a62d-76ff-631104cd02f1@redhat.com>
Date: Mon, 18 Sep 2017 18:13:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170918034431.GA15551@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k1CgRqXMoES3PRuC9eWiJKxjrIKJMxOko"
Subject: Re: [Qemu-devel] [PATCH 02/18] block: BDS deletion during
 bdrv_drain_recurse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k1CgRqXMoES3PRuC9eWiJKxjrIKJMxOko
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <85fd9e96-4135-a62d-76ff-631104cd02f1@redhat.com>
Subject: Re: [PATCH 02/18] block: BDS deletion during bdrv_drain_recurse
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-3-mreitz@redhat.com> <20170918034431.GA15551@lemon.lan>
In-Reply-To: <20170918034431.GA15551@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-18 05:44, Fam Zheng wrote:
> On Wed, 09/13 20:18, Max Reitz wrote:
>> Drainined a BDS child may lead to both the original BDS and/or its oth=
er
>> children being deleted (e.g. if the original BDS represents a block
>> job).  We should prepare for this in both bdrv_drain_recurse() and
>> bdrv_drained_begin() by monitoring whether the BDS we are about to dra=
in
>> still exists at all.
>=20
> Can the deletion happen when IOThread calls
> bdrv_drain_recurse/bdrv_drained_begin?

I don't think so, because (1) my issue was draining a block job and that
can only be completed in the main loop, and (2) I would like to think
it's always impossible, considering that bdrv_unref() may only be called
with the BQL.

>                                         If not, is it enough to do
>=20
>     ...
>     if (in_main_loop) {
>         bdrv_ref(bs);
>     }
>     ...
>     if (in_main_loop) {
>         bdrv_unref(bs);
>     }
>=20
> to protect the main loop case? So the BdrvDeletedStatus state is not ne=
eded.

We already have that in bdrv_drained_recurse(), don't we?

The issue here is, though, that QLIST_FOREACH_SAFE() stores the next
child pointer to @tmp.  However, once the current child @child is
drained, @tmp may no longer be valid -- it may have been detached from
@bs, and it may even have been deleted.

We could work around the latter by increasing the next child's reference
somehow (but BdrvChild doesn't really have a refcount, and in order to
do so, we would probably have to emulate being a parent or
something...), but then you'd still have the issue of @tmp being
detached from the children list we're trying to iterate over.  So
tmp->next is no longer valid.

Anyway, so the latter is the reason why I decided to introduce the bs_lis=
t.

But maybe that actually saves us from having to fiddle with BdrvChild...
 Since it's just a list of BDSs now, it may be enough to simply
bdrv_ref() all of the BDSs in that list before draining any of them.  So
 we'd keep creating the bs_list and then we'd move the existing
bdrv_ref() from the drain loop into the loop filling bs_list.

And adding a bdrv_ref()/bdrv_unref() pair to bdrv_drained_begin() should
hopefully work there, too.

Max


--k1CgRqXMoES3PRuC9eWiJKxjrIKJMxOko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm/8I8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AcXYIALhaI0RonCNj7cH+vleGjHDAhIXJIUwk
lhgYMY5WH4S8Gdl7PQM3psJD7kBPNitpfkfGYP/njs7tmco9H6RyiCQ+WSuJb3t0
mQLVxGthD9XxWK7GpDJn1wdf8h+ldw/eOBCS5JTYZMPsGlga8iMBkNUgwLzKsddJ
DmfeIAxcU1pMLe/5igZbmQI+txXkbRSdN+bUIexEFWq573pl1OJvqN5ExSuoFr7a
vI0kNvMeUKBM2PT5JjI1ziXiZBqNhRQa8MBqI2ZQJUvp0CvebzFzh/qaDgHbW2sm
fIiNj7+PAJ8uv/FdEBSyWf9fzjHRrd57MTG2UwGmfXVLOWCGXf1ROsg=
=+W0U
-----END PGP SIGNATURE-----

--k1CgRqXMoES3PRuC9eWiJKxjrIKJMxOko--
