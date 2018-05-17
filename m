Received: from eggs.gnu.org ([2001:4830:134:3::10]:36133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6682a862c=anthony.perard@citrix.com>)
	id 1fJLny-0003XK-Ep
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6682a862c=anthony.perard@citrix.com>)
	id 1fJLnu-0002Ql-BQ
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:31:02 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:43722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=6682a862c=anthony.perard@citrix.com>)
	id 1fJLnu-0002QT-1x
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:30:58 -0400
Date: Thu, 17 May 2018 17:30:53 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180517163053.GN2057@perard.uk.xensource.com>
References: <1525346320-24553-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1525346320-24553-1-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] xen-hvm: stop faking I/O to access PCI
 config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, May 03, 2018 at 12:18:40PM +0100, Paul Durrant wrote:
> This patch removes the current hackery where IOREQ_TYPE_PCI_CONFIG
> reqyests are handled by faking PIO to 0xcf8 and 0xcfc and replaces it

  ^ requests

> with direct calls to pci_host_config_read/write_common().
> Doing so necessitates mapping BDFs to PCIDevices but maintaining a simple
> QLIST in xen_device_realize/unrealize() will suffice.
> 
> NOTE: whilst config space accesses are currently limited to
>       PCI_CONFIG_SPACE_SIZE, this patch paves the way to increasing the
>       limit to PCIE_CONFIG_SPACE_SIZE when Xen gains the ability to
>       emulate MCFG table accesses.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

> +static void cpu_ioreq_config(XenIOState *state, ioreq_t *req)
> +{
> +    uint32_t sbdf = req->addr >> 32;
> +    uint32_t reg = req->addr;
> +    XenPciDevice *xendev;
> +
> +    if (req->size > sizeof(uint32_t)) {
> +        hw_error("PCI config access: bad size (%u)", req->size);
> +    }
> +
> +    QLIST_FOREACH(xendev, &state->dev_list, entry) {
> +        unsigned int i;
> +
> +        if (xendev->sbdf != sbdf) {
> +            continue;
> +        }
> +
> +        if (req->dir == IOREQ_READ) {
> +            if (!req->data_is_ptr) {
> +                req->data = pci_host_config_read_common(
> +                    xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE,
> +                    req->size);
> +                trace_cpu_ioreq_config_read(req, sbdf, reg, req->size,
> +                                            req->data);
> +            } else {
> +                for (i = 0; i < req->count; i++) {
> +                    uint32_t tmp;
> +
> +                    tmp = pci_host_config_read_common(
> +                        xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE,
> +                        req->size);

So, if data is a pointer, we just keep reading the same address
req->count time?

> +                    write_phys_req_item(req->data, req, i, &tmp);
> +                }
> +            }
> +        } else if (req->dir == IOREQ_WRITE) {
> +            if (!req->data_is_ptr) {
> +                trace_cpu_ioreq_config_write(req, sbdf, reg, req->size,
> +                                             req->data);
> +                pci_host_config_write_common(
> +                    xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE, req->data,
> +                    req->size);
> +            } else {
> +                for (i = 0; i < req->count; i++) {
> +                    uint32_t tmp = 0;
> +
> +                    read_phys_req_item(req->data, req, i, &tmp);
> +                    pci_host_config_write_common(
> +                        xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE, tmp,
> +                        req->size);
> +                }
> +            }
> +        }
> +    }
> +}

-- 
Anthony PERARD
