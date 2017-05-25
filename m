Received: from eggs.gnu.org ([2001:4830:134:3::10]:35098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDqoO-0004uD-12
	for qemu-devel@nongnu.org; Thu, 25 May 2017 07:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDqoI-0007vM-PY
	for qemu-devel@nongnu.org; Thu, 25 May 2017 07:20:12 -0400
Received: from mail-by2nam01on0101.outbound.protection.outlook.com
	([104.47.34.101]:50922
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dDqoI-0007uU-B0
	for qemu-devel@nongnu.org; Thu, 25 May 2017 07:20:06 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Thu, 25 May 2017 11:20:02 +0000
Message-ID: <EF06A5D3-CEF2-4F56-AC60-6EA2ABFF084A@nutanix.com>
References: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
	<1495642203-12702-5-git-send-email-felipe@nutanix.com>
	<20170525010343.GS3873@pxdev.xzpeter.org>
In-Reply-To: <20170525010343.GS3873@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9756963E6CC41547977EB624B072E2F0@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 4/4] migration: use dirty_rate_high_cnt
 more aggressively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Cc: Juan Quintela <quintela@redhat.com>, amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

+ Matthew Rosato, original reviewer of 070afca25

> On 25 May 2017, at 02:03, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Wed, May 24, 2017 at 05:10:03PM +0100, Felipe Franciosi wrote:
>> The commit message from 070afca25 suggests that dirty_rate_high_cnt
>> should be used more aggressively to start throttling after two
>> iterations instead of four. The code, however, only changes the auto
>> convergence behaviour to throttle after three iterations. This makes the
>> behaviour more aggressive by kicking off throttling after two iterations
>> as originally intended.
>=20
> For this one, I don't think fixing the code to match the commit
> message is that important. Instead, for me this patch looks more like
> something "changed iteration loops from 3 to 2".

I agree. If we decide a v2 is needed I can amend the commit message accordi=
ngly.

> So the point is, what
> would be the best practical number for it. And when we change an
> existing value, we should have some reason, since it'll change
> behavior of existing user (though I'm not sure whether this one will
> affect much).

We've done a few tests with this internally using various workloads (DBs, s=
ynthetic mem stress, &c.). In summary, and along the lines with how Qemu im=
plements auto convergence today, I would say this counter should be removed=
.

Consider that when live migrating a large-ish VM (100GB+ RAM), the network =
will be under stress for (at least) several minutes. At the same time, the =
sole purpose of this counter is to attempt convergence without having to th=
rottle the guest. That is, it defers throttling in the hope that either the=
 guest calms down or that the network gets less congested.

For real workloads, both cases are unlikely to happen. Throttling will even=
tually be needed otherwise the migration will not converge.

> I believe with higher dirty_rate_high_cnt, we have more smooth
> throttling, but it'll be slower in responding; While if lower or even
> remove it, we'll get very fast throttling response speed but I guess
> it may be more possible to report a false positive?

With a higher dirty_rate_high_cnt, migration will simply take longer (if no=
t converging). For real workloads, it doesn't change how much throttling is=
 required. For spiky or varied workloads, it gives a chance for migration t=
o converge without throttling, at the cost of massive network stress and a =
longer overall migration time (which is bad user experience IMO).

> IMHO here 3 is
> okay since after all we are solving the problem of unconverged
> migration, so as long as we can converge, I think it'll be fine.

Based on 070afca25's commit message, Jason seemed to think that four was to=
o much and meant to change it to two. As explained above, I'd be in favour =
of removing this counter altogether, or at least make it configurable (perh=
aps a #define would be enough an improvement for now). This patch is intend=
ed as a compromise by effectively using two.

Great feedback! Thanks again.
Felipe


>=20
> Thanks,
>=20
>>=20
>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>> ---
>> migration/ram.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 1a3d9e6..26e03a5 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -708,7 +708,7 @@ static void migration_bitmap_sync(RAMState *rs)
>>=20
>>             if ((rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
>>                    (bytes_xfer_now - rs->bytes_xfer_prev) / 2) &&
>> -                (rs->dirty_rate_high_cnt++ >=3D 2)) {
>> +                (++rs->dirty_rate_high_cnt >=3D 2)) {
>>                     trace_migration_throttle();
>>                     rs->dirty_rate_high_cnt =3D 0;
>>                     mig_throttle_guest_down();
>> --=20
>> 1.9.5
>>=20
>=20
> --=20
> Peter Xu
