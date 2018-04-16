Received: from eggs.gnu.org ([2001:4830:134:3::10]:55354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel.vetter@ffwll.ch>) id 1f82wC-0003cc-03
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel.vetter@ffwll.ch>) id 1f82w7-00053j-U9
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:08:47 -0400
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:50297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <daniel.vetter@ffwll.ch>)
	id 1f82w7-000537-LT
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:08:43 -0400
Received: by mail-it0-x229.google.com with SMTP id r19-v6so11050138itc.0
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 05:08:43 -0700 (PDT)
MIME-Version: 1.0
Sender: daniel.vetter@ffwll.ch
In-Reply-To: <89b044da-8986-d361-f557-26331a3de317@gmail.com>
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
	<20180416074302.GG31310@phenom.ffwll.local>
	<d7d0fb50-0407-b51d-fb20-7275d17db47b@gmail.com>
	<CAKMK7uEH-VFFYQCVw4QWrFf-vGC8wK4X3Fq6EybjMPoknDsxnQ@mail.gmail.com>
	<89b044da-8986-d361-f557-26331a3de317@gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 16 Apr 2018 14:08:41 +0200
Message-ID: <CAKMK7uFvHwWZbaWbfG1AcDiHaOL1Ns6TSqOMN71NBUUiEnwx=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Dongwon Kim <dongwon.kim@intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, qemu-devel@nongnu.org, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>

Ok, confusion around backend is I think cleared up. The other
confusion seems to be around dma-buf:

dma-buf is the cross subsystem zerocopy abstraction. PRIME is the
drm-specific support for it, 100% based on top of the generic struct
dma_buf.

You need a dma_buf exporter to convert a xen grant references list
into a dma_buf, which you can then import in your drm driver (using
prime), v4l, or anything else that supports dma-buf. You do _not_ need
a prime implementation, that's only the marketing name we've given to
dma-buf import/export for drm drivers.
-Daniel


