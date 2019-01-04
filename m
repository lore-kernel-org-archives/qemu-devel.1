Received: from eggs.gnu.org ([208.118.235.92]:50428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gfTgH-0006Gn-GW
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gfTgE-0001sV-C0
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:54:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gfTgE-0001oI-4l
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:54:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DC0A85A07
	for <qemu-devel@nongnu.org>; Fri,  4 Jan 2019 17:54:45 +0000 (UTC)
Date: Fri, 4 Jan 2019 15:54:39 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190104175439.GH4157@habkost.net>
References: <20190104032226.21428-1-ehabkost@redhat.com>
	<20190103232012-mutt-send-email-mst@kernel.org>
	<20190104101200.GA2494@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104101200.GA2494@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On Fri, Jan 04, 2019 at 10:12:00AM +0000, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Fri, Jan 04, 2019 at 01:22:26AM -0200, Eduardo Habkost wrote:
> > > The virtio-pci entries in HW_COMPAT_2_6 had an implicit
> > > assumption: that all virtio-pci subclasses support the
> > > disable-legacy and disable-modern options.
> > > 
> > > That assumption was broken by commit f6e501a28ef9 ("virtio:
> > > Provide version-specific variants of virtio PCI devices").  This
> > > caused QEMU to crash if using the new -non-transitional or
> > > -transitional device types:
> > > 
> > >   $ qemu-system-x86_64 -machine pc-i440fx-2.6 \
> > >     -device virtio-net-pci-non-transitional
> > >   Unexpected error in object_property_find() at qom/object.c:1092:
> > >   qemu-system-x86_64: -device virtio-net-pci-non-transitional: can't apply \
> > >   global virtio-pci.disable-modern=on: Property '.disable-modern' not found
> > >   Aborted (core dumped)
> > > 
> > > Replace the virtio-pci.disable-legacy=off and
> > > virtio-pci.disable-modern=on entries on HW_COMPAT_2_6 with
> > > explicit entries for each generic virtio device type.
> > > 
> > > The full list of generic virtio device types was extracted by
> > > just grepping for ".generic_name".  Note that we don't need to
> > > worry about listing new virtio-pci devices in HW_COMPAT_2_6 in
> > > the future, because new devices won't require QEMU 2.6
> > > compatibility.
> > 
> > I fully expect that e.g. packed ring support will need
> > to affect all virtio devices too. And it's likely
> > that we'll have some new virtio-pci transport features too.
> > 
> > > This makes the compat entries annoyingly verbose, but is simpler
> > > than the alternative of making the virtio-pci type inheritance
> > > rules even more complex.
> > 
> > God forbid we forgot something, the only way to notice is to
> > run a cross version migration with an old qemu.
> > I think we need to come up with something less verbose and fragile.
> 
> I guess we could use a script like tests/acceptance/virtio_version.py to
> do a check?

That's a good idea.  On test code we can try additional tricks to
detect the hybrid virtio devices without increasing the
complexity of QEMU code.  I'll give it a try.

> 
> As for something less verbose, I guess something is doable with a few
> macros (more complex but less verbose); or I guess you could add these
> properties to the other devices but just refuse to operate when they
> were set the wrong way.

Adding the properties to all virtio-pci devices is the kind of
complexity I would like to avoid.  If we need to define rules for
when disable-modern/disable-legacy is set to unexpected values,
we'll have to maintain the code that implement those rules
forever.

-- 
Eduardo
