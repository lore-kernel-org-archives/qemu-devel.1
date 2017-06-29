Received: from eggs.gnu.org ([2001:4830:134:3::10]:57091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQYT1-0002hC-NA
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQYT0-00013z-UD
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:22:39 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <cover.1498607452.git.alistair.francis@xilinx.com>
	<dc10d43ceafb859bf568e0ccd3085d7348e114c9.1498607452.git.alistair.francis@xilinx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ef1b8289-0b94-5ddc-d8f2-c4e03c2c4c1e@redhat.com>
Date: Thu, 29 Jun 2017 14:22:28 +0200
MIME-Version: 1.0
In-Reply-To: <dc10d43ceafb859bf568e0ccd3085d7348e114c9.1498607452.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 1/4] util/aio-win32: Only select on what
 we are actually waiting for
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com
Cc: edgar.iglesias@xilinx.com, alistair23@gmail.com, qemu-block@nongnu.org



On 28/06/2017 01:57, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
> 
>  util/aio-win32.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/util/aio-win32.c b/util/aio-win32.c
> index bca496a47a..949979c2f5 100644
> --- a/util/aio-win32.c
> +++ b/util/aio-win32.c
> @@ -71,6 +71,7 @@ void aio_set_fd_handler(AioContext *ctx,
>          }
>      } else {
>          HANDLE event;
> +        long bitmask = 0;
>  
>          if (node == NULL) {
>              /* Alloc and insert if it's not already there */
> @@ -95,10 +96,16 @@ void aio_set_fd_handler(AioContext *ctx,
>          node->io_write = io_write;
>          node->is_external = is_external;
>  
> +        if (io_read) {
> +            bitmask |= FD_READ;
> +        }
> +
> +        if (io_write) {
> +            bitmask |= FD_WRITE;
> +        }

The read case should also include FD_ACCEPT, and the write case should
also include FD_CONNECT.  FD_CLOSE probably also goes under "read",
since it's signaled when read()/recv() return 0.

FD_OOB is unnecessary, indeed.

Paolo

>          event = event_notifier_get_handle(&ctx->notifier);
> -        WSAEventSelect(node->pfd.fd, event,
> -                       FD_READ | FD_ACCEPT | FD_CLOSE |
> -                       FD_CONNECT | FD_WRITE | FD_OOB);
> +        WSAEventSelect(node->pfd.fd, event, bitmask);
>      }
>  
>      qemu_lockcnt_unlock(&ctx->list_lock);
> 
