Received: from eggs.gnu.org ([2001:4830:134:3::10]:55472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgrce-0003oQ-CR
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgrcd-0008UP-IT
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:31:44 -0500
Date: Thu, 23 Feb 2017 19:31:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170223113134.GD14175@lemon.lan>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-4-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487689130-30373-4-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/54] mirror: Resize active commit base in
 mirror_run()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On Tue, 02/21 15:57, Kevin Wolf wrote:
> diff --git a/block/mirror.c b/block/mirror.c
> index 698a54e..13f793e 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -657,7 +657,28 @@ static void coroutine_fn mirror_run(void *opaque)
>      if (s->bdev_length < 0) {
>          ret = s->bdev_length;
>          goto immediate_exit;
> -    } else if (s->bdev_length == 0) {
> +    }
> +
> +    /* Active commit must resize the base image if its size differs from the
> +     * active layer. */
> +    if (s->base == blk_bs(s->target)) {
> +        int64_t base_length;
> +
> +        base_length = blk_getlength(s->target);
> +        if (base_length < 0) {
> +            ret = base_length;
> +            goto immediate_exit;
> +        }
> +
> +        if (s->bdev_length > base_length) {
> +            ret = blk_truncate(s->target, s->bdev_length);
> +            if (ret < 0) {
> +                goto immediate_exit;
> +            }
> +        }
> +    }
> +
> +    if (s->bdev_length == 0) {
>          /* Report BLOCK_JOB_READY and wait for complete. */
>          block_job_event_ready(&s->common);
>          s->synced = true;

This has a slight behavior change of commit job that previously upon resize
failure the job wouldn't start, but now it will, then immediately end with an
error. Not an problem, though.

Fam
