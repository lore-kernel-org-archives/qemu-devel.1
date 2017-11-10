Received: from eggs.gnu.org ([2001:4830:134:3::10]:45465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHM2-0001SQ-93
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHM1-0007sN-Bc
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:00:50 -0500
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-6-mreitz@redhat.com>
	<0d714dcf-f15c-c229-fa30-1d42002a2438@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3eb16582-87e8-61f0-f880-dea9cec0e25f@redhat.com>
Date: Fri, 10 Nov 2017 23:00:36 +0100
MIME-Version: 1.0
In-Reply-To: <0d714dcf-f15c-c229-fa30-1d42002a2438@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vl4FFrdIBidmnRQMu2hSKFWWaEne588lr"
Subject: Re: [Qemu-devel] [PATCH for-2.11 5/5] qcow2: Refuse to get
 unaligned offsets from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vl4FFrdIBidmnRQMu2hSKFWWaEne588lr
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Message-ID: <3eb16582-87e8-61f0-f880-dea9cec0e25f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 5/5] qcow2: Refuse to get unaligned
 offsets from cache
References: <20171110203111.7666-1-mreitz@redhat.com>
 <20171110203111.7666-6-mreitz@redhat.com>
 <0d714dcf-f15c-c229-fa30-1d42002a2438@redhat.com>
In-Reply-To: <0d714dcf-f15c-c229-fa30-1d42002a2438@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 22:54, Eric Blake wrote:
> On 11/10/2017 02:31 PM, Max Reitz wrote:
>> Instead of using an assertion, it is better to emit a corruption event=

>> here.  Checking all offsets for correct alignment can be tedious and i=
t
>> is easily possible to forget to do so.  qcow2_cache_do_get() is a
>> function every L2 and refblock access has to go through, so this is a
>> good central point to add such a check.
>>
>> And for good measure, let us also add an assertion that the offset is
>> non-zero.  Making this a corruption event is not feasible, because a
>> zero offset usually means something special (such as the cluster is
>> unused), so all callers should be checking this anyway.  If they do no=
t,
>> it is their fault, hence the assertion here.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2-cache.c        | 21 +++++++++++++++++++++
>>  tests/qemu-iotests/060     | 21 +++++++++++++++++++++
>>  tests/qemu-iotests/060.out | 29 +++++++++++++++++++++++++++++
>>  3 files changed, 71 insertions(+)
>>
>=20
>> +--- Repairing ---
>> +Repairing refcount block 1 is outside image
>> +ERROR refcount block 2 is not cluster aligned; refcount table entry c=
orrupted
>> +qcow2: Marking image as corrupt: Refblock offset 0x200 unaligned (ref=
table index: 0x2); further corruption events will be suppressed
>> +Can't get refcount for cluster 1048576: Input/output error
>=20
> Trying to understand this: we have a double corruption, because we
> encountered a refblock that points outside of the image, but fixing the=

> refblock in turn encounters a second refblock that points within the
> image but to an unaligned area.

No, it's the very same.  As far as I've seen it, the repair function
tries to fix the "refblock is outside image" error by resizing the image
so the refblock is inside the image.  However, the subsequent
bdrv_truncate() detects the alignment corruption, too, and thus marks
the image corrupt.

The check function itself never marks the image corrupt because it's
doing its best to fix it. :-)

(And the only point in marking an image corrupt is to force the user to
repair it.)

And that's also the reason why we need to invoke the repair twice: On
the first run the check function notices that the image is so broken we
need to create new refcount structures, so it does that.  But it cannot
free the old structures (or something) because bs->drv =3D=3D NULL by now=
=2E
And then it cannot be run a second time because !bs->drv.

So you need to manually invoke it a second time, and then it goes over
the newly created refcount structures which are then fixed up.

> Of course, you should never encounter these bad refblocks in normal
> usage, but when it comes to dealing with untrusted images, being robust=

> is always worth it.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Max


--vl4FFrdIBidmnRQMu2hSKFWWaEne588lr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloGIYQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYpsH+wd6j1P7zpf2ou5X+gjVrsmXsKlsJT3Z
OaMtn1QQzka5F2c7JU738XOq+GS3YqMpesCy0ERY/eCMM6+/0VJsCJ2wnzoIuAkw
8nvwiLUX/bGmvWq/JSR5EiBIjqX96QApYtIpZ4u/7b17ffJ0cUgSZcSdzBea0fH5
+tiMSDJSvLwTKLfhpElYZ95XbQzWOc3bX2z3IITJ6ZiHPaME3eBnqoJG2ccyfxRh
Kat8VUEQ60jTgZ4ogNeIs+ZlKUEK+VOkDOmYXlVzIszwV4OyCA/aRXsI2U2FsFNl
I1LK5C7d7V7pEPO7eHIBCHtCcPuJQvcAhWUti4z9KnvticiBjts//2c=
=toG9
-----END PGP SIGNATURE-----

--vl4FFrdIBidmnRQMu2hSKFWWaEne588lr--
