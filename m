Received: from eggs.gnu.org ([2001:4830:134:3::10]:35653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gNKLM-0001Eb-Qa
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:18:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gNKLJ-0006Gc-O5
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:18:12 -0500
Date: Thu, 15 Nov 2018 17:17:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181115161756.GE12677@localhost.localdomain>
References: <20181031215622.27690-1-kwolf@redhat.com>
	<20181031215622.27690-9-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031215622.27690-9-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/12] file-posix: Move read/write
 operation logic out of aio_worker()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

Am 31.10.2018 um 22:56 hat Kevin Wolf geschrieben:
> aio_worker() for reads and writes isn't boring enough yet. It still does
> some postprocessing for handling short reads and turning the result into
> the right return value.
> 
> However, there is no reason why handle_aiocb_rw() couldn't do the same,
> and even without duplicating code between the read and write path. So
> move the code there.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

> @@ -1354,7 +1356,21 @@ static ssize_t handle_aiocb_rw(RawPosixAIOData *aiocb)
>      }
>      qemu_vfree(buf);
>  
> -    return nbytes;
> +out:
> +    if (nbytes == aiocb->aio_nbytes) {
> +        return 0;
> +    } else if (nbytes >= 0 && nbytes < aiocb->aio_nbytes) {
> +        if (aiocb->aio_type & QEMU_AIO_WRITE) {
> +            return -EINVAL;
> +        } else {
> +            iov_memset(aiocb->io.iov, aiocb->io.niov, nbytes,
> +                      0, aiocb->aio_nbytes - nbytes);
> +            return aiocb->aio_nbytes;

While reviewing Eric's patches, I noticed that this should be return 0.
Fixing it in my queue.

Kevin
