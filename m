Received: from eggs.gnu.org ([2001:4830:134:3::10]:36782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel@ffwll.ch>) id 1f7yn9-0002lE-Fv
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel@ffwll.ch>) id 1f7yn6-0005wz-Oz
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:43:11 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:36918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <daniel@ffwll.ch>) id 1f7yn6-0005wJ-9c
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:43:08 -0400
Received: by mail-wr0-x230.google.com with SMTP id l49so23046283wrl.4
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 00:43:07 -0700 (PDT)
Sender: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 16 Apr 2018 09:43:03 +0200
From: Daniel Vetter <daniel@ffwll.ch>
Message-ID: <20180416074302.GG31310@phenom.ffwll.local>
References: <20180406090747.gwiegu22z4noj23i@sirius.home.kraxel.org>
	<9a085854-3758-1500-9971-806c611cb54f@gmail.com>
	<20180406115730.jtwcbz5okrphlxli@sirius.home.kraxel.org>
	<7ef89a29-6584-d23c-efd1-f30d9b767a24@gmail.com>
	<20180406185746.GA4983@downor-Z87X-UD5H>
	<c5923162-4144-56ef-ac81-eb1ab3eb5e8f@gmail.com>
	<20180410172605.GA26472@downor-Z87X-UD5H>
	<e4be9524-53d8-640c-e242-8ed3bfd05541@gmail.com>
	<20180413153708.GW31310@phenom.ffwll.local>
	<ced31540-9e93-6a24-ea60-20a1bddf2d39@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ced31540-9e93-6a24-ea60-20a1bddf2d39@gmail.com>
Subject: Re: [Qemu-devel] [RfC PATCH] Add udmabuf misc device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, qemu-devel@nongnu.org, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>

