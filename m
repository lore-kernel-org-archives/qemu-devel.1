Received: from eggs.gnu.org ([2001:4830:134:3::10]:52571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDVw1-0001NA-A9
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDVvw-0001j6-DF
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:02:41 -0400
Received: from mail-co1nam03on0132.outbound.protection.outlook.com
	([104.47.40.132]:55072
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dDVvv-0001cg-Ut
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:02:36 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 24 May 2017 13:02:25 +0000
Message-ID: <140B898B-D9A0-4123-B3C0-1A3C7BA48584@nutanix.com>
References: <1495231142-19055-1-git-send-email-felipe@nutanix.com>
	<20170523042702.GC3873@pxdev.xzpeter.org>
In-Reply-To: <20170523042702.GC3873@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2ACEC30906C56C419B0A2CB09112190C@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] migration: keep bytes_xfer_prev init'd to
 zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> On 23 May 2017, at 05:27, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Fri, May 19, 2017 at 10:59:02PM +0100, Felipe Franciosi wrote:
>> The first time migration_bitmap_sync() is called, bytes_xfer_prev is set
>> to ram_state.bytes_transferred which is, at this point, zero. The next
>> time migration_bitmap_sync() is called, an iteration has happened and
>> bytes_xfer_prev is set to 'x' bytes. Most likely, more than one second
>> has passed, so the auto converge logic will be triggered and
>> bytes_xfer_now will also be set to 'x' bytes.
>>=20
>> This condition is currently masked by dirty_rate_high_cnt, which will
>> wait for a few iterations before throttling. It would otherwise always
>> assume zero bytes have been copied and therefore throttle the guest
>> (possibly) prematurely.
>>=20
>> Given bytes_xfer_prev is only used by the auto convergence logic, it
>> makes sense to only set its value after a check has been made against
>> bytes_xfer_now.
>>=20
>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>> ~
>> ---
>> migration/ram.c | 4 ----
>> 1 file changed, 4 deletions(-)
>>=20
>> diff --git a/migration/ram.c b/migration/ram.c
>> index f59fdd4..793af39 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -670,10 +670,6 @@ static void migration_bitmap_sync(RAMState *rs)
>>=20
>>     rs->bitmap_sync_count++;
>>=20
>> -    if (!rs->bytes_xfer_prev) {
>> -        rs->bytes_xfer_prev =3D ram_bytes_transferred();
>> -    }
>> -
>>     if (!rs->time_last_bitmap_sync) {
>>         rs->time_last_bitmap_sync =3D qemu_clock_get_ms(QEMU_CLOCK_REALT=
IME);
>>     }
>> --=20
>> 1.9.5
>>=20
>>=20
>=20
> I feel like this patch wants to correctly initialize bytes_xfer_prev,
> however I still see problem. E.g., when user specify auto-convergence
> during migration, and in the first iteration we'll always have a very
> small bytes_xfer_prev (with this patch, it'll be zero) with a very big
> bytes_xfer_now (which is the ram_bytes_transferred() value).

Interesting point. Worth noting, that's no different than what happens toda=
y anyway (bytes_xfer_prev would be initialised to the first non-zero bytes_=
transferred). I therefore don't think it should stop or slow this patch's a=
cceptance.

> If so, do
> you think squash below change together with current one would be more
> accurate?

As a matter of fact I had a different idea (below) to fix what you are desc=
ribing. I was still experimenting with this code, so haven't sent a patch y=
et. But I'm going to send a series soon for comments. Basically, I think so=
me other changes are required to make sure these numbers are correct:

1) dirty_rate_high_cnt++ >=3D 2 should be ++dirty_rate_high_cnt >=3D 2
- The original commit msg from 070afca25 (Jason J. Herne) says that converg=
ence should be triggered after two passes. Current code does it after three=
 passes (and four passes the first time around; see number 2 below).
- I personally feel this counter should go away altogether. If the migratio=
n is not converging and the VM is going to be throttled, there's no point s=
tressing the network any further; just start throttling straight away.

2) dirty_pages_rate should be updated before the autoconverge logic.
- Right now, we delay throttling by a further iteration, as dirty_pages_rat=
e is set after the first pass through the autoconverge logic (it is zero th=
e first time around).
- The "if (rs->dirty_pages_rate &&..." part of the conditional can then be =
removed, as it won't ever be zero.

3) bytes_xfer counters should be updated alongside dirty_pages counters (fo=
r the same period).
- This fixes the issue you described, as bytes_xfer_* will correspond to th=
e period.

I'll send the series shortly. Thoughts in the meantime?

Thanks,
Felipe

>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index f59fdd4..e01a218 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -703,7 +703,8 @@ static void migration_bitmap_sync(RAMState *rs)
>                throttling */
>             bytes_xfer_now =3D ram_bytes_transferred();
>=20
> -            if (rs->dirty_pages_rate &&
> +            /* Skip first iteration when bytes_xfer_prev not inited */
> +            if (rs->bytes_xfer_prev && rs->dirty_pages_rate &&
>                (rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
>                    (bytes_xfer_now - rs->bytes_xfer_prev) / 2) &&
>                (rs->dirty_rate_high_cnt++ >=3D 2)) {
>=20
> Even I am not sure whether we can move bytes_xfer_prev out of RAMState
> since it's only used by migration_bitmap_sync().
>=20
> Thanks,
>=20
> --=20
> Peter Xu
