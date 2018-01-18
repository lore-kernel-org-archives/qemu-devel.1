Received: from eggs.gnu.org ([2001:4830:134:3::10]:38492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCMq-0006q3-Hm
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:44:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCMn-0004b8-Ey
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:44:40 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCMn-0004ax-Aa
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:44:37 -0500
Received: by mail-qt0-x243.google.com with SMTP id e2so31238611qti.0
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 07:44:37 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180118123219.19410-1-f4bug@amsat.org>
	<20180118123219.19410-7-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <16165fc9-6593-8ee9-1dd9-a28400876e66@amsat.org>
Date: Thu, 18 Jan 2018 12:44:32 -0300
MIME-Version: 1.0
In-Reply-To: <20180118123219.19410-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 06/16] sdhci: add
 init_readonly_registers() to initialize the CAPAB register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

On 01/18/2018 09:32 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/sd/sdhci.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index f9264d3be5..08b85558f1 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1174,12 +1174,19 @@ static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
>      }
>  }
>  
> +static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
> +{
> +    if (s->capareg == UINT64_MAX) {
> +        s->capareg = SDHC_CAPAB_REG_DEFAULT;
> +    }
> +}
> +
>  /* --- qdev common --- */
>  
>  #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
> -    /* Capabilities registers provide information on supported features
> -     * of this specific host controller implementation */ \
> -    DEFINE_PROP_UINT64("capareg", _state, capareg, SDHC_CAPAB_REG_DEFAULT), \
> +    /* deprecated: Capabilities registers provide information on supported
> +     * features of this specific host controller implementation */ \
> +    DEFINE_PROP_UINT64("capareg", _state, capareg, UINT64_MAX), \
>      DEFINE_PROP_UINT64("maxcurr", _state, maxcurr, 0)
>  
>  static void sdhci_initfn(SDHCIState *s)
> @@ -1204,6 +1211,10 @@ static void sdhci_uninitfn(SDHCIState *s)
>  
>  static void sdhci_common_realize(SDHCIState *s, Error **errp)
>  {
> +    sdhci_init_readonly_registers(s, errp);
> +    if (errp && *errp) {

Paolo said this is wrong (as in bad pattern?).

I will respin probably using 'bool sdhci_init_readonly_registers()' instead.

> +        return;
> +    }
>      s->buf_maxsz = sdhci_get_fifolen(s);
>      s->fifo_buffer = g_malloc0(s->buf_maxsz);
>  
> 
