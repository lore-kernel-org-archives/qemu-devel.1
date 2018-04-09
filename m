Received: from eggs.gnu.org ([2001:4830:134:3::10]:59500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel@ffwll.ch>) id 1f5Ruj-00061C-Ez
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel@ffwll.ch>) id 1f5Ruh-0006kf-H2
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:12:33 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:40357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <daniel@ffwll.ch>) id 1f5Ruh-0006gU-63
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:12:31 -0400
Received: by mail-wm0-x229.google.com with SMTP id x4so14646736wmh.5
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 01:12:31 -0700 (PDT)
Sender: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 9 Apr 2018 10:12:27 +0200
From: Daniel Vetter <daniel@ffwll.ch>
Message-ID: <20180409081226.GE31310@phenom.ffwll.local>
References: <20180313154826.20436-1-kraxel@redhat.com>
	<20180313161035.GL4788@phenom.ffwll.local>
	<20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
	<CAKMK7uGG6Z6XLc6GuKv7-3grCNg+EK2Lh6XWpavjsbZWF_L5Wg@mail.gmail.com>
	<20180406001117.GD31612@mdroper-desk.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180406001117.GD31612@mdroper-desk.amr.corp.intel.com>
Subject: Re: [Qemu-devel] [RfC PATCH] Add udmabuf misc device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matt Roper <matthew.d.roper@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Dongwon Kim <dongwon.kim@intel.com>, dri-devel <dri-devel@lists.freedesktop.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>

On Thu, Apr 05, 2018 at 05:11:17PM -0700, Matt Roper wrote:
> On Thu, Apr 05, 2018 at 10:32:04PM +0200, Daniel Vetter wrote:
> > Pulling this out of the shadows again.
> > 
> > We now also have xen-zcopy from Oleksandr and the hyper dmabuf stuff
> > from Matt and Dongwong.
> > 
> > At least from the intel side there seems to be the idea to just have 1
> > special device that can handle cross-gues/host sharing for all kinds
> > of hypervisors, so I guess you all need to work together :-)
> > 
> > Or we throw out the idea that hyper dmabuf will be cross-hypervisor
> > (not sure how useful/reasonable that is, someone please convince me
> > one way or the other).
> > 
> > Cheers, Daniel
> 
> Dongwon (DW) is the one doing all the real work on hyper_dmabuf, but I'm
> familiar with the use cases he's trying to address, and I think there
> are a couple high-level goals of his work that are worth calling out as
> we discuss the various options for sharing buffers produced in one VM
> with a consumer running in another VM:
> 
>  * We should try to keep the interface/usage separate from the
>    underlying hypervisor implementation details.  I.e., in DW's design
>    the sink/source drivers that handle the actual buffer passing in the
>    two VM's should provide a generic interface that does not depend on a
>    specific hypervisor.  Behind the scenes there could be various
>    implementations for specific hypervisors (Xen, KVM, ACRN, etc.), and
>    some of those backends may have additional restrictions, but it would
>    be best if userspace didn't have to know the specific hypervisor
>    running on the system and could just query the general capabilities
>    available to it.  We've already got projects in flight that are
>    wanting this functionality on Xen and ACRN today.

Two comments on this:

- Just because it's in drivers/gpu doesn't mean you can't use it for
  anything else. E.g. the xen-zcopy driver can very much be used for any
  dma-buf, there's nothing gpu specific with it - well besides that it
  resuses some useful DRM ioctls, but if that annoys you just do a #define
  TOTALLY_GENERIC DRM and be done :-)

- Especially the kvm memory and hypervisor model seems totally different
  from other hypervisors, e.g. no real use for guest-guest sharing (which
  doesn't go through the host) and other cases. So trying to make
  something 100% generic seems like a bad idea.

  Wrt making it generic: Just use generic interfaces - if you can somehow
  use xen-front for the display sharing, then a) no need for hyper-dmabuf
  and b) already fully generic since it looks like a normal drm device to
  the guest userspace.

>  * The general interface should be able to express sharing from any
>    guest:guest, not just guest:host.  Arbitrary G:G sharing might be
>    something some hypervisors simply aren't able to support, but the
>    userspace API itself shouldn't make assumptions or restrict that.  I
>    think ideally the sharing API would include some kind of
>    query_targets interface that would return a list of VM's that your
>    current OS is allowed to share with; that list would be depend on the
>    policy established by the system integrator, but obviously wouldn't
>    include targets that the hypervisor itself wouldn't be capable of
>    handling.

Uh ... has a proper security architect analyzed this idea?

