Received: from eggs.gnu.org ([2001:4830:134:3::10]:35981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8iuU-0004Q3-JX
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8iuT-0000ZQ-Mm
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:53:18 -0400
References: <20170510173945.11819-1-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca329f38-fbdd-0768-a8f9-115412be8c68@redhat.com>
Date: Thu, 11 May 2017 09:53:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170510173945.11819-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] blockdev: use drained_begin/end for
 qmp_block_resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, stefanha@redhat.com, mreitz@redhat.com



On 10/05/2017 19:39, John Snow wrote:
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1447551
> 
> If one tries to issue a block_resize while a guest is busy
> accessing the disk, it is possible that qemu may deadlock
> when invoking aio_poll from both the main loop and the iothread.
> 
> Replace another instance of bdrv_drain_all that doesn't
> quite belong.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 0b38c3d..9ff06f3 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2923,10 +2923,9 @@ void qmp_block_resize(bool has_device, const char *device,
>          goto out;
>      }
>  
> -    /* complete all in-flight operations before resizing the device */
> -    bdrv_drain_all();
> -
> +    bdrv_drained_begin(bs);
>      ret = blk_truncate(blk, size, errp);
> +    bdrv_drained_end(bs);
>  
>  out:
>      blk_unref(blk);
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
