Received: from eggs.gnu.org ([2001:4830:134:3::10]:33445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbYLo-00015O-Ep
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 17:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbYLn-0005CV-CR
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 17:33:12 -0400
References: <20180705074638.770905-1-vsementsov@virtuozzo.com>
	<20180705074638.770905-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2da7c234-6157-18d5-139b-2d4d5480c6b9@redhat.com>
Date: Fri, 6 Jul 2018 16:32:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180705074638.770905-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/4] block: disallow
 BDRV_REQ_NO_SERIALISING for write
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
> Before commit 9ded4a01149 "backup: Use copy offloading",
> BDRV_REQ_NO_SERIALISING was used for only one case: read in
> copy-on-write operation during backup. Also, the flag was handled only
> on read path (in bdrv_co_preadv and bdrv_aligned_preadv).
> 
> After 9ded4a01149, flag is used for not waiting serializing operations
> on backup target (in same case of copy-on-write operation). This
> behavior change is unsubstantiated and potentially dangerous, let's
> drop it.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/block.h | 13 +++++++++++++
>   block/io.c            |  7 ++++++-
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 

Commenting only on the grammar:

> diff --git a/include/block/block.h b/include/block/block.h
> index e5c7759a0c..a06a4d27de 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -50,6 +50,19 @@ typedef enum {
>        * opened with BDRV_O_UNMAP.
>        */
>       BDRV_REQ_MAY_UNMAP          = 0x4,
> +
> +    /* The BDRV_REQ_NO_SERIALISING means that we don't want to
> +     * wait_serialising_requests(), when reading.

Either:

/* BDRV_REQ_NO_SERALISING means that...

or

/* The BDRV_REQ_NO_SERIALISING flag means that...

s/want to/want/

> +     *
> +     * This flag is used for backup copy on write operation, when we need to
> +     * read old data before write (write notifier triggered). It is ok, due to
> +     * we already waited for serializing requests in initiative write (see
> +     * bdrv_aligned_pwritev), and it is necessary for the case when initiative
> +     * write is serializing itself (we'll dead lock waiting it).

It is okay since we already waited for other serializing requests in the 
initiating write (see bdrv_aligned_pwritev), and it is necessary since 
the initiating write is already serializing (without the flag, the read 
would deadlock waiting for the write to complete).

> +     *
> +     * The described case is the only usage for the flag for now, so, it is
> +     * supported only for read operation and restricted for write.

This last sentence is rather wordy; I'm fine with just:

The flag is only valid during read operations.

> +     */
>       BDRV_REQ_NO_SERIALISING     = 0x8,
>       BDRV_REQ_FUA                = 0x10,
>       BDRV_REQ_WRITE_COMPRESSED   = 0x20,

We're inconsistent on which flags we document; it might be nice to have 
a comment for each of them.  But not necessarily this patch's problem.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
