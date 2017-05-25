Received: from eggs.gnu.org ([2001:4830:134:3::10]:58694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDqNk-0002UF-GJ
	for qemu-devel@nongnu.org; Thu, 25 May 2017 06:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDqNh-0007Nu-Fp
	for qemu-devel@nongnu.org; Thu, 25 May 2017 06:52:40 -0400
Received: from mail-bn3nam01on0115.outbound.protection.outlook.com
	([104.47.33.115]:55331
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dDqNh-0007Nb-9j
	for qemu-devel@nongnu.org; Thu, 25 May 2017 06:52:37 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Thu, 25 May 2017 10:52:32 +0000
Message-ID: <3F052E47-5144-411B-BBEF-03C0E4D872B7@nutanix.com>
References: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
	<1495642203-12702-3-git-send-email-felipe@nutanix.com>
	<20170525004007.GP3873@pxdev.xzpeter.org>
In-Reply-To: <20170525004007.GP3873@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8DC80C6EBAC391478696F052B1CED154@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/4] migration: set dirty_pages_rate before
 autoconverge logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, amit Shah <amit.shah@redhat.com>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> On 25 May 2017, at 01:40, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Wed, May 24, 2017 at 05:10:01PM +0100, Felipe Franciosi wrote:
>> Currently, a "period" in the RAM migration logic is at least a second
>> long and accounts for what happened since the last period (or the
>> beginning of the migration). The dirty_pages_rate counter is calculated
>> at the end this logic.
>>=20
>> If the auto convergence capability is enabled from the start of the
>> migration, it won't be able to use this counter the first time around.
>> This calculates dirty_pages_rate as soon as a period is deemed over,
>> which allows for it to be used immediately.
>>=20
>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>=20
> You fixed the indents as well, but imho it's okay.

Yeah a couple of lines were off-by-one space. Fixed it given I was touching=
 the code anyway, hope it's ok with everyone else. Would you normally patch=
 that separately or just mention it in the commit message?

F.

>=20
> Reviewed-by: Peter Xu <peterx@redhat.com>
>=20
>> ---
>> migration/ram.c | 17 ++++++++++-------
>> 1 file changed, 10 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 36bf720..495ecbe 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -694,6 +694,10 @@ static void migration_bitmap_sync(RAMState *rs)
>>=20
>>     /* more than 1 second =3D 1000 millisecons */
>>     if (end_time > rs->time_last_bitmap_sync + 1000) {
>> +        /* calculate period counters */
>> +        rs->dirty_pages_rate =3D rs->num_dirty_pages_period * 1000
>> +            / (end_time - rs->time_last_bitmap_sync);
>> +
>>         if (migrate_auto_converge()) {
>>             /* The following detection logic can be refined later. For n=
ow:
>>                Check to see if the dirtied bytes is 50% more than the ap=
prox.
>> @@ -702,15 +706,14 @@ static void migration_bitmap_sync(RAMState *rs)
>>                throttling */
>>             bytes_xfer_now =3D ram_bytes_transferred();
>>=20
>> -            if (rs->dirty_pages_rate &&
>> -               (rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
>> +            if ((rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
>>                    (bytes_xfer_now - rs->bytes_xfer_prev) / 2) &&
>> -               (rs->dirty_rate_high_cnt++ >=3D 2)) {
>> +                (rs->dirty_rate_high_cnt++ >=3D 2)) {
>>                     trace_migration_throttle();
>>                     rs->dirty_rate_high_cnt =3D 0;
>>                     mig_throttle_guest_down();
>> -             }
>> -             rs->bytes_xfer_prev =3D bytes_xfer_now;
>> +            }
>> +            rs->bytes_xfer_prev =3D bytes_xfer_now;
>>         }
>>=20
>>         if (migrate_use_xbzrle()) {
>> @@ -723,8 +726,8 @@ static void migration_bitmap_sync(RAMState *rs)
>>             rs->iterations_prev =3D rs->iterations;
>>             rs->xbzrle_cache_miss_prev =3D rs->xbzrle_cache_miss;
>>         }
>> -        rs->dirty_pages_rate =3D rs->num_dirty_pages_period * 1000
>> -            / (end_time - rs->time_last_bitmap_sync);
>> +
>> +        /* reset period counters */
>>         rs->time_last_bitmap_sync =3D end_time;
>>         rs->num_dirty_pages_period =3D 0;
>>     }
>> --=20
>> 1.9.5
>>=20
>=20
> --=20
> Peter Xu
