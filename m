Received: from eggs.gnu.org ([209.51.188.92]:33574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqzgL-000182-7o
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:18:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqzgJ-0003DY-GP
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:18:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqzgH-0003CH-Sh
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:18:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id r2so3335165wrv.10
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 04:18:22 -0800 (PST)
References: <20190204202609.26956-1-philmd@redhat.com>
	<20190204202609.26956-7-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <43082fc0-0a65-a450-b5ee-5ddca51adcc9@redhat.com>
Date: Tue, 5 Feb 2019 13:18:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190204202609.26956-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] mips: Express dependencies of the
 Loongson 2E machine with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>, Thomas Huth <thuth@redhat.com>

On 2/4/19 9:26 PM, Philippe Mathieu-Daudé wrote:
> The Loongson 2E uses a Bonito64 system controller as North Bridge and a
> VT82C686 chipset as South Bridge. The network card chipset is a RTL8139D.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  default-configs/mips64el-softmmu.mak |  3 ---
>  hw/isa/Kconfig                       | 13 +++++++++----
>  hw/mips/Kconfig                      |  5 +++++
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips64el-softmmu.mak
> index 9e80711275..326c5cd520 100644
> --- a/default-configs/mips64el-softmmu.mak
> +++ b/default-configs/mips64el-softmmu.mak
> @@ -1,8 +1,5 @@
>  # Default configuration for mips64el-softmmu
>  
>  include mips-softmmu-common.mak
> -CONFIG_IDE_VIA=y
>  CONFIG_FULONG=y
> -CONFIG_PCI_BONITO=y
> -CONFIG_VT82C686=y
>  CONFIG_MIPS_BOSTON=y
> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
> index d580471c00..bd6f60dd3d 100644
> --- a/hw/isa/Kconfig
> +++ b/hw/isa/Kconfig
> @@ -33,10 +33,15 @@ config PIIX4
>  
>  config VT82C686
>      bool
> -    select ISA_BUS
> -    select ACPI_SMBUS

The VT82C686 config might be incorrect, I rebased this on another
series where I reworked the ISA_SUPERIO config and have to check
this part again.

> -    select SERIAL_ISA
> -    select FDC
> +    select PCI
> +    select I8259
> +    select I8254
> +    select I8257
> +    select PARALLEL
> +    select IDE_ISA
> +    select IDE_VIA
> +    select USB_UHCI
> +    #select PCKBD
>  
>  config SMC37C669
>      bool
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index 2940ff39ab..16b2bdb068 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -42,6 +42,11 @@ config JAZZ
>  
>  config FULONG
>      bool
> +    select PCI_BONITO
> +    select VT82C686
> +    select SMBUS_EEPROM
> +    select RTL8139_PCI
> +    select MC146818RTC
>  
>  config MIPS_CPS
>      bool
> 
