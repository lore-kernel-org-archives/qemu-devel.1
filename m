Received: from eggs.gnu.org ([209.51.188.92]:36469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ggtdR-0001TB-De
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ggtdQ-0005j5-40
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:49:45 -0500
References: <20190108151114.33140-1-liq3ea@163.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a9cf265e-b45b-232c-0bdb-7bc907c7b8c7@redhat.com>
Date: Tue, 8 Jan 2019 16:49:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190108151114.33140-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] s390: avoid potential null dereference
 ins390_pcihost_unplug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, walling@linux.ibm.com, cohuck@redhat.com, rth@twiddle.net, pasic@linux.ibm.com, borntraeger@de.ibm.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 08.01.19 16:11, Li Qiang wrote:
> When getting the 'pbdev', the if...else has no default branch.
> From Coverity, the 'pbdev' maybe null when the 'dev' is not
> the TYPE_PCI_BRIDGE/TYPE_PCI_DEVICE/TYPE_S390_PCI_DEVICE.
> This patch adds a default branch for device plug and unplug.
> 
> Spotted by Coverity: CID 1398593
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
> 
> Change since v2: use g_assert_not_reached for default branch
> 
>  hw/s390x/s390-pci-bus.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 15759b6514..a94700a78c 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -912,6 +912,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>          pbdev->fh = pbdev->idx;
>          QTAILQ_INSERT_TAIL(&s->zpci_devs, pbdev, link);
>          g_hash_table_insert(s->zpci_table, &pbdev->idx, pbdev);
> +    } else {
> +        g_assert_not_reached();
>      }
>  }
>  
> @@ -956,6 +958,8 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
>          pbdev = S390_PCI_DEVICE(dev);
>          pci_dev = pbdev->pdev;
> +    } else {
> +        g_assert_not_reached();
>      }
>  
>      switch (pbdev->state) {
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

Please note that I'll be sending a bigger unplug rework the next days.

-- 

Thanks,

David / dhildenb
