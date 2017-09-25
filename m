Received: from eggs.gnu.org ([2001:4830:134:3::10]:36912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dwTix-0001Ln-0o
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dwTiw-0002CO-1U
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:47:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dwTiv-0002C9-Oo
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:47:01 -0400
Date: Mon, 25 Sep 2017 15:46:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170925154647.357047b9@nial.brq.redhat.com>
In-Reply-To: <20170925133153.GZ3030@localhost.localdomain>
References: <1506071794-4373-1-git-send-email-thuth@redhat.com>
	<20170925135316.74fed6da.cohuck@redhat.com>
	<20170925133153.GZ3030@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>

On Mon, 25 Sep 2017 10:31:53 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Sep 25, 2017 at 01:53:16PM +0200, Cornelia Huck wrote:
> > On Fri, 22 Sep 2017 11:16:34 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> > > Historically we've marked all devices as hotpluggable by default. However,
> > > most devices are not hotpluggable, and you also need a HotplugHandler to
> > > support these devices. So if the user tries to "device_add" or "device_del"
> > > such a non-hotpluggable device during runtime, either nothing really usable
> > > happens, or QEMU even crashes/aborts unexpectedly (see for example commit
> > > 84ebd3e8c7d4fe955b - "Mark diag288 watchdog as non-hotpluggable").
> > > So let's change this dangerous default behaviour and mark the devices as
> > > non-hotpluggable by default. Certain parent devices classes which are known
> > > as hotpluggable (e.g. PCI, USB, etc.) are marked with "hotpluggable = true",
> > > so that devices that are derived from these classes continue to work as
> > > expected.
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >  v2: Add missing devices and dropped "RFC" status. See Eduardo's reply on
> > >  the previous version of this patch for the rationale which devices need
> > >  to be hotpluggable:
> > >  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg06128.html
> > > 
> > >  hw/char/virtio-serial-bus.c   |  1 +
> > >  hw/core/qdev.c                | 10 ++++------
> > >  hw/mem/nvdimm.c               |  3 +++
> > >  hw/mem/pc-dimm.c              |  1 +
> > >  hw/pci/pci.c                  |  1 +
> > >  hw/ppc/spapr_cpu_core.c       |  1 +
> > >  hw/s390x/ccw-device.c         |  1 +
> > >  hw/scsi/scsi-bus.c            |  1 +
> > >  hw/usb/bus.c                  |  1 +
> > >  hw/usb/dev-smartcard-reader.c |  1 +
> > >  hw/xen/xen_backend.c          |  1 +
> > >  target/i386/cpu.c             |  4 ++--
> > >  target/s390x/cpu.c            |  1 +
> > >  13 files changed, 19 insertions(+), 8 deletions(-)  
> > 
> > Hm, this seems to break hotplug of virtio devices:
> > 
> > (qemu) device_add virtio-net-pci,id=xxx
> > Device 'virtio-net-device' does not support hotplugging
> > 
> > (qemu) device_add virtio-net-ccw,id=yyy
> > Device 'virtio-net-device' does not support hotplugging
> > 
> > We probably need to enable hotplug for virtio devices as well?  
> 
> I've seen a similar case broken by "[PATCH] hw/core/qdev: Do not
> allow hot-plugging without hotplug controller", because we're
> blocking creation of devices created internally by other devices,
> not just the ones created by device_add.  I need to find the
> exact reproducer again.
> 
> It would probably simplify things if we move the check for
> DeviceClass::hotpluggable to qmp_device_add(), instead of
> device_set_realized().
if we would have to do that, than we are probably doing
something wrong and not using property right. Perhaps we
should fix property instead of trying find a place to check
it where it would hurt less.
