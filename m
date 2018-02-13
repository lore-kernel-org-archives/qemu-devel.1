Received: from eggs.gnu.org ([2001:4830:134:3::10]:41067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elc8D-0003QQ-SO
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elc88-0004HR-6s
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:04:29 -0500
References: <20180213130356.8885-1-mreitz@redhat.com>
	<20180213130356.8885-7-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf073a56-441c-47fc-104a-72bd993e08db@redhat.com>
Date: Tue, 13 Feb 2018 09:04:12 -0600
MIME-Version: 1.0
In-Reply-To: <20180213130356.8885-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] sheepdog: Pass old and new size to
 sd_prealloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, sheepdog@lists.wpkg.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Liu Yuan <namei.unix@gmail.com>

On 02/13/2018 07:03 AM, Max Reitz wrote:
> sd_prealloc() will now preallocate the area [old_size, new_size).  As
> before, it rounds to buf_size and may thus overshoot and preallocate
> areas that were not requested to be preallocated.  For image creation,
> this is no change in behavior.  For truncation, this is in accordance
> with the documentation for preallocated truncation.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/sheepdog.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
> 

> @@ -1847,19 +1847,13 @@ static int sd_prealloc(BlockDriverState *bs, Error **errp)
>   
>       blk_set_allow_write_beyond_eof(blk, true);
>   
> -    vdi_size = blk_getlength(blk);
> -    if (vdi_size < 0) {
> -        ret = vdi_size;
> -        goto out;
> -    }
> -

> @@ -2119,7 +2113,7 @@ static int sd_create(const char *filename, QemuOpts *opts,
>               goto out;
>           }
>   
> -        ret = sd_prealloc(bs, errp);
> +        ret = sd_prealloc(bs, 0, s->inode.vdi_size, errp);

Nice - you also got rid of a potential failure in blk_getlength().

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
