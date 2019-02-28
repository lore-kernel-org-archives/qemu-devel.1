Received: from eggs.gnu.org ([209.51.188.92]:60240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gzJAv-0000wv-Lb
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gzJAs-0000Mi-Ce
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:44:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gzJAr-0000MJ-Um
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:44:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so8361978wmg.2
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 02:44:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-31-git-send-email-pbonzini@redhat.com>
Message-ID: <5c27dea9-b571-c2ee-ed06-10982e78f540@redhat.com>
Date: Thu, 28 Feb 2019 11:44:16 +0100
MIME-Version: 1.0
In-Reply-To: <1549562254-41157-31-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 30/51] ppc64: Express dependencies of
 'pseries' and 'powernv' machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com

On 07/02/19 18:57, Paolo Bonzini wrote:
> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
> index d642b67..cca5266 100644
> --- a/default-configs/ppc64-softmmu.mak
> +++ b/default-configs/ppc64-softmmu.mak
> @@ -5,11 +5,6 @@ include ppc-softmmu.mak
>  
>  # For PowerNV
>  CONFIG_POWERNV=y
> -CONFIG_ISA_IPMI_BT=y
>  
>  # For pSeries
>  CONFIG_PSERIES=y
> -CONFIG_VIRTIO_VGA=y
> -CONFIG_MEM_DEVICE=y
> -CONFIG_DIMM=y
> -CONFIG_SPAPR_RNG=y
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index 6eea14e..de10a6b 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -31,13 +31,11 @@ config OPENPIC_KVM
>  
>  config XICS
>      bool
> -    default y
> -    depends on PSERIES
> +    depends on POWERNV || PSERIES
>  
>  config XICS_SPAPR
>      bool
> -    default y
> -    depends on PSERIES
> +    select XICS
>  
>  config XICS_KVM
>      bool
> diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
> index d1e635c..620fd4c 100644
> --- a/hw/mem/Kconfig
> +++ b/hw/mem/Kconfig
> @@ -1,5 +1,6 @@
>  config DIMM
>      bool
> +    select MEM_DEVICE
>  
>  config MEM_DEVICE
>      bool
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index fb085d7..be6440e 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -1,11 +1,29 @@
>  config PSERIES
>      bool
> +    imply PCI_DEVICES
> +    imply TEST_DEVICES
> +    select DIMM
> +    select PCI
> +    select VFIO

I'm changing this to "select VFIO if LINUX" to fix non-Linux compilation.

Paolo
