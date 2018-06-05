Received: from eggs.gnu.org ([2001:4830:134:3::10]:58957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fQ879-00044g-3A
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fQ875-0005mX-4k
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:18:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40600 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fQ874-0005mI-Tz
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:18:47 -0400
References: <1528185295-14199-1-git-send-email-slp@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4e35ea24-147d-1b51-fa1b-0f1cc32966e0@redhat.com>
Date: Tue, 5 Jun 2018 11:18:35 +0200
MIME-Version: 1.0
In-Reply-To: <1528185295-14199-1-git-send-email-slp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/char/serial: Only retry if
 qemu_chr_fe_write returns 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>, mst@redhat.com, peter.maydell@linaro.org, marcandre.lureau@gmail.com
Cc: qemu-devel@nongnu.org

On 05/06/2018 09:54, Sergio Lopez wrote:
> Only retry on serial_xmit if qemu_chr_fe_write returns 0, as this is the
> only recoverable error.
> 
> Retrying with any other scenario, in addition to being a waste of CPU
> cycles, can compromise the Guest stability if by the vCPU issuing the
> write and the main loop thread are, by chance or explicit pinning,
> running on the same pCPU.
> 
> Previous discussion:
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06998.html
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  hw/char/serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 605b0d0..6de6c29 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -260,7 +260,7 @@ static void serial_xmit(SerialState *s)
>          if (s->mcr & UART_MCR_LOOP) {
>              /* in loopback mode, say that we just received a char */
>              serial_receive1(s, &s->tsr, 1);
> -        } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) != 1 &&
> +        } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) == 0 &&
>                     s->tsr_retry < MAX_XMIT_RETRY) {
>              assert(s->watch_tag == 0);
>              s->watch_tag =
> 

Queued, thanks to you and all those who participated in the discussion.

Paolo
