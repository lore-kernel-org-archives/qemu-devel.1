Received: from eggs.gnu.org ([2001:4830:134:3::10]:60753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQVug-00084i-Ag
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQVuf-0000Zj-GW
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:39:02 -0400
Date: Thu, 29 Jun 2017 17:38:50 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170629093850.GF28654@lemon.lan>
References: <cover.1498607452.git.alistair.francis@xilinx.com>
	<4b48ca3f3c45bee1103bcb50d87e6d5cadc88d6f.1498607452.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b48ca3f3c45bee1103bcb50d87e6d5cadc88d6f.1498607452.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [RFC v1 4/4] util/oslib-win32: Recursivly pass the
 timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, qemu-block@nongnu.org

On Tue, 06/27 16:57, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
> 
>  util/oslib-win32.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index a015e1ac96..3630e46499 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -432,10 +432,10 @@ static int poll_rest(gboolean poll_msgs, HANDLE *handles, gint nhandles,
>              }
>          }
>  
> -        /* If no timeout and polling several handles, recurse to poll
> -         * the rest of them.
> +        /* We only found one and we are waiting on more then one. Let's try
> +         * again.
>           */
> -        if (timeout == 0 && nhandles > 1) {
> +        if (nhandles > 1) {
>              /* Remove the handle that fired */
>              int i;
>              if ((ready - WAIT_OBJECT_0) < nhandles - 1) {
> @@ -444,7 +444,20 @@ static int poll_rest(gboolean poll_msgs, HANDLE *handles, gint nhandles,
>                  }
>              }
>              nhandles--;
> -            recursed_result = poll_rest(FALSE, handles, nhandles, fds, nfds, 0);
> +
> +            /* If we just had a very small timeout let's increase it when we
> +             * recurse to ensure we don't just busy wait. This ensures we let
> +             * the Windows threads block at least a little. If we previously
> +             * had some wait let's set it to zero to avoid blocking for too
> +             * long.
> +             */
> +            if (timeout < 10) {
> +                timeout = timeout + 1;
> +            } else {
> +                timeout = 0;
> +            }
> +            recursed_result = poll_rest(FALSE, handles, nhandles, fds,
> +                                        nfds, timeout);
>              return (recursed_result == -1) ? -1 : 1 + recursed_result;
>          }
>          return 1;
> -- 
> 2.11.0
> 

This is a hack, can we fix what is the causing the busy wait instead?

Fam
