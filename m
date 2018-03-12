Received: from eggs.gnu.org ([2001:4830:134:3::10]:47820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evGDf-00085p-0S
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 01:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evGDa-0002uW-3h
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 01:41:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56394 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1evGDZ-0002u2-Ut
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 01:41:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5BA91406E8B9
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 05:41:49 +0000 (UTC)
References: <20180228093232.24854-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2a01c42c-fe68-23c9-04d2-648d942291da@redhat.com>
Date: Mon, 12 Mar 2018 06:41:42 +0100
MIME-Version: 1.0
In-Reply-To: <20180228093232.24854-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/i386: make IOMMUs configurable via
 default-configs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: ddepaula@redhat.com

On 28.02.2018 10:32, Paolo Bonzini wrote:
> Allow distributions to disable the Intel and/or AMD IOMMU devices.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/i386-softmmu.mak   | 2 ++
>  default-configs/x86_64-softmmu.mak | 2 ++
>  hw/i386/Makefile.objs              | 5 +++--
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index 3326e3e0bb..9e5a29fa4a 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -63,3 +63,5 @@ CONFIG_PXB=y
>  CONFIG_ACPI_VMGENID=y
>  CONFIG_FW_CFG_DMA=y
>  CONFIG_I2C=y
> +CONFIG_VTD=y
> +CONFIG_AMD_IOMMU=y
> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
> index 1c6cda1d9a..7baf91b921 100644
> --- a/default-configs/x86_64-softmmu.mak
> +++ b/default-configs/x86_64-softmmu.mak
> @@ -63,3 +63,5 @@ CONFIG_PXB=y
>  CONFIG_ACPI_VMGENID=y
>  CONFIG_FW_CFG_DMA=y
>  CONFIG_I2C=y
> +CONFIG_VTD=y
> +CONFIG_AMD_IOMMU=y
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index fd279e7584..528b8dc431 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -2,8 +2,9 @@ obj-$(CONFIG_KVM) += kvm/
>  obj-y += multiboot.o
>  obj-y += pc.o pc_piix.o pc_q35.o
>  obj-y += pc_sysfw.o
> -obj-y += x86-iommu.o intel_iommu.o
> -obj-y += amd_iommu.o
> +obj-y += x86-iommu.o
> +obj-$(CONFIG_VTD) += x86-iommu.o intel_iommu.o

I think you have to remove x86-iommu.o in the above line, since it is
included already one line earlier.

With that modification:

Reviewed-by: Thomas Huth <thuth@redhat.com>
