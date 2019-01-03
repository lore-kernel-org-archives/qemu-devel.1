Received: from eggs.gnu.org ([208.118.235.92]:47284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf5W1-0007cs-Hi
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf5W0-0005iK-M2
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:06:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gf5W0-0005hc-EU
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:06:36 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-11-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <00c0eea5-aa0d-118f-3c78-5851fd5eae9d@redhat.com>
Date: Thu, 3 Jan 2019 17:06:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-11-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 10/25] build: convert pci.mak to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org

On 2018-12-27 07:34, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Instead of including the same list of devices for each target,
> set CONFIG_PCI to true, and make the devices default to present
> whenever PCI is available.
>=20
> Done mostly with the following script:
>=20
>   while read i; do
>      i=3D${i%=3Dy}; i=3D${i#CONFIG_}
>      sed -i -e'/^config '$i'$/!b' -en \
>             -e'a\' -e'    default y\' -e'    depends on PCI' \
>           `grep -lw $i hw/*/Kconfig`
>   done < default-configs/pci.mak
>=20
> followed by replacing a few "depends on" clauses with "select"
> whenever the symbol is not really related to PCI.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/i386-softmmu.mak |  2 +-
>  default-configs/pci.mak          | 47 --------------------------------
>  hw/audio/Kconfig                 |  6 ++++
>  hw/block/Kconfig                 |  2 ++
>  hw/char/Kconfig                  |  2 ++
>  hw/display/Kconfig               | 12 +++++++-
>  hw/ide/Kconfig                   |  6 ++++
>  hw/ipack/Kconfig                 |  2 ++
>  hw/misc/Kconfig                  |  4 +++
>  hw/net/Kconfig                   | 19 +++++++++++++
>  hw/scsi/Kconfig                  | 11 ++++++++
>  hw/sd/Kconfig                    |  3 ++
>  hw/usb/Kconfig                   | 10 +++++++
>  hw/virtio/Kconfig                |  3 ++
>  hw/watchdog/Kconfig              |  2 ++
>  15 files changed, 82 insertions(+), 49 deletions(-)
>  delete mode 100644 default-configs/pci.mak
>=20
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-so=
ftmmu.mak
> index 560250c998..61f19e5231 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -1,6 +1,6 @@
>  # Default configuration for i386-softmmu
[...]
> diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
> index 091f3a81c9..0f25b27163 100644
> --- a/hw/ide/Kconfig
> +++ b/hw/ide/Kconfig
> @@ -7,6 +7,7 @@ config IDE_QDEV
> =20
>  config IDE_PCI
>      bool
> +    depends on PCI
>      select IDE_CORE
> =20
>  config IDE_ISA
> @@ -15,10 +16,12 @@ config IDE_ISA
> =20
>  config IDE_PIIX
>      bool
> +    depends on PCI
>      select IDE_QDEV
> =20
>  config IDE_CMD646
>      bool
> +    select IDE_PCI
>      select IDE_QDEV

Why "select" here and not "depends on" like in the previous cases?

>  config IDE_MACIO
> @@ -31,6 +34,7 @@ config IDE_MMIO
> =20
>  config IDE_VIA
>      bool
> +    select IDE_PCI
>      select IDE_QDEV

dito

>  config MICRODRIVE
> @@ -39,6 +43,8 @@ config MICRODRIVE
> =20
>  config AHCI
>      bool
> +    default y
> +    depends on PCI
>      select IDE_QDEV
> =20
>  config IDE_SII3112

I think the SII3112 needs a "depends on PCI", too?

> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index 6b2ec971b5..c87375ee52 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -3,27 +3,42 @@ config DP8393X
> =20
>  config NE2000_PCI
>      bool
> +    default y
> +    depends on PCI
> =20
>  config EEPRO100_PCI
>      bool
> +    default y
> +    depends on PCI
> =20
>  config PCNET_PCI
>      bool
> +    default y
> +    depends on PCI
> +    select PCNET_COMMON
> =20
>  config PCNET_COMMON
>      bool
> =20
>  config E1000_PCI
>      bool
> +    default y
> +    depends on PCI
> =20
>  config E1000E_PCI
>      bool
> +    default y
> +    depends on PCI
> =20
>  config RTL8139_PCI
>      bool
> +    default y
> +    depends on PCI
> =20
>  config VMXNET3_PCI
>      bool
> +    default y
> +    depends on PCI
> =20
>  config SMC91C111
>      bool
> @@ -81,12 +96,16 @@ config ETSEC
> =20
>  config ROCKER
>      bool
> +    default y
> +    depends on PCI
> =20
>  config CAN_BUS
>      bool
> =20
>  config CAN_PCI
>      bool
> +    default y
> +    depends on PCI

Do we need a "select CAN_BUS" here? (Well, maybe that's rather something
for a later patch instead...)

 Thomas
