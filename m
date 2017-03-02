Received: from eggs.gnu.org ([2001:4830:134:3::10]:45870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cjKAd-0005Qw-K9
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:25:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cjKAY-00060j-N4
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:24:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cjKAY-00060P-El
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:24:54 -0500
References: <1488425538-13785-1-git-send-email-peterx@redhat.com>
	<20170302071100-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <213ff4bb-b3b9-fe00-6f0e-b75114e1a5ef@redhat.com>
Date: Thu, 2 Mar 2017 08:24:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170302071100-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] intel_iommu: check misordered init when
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, yi.l.liu@intel.com, Jintack Lim <jintack@cs.columbia.edu>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

On 03/02/2017 07:13 AM, Michael S. Tsirkin wrote:
> On Thu, Mar 02, 2017 at 11:32:18AM +0800, Peter Xu wrote:
>> Intel vIOMMU devices are created with "-device" parameter, while here
>> actually we need to make sure the dmar device be created before other
>> PCI devices (like vfio-pci, virtio-pci ones) so that we know iommu_fn
>> will be setup correctly before realizations of those PCI devices (it is
>> legal that PCI device fetch these info during its realization). Now this
>> ordering yet cannot be achieved elsewhere, and devices will be created
>> in the order that user specified. We need to avoid that.
>>
>> This patch tries to detect this kind of misordering issue during init of
>> VT-d device, then report to guest if misordering happened. In the
>> future, we can provide something better to solve it, e.g., to support
>> device init ordering, then we can live without this patch.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>
> Unfortunately with virtio it's a regression, as it used to
> work with iommu. So I'm afraid we need to look into supporting
> arbitrary order right now :(
>

Hi,

A fast way to do it is to initialize iommu with a new keyword, like
     -iommu intel-iommu
Or maybe use the existing "-object" somehow ?
 From vl.c comments:
   "Initial object creation happens before all other
    QEMU data types are created.... "

Another idea is to add a third run on QEMU cmd line arguments,
but this would affect the whole system.

However having an ordering system beats all other ideas.

Thanks,
Marcel

>> ---
>> v3: added virtio-pci device detection since we have that requirement as
>>     well now.
>>
>> PS. this patch should be needed along with Jason's:
>>  "virtio: unbreak virtio-pci with IOMMU after caching ring translations"
>> to make sure virtio devices with vt-d are safe for 2.9.
>> ---
>>  hw/i386/intel_iommu.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 22d8226..1077f90 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -2560,6 +2560,24 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>>      return true;
>>  }
>>
>> +/*
>> + * TODO: we should have a better way to achieve the ordering rather
>> + * than this misorder check explicitly against vfio-pci and virtio-pci
>> + * devices. Here, there's no easy way to detect init of virtio-pci
>> + * devices, instead we detect the virtio bus.
>> + */
>> +static bool vtd_detected_misorder_init(Error **errp)
>> +{
>> +    if (object_resolve_path_type("", "vfio-pci", NULL) ||
>> +        object_resolve_path_type("", "virtio-pci-bus", NULL)) {
>> +        error_setg(errp, "Please specify \"intel-iommu\" before "
>> +                   "all the rest of the devices.");
>> +        return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>>  static void vtd_realize(DeviceState *dev, Error **errp)
>>  {
>>      PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
>
> We'd put this somewhere central - this hack is not vtd specific.
>
>
>
>> @@ -2567,6 +2585,10 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>>      IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
>>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
>>
>> +    if (vtd_detected_misorder_init(errp)) {
>> +        return;
>> +    }
>> +
>>      VTD_DPRINTF(GENERAL, "");
>>      x86_iommu->type = TYPE_INTEL;
>>
>> --
>> 2.7.4
