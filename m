Received: from eggs.gnu.org ([209.51.188.92]:51880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjjZW-000104-On
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjjZV-00086w-Lf
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:41:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjjZV-0007u7-4Z
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:41:25 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-24-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8f2984fd-68e4-eb00-d384-2bcddeefa049@redhat.com>
Date: Wed, 16 Jan 2019 12:41:17 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-24-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 23/37] build: convert pci.mak to
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com

On 2019-01-15 15:10, Yang Zhong wrote:
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
[...]
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index 6b2ec971b5..5191c082e3 100644
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

The e1000e is a PCI-e device, so maybe this should rather depend on
"PCIE" instead?

With that fixed:

Reviewed-by: Thomas Huth <thuth@redhat.com>


>  config RTL8139_PCI
>      bool
> +    default y
> +    depends on PCI
> =20
>  config VMXNET3_PCI
>      bool
> +    default y
> +    depends on PCI
[...]
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index cbf5c5d761..f23c542d27 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -3,21 +3,31 @@ config USB
> =20
>  config USB_UHCI
>      bool
> +    default y
> +    depends on PCI
> =20
>  config USB_OHCI
>      bool
> +    default y
> +    depends on PCI
> =20
>  config USB_EHCI
>      bool
> +    default y
> +    depends on PCI

We might need a USB_EHCI_PCI switch in the future (since there is also
_SYSBUS which could be used without PCI), but I think that can be done
in a later patch.

>  config USB_EHCI_SYSBUS
>      bool
> =20
>  config USB_XHCI
>      bool
> +    default y
> +    depends on PCI
> =20
>  config USB_XHCI_NEC
>      bool
> +    default y
> +    depends on PCI
> =20
>  config USB_MUSB
>      bool

 Thomas
