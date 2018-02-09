Received: from eggs.gnu.org ([2001:4830:134:3::10]:36419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ekHm8-0003Ko-AI
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 18:08:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ekHm7-00079A-EH
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 18:08:12 -0500
References: <20180207162920.28386-1-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <84467de4-5563-8293-9838-a5d48878597f@redhat.com>
Date: Fri, 9 Feb 2018 18:07:49 -0500
MIME-Version: 1.0
In-Reply-To: <20180207162920.28386-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: early check for blockers on
 drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org



On 02/07/2018 11:29 AM, Paolo Bonzini wrote:
> Even if an op blocker is present for BLOCK_OP_TYPE_MIRROR_SOURCE,
> it is checked a bit late and the result is that the target is
> created even if drive-mirror subsequently fails.  Add an early
> check to avoid this.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockdev.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 8e977eef11..c7e2e0a00e 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3565,6 +3565,11 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>          return;
>      }
>  
> +    /* Early check to avoid creating target */
> +    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_MIRROR_SOURCE, errp)) {
> +        return;
> +    }
> +
>      aio_context = bdrv_get_aio_context(bs);
>      aio_context_acquire(aio_context);
>  
> 

What's the implication of the temporarily-extant target node that it
needs to be avoided so strictly?
