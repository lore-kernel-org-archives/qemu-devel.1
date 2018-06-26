Received: from eggs.gnu.org ([2001:4830:134:3::10]:50033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fXl7F-0005DJ-53
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fXl7A-0003HO-Ep
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:22:29 -0400
References: <20180619093124.24011-1-luc.michel@greensocs.com>
	<d3c05355-4eda-f501-8f04-d808f416393a@web.de>
	<3c8fa899-e420-15a0-a2af-8d92ca390a85@greensocs.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <d86380b6-cee8-301c-45a1-b696acf2eeea@web.de>
Date: Tue, 26 Jun 2018 12:22:05 +0200
MIME-Version: 1.0
In-Reply-To: <3c8fa899-e420-15a0-a2af-8d92ca390a85@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] arm_gic: add virtualization
 extensions support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com

On 2018-06-26 11:24, Luc Michel wrote:
> 
> 
> On 06/25/2018 06:55 AM, Jan Kiszka wrote:
>> On 2018-06-19 11:31, luc.michel@greensocs.com wrote:
>>> From: Luc MICHEL <luc.michel@greensocs.com>
>>>
>>> This patch series add support for the virtualization extensions in the
>>> ARM GICv2 interrupt controller.
>>>
>>> The first two commits do some refactoring to prepare for the
>>> implementation. Commits 3 and 4 are the actual implementation. The last
>>> commit updates the ZynqMP implementation to support virtualization.
>>
>> Is it enabled for the virt machine as well? Seems we are missing some
>> mapping of GICV and GICH there.
>>
>> And what is the recommended way to get the ZynqMP model running? I've a
>> kernel that works on a ZCU102, but just passing it via -kernel to the
>> QEMU model seems insufficient.
> Hum, I think it should be enough. This is the way I run my tests with Xen:
> qemu-system-aarch64 -M xlnx-zcu102,secure=on,virtualization=on \
>                     -m 1024 \
>                     -kernel xen-kernel -nographic -smp 1
> 

Just debugged this further a bit, and it seems my kernel is not getting
any device tree from qemu:

(gdb) bt
#0  cpu_relax () at ../arch/arm64/include/asm/processor.h:203
#1  setup_machine_fdt (dt_phys=256) at ../arch/arm64/kernel/setup.c:194
#2  setup_arch (cmdline_p=<optimized out>) at ../arch/arm64/kernel/setup.c:258
#3  0xffffff8008e30bc4 in start_kernel () at ../init/main.c:552
#4  0x0000000000000000 in ?? ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb) lx-dmesg 
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 4.17.0-00033-g67c2a9a37d59 (jan@md1f2u6c) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #17 SMP Tue Jun 26 12:16:56 CEST 2018
(gdb) l setup_machine_fdt
178                     pr_warn("Large number of MPIDR hash buckets detected\n");
179     }
180
181     static void __init setup_machine_fdt(phys_addr_t dt_phys)
182     {
183             void *dt_virt = fixmap_remap_fdt(dt_phys);
184             const char *name;
185
186             if (!dt_virt || !early_init_dt_scan(dt_virt)) {
187                     pr_crit("\n"
188                             "Error: invalid device tree blob at physical address %pa (virtual address 0x%p)\n"
189                             "The dtb must be 8-byte aligned and must not exceed 2 MB in size\n"
190                             "\nPlease check your bootloader.",
191                             &dt_phys, dt_virt);
192
193                     while (true)
194                             cpu_relax();
[...]
(gdb) p dt_virt
$1 = (void *) 0x0

Jan
