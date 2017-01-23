Received: from eggs.gnu.org ([2001:4830:134:3::10]:48020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVmvh-0004nK-WF
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 17:17:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVmvh-0007xW-7C
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 17:17:38 -0500
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:34921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cVmvh-0007xP-3U
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 17:17:37 -0500
Received: by mail-ua0-x234.google.com with SMTP id y9so121550815uae.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 14:17:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485206518-32403-1-git-send-email-atar4qemu@gmail.com>
References: <1485206518-32403-1-git-send-email-atar4qemu@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jan 2017 22:17:16 +0000
Message-ID: <CAFEAcA860sYR6svwKMtjjoknfkVK=-Ch8vat_ywPyyvjtsr=MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/2] niagara: fail if a firmware file is
 missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 23 January 2017 at 21:21, Artyom Tarasenko <atar4qemu@gmail.com> wrote:
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>  hw/sparc64/niagara.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index b55d4bb..e945b5a 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -35,6 +35,7 @@
>  #include "hw/timer/sun4v-rtc.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/block-backend.h"
> +#include "qemu/error-report.h"
>
>
>  typedef struct NiagaraBoardState {
> @@ -85,6 +86,14 @@ typedef struct NiagaraBoardState {
>  #define NIAGARA_OBP_OFFSET  0x80000ULL
>  #define PROM_SIZE_MAX       (4 * 1024 * 1024)
>
> +static void add_rom_or_fail(const char *file, const hwaddr addr)
> +{
> +    if (rom_add_file_fixed(file, addr, -1)) {
> +        error_report("Unable to load a firmware for -M niagara");
> +        exit(1);

It would be nice to include the name of the file in the
error message -- or is that reported already inside
rom_add_file_fixed() somehow?

thanks
-- PMM
