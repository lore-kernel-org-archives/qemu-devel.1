Received: from eggs.gnu.org ([2001:4830:134:3::10]:58187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDqM1-0000uo-UV
	for qemu-devel@nongnu.org; Thu, 25 May 2017 06:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDqLy-00074M-OJ
	for qemu-devel@nongnu.org; Thu, 25 May 2017 06:50:53 -0400
Received: from mail-co1nam03on0120.outbound.protection.outlook.com
	([104.47.40.120]:27379
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dDqLy-00074E-8T
	for qemu-devel@nongnu.org; Thu, 25 May 2017 06:50:50 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Thu, 25 May 2017 10:50:46 +0000
Message-ID: <E2C4904B-8E96-413A-95BE-ED3199FA4089@nutanix.com>
References: <1495231142-19055-1-git-send-email-felipe@nutanix.com>
	<20170523042702.GC3873@pxdev.xzpeter.org>
	<140B898B-D9A0-4123-B3C0-1A3C7BA48584@nutanix.com>
	<20170525003609.GO3873@pxdev.xzpeter.org>
In-Reply-To: <20170525003609.GO3873@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7BE8A0EC05E0E49AA10FFEE695EA450@namprd02.prod.outlook.com>
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


> On 25 May 2017, at 01:36, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Wed, May 24, 2017 at 01:02:25PM +0000, Felipe Franciosi wrote:
>>=20
>>> On 23 May 2017, at 05:27, Peter Xu <peterx@redhat.com> wrote:
>>>=20
>>> On Fri, May 19, 2017 at 10:59:02PM +0100, Felipe Franciosi wrote:
>>>> The first time migration_bitmap_sync() is called, bytes_xfer_prev is s=
et
>>>> to ram_state.bytes_transferred which is, at this point, zero. The next
>>>> time migration_bitmap_sync() is called, an iteration has happened and
>>>> bytes_xfer_prev is set to 'x' bytes. Most likely, more than one second
>>>> has passed, so the auto converge logic will be triggered and
>>>> bytes_xfer_now will also be set to 'x' bytes.
>>>>=20
>>>> This condition is currently masked by dirty_rate_high_cnt, which will
>>>> wait for a few iterations before throttling. It would otherwise always
>>>> assume zero bytes have been copied and therefore throttle the guest
>>>> (possibly) prematurely.
>>>>=20
>>>> Given bytes_xfer_prev is only used by the auto convergence logic, it
>>>> makes sense to only set its value after a check has been made against
>>>> bytes_xfer_now.
>>>>=20
>>>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>>>> ~
>>>> ---
>>>> migration/ram.c | 4 ----
>>>> 1 file changed, 4 deletions(-)
>>>>=20
>>>> diff --git a/migration/ram.c b/migration/ram.c
>>>> index f59fdd4..793af39 100644
>>>> --- a/migration/ram.c
>>>> +++ b/migration/ram.c
>>>> @@ -670,10 +670,6 @@ static void migration_bitmap_sync(RAMState *rs)
>>>>=20
>>>>    rs->bitmap_sync_count++;
>>>>=20
>>>> -    if (!rs->bytes_xfer_prev) {
>>>> -        rs->bytes_xfer_prev =3D ram_bytes_transferred();
>>>> -    }
>>>> -
>>>>    if (!rs->time_last_bitmap_sync) {
>>>>        rs->time_last_bitmap_sync =3D qemu_clock_get_ms(QEMU_CLOCK_REAL=
TIME);
>>>>    }
>>>> --=20
>>>> 1.9.5
>>>>=20
>>>>=20
>>>=20
>>> I feel like this patch wants to correctly initialize bytes_xfer_prev,
>>> however I still see problem. E.g., when user specify auto-convergence
>>> during migration, and in the first iteration we'll always have a very
>>> small bytes_xfer_prev (with this patch, it'll be zero) with a very big
>>> bytes_xfer_now (which is the ram_bytes_transferred() value).
>>=20
>> Interesting point. Worth noting, that's no different than what happens t=
oday anyway (bytes_xfer_prev would be initialised to the first non-zero byt=
es_transferred). I therefore don't think it should stop or slow this patch'=
s acceptance.
>>=20
>>> If so, do
>>> you think squash below change together with current one would be more
>>> accurate?
>>=20
>> As a matter of fact I had a different idea (below) to fix what you are d=
escribing. I was still experimenting with this code, so haven't sent a patc=
h yet. But I'm going to send a series soon for comments. Basically, I think=
 some other changes are required to make sure these numbers are correct:
>=20
> I agree on most points.
>=20
>>=20
>> 1) dirty_rate_high_cnt++ >=3D 2 should be ++dirty_rate_high_cnt >=3D 2
>> - The original commit msg from 070afca25 (Jason J. Herne) says that conv=
ergence should be triggered after two passes. Current code does it after th=
ree passes (and four passes the first time around; see number 2 below).
>> - I personally feel this counter should go away altogether. If the migra=
tion is not converging and the VM is going to be throttled, there's no poin=
t stressing the network any further; just start throttling straight away.
>>=20
>> 2) dirty_pages_rate should be updated before the autoconverge logic.
>> - Right now, we delay throttling by a further iteration, as dirty_pages_=
rate is set after the first pass through the autoconverge logic (it is zero=
 the first time around).
>> - The "if (rs->dirty_pages_rate &&..." part of the conditional can then =
be removed, as it won't ever be zero.
>=20
> For this one: why dirty_pages_rate cannot be zero?

Yeah good point. If _nothing_ got dirtied in the period (possible I suppose=
), then the dirty rate would be zero.

> But I agree with
> you that it can be removed since even if it's zero, then the next
> check would fail as well (rs->num_dirty_pages_period *
> TARGET_PAGE_SIZE > (bytes_xfer_now - rs->bytes_xfer_prev) / 2).

Exactly. I suppose that check was introduced to consider the first iteratio=
n where the counter hadn't been initialised. But it's not needed.

>=20
>>=20
>> 3) bytes_xfer counters should be updated alongside dirty_pages counters =
(for the same period).
>> - This fixes the issue you described, as bytes_xfer_* will correspond to=
 the period.
>>=20
>> I'll send the series shortly. Thoughts in the meantime?
>=20
> I'll reply to that patchset then. Thanks.

Thanks for the quick feedback on this. I've included this change on the pat=
chset, so let's continue the conversation there.

Felipe

>=20
> --=20
> Peter Xu