>  * A lot of the initial use cases are in the realm of graphics, but this
>    shouldn't be a graphics-specific API.  Buffers might contain other
>    types of content as well (e.g., audio).  Really the content producer
>    could potentially be any driver (or userspace) running in the VM that
>    knows how to import/export dma_buf's (or maybe just import given
>    danvet's suggestion that we should make the sink driver do all the
>    actual memory allocation for any buffers that may be shared).

See above, just because it uses drm ioctls doesn't make it gfx specific.

Otoh making it even more graphics specific might be even better, i.e. just
sharing the backend tech (grant tables or whatever), but having dedicated
front-ents for each use-case so there's less code to type.

>  * We need to be able to handle cross-VM coordination of buffer usage as
>    well, so I think we'd want to include fence forwarding support in the
>    API as well to signal back and forth about production/consumption
>    completion.  And of course document really well what should happen
>    if, for example, the entire VM you're sharing with/from dies.

Implicit fencing has been proven to be a bad idea. Please do explicit
passing of dma_fences (plus assorted protocol).

>  * The sharing API could be used to share multiple kinds of content in a
>    single system.  The sharing sink driver running in the content
>    producer's VM should accept some additional metadata that will be
>    passed over to the target VM as well.  The sharing source driver
>    running in the content consumer's VM would then be able to use this
>    metadata to determine the purpose of a new buffer that arrives and
>    filter/dispatch it to the appropriate consumer.

If you want metadata, why not use xen-front or something similar to have a
well-defined means to transfer everything? One of the key design decisions
of dma-buf was to _not_ have metadata, just buffer sharing.
-Daniel

> 
> 
> For reference, the terminology I'm using is
> 
>  /----------\  dma_buf   /------\ HV /--------\  dma_buf   /----------\
>  | Producer |----------->| Sink | HV | Source |----------->| Consumer |
>  \----------/   ioctls   \------/ HV \--------/  uevents   \----------/
> 
> 
> 
> In the realm of graphics, "Producer" could potentially be something like
> an EGL client that sends the buffer at context setup and then signals
> with fences on each SwapBuffers.  "Consumer" could be a Wayland client
> that proxies the buffers into surfaces or dispatches them to other
> userspace software that's waiting for buffers.
> 
> With the hyper_dmabuf approach, there's a lot of ABI details that need
> to be worked out and really clearly documented before we worry too much
> about the backend hypervisor-specific stuff.
> 
> I'm not super familiar with xen-zcopy and udmabuf, but it sounds like
> they're approaching similar problems from slightly different directions,
> so we should make sure we can come up with something that satisfies
> everyone's requirements. 
> 
> 
> Matt
> 
> > 
> > On Wed, Mar 14, 2018 at 9:03 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >   Hi,
> > >
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
> > >
> > >> > Known issue:  Driver API isn't complete yet.  Need add some flags, for
> > >> > example to support read-only buffers.
> > >>
> > >> dma-buf has no concept of read-only. I don't think we can even enforce
> > >> that (not many iommus can enforce this iirc), so pretty much need to
> > >> require r/w memory.
> > >
> > > Ah, ok.  Just saw the 'write' arg for get_user_pages_fast and figured we
> > > might support that, but if iommus can't handle that anyway it's
> > > pointless indeed.
> > >
> > >> > Cc: David Airlie <airlied@linux.ie>
> > >> > Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > >> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > >>
> > >> btw there's also the hyperdmabuf stuff from the xen folks, but imo their
> > >> solution of forwarding the entire dma-buf api is over the top. This here
> > >> looks _much_ better, pls cc all the hyperdmabuf people on your next
> > >> version.
> > >
> > > Fun fact: googling for "hyperdmabuf" found me your mail and nothing else :-o
> > > (Trying "hyper dmabuf" instead worked better then).
> > >
> > > Yes, will cc them on the next version.  Not sure it'll help much on xen
> > > though due to the memory management being very different.  Basically xen
> > > owns the memory, not the kernel of the control domain (dom0), so
> > > creating dmabufs for guest memory chunks isn't that simple ...
> > >
> > > Also it's not clear whenever they really need guest -> guest exports or
> > > guest -> dom0 exports.
> > >
> > >> Overall I like the idea, but too lazy to review.
> > >
> > > Cool.  General comments on the idea was all I was looking for for the
> > > moment.  Spare yor review cycles for the next version ;)
> > >
> > >> Oh, some kselftests for this stuff would be lovely.
> > >
> > > I'll look into it.
> > >
> > > thanks,
> > >   Gerd
> > >
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> > 
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> 
> -- 
> Matt Roper
> Graphics Software Engineer
> IoTG Platform Enabling & Development
> Intel Corporation
> (916) 356-2795

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
