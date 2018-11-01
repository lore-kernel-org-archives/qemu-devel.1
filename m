Received: from eggs.gnu.org ([2001:4830:134:3::10]:41713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIGuG-0004BE-Dd
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIGuB-0002qT-CY
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:37:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gIGuB-0002pm-4X
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:37:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so20877716wrw.3
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 10:37:15 -0700 (PDT)
References: <20181101161758.12300-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2e3320e1-a69b-3408-3676-3869b6826bee@redhat.com>
Date: Thu, 1 Nov 2018 18:37:11 +0100
MIME-Version: 1.0
In-Reply-To: <20181101161758.12300-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] hw/ppc/mac_newworld: Free
 openpic_irqs array after use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 1/11/18 17:17, Peter Maydell wrote:
> In ppc_core99_init(), we allocate an openpic_irqs array, which
> we then use to collect up the various qemu_irqs which we're
> going to connect to the interrupt controller. Once we've
> called sysbus_connect_irq() to connect them all up, the
> array is no longer required, but we forgot to free it.
> 
> Since board init is only run once at startup, the memory
> leak is not a significant one.
> 
> Spotted by Coverity: CID 1192916.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/ppc/mac_newworld.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index a630cb81cd8..14273a123e5 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -303,6 +303,7 @@ static void ppc_core99_init(MachineState *machine)
>               sysbus_connect_irq(s, k++, openpic_irqs[i][j]);
>           }
>       }
> +    g_free(openpic_irqs);
>   
>       if (PPC_INPUT(env) == PPC_FLAGS_INPUT_970) {
>           /* 970 gets a U3 bus */
> 
