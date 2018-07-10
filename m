Received: from eggs.gnu.org ([2001:4830:134:3::10]:59894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcttq-0003Ui-Q7
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcttp-0002Pz-Rk
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:45:54 -0400
Date: Tue, 10 Jul 2018 16:45:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180710144543.GK5852@localhost.localdomain>
References: <20180710063124.2263-1-famz@redhat.com>
	<20180710063124.2263-8-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710063124.2263-8-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/10] block: Use common req handling
 for discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 10.07.2018 um 08:31 hat Fam Zheng geschrieben:
> Reuse the new bdrv_co_write_req_prepare/finish helpers. The variation
> here is that discard requests don't affect bs->wr_highest_offset, and it
> cannot extend the image.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/io.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 10a475302a..cc426bab2e 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1601,15 +1601,31 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, uint64_t bytes,
>  
>      atomic_inc(&bs->write_gen);
>  
> -    stat64_max(&bs->wr_highest_offset, offset + bytes);
> -
> +    /* Discard cannot extend the image, but in error handling cases, such as
> +     * when reverting a qcow2 cluster allocation, the discarded range can pass
> +     * the end of image file, so we cannot assert about BDRV_TRACKED_DISCARD
> +     * here. Instead, just skip it, since semantically a discard request
> +     * beyond EOF cannot expand the image anyway.
> +     * */

Oh, yet another style for the end of a multiline comment. :-)

I'll fix this while applying.

Kevin
