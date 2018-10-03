Received: from eggs.gnu.org ([2001:4830:134:3::10]:36325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7gUH-0003yh-AL
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7gH4-00028R-M0
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:29:07 -0400
References: <20181002230218.13949-1-jsnow@redhat.com>
	<20181002230218.13949-6-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46167222-a029-6c2d-c5f3-5383b7f4f4f4@redhat.com>
Date: Wed, 3 Oct 2018 07:28:45 -0500
MIME-Version: 1.0
In-Reply-To: <20181002230218.13949-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 10/2/18 6:02 PM, John Snow wrote:
> If the bitmap is frozen, we shouldn't touch it.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockdev.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index d0febfca79..098d4c337f 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3512,10 +3512,10 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
>               bdrv_unref(target_bs);
>               goto out;
>           }
> -        if (bdrv_dirty_bitmap_qmp_locked(bmap)) {
> +        if (bdrv_dirty_bitmap_user_locked(bmap)) {
>               error_setg(errp,
> -                       "Bitmap '%s' is currently locked and cannot be used for "
> -                       "backup", backup->bitmap);
> +                       "Bitmap '%s' is currently in use by another operation"
> +                       " and cannot be used for backup", backup->bitmap);
>               goto out;

Is this right?  Why can we not have two parallel backups utilizing the 
same unchanging locked bitmap as its source?  Of course, to do that, 
we'd need the condition of being locked to be a ref-counter (increment 
for each backup that reuses the bitmap, decrement when the backup 
finishes, and it is unlocked when the counter is 0) rather than a bool. 
So, without that larger refactoring, this is a conservative approach 
that is a little too strict, but allows for a simpler implementation. 
And the user can always work around the limitation by cloning the locked 
bitmap into another temporary bitmap, and starting the second parallel 
backup with the second backup instead of the original.

Weak Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
