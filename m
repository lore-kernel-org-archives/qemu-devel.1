Received: from eggs.gnu.org ([2001:4830:134:3::10]:34139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86xZ-0006M2-P1
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86xU-0006fL-T3
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:54:13 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:52763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86xU-0006ev-OB
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:54:08 -0400
Received: by mail-qt0-x241.google.com with SMTP id 31so8961156qtz.9
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 08:54:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-10-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1b46ecf4-9422-a3ad-67a0-b470605dd84d@amsat.org>
Date: Fri, 27 Oct 2017 12:53:59 -0300
MIME-Version: 1.0
In-Reply-To: <1508947167-5304-10-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv4 09/13] lance: move TYPE_LANCE and
 SysBusPCNetState from lance.c to lance.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Jason Wang <jasowang@redhat.com>

On 10/25/2017 12:59 PM, Mark Cave-Ayland wrote:
> This enables them to be used outside of lance.c.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> CC: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/lance.c         |   11 +----------
>  include/hw/net/lance.h |   41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 10 deletions(-)
>  create mode 100644 include/hw/net/lance.h
> 
> diff --git a/hw/net/lance.c b/hw/net/lance.c
> index 92b0c68..23929fd 100644
> --- a/hw/net/lance.c
> +++ b/hw/net/lance.c
> @@ -41,19 +41,10 @@
>  #include "qemu/timer.h"
>  #include "qemu/sockets.h"
>  #include "hw/sparc/sun4m.h"
> -#include "pcnet.h"
> +#include "hw/net/lance.h"
>  #include "trace.h"
>  #include "sysemu/sysemu.h"
>  
> -#define TYPE_LANCE "lance"
> -#define SYSBUS_PCNET(obj) \
> -    OBJECT_CHECK(SysBusPCNetState, (obj), TYPE_LANCE)
> -
> -typedef struct {
> -    SysBusDevice parent_obj;
> -
> -    PCNetState state;
> -} SysBusPCNetState;
>  
>  static void parent_lance_reset(void *opaque, int irq, int level)
>  {
> diff --git a/include/hw/net/lance.h b/include/hw/net/lance.h
> new file mode 100644
> index 0000000..c112fbc
> --- /dev/null
> +++ b/include/hw/net/lance.h
> @@ -0,0 +1,41 @@
> +/*
> + * QEMU AMD PC-Net II (Am79C970A) emulation
> + *
> + * Copyright (c) 2004 Antony T Curtis
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef LANCE_H
> +#define LANCE_H
> +
> +#include "net/net.h"
> +#include "hw/net/pcnet.h"
> +
> +#define TYPE_LANCE "lance"
> +#define SYSBUS_PCNET(obj) \
> +    OBJECT_CHECK(SysBusPCNetState, (obj), TYPE_LANCE)
> +
> +typedef struct {
> +    SysBusDevice parent_obj;
> +
> +    PCNetState state;
> +} SysBusPCNetState;
> +
> +#endif
> 
