Received: from eggs.gnu.org ([2001:4830:134:3::10]:56290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongwon.kim@intel.com>) id 1f5x2P-0005Kn-U0
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 13:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongwon.kim@intel.com>) id 1f5x2L-0008TT-MJ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 13:26:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:47205)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongwon.kim@intel.com>)
	id 1f5x2L-0008Pz-8E
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 13:26:29 -0400
Date: Tue, 10 Apr 2018 10:26:05 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
Message-ID: <20180410172605.GA26472@downor-Z87X-UD5H>
References: <20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
	<CAKMK7uGG6Z6XLc6GuKv7-3grCNg+EK2Lh6XWpavjsbZWF_L5Wg@mail.gmail.com>
	<20180406001117.GD31612@mdroper-desk.amr.corp.intel.com>
	<2411d2c1-33c0-2ba5-67ea-3bb9af5d5ec9@epam.com>
	<20180406090747.gwiegu22z4noj23i@sirius.home.kraxel.org>
	<9a085854-3758-1500-9971-806c611cb54f@gmail.com>
	<20180406115730.jtwcbz5okrphlxli@sirius.home.kraxel.org>
	<7ef89a29-6584-d23c-efd1-f30d9b767a24@gmail.com>
	<20180406185746.GA4983@downor-Z87X-UD5H>
	<c5923162-4144-56ef-ac81-eb1ab3eb5e8f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5923162-4144-56ef-ac81-eb1ab3eb5e8f@gmail.com>
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, qemu-devel@nongnu.org, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, Matt Roper <matthew.d.roper@intel.com>

On Tue, Apr 10, 2018 at 09:37:53AM +0300, Oleksandr Andrushchenko wrote:
> On 04/06/2018 09:57 PM, Dongwon Kim wrote:
> >On Fri, Apr 06, 2018 at 03:36:03PM +0300, Oleksandr Andrushchenko wrote:
> >>On 04/06/2018 02:57 PM, Gerd Hoffmann wrote:
> >>>   Hi,
> >>>
> >>>>>I fail to see any common ground for xen-zcopy and udmabuf ...
> >>>>Does the above mean you can assume that xen-zcopy and udmabuf
> >>>>can co-exist as two different solutions?
> >>>Well, udmabuf route isn't fully clear yet, but yes.
> >>>
> >>>See also gvt (intel vgpu), where the hypervisor interface is abstracted
> >>>away into a separate kernel modules even though most of the actual vgpu
> >>>emulation code is common.
> >>Thank you for your input, I'm just trying to figure out
> >>which of the three z-copy solutions intersect and how much
> >>>>And what about hyper-dmabuf?
> >xen z-copy solution is pretty similar fundamentally to hyper_dmabuf
> >in terms of these core sharing feature:
> >
> >1. the sharing process - import prime/dmabuf from the producer -> extract
> >underlying pages and get those shared -> return references for shared pages

Another thing is danvet was kind of against to the idea of importing existing
dmabuf/prime buffer and forward it to the other domain due to synchronization
issues. He proposed to make hyper_dmabuf only work as an exporter so that it
can have a full control over the buffer. I think we need to talk about this
further as well.

danvet, can you comment on this topic?

> >
> >2. the page sharing mechanism - it uses Xen-grant-table.
> >
> >And to give you a quick summary of differences as far as I understand
> >between two implementations (please correct me if I am wrong, Oleksandr.)
> >
> >1. xen-zcopy is DRM specific - can import only DRM prime buffer
> >while hyper_dmabuf can export any dmabuf regardless of originator
> Well, this is true. And at the same time this is just a matter
> of extending the API: xen-zcopy is a helper driver designed for
> xen-front/back use-case, so this is why it only has DRM PRIME API
> >
> >2. xen-zcopy doesn't seem to have dma-buf synchronization between two VMs
> >while (as danvet called it as remote dmabuf api sharing) hyper_dmabuf sends
> >out synchronization message to the exporting VM for synchronization.
> This is true. Again, this is because of the use-cases it covers.
> But having synchronization for a generic solution seems to be a good idea.

Yeah, understood xen-zcopy works ok with your use case. But I am just curious
if it is ok not to have any inter-domain synchronization in this sharing model.
The buffer being shared is technically dma-buf and originator needs to be able
to keep track of it.

> >
> >3. 1-level references - when using grant-table for sharing pages, there will
> >be same # of refs (each 8 byte)
> To be precise, grant ref is 4 bytes
You are right. Thanks for correction.;)

> >as # of shared pages, which is passed to
> >the userspace to be shared with importing VM in case of xen-zcopy.
> The reason for that is that xen-zcopy is a helper driver, e.g.
> the grant references come from the display backend [1], which implements
> Xen display protocol [2]. So, effectively the backend extracts references
> from frontend's requests and passes those to xen-zcopy as an array
> of refs.
> >  Compared
> >to this, hyper_dmabuf does multiple level addressing to generate only one
> >reference id that represents all shared pages.
> In the protocol [2] only one reference to the gref directory is passed
> between VMs
> (and the gref directory is a single-linked list of shared pages containing
> all
> of the grefs of the buffer).

ok, good to know. I will look into its implementation in more details but is
this gref directory (chained grefs) something that can be used for any general
memory sharing use case or is it jsut for xen-display (in current code base)?

