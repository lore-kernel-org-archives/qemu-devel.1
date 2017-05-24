Received: from eggs.gnu.org ([2001:4830:134:3::10]:33545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDZGc-0001Ig-Ia
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDZGZ-0005LV-TC
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:36:10 -0400
Received: from mail-bn3nam01on0125.outbound.protection.outlook.com
	([104.47.33.125]:20185
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dDZGZ-0005Kh-Ih
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:36:07 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 24 May 2017 16:36:02 +0000
Message-ID: <6FADC273-B99C-432E-8ACD-DF679896DE92@nutanix.com>
References: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
	<1495642203-12702-5-git-send-email-felipe@nutanix.com>
	<20170524162512.GL18771@redhat.com>
In-Reply-To: <20170524162512.GL18771@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FA22D13A03DD5E47B5E48376A8090D6D@namprd02.prod.outlook.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, "Jason
	J. Herne" <jjherne@linux.vnet.ibm.com>, amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> On 24 May 2017, at 17:25, Daniel P. Berrange <berrange@redhat.com> wrote:
>=20
> On Wed, May 24, 2017 at 05:10:03PM +0100, Felipe Franciosi wrote:
>> The commit message from 070afca25 suggests that dirty_rate_high_cnt
>> should be used more aggressively to start throttling after two
>> iterations instead of four. The code, however, only changes the auto
>> convergence behaviour to throttle after three iterations. This makes the
>> behaviour more aggressive by kicking off throttling after two iterations
>> as originally intended.
>=20
> This description looks suspect vs the code. You say it is changing
> from "after four" to "after two", but you are merely switching a
> post-increment to a pre-increment which can only reduce the boundary
> condition by 1, not 2. So either you mean to write
>=20
> "after two iterations instead of three"=20
>=20
> or
>=20
> "after three iterations intead of four"

Hi Daniel,

Thanks for the quick feedback. Let me clarify what I meant. If there's stil=
l confusion I'll update the commit message to reflect it better.

Pre-070afca25: throttling kicked in after four iterations.
Post-070afca25: throttling kicked in after three iterations (but Jason wrot=
e he meant to start throttling after two).
This patch: throttles kicks in after two iterations (so Jason's code, minus=
 one).

Perhaps where I said "The code, however," I could say "Commit 070afca25, ho=
wever,". Let me know.

Thanks,
Felipe

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
>>=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
