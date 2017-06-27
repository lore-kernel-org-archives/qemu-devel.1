Received: from eggs.gnu.org ([2001:4830:134:3::10]:40751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPpYC-0001tG-QA
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPpY8-0000IH-QD
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:25:00 -0400
Date: Tue, 27 Jun 2017 15:24:09 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170627122409.2kot2sct56m6mmgg@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-2-el13635@mail.ntua.gr>
	<w51bmp9zl7t.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vxh224lzto47lvf2"
Content-Disposition: inline
In-Reply-To: <w51bmp9zl7t.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 1/8] block: move ThrottleGroup
 membership to ThrottleGroupMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--vxh224lzto47lvf2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 02:08:54PM +0200, Alberto Garcia wrote:
>On Fri 23 Jun 2017 02:46:53 PM CEST, Manos Pitsidianakis wrote:
>> This commit gathers ThrottleGroup membership details from
>> BlockBackendPublic into ThrottleGroupMember and refactors existing code
>> to use the structure.
>>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>
>Hey Manos, thanks for the patch. It looks good to me in general, I only
>have a couple of comments:
>
>>      /* If no IO are queued for scheduling on the next round robin token
>> -     * then decide the token is the current bs because chances are
>> -     * the current bs get the current request queued.
>> +     * then decide the token is the current tgm because chances are
>> +     * the current tgm get the current request queued.
>
>I wonder if it's not better to use 'member' instead of 'tgm' in general.
>My impression is that the former is clearer and not too long, but I
>don't have a very strong opinion so you can keep it like this if you
>want.

I will change it, no problem,

>> -/* Check if an I/O request needs to be throttled, wait and set a timer
>> - * if necessary, and schedule the next request using a round robin
>> - * algorithm.
>> +/* Check if an I/O request needs to be throttled, wait and set a timer =
if
>> + * necessary, and schedule the next request using a round robin algorit=
hm.
>>   *
>
>There's a few cases like this when you reformat a paragraph but don't
>actually change the text. I think it just adds unnecessary noise to the
>diff...

Wiki says "It's OK to fix coding style issues in the immediate area (few=20
lines) of the lines you're changing" so I left the reformats. Since they=20
are noticed they must be too noisey.. I will either remove the changes=20
or do a restyling patch later.

>> --- a/include/qemu/throttle.h
>> +++ b/include/qemu/throttle.h
>> @@ -27,6 +27,7 @@
>>
>>  #include "qemu-common.h"
>>  #include "qemu/timer.h"
>> +#include "qemu/coroutine.h"
>>
>>  #define THROTTLE_VALUE_MAX 1000000000000000LL
>>
>> @@ -153,4 +154,29 @@ bool throttle_schedule_timer(ThrottleState *ts,
>>
>>  void throttle_account(ThrottleState *ts, bool is_write, uint64_t size);
>>
>> +
>> +/* The ThrottleGroupMember structure indicates membership in a Throttle=
Group
>> + * and holds related data.
>> + */
>> +
>> +typedef struct ThrottleGroupMember {
>> +    /* throttled_reqs_lock protects the CoQueues for throttled requests=
=2E  */
>> +    CoMutex      throttled_reqs_lock;
>> +    CoQueue      throttled_reqs[2];
>> +
>> +    /* Nonzero if the I/O limits are currently being ignored; generally
>> +     * it is zero.  Accessed with atomic operations.
>> +     */
>> +    unsigned int io_limits_disabled;
>> +
>> +    /* The following fields are protected by the ThrottleGroup lock.
>> +     * See the ThrottleGroup documentation for details.
>> +     * throttle_state tells us if I/O limits are configured. */
>> +    ThrottleState *throttle_state;
>> +    ThrottleTimers throttle_timers;
>> +    unsigned       pending_reqs[2];
>> +    QLIST_ENTRY(ThrottleGroupMember) round_robin;
>> +
>> +} ThrottleGroupMember;
>> +
>
>Any reason why you add this to throttle.h (which is generic throttling
>code independent from the block layer) and not to throttle-groups.h?

I put it there because it's not directly ThrottleGroup-related, but=20
you're right, if throttle.h is block layer free it should remain that=20
way.
>
>Otherwise it all looks good to me, thanks!
>
>Berto
>

--vxh224lzto47lvf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllSTmgACgkQc2J8L2kN
9xCHrhAAl9IP2mC4BR4xcayRcJF2IGJW3jkEIP7Bk0zinqlE3COjbVMSKmfNxsZP
YUmZZ+IyxKz6HzFeGDHWbLxlaTDa1gLHX+x+BKnkp8fDBbsQVoDU3g8x28wnYOa4
uwSjT21w+qRYJ1/nw5HfjwHhVKzhZCGx0h8QqMqZ0Uvdr9byoVybQBVRo3SIiAfA
5YZcp/hOlctw8AVwapxs6xFc/T98SYpfe9N0/PgsElckB9YXaCedXQnCyA0Y2CuT
v2fIWXIfvyOoEjxcn7FqtjhtfQAs8V+fdB1/cs1n6H2BxKNxN8JUG5/ph1kQMhvW
r+oKO2xGuHV+JYtvnLGbp1dby7NDwIXgilRFzgLRperVfhezUXA5HZSvTTZwHelK
WhSkAHSKmM/Zk8j3nMXha9A3WO9pxO26XSTs9uq2GUfmLLCaLmWitIZLA4pavIiZ
Er+S1tzFHCzH6bC0AVXVXEFIWF2yJhHmQUQhm784Fm4l4gOKUUoyHKtlGP7MMsfq
MuDgS45tqW5f9ZdQHGgR115bTC45IJ3HtijtU2vLyJf2peDsYRatDpuQO4hjELrA
N41NSuQAkHoLs1SXa2TPkzLJIkiBLchR5uGXimY5b/fPgYW1XYJC3ljgfkyhnDLm
cGTEdaPxdmD5gvVSJ1grk5KSBbfchYqhDrPIXE4EXdNCwEou7Qk=
=Xj0W
-----END PGP SIGNATURE-----

--vxh224lzto47lvf2--
