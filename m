Received: from eggs.gnu.org ([2001:4830:134:3::10]:50133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ezPmr-0000Nj-BN
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 12:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ezPmo-0001B3-NW
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 12:43:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ezPmo-0001A4-IH
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 12:43:26 -0400
References: <20180323152948.27048-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d41535d3-eae4-2189-b950-22d84af66f87@redhat.com>
Date: Fri, 23 Mar 2018 17:43:19 +0100
MIME-Version: 1.0
In-Reply-To: <20180323152948.27048-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] chardev/char-fe: Allow NULL
 chardev in qemu_chr_fe_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>

On 23/03/2018 16:29, Peter Maydell wrote:
> All the functions in char-fe.c handle the CharBackend
> having a NULL Chardev pointer, which means that the
> backend exists but is not connected to anything. The
> exception is qemu_chr_fe_init(), which will crash if
> passed a NULL Chardev pointer argument. This can happen
> for various boards if they're started with 'nodefaults':
>  arm-softmmu/qemu-system-arm -S -nodefaults -M cubieboard
>  riscv32-softmmu/qemu-system-riscv32 -nodefaults -M sifive_e
> 
> Make qemu_chr_fe_init() accept a NULL chardev. This allows
> UART models to handle NULL chardev properties without
> generally needing to special case them or to manually
> create a NullChardev.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is my proposal for fixing the crashes with -nodefaults.
> I think we should also change hw/char/serial.c to accept
> a NULL Chardev rather than treating it as an error
> ( "Can't create serial device, empty char device"), and
> similarly for any other devices that currently error out
> on NULL chardevs. I'd rather postpone that part til 2.13, though.
> 
> 
>  chardev/char-fe.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index 392db78b13..b1f228e8b5 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -198,19 +198,21 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
>  {
>      int tag = 0;
>  
> -    if (CHARDEV_IS_MUX(s)) {
> -        MuxChardev *d = MUX_CHARDEV(s);
> +    if (s) {
> +        if (CHARDEV_IS_MUX(s)) {
> +            MuxChardev *d = MUX_CHARDEV(s);
>  
> -        if (d->mux_cnt >= MAX_MUX) {
> +            if (d->mux_cnt >= MAX_MUX) {
> +                goto unavailable;
> +            }
> +
> +            d->backends[d->mux_cnt] = b;
> +            tag = d->mux_cnt++;
> +        } else if (s->be) {
>              goto unavailable;
> +        } else {
> +            s->be = b;
>          }
> -
> -        d->backends[d->mux_cnt] = b;
> -        tag = d->mux_cnt++;
> -    } else if (s->be) {
> -        goto unavailable;
> -    } else {
> -        s->be = b;
>      }
>  
>      b->fe_open = false;
> 

Queued, thanks.

Paolo
