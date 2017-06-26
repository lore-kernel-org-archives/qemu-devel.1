Received: from eggs.gnu.org ([2001:4830:134:3::10]:35424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPUcG-000303-LG
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPUcF-0004er-MF
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:03:48 -0400
Date: Mon, 26 Jun 2017 17:03:06 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170626140306.doogwehvvdtkmzxh@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-3-el13635@mail.ntua.gr>
	<20170626133611.GB29664@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="it2nupntbix6xibk"
Content-Disposition: inline
In-Reply-To: <20170626133611.GB29664@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 2/8] block: Add
 aio_context field in ThrottleGroupMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--it2nupntbix6xibk
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline

On Mon, Jun 26, 2017 at 02:36:11PM +0100, Stefan Hajnoczi wrote:
>On Fri, Jun 23, 2017 at 03:46:54PM +0300, Manos Pitsidianakis wrote:
>> timer_cb() needs to know about the current Aio context of the throttle
>> request that is woken up. In order to make ThrottleGroupMember backend
>> agnostic, this information is stored in an aio_context field instead of
>> accessing it from BlockBackend.
>>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> ---
>>  block/block-backend.c   |  1 +
>>  block/throttle-groups.c | 19 +++++----------
>>  include/qemu/throttle.h |  1 +
>>  tests/test-throttle.c   | 65 +++++++++++++++++++++++++++----------------------
>>  util/throttle.c         |  4 +++
>>  5 files changed, 48 insertions(+), 42 deletions(-)
>>
>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index 90a7abaa53..1d501ec973 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -1928,6 +1928,7 @@ void blk_io_limits_disable(BlockBackend *blk)
>>  /* should be called before blk_set_io_limits if a limit is set */
>>  void blk_io_limits_enable(BlockBackend *blk, const char *group)
>>  {
>> +    blk->public.throttle_group_member.aio_context = blk_get_aio_context(blk);
>>      assert(!blk->public.throttle_group_member.throttle_state);
>>      throttle_group_register_tgm(&blk->public.throttle_group_member, group);
>
>Or throttle_group_register_tgm() could take an AioContext* argument, I
>think that's a little cleaner than modifying throttle_group_member
>fields in multiple source files.

Indeed that is cleaner.

>
>> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
>> index 5e9d8fb4d6..7883cbb511 100644
>> --- a/block/throttle-groups.c
>> +++ b/block/throttle-groups.c
>> @@ -71,6 +71,7 @@ static QemuMutex throttle_groups_lock;
>>  static QTAILQ_HEAD(, ThrottleGroup) throttle_groups =
>>      QTAILQ_HEAD_INITIALIZER(throttle_groups);
>>
>> +
>>  /* Increments the reference count of a ThrottleGroup given its name.
>>   *
>>   * If no ThrottleGroup is found with the given name a new one is
>
>Spurious whitespace change.  Please do not change whitespace in random
>places.

I noticed it too late unfortunately.

--it2nupntbix6xibk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllRFBoACgkQc2J8L2kN
9xCIuw//awTpRTUMAS1qhV9lATU3dJ8tpLhEDBa8GvYNllSIGAN/+YdnmMUqg7y7
QpO7IceBTsjmICLg0YVnABFw06ZQP/PU0mYzsro1sASKTAvQ0mD4m+IYynPo3T/s
aMUOW4SNMNmm3qVAhiPJR5q4hrg2S7JscoaboaSLGxRRXiI+0/KXRqv60KdjXpr7
q7N4OhaFCrhycSFyW0IM4NQ36dFNkHIQo0aJvd+quW6Jj1c8pRxvpZYjX59RuLul
c+fLgnS4Mv4s+c9lYC+4oMcGOhZPjzmEF49PhIdp41H3MNFYSMVQCuN2acEXKInm
zSHstvd8oEFrwtzHndZVZ4RT/YVPlwwdXsyyhajbvJkrvJuRupXknuqW1kkJ+wor
vLDb++pPHQ7sG1wicZ6nF6VfZ8HiFlpGvf/VFt7DMytkHkNI5VWOD/+yzsi1XBTn
5ETzTF9gG61PK0iLnwpWonEnA3vJim20vNmd165fBaxeTAVbfJEuZ5+4T29ovON5
gsMLp06R+vyPrKo1axK5MJ5RoY1ARH39w0/Pyz7iHIYXTq2rsr6HExJtvt8Cqa9d
CXpWYjJptwwJ/Qe2ZgGvbnLFX0hHfu4uxFymLSHgKok8rTDbEHitDxcsl02MNwdb
+t2bn+wkJPb3crhupPA2/0l6vvYJYvgnba+cr0pgMDioRSbXvYE=
=38GK
-----END PGP SIGNATURE-----

--it2nupntbix6xibk--
