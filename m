Received: from eggs.gnu.org ([208.118.235.92]:45382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gfS1v-0006Yh-TB
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gfS1s-0003rd-P2
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:09:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gfS1s-0003r7-Gx
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:09:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCA60C067821
	for <qemu-devel@nongnu.org>; Fri,  4 Jan 2019 16:08:59 +0000 (UTC)
Date: Fri, 4 Jan 2019 14:08:54 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190104160854.GE4157@habkost.net>
References: <20190104032226.21428-1-ehabkost@redhat.com>
	<20190103232012-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103232012-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] compat: Use explicit type names on
 HW_COMPAT_2_6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On Thu, Jan 03, 2019 at 11:23:45PM -0500, Michael S. Tsirkin wrote:
> On Fri, Jan 04, 2019 at 01:22:26AM -0200, Eduardo Habkost wrote:
> > The virtio-pci entries in HW_COMPAT_2_6 had an implicit
> > assumption: that all virtio-pci subclasses support the
> > disable-legacy and disable-modern options.
> > 
> > That assumption was broken by commit f6e501a28ef9 ("virtio:
> > Provide version-specific variants of virtio PCI devices").  This
> > caused QEMU to crash if using the new -non-transitional or
> > -transitional device types:
> > 
> >   $ qemu-system-x86_64 -machine pc-i440fx-2.6 \
> >     -device virtio-net-pci-non-transitional
> >   Unexpected error in object_property_find() at qom/object.c:1092:
> >   qemu-system-x86_64: -device virtio-net-pci-non-transitional: can't apply \
> >   global virtio-pci.disable-modern=on: Property '.disable-modern' not found
> >   Aborted (core dumped)
> > 
> > Replace the virtio-pci.disable-legacy=off and
> > virtio-pci.disable-modern=on entries on HW_COMPAT_2_6 with
> > explicit entries for each generic virtio device type.
> > 
> > The full list of generic virtio device types was extracted by
> > just grepping for ".generic_name".  Note that we don't need to
> > worry about listing new virtio-pci devices in HW_COMPAT_2_6 in
> > the future, because new devices won't require QEMU 2.6
> > compatibility.
> 
> I fully expect that e.g. packed ring support will need
> to affect all virtio devices too. And it's likely
> that we'll have some new virtio-pci transport features too.

If you need to affect all virtio devices, you can still use
.driver="virtio-pci" on compat_props.  This is just about the
disable-legacy and disable-modern properties.

> 
> > This makes the compat entries annoyingly verbose, but is simpler
> > than the alternative of making the virtio-pci type inheritance
> > rules even more complex.
> 
> God forbid we forgot something, the only way to notice is to
> run a cross version migration with an old qemu.
> I think we need to come up with something less verbose and fragile.

Both approaches can break if we forget something or do something
wrong.  I don't think this one is more fragile than the others.

The difference is that this one lets us list the device types
once on compat_props and never think about it again.  The others
would require us to worry forever about subtle interactions
between the disable-modern/disable-legacy properties and QOM
inheritance.

> 
> 
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > ---
> >  include/hw/compat.h | 140 +++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 138 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/hw/compat.h b/include/hw/compat.h
> > index 3ca85b037c..fbb6c1138a 100644
> > --- a/include/hw/compat.h
> > +++ b/include/hw/compat.h
> > @@ -163,11 +163,147 @@
> >          .property = "format_transport_address",\
> >          .value    = "off",\
> >      },{\
> > -        .driver   = "virtio-pci",\
> > +        .driver   = "vhost-scsi-pci",\
> >          .property = "disable-modern",\
> >          .value    = "on",\
> >      },{\
> > -        .driver   = "virtio-pci",\
> > +        .driver   = "vhost-scsi-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "vhost-user-blk-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "vhost-user-blk-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "vhost-user-scsi-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "vhost-user-scsi-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "vhost-vsock-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "vhost-vsock-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "virtio-9p-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "virtio-9p-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "virtio-balloon-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "virtio-balloon-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "virtio-blk-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "virtio-blk-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "virtio-crypto-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "virtio-crypto-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "virtio-gpu-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "virtio-gpu-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "virtio-input-host-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "virtio-input-host-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "virtio-keyboard-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "virtio-keyboard-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "virtio-mouse-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "virtio-mouse-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "virtio-net-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "virtio-net-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "virtio-rng-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "virtio-rng-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "virtio-scsi-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "virtio-scsi-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "virtio-serial-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "virtio-serial-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "virtio-tablet-pci",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "virtio-tablet-pci",\
> > +        .property = "disable-legacy",\
> > +        .value    = "off",\
> > +    },{\
> > +        .driver   = "virtio-vga",\
> > +        .property = "disable-modern",\
> > +        .value    = "on",\
> > +    },{\
> > +        .driver   = "virtio-vga",\
> >          .property = "disable-legacy",\
> >          .value    = "off",\
> >      },
> > -- 
> > 2.18.0.rc1.1.g3f1ff2140

-- 
Eduardo