On Mon, Apr 16, 2018 at 12:14 PM, Oleksandr Andrushchenko
<andr2000@gmail.com> wrote:
> On 04/16/2018 12:32 PM, Daniel Vetter wrote:
>>
>> On Mon, Apr 16, 2018 at 10:22 AM, Oleksandr Andrushchenko
>> <andr2000@gmail.com> wrote:
>>>
>>> On 04/16/2018 10:43 AM, Daniel Vetter wrote:
>>>>
>>>> On Mon, Apr 16, 2018 at 10:16:31AM +0300, Oleksandr Andrushchenko wrote:
>>>>>
>>>>> On 04/13/2018 06:37 PM, Daniel Vetter wrote:
>>>>>>
>>>>>> On Wed, Apr 11, 2018 at 08:59:32AM +0300, Oleksandr Andrushchenko
>>>>>> wrote:
>>>>>>>
>>>>>>> On 04/10/2018 08:26 PM, Dongwon Kim wrote:
>>>>>>>>
>>>>>>>> On Tue, Apr 10, 2018 at 09:37:53AM +0300, Oleksandr Andrushchenko
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> On 04/06/2018 09:57 PM, Dongwon Kim wrote:
>>>>>>>>>>
>>>>>>>>>> On Fri, Apr 06, 2018 at 03:36:03PM +0300, Oleksandr Andrushchenko
>>>>>>>>>> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On 04/06/2018 02:57 PM, Gerd Hoffmann wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>       Hi,
>>>>>>>>>>>>
>>>>>>>>>>>>>> I fail to see any common ground for xen-zcopy and udmabuf ...
>>>>>>>>>>>>>
>>>>>>>>>>>>> Does the above mean you can assume that xen-zcopy and udmabuf
>>>>>>>>>>>>> can co-exist as two different solutions?
>>>>>>>>>>>>
>>>>>>>>>>>> Well, udmabuf route isn't fully clear yet, but yes.
>>>>>>>>>>>>
>>>>>>>>>>>> See also gvt (intel vgpu), where the hypervisor interface is
>>>>>>>>>>>> abstracted
>>>>>>>>>>>> away into a separate kernel modules even though most of the
>>>>>>>>>>>> actual
>>>>>>>>>>>> vgpu
>>>>>>>>>>>> emulation code is common.
>>>>>>>>>>>
>>>>>>>>>>> Thank you for your input, I'm just trying to figure out
>>>>>>>>>>> which of the three z-copy solutions intersect and how much
>>>>>>>>>>>>>
>>>>>>>>>>>>> And what about hyper-dmabuf?
>>>>>>>>>>
>>>>>>>>>> xen z-copy solution is pretty similar fundamentally to
>>>>>>>>>> hyper_dmabuf
>>>>>>>>>> in terms of these core sharing feature:
>>>>>>>>>>
>>>>>>>>>> 1. the sharing process - import prime/dmabuf from the producer ->
>>>>>>>>>> extract
>>>>>>>>>> underlying pages and get those shared -> return references for
>>>>>>>>>> shared pages
>>>>>>>>
>>>>>>>> Another thing is danvet was kind of against to the idea of importing
>>>>>>>> existing
>>>>>>>> dmabuf/prime buffer and forward it to the other domain due to
>>>>>>>> synchronization
>>>>>>>> issues. He proposed to make hyper_dmabuf only work as an exporter so
>>>>>>>> that it
>>>>>>>> can have a full control over the buffer. I think we need to talk
>>>>>>>> about
>>>>>>>> this
>>>>>>>> further as well.
>>>>>>>
>>>>>>> Yes, I saw this. But this limits the use-cases so much.
>>>>>>> For instance, running Android as a Guest (which uses ION to allocate
>>>>>>> buffers) means that finally HW composer will import dma-buf into
>>>>>>> the DRM driver. Then, in case of xen-front for example, it needs to
>>>>>>> be
>>>>>>> shared with the backend (Host side). Of course, we can change
>>>>>>> user-space
>>>>>>> to make xen-front allocate the buffers (make it exporter), but what
>>>>>>> we
>>>>>>> try
>>>>>>> to avoid is to change user-space which in normal world would have
>>>>>>> remain
>>>>>>> unchanged otherwise.
>>>>>>> So, I do think we have to support this use-case and just have to
>>>>>>> understand
>>>>>>> the complexity.
>>>>>>
>>>>>> Erm, why do you need importer capability for this use-case?
>>>>>>
>>>>>> guest1 -> ION -> xen-front -> hypervisor -> guest 2 -> xen-zcopy
>>>>>> exposes
>>>>>> that dma-buf -> import to the real display hw
>>>>>>
>>>>>> No where in this chain do you need xen-zcopy to be able to import a
>>>>>> dma-buf (within linux, it needs to import a bunch of pages from the
>>>>>> hypervisor).
>>>>>>
>>>>>> Now if your plan is to use xen-zcopy in the guest1 instead of
>>>>>> xen-front,
>>>>>> then you indeed need to import.
>>>>>
>>>>> This is the exact use-case I was referring to while saying
>>>>> we need to import on Guest1 side. If hyper-dmabuf is so
>>>>> generic that there is no xen-front in the picture, then
>>>>> it needs to import a dma-buf, so it can be exported at Guest2 side.
>>>>>>
>>>>>>     But that imo doesn't make sense:
>>>>>> - xen-front gives you clearly defined flip events you can forward to
>>>>>> the
>>>>>>      hypervisor. xen-zcopy would need to add that again.
>>>>>
>>>>> xen-zcopy is a helper driver which doesn't handle page flips
>>>>> and is not a KMS driver as one might think of: the DRM UAPI it uses is
>>>>> just to export a dma-buf as a PRIME buffer, but that's it.
>>>>> Flipping etc. is done by the backend [1], not xen-zcopy.
>>>>>>
>>>>>>     Same for
>>>>>>      hyperdmabuf (and really we're not going to shuffle struct
>>>>>> dma_fence
>>>>>> over
>>>>>>      the wire in a generic fashion between hypervisor guests).
>>>>>>
>>>>>> - xen-front already has the idea of pixel format for the buffer (and
>>>>>> any
>>>>>>      other metadata). Again, xen-zcopy and hyperdmabuf lack that,
>>>>>> would
>>>>>> need
>>>>>>      to add it shoehorned in somehow.
>>>>>
>>>>> Again, here you are talking of something which is implemented in
>>>>> Xen display backend, not xen-zcopy, e.g. display backend can
>>>>> implement para-virtual display w/o xen-zcopy at all, but in this case
>>>>> there is a memory copying for each frame. With the help of xen-zcopy
>>>>> the backend feeds xen-front's buffers directly into Guest2 DRM/KMS or
>>>>> Weston or whatever as xen-zcopy exports remote buffers as PRIME
>>>>> buffers,
>>>>> thus no buffer copying is required.
>>>>
>>>> Why do you need to copy on every frame for xen-front? In the above
>>>> pipeline, using xen-front I see 0 architectural reasons to have a copy
>>>> anywhere.
>>>>
>>>> This seems to be the core of the confusion we're having here.
>>>
>>> Ok, so I'll try to explain:
>>> 1. xen-front - produces a display buffer to be shown at Guest2
>>> by the backend, shares its grant references with the backend
>>> 2. xen-front sends page flip event to the backend specifying the
>>> buffer in question
>>> 3. Backend takes the shared buffer (which is only a buffer mapped into
>>> backend's memory, it is not a dma-buf/PRIME one) and makes memcpy from
>>> it to a local dumb/surface
>>
>> Why do you even do that? The copying here I mean - why don't you just
>> directly scan out from the grant references you received through the
>> hypervisor?
>
> Probably the confusion comes from the fact that KVM and Xen
> implement things differently (for example, on ARM we don't use QEMU at all).
> Please see [1] and [2] for Xen frontend/backend placement in the picture.
>
> WRT to [2] xen-front is a PV front-end driver running in guest OS
> and Xen display backend is a user-space application running in Dom0
> (in the picture [2] backend runs as a Dom0 kernel driver).
> So, the para-virtualized device is not implemented in the hypervisor
> itself, but as user/kernel-space pair in corresponding domains.
> Thus, when xen-front shares grant references of the pages of the buffer
> with the Xen display backend (user-space) the later can only map those
> references into Dom0 memory to memcpy into some local display buffer/dumb.
> Hence, hypervisor is not in the equation while actually implementing
> para-virtual display device, e.g. it provides you with API to share/map
> pages, but it won't be the entity which will implement actual page flips
> etc.
> So, this is where xen-zcopy comes into the play (runs in Dom0):
> it not only maps xen-front's grant references into Dom0, but also creates
> a PRIME buffer, so this buffer can be used by other DRM devices/Weston
> running in Dom0.
>>
>> Also I'm not clear in your example which step happens where (guest 1/2
>> or hypervisor)?
>
> Steps 1,2 - Guest2, kernel space
> Steps 3-4 - Guest1, Dom0 user-space
> The hypervisor here only provides transport and means to access buffers,
> actual display/DRM related code is in xen-front and Dom0's display backend
>
>>> 4. Backend flips that local dumb buffer/surface
>>>
>>> If I have a xen-zcopy helper driver then I can avoid doing step 3):
>>> 1) 2) remain the same as above
>>> 3) Initially for a new display buffer, backend calls xen-zcopy to create
>>> a local PRIME buffer from the grant references provided by the xen-front
>>> via displif protocol [1]: we now have handle_zcopy
>>> 4) Backend exports this PRIME with HANDLE_TO_FD from xen-zcopy and
>>> imports
>>> it into Weston-KMS/DRM or real HW DRM driver with FD_TO_HANDLE: we now
>>> have
>>> handle_local
>>> 5) On page flip event backend flips local PRIME: uses handle_local for
>>> flips
>>>
>>>>>> Ofc you won't be able to shovel sound or media stream data over to
>>>>>> another
>>>>>> guest like this, but that's what you have xen-v4l and xen-sound or
>>>>>> whatever else for. Trying to make a new uapi, which means userspace
>>>>>> must
>>>>>> be changed for all the different use-case, instead of reusing standard
>>>>>> linux driver uapi (which just happens to send the data to another
>>>>>> hypervisor guest instead of real hw) imo just doesn't make much sense.
>>>>>>
>>>>>> Also, at least for the gpu subsystem: Any new uapi must have full
>>>>>> userspace available for it, see:
>>>>>>
>>>>>>
>>>>>>
>>>>>> https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements
>>>>>>
>>>>>> Adding more uapi is definitely the most painful way to fix a use-case.
>>>>>> Personally I'd go as far and also change the xen-zcopy side on the
>>>>>> receiving guest to use some standard linux uapi. E.g. you could write
>>>>>> an
>>>>>> output v4l driver to receive the frames from guest1.
>>>>>
>>>>> So, we now know that xen-zcopy was not meant to handle page flips,
>>>>> but to implement new UAPI to let user-space create buffers either
>>>>> from Guest2 grant references (so it can be exported to Guest1) or
>>>>> other way round, e.g. create (from Guest1 grant references to export to
>>>>> Guest 2). For that reason it adds 2 IOCTLs: create buffer from grefs
>>>>> or produce grefs for the buffer given.
>>>>> One additional IOCTL is to wait for the buffer to be released by
>>>>> Guest2 user-space.
>>>>> That being said, I don't quite see how v4l can be used here to
>>>>> implement
>>>>> UAPI I need.
>>>>
>>>> Under the assumption that you can make xen-front to zerocopy for the
>>>> kernel->hypervisor path, v4l could be made to work for the
>>>> hypervisor->kernel side of the pipeline.
>>>>
>>>> But it sounds like we have a confusion already on why or why not
>>>> xen-front
>>>> can or cannot do zerocopy.
>>>
>>> xen-front provides an array of grant references to Guest2 (backend).
>>> It's up to backend what it does with those grant references
>>> which at Guest2 side are not PRIME or dma-buf, but just a set of pages.
>>> This is xen-zcopy which turns these pages into a PRIME. When this is done
>>> backend can now tell DRM drivers to use the buffer in DRM terms.
>>>
>>>>>>>> danvet, can you comment on this topic?
>>>>>>>>
>>>>>>>>>> 2. the page sharing mechanism - it uses Xen-grant-table.
>>>>>>>>>>
>>>>>>>>>> And to give you a quick summary of differences as far as I
>>>>>>>>>> understand
>>>>>>>>>> between two implementations (please correct me if I am wrong,
>>>>>>>>>> Oleksandr.)
>>>>>>>>>>
>>>>>>>>>> 1. xen-zcopy is DRM specific - can import only DRM prime buffer
>>>>>>>>>> while hyper_dmabuf can export any dmabuf regardless of originator
>>>>>>>>>
>>>>>>>>> Well, this is true. And at the same time this is just a matter
>>>>>>>>> of extending the API: xen-zcopy is a helper driver designed for
>>>>>>>>> xen-front/back use-case, so this is why it only has DRM PRIME API
>>>>>>>>>>
>>>>>>>>>> 2. xen-zcopy doesn't seem to have dma-buf synchronization between
>>>>>>>>>> two VMs
>>>>>>>>>> while (as danvet called it as remote dmabuf api sharing)
>>>>>>>>>> hyper_dmabuf sends
>>>>>>>>>> out synchronization message to the exporting VM for
>>>>>>>>>> synchronization.
>>>>>>>>>
>>>>>>>>> This is true. Again, this is because of the use-cases it covers.
>>>>>>>>> But having synchronization for a generic solution seems to be a
>>>>>>>>> good
>>>>>>>>> idea.
>>>>>>>>
>>>>>>>> Yeah, understood xen-zcopy works ok with your use case. But I am
>>>>>>>> just
>>>>>>>> curious
>>>>>>>> if it is ok not to have any inter-domain synchronization in this
>>>>>>>> sharing model.
>>>>>>>
>>>>>>> The synchronization is done with displif protocol [1]
>>>>>>>>
>>>>>>>> The buffer being shared is technically dma-buf and originator needs
>>>>>>>> to
>>>>>>>> be able
>>>>>>>> to keep track of it.
>>>>>>>
>>>>>>> As I am working in DRM terms the tracking is done by the DRM core
>>>>>>> for me for free. (This might be one of the reasons Daniel sees DRM
>>>>>>> based implementation fit very good from code-reuse POV).
>>>>>>
>>>>>> Hm, not sure what tracking you refer to here all ... I got lost in all
>>>>>> the
>>>>>> replies while catching up.
>>>>>>
>>>>> I was just referring to accounting stuff already implemented in the DRM
>>>>> core,
>>>>> so I don't have to worry about doing the same for buffers to understand
>>>>> when they are released etc.
>>>>>>>>>>
>>>>>>>>>> 3. 1-level references - when using grant-table for sharing pages,
>>>>>>>>>> there will
>>>>>>>>>> be same # of refs (each 8 byte)
>>>>>>>>>
>>>>>>>>> To be precise, grant ref is 4 bytes
>>>>>>>>
>>>>>>>> You are right. Thanks for correction.;)
>>>>>>>>
>>>>>>>>>> as # of shared pages, which is passed to
>>>>>>>>>> the userspace to be shared with importing VM in case of xen-zcopy.
>>>>>>>>>
>>>>>>>>> The reason for that is that xen-zcopy is a helper driver, e.g.
>>>>>>>>> the grant references come from the display backend [1], which
>>>>>>>>> implements
>>>>>>>>> Xen display protocol [2]. So, effectively the backend extracts
>>>>>>>>> references
>>>>>>>>> from frontend's requests and passes those to xen-zcopy as an array
>>>>>>>>> of refs.
>>>>>>>>>>
>>>>>>>>>>      Compared
>>>>>>>>>> to this, hyper_dmabuf does multiple level addressing to generate
>>>>>>>>>> only one
>>>>>>>>>> reference id that represents all shared pages.
>>>>>>>>>
>>>>>>>>> In the protocol [2] only one reference to the gref directory is
>>>>>>>>> passed
>>>>>>>>> between VMs
>>>>>>>>> (and the gref directory is a single-linked list of shared pages
>>>>>>>>> containing
>>>>>>>>> all
>>>>>>>>> of the grefs of the buffer).
>>>>>>>>
>>>>>>>> ok, good to know. I will look into its implementation in more
>>>>>>>> details
>>>>>>>> but is
>>>>>>>> this gref directory (chained grefs) something that can be used for
>>>>>>>> any
>>>>>>>> general
>>>>>>>> memory sharing use case or is it jsut for xen-display (in current
>>>>>>>> code
>>>>>>>> base)?
>>>>>>>
>>>>>>> Not to mislead you: one grant ref is passed via displif protocol,
>>>>>>> but the page it's referencing contains the rest of the grant refs.
>>>>>>>
>>>>>>> As to if this can be used for any memory: yes. It is the same for
>>>>>>> sndif and displif Xen protocols, but defined twice as strictly
>>>>>>> speaking
>>>>>>> sndif and displif are two separate protocols.
>>>>>>>
>>>>>>> While reviewing your RFC v2 one of the comments I had [2] was that if
>>>>>>> we
>>>>>>> can start from defining such a generic protocol for hyper-dmabuf.
>>>>>>> It can be a header file, which not only has the description part
>>>>>>> (which then become a part of Documentation/...rst file), but also
>>>>>>> defines
>>>>>>> all the required constants for requests, responses, defines message
>>>>>>> formats,
>>>>>>> state diagrams etc. all at one place. Of course this protocol must
>>>>>>> not
>>>>>>> be
>>>>>>> Xen specific, but be OS/hypervisor agnostic.
>>>>>>> Having that will trigger a new round of discussion, so we have it all
>>>>>>> designed
>>>>>>> and discussed before we start implementing.
>>>>>>>
>>>>>>> Besides the protocol we have to design UAPI part as well and make
>>>>>>> sure
>>>>>>> the hyper-dmabuf is not only accessible from user-space, but there
>>>>>>> will
>>>>>>> be
>>>>>>> number
>>>>>>> of kernel-space users as well.
>>>>>>
>>>>>> Again, why do you want to create new uapi for this? Given the very
>>>>>> strict
>>>>>> requirements we have for new uapi (see above link), it's the toughest
>>>>>> way
>>>>>> to get any kind of support in.
>>>>>
>>>>> I do understand that adding new UAPI is not good for many reasons.
>>>>> But here I was meaning that current hyper-dmabuf design is
>>>>> only user-space oriented, e.g. it provides number of IOCTLs to do all
>>>>> the work. But I need a way to access the same from the kernel, so, for
>>>>> example,
>>>>> some other para-virtual driver can export/import dma-buf, not only
>>>>> user-space.
>>>>
>>>> If you need an import-export helper library, just merge it. Do not
>>>> attach
>>>> any uapi to it, just the internal helpers.
>>>>
>>>> Much, much, much easier to land.
>>>
>>> This can be done, but again, I will need some entity which
>>> backend may use to convert xen-front's grant references into
>>> a PRIME buffer, hence there is UAPI for that. In other words,
>>> I'll need a thiner xen-zcopy which will implement the same UAPI
>>> and use that library for Xen related stuff.
>>>
>>> The confusion may also come from the fact that the backend is
>>> a user-space application, not a kernel module (we have 2 modes
>>> of its operation as of now: DRM master or Weston client), so
>>> it needs a way to talk to the kernel.
>>
>> So this is entirely a means to implement the virtual xen device in
>> dom0 (or whichever guest implements it)?
>>
>> I'm externally confused about what you mean with "backend", since
>> xen-front also has backend code. But that backend code lives in the
>> same guest os image (afaict at least), since it does direct function
>> calls.
>
> xen-front has no backend code, but only has code which allows it
> to create a dumb buffer from the grant references provided by the
> backend.
>>
>> Please be more specific in what you mean instead of just "backend",
>> that's really confusing.
>
> Hope [2] better explains this
>>
>>
>> But essentially we're talking about the equivalent of what qemu does
>> for kvm, and that's entirely not my problem. Not really a gpu
>> subsystem problem I think. Just talk with the xen hypervisor people
>> about how exactly they want to go about converting grant tables to
>> dma-buf, so that your virtual hw backend in userspace can make use of
>> it.
>
> The problem here is that the display backend then will need
> to talk to DRM. And what is the UAPI for that? Right, PRIME
> buffers.
>
>> And then merge it somewhere in the xen directories. Since the
>> grant tables and everything is very xen specific, I don't think
>> there's much point in trying to have a fake generic uapi that pretends
>> to work on other hypervisors, as long as they're Xen :-)
>>
>> And you probably have no need for all the caching/general book-keeping
>> drm_prime does (it's all in userspace I guess, except for the magic
>> conversion from grant references to a dma_buf). So there's no point
>> trying to reuse code in drm_prime.c.
>>
>> Also, this should make it tons easier to reuse xen-zcopy for
>> sound/wireless/v4l backends.
>>
>>>>>> That's why I had essentially zero big questions for xen-front (except
>>>>>> some
>>>>>> implementation improvements, and stuff to make sure xen-front actually
>>>>>> implements the real uapi semantics instead of its own), and why I'm
>>>>>> asking
>>>>>> much more questions on this stuff here.
>>>>>>
>>>>>>>>>> 4. inter VM messaging (hype_dmabuf only) - hyper_dmabuf has
>>>>>>>>>> inter-vm
>>>>>>>>>> msg
>>>>>>>>>> communication defined for dmabuf synchronization and private data
>>>>>>>>>> (meta
>>>>>>>>>> info that Matt Roper mentioned) exchange.
>>>>>>>>>
>>>>>>>>> This is true, xen-zcopy has no means for inter VM sync and
>>>>>>>>> meta-data,
>>>>>>>>> simply because it doesn't have any code for inter VM exchange in
>>>>>>>>> it,
>>>>>>>>> e.g. the inter VM protocol is handled by the backend [1].
>>>>>>>>>>
>>>>>>>>>> 5. driver-to-driver notification (hyper_dmabuf only) - importing
>>>>>>>>>> VM
>>>>>>>>>> gets
>>>>>>>>>> notified when newdmabuf is exported from other VM - uevent can be
>>>>>>>>>> optionally
>>>>>>>>>> generated when this happens.
>>>>>>>>>>
>>>>>>>>>> 6. structure - hyper_dmabuf is targetting to provide a generic
>>>>>>>>>> solution for
>>>>>>>>>> inter-domain dmabuf sharing for most hypervisors, which is why it
>>>>>>>>>> has two
>>>>>>>>>> layers as mattrope mentioned, front-end that contains standard API
>>>>>>>>>> and backend
>>>>>>>>>> that is specific to hypervisor.
>>>>>>>>>
>>>>>>>>> Again, xen-zcopy is decoupled from inter VM communication
>>>>>>>>>>>>
>>>>>>>>>>>> No idea, didn't look at it in detail.
>>>>>>>>>>>>
>>>>>>>>>>>> Looks pretty complex from a distant view.  Maybe because it
>>>>>>>>>>>> tries
>>>>>>>>>>>> to
>>>>>>>>>>>> build a communication framework using dma-bufs instead of a
>>>>>>>>>>>> simple
>>>>>>>>>>>> dma-buf passing mechanism.
>>>>>>>>>>
>>>>>>>>>> we started with simple dma-buf sharing but realized there are many
>>>>>>>>>> things we need to consider in real use-case, so we added
>>>>>>>>>> communication
>>>>>>>>>> , notification and dma-buf synchronization then re-structured it
>>>>>>>>>> to
>>>>>>>>>> front-end and back-end (this made things more compicated..) since
>>>>>>>>>> Xen
>>>>>>>>>> was not our only target. Also, we thought passing the reference
>>>>>>>>>> for
>>>>>>>>>> the
>>>>>>>>>> buffer (hyper_dmabuf_id) is not secure so added uvent mechanism
>>>>>>>>>> later.
>>>>>>>>>>
>>>>>>>>>>> Yes, I am looking at it now, trying to figure out the full story
>>>>>>>>>>> and its implementation. BTW, Intel guys were about to share some
>>>>>>>>>>> test application for hyper-dmabuf, maybe I have missed one.
>>>>>>>>>>> It could probably better explain the use-cases and the complexity
>>>>>>>>>>> they have in hyper-dmabuf.
>>>>>>>>>>
>>>>>>>>>> One example is actually in github. If you want take a look at it,
>>>>>>>>>> please
>>>>>>>>>> visit:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> https://github.com/downor/linux_hyper_dmabuf_test/tree/xen/simple_export
>>>>>>>>>
>>>>>>>>> Thank you, I'll have a look
>>>>>>>>>>>>
>>>>>>>>>>>> Like xen-zcopy it seems to depend on the idea that the
>>>>>>>>>>>> hypervisor
>>>>>>>>>>>> manages all memory it is easy for guests to share pages with the
>>>>>>>>>>>> help of
>>>>>>>>>>>> the hypervisor.
>>>>>>>>>>>
>>>>>>>>>>> So, for xen-zcopy we were not trying to make it generic,
>>>>>>>>>>> it just solves display (dumb) zero-copying use-cases for Xen.
>>>>>>>>>>> We implemented it as a DRM helper driver because we can't see any
>>>>>>>>>>> other use-cases as of now.
>>>>>>>>>>> For example, we also have Xen para-virtualized sound driver, but
>>>>>>>>>>> its buffer memory usage is not comparable to what display wants
>>>>>>>>>>> and it works somewhat differently (e.g. there is no "frame done"
>>>>>>>>>>> event, so one can't tell when the sound buffer can be "flipped").
>>>>>>>>>>> At the same time, we do not use virtio-gpu, so this could
>>>>>>>>>>> probably
>>>>>>>>>>> be one more candidate for shared dma-bufs some day.
>>>>>>>>>>>>
>>>>>>>>>>>>       Which simply isn't the case on kvm.
>>>>>>>>>>>>
>>>>>>>>>>>> hyper-dmabuf and xen-zcopy could maybe share code, or
>>>>>>>>>>>> hyper-dmabuf
>>>>>>>>>>>> build
>>>>>>>>>>>> on top of xen-zcopy.
>>>>>>>>>>>
>>>>>>>>>>> Hm, I can imagine that: xen-zcopy could be a library code for
>>>>>>>>>>> hyper-dmabuf
>>>>>>>>>>> in terms of implementing all that page sharing fun in multiple
>>>>>>>>>>> directions,
>>>>>>>>>>> e.g. Host->Guest, Guest->Host, Guest<->Guest.
>>>>>>>>>>> But I'll let Matt and Dongwon to comment on that.
>>>>>>>>>>
>>>>>>>>>> I think we can definitely collaborate. Especially, maybe we are
>>>>>>>>>> using some
>>>>>>>>>> outdated sharing mechanism/grant-table mechanism in our Xen
>>>>>>>>>> backend
>>>>>>>>>> (thanks
>>>>>>>>>> for bringing that up Oleksandr). However, the question is once we
>>>>>>>>>> collaborate
>>>>>>>>>> somehow, can xen-zcopy's usecase use the standard API that
>>>>>>>>>> hyper_dmabuf
>>>>>>>>>> provides? I don't think we need different IOCTLs that do the same
>>>>>>>>>> in
>>>>>>>>>> the final
>>>>>>>>>> solution.
>>>>>>>>>>
>>>>>>>>> If you think of xen-zcopy as a library (which implements Xen
>>>>>>>>> grant references mangling) and DRM PRIME wrapper on top of that
>>>>>>>>> library, we can probably define proper API for that library,
>>>>>>>>> so both xen-zcopy and hyper-dmabuf can use it. What is more, I am
>>>>>>>>> about to start upstreaming Xen para-virtualized sound device driver
>>>>>>>>> soon,
>>>>>>>>> which also uses similar code and gref passing mechanism [3].
>>>>>>>>> (Actually, I was about to upstream drm/xen-front, drm/xen-zcopy and
>>>>>>>>> snd/xen-front and then propose a Xen helper library for sharing big
>>>>>>>>> buffers,
>>>>>>>>> so common code of the above drivers can use the same code w/o code
>>>>>>>>> duplication)
>>>>>>>>
>>>>>>>> I think it is possible to use your functions for memory sharing part
>>>>>>>> in
>>>>>>>> hyper_dmabuf's backend (this 'backend' means the layer that does
>>>>>>>> page
>>>>>>>> sharing
>>>>>>>> and inter-vm communication with xen-specific way.), so why don't we
>>>>>>>> work on
>>>>>>>> "Xen helper library for sharing big buffers" first while we continue
>>>>>>>> our
>>>>>>>> discussion on the common API layer that can cover any dmabuf sharing
>>>>>>>> cases.
>>>>>>>>
>>>>>>> Well, I would love we reuse the code that I have, but I also
>>>>>>> understand that it was limited by my use-cases. So, I do not
>>>>>>> insist we have to ;)
>>>>>>> If we start designing and discussing hyper-dmabuf protocol we of
>>>>>>> course
>>>>>>> can work on this helper library in parallel.
>>>>>>
>>>>>> Imo code reuse is overrated. Adding new uapi is what freaks me out
>>>>>> here
>>>>>> :-)
>>>>>>
>>>>>> If we end up with duplicated implementations, even in upstream, meh,
>>>>>> not
>>>>>> great, but also ok. New uapi, and in a similar way, new hypervisor api
>>>>>> like the dma-buf forwarding that hyperdmabuf does is the kind of thing
>>>>>> that will lock us in for 10+ years (if we make a mistake).
>>>>>>
>>>>>>>>> Thank you,
>>>>>>>>> Oleksandr
>>>>>>>>>
>>>>>>>>> P.S. All, is it a good idea to move this out of udmabuf thread into
>>>>>>>>> a
>>>>>>>>> dedicated one?
>>>>>>>>
>>>>>>>> Either way is fine with me.
>>>>>>>
>>>>>>> So, if you can start designing the protocol we may have a dedicated
>>>>>>> mail
>>>>>>> thread for that. I will try to help with the protocol as much as I
>>>>>>> can
>>>>>>
>>>>>> Please don't start with the protocol. Instead start with the concrete
>>>>>> use-cases, and then figure out why exactly you need new uapi. Once we
>>>>>> have
>>>>>> that answered, we can start thinking about fleshing out the details.
>>>>>
>>>>> On my side there are only 2 use-cases, Guest2 only:
>>>>> 1. Create a PRIME (dma-buf) from grant references
>>>>> 2. Create grant references from PRIME (dma-buf)
>>>>
>>>> So these grant references, are those userspace visible things?
>>>
>>> Yes, the user-space backend receives those from xen-front via [1]
>>>
>>>> I thought
>>>> the grant references was just the kernel/hypervisor internal magic to
>>>> make
>>>> this all work?
>>>
>>> So, I can map the grant references from user-space, but I won't
>>> be able to turn those into a PRIME buffer. So, the only use of those
>>> w/o xen-zcopy is to map grant refs and copy into real HW dumb on every
>>> page
>>> flip.
>>
>> Ok, that explains. I thought your current xen-side implementation for
>> xen-front is already making all that stuff happen. But I'm still not
>> sure given all the confusing talk about back-end we have in these
>> threads (hyperdmabuf people also talked about different backends for
>> different hypervisors, I guess that's a different kind of backend?).
>
> Hope the explanation above makes it all clearer.
> Please let me know if you still want me to elaborate more
>>
>> -Daniel
>
> [1] https://wiki.xen.org/wiki/Paravirtualization_(PV)
> [2] https://wiki.xen.org/wiki/File:XenPV.png



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
