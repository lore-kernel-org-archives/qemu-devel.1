Received: from eggs.gnu.org ([2001:4830:134:3::10]:60062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRRUT-0000e9-5p
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 19:44:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRRLx-0004fx-W5
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 19:35:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gRRLx-0004en-OM
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 19:35:49 -0500
Date: Mon, 26 Nov 2018 22:35:25 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181127003525.GA8807@habkost.net>
References: <20181114233831.10374-1-ehabkost@redhat.com>
	<20181115122155.7a15df7d.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115122155.7a15df7d.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, Andrea Bolognani <abologna@redhat.com>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Thu, Nov 15, 2018 at 12:21:55PM +0100, Cornelia Huck wrote:
> On Wed, 14 Nov 2018 21:38:31 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> > index 813082b0d7..1d2a11504f 100644
> > --- a/hw/virtio/virtio-pci.h
> > +++ b/hw/virtio/virtio-pci.h
> 
> (...)
> 
> > +/**
> > + * VirtioPCIDeviceTypeInfo:
> > + *
> > + * Template for virtio PCI device types.  See virtio_pci_types_register()
> > + * for details.
> > + */
> > +typedef struct VirtioPCIDeviceTypeInfo {
> > +    /* Prefix for the class names */
> > +    const char *name_prefix;
> 
> <bikeshed>Maybe call this the vpci_name instead? It's not really a
> prefix in the way I would usually use the term, but rather a type name
> with a possible suffix tacked onto it.</bikeshed>

I'm considering getting rid of all magic type name generation,
and make the struct explicit list all the type names to be
registered.  This way people won't be confused when grepping the
code for the type names.


> 
> > +    /* Parent type.  If NULL, TYPE_VIRTIO_PCI is used */
> > +    const char *parent;
> > +    /* If modern_only is true, only <name_prefix> type will be registered */
> > +    bool modern_only;
> > +
> > +    /* Same as TypeInfo fields: */
> > +    size_t instance_size;
> > +    void (*instance_init)(Object *obj);
> > +    void (*class_init)(ObjectClass *klass, void *data);
> > +} VirtioPCIDeviceTypeInfo;
> > +
> > +/*
> > + * Register virtio-pci types.  Each virtio-pci device type will be available
> > + * in 3 flavors:
> > + * - <prefix>-transitional: modern device supporting legacy drivers
> > + *   - Supports Conventional PCI buses only
> > + * - <prefix>-non-transitional: modern-only
> > + *   - Supports Conventional PCI and PCI Express buses
> > + * - <prefix>: virtio version configurable, legacy driver support
> > + *                  automatically selected when device is plugged
> > + *   _ This was the only flavor supported until QEMU 3.1
> 
> s/_/-/
> s/until/up to/ ?

Done.  Thanks!

> 
> > + *   - Supports Conventional PCI and PCI Express buses
> > + *
> > + * All the types above will inherit from "<prefix>-base", so generic
> > + * code can use "<prefix>-base" on type casts.
> > + *
> > + * We need a separate "<prefix>-base" type instead of making all types inherit
> > + * from <prefix> for two reasons:
> > + * 1) <prefix> will implement INTERFACE_PCIE_DEVICE, but
> > + *    <prefix>-transitional won't.
> > + * 2) <prefix> will have the "disable-legacy" and "disable-modern" properties,
> > + *    <prefix>-transitional and <prefix>-non-transitional won't.
> 
> <bikeshed>I'd formulate this rather as "x implements/has something, y
> and z do not", as the code actually does that (and does not just intend
> to do so :)</bikeshed>

Done.  Thanks!

> 
> > + */
> > +void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t);
> > +
> >  #endif
> 
> (...)
> 
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index a954799267..0fa248d68c 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> 
> (...)
> 
> > +static void virtio_pci_1_0_instance_init(Object *obj)
> 
> Ditch the _0? I don't expect this to change the name when virtio 1.1
> arrives.

I was going to rename this to
virtio_pci_non_transitional_instance_init() for consistency, but
I forgot.  Thanks for noting.

> 
> > +{
> > +    VirtIOPCIProxy *proxy = VIRTIO_PCI(obj);
> > +
> > +    proxy->disable_legacy = ON_OFF_AUTO_ON;
> > +    proxy->disable_modern = false;
> > +}
> 
> (...)
> 
> After a quick look, this seems fine; have not actually tried to run it
> yet.

-- 
Eduardo
