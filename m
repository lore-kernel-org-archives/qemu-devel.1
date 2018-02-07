Received: from eggs.gnu.org ([2001:4830:134:3::10]:37876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejYe9-0008CL-Pw
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejYe8-0005S6-Rw
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:57 -0500
References: <20180119205847.7141-1-jsnow@redhat.com>
	<20180119205847.7141-12-jsnow@redhat.com>
	<98b08bf5-6ac1-a1df-e92d-046b7975e3de@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bb48a32b-4e40-0741-60aa-84ae6328e0e2@redhat.com>
Date: Wed, 7 Feb 2018 23:56:31 +0100
MIME-Version: 1.0
In-Reply-To: <98b08bf5-6ac1-a1df-e92d-046b7975e3de@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HEWj5I5rsTtYEeYEUoqVHyhgEoqVlIGIm"
Subject: Re: [Qemu-devel] [PATCH v2 11/13] block/mirror: remove
 block_job_sleep_ns calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HEWj5I5rsTtYEeYEUoqVHyhgEoqVlIGIm
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <bb48a32b-4e40-0741-60aa-84ae6328e0e2@redhat.com>
Subject: Re: [PATCH v2 11/13] block/mirror: remove block_job_sleep_ns calls
References: <20180119205847.7141-1-jsnow@redhat.com>
 <20180119205847.7141-12-jsnow@redhat.com>
 <98b08bf5-6ac1-a1df-e92d-046b7975e3de@redhat.com>
In-Reply-To: <98b08bf5-6ac1-a1df-e92d-046b7975e3de@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-07 23:46, Max Reitz wrote:
> On 2018-01-19 21:58, John Snow wrote:
>> We're attempting to slacken the mirror loop in three different places,=

>> but we can combine these three attempts. Combine the early loop call t=
o
>> block_job_pause_point with the two late-loop calls to block_job_sleep_=
ns.
>>
>> When delay_ns is 0 and it has not been SLICE_TIME since the last yield=
,
>> block_job_relax is merely a call to block_job_pause_point, so this sho=
uld
>> be equivalent with the exception that if we have managed to not yield =
at
>> all in the last SLICE_TIME ns, we will now do so.
>>
>> I am not sure that condition was possible,
>> so this loop should be equivalent.
>=20
> Well, to me it even sounds like a positive change if it was a change.
> We want the job to yield after SLICE_TIME ns, after all, and I don't
> think it matters where that happens, exactly.
>=20
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/mirror.c     | 22 +++++++++++-----------
>>  block/trace-events |  2 +-
>>  2 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index a0e0044de2..192e03694f 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -761,7 +761,7 @@ static void coroutine_fn mirror_run(void *opaque)
>>      assert(!s->dbi);
>>      s->dbi =3D bdrv_dirty_iter_new(s->dirty_bitmap);
>>      for (;;) {
>> -        uint64_t delay_ns =3D 0;
>> +        static uint64_t delay_ns =3D 0;
>=20
> Errr.  Are you sure about that?
>=20
> Now every mirror job in the qeny process will share this single
> variable.  Was that your intention?

("Errr" @myself for "qeny")


--HEWj5I5rsTtYEeYEUoqVHyhgEoqVlIGIm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp7hB8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A/Y8IAJ4ocgJ48dXOQU1ROqAhfjRWlwrw3AjE
R4WqZzeVjqYJcKGi4gYNxoOEg/YF1uiHSfoTaQx7uWE3OHbtVYcMM5KU4WsNsLln
ln6WBY+5GStMoyT0mZA9FYpgwTkoguvwqitpPGn+22fk2r6uveL2zW4AR9HMMjKg
R+kSgl2r0BuMg6OuOqzvuS1nEGFFux0FaQToJalFyiaBOjyNbGtSDlSajCh0N8Pa
o0acg+VV2N9lmDV+9x4YNB0y+XLRjY/rzEdUQGlvwp3+HD7XtVukDsZ8BcQHh9LL
lmS7f8K2k3h+rsMpmu4saSbZ5ns9KWTJsugkYPYKnzs9jTLBMUh2lD8=
=RZtT
-----END PGP SIGNATURE-----

--HEWj5I5rsTtYEeYEUoqVHyhgEoqVlIGIm--
