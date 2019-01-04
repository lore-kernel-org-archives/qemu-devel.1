Received: from eggs.gnu.org ([208.118.235.92]:37122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gfQBK-0000hd-LI
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gfQBH-0006iM-Hi
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:10:38 -0500
Date: Fri, 4 Jan 2019 15:10:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190104151005.42b6f111.cohuck@redhat.com>
In-Reply-To: <20190103151612.51399-1-liq3ea@163.com>
References: <20190103151612.51399-1-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390: avoid potential null dereference
 in s390_pcihost_unplug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: walling@linux.ibm.com, rth@twiddle.net, david@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org

On Thu,  3 Jan 2019 07:16:12 -0800
Li Qiang <liq3ea@163.com> wrote:

> When getting the 'pbdev', the if...else has no default branch.
> From Coverity, the 'pbdev' maybe null when the 'dev' is not
> the TYPE_PCI_BRIDGE/TYPE_PCI_DEVICE/TYPE_S390_PCI_DEVICE.
> This patch adds a default branch for device plug and unplug.
> 
> Spotted by Coverity: CID 1398593
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
> Adds a default branch for device plug per Cornelia's review.
> 
>  hw/s390x/s390-pci-bus.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 15759b6514..fe48a36ff6 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -912,6 +912,9 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>          pbdev->fh = pbdev->idx;
>          QTAILQ_INSERT_TAIL(&s->zpci_devs, pbdev, link);
>          g_hash_table_insert(s->zpci_table, &pbdev->idx, pbdev);
> +    } else {
> +        error_setg(errp, "s390: device plug request for not supported device"
> +                   " type: %s", object_get_typename(OBJECT(dev)));

Maybe make this "s390/pci: plugging device type <%s> is not supported"?

>      }
>  }
>  
> @@ -956,6 +959,10 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
>          pbdev = S390_PCI_DEVICE(dev);
>          pci_dev = pbdev->pdev;
> +    } else {
> +        error_setg(errp, "s390: device unplug request for not supported device"
> +                   " type: %s", object_get_typename(OBJECT(dev)));

Halil has a point when he suggests an assert here. If we fence the
device type in the plug function, I can't think of a way we would end
up here.

> +        return;
>      }
>  
>      switch (pbdev->state) {
