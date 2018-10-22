Received: from eggs.gnu.org ([2001:4830:134:3::10]:37798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gEXda-0007nk-1C
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 06:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gEXdW-0003f9-Uo
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 06:40:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gEXdW-0003e5-Mx
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 06:40:38 -0400
References: <20181021142103.19014-1-clement.deschamps@greensocs.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b0fbe897-8d98-30e1-b46a-f7485ee9d4a3@redhat.com>
Date: Mon, 22 Oct 2018 12:40:29 +0200
MIME-Version: 1.0
In-Reply-To: <20181021142103.19014-1-clement.deschamps@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] icount: fix deadlock when all cpus are
 sleeping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Clement Deschamps <clement.deschamps@greensocs.com>, qemu-devel@nongnu.org
Cc: artem.k.pisarenko@gmail.com, Pavel.Dovgaluk@ispras.ru

On 21/10/2018 16:21, Clement Deschamps wrote:
> When all cpus are sleeping (e.g in WFI), to avoid a deadlock
> in the main_loop, wake it up in order to start the warp timer.
> 
> Signed-off-by: Clement Deschamps <clement.deschamps@greensocs.com>
> ---
>  cpus.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/cpus.c b/cpus.c
> index bb2a511483..798d43623a 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1554,6 +1554,14 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>              atomic_mb_set(&cpu->exit_request, 0);
>          }
>  
> +        if (use_icount && all_cpu_threads_idle()) {
> +            /*
> +             * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
> +             * in the main_loop, wake it up in order to start the warp timer.
> +             */
> +            qemu_notify_event();
> +        }
> +
>          qemu_tcg_rr_wait_io_event(cpu ? cpu : first_cpu);
>          deal_with_unplugged_cpus();
>      }
> 

Queued, thanks.

Paolo
