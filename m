Received: from eggs.gnu.org ([2001:4830:134:3::10]:58598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCCMI-00006a-1i
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 19:33:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCCMC-0002Gj-3E
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 19:33:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gCCM8-0002Am-AN
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 19:33:02 -0400
Date: Mon, 15 Oct 2018 20:32:42 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181015233242.GB18270@habkost.net>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181015114556.152d89cd.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015114556.152d89cd.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: Provide version-specific variants
 of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Markus Armbruster <armbru@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Laine Stump <laine@redhat.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

On Mon, Oct 15, 2018 at 11:45:56AM +0200, Cornelia Huck wrote:
> On Fri, 12 Oct 2018 23:54:35 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > The current virtio-*-pci device types actually represent 3
> > different types of devices:
> > * virtio 1.0 non-transitional devices
> > * virtio 1.0 transitional devices
> > * virtio 0.9 ("legacy device" in virtio 1.0 terminology)
> > 
> > That would be just an annoyance if it didn't break our device/bus
> > compatibility QMP interfaces.  With this multi-purpose device
> > type, there's no way to tell management software that
> > transitional devices and legacy devices require a Conventional
> > PCI bus.
> > 
> > The multi-purpose device types would also prevent us from telling
> > management software what's the PCI vendor/device ID for them,
> > because their PCI IDs change at runtime depending on the bus
> > where they were is plugged.
> > 
> > This patch adds separate device types for each of those virtio
> > device flavors:
> > 
> > - virtio-*-pci: the existing multi-purpose device types
> >   - Configurable using `disable-legacy` and `disable-modern`
> >     properties
> >   - Legacy driver support is automatically enabled/disabled
> >     depending on the bus where it is plugged
> >   - Supports Conventional PCI and PCI Express buses
> >     (but Conventional PCI is incompatible with
> >     disable-legacy=off)
> >   - Changes PCI vendor/device IDs at runtime
> > - virtio-*-pci-0.9: legacy virtio device
> >   - Supports Conventional PCI buses only, because
> >     it has a PIO BAR
> > - virtio-*-pci-1.0-transitional: virtio-1.0 device supporting legacy drivers
> >   - Supports Conventional PCI buses only, because
> >     it has a PIO BAR
> > - virtio-*-pci-1.0: modern-only
> >   - Supports both Conventional PCI and PCI Express buses
> > 
> > All the types above will inherit from an abstract
> > "virtio-*-pci-base" type, so existing code that doesn't care
> > about the virtio version can use "virtio-*-pci-base" on type
> > casts.
> 
> I get a crash when running 'make check'; might be missing a change to
> virtio-input-host?
> 
> TEST: tests/device-introspect-test... (pid=28626)
>   /s390x/device/introspect/list:                                       OK
>   /s390x/device/introspect/list-fields:                                OK
>   /s390x/device/introspect/none:                                       OK
>   /s390x/device/introspect/abstract:                                   OK
>   /s390x/device/introspect/abstract-interfaces:                        OK
>   /s390x/device/introspect/concrete/defaults/none:                     /home/cohuck/git/qemu/hw/virtio/virtio-pci.c:2730:virtio_host_initfn: Object 0x5633a43a1480 is not an instance of type virtio-input-host-device-base
> Broken pipe
> /home/cohuck/git/qemu/tests/libqtest.c:125: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)

Oops.  I will fix it in v2, thanks.

> 
[...]
> > 
> > A simple test script (tests/acceptance/virtio_version.py) is
> > included, to check if the new device types are equivalent to
> > using the `disable-legacy` and `disable-modern` options.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Reference to previous discussion that originated this idea:
> >   https://www.mail-archive.com/qemu-devel@nongnu.org/msg558389.html
> > ---
> >  hw/virtio/virtio-pci.h             |  93 +++++++++---
> >  hw/display/virtio-gpu-pci.c        |   8 +-
> >  hw/display/virtio-vga.c            |  11 +-
> >  hw/virtio/virtio-crypto-pci.c      |   8 +-
> >  hw/virtio/virtio-pci.c             | 225 +++++++++++++++++++++--------
> >  tests/acceptance/virtio_version.py | 138 ++++++++++++++++++
> >  6 files changed, 390 insertions(+), 93 deletions(-)
> >  create mode 100644 tests/acceptance/virtio_version.py
> 
> The approach makes sense to me, but I second the suggestion to use
> something like 'modern' (or 'standard'?) instead of '1.0'.

As noted on the reply I sent to Michael: the whole point of this
patch is to provide unambiguous device type names.  What would be
the advantage of having another ambiguous device type named
"virtio-*-modern"?


> 
> Also, before someone asks: I don't think we need something like that
> for virtio-ccw, as we (a) only support fencing newer revisions, not
> older ones, and (b) the implications of using different virtio
> revisions are localized to virtio-ccw only and do not have further
> implications as for virtio-pci.

Thanks!  I was planning to ask about it later.  :)

-- 
Eduardo
