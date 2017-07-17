Received: from eggs.gnu.org ([2001:4830:134:3::10]:58356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dX9NJ-0000xU-1d
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dX9NE-0006KA-5s
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:00:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dX9NE-0006Jb-0K
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:59:56 -0400
Date: Mon, 17 Jul 2017 19:59:52 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170717195300-mutt-send-email-mst@kernel.org>
References: <20170716082917.720-1-dmitry@daynix.com>
	<09ea0b99-783f-263c-fd47-801c933fb398@redhat.com>
	<5FFD3164-EECD-4077-97DC-13924DEDFA61@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FFD3164-EECD-4077-97DC-13924DEDFA61@daynix.com>
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

On Mon, Jul 17, 2017 at 03:48:03PM +0300, Dmitry Fleytman wrote:
> Am I understand correctly that there are no special cases for
> IDE controllers, i.e. bus master bit must be set by SW same
> way as for other PCI devices?

Bus mastering is typically enabled by the driver.
E.g. under linux:

static int virtio_pci_restore(struct device *dev)
{
        struct pci_dev *pci_dev = to_pci_dev(dev);
        struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
        int ret;

        ret = pci_enable_device(pci_dev);
        if (ret)
                return ret;

        pci_set_master(pci_dev);
        return virtio_device_restore(&vp_dev->vdev);
}


As an exception, in case of BIOS booting using device ROM, it is set by
the ROM. E.g. src/hw/virtio-pci.c:

    vp_reset(vp);
    pci_enable_busmaster(pci);
    vp_set_status(vp, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                  VIRTIO_CONFIG_S_DRIVER );


-- 
MST
