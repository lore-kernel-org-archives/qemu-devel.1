Received: from eggs.gnu.org ([2001:4830:134:3::10]:60327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cHBMC-00019F-5j
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cHBM7-0007Vi-7A
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:20:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1cHBM6-0007VW-V9
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:20:31 -0500
References: <20161214125237.20850-1-maxime.coquelin@redhat.com>
	<20161214150852.5009.51009@loki>
	<20161214171501-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <47f04741-9323-c2a5-f135-b317894ae398@redhat.com>
Date: Wed, 14 Dec 2016 16:20:24 +0100
MIME-Version: 1.0
In-Reply-To: <20161214171501-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Fix cross-version migration
 with older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, marcel@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>



On 12/14/2016 04:15 PM, Michael S. Tsirkin wrote:
> On Wed, Dec 14, 2016 at 09:08:52AM -0600, Michael Roth wrote:
>> Quoting Maxime Coquelin (2016-12-14 06:52:37)
>>> This patch fixes a cross-version migration regression introduced
>>> by commit d1b4259f ("virtio-bus: Plug devices after features are
>>> negotiated").
>>>
>>> The problem is encountered when host's vhost backend does not support
>>> VIRTIO_F_VERSION_1, and migration is initiated from a v2.7 or prior
>>> machine with virtio-pci modern capabilities enabled to a v2.8 machine.
>>>
>>> In this case, modern capabilities get exposed to the guest by the source,
>>> whereas the target will detect version 1 is not supported so will only
>>> expose legacy capabilities.
>>>
>>> The problem is fixed by introducing a new "x-modern-broken" property,
>>> which is set in v2.7 and prior compatibility modes. Doing this, v2.7
>>> machine keeps its broken behaviour (enabling modern while version is
>>> not supported), and newer machines will behave correctly.
>>>
>>> Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
>>> Cc: Marcel Apfelbaum <marcel@redhat.com>
>>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>>
>> Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>>
>> I can confirm this fixes the original issue I reported. I also did a
>> number of sanity runs with 2.7/2.8/pc-i440fx-2.{6,7,8} using various
>> combinations of disable-modern=true/false on hosts with/without virtio-1,
>> and some tests with pseries machines as well, and everything seems to
>> work.
>>
>> Thanks for the quick fix!
>
> FYI what I think does not work is a recent kernel on 2.7
> machine type and host without virtio 1.
> But this is not new.

I confirm, and as we discussed off-list, I will propose a kernel patch
to improve the situation, even if it will not fix current guests using
recent kernels.


>
>>> ---
>>>
>>> I'm not sure about the property name, let me know if you have better ideas.
>>> I didn't tested migration yet, but I wanted to share the patch while I test it.
>>> I tested booting v2.8 and v2.7 machines with !VERSION_1 and get expected result:
>>>  - v2.8: Virtio-pci probe succeed
>>>  - v2.7: Virtio-pci probe fails
>>>
>>> Thanks,
>>> Maxime
>>>
>>>  hw/virtio/virtio-pci.c | 4 +++-
>>>  hw/virtio/virtio-pci.h | 1 +
>>>  include/hw/compat.h    | 4 ++++
>>>  3 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>>> index 521ba0b..93f6b54 100644
>>> --- a/hw/virtio/virtio-pci.c
>>> +++ b/hw/virtio/virtio-pci.c
>>> @@ -1580,7 +1580,8 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
>>>       * Virtio capabilities present without
>>>       * VIRTIO_F_VERSION_1 confuses guests
>>>       */
>>> -    if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
>>> +    if (!proxy->modern_broken &&
>>> +            !virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
>>>          virtio_pci_disable_modern(proxy);
>>>
>>>          if (!legacy) {
>>> @@ -1852,6 +1853,7 @@ static Property virtio_pci_properties[] = {
>>>                      VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT, false),
>>>      DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
>>>                      VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
>>> +    DEFINE_PROP_BOOL("x-modern-broken", VirtIOPCIProxy, modern_broken, false),
>>>      DEFINE_PROP_END_OF_LIST(),
>>>  };
>>>
>>> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
>>> index b2a996f..1dca223 100644
>>> --- a/hw/virtio/virtio-pci.h
>>> +++ b/hw/virtio/virtio-pci.h
>>> @@ -153,6 +153,7 @@ struct VirtIOPCIProxy {
>>>      int config_cap;
>>>      uint32_t flags;
>>>      bool disable_modern;
>>> +    bool modern_broken;
>>>      OnOffAuto disable_legacy;
>>>      uint32_t class_code;
>>>      uint32_t nvectors;
>>> diff --git a/include/hw/compat.h b/include/hw/compat.h
>>> index 0f06e11..fe11723 100644
>>> --- a/include/hw/compat.h
>>> +++ b/include/hw/compat.h
>>> @@ -18,6 +18,10 @@
>>>          .driver   = "intel-iommu",\
>>>          .property = "x-buggy-eim",\
>>>          .value    = "true",\
>>> +    },{\
>>> +        .driver   = "virtio-pci",\
>>> +        .property = "x-modern-broken",\
>>> +        .value    = "on",\
>>>      },
>>>
>>>  #define HW_COMPAT_2_6 \
>>> --
>>> 2.9.3
>>>
