Received: from eggs.gnu.org ([2001:4830:134:3::10]:34147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eBbs5-00008W-F0
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eBbs4-0002Qr-KX
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:31:01 -0500
References: <1509712671-16299-1-git-send-email-shankerd@codeaurora.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a381c1f7-b695-8126-982f-610f60a1b992@redhat.com>
Date: Mon, 6 Nov 2017 08:30:51 +0100
MIME-Version: 1.0
In-Reply-To: <1509712671-16299-1-git-send-email-shankerd@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/intc/arm_gicv3_its: Fix the VM
 termination in vm_change_state_handler()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shanker Donthineni <shankerd@codeaurora.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

Hi Shanker,

On 03/11/2017 13:37, Shanker Donthineni wrote:
> The commit cddafd8f353d ("hw/intc/arm_gicv3_its: Implement state save
> /restore") breaks the backward compatibility with the older kernels
> where vITS save/restore support is not available. The vmstate function
> vm_change_state_handler() should not be registered if the running kernel
> doesn't support ITS save/restore feature. Otherwise VM instance will be
> killed whenever vmstate callback function is invoked.
> 
> Observed a virtual machine shutdown with QEMU-2.10+linux-4.11 when testing
> the reboot command "virsh reboot <domain> --mode acpi" instead of reboot.
> 
> KVM Error: 'KVM_SET_DEVICE_ATTR failed: Group 4 attr 0x00000000000001'
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks for the fix.

Best Regards

Eric
> ---
>  hw/intc/arm_gicv3_its_kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index 39903d5..9b00ce5 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -111,13 +111,13 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
>              error_free(s->migration_blocker);
>              return;
>          }
> +    } else {
> +        qemu_add_vm_change_state_handler(vm_change_state_handler, s);
>      }
>  
>      kvm_msi_use_devid = true;
>      kvm_gsi_direct_mapping = false;
>      kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
> -
> -    qemu_add_vm_change_state_handler(vm_change_state_handler, s);
>  }
>  
>  /**
> 
