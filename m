Received: from eggs.gnu.org ([209.51.188.92]:40213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1groW3-0006cQ-Nd
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1groW1-0004mj-OV
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:35:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1groVz-0004iw-ST
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:35:13 -0500
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-6-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <05115768-7591-b327-8383-3bd58305b3f8@redhat.com>
Date: Thu, 7 Feb 2019 19:35:02 +0100
MIME-Version: 1.0
In-Reply-To: <1549562254-41157-6-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/51] kconfig: introduce kconfig files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, Yang Zhong <yang.zhong@intel.com>

On 2019-02-07 18:56, Paolo Bonzini wrote:
> The Kconfig files were generated mostly with this script:
>=20
>   for i in `grep -ho CONFIG_[A-Z0-9_]* default-configs/* | sort -u`; do
>     set fnord `git grep -lw $i -- 'hw/*/Makefile.objs' `
>     shift
>     if test $# =3D 1; then
>       cat >> $(dirname $1)/Kconfig << EOF
> config ${i#CONFIG_}
>     bool
>=20
> EOF
>       git add $(dirname $1)/Kconfig
>     else
>       echo $i $*
>     fi
>   done
>   sed -i '$d' hw/*/Kconfig
>   for i in hw/*; do
>     if test -d $i && ! test -f $i/Kconfig; then
>       touch $i/Kconfig
>       git add $i/Kconfig
>     fi
>   done
>=20
> Whenever a symbol is referenced from multiple subdirectories, the
> script prints the list of directories that reference the symbol.
> These symbols have to be added manually to the Kconfig files.
>=20
> Kconfig.host and hw/Kconfig were created manually.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Message-Id: <20190123065618.3520-27-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Duplicated S-o-b ... doesn't hurt, but looks a little bit weird...

[...]
> diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
> new file mode 100644
> index 0000000..cd66ada
> --- /dev/null
> +++ b/hw/m68k/Kconfig
> @@ -0,0 +1,8 @@
> +config AN5206
> +    bool
> +
> +config MCF5206
> +    bool

As far as I can see, the MCF5206 switch is not necessary?

> +config MCF5208
> +    bool
[...]
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> new file mode 100644
> index 0000000..d358b2c
> --- /dev/null
> +++ b/hw/net/Kconfig
> @@ -0,0 +1,92 @@
> +config DP8393X
> +    bool
> +
> +config NE2000_PCI
> +    bool
> +
> +config EEPRO100_PCI
> +    bool
> +
> +config PCNET_PCI
> +    bool
> +
> +config PCNET_COMMON
> +    bool
> +
> +config E1000_PCI
> +    bool
> +
> +config E1000E_PCI_EXPRESS
> +    bool
> +
> +config RTL8139_PCI
> +    bool
> +
> +config VMXNET3_PCI
> +    bool
> +
> +config SMC91C111
> +    bool
> +
> +config LAN9118
> +    bool
> +
> +config NE2000_ISA
> +    bool
> +
> +config OPENCORES_ETH
> +    bool
> +
> +config XGMAC
> +    bool
> +
> +config MIPSNET
> +    bool
> +
> +config ALLWINNER_EMAC
> +    bool
> +
> +config IMX_FEC
> +    bool
> +
> +config CADENCE
> +    bool
> +
> +config STELLARIS_ENET
> +    bool
> +
> +config LANCE
> +    bool
> +
> +config SUNHME
> +    bool
> +
> +config FTGMAC100
> +    bool
> +
> +config SUNGEM
> +    bool
> +
> +config COLDFIRE
> +    bool

Could you please move COLDFIRE to hw/m68k/Kconfig ? The switch is also
used for other Coldfire-related files that do not reside in hw/net/ .

 Thanks,
  Thomas
