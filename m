Received: from eggs.gnu.org ([2001:4830:134:3::10]:35111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dDZNw-0003zw-E4
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dDZNv-0000qi-HD
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:43:44 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
References: <4086b9ad1d1c912298f7c981f2c94a9f9a7026a3.1495536228.git.berto@igalia.com>
	<5925B107.1060404@virtuozzo.com>
In-Reply-To: <5925B107.1060404@virtuozzo.com>
Message-ID: <f4437f01-1eb2-d1c1-3df5-ee992fab2036@virtuozzo.com>
Date: Wed, 24 May 2017 19:43:31 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org

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
> ---
>  block/qcow2-cluster.c | 34 ++++++++++++++++++++++--------
>  block/qcow2.c         | 58
> ++++++++++++++++++++++++++++++++++++++++++---------
>  block/qcow2.h         |  7 +++++++
>  3 files changed, 80 insertions(+), 19 deletions(-)
>
> -    /* And now we can write everything */
> -    qemu_iovec_reset(&qiov);
> -    qemu_iovec_add(&qiov, start_buffer, start->nb_bytes);
> -    ret = do_perform_cow_write(bs, m->alloc_offset, start->offset, &qiov);
> -    if (ret < 0) {
> -        goto fail;
> +    /* And now we can write everything. If we have the guest data we
> +     * can write everything in one single operation */
> +    if (m->data_qiov) {
> +        qemu_iovec_reset(&qiov);
> +        qemu_iovec_add(&qiov, start_buffer, start->nb_bytes);
> +        qemu_iovec_concat(&qiov, m->data_qiov, 0, data_bytes);
> +        qemu_iovec_add(&qiov, end_buffer, end->nb_bytes);

Can it be a problem if (m->data_qiov->niov == IOV_MAX)?
We had to add merge-iovecs code for the case (maybe there's better
solution?)

Also, will this work if allocation is split into several l2metas?
e.g. one has cow_start.nb_bytes and another has cow_end.nb_bytes

/Anton