On Mon, Apr 16, 2018 at 10:16:31AM +0300, Oleksandr Andrushchenko wrote:
> On 04/13/2018 06:37 PM, Daniel Vetter wrote:
> > On Wed, Apr 11, 2018 at 08:59:32AM +0300, Oleksandr Andrushchenko wrote:
> > > On 04/10/2018 08:26 PM, Dongwon Kim wrote:
> > > > On Tue, Apr 10, 2018 at 09:37:53AM +0300, Oleksandr Andrushchenko wrote:
> > > > > On 04/06/2018 09:57 PM, Dongwon Kim wrote:
> > > > > > On Fri, Apr 06, 2018 at 03:36:03PM +0300, Oleksandr Andrushchenko wrote:
> > > > > > > On 04/06/2018 02:57 PM, Gerd Hoffmann wrote:
> > > > > > > >     Hi,
> > > > > > > > 
> > > > > > > > > > I fail to see any common ground for xen-zcopy and udmabuf ...
> > > > > > > > > Does the above mean you can assume that xen-zcopy and udmabuf
> > > > > > > > > can co-exist as two different solutions?
> > > > > > > > Well, udmabuf route isn't fully clear yet, but yes.
> > > > > > > > 
> > > > > > > > See also gvt (intel vgpu), where the hypervisor interface is abstracted
> > > > > > > > away into a separate kernel modules even though most of the actual vgpu
> > > > > > > > emulation code is common.
> > > > > > > Thank you for your input, I'm just trying to figure out
> > > > > > > which of the three z-copy solutions intersect and how much
> > > > > > > > > And what about hyper-dmabuf?
> > > > > > xen z-copy solution is pretty similar fundamentally to hyper_dmabuf
> > > > > > in terms of these core sharing feature:
> > > > > > 
> > > > > > 1. the sharing process - import prime/dmabuf from the producer -> extract
> > > > > > underlying pages and get those shared -> return references for shared pages
> > > > Another thing is danvet was kind of against to the idea of importing existing
> > > > dmabuf/prime buffer and forward it to the other domain due to synchronization
> > > > issues. He proposed to make hyper_dmabuf only work as an exporter so that it
> > > > can have a full control over the buffer. I think we need to talk about this
> > > > further as well.
> > > Yes, I saw this. But this limits the use-cases so much.
> > > For instance, running Android as a Guest (which uses ION to allocate
> > > buffers) means that finally HW composer will import dma-buf into
> > > the DRM driver. Then, in case of xen-front for example, it needs to be
> > > shared with the backend (Host side). Of course, we can change user-space
> > > to make xen-front allocate the buffers (make it exporter), but what we try
> > > to avoid is to change user-space which in normal world would have remain
> > > unchanged otherwise.
> > > So, I do think we have to support this use-case and just have to understand
> > > the complexity.
> > Erm, why do you need importer capability for this use-case?
> > 
> > guest1 -> ION -> xen-front -> hypervisor -> guest 2 -> xen-zcopy exposes
> > that dma-buf -> import to the real display hw
> > 
> > No where in this chain do you need xen-zcopy to be able to import a
> > dma-buf (within linux, it needs to import a bunch of pages from the
> > hypervisor).
> > 
> > Now if your plan is to use xen-zcopy in the guest1 instead of xen-front,
> > then you indeed need to import.
> This is the exact use-case I was referring to while saying
> we need to import on Guest1 side. If hyper-dmabuf is so
> generic that there is no xen-front in the picture, then
> it needs to import a dma-buf, so it can be exported at Guest2 side.
> >   But that imo doesn't make sense:
> > - xen-front gives you clearly defined flip events you can forward to the
> >    hypervisor. xen-zcopy would need to add that again.
> xen-zcopy is a helper driver which doesn't handle page flips
> and is not a KMS driver as one might think of: the DRM UAPI it uses is
> just to export a dma-buf as a PRIME buffer, but that's it.
> Flipping etc. is done by the backend [1], not xen-zcopy.
> >   Same for
> >    hyperdmabuf (and really we're not going to shuffle struct dma_fence over
> >    the wire in a generic fashion between hypervisor guests).
> > 
> > - xen-front already has the idea of pixel format for the buffer (and any
> >    other metadata). Again, xen-zcopy and hyperdmabuf lack that, would need
> >    to add it shoehorned in somehow.
> Again, here you are talking of something which is implemented in
> Xen display backend, not xen-zcopy, e.g. display backend can
> implement para-virtual display w/o xen-zcopy at all, but in this case
> there is a memory copying for each frame. With the help of xen-zcopy
> the backend feeds xen-front's buffers directly into Guest2 DRM/KMS or
> Weston or whatever as xen-zcopy exports remote buffers as PRIME buffers,
> thus no buffer copying is required.

Why do you need to copy on every frame for xen-front? In the above
pipeline, using xen-front I see 0 architectural reasons to have a copy
anywhere.

This seems to be the core of the confusion we're having here.

> > Ofc you won't be able to shovel sound or media stream data over to another
> > guest like this, but that's what you have xen-v4l and xen-sound or
> > whatever else for. Trying to make a new uapi, which means userspace must
> > be changed for all the different use-case, instead of reusing standard
> > linux driver uapi (which just happens to send the data to another
> > hypervisor guest instead of real hw) imo just doesn't make much sense.
> > 
> > Also, at least for the gpu subsystem: Any new uapi must have full
> > userspace available for it, see:
> > 
> > https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements
> > 
> > Adding more uapi is definitely the most painful way to fix a use-case.
> > Personally I'd go as far and also change the xen-zcopy side on the
> > receiving guest to use some standard linux uapi. E.g. you could write an
> > output v4l driver to receive the frames from guest1.
> So, we now know that xen-zcopy was not meant to handle page flips,
> but to implement new UAPI to let user-space create buffers either
> from Guest2 grant references (so it can be exported to Guest1) or
> other way round, e.g. create (from Guest1 grant references to export to
> Guest 2). For that reason it adds 2 IOCTLs: create buffer from grefs
> or produce grefs for the buffer given.
> One additional IOCTL is to wait for the buffer to be released by
> Guest2 user-space.
> That being said, I don't quite see how v4l can be used here to implement
> UAPI I need.

