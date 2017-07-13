Received: from eggs.gnu.org ([2001:4830:134:3::10]:45010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVdeu-0001bi-QA
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVdeu-0001t6-4p
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:55:56 -0400
Date: Thu, 13 Jul 2017 14:55:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170713125546.GB20828@noname.redhat.com>
References: <20170418013356.3578-1-eblake@redhat.com>
	<20170418013356.3578-30-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170418013356.3578-30-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 29/31] vpc: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@nongnu.org, jsnow@redhat.com, Max Reitz <mreitz@redhat.com>

Am 18.04.2017 um 03:33 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the vpc driver accordingly.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

I know this is an old series, but I think you split it for later
versions and there hasn't been a respin of this final part of the series
yet.

When I just told Peter that get_sector_offset() would go away with your
patches, I decided to check whether this was actually true, and found...

>          /* *pnum can't be greater than one block for allocated
>           * sectors since there is always a bitmap in between. */
>          if (allocated) {
>              *file = bs->file->bs;
>              return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | start;
>          }
> -        if (nb_sectors == 0) {
> +        if (bytes == 0) {
>              break;
>          }
> -        offset = get_sector_offset(bs, sector_num, 0);
> +        image_offset = get_sector_offset(bs, offset, 0);
>      } while (offset == -1);

...this bug. I think you want to use get_image_offset() now.

This should also be the last caller of get_sector_offset(), so the
function should go away in this commit.

Kevin
