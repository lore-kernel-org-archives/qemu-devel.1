Received: from eggs.gnu.org ([2001:4830:134:3::10]:60151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsaig-0002LK-Q3
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 16:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsaid-0007f5-DB
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 16:26:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dsaid-0007eJ-7L
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 16:26:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5114E4A6F4
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 20:26:38 +0000 (UTC)
References: <1505420247-23685-1-git-send-email-mgamal@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4e386f8e-a4f5-7646-a37c-353d6f8068c8@redhat.com>
Date: Thu, 14 Sep 2017 22:26:31 +0200
MIME-Version: 1.0
In-Reply-To: <1505420247-23685-1-git-send-email-mgamal@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: Return error on machines with
 no PCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mohammed Gamal <mgamal@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, mst@redhat.com

On 14.09.2017 22:17, Mohammed Gamal wrote:
> Starting the following command line causes a segfault
> qemu-system-x86_64 -S -machine isapc,accel=kvm -device intel-iommu
> 
> This is due to the fact that the machine type 'isapc' doesn't have
> a PCI bus, while intel_iommu doesn't check if the machine has PCI support
> and subsequently does a null-pointer access. Intel IOMMU shouldn't even work
> if the target machine doesn't have PCI.
> 
> Add a check for PCI on the given machine type and return an error if PCI
> is not supported.
> 
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 3a5bb0b..fab0b4b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3041,6 +3041,13 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>      }
>  
>      bus = pcms->bus;
> +
> +    if (!bus) {
> +        error_setg(errp, "Machine-type '%s' does not support PCI",
> +                   mc->name);
> +        return;
> +    }
> +
>      x86_iommu->type = TYPE_INTEL;
>  
>      if (!vtd_decide_config(s, errp)) {
> 

Patch looks basically fine to me, too, but I think I'd also rather
change the "if (!pcms)" at the beginning of the function into "if (!pcms
|| !pcms->bus)" here to use the same error message for both cases.

 Thomas
