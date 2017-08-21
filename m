Received: from eggs.gnu.org ([2001:4830:134:3::10]:55313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1djljc-0005y1-UE
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1djljc-0003sB-0W
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:23:12 -0400
Date: Mon, 21 Aug 2017 15:20:56 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170821122056.vamuyzjbm3wmlzlm@postretch>
References: <cover.1502979710.git.berto@igalia.com>
	<112e28c8da085ffd59381d86f3acb0b8f75d5f9a.1502979710.git.berto@igalia.com>
	<20170819152312.752zb42qc5ko6rat@postretch>
	<w51efs5nmss.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="za4jdb6vtqb2kifq"
Content-Disposition: inline
In-Reply-To: <w51efs5nmss.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] throttle: Remove throttle_fix_bucket()
 / throttle_unfix_bucket()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--za4jdb6vtqb2kifq
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline

On Mon, Aug 21, 2017 at 02:10:59PM +0200, Alberto Garcia wrote:
>On Sat 19 Aug 2017 05:23:12 PM CEST, Manos Pitsidianakis wrote:
>>>-    /* If the bucket is full then we have to wait */
>>>-    extra = bkt->level - bkt->max * bkt->burst_length;
>>>+    if (!bkt->max) {
>>>+        /* If bkt->max is 0 we still want to allow short bursts of I/O
>>>+         * from the guest, otherwise every other request will be throttled
>>>+         * and performance will suffer considerably. */
>>>+        bucket_size = bkt->avg / 10;
>>>+        burst_bucket_size = 0;
>>
>> Might be wrong, but shouldn't that be
>>     bucket_size = (bkt->avg / 10) * bkt->burst_length?
>>     burst_bucket_size = (bkt->avg / 10) / 10;
>
>if !bkt->max then the user didn't define any bursts, and the I/O is only
>throttled to the rate set in bkt->avg.
>
>>>+    } else {
>>>+        /* If we have a burst limit then we have to wait until all I/O
>>>+         * at burst rate has finished before throttling to bkt->avg */
>>>+        bucket_size = bkt->max * bkt->burst_length;
>>>+        burst_bucket_size = bkt->max / 10;
>>>+    }
>>>+
>>>+    /* If the main bucket is full then we have to wait */
>>>+    extra = bkt->level - bucket_size;
>> because it used to be that if bkt->max is 0 then
>>  extra = bkt->level - (bkt->avg /10) * bkt->burst_length; //fixed value
>>  and now it's
>>  extra = bkt->level - (bkt->avg / 10);
>>
>>  and
>>
>>>     if (extra > 0) {
>>>         return throttle_do_compute_wait(bkt->avg, extra);
>>>     }
>>>
>>>-    /* If the bucket is not full yet we have to make sure that we
>>>-     * fulfill the goal of bkt->max units per second. */
>>>+    /* If the main bucket is not full yet we still have to check the
>>>+     * burst bucket in order to enforce the burst limit */
>>>     if (bkt->burst_length > 1) {
>>>-        /* We use 1/10 of the max value to smooth the throttling.
>>>-         * See throttle_fix_bucket() for more details. */
>>>-        extra = bkt->burst_level - bkt->max / 10;
>>>+        extra = bkt->burst_level - burst_bucket_size;
>> This used to be
>>
>>     extra = bkt->burst_level - (bkt->avg / 10) / 10;
>> and now it's
>>     extra = bkt->burst_level  - 0;
>
>No, if bkt->burst_length > 1 then bkt->max != 0, and therefore
>burst_bucket_size is never 0 either.
>
>Perhaps you missed the ! in the first "if (!bkt->max)" ?

Now it makes sense, thanks :) I reread the patch and you can add

Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

--za4jdb6vtqb2kifq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlma0CgACgkQc2J8L2kN
9xAcFRAApYJlqF+cTtetCVZnse9fJ9GPRo6v1WBN546jFG6e7/6AVrXvjPXaHWVQ
nDrmABAyH1rNf31uT8EHtGw0vVthnf7udC0t19phfzZgPJQIIJSnUtMztKulT8EP
Sok7TNw9VH3MOlNcZvX5Y3vGUorAJQjkXksjHGWfriKgaXcL/r0HJU2G05Y/FI4Y
EfTUWIHX9C2VD7n9vqX0zkzl4LZMsrrEEP0/SoLWrY86g01X4nsLEd7kp77Cggue
h6bvNvaTMjVHTPlsAD/TeJekF9Z9nO1Qu/LbFMCwMIQ7t8FYBJIiJHLB3jJ6ugO1
km87nOnf8Z3NywUPmhIk3wyYNDfbZmzfWVqIyewY7BFVAuH1M0A3ptCmN4/bVctI
mlFzk2pN+ohhSePUhjaWqLqjr2u8xINdpekFgpZVfdI7KezV6bH5RzaC0VBT75aK
6Dkc9ucdSs66BVavoD+BCyjDenbOy7f7obWf7v4dlO6guoPI/cjJhb2FX+JiMP2S
tgkvYsII0q/MHL5S//mMHLH1xtyYmZSfXjNyW812T6ainAdKhgLuu1TN+FIKHVlt
uHvbRyjc14AW/S4ZEwMYt+1NxJF9kc5LUEtZWdBBEkOP1c0GewBpl9SPlNn/FSMv
dHe/YO7KJXB2+s46BoR52eArriCChT9tTyf95ah+wdI9yvP+JTg=
=vCVp
-----END PGP SIGNATURE-----

--za4jdb6vtqb2kifq--
