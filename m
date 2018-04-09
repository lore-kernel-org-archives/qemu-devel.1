Received: from eggs.gnu.org ([2001:4830:134:3::10]:53492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel@ffwll.ch>) id 1f5RjV-0000Xv-6H
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel@ffwll.ch>) id 1f5RjT-0004PS-QI
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:00:57 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:35287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <daniel@ffwll.ch>) id 1f5RjT-0004Ma-EN
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:00:55 -0400
Received: by mail-wm0-x233.google.com with SMTP id r82so14702315wme.0
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 01:00:54 -0700 (PDT)
Sender: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 9 Apr 2018 10:00:51 +0200
From: Daniel Vetter <daniel@ffwll.ch>
Message-ID: <20180409080051.GD31310@phenom.ffwll.local>
References: <20180313154826.20436-1-kraxel@redhat.com>
	<20180313161035.GL4788@phenom.ffwll.local>
	<20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
	<CAPj87rPKtuQ4SZePYDUesWY9VSSGR=1p-LO=yByY_6Q8=BfoyA@mail.gmail.com>
	<20180406105422.6tewkkciwerud3tm@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180406105422.6tewkkciwerud3tm@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [RfC PATCH] Add udmabuf misc device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel Stone <daniel@fooishbar.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, qemu-devel@nongnu.org, dri-devel <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>

On Fri, Apr 06, 2018 at 12:54:22PM +0200, Gerd Hoffmann wrote:
> On Fri, Apr 06, 2018 at 10:52:21AM +0100, Daniel Stone wrote:
> > Hi Gerd,
> > 
> > On 14 March 2018 at 08:03, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >> Either mlock account (because it's mlocked defacto), and get_user_pages
> > >> won't do that for you.
> > >>
> > >> Or you write the full-blown userptr implementation, including mmu_notifier
> > >> support (see i915 or amdgpu), but that also requires Christian Königs
> > >> latest ->invalidate_mapping RFC for dma-buf (since atm exporting userptr
> > >> buffers is a no-go).
> > >
> > > I guess I'll look at mlock accounting for starters then.  Easier for
> > > now, and leaves the door open to switch to userptr later as this should
> > > be transparent to userspace.
> > 
> > Out of interest, do you have usecases for full userptr support? Maybe
> > another way would be to allow creation of dmabufs from memfds.
> 
> I have two things in mind.
> 
> One is vga emulation.  I have virtual pci memory bar for the virtual
> vga.  qemu backs vga memory with anonymous pages right now, switching
> that to shmem should be easy though if that makes things easier.  Guest
> places the framebuffer somewhere in the pci bar, and I want export the
> chunk which represents the framebuffer as dma-buf to display it on the
> host without copying around data.  Framebuffer is linear in guest
> physical memory, so a single block only.  That is the simpler case.
> 
> The more difficuilt one is virtio-gpu ressources.  virtio-gpu resources
> live in host memory (guest has no direct access).  The guest can
> optionally specify guest memory pages as backing storage for the
> resource.  Guest backing storage is allowed to be scattered.  Commands
> exist to copy both ways between host storage and guest backing.
> 
> With virgl (opengl acceleration) enabled the guest will send rendering
> commands to fill the framebuffer ressource, so there is no need to copy
> content to the framebuffer ressource.  The guest may fill other
> resources such as textures used for rendering with copy commands.
> 
> Without acceleration the guest does software-rendering to the backing
> storage, then sends a command to copy the framebuffer content from guest
> backing storage to host ressource.
> 
> Now it would be useful to allow a shared mapping, so no copying between
> guest backing storage and host resource is needed, especially for the
> software rendering case (i.e. dumb gem buffers).  Being able to export
> guest dumb buffers to other host processes would be useful too, for
> example to display guest windows seamlessly on the host wayland server.
> 
> So getting a dma-buf for the guest backing storage via udmabuf looked
> like a useful approach.  We can export the guest gem buffers to other
> host processes that way.  qemu itself could map it too, to get a linear
> representation of the scattered guest backing storage.
> 
> The other obvious approach would be to do it the other way around and
> allow the guest map the host resource somehow.  On the host side qemu
> could use vgem to allocate resource memory, so it'll be a gem object
> already.  Mapping that into the guest isn't that straight-forward
> though.  The guest manages its physical address space, so the guest
> would need to find a free spot and ask the host to place the resource
> there.  Then the guest needs page structs covering the mapped resource,
> so it can work with it.  Didn't investigate how difficuilt that is.  Use
> memory hotplug maybe?  Can we easily unmap the resource then?  Also I
> think updating the guests physical memory layout (which we would need to
> do on every resource map/unmap) isn't an exactly cheap operation ...

Generally we try to cache mappings as much as possible. And wrt finding a
slot: Create a sufficiently sized BAR on the virgl device, just for that?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