Under the assumption that you can make xen-front to zerocopy for the
kernel->hypervisor path, v4l could be made to work for the
hypervisor->kernel side of the pipeline.

But it sounds like we have a confusion already on why or why not xen-front
can or cannot do zerocopy.

> > > > danvet, can you comment on this topic?
> > > > 
> > > > > > 2. the page sharing mechanism - it uses Xen-grant-table.
> > > > > > 
> > > > > > And to give you a quick summary of differences as far as I understand
> > > > > > between two implementations (please correct me if I am wrong, Oleksandr.)
> > > > > > 
> > > > > > 1. xen-zcopy is DRM specific - can import only DRM prime buffer
> > > > > > while hyper_dmabuf can export any dmabuf regardless of originator
> > > > > Well, this is true. And at the same time this is just a matter
> > > > > of extending the API: xen-zcopy is a helper driver designed for
> > > > > xen-front/back use-case, so this is why it only has DRM PRIME API
> > > > > > 2. xen-zcopy doesn't seem to have dma-buf synchronization between two VMs
> > > > > > while (as danvet called it as remote dmabuf api sharing) hyper_dmabuf sends
> > > > > > out synchronization message to the exporting VM for synchronization.
> > > > > This is true. Again, this is because of the use-cases it covers.
> > > > > But having synchronization for a generic solution seems to be a good idea.
> > > > Yeah, understood xen-zcopy works ok with your use case. But I am just curious
> > > > if it is ok not to have any inter-domain synchronization in this sharing model.
> > > The synchronization is done with displif protocol [1]
> > > > The buffer being shared is technically dma-buf and originator needs to be able
> > > > to keep track of it.
> > > As I am working in DRM terms the tracking is done by the DRM core
> > > for me for free. (This might be one of the reasons Daniel sees DRM
> > > based implementation fit very good from code-reuse POV).
> > Hm, not sure what tracking you refer to here all ... I got lost in all the
> > replies while catching up.
> > 
> I was just referring to accounting stuff already implemented in the DRM
> core,
> so I don't have to worry about doing the same for buffers to understand
> when they are released etc.
> > > > > > 3. 1-level references - when using grant-table for sharing pages, there will
> > > > > > be same # of refs (each 8 byte)
> > > > > To be precise, grant ref is 4 bytes
> > > > You are right. Thanks for correction.;)
> > > > 
> > > > > > as # of shared pages, which is passed to
> > > > > > the userspace to be shared with importing VM in case of xen-zcopy.
> > > > > The reason for that is that xen-zcopy is a helper driver, e.g.
> > > > > the grant references come from the display backend [1], which implements
> > > > > Xen display protocol [2]. So, effectively the backend extracts references
> > > > > from frontend's requests and passes those to xen-zcopy as an array
> > > > > of refs.
> > > > > >    Compared
> > > > > > to this, hyper_dmabuf does multiple level addressing to generate only one
> > > > > > reference id that represents all shared pages.
> > > > > In the protocol [2] only one reference to the gref directory is passed
> > > > > between VMs
> > > > > (and the gref directory is a single-linked list of shared pages containing
> > > > > all
> > > > > of the grefs of the buffer).
> > > > ok, good to know. I will look into its implementation in more details but is
> > > > this gref directory (chained grefs) something that can be used for any general
> > > > memory sharing use case or is it jsut for xen-display (in current code base)?
> > > Not to mislead you: one grant ref is passed via displif protocol,
> > > but the page it's referencing contains the rest of the grant refs.
> > > 
> > > As to if this can be used for any memory: yes. It is the same for
> > > sndif and displif Xen protocols, but defined twice as strictly speaking
> > > sndif and displif are two separate protocols.
> > > 
> > > While reviewing your RFC v2 one of the comments I had [2] was that if we
> > > can start from defining such a generic protocol for hyper-dmabuf.
> > > It can be a header file, which not only has the description part
> > > (which then become a part of Documentation/...rst file), but also defines
> > > all the required constants for requests, responses, defines message formats,
> > > state diagrams etc. all at one place. Of course this protocol must not be
> > > Xen specific, but be OS/hypervisor agnostic.
> > > Having that will trigger a new round of discussion, so we have it all
> > > designed
> > > and discussed before we start implementing.
> > > 
> > > Besides the protocol we have to design UAPI part as well and make sure
> > > the hyper-dmabuf is not only accessible from user-space, but there will be
> > > number
> > > of kernel-space users as well.
> > Again, why do you want to create new uapi for this? Given the very strict
> > requirements we have for new uapi (see above link), it's the toughest way
> > to get any kind of support in.
> I do understand that adding new UAPI is not good for many reasons.
> But here I was meaning that current hyper-dmabuf design is
> only user-space oriented, e.g. it provides number of IOCTLs to do all
> the work. But I need a way to access the same from the kernel, so, for
> example,
> some other para-virtual driver can export/import dma-buf, not only
> user-space.

