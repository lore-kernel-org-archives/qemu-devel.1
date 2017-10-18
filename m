Received: from eggs.gnu.org ([2001:4830:134:3::10]:41290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1e4k8L-0000XB-ED
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1e4k8I-0003Ip-DL
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:55:25 -0400
Date: Wed, 18 Oct 2017 09:54:59 +0100
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171018085459.3mt4gynx3s3gndnt@starbug-vm.ie.oracle.com>
References: <1508298038-4156-1-git-send-email-sundeep.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1508298038-4156-1-git-send-email-sundeep.lkml@gmail.com>
Subject: Re: [Qemu-devel] [Qemu devel v2 PATCH] msf2: Remove dead code
 reported by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, crosthwaite.peter@gmail.com, f4bug@amsat.org, alistair23@gmail.com, pbonzini@redhat.com, imammedo@redhat.com

On Wed, Oct 18, 2017 at 03:40:38AM +0000, Subbaraya Sundeep wrote:
>Fixed incorrect frame size mask, validated maximum frame
>size in spi_write and removed dead code.
>
>Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>---
>v2:
>	else if -> else in set_fifodepth
>	log guest error when frame size is more than 32
>
> hw/ssi/mss-spi.c | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)
>
>diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
>index 5a8e308..7fef2c3 100644
>--- a/hw/ssi/mss-spi.c
>+++ b/hw/ssi/mss-spi.c
>@@ -76,9 +76,10 @@
> #define C_BIGFIFO            (1 << 29)
> #define C_RESET              (1 << 31)
>
>-#define FRAMESZ_MASK         0x1F
>+#define FRAMESZ_MASK         0x3F
> #define FMCOUNT_MASK         0x00FFFF00
> #define FMCOUNT_SHIFT        8
>+#define FRAMESZ_MAX          32
>
> static void txfifo_reset(MSSSpiState *s)
> {
>@@ -104,10 +105,8 @@ static void set_fifodepth(MSSSpiState *s)
>         s->fifo_depth = 32;
>     } else if (size <= 16) {
>         s->fifo_depth = 16;
>-    } else if (size <= 32) {
>-        s->fifo_depth = 8;
>     } else {
>-        s->fifo_depth = 4;
>+        s->fifo_depth = 8;
>     }
> }
>
>@@ -301,6 +300,11 @@ static void spi_write(void *opaque, hwaddr addr,
>         if (s->enabled) {
>             break;
>         }
>+        if ((value & FRAMESZ_MASK) > FRAMESZ_MAX) {
>+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Maximum frame size is %d\n",
>+                         __func__, FRAMESZ_MAX);
>+            break;
>+        }
>         s->regs[R_SPI_DFSIZE] = value;
>         break;

This test, and subsequent use of value appear to be out of sorts -
in that while it is testing for the value by ANDing it with
FRAMESZ_MASK, it is subsequently using the value without that mask
applied to it, which still has the potential to be larger than
FRAMESZ_MASK if it contains a value larger than 0x3F.

Is that the expected behaviour? If so, maybe include a comment on
it?

Also, it might be useful to include the incorrect value in the
logged output too, not just what the maximum is.

Thanks,

Darren.

>
>-- 
>2.5.0
>
>
