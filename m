Received: from eggs.gnu.org ([209.51.188.92]:35730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ggplw-0003eL-FO
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ggplv-0007qY-Gz
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:42:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ggplv-0007ey-4i
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:42:15 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-14-yang.zhong@intel.com>
	<fa9d19df-c373-f647-a732-9fc76d9b2f4b@redhat.com>
	<20190108080426.GB27840@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f5bb53e6-0ba0-57e5-f917-4c25ed53b562@redhat.com>
Date: Tue, 8 Jan 2019 12:42:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190108080426.GB27840@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 13/25] scsi: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com

On 08/01/19 09:04, Yang Zhong wrote:
> On Fri, Jan 04, 2019 at 02:39:50PM +0100, Thomas Huth wrote:
>> On 2018-12-27 07:34, Yang Zhong wrote:
>>> From: Paolo Bonzini <pbonzini@redhat.com>
>>>
>>> This lets you disable SCSI altogether with "CONFIG_SCSI=n".
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
>>> ---
>>>  hw/scsi/Kconfig       | 11 ++++++++++-
>>>  hw/scsi/Makefile.objs |  2 +-
>>>  2 files changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
>>> index 6e7575397f..d669a4824e 100644
>>> --- a/hw/scsi/Kconfig
>>> +++ b/hw/scsi/Kconfig
>>>  
>>> -config PSERIES
>>> +config SPAPR_VSCSI
>>>      bool
>>> +    select SCSI
>>
>> I think this should get "default y" and "depends on PSERIES" now.
>>
>>  Thomas
> 
>    Hello Thomas,
> 
>    I greped CONFIG_PSERIES from current Kconfig repo and got below list
>   ./hw/net/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr_llan.o
>   ./hw/ppc/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr.o spapr_caps.o spapr_vio.o spapr_events.o
>   ./hw/ppc/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
>   ./hw/ppc/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o
>   ./hw/ppc/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o spapr_irq.o
>   ./hw/ppc/Makefile.objs:ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
>   ./hw/ppc/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
>   ./hw/char/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr_vty.o
>   ./hw/nvram/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr_nvram.o
>   ./default-configs/ppc64-softmmu.mak:CONFIG_PSERIES=y
>   ./default-configs/ppc64-softmmu.mak:CONFIG_XICS=$(CONFIG_PSERIES)
>   ./default-configs/ppc64-softmmu.mak:CONFIG_XICS_SPAPR=$(CONFIG_PSERIES)
>   ./default-configs/ppc64-softmmu.mak:CONFIG_XICS_KVM=$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
> 
>   Since this time is only for x86 and i did not add Kconfig file in hw/ppc/, i did not add 
>   this dependency too in here. 
>   
>   In previous plan, i will add "config PSERRIES" in hw/ppc/Kconfig file for PowerPC pSeries
>   and will add dependency in that time, thanks.

You could skip the conversion to Kconfig of default-configs/, but
already add all "source hw/ARCH/Kconfig" statements to hw/Kconfig and
all "select" statements for buses.  Then, all machine types for example
could start removing CONFIG_SCSI=y and CONFIG_PCI=y, even if you do not
have the machines converted.

Paolo
