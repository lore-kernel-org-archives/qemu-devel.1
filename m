Received: from eggs.gnu.org ([2001:4830:134:3::10]:55836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dEFw9-0004IS-Qr
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dEFw4-0003In-S7
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:09:53 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <4086b9ad1d1c912298f7c981f2c94a9f9a7026a3.1495536228.git.berto@igalia.com>
References: <cover.1495536228.git.berto@igalia.com>
	<4086b9ad1d1c912298f7c981f2c94a9f9a7026a3.1495536228.git.berto@igalia.com>
Date: Fri, 26 May 2017 16:09:45 +0200
Message-ID: <w51zidzk8uu.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 7/7] qcow2: Merge the writing of the COW
 regions with the guest data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>

On Tue 23 May 2017 01:23:02 PM CEST, Alberto Garcia wrote:

You can still review this now if you want, but here's a couple of minor
things I'll correct in the next revision:

> +    if (m->data_qiov) {
> +        qemu_iovec_reset(&qiov);
> +        qemu_iovec_add(&qiov, start_buffer, start->nb_bytes);
> +        qemu_iovec_concat(&qiov, m->data_qiov, 0, data_bytes);
> +        qemu_iovec_add(&qiov, end_buffer, end->nb_bytes);

I'll check start->nb_bytes and end->nb_bytes for zero before calling
qemu_iovec_add() (no practical difference, but I find it a bit cleaner).

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

I realized that I'm using guest offsets in this function. Since this
checks if we can _write_ everything together I think I should be using
host offsets instead.

I also don't think this makes any difference in practice in this case,
but I'll update it.

Berto
