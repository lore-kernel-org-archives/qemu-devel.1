Received: from eggs.gnu.org ([2001:4830:134:3::10]:33045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cTylr-00035N-8o
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cTylm-0006Ti-QM
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:31:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cTylm-0006SW-IF
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:31:54 -0500
Date: Wed, 18 Jan 2017 15:31:52 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170118153152.2869a1aa@t450s.home>
In-Reply-To: <1483175588-17006-4-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1483175588-17006-4-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v11 3/4] vfio-pci: pass the aer error
 to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, izumi.taku@jp.fujitsu.com, Chen Fan <chen.fan.fnst@cn.fujitsu.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>

On Sat, 31 Dec 2016 17:13:07 +0800
Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

> From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
> 
> When physical device has uncorrectable error hanppened, the vfio_pci
> driver will signal the uncorrectable error status register value to
> corresponding QEMU's vfio-pci device via the eventfd registered by this
> device, then, the vfio-pci's error eventfd handler will be invoked in
> event loop.
> 
> Construct and pass the aer message to root port, root port will trigger an
> interrupt to signal guest, then, the guest driver will do the recovery.
> 
> Note: Now only support non-fatal error's recovery, fatal error will
> still result in vm stop.

Please update the entire commit log, don't just add a note that this
now only covers non-fatal errors.

> 
> Signed-off-by: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  hw/vfio/pci.c | 50 ++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 76a8ac3..9861f72 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2470,21 +2470,55 @@ static void vfio_put_device(VFIOPCIDevice *vdev)
>  static void vfio_err_notifier_handler(void *opaque)
>  {
>      VFIOPCIDevice *vdev = opaque;
> +    PCIDevice *dev = &vdev->pdev;
> +    PCIEAERMsg msg = {
> +        .severity = 0,
> +        .source_id = (pci_bus_num(dev->bus) << 8) | dev->devfn,
> +    };
> +    int len;
> +    uint64_t uncor_status;
> +
> +    /* Read uncorrectable error status from driver */
> +    len = read(vdev->err_notifier.rfd, &uncor_status, sizeof(uncor_status));

Whoa this seems bogus.  In the kernel eventfd_signal() adds the value
to the internal counter.  We can't guarantee that the user is going to
immediately respond to every signal, multiple signals might occur, each
incrementing the counter.  I don't think we can use the eventfd like
this.

> +    if (len != sizeof(uncor_status)) {
> +        error_report("vfio-pci: uncor error status reading returns"
> +                     " invalid number of bytes: %d", len);
> +        return; //Or goto stop?

It's bogus use of the eventfd anyway afaict, but
event_notifier_test_and_clear() certainly handles at least EINTR.

> +    }
> +
> +    if (!(vdev->features & VFIO_FEATURE_ENABLE_AER)) {
> +        goto stop;
> +    }

I'm not sure this should be user selected anymore.

> +
> +    /* Populate the aer msg and send it to root port */
> +    if (dev->exp.aer_cap) {
> +        uint8_t *aer_cap = dev->config + dev->exp.aer_cap;
> +        bool isfatal = uncor_status &
> +                       pci_get_long(aer_cap + PCI_ERR_UNCOR_SEVER);
> +
> +	if (isfatal) {
> +	    goto stop;
> +	}

QEMU uses spaces not tabs.

> +
> +        msg.severity = isfatal ? PCI_ERR_ROOT_CMD_FATAL_EN :
> +                                 PCI_ERR_ROOT_CMD_NONFATAL_EN;

We don't get here if isfatal.

>  
> -    if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
> +        error_report("vfio-pci device %d sending AER to root port. uncor"
> +                     " status = 0x%"PRIx64, dev->devfn, uncor_status);
> +        pcie_aer_msg(dev, &msg);
>          return;
>      }
>  
> +stop:
>      /*
> -     * TBD. Retrieve the error details and decide what action
> -     * needs to be taken. One of the actions could be to pass
> -     * the error to the guest and have the guest driver recover
> -     * from the error. This requires that PCIe capabilities be
> -     * exposed to the guest. For now, we just terminate the
> -     * guest to contain the error.
> +     * Terminate the guest in case of
> +     * 1. AER capability is not exposed to guest.
> +     * 2. AER capability is exposed, but error is fatal, only non-fatal
> +     * error is handled now.

You're also currently requiring the user to enable aer per device.

>       */
>  
> -    error_report("%s(%s) Unrecoverable error detected. Please collect any data possible and then kill the guest", __func__, vdev->vbasedev.name);
> +    error_report("%s(%s) fatal error detected. Please collect any data"
> +            " possible and then kill the guest", __func__, vdev->vbasedev.name);
>  
>      vm_stop(RUN_STATE_INTERNAL_ERROR);
>  }
