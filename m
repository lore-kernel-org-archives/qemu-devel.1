Received: from eggs.gnu.org ([2001:4830:134:3::10]:49183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLDr9-000854-7o
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLDr8-0007uw-Ch
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:26:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180522201056.1442-1-pbonzini@redhat.com>
	<20180522201056.1442-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4c18115c-1b9a-e071-0b28-71fb721667f9@amsat.org>
Date: Tue, 22 May 2018 17:25:45 -0300
MIME-Version: 1.0
In-Reply-To: <20180522201056.1442-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] sheepdog: cleanup repeated expression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jcody@redhat.com, qemu-block@nongnu.org

On 05/22/2018 05:10 PM, Paolo Bonzini wrote:
> The expression "SD_INODE_SIZE - sizeof(inode.data_vdi_id)" already has a macro
> defined for the same value (though with a nicer definition using offsetof).
> Replace it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  block/sheepdog.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 4237132419..23cf5a8430 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -2337,7 +2337,7 @@ static int sd_truncate(BlockDriverState *bs, int64_t offset,
>      }
>  
>      /* we don't need to update entire object */
> -    datalen = SD_INODE_SIZE - sizeof(s->inode.data_vdi_id);
> +    datalen = SD_INODE_HEADER_SIZE;
>      s->inode.vdi_size = offset;
>      ret = write_object(fd, s->bs, (char *)&s->inode,
>                         vid_to_vdi_oid(s->inode.vdi_id), s->inode.nr_copies,
> @@ -2705,7 +2705,7 @@ static int sd_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
>       */
>      strncpy(s->inode.tag, sn_info->name, sizeof(s->inode.tag));
>      /* we don't need to update entire object */
> -    datalen = SD_INODE_SIZE - sizeof(s->inode.data_vdi_id);
> +    datalen = SD_INODE_HEADER_SIZE;
>      inode = g_malloc(datalen);
>  
>      /* refresh inode. */
> @@ -2991,7 +2991,7 @@ static int sd_snapshot_list(BlockDriverState *bs, QEMUSnapshotInfo **psn_tab)
>          /* we don't need to read entire object */
>          ret = read_object(fd, s->bs, (char *)&inode,
>                            vid_to_vdi_oid(vid),
> -                          0, SD_INODE_SIZE - sizeof(inode.data_vdi_id), 0,
> +                          0, SD_INODE_HEADER_SIZE, 0,
>                            s->cache_flags);
>  
>          if (ret) {
> 
