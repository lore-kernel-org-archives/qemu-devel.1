Received: from eggs.gnu.org ([2001:4830:134:3::10]:48512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhwOU-0001Ri-FI
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhwOR-00076H-BN
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:21:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dhwOR-00075n-5B
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:21:47 -0400
References: <1502842933-8323-1-git-send-email-tianyu.lan@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34042934-782b-6bcc-b9b2-de7a1816cfb7@redhat.com>
Date: Wed, 16 Aug 2017 13:21:37 +0200
MIME-Version: 1.0
In-Reply-To: <1502842933-8323-1-git-send-email-tianyu.lan@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] x86: Skip check apic_id_limit for Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, rth@twiddle.net, ehabkost@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org

On 16/08/2017 02:22, Lan Tianyu wrote:
> Xen vIOMMU device model will be in Xen hypervisor. Skip vIOMMU
> check for Xen here when vcpu number is more than 255.

I think you still need to do a check for vIOMMU being enabled.

Paolo

> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  hw/i386/pc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 5943539..fc17885 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1260,7 +1260,7 @@ void pc_machine_done(Notifier *notifier, void *data)
>          fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
>      }
>  
> -    if (pcms->apic_id_limit > 255) {
> +    if (pcms->apic_id_limit > 255 && !xen_enabled()) {
>          IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
>  
>          if (!iommu || !iommu->x86_iommu.intr_supported ||
> 
