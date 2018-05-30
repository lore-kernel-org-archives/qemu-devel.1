Received: from eggs.gnu.org ([2001:4830:134:3::10]:46734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1fNvqo-00056W-70
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1fNvqk-00007y-AZ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:48:54 -0400
Date: Wed, 30 May 2018 09:48:39 +0200
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20180530074839.GB28893@erzo-ntb>
References: <20180529151753.22912.14813.stgit@gimli.home>
	<20180529092408.2803fe05@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180529092408.2803fe05@w520.home>
Subject: Re: [Qemu-devel] [PATCH] vfio/pci: Default display option to "off"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

On Tue, May 29, 2018 at 09:24:08AM -0600, Alex Williamson wrote:
> [Cc +Erik,libvirt]
>
> Sorry, should have cc'd libvirt with this initially since display
> support is under development.  I think "off" is the better
> compatibility option, but perhaps the damage is done since it was the
> 2.12 default.  Thanks,

Thanks for CC'ing me. So, the approach I took with the initial design to be
sent as an RFC is to default to display=off in libvirt. My implementation is
lacking support for display=auto, solely because the way libvirt would need to
get all the information about devices was cumbersome - whether it uses dmabuf
or vfio regions ergo not guessing whether a missing gl=on signals dmabuf or it
was just a mistake. Therefore, we're going to default to use egl-headless unless
explicitly asked to turn on OpenGL. Back to the 'auto' value, it would also mean
for libvirt to make policy decisions which is not what libvirt's supposed to do
plus in this case it's difficult for any layer to guess what user's intention
with the device was, whether it was supposed to be used for graphics or not.
We can add support for 'auto' once there are compelling reasons for us to do so
and the overall consensus is in favour of implementing that, however, we
wouldn't change the display=off default anyway, since it's much safer for us.

Erik

>
> Alex
>
> On Tue, 29 May 2018 09:18:10 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
>
> > Commit a9994687cb9b ("vfio/display: core & wireup") added display
> > support to vfio-pci with the default being "auto", which breaks
> > existing VMs when the vGPU requires GL support but had no previous
> > requirement for a GL compatible configuration.  "Off" is the safer
> > default as we impose no new requirements to VM configurations.
> >
> > Fixes: a9994687cb9b ("vfio/display: core & wireup")
> > Cc: qemu-stable@nongnu.org
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  hw/vfio/pci.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 84e27c7bb2d1..18c493b49ec1 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -3160,7 +3160,7 @@ static Property vfio_pci_dev_properties[] = {
> >      DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
> >      DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
> >      DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
> > -                            display, ON_OFF_AUTO_AUTO),
> > +                            display, ON_OFF_AUTO_OFF),
> >      DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
> >                         intx.mmap_timeout, 1100),
> >      DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
> >
>
