Received: from eggs.gnu.org ([2001:4830:134:3::10]:40564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb2Fw-0005Dl-JL
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb2Fs-0001qI-G3
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:17:00 -0400
Date: Thu, 5 Jul 2018 13:16:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180705111649.GI3309@localhost.localdomain>
References: <20180705073701.10558-1-famz@redhat.com>
	<20180705073701.10558-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705073701.10558-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/9] block: Use uint64_t for
 BdrvTrackedRequest byte fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 05.07.2018 um 09:36 hat Fam Zheng geschrieben:
> This matches the types used for bytes in the rest parts of block layer.
> In the case of bdrv_co_truncate, new_bytes can be the image size which
> probably doesn't fit in a 32 bit int.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

mark_request_serialising() has this:

    unsigned int overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
                               - overlap_offset;


There is also:

static bool tracked_request_overlaps(BdrvTrackedRequest *req,
                                     int64_t offset, unsigned int bytes)

Don't these need to be uint64_t now as well?

>  block/io.c                | 2 +-
>  include/block/block_int.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 3e00667a2a..443a8584c4 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -587,7 +587,7 @@ static void tracked_request_end(BdrvTrackedRequest *req)
>  static void tracked_request_begin(BdrvTrackedRequest *req,
>                                    BlockDriverState *bs,
>                                    int64_t offset,
> -                                  unsigned int bytes,
> +                                  uint64_t bytes,
>                                    enum BdrvTrackedRequestType type)
>  {
>      *req = (BdrvTrackedRequest){

Should we assert that offset + bytes <= INT64_MAX? We make this
assumption in basically all of the calculations.

Kevin
