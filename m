Received: from eggs.gnu.org ([2001:4830:134:3::10]:35937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLtE1-00023U-QE
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLtE0-0008BM-Rb
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:31:53 -0400
Date: Fri, 16 Jun 2017 17:31:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170616153142.GB4366@noname.fritz.box>
References: <cover.1496844254.git.berto@igalia.com>
	<1f133befcfa4b89978d7fee980bb61ae1298e224.1496844254.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f133befcfa4b89978d7fee980bb61ae1298e224.1496844254.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/7] qcow2: Merge the writing of the COW
 regions with the guest data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

Am 07.06.2017 um 16:08 hat Alberto Garcia geschrieben:
> If the guest tries to write data that results on the allocation of a
> new cluster, instead of writing the guest data first and then the data
> from the COW regions, write everything together using one single I/O
> operation.
> 
> This can improve the write performance by 25% or more, depending on
> several factors such as the media type, the cluster size and the I/O
> request size.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

> diff --git a/block/qcow2.c b/block/qcow2.c
> index b3ba5daa93..89be2083d4 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1575,6 +1575,44 @@ fail:
>      return ret;
>  }
>  
> +/* Check if it's possible to merge a write request with the writing of
> + * the data from the COW regions */
> +static bool can_merge_cow(uint64_t offset, unsigned bytes,
> +                          QEMUIOVector *hd_qiov, QCowL2Meta *l2meta)
> +{
> +    QCowL2Meta *m;
> +
> +    for (m = l2meta; m != NULL; m = m->next) {
> +        /* If both COW regions are empty then there's nothing to merge */
> +        if (m->cow_start.nb_bytes == 0 && m->cow_end.nb_bytes == 0) {
> +            continue;
> +        }
> +
> +        /* The data (middle) region must be immediately after the
> +         * start region */
> +        if (l2meta_cow_start(m) + m->cow_start.nb_bytes != offset) {
> +            continue;
> +        }
> +
> +        /* The end region must be immediately after the data (middle)
> +         * region */
> +        if (m->offset + m->cow_end.offset != offset + bytes) {
> +            continue;
> +        }
> +
> +        /* Make sure that adding both COW regions to the QEMUIOVector
> +         * does not exceed IOV_MAX */
> +        if (hd_qiov->niov > IOV_MAX - 2) {
> +            continue;
> +        }
> +
> +        m->data_qiov = hd_qiov;

I don't think having this side effect is good for a function that is
called can_xyz(). I'd either call it merge_cow() or move the assignment
to the caller.

If we consider allowing to merge multiple L2Metas in the future, the
actual merging could become more complicated, so maybe merge_cow() is
the better option.

Kevin
