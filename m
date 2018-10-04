Received: from eggs.gnu.org ([2001:4830:134:3::10]:51905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g82mG-0000jE-W2
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g82jJ-0007gq-BB
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:27:47 -0400
References: <20181004100313.4253-1-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <df8c34a4-fef5-a5b5-1e7d-41c638588b5e@redhat.com>
Date: Thu, 4 Oct 2018 07:27:38 -0500
MIME-Version: 1.0
In-Reply-To: <20181004100313.4253-1-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] nbd: fix NBD_CMD_CACHE negitiation
 according to the NBD specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Valery Vdovin <valery.vdovin@acronis.com>, Paolo Bonzini <pbonzini@redhat.com>

On 10/4/18 5:03 AM, Denis V. Lunev wrote:
> Commit bc37b06a5 was made very bad thing, it has been added
> NBD_FLAG_SEND_CACHE flag for negotiation.

Oof. Probably my fault for not doing a careful review against the 
upstream spec.

> The problem is that the value
> of the flag was taken wrong and directly violates NBD specification.
> This value (bit 8) is used at least in the Linux kernel as a part of
> stable userspace-kernel API since 4.10 as NBD_FLAG_CAN_MULTI_CONN
> as defined in the specification:

And a kernel that honors that bit can cause qemu to misbehave. Yeah, 
that's definitely undesirable.

> 
> "bit 8, NBD_FLAG_CAN_MULTI_CONN: Indicates that the server operates
> entirely without cache, or that the cache it uses is shared among all
> connections to the given device. In particular, if this flag is
> present, then the effects of NBD_CMD_FLUSH and NBD_CMD_FLAG_FUA
> MUST be visible across all connections when the server sends its reply
> to that command to the client. In the absense of this flag, clients

Oh fun - a typo in the NBD spec (should be absence). I'll fix that 
separately.

> SHOULD NOT multiplex their commands over more than one connection to
> the export.
> ...
> bit 10, NBD_FLAG_SEND_CACHE: documents that the server understands
> NBD_CMD_CACHE; however, note that server implementations exist
> which support the command without advertising this bit, and
> conversely that this bit does not guarantee that the command will
> succeed or have an impact."
> 
> Personally I do not see any option that we will be allowed to fix the
> specification in favor of QEMU and apply the fix to the kernel. This
> is a big-big problem. Let us fix this in QEMU as soon as possible.

Correct. Since the kernel is already one client that supports 
CAN_MULTI_CONN, qemu 3.0 was wrong for declaring the wrong bit value.

> 
> Thus the commit fixes negotiation flag in QEMU accoring to the

s/according/according/

> specification. Fortunately enough the bit has been added by Virtuozzo
> and there are no released products in the field with this bit used
> so far.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Valery Vdovin <valery.vdovin@acronis.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/block/nbd.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 4638c839f5..4377fa502c 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -135,7 +135,7 @@ typedef struct NBDExtent {
>   #define NBD_FLAG_SEND_TRIM         (1 << 5) /* Send TRIM (discard) */
>   #define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6) /* Send WRITE_ZEROES */
>   #define NBD_FLAG_SEND_DF           (1 << 7) /* Send DF (Do not Fragment) */
> -#define NBD_FLAG_SEND_CACHE        (1 << 8) /* Send CACHE (prefetch) */
> +#define NBD_FLAG_SEND_CACHE        (1 << 10) /* Send CACHE (prefetch) */

I'll probably amend this to list all NBD_FLAG_ values in the spec (even 
if qemu doesn't implement them yet), just to make it easier to avoid 
making this mistake in the future.

Reviewed-by: Eric Blake <eblake@redhat.com>

Will queue through my NBD tree.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
