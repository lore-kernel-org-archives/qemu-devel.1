Received: from eggs.gnu.org ([2001:4830:134:3::10]:54637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRcnW-00005X-He
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRcnT-0007fx-71
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:49:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gRcnS-0007f6-Ud
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:48:59 -0500
Date: Tue, 27 Nov 2018 10:48:27 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181127124827.GZ18284@habkost.net>
References: <20181127024959.7060-1-ehabkost@redhat.com>
	<20181127024959.7060-2-ehabkost@redhat.com>
	<20181127114523.646bcb29.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127114523.646bcb29.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 1/2] virtio: Helper for
 registering virtio device types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Amit Shah <amit@kernel.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Max Reitz <mreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Tue, Nov 27, 2018 at 11:45:23AM +0100, Cornelia Huck wrote:
> On Tue, 27 Nov 2018 00:49:58 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > Introduce a helper for registering different flavours of virtio
> > devices.  Convert code to use the helper, but keep only the
> > existing generic types.  Transitional and non-transitional device
> > types will be added by another patch.
> > 
> > Acked-by: Andrea Bolognani <abologna@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Changes v2 -> v3:
> > * Split into two separate patches (type registration helper
> >   and introduction of new types)
> > * Rewrote comments describing each flavour
> > * Rewrote virtio_pci_types_register() completely:
> >   * Replaced magic generation of type names with explicit fields in
> >     VirtioPCIDeviceTypeInfo
> >   * Removed modern_only field (won't be used anymore)
> >   * Don't register a separate base type unless it's required by
> >     the caller
> > ---
> >  hw/virtio/virtio-pci.h        |  54 ++++++++
> >  hw/display/virtio-gpu-pci.c   |   7 +-
> >  hw/display/virtio-vga.c       |   7 +-
> >  hw/virtio/virtio-crypto-pci.c |   7 +-
> >  hw/virtio/virtio-pci.c        | 231 ++++++++++++++++++++++++----------
> >  5 files changed, 228 insertions(+), 78 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> > index 813082b0d7..b26731a305 100644
> > --- a/hw/virtio/virtio-pci.h
> > +++ b/hw/virtio/virtio-pci.h
> > @@ -417,4 +417,58 @@ struct VirtIOCryptoPCI {
> >  /* Virtio ABI version, if we increment this, we break the guest driver. */
> >  #define VIRTIO_PCI_ABI_VERSION          0
> >  
> > +/* Input for virtio_pci_types_register() */
> > +typedef struct VirtioPCIDeviceTypeInfo {
> > +    /*
> > +     * Common base class for the subclasses below.
> > +     *
> > +     * Required only if transitional_name or non_transitional_name is set.
> > +     *
> > +     * We need a separate base type instead of making all types
> > +     * inherit from generic_name for two reasons:
> > +     * 1) generic_name implements INTERFACE_PCIE_DEVICE, but
> > +     *    transitional_name don't.
> 
> s/don't/does not/

Fixed, thanks!

> 
> > +     * 2) generic_name has the "disable-legacy" and "disable-modern"
> > +     *    properties, transitional_name and non_transitional name don't.
> > +     */
> > +    const char *base_name;
> > +    /*
> > +     * Generic device type.  Optional.
> > +     *
> > +     * Supports both transitional and non-transitional modes,
> > +     * using the disable-legacy and disable-modern properties.
> > +     * If disable-legacy=auto, (non-)transitional mode is selected
> > +     * depending on the bus where the device is plugged.
> > +     *
> > +     * Implements both INTERFACE_PCIE_DEVICE and INTERFACE_CONVENTIONAL_PCI_DEVICE,
> > +     * but PCI Express is supported only in non-transitional mode.
> > +     *
> > +     * The only type implemented by QEMU 3.1 and older.
> > +     */
> > +    const char *generic_name;
> > +    /*
> > +     * The non-transitional device type.  Optional.
> 
> That's transitional...

Oops.  Fixed, thanks!

> 
> > +     *
> > +     * Implements both INTERFACE_PCIE_DEVICE and INTERFACE_CONVENTIONAL_PCI_DEVICE.
> > +     */
> > +    const char *transitional_name;
> > +    /*
> > +     * The transitional device type.  Optional.
> 
> ...and that's non-transitional :)

Oops.  Fixed, thanks!

> 
> > +     *
> > +     * Implements INTERFACE_CONVENTIONAL_PCI_DEVICE only.
> > +     */
> > +    const char *non_transitional_name;
> > +
> > +    /* Parent type.  If NULL, TYPE_VIRTIO_PCI is used */
> > +    const char *parent;
> > +
> > +    /* Same as TypeInfo fields: */
> > +    size_t instance_size;
> > +    void (*instance_init)(Object *obj);
> > +    void (*class_init)(ObjectClass *klass, void *data);
> > +} VirtioPCIDeviceTypeInfo;
> 
> That's a bit of boilerplate, but the end result seems to be more
> greppable.

Right.  Also, only old devices that have transitional versions
will need to use all fields.  The modern-only devices now
have less boilerplate (because parent is optional).

> 
> > +
> > +/* Register virtio-pci type(s).  @t must be static. */
> > +void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t);
> > +
> >  #endif
> 
> (...)
> 
> Looks sane to me. With the typos fixed,
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks!

-- 
Eduardo
