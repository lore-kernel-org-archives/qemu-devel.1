Received: from eggs.gnu.org ([2001:4830:134:3::10]:45245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dXa8p-0006ug-R4
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dXa8m-00025i-Na
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:34:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dXa8m-00025L-HP
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:34:48 -0400
Date: Wed, 19 Jul 2017 00:34:44 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170718235254-mutt-send-email-mst@kernel.org>
References: <20170716082917.720-1-dmitry@daynix.com>
	<09ea0b99-783f-263c-fd47-801c933fb398@redhat.com>
	<5FFD3164-EECD-4077-97DC-13924DEDFA61@daynix.com>
	<20170717195300-mutt-send-email-mst@kernel.org>
	<06941EB3-4E1A-435D-869E-8FC9E5C46EE7@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06941EB3-4E1A-435D-869E-8FC9E5C46EE7@daynix.com>
Subject: Re: [Qemu-devel] [PATCH] pci: honor PCI_COMMAND_MEMORY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Sameeh Jubran <sameeh@daynix.com>

On Tue, Jul 18, 2017 at 10:23:06AM +0300, Dmitry Fleytman wrote:
> On 17 Jul 2017, at 19:59 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> 
>     On Mon, Jul 17, 2017 at 03:48:03PM +0300, Dmitry Fleytman wrote:
> 
>         Am I understand correctly that there are no special cases for
>         IDE controllers, i.e. bus master bit must be set by SW same
>         way as for other PCI devices?
> 
> 
>     Bus mastering is typically enabled by the driver.
>     E.g. under linux:
> 
>     static int virtio_pci_restore(struct device *dev)
>     {
>            struct pci_dev *pci_dev = to_pci_dev(dev);
>            struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>            int ret;
> 
>            ret = pci_enable_device(pci_dev);
>            if (ret)
>                    return ret;
> 
>            pci_set_master(pci_dev);
>            return virtio_device_restore(&vp_dev->vdev);
>     }
> 
> 
>     As an exception, in case of BIOS booting using device ROM, it is set by
>     the ROM. E.g. src/hw/virtio-pci.c:
> 
>        vp_reset(vp);
>        pci_enable_busmaster(pci);
>        vp_set_status(vp, VIRTIO_CONFIG_S_ACKNOWLEDGE |
>                      VIRTIO_CONFIG_S_DRIVER );
> 
> 
> 
> Thanks, Michael.
> 
> After some more investigations, there are additional interesting details.
> 
> First of all, resume from hibernation succeeds without USB host controller
> (-usbtablet).
> 
> I did tracing of PCI configuration space writes and here is what I see:

All I can say is uhci confuses windows somehow.
Try another type of controller?


>     --
>     MST
> 
> 
