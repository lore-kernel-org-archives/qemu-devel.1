Received: from eggs.gnu.org ([2001:4830:134:3::10]:46641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fXzPf-0008Be-P6
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 21:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fXzPe-0004TE-Ho
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 21:38:27 -0400
References: <20180626222226.27620-1-jsnow@redhat.com>
	<20180626222226.27620-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <67381f57-d8a6-b8e2-ac70-9e0fa10cbd94@redhat.com>
Date: Tue, 26 Jun 2018 20:38:16 -0500
MIME-Version: 1.0
In-Reply-To: <20180626222226.27620-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] block: allow blockdev-backup from
 any source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 06/26/2018 05:22 PM, John Snow wrote:
> In the case of image fleecing, the node we choose as the source
> for a blockdev-backup is going to be both a root node AND the
> backing node for the exported image. It does not qualify as a root
> image in this case.
> 
> Loosen the restriction.

Did we regress (and if so, when), or has this never worked?  But you are 
right: visually, we are starting with:

                   Device
Base (backing) <- Top (active)

then want to add nodes for an NBD export:
                   Device    NBD
Base (backing) <- Top    <- Tmp

with a blockdev-backup "sync":"none" from Top to Tmp (any writes from 
the Device first copy the old data to Tmp; the NBD export sees a 
read-only view of Tmp that is unchanging from the time the backup job 
started, regardless of what the Device does in the meantime).

Then when the fleece job ends, the NBD export is stopped, the 
blockdev-backup job is canceled, and Tmp is thrown away as unneeded.

> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 58d7570932..526f8b60be 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3517,7 +3517,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
>           backup->compress = false;
>       }
>   
> -    bs = qmp_get_root_bs(backup->device, errp);
> +    bs = bdrv_lookup_bs(backup->device, backup->device, errp);

Reviewed-by: Eric Blake <eblake@redhat.com>

>       if (!bs) {
>           return NULL;
>       }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
