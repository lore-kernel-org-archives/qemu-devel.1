Received: from eggs.gnu.org ([2001:4830:134:3::10]:43628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dEDJ6-00058L-D7
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dEDJ5-00064S-Lj
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:21:24 -0400
Date: Fri, 26 May 2017 13:21:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170526132114.6edc006e@nial.brq.redhat.com>
In-Reply-To: <1495790468-23862-1-git-send-email-zhlcindy@gmail.com>
References: <1495790468-23862-1-git-send-email-zhlcindy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] arm/virt: refine virt.c code and
 implement hot_add_cpu interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhang <zhlcindy@gmail.com>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Li Zhang <li.zhang@hxt-semitech.com>

On Fri, 26 May 2017 17:21:05 +0800
Li Zhang <zhlcindy@gmail.com> wrote:

> From: Li Zhang <li.zhang@hxt-semitech.com>
> 
> virt machine doesn't support hot_add_cpu interface. This patchset is to implement
> hot_add_cpu interface. A CPU can be added by QMP command with QEMU monitor.
> 
> Here is command to add a CPU with QMP command.
> 
> * qemu-system-aarch64 -machine virt -cpu cortex-a15 -smp 1,maxcpus=4 \
>     -monitor telnet:127.0.0.1:4444,server,nowait -nographic
> * connect monitor:      telnet 127.0.0.1 4444
> * execute qmp command:  cpu-add 1
cpu-add command shouldn't be used for new cpu hotplug,
pls use generic device_add for that.

The last time I looked at it, virt machine needed quite a bit of
re-factoring of the way it creates/wires up CPUs.

Pls see usage of following callbacks for example on how to implement
device_add based cpu hotplug:

  get_hotplug_handler
  pc_cpu_pre_plug
  pc_cpu_plug
  pc_possible_cpu_arch_ids

and pc_cpus_init() for initial cpu creation with above callbacks in use

> 
> Currently, when KVM is enabled and add a CPU with QMP command, QEMU 
> reports error "kvm_init_vcpu failed: Device or resourc busy". KVM can't
> create a new CPU when vgic has been initialized and irqchip_in_kernel in
> function kvm_arch_vcpu_create. It needs to change KVM code in the future.
if KVM isn't capable do it yet, then qemu should refuse cpu hotplug if running
with KVM accelarator and allow it only in TCG mode.

> 
> Li Zhang (3):
>   arm/virt: Refine fdt_add_cpu_nodes code
>   arm/virt: Refine code of machvirt_init
>   arm/virt: Implement hot_add_cpu interface
> 
>  hw/arm/virt.c | 344 ++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 202 insertions(+), 142 deletions(-)
> 
