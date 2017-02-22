Received: from eggs.gnu.org ([2001:4830:134:3::10]:49553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cga8P-0000pI-CB
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cga8O-0000Ey-6k
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:51:21 -0500
References: <20170221024248.11027-1-eblake@redhat.com>
	<20170221024248.11027-8-eblake@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ecab92ba-94d4-7b1d-c854-fa2ff9b93acc@redhat.com>
Date: Wed, 22 Feb 2017 17:51:10 +0100
MIME-Version: 1.0
In-Reply-To: <20170221024248.11027-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 7/8] nbd: Implement NBD_INFO_BLOCK_SIZE
 on server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, den@virtuozzo.com



On 21/02/2017 03:42, Eric Blake wrote:
> +    /* Send NBD_INFO_BLOCK_SIZE always, but tweak the minimum size
> +     * according to whether the client requested it, and according to
> +     * whether this is OPT_INFO or OPT_GO. */
> +    /* minimum - 1 for back-compat, or 512 if client is new enough.
> +     * TODO: consult blk_bs(blk)->request_align? */
> +    sizes[0] = (opt == NBD_OPT_INFO || blocksize) ? BDRV_SECTOR_SIZE : 1;
> +    /* preferred - At least 4096, but larger as appropriate. */
> +    sizes[1] = MAX(blk_get_opt_transfer(exp->blk), 4096);

Can we just say zero if the preferred transfer size is unknown?

Apart from this, it looks good.

Paolo

> +    /* maximum - At most 32M, but smaller as appropriate. */
> +    sizes[2] = MIN(blk_get_max_transfer(exp->blk), NBD_MAX_BUFFER_SIZE);
> +    TRACE("advertising minimum 0x%" PRIx32 ", preferred 0x%" PRIx32
> +          ", maximum 0x%" PRIx32, sizes[0], sizes[1], sizes[2]);
