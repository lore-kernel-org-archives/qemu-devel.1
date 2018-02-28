Received: from eggs.gnu.org ([2001:4830:134:3::10]:46050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er3IV-0002av-EP
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:05:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er3IU-0003vv-9O
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:05:35 -0500
References: <20180122220806.22154-1-mreitz@redhat.com>
	<20180122220806.22154-13-mreitz@redhat.com>
	<20180227091239.GD25412@lemon.usersys.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0241c0c8-e4a0-f986-bcbd-9a46b0879d26@redhat.com>
Date: Wed, 28 Feb 2018 16:05:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180227091239.GD25412@lemon.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NSf6MI1X4ol6nrIEM82TzINP8AKEz3ipc"
Subject: Re: [Qemu-devel] [PATCH v2 12/16] block/mirror: Distinguish active
 from passive ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NSf6MI1X4ol6nrIEM82TzINP8AKEz3ipc
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <0241c0c8-e4a0-f986-bcbd-9a46b0879d26@redhat.com>
Subject: Re: [PATCH v2 12/16] block/mirror: Distinguish active from passive
 ops
References: <20180122220806.22154-1-mreitz@redhat.com>
 <20180122220806.22154-13-mreitz@redhat.com>
 <20180227091239.GD25412@lemon.usersys.redhat.com>
In-Reply-To: <20180227091239.GD25412@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-27 10:12, Fam Zheng wrote:
> On Mon, 01/22 23:08, Max Reitz wrote:
>> Currently, the mirror block job only knows passive operations.  But on=
ce
>> we introduce active writes, we need to distinguish between the two; fo=
r
>> example, mirror_wait_for_free_in_flight_slot() should wait for a passi=
ve
>> operation because active writes will not use the same in-flight slots.=

>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/mirror.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 2363e79563..bb46f3c4e9 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -89,6 +89,7 @@ struct MirrorOp {
>>      int64_t *bytes_handled;
>> =20
>>      bool is_pseudo_op;
>> +    bool is_active_write;
>>      CoQueue waiting_requests;
>> =20
>>      QTAILQ_ENTRY(MirrorOp) next;
>> @@ -281,8 +282,10 @@ static inline void mirror_wait_for_free_in_flight=
_slot(MirrorBlockJob *s)
>>           * some other operation to start, which may in fact be the
>>           * caller of this function.  Since there is only one pseudo o=
p
>>           * at any given time, we will always find some real operation=

>> -         * to wait on. */
>> -        if (!op->is_pseudo_op) {
>> +         * to wait on.
>> +         * Also, only non-active operations use up in-flight slots, s=
o
>> +         * we can ignore active operations. */
>> +        if (!op->is_pseudo_op && !op->is_active_write) {
>>              qemu_co_queue_wait(&op->waiting_requests, NULL);
>>              return;
>>          }
>> --=20
>> 2.14.3
>>
>=20
> I'd just squash this patch into 14 to avoid code churn.

I wanted to pull out as much as possible from 14 since it is massive as
it is, but if you think it makes reviewing even harder... Then I can put
it in there, of course.

Max


--NSf6MI1X4ol6nrIEM82TzINP8AKEz3ipc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqWxSoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABnIH+gM+oZ3W01O1+6CQEqcxyfBkd9INWW4p
aZZySzLi9zFSuzsVR3T+mCxSpo73qPjqr73ZMCd9WxNzvOBz0PQvi0hiFIxfCqWE
VXwgVhxzvz5Ju73oaVQbvGdz2hbpfYsfZ9l17+pcelTyvpYQBWh5AuVpQ6AtKxOT
u+n8uVhUnmAhFd8dVpXAykcSEcdRtstlRdISBzv0FoQLwJasDG71bRxqUGS/fv9n
RJbHX1oqssaobOdWy+4g+itTay8EKXXN56UjsXgQmWkic6i2gdkzwbMszIgVU/IR
9CuWRLe16A+kbxhhxj0GjuCFtepYWhabio4wSMAdJPavGAfTrAEv0p4=
=Pauf
-----END PGP SIGNATURE-----

--NSf6MI1X4ol6nrIEM82TzINP8AKEz3ipc--