If you need an import-export helper library, just merge it. Do not attach
any uapi to it, just the internal helpers.

Much, much, much easier to land.

> > That's why I had essentially zero big questions for xen-front (except some
> > implementation improvements, and stuff to make sure xen-front actually
> > implements the real uapi semantics instead of its own), and why I'm asking
> > much more questions on this stuff here.
> > 
> > > > > > 4. inter VM messaging (hype_dmabuf only) - hyper_dmabuf has inter-vm msg
> > > > > > communication defined for dmabuf synchronization and private data (meta
> > > > > > info that Matt Roper mentioned) exchange.
> > > > > This is true, xen-zcopy has no means for inter VM sync and meta-data,
> > > > > simply because it doesn't have any code for inter VM exchange in it,
> > > > > e.g. the inter VM protocol is handled by the backend [1].
> > > > > > 5. driver-to-driver notification (hyper_dmabuf only) - importing VM gets
> > > > > > notified when newdmabuf is exported from other VM - uevent can be optionally
> > > > > > generated when this happens.
> > > > > > 
> > > > > > 6. structure - hyper_dmabuf is targetting to provide a generic solution for
> > > > > > inter-domain dmabuf sharing for most hypervisors, which is why it has two
> > > > > > layers as mattrope mentioned, front-end that contains standard API and backend
> > > > > > that is specific to hypervisor.
> > > > > Again, xen-zcopy is decoupled from inter VM communication
> > > > > > > > No idea, didn't look at it in detail.
> > > > > > > > 
> > > > > > > > Looks pretty complex from a distant view.  Maybe because it tries to
> > > > > > > > build a communication framework using dma-bufs instead of a simple
> > > > > > > > dma-buf passing mechanism.
> > > > > > we started with simple dma-buf sharing but realized there are many
> > > > > > things we need to consider in real use-case, so we added communication
> > > > > > , notification and dma-buf synchronization then re-structured it to
> > > > > > front-end and back-end (this made things more compicated..) since Xen
> > > > > > was not our only target. Also, we thought passing the reference for the
> > > > > > buffer (hyper_dmabuf_id) is not secure so added uvent mechanism later.
> > > > > > 
> > > > > > > Yes, I am looking at it now, trying to figure out the full story
> > > > > > > and its implementation. BTW, Intel guys were about to share some
> > > > > > > test application for hyper-dmabuf, maybe I have missed one.
> > > > > > > It could probably better explain the use-cases and the complexity
> > > > > > > they have in hyper-dmabuf.
> > > > > > One example is actually in github. If you want take a look at it, please
> > > > > > visit:
> > > > > > 
> > > > > > https://github.com/downor/linux_hyper_dmabuf_test/tree/xen/simple_export
> > > > > Thank you, I'll have a look
> > > > > > > > Like xen-zcopy it seems to depend on the idea that the hypervisor
> > > > > > > > manages all memory it is easy for guests to share pages with the help of
> > > > > > > > the hypervisor.
> > > > > > > So, for xen-zcopy we were not trying to make it generic,
> > > > > > > it just solves display (dumb) zero-copying use-cases for Xen.
> > > > > > > We implemented it as a DRM helper driver because we can't see any
> > > > > > > other use-cases as of now.
> > > > > > > For example, we also have Xen para-virtualized sound driver, but
> > > > > > > its buffer memory usage is not comparable to what display wants
> > > > > > > and it works somewhat differently (e.g. there is no "frame done"
> > > > > > > event, so one can't tell when the sound buffer can be "flipped").
> > > > > > > At the same time, we do not use virtio-gpu, so this could probably
> > > > > > > be one more candidate for shared dma-bufs some day.
> > > > > > > >     Which simply isn't the case on kvm.
> > > > > > > > 
> > > > > > > > hyper-dmabuf and xen-zcopy could maybe share code, or hyper-dmabuf build
> > > > > > > > on top of xen-zcopy.
> > > > > > > Hm, I can imagine that: xen-zcopy could be a library code for hyper-dmabuf
> > > > > > > in terms of implementing all that page sharing fun in multiple directions,
> > > > > > > e.g. Host->Guest, Guest->Host, Guest<->Guest.
> > > > > > > But I'll let Matt and Dongwon to comment on that.
> > > > > > I think we can definitely collaborate. Especially, maybe we are using some
> > > > > > outdated sharing mechanism/grant-table mechanism in our Xen backend (thanks
> > > > > > for bringing that up Oleksandr). However, the question is once we collaborate
> > > > > > somehow, can xen-zcopy's usecase use the standard API that hyper_dmabuf
> > > > > > provides? I don't think we need different IOCTLs that do the same in the final
> > > > > > solution.
> > > > > > 
> > > > > If you think of xen-zcopy as a library (which implements Xen
> > > > > grant references mangling) and DRM PRIME wrapper on top of that
> > > > > library, we can probably define proper API for that library,
> > > > > so both xen-zcopy and hyper-dmabuf can use it. What is more, I am
> > > > > about to start upstreaming Xen para-virtualized sound device driver soon,
> > > > > which also uses similar code and gref passing mechanism [3].
> > > > > (Actually, I was about to upstream drm/xen-front, drm/xen-zcopy and
> > > > > snd/xen-front and then propose a Xen helper library for sharing big buffers,
> > > > > so common code of the above drivers can use the same code w/o code
> > > > > duplication)
> > > > I think it is possible to use your functions for memory sharing part in
> > > > hyper_dmabuf's backend (this 'backend' means the layer that does page sharing
> > > > and inter-vm communication with xen-specific way.), so why don't we work on
> > > > "Xen helper library for sharing big buffers" first while we continue our
> > > > discussion on the common API layer that can cover any dmabuf sharing cases.
> > > > 
> > > Well, I would love we reuse the code that I have, but I also
> > > understand that it was limited by my use-cases. So, I do not
> > > insist we have to ;)
> > > If we start designing and discussing hyper-dmabuf protocol we of course
> > > can work on this helper library in parallel.
> > Imo code reuse is overrated. Adding new uapi is what freaks me out here
> > :-)
> > 
> > If we end up with duplicated implementations, even in upstream, meh, not
> > great, but also ok. New uapi, and in a similar way, new hypervisor api
> > like the dma-buf forwarding that hyperdmabuf does is the kind of thing
> > that will lock us in for 10+ years (if we make a mistake).
> > 
> > > > > Thank you,
> > > > > Oleksandr
> > > > > 
> > > > > P.S. All, is it a good idea to move this out of udmabuf thread into a
> > > > > dedicated one?
> > > > Either way is fine with me.
> > > So, if you can start designing the protocol we may have a dedicated mail
> > > thread for that. I will try to help with the protocol as much as I can
> > Please don't start with the protocol. Instead start with the concrete
> > use-cases, and then figure out why exactly you need new uapi. Once we have
> > that answered, we can start thinking about fleshing out the details.
> On my side there are only 2 use-cases, Guest2 only:
> 1. Create a PRIME (dma-buf) from grant references
> 2. Create grant references from PRIME (dma-buf)

So these grant references, are those userspace visible things? I thought
the grant references was just the kernel/hypervisor internal magic to make
this all work?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
