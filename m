Received: from eggs.gnu.org ([2001:4830:134:3::10]:57129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhlcindy@gmail.com>) id 1dBakR-00037e-0Y
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhlcindy@gmail.com>) id 1dBakQ-0006zz-73
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:46:47 -0400
MIME-Version: 1.0
From: Li Zhang <zhlcindy@gmail.com>
Date: Fri, 19 May 2017 13:46:44 +0800
Message-ID: <CAD8of+qgOQyU3QBk6YmPd4RnXQV0W-T4AE868q6y7TkCwu1K2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] A problem of IRQchip in QEMU and KVM for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-arm@nongnu.org, kvm@vger.kernel.org

Hi,

I am looking into QEMU code in ARM recently and trying to add add_hot_cpu
in QEMU for ARM,
but it doesn't work when enabling KVM. It reports error:

"kvm_init_vcpu failed: Device or resourc busy."

By debugging QEMU with gdb, it failed on ioctl. In kernel soruce code
arch/arm/kvm/arm.c,
vcpu is created by this following function, it will report -EBUSY if
irqchip_in_kernel.

struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
{
        int err;
        struct kvm_vcpu *vcpu;

        if (irqchip_in_kernel(kvm) && vgic_initialized(kvm)) {
                err = -EBUSY;
                goto out;
        }

  ....
}

I set virt machine with kernel_irqchip = off, it can execute cpu-add
interface correctly with qmp-shell
commands. But VMs still can't work well with kernel_irqchip=off when
executing "info cpus" in qemu monitor.

My question is that:
1) Can we change this error status in kvm_arch_vcpu_create?
2) Is it that irqchip_kernel=off  isn't supported with KVM enabled on ARM?

-- 

Best Regards
-Li
