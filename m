Received: from eggs.gnu.org ([2001:4830:134:3::10]:45394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhlcindy@gmail.com>) id 1dEBR5-0002dl-60
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhlcindy@gmail.com>) id 1dEBR4-0005XZ-5U
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:21:31 -0400
From: Li Zhang <zhlcindy@gmail.com>
Date: Fri, 26 May 2017 17:21:05 +0800
Message-Id: <1495790468-23862-1-git-send-email-zhlcindy@gmail.com>
Subject: [Qemu-devel] [PATCH 0/3] arm/virt: refine virt.c code and implement
 hot_add_cpu interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Li Zhang <li.zhang@hxt-semitech.com>

From: Li Zhang <li.zhang@hxt-semitech.com>

virt machine doesn't support hot_add_cpu interface. This patchset is to implement
hot_add_cpu interface. A CPU can be added by QMP command with QEMU monitor.

Here is command to add a CPU with QMP command.

* qemu-system-aarch64 -machine virt -cpu cortex-a15 -smp 1,maxcpus=4 \
    -monitor telnet:127.0.0.1:4444,server,nowait -nographic
* connect monitor:      telnet 127.0.0.1 4444
* execute qmp command:  cpu-add 1

Currently, when KVM is enabled and add a CPU with QMP command, QEMU 
reports error "kvm_init_vcpu failed: Device or resourc busy". KVM can't
create a new CPU when vgic has been initialized and irqchip_in_kernel in
function kvm_arch_vcpu_create. It needs to change KVM code in the future.

Li Zhang (3):
  arm/virt: Refine fdt_add_cpu_nodes code
  arm/virt: Refine code of machvirt_init
  arm/virt: Implement hot_add_cpu interface

 hw/arm/virt.c | 344 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 202 insertions(+), 142 deletions(-)

-- 
2.7.4