> 
> >
> >4. inter VM messaging (hype_dmabuf only) - hyper_dmabuf has inter-vm msg
> >communication defined for dmabuf synchronization and private data (meta
> >info that Matt Roper mentioned) exchange.
> This is true, xen-zcopy has no means for inter VM sync and meta-data,
> simply because it doesn't have any code for inter VM exchange in it,
> e.g. the inter VM protocol is handled by the backend [1].
> >
> >5. driver-to-driver notification (hyper_dmabuf only) - importing VM gets
> >notified when newdmabuf is exported from other VM - uevent can be optionally
> >generated when this happens.
> >
> >6. structure - hyper_dmabuf is targetting to provide a generic solution for
> >inter-domain dmabuf sharing for most hypervisors, which is why it has two
> >layers as mattrope mentioned, front-end that contains standard API and backend
> >that is specific to hypervisor.
> Again, xen-zcopy is decoupled from inter VM communication
> >>>No idea, didn't look at it in detail.
> >>>
> >>>Looks pretty complex from a distant view.  Maybe because it tries to
> >>>build a communication framework using dma-bufs instead of a simple
> >>>dma-buf passing mechanism.
> >we started with simple dma-buf sharing but realized there are many
> >things we need to consider in real use-case, so we added communication
> >, notification and dma-buf synchronization then re-structured it to
> >front-end and back-end (this made things more compicated..) since Xen
> >was not our only target. Also, we thought passing the reference for the
> >buffer (hyper_dmabuf_id) is not secure so added uvent mechanism later.
> >
> >>Yes, I am looking at it now, trying to figure out the full story
> >>and its implementation. BTW, Intel guys were about to share some
> >>test application for hyper-dmabuf, maybe I have missed one.
> >>It could probably better explain the use-cases and the complexity
> >>they have in hyper-dmabuf.
> >One example is actually in github. If you want take a look at it, please
> >visit:
> >
> >https://github.com/downor/linux_hyper_dmabuf_test/tree/xen/simple_export
> Thank you, I'll have a look
> >>>Like xen-zcopy it seems to depend on the idea that the hypervisor
> >>>manages all memory it is easy for guests to share pages with the help of
> >>>the hypervisor.
> >>So, for xen-zcopy we were not trying to make it generic,
> >>it just solves display (dumb) zero-copying use-cases for Xen.
> >>We implemented it as a DRM helper driver because we can't see any
> >>other use-cases as of now.
> >>For example, we also have Xen para-virtualized sound driver, but
> >>its buffer memory usage is not comparable to what display wants
> >>and it works somewhat differently (e.g. there is no "frame done"
> >>event, so one can't tell when the sound buffer can be "flipped").
> >>At the same time, we do not use virtio-gpu, so this could probably
> >>be one more candidate for shared dma-bufs some day.
> >>>   Which simply isn't the case on kvm.
> >>>
> >>>hyper-dmabuf and xen-zcopy could maybe share code, or hyper-dmabuf build
> >>>on top of xen-zcopy.
> >>Hm, I can imagine that: xen-zcopy could be a library code for hyper-dmabuf
> >>in terms of implementing all that page sharing fun in multiple directions,
> >>e.g. Host->Guest, Guest->Host, Guest<->Guest.
> >>But I'll let Matt and Dongwon to comment on that.
> >I think we can definitely collaborate. Especially, maybe we are using some
> >outdated sharing mechanism/grant-table mechanism in our Xen backend (thanks
> >for bringing that up Oleksandr). However, the question is once we collaborate
> >somehow, can xen-zcopy's usecase use the standard API that hyper_dmabuf
> >provides? I don't think we need different IOCTLs that do the same in the final
> >solution.
> >
> If you think of xen-zcopy as a library (which implements Xen
> grant references mangling) and DRM PRIME wrapper on top of that
> library, we can probably define proper API for that library,
> so both xen-zcopy and hyper-dmabuf can use it. What is more, I am
> about to start upstreaming Xen para-virtualized sound device driver soon,
> which also uses similar code and gref passing mechanism [3].
> (Actually, I was about to upstream drm/xen-front, drm/xen-zcopy and
> snd/xen-front and then propose a Xen helper library for sharing big buffers,
> so common code of the above drivers can use the same code w/o code
> duplication)

I think it is possible to use your functions for memory sharing part in
hyper_dmabuf's backend (this 'backend' means the layer that does page sharing
and inter-vm communication with xen-specific way.), so why don't we work on
"Xen helper library for sharing big buffers" first while we continue our
discussion on the common API layer that can cover any dmabuf sharing cases.

> 
> Thank you,
> Oleksandr
> 
> P.S. All, is it a good idea to move this out of udmabuf thread into a
> dedicated one?

Either way is fine with me.

> >>>cheers,
> >>>   Gerd
> >>>
> >>Thank you,
> >>Oleksandr
> >>
> >>P.S. Sorry for making your original mail thread to discuss things much
> >>broader than your RFC...
> >>
> [1] https://github.com/xen-troops/displ_be
> [2] https://elixir.bootlin.com/linux/v4.16-rc7/source/include/xen/interface/io/displif.h#L484
> [3] https://elixir.bootlin.com/linux/v4.16-rc7/source/include/xen/interface/io/sndif.h
> 
