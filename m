Received: from eggs.gnu.org ([2001:4830:134:3::10]:33507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f6z19-0007JJ-5w
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f6z18-0006Hc-Co
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:45:31 -0400
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
	<1522160122-10744-7-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_p+ibaMyePwKW_dMQ_M7BHADnzvN_5_mjOLmUtEp=m2Q@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <75f90e1b-5460-bdba-9bd9-b32a87f40e06@redhat.com>
Date: Fri, 13 Apr 2018 15:45:18 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_p+ibaMyePwKW_dMQ_M7BHADnzvN_5_mjOLmUtEp=m2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 6/8] hw/arm/virt: Allow GICv3 DT node with
 multiple redistributor regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <cdall@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Eric Auger <eric.auger.pro@gmail.com>

Hi Peter,

On 13/04/18 15:36, Peter Maydell wrote:
> On 27 March 2018 at 15:15, Eric Auger <eric.auger@redhat.com> wrote:
>> This patch adds the GICState handle in the virtual machine state and
>> allows to create a GIC device tree node advertising multiple redistributor
>> regions.
>>
>> There is one range per distributor region following the GIC distributor.
>> Please refer to kernel documentation for further details:
>> Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
>> +
>> +        num_reg_values =  4 * (s->nb_redist_regions + 1);
>> +        regs = g_new0(uint64_t, num_reg_values);
>> +        qemu_fdt_setprop_cell(vms->fdt, "/intc", "#redistributor-regions",
>> +                              s->nb_redist_regions);
>> +        regs[0] = 2;
>> +        regs[1] = vms->memmap[VIRT_GIC_DIST].base;
>> +        regs[2] = 2;
>> +        regs[3] = vms->memmap[VIRT_GIC_DIST].size;
>> +
>> +        for (r = 1; r <= s->nb_redist_regions; r++) {
>> +            regs[4 * r] = 2;
>> +            regs[4 * r  + 1] = s->redist_region[r - 1].base;
>> +            regs[4 * r  + 2] = 2;
>> +            /* count redistributors of 2 x 64kB pages */
>> +            regs[4 * r  + 3] = (uint64_t)s->redist_region[r - 1].count << 17;
> 
> Board code shouldn't be reaching into the GIC device state struct like this.

I will add a dedicated API.

Thanks

Eric
> 
>> +        }
>> +        qemu_fdt_setprop_sized_cells_from_array(vms->fdt, "/intc", "reg",
>> +                                                num_reg_values / 2, regs);
>> +        g_free(regs);
>> +
>>          if (vms->virt) {
>>              qemu_fdt_setprop_cells(vms->fdt, "/intc", "interrupts",
> 
> thanks
> -- PMM
> 
