Received: from eggs.gnu.org ([2001:4830:134:3::10]:56080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhlcindy@gmail.com>) id 1dERWw-0001j5-N0
	for qemu-devel@nongnu.org; Fri, 26 May 2017 22:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhlcindy@gmail.com>) id 1dERWv-0003Z6-OY
	for qemu-devel@nongnu.org; Fri, 26 May 2017 22:32:38 -0400
MIME-Version: 1.0
In-Reply-To: <20170526132114.6edc006e@nial.brq.redhat.com>
References: <1495790468-23862-1-git-send-email-zhlcindy@gmail.com>
	<20170526132114.6edc006e@nial.brq.redhat.com>
From: Li Zhang <zhlcindy@gmail.com>
Date: Sat, 27 May 2017 10:32:33 +0800
Message-ID: <CAD8of+pw5Nh4oSkTuYX4fbJvA8=-CTmn6dgdXHPLERAcQM+Oyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Li Zhang <li.zhang@hxt-semitech.com>

On Fri, May 26, 2017 at 7:21 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Fri, 26 May 2017 17:21:05 +0800
> Li Zhang <zhlcindy@gmail.com> wrote:
>
>> From: Li Zhang <li.zhang@hxt-semitech.com>
>>
>> virt machine doesn't support hot_add_cpu interface. This patchset is to implement
>> hot_add_cpu interface. A CPU can be added by QMP command with QEMU monitor.
>>
>> Here is command to add a CPU with QMP command.
>>
>> * qemu-system-aarch64 -machine virt -cpu cortex-a15 -smp 1,maxcpus=4 \
>>     -monitor telnet:127.0.0.1:4444,server,nowait -nographic
>> * connect monitor:      telnet 127.0.0.1 4444
>> * execute qmp command:  cpu-add 1
> cpu-add command shouldn't be used for new cpu hotplug,
> pls use generic device_add for that.

Ok,  I will drop this command and look at device_add.

>
> The last time I looked at it, virt machine needed quite a bit of
> re-factoring of the way it creates/wires up CPUs.

 Yes, I am looking into it and see if I can do something:)

>
> Pls see usage of following callbacks for example on how to implement
> device_add based cpu hotplug:
>
>   get_hotplug_handler
>   pc_cpu_pre_plug
>   pc_cpu_plug
>   pc_possible_cpu_arch_ids
>
> and pc_cpus_init() for initial cpu creation with above callbacks in use
>
Thanks, I will see it. :)

>>
>> Currently, when KVM is enabled and add a CPU with QMP command, QEMU
>> reports error "kvm_init_vcpu failed: Device or resourc busy". KVM can't
>> create a new CPU when vgic has been initialized and irqchip_in_kernel in
>> function kvm_arch_vcpu_create. It needs to change KVM code in the future.
> if KVM isn't capable do it yet, then qemu should refuse cpu hotplug if running
> with KVM accelarator and allow it only in TCG mode.

OK, I will add an assertion to allow hotplug only in TCG mode.

>
>>
>> Li Zhang (3):
>>   arm/virt: Refine fdt_add_cpu_nodes code
>>   arm/virt: Refine code of machvirt_init
>>   arm/virt: Implement hot_add_cpu interface
>>
>>  hw/arm/virt.c | 344 ++++++++++++++++++++++++++++++++++------------------------
>>  1 file changed, 202 insertions(+), 142 deletions(-)
>>
>



-- 

Best Regards
-Li
