Received: from eggs.gnu.org ([209.51.188.92]:34750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLPpW-0001Py-Ih
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLPn4-0000of-Hf
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:15:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLPn4-0000mV-Au
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:15:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id 26so3147055wmj.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 03:15:10 -0700 (PDT)
References: <20190428110258.86681-1-liboxuan@connect.hku.hk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a683a29f-ea7b-aaf9-258f-68f4ffcd9b96@redhat.com>
Date: Tue, 30 Apr 2019 12:15:07 +0200
MIME-Version: 1.0
In-Reply-To: <20190428110258.86681-1-liboxuan@connect.hku.hk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-mmio: Always compile debug prints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Boxuan Li <liboxuan@connect.hku.hk>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Hi Li,

On 4/28/19 1:02 PM, Boxuan Li wrote:
> Wrap printf calls inside debug macros (DPRINTF) in `if` statement, and
> change output to stderr as well. This will ensure that printf function
> will always compile and prevent bitrot of the format strings.

There is an effort in QEMU to replace the obsolete DPRINTF() macros by
trace events (which prevent format strings bitroting).

You can read more about tracing in docs/devel/tracing.txt,

and I recomment you to look at the following recent convertions in the
repository history:

commit 8d83cbf1015f547cd9336881e6b62ae2ca293849
Author: Greg Kurz <groug@kaod.org>
Date:   Fri Apr 5 10:05:24 2019 +0200

    target/ppc/kvm: Convert DPRINTF to traces

commit dd849ef2c9d57a329c6001c58dbdf49de712349c
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Thu Feb 21 18:17:46 2019 +0000

    hw/timer/pl031: Convert to using trace events

    Convert the debug printing in the PL031 device to use trace events,

Regards,

Phil.

> Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> ---
>  hw/virtio/virtio-mmio.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 5807aa87fe..693b3c9eb4 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -28,15 +28,14 @@
>  #include "hw/virtio/virtio-bus.h"
>  #include "qemu/error-report.h"
>  
> -/* #define DEBUG_VIRTIO_MMIO */
> -
> -#ifdef DEBUG_VIRTIO_MMIO
> -
> -#define DPRINTF(fmt, ...) \
> -do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while (0)
> -#endif
> +#define DEBUG_VIRTIO_MMIO 0
> +
> +#define DPRINTF(fmt, ...)                                            \
> +    do {                                                             \
> +        if (DEBUG_VIRTIO_MMIO) {                                     \
> +            fprintf(stderr, "virtio_mmio: " fmt , ## __VA_ARGS__);   \
> +        }                                                            \
> +    } while (0)
>  
>  /* QOM macros */
>  /* virtio-mmio-bus */
> 
