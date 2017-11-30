Received: from eggs.gnu.org ([2001:4830:134:3::10]:57222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKoLA-0006gs-DZ
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:39:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKoL9-0004yE-HY
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:39:04 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-4-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <02501491-0802-3888-46c3-3a56c7ebec82@redhat.com>
Date: Thu, 30 Nov 2017 14:40:54 -0600
MIME-Version: 1.0
In-Reply-To: <20171012185916.22776-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 03/20] file-posix: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 10/12/2017 01:58 PM, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the file protocol driver accordingly.
> 
> In want_zero mode, we continue to report fine-grained hole
> information (the caller wants as much mapping detail as possible);
> but when not in that mode, the caller prefers larger *pnum and
> merely cares about what offsets are allocated at this layer, rather
> than where the holes live.  Since holes still read as zeroes at
> this layer (rather than deferring to a backing layer), we can take
> the shortcut of skipping lseek(), and merely state that all bytes
> are allocated.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---

> @@ -2154,39 +2156,46 @@ static int64_t coroutine_fn raw_co_get_block_status(BlockDriverState *bs,
>           return ret;
>       }
> 
> -    start = sector_num * BDRV_SECTOR_SIZE;
>       total_size = bdrv_getlength(bs);
>       if (total_size < 0) {
>           return total_size;
> -    } else if (start >= total_size) {
> +    } else if (offset >= total_size) {
>           *pnum = 0;
>           return 0;
> -    } else if (start + nb_sectors * BDRV_SECTOR_SIZE > total_size) {
> -        nb_sectors = DIV_ROUND_UP(total_size - start, BDRV_SECTOR_SIZE);
> +    } else if (offset + bytes > total_size) {
> +        bytes = total_size - offset;
>       }

I just realized: this is dead code. The block layer already checked 
bdrv_getlength() and clamped values.  So, v5 will trim this and similar 
redundant driver code.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
