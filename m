Received: from eggs.gnu.org ([2001:4830:134:3::10]:38060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dnkUB-00036S-LY
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dnkUA-000604-II
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:51:43 -0400
Date: Fri, 1 Sep 2017 13:51:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170901135121.57ca6a04@nial.brq.redhat.com>
In-Reply-To: <dfaeb539-8006-85d6-35b2-0af31f5a0675@huawei.com>
References: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
	<1503066227-18251-3-git-send-email-gengdongjiu@huawei.com>
	<20170829122053.36cf550c@nial.brq.redhat.com>
	<dfaeb539-8006-85d6-35b2-0af31f5a0675@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 2/6] ACPI: Add APEI GHES Table
 Generation support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: mst@redhat.com, zhaoshenglong@huawei.com, lersek@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, edk2-devel@lists.01.org, christoffer.dall@linaro.org, marc.zyngier@arm.com, will.deacon@arm.com, james.morse@arm.com, ard.biesheuvel@linaro.org, mingo@kernel.org, bp@suse.de, shiju.jose@huawei.com, zjzhang@codeaurora.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, john.garry@huawei.com, jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com, zhengqiang10@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com, linuxarm@huawei.com

On Fri, 1 Sep 2017 17:58:55 +0800
gengdongjiu <gengdongjiu@huawei.com> wrote:

> Hi Igor,
> 
> On 2017/8/29 18:20, Igor Mammedov wrote:
> > On Fri, 18 Aug 2017 22:23:43 +0800
> > Dongjiu Geng <gengdongjiu@huawei.com> wrote:
[...]
> >   
> >> +void ghes_build_acpi(GArray *table_data, GArray *hardware_error,
> >> +                                            BIOSLinker *linker)
> >> +{
> >> +    uint32_t ghes_start = table_data->len;
> >> +    uint32_t address_size, error_status_address_offset;
> >> +    uint32_t read_ack_register_offset, i;
> >> +
> >> +    address_size = sizeof(struct AcpiGenericAddress) -
> >> +        offsetof(struct AcpiGenericAddress, address);  
> > it's confusing name for var,
> > AcpiGenericAddress::address is fixed unsigned 64 bit integer per spec
> > also, I'm not sure why it's needed at all.  
>  it is because other people have concern about where does the "unsigned 64 bit integer"
>  come from, they are confused about the "unsigned 64 bit integer"
>  so they suggested use sizeof. anyway I will directly use unsigned 64 bit integer.
Maybe properly named macro instead of sizeof(foo) would do the job


[...]
> >> +
> >> +        /* Build error status address*/
> >> +        build_address(table_data, linker, error_status_address_offset + i *
> >> +            sizeof(AcpiGenericHardwareErrorSourceV2), i * address_size,
> >> +            AML_SYSTEM_MEMORY, 0x40, 0, 4 /* QWord access */);  
> > just do something like this instead of build_address():
> > build_append_gas()
> > bios_linker_loader_add_pointer()  
> Thanks for the suggestion.
> 
> > 
> > also register width 0x40 looks suspicious, where does it come from?
> > While at it do you have a real hardware which has HEST table that you re trying to model after?
> > I'd like to see HEST and other related tables from it.  
> 
> Igor, what is your suspicious point? The register width 0x40 come from our host BIOS record to the System Memory space.

maybe s/0x40/ERROR_STATUS_BLOCK_POINTER_SIZE/

[...]
