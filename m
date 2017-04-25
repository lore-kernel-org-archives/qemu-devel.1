Received: from eggs.gnu.org ([2001:4830:134:3::10]:38680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d31uE-0001VS-7c
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d31uD-00073g-H8
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:57:30 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d31uD-00073H-AT
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:57:29 -0400
Received: by mail-wm0-x231.google.com with SMTP id m123so98762815wma.0
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 07:57:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1492763327-12742-2-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1492763327-12742-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1492763327-12742-2-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 15:57:07 +0100
Message-ID: <CAFEAcA-8DazW24_XwZ+2e+TSPJWfygQXWtmqUaBSUcTNpe32TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 01/13] cg3: remove TARGET_PAGE_SIZE
 rounding on dirty page detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 21 April 2017 at 09:28, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> This was an artifact from very early versions of the code from before the
> memory API and is no longer needed.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/cg3.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/display/cg3.c b/hw/display/cg3.c
> index 1174220..7d43694 100644
> --- a/hw/display/cg3.c
> +++ b/hw/display/cg3.c
> @@ -26,7 +26,6 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
> -#include "cpu.h"
>  #include "qemu/error-report.h"
>  #include "ui/console.h"
>  #include "hw/sysbus.h"
> @@ -114,7 +113,7 @@ static void cg3_update_display(void *opaque)
>      for (y = 0; y < height; y++) {
>          int update = s->full_update;
>
> -        page = (y * width) & TARGET_PAGE_MASK;
> +        page = y * width;

Coverity warns that this is multiplying two 32 bit quantities
and giving a 32 bit result that's then assigned to a 64 bit variable.
Casting like:
    page = (ram_addr_t)y * width;

is the usual way to placate it.

thanks
-- PMM
