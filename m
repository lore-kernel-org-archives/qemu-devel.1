Received: from eggs.gnu.org ([2001:4830:134:3::10]:54679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvTT-0007HN-D1
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:55:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvTS-0003UK-9h
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:55:11 -0500
References: <1517559331-6388-1-git-send-email-thuth@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <7422455d-c0bb-9bde-4e82-251dafcbb2ef@ilande.co.uk>
Date: Sat, 3 Feb 2018 10:54:56 +0000
MIME-Version: 1.0
In-Reply-To: <1517559331-6388-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/timer/mt48t59: Fix bit-rotten
 NVRAM_PRINTF format strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 02/02/18 08:15, Thomas Huth wrote:

> When compiling with NVRAM_PRINTF enabled, gcc currently bails out with:
> 
>    CC      hw/timer/m48t59.o
>    CC      hw/timer/m48t59-isa.o
> hw/timer/m48t59.c: In function ‘NVRAM_writeb’:
> hw/timer/m48t59.c:460:5: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 3 has type ‘hwaddr’ [-Werror=format=]
>       NVRAM_PRINTF("%s: 0x%08x => 0x%08x\n", __func__, addr, val);
>       ^
> hw/timer/m48t59.c:460:5: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 4 has type ‘uint64_t’ [-Werror=format=]
> hw/timer/m48t59.c: In function ‘NVRAM_readb’:
> hw/timer/m48t59.c:492:5: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 3 has type ‘hwaddr’ [-Werror=format=]
>       NVRAM_PRINTF("%s: 0x%08x <= 0x%08x\n", __func__, addr, retval);
> 
> Fix it by using the correct format strings and while we're at it,
> also change the definition of NVRAM_PRINTF so that this can not
> bit-rot so easily again.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/timer/m48t59-internal.h | 9 +++------
>   hw/timer/m48t59.c          | 4 ++--
>   2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/timer/m48t59-internal.h b/hw/timer/m48t59-internal.h
> index 32ae957..d0f0caf 100644
> --- a/hw/timer/m48t59-internal.h
> +++ b/hw/timer/m48t59-internal.h
> @@ -25,13 +25,10 @@
>   #ifndef HW_M48T59_INTERNAL_H
>   #define HW_M48T59_INTERNAL_H 1
>   
> -//#define DEBUG_NVRAM
> +#define M48T59_DEBUG 0
>   
> -#if defined(DEBUG_NVRAM)
> -#define NVRAM_PRINTF(fmt, ...) do { printf(fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define NVRAM_PRINTF(fmt, ...) do { } while (0)
> -#endif
> +#define NVRAM_PRINTF(fmt, ...) do { \
> +    if (M48T59_DEBUG) { printf(fmt , ## __VA_ARGS__); } } while (0)
>   
>   /*
>    * The M48T02, M48T08 and M48T59 chips are very similar. The newer '59 has
> diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
> index 844aad5..4abb4ac 100644
> --- a/hw/timer/m48t59.c
> +++ b/hw/timer/m48t59.c
> @@ -457,7 +457,7 @@ static void NVRAM_writeb(void *opaque, hwaddr addr, uint64_t val,
>   {
>       M48t59State *NVRAM = opaque;
>   
> -    NVRAM_PRINTF("%s: 0x%08x => 0x%08x\n", __func__, addr, val);
> +    NVRAM_PRINTF("%s: 0x%"HWADDR_PRIx" => 0x%"PRIx64"\n", __func__, addr, val);
>       switch (addr) {
>       case 0:
>           NVRAM->addr &= ~0x00FF;
> @@ -489,7 +489,7 @@ static uint64_t NVRAM_readb(void *opaque, hwaddr addr, unsigned size)
>           retval = -1;
>           break;
>       }
> -    NVRAM_PRINTF("%s: 0x%08x <= 0x%08x\n", __func__, addr, retval);
> +    NVRAM_PRINTF("%s: 0x%"HWADDR_PRIx" <= 0x%08x\n", __func__, addr, retval);
>   
>       return retval;
>   }

Hi Thomas,

I agree with Philippe here that given you've got this far then is it not 
worth going all the way with a trace-events conversion?

Then again fixing this is enough of an improvement that I'm happy to 
give my R-B regardless:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
