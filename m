Received: from eggs.gnu.org ([2001:4830:134:3::10]:35901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLtDr-0001wu-Eo
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLtDq-00089Y-Lo
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:31:43 -0400
Date: Fri, 16 Jun 2017 17:31:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170616153127.GA4366@noname.fritz.box>
References: <cover.1496844254.git.berto@igalia.com>
	<ab53bc08e26b3e4cc5b1a14eee9e64fd0e03871d.1496844254.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab53bc08e26b3e4cc5b1a14eee9e64fd0e03871d.1496844254.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/7] qcow2: Pass a QEMUIOVector to
 do_perform_cow_{read, write}()
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
> Instead of passing a single buffer pointer to do_perform_cow_write(),
> pass a QEMUIOVector. This will allow us to merge the write requests
> for the COW regions and the actual data into a single one.
> 
> Although do_perform_cow_read() does not strictly need to change its
> API, we're doing it here as well for consistency.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 51 ++++++++++++++++++++++++---------------------------
>  1 file changed, 24 insertions(+), 27 deletions(-)

> @@ -807,22 +798,25 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
>      /* The part of the buffer where the end region is located */
>      end_buffer = start_buffer + buffer_size - end->nb_bytes;
>  
> +    qemu_iovec_init(&qiov, 3);
> +

You don't actually make use of more than one iovec in this patch. And
after the last patch, the value is potentially too low - which isn't
fatal because this is not a fixed maximum, but just a hint, but it can
cause unnecessary memory allocations.

It would probably be better to use 1 here and change it into
2 + m->data_qiov->niov when you add write merging.

Kevin
