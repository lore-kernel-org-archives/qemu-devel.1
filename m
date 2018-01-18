Received: from eggs.gnu.org ([2001:4830:134:3::10]:59331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec910-0004un-Fa
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:09:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec90z-0004Dk-Mj
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:09:54 -0500
References: <20180118115158.17219-1-edgar.kaziakhmedov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b55edad-f820-6898-1630-ccc76e6c4845@redhat.com>
Date: Thu, 18 Jan 2018 13:09:42 +0100
MIME-Version: 1.0
In-Reply-To: <20180118115158.17219-1-edgar.kaziakhmedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] nbd: implement bdrv_get_info callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

On 18/01/2018 12:51, Edgar Kaziakhmedov wrote:
> 
> +static int nbd_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
> +{
> +    if (bs->supported_zero_flags & BDRV_REQ_MAY_UNMAP) {
> +        bdi->can_write_zeroes_with_unmap = true;
> +    }
> +    return 0;
> +}
> +

Other drivers set the flag always, while NBD only sets it if the server
knows the flag.

I think NBD is more correct, so:

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

However, it would be nice to remove can_write_zeroes_with_unmap from
BlockDriverInfo, and make bdrv_can_write_zeroes_with_unmap just return
!!(bs->supported_zero_flags & BDRV_REQ_MAY_UNMAP).  Kevin, what do you
think?

Paolo
