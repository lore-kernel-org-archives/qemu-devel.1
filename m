Received: from eggs.gnu.org ([2001:4830:134:3::10]:46635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMEqy-0005PY-G7
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:09:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMEqv-0004Kj-9H
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:09:48 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1511196664-85304-2-git-send-email-anton.nefedov@virtuozzo.com>
References: <1511196664-85304-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1511196664-85304-2-git-send-email-anton.nefedov@virtuozzo.com>
Date: Tue, 05 Dec 2017 16:09:07 +0100
Message-ID: <w51shcp5i0c.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/7] qapi: add unmap to
 BlockDeviceStats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

On Mon 20 Nov 2017 05:50:58 PM CET, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json       | 20 ++++++++++++++++++++
>  include/block/accounting.h |  1 +
>  block/qapi.c               |  6 ++++++
>  3 files changed, 27 insertions(+)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 76bf50f..ba2705d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -730,6 +730,23 @@
>  # @timed_stats: Statistics specific to the set of previously defined
>  #               intervals of time (Since 2.5)
>  #
> +# @unmap_bytes: The number of bytes unmapped by the device (Since 2.12)
> +#
> +# @unmap_operations: The number of unmap operations performed by the device
> +#                    (Since 2.12)
> +#
> +# @unmap_total_time_ns: Total time spent on unmap operations in nano-seconds
> +#                       (Since 2.12)
> +#
> +# @unmap_merged: Number of unmap requests that have been merged into another
> +#                request (Since 2.12)
> +#
> +# @failed_unmap_operations: The number of failed unmap operations performed
> +#                           by the device (Since 2.12)
> +#
> +# @invalid_unmap_operations: The number of invalid unmap operations performed
> +#                            by the device (Since 2.12)
> +#
>  # Since: 0.14.0

Admittedtly this is just a style issue and I don't know what others
think, but wouldn't it be nicer if the documentation of new fields is
located together with the existing ones?

E.g

 @rd_bytes
 @wr_bytes
+@unmap_bytes
 @rd_operations
 @wr_operations
 @flush_operations
+@unmap_operations

[...]

 @failed_rd_operations
 @failed_wr_operations
 @failed_flush_operations
+@failed_unmap_operations

etc.

>      ds->rd_bytes = stats->nr_bytes[BLOCK_ACCT_READ];
>      ds->wr_bytes = stats->nr_bytes[BLOCK_ACCT_WRITE];
> +    ds->unmap_bytes = stats->nr_bytes[BLOCK_ACCT_UNMAP];
>      ds->rd_operations = stats->nr_ops[BLOCK_ACCT_READ];
>      ds->wr_operations = stats->nr_ops[BLOCK_ACCT_WRITE];
> +    ds->unmap_operations = stats->nr_ops[BLOCK_ACCT_UNMAP];

Essentially like this :)

The patch is fine with me either way.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
