Received: from eggs.gnu.org ([2001:4830:134:3::10]:55782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2FOg-0001lY-3G
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 07:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2FOe-0004T2-V4
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 07:41:58 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-3-mreitz@redhat.com>
	<20171010083651.GC4177@dhcp-200-186.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cc8d5dc0-6e29-fda3-3ff1-b44cbdd9755d@redhat.com>
Date: Wed, 11 Oct 2017 13:41:39 +0200
MIME-Version: 1.0
In-Reply-To: <20171010083651.GC4177@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VG7onOP7wIG1s3kIAInFME6fORSr2P3Ui"
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VG7onOP7wIG1s3kIAInFME6fORSr2P3Ui
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng
 <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <cc8d5dc0-6e29-fda3-3ff1-b44cbdd9755d@redhat.com>
Subject: Re: [PATCH 02/18] block: BDS deletion during bdrv_drain_recurse
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-3-mreitz@redhat.com>
 <20171010083651.GC4177@dhcp-200-186.str.redhat.com>
In-Reply-To: <20171010083651.GC4177@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-10 10:36, Kevin Wolf wrote:
> Am 13.09.2017 um 20:18 hat Max Reitz geschrieben:
>> Drainined a BDS child may lead to both the original BDS and/or its oth=
er
>> children being deleted (e.g. if the original BDS represents a block
>> job).  We should prepare for this in both bdrv_drain_recurse() and
>> bdrv_drained_begin() by monitoring whether the BDS we are about to dra=
in
>> still exists at all.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> How hard would it be to write a test case for this? qemu-iotests
> probably isn't the right tool, but I feel a C unit test would be
> possible.

I can look into it, but I can't promise anything.

>> -    QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
>> -        BlockDriverState *bs =3D child->bs;
>> -        bool in_main_loop =3D
>> -            qemu_get_current_aio_context() =3D=3D qemu_get_aio_contex=
t();
>> -        assert(bs->refcnt > 0);
>=20
> Would it make sense to keep this assertion for the !deleted case?

Sure, why not.

>> -        if (in_main_loop) {
>> -            /* In case the recursive bdrv_drain_recurse processes a
>> -             * block_job_defer_to_main_loop BH and modifies the graph=
,
>> -             * let's hold a reference to bs until we are done.
>> -             *
>> -             * IOThread doesn't have such a BH, and it is not safe to=
 call
>> -             * bdrv_unref without BQL, so skip doing it there.
>> -             */
>> -            bdrv_ref(bs);
>> -        }
>> -        waited |=3D bdrv_drain_recurse(bs);
>> -        if (in_main_loop) {
>> -            bdrv_unref(bs);
>> +    /* Draining children may result in other children being removed a=
nd maybe
>> +     * even deleted, so copy the children list first */
>=20
> Maybe it's just me, but I failed to understand this correctly at first.=

> How about "being removed from their parent" to clarify that it's not th=
e
> BDS that is removed, but just the reference?

Well, it's the BdrvChild that's removed, that's what I meant by
"children".  But then the comment speaks of "children list" and means
creation of a list of BDSs, sooo...  Yes, some change necessary.

Max


--VG7onOP7wIG1s3kIAInFME6fORSr2P3Ui
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlneA3MSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6/UH/3b5D2mo9HoJvHoETNt8OuBT1zptPb02
CUD1bAfgjF9sFWm4c60kcJ9SpzBmdca3Cix3jC8FB7PJnbsYUq6E6PIhim2HR9s9
wkkE6Gt/N3IO2VVyb70EE1FwFBExVSYNP+cp6q9jyETLtbwh5HnriZsx9sA3pQJw
n5TBOvfTEvjsoeeG0BCp2x4eHMaJWUw0MesrGJOMv1jl6qzQP1dx8sJrmHoreEz8
+OedhflvYND50PymZVdB48lmxIXvVafYWrWWhjW2Befn9BcQ9z6PQTsHZ7LHqRuQ
caZ+VBjcy9V4koFGuUGaol89fsNFJUnms5r8283c69D0uT9oC6jOwro=
=wbQA
-----END PGP SIGNATURE-----

--VG7onOP7wIG1s3kIAInFME6fORSr2P3Ui--
