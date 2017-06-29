Received: from eggs.gnu.org ([2001:4830:134:3::10]:54170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQdGY-0000f3-Ax
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQdGX-0004wt-Gy
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:30:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1498756113.git.alistair.francis@xilinx.com>
	<ec037b86d3144d26ebdbb943515d2da02725d465.1498756113.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cbdfef36-9f44-dcb9-a2e6-cf2fd65b0365@amsat.org>
Date: Thu, 29 Jun 2017 14:29:54 -0300
MIME-Version: 1.0
In-Reply-To: <ec037b86d3144d26ebdbb943515d2da02725d465.1498756113.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/3] util/aio-win32: Only select on what
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
Cc: alistair23@gmail.com, edgar.iglesias@xilinx.com, qemu-block@nongnu.org, philippe@mathieu-daude.net, pbonzini@redhat.com

On 06/29/2017 02:16 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> Changes since RFC:
>   - Include more bitmasks for the select call
> 
>   util/aio-win32.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/util/aio-win32.c b/util/aio-win32.c
> index bca496a47a..d6d5e02f00 100644
> --- a/util/aio-win32.c
> +++ b/util/aio-win32.c
> @@ -71,6 +71,7 @@ void aio_set_fd_handler(AioContext *ctx,
>           }
>       } else {
>           HANDLE event;
> +        long bitmask = 0;
>   
>           if (node == NULL) {
>               /* Alloc and insert if it's not already there */
> @@ -95,10 +96,16 @@ void aio_set_fd_handler(AioContext *ctx,
>           node->io_write = io_write;
>           node->is_external = is_external;
>   
> +        if (io_read) {
> +            bitmask |= FD_READ | FD_ACCEPT | FD_CLOSE;
> +        }
> +
> +        if (io_write) {
> +            bitmask |= FD_WRITE | FD_CONNECT;
> +        }
> +
>           event = event_notifier_get_handle(&ctx->notifier);
> -        WSAEventSelect(node->pfd.fd, event,
> -                       FD_READ | FD_ACCEPT | FD_CLOSE |
> -                       FD_CONNECT | FD_WRITE | FD_OOB);
> +        WSAEventSelect(node->pfd.fd, event, bitmask);
>       }
>   
>       qemu_lockcnt_unlock(&ctx->list_lock);
> 
