Received: from eggs.gnu.org ([2001:4830:134:3::10]:36002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbYef-0006bh-1X
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 17:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbYee-0003y5-51
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 17:52:41 -0400
References: <20180705074638.770905-1-vsementsov@virtuozzo.com>
	<20180705074638.770905-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <435d60d6-bf7e-1ec0-7d2e-89d267359f15@redhat.com>
Date: Fri, 6 Jul 2018 16:52:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180705074638.770905-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/4] block: add BDRV_REQ_SERIALISING flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, ronniesahlberg@gmail.com, jcody@redhat.com, pl@kamp.de, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com

On 07/05/2018 02:46 AM, Vladimir Sementsov-Ogievskiy wrote:
> Serialized writes should be used in copy-on-write of backup(sync=none)
> for image fleecing scheme.
> 
> We need to change an assert in bdrv_aligned_pwritev, added in
> 28de2dcd88de. The assert may fail now, because call to
> wait_serialising_requests here may become first call to it for this
> request with serializing flag set. It occurs if the request is aligned
> (otherwise, we should already set serializing flag before calling
> bdrv_aligned_pwritev and correspondingly waited for all intersecting
> requests). However, for aligned requests, we should not care about
> outdating of previously read data, as there no such data. Therefore,
> let's just update an assert to not care about aligned requests.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/block.h | 15 ++++++++++++++-
>   block/io.c            | 26 +++++++++++++++++++++++++-
>   2 files changed, 39 insertions(+), 2 deletions(-)
> 

Again just grammar suggestions:

> diff --git a/include/block/block.h b/include/block/block.h
> index 478ebc6c6c..fded1b7657 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -71,8 +71,21 @@ typedef enum {
>        * content. */
>       BDRV_REQ_WRITE_UNCHANGED    = 0x40,
>   
> +    /* BDRV_REQ_SERIALISING forces request serializing. Only for writes. 

After comparison with patch 1/4, I'd suggest:

BDRV_REQ_SERIALISING forces request serialisation for writes.

>  Used
> +     * to serialize writes to target in backup process, when source is in
> +     * backing chain of target (image fleecing scheme is example) to avoid a
> +     * possibility for a client, reading from target during backup to read
> +     * updated data from source in case of unhappy race of client-read and
> +     * backup-cow-write.

It is used to ensure that writes to the backing file of a backup process 
target cannot race with a read of the backup target that defers to the 
backing file.


> +     *
> +     * Note, that BDRV_REQ_SERIALISING is _not_ opposite in meaning to
> +     * BDRV_REQ_NO_SERIALISING. May be, better name for the latter is
> +     * _DO_NOT_WAIT_FOR_SERIALISING, but it is too long.

The longer rationale on naming might fit better in the commit comment; 
I'd probably drop this paragraph from the code, But if you keep it, the 
second sentence reads better as:

A more descriptive name for the latter might be 
_DO_NOT_WAIT_FOR_SERIALISING, except that is too long.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
