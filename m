Received: from eggs.gnu.org ([2001:4830:134:3::10]:53166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7kFt-000341-D5
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 12:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7kFm-0006Lw-Gu
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 12:44:08 -0400
References: <20181002230218.13949-1-jsnow@redhat.com>
	<20181002230218.13949-6-jsnow@redhat.com>
	<46167222-a029-6c2d-c5f3-5383b7f4f4f4@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <be1e6ca3-a94e-eb4d-920c-5f5813a79b33@redhat.com>
Date: Wed, 3 Oct 2018 12:43:36 -0400
MIME-Version: 1.0
In-Reply-To: <46167222-a029-6c2d-c5f3-5383b7f4f4f4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 5/6] block/backup: prohibit backup from
 using in use bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 10/03/2018 08:28 AM, Eric Blake wrote:
> On 10/2/18 6:02 PM, John Snow wrote:
>> If the bitmap is frozen, we shouldn't touch it.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 blockdev.c | 12 ++++++------
>> =C2=A0 1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index d0febfca79..098d4c337f 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -3512,10 +3512,10 @@ static BlockJob *do_drive_backup(DriveBackup
>> *backup, JobTxn *txn,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bdrv_unref(target_bs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_qmp_=
locked(bmap)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_user=
_locked(bmap)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_setg(errp,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Bitmap '=
%s' is currently locked and cannot be
>> used for "
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "backup",=
 backup->bitmap);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Bitmap '=
%s' is currently in use by another
>> operation"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " and can=
not be used for backup",
>> backup->bitmap);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
>=20
> Is this right?=C2=A0 Why can we not have two parallel backups utilizing=
 the
> same unchanging locked bitmap as its source?=C2=A0 Of course, to do tha=
t,
> we'd need the condition of being locked to be a ref-counter (increment
> for each backup that reuses the bitmap, decrement when the backup
> finishes, and it is unlocked when the counter is 0) rather than a bool.
> So, without that larger refactoring, this is a conservative approach
> that is a little too strict, but allows for a simpler implementation.
> And the user can always work around the limitation by cloning the locke=
d
> bitmap into another temporary bitmap, and starting the second parallel
> backup with the second backup instead of the original.
>=20
> Weak Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Vladimir gave a good recounting of the reasons. My principal
justification here is that:

- FROZEN implies that the bitmap has been split; which means there is a
pending operating to re-suture them into one bitmap which may occur at
an indeterminate time in the future that we cannot account for in the
following job code, and

- QMP_LOCKED only implies that the bitmap is in use by, say, the NBD
fleecing operation with no further pending actions.

Here, in do_drive_backup, we check only that we are not qmp_locked, but
I argue we ought to check against frozen as well. It's likely to fail
because the BDS is already in use by another job, but this check is
strictly more correct.

In the opposite case, we don't want to split a bitmap that is being used
by someone else -- we're about to fork this bitmap (which means that the
bitmap referenced by this named handle will be CLEARED) which can alter
what the NBD process is doing, which is also bad.

For now, this is correct.

--js
