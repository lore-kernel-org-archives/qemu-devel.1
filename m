Received: from eggs.gnu.org ([2001:4830:134:3::10]:48300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDekK-0005Ll-8t
	for qemu-devel@nongnu.org; Tue, 01 May 2018 19:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDekJ-0001em-BU
	for qemu-devel@nongnu.org; Tue, 01 May 2018 19:31:44 -0400
References: <20180501220509.14152-1-mreitz@redhat.com>
	<20180501220509.14152-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b61ec864-3f92-d945-af4b-d14260f23ce9@redhat.com>
Date: Tue, 1 May 2018 18:31:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180501220509.14152-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] block/mirror: Make cancel always
 cancel pre-READY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

On 05/01/2018 05:05 PM, Max Reitz wrote:
> Commit b76e4458b1eb3c32e9824fe6aa51f67d2b251748 made the mirror block
> job respect block-job-cancel's @force flag: With that flag set, it would
> now always really cancel, even post-READY.
> 
> Unfortunately, it had a side effect: Without that flag set, it would now
> never cancel, not even before READY.  Considering that is an
> incompatible change and not noted anywhere in the commit or the
> description of block-job-cancel's @force parameter, this seems
> unintentional and we should revert to the previous behavior, which is to
> immediately cancel the job when block-job-cancel is called before source
> and target are in sync (i.e. before the READY event).
> 
> Cc: qemu-stable@nongnu.org

Actually adding that in cc on this reply.

> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1572856
> Reported-by: Yanan Fu <yfu@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/mirror.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 7bfad6e844..003f957b12 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -874,7 +874,9 @@ static void coroutine_fn mirror_run(void *opaque)
>           }
>           trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
>           block_job_sleep_ns(&s->common, delay_ns);
> -        if (block_job_is_cancelled(&s->common) && s->common.force) {
> +        if (block_job_is_cancelled(&s->common) &&
> +            (!s->synced || s->common.force))
> +        {
>               break;
>           }
>           s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
