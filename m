Received: from eggs.gnu.org ([2001:4830:134:3::10]:53212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f4P0w-0000L0-34
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f4P0r-0004rM-3j
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:54:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38024 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f4P0q-0004q0-T2
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:54:33 -0400
Date: Fri, 6 Apr 2018 12:54:22 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180406105422.6tewkkciwerud3tm@sirius.home.kraxel.org>
References: <20180313154826.20436-1-kraxel@redhat.com>
	<20180313161035.GL4788@phenom.ffwll.local>
	<20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
	<CAPj87rPKtuQ4SZePYDUesWY9VSSGR=1p-LO=yByY_6Q8=BfoyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAPj87rPKtuQ4SZePYDUesWY9VSSGR=1p-LO=yByY_6Q8=BfoyA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RfC PATCH] Add udmabuf misc device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>

On Fri, Apr 06, 2018 at 10:52:21AM +0100, Daniel Stone wrote:
> Hi Gerd,
>=20
> On 14 March 2018 at 08:03, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >> Either mlock account (because it's mlocked defacto), and get_user_pa=
ges
> >> won't do that for you.
> >>
> >> Or you write the full-blown userptr implementation, including mmu_no=
tifier
> >> support (see i915 or amdgpu), but that also requires Christian K=F6n=
igs
> >> latest ->invalidate_mapping RFC for dma-buf (since atm exporting use=
rptr
> >> buffers is a no-go).
> >
> > I guess I'll look at mlock accounting for starters then.  Easier for
> > now, and leaves the door open to switch to userptr later as this shou=
ld
> > be transparent to userspace.
>=20
> Out of interest, do you have usecases for full userptr support? Maybe
> another way would be to allow creation of dmabufs from memfds.

I have two things in mind.

One is vga emulation.  I have virtual pci memory bar for the virtual
vga.  qemu backs vga memory with anonymous pages right now, switching
that to shmem should be easy though if that makes things easier.  Guest
places the framebuffer somewhere in the pci bar, and I want export the
chunk which represents the framebuffer as dma-buf to display it on the
host without copying around data.  Framebuffer is linear in guest
physical memory, so a single block only.  That is the simpler case.

The more difficuilt one is virtio-gpu ressources.  virtio-gpu resources
live in host memory (guest has no direct access).  The guest can
optionally specify guest memory pages as backing storage for the
resource.  Guest backing storage is allowed to be scattered.  Commands
exist to copy both ways between host storage and guest backing.

With virgl (opengl acceleration) enabled the guest will send rendering
commands to fill the framebuffer ressource, so there is no need to copy
content to the framebuffer ressource.  The guest may fill other
resources such as textures used for rendering with copy commands.

Without acceleration the guest does software-rendering to the backing
storage, then sends a command to copy the framebuffer content from guest
backing storage to host ressource.

Now it would be useful to allow a shared mapping, so no copying between
guest backing storage and host resource is needed, especially for the
software rendering case (i.e. dumb gem buffers).  Being able to export
guest dumb buffers to other host processes would be useful too, for
example to display guest windows seamlessly on the host wayland server.

So getting a dma-buf for the guest backing storage via udmabuf looked
like a useful approach.  We can export the guest gem buffers to other
host processes that way.  qemu itself could map it too, to get a linear
representation of the scattered guest backing storage.

The other obvious approach would be to do it the other way around and
allow the guest map the host resource somehow.  On the host side qemu
could use vgem to allocate resource memory, so it'll be a gem object
already.  Mapping that into the guest isn't that straight-forward
though.  The guest manages its physical address space, so the guest
would need to find a free spot and ask the host to place the resource
there.  Then the guest needs page structs covering the mapped resource,
so it can work with it.  Didn't investigate how difficuilt that is.  Use
memory hotplug maybe?  Can we easily unmap the resource then?  Also I
think updating the guests physical memory layout (which we would need to
do on every resource map/unmap) isn't an exactly cheap operation ...

cheers,
  Gerd
