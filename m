Received: from eggs.gnu.org ([2001:4830:134:3::10]:51178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejo7x-0007eV-9H
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejo7w-00011i-86
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:28:45 -0500
From: Eric Blake <eblake@redhat.com>
References: <20180208132336.6519-1-edgar.kaziakhmedov@virtuozzo.com>
Message-ID: <8eb7f38c-ff46-df7d-1d43-d5c98bfd4ff2@redhat.com>
Date: Thu, 8 Feb 2018 09:28:36 -0600
MIME-Version: 1.0
In-Reply-To: <20180208132336.6519-1-edgar.kaziakhmedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] nbd: increase maximum size of the
 PWRITE_ZERO request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, nbd list <nbd@other.debian.org>, vsementsov@virtuozzo.com, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com

[resending with correct NBD list address]

On 02/08/2018 07:23 AM, Edgar Kaziakhmedov wrote:
> Upstream NBD protocol implementation supports an efficient zero out
> mechanism over the wire, along with the ability to check whether a
> client allows using a hole.
> 
> Accordingly, since PWRITE_ZERO doesn't involve any payload on the wire,
> increase a maximum size of the PWRITE_ZERO request up to 1Gb (aligned).
> Moreover, such change will decrease the number of PWRITE_ZERO NBD commands
> in comparison with the current 32M limit. The benefits of
> the larger constraint can be examined in a block mirroring over NBD.

We've got a potential problem.  Unless you have out-of-band 
communication of the maximum NBD_CMD_WRITE_ZEROES sizing (or if the NBD 
protocol is enhanced to advertise that as an additional piece of block 
size information during NBD_OPT_GO), then a client CANNOT assume that 
the server will accept a request this large.  We MIGHT get lucky if all 
existing servers that accept WRITE_ZEROES requests either act on large 
requests or reply with EINVAL but do not outright drop the connection 
(which is different from servers that DO outright drop the connection 
for an NBD_CMD_WRITE larger than 32M).  But I don't know if that's how 
all servers behave, so sending a too-large WRITE_ZEROES request may have 
the unintended consequence of killing the connection.

I'm adding the NBD list; perhaps before accepting this into qemu, I 
should revive my earlier attempt at codifying an NBD_OPT_GO info 
advertisement for maximum trim/zero sizing, which would let clients have 
a guarantee that their choice of sizing won't cause unexpected failures.

> 
> Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
> ---
>   block/nbd.c         | 2 +-
>   include/block/nbd.h | 3 +++
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 94220f6d14..3641d9244e 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -477,7 +477,7 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
>       uint32_t max = MIN_NON_ZERO(NBD_MAX_BUFFER_SIZE, s->info.max_block);
> 
>       bs->bl.max_pdiscard = max;
> -    bs->bl.max_pwrite_zeroes = max;
> +    bs->bl.max_pwrite_zeroes = NBD_MAX_PWRITE_ZERO_SIZE;

max_discard should get the same treatment, whatever we decide (yes, it 
is feasible that a server may have different limits for NBD_CMD_TRIM 
than for NBD_CMD_WRITE_ZEROES, but in general, it's probably easier if 
both commands share theh same limit as both have very similar 
implementations).

>       bs->bl.max_transfer = max;
> 
>       if (s->info.opt_block &&
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index ee74ec391a..e2f18e2332 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -182,6 +182,9 @@ enum {
>   /* Maximum size of a single READ/WRITE data buffer */
>   #define NBD_MAX_BUFFER_SIZE (32 * 1024 * 1024)
> 
> +/* Maximum size of a single PWRITE_ZERO request 1Gb */
> +#define NBD_MAX_PWRITE_ZERO_SIZE (1024 * 1024 * 1024)
> +
>   /* Maximum size of an export name. The NBD spec requires 256 and
>    * suggests that servers support up to 4096, but we stick to only the
>    * required size so that we can stack-allocate the names, and because
> --
> 2.11.0
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
