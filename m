Received: from eggs.gnu.org ([2001:4830:134:3::10]:38444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Oleksandr_Andrushchenko@epam.com>)
	id 1f4LIC-0007pQ-Gj
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 02:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Oleksandr_Andrushchenko@epam.com>)
	id 1f4LI8-0007dN-8Q
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 02:56:12 -0400
Received: from mail-he1eur01on0057.outbound.protection.outlook.com
	([104.47.0.57]:11520
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Oleksandr_Andrushchenko@epam.com>)
	id 1f4LI7-0007cO-8Y
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 02:56:08 -0400
References: <20180313154826.20436-1-kraxel@redhat.com>
	<20180313161035.GL4788@phenom.ffwll.local>
	<20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
	<CAKMK7uGG6Z6XLc6GuKv7-3grCNg+EK2Lh6XWpavjsbZWF_L5Wg@mail.gmail.com>
	<20180406001117.GD31612@mdroper-desk.amr.corp.intel.com>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <2411d2c1-33c0-2ba5-67ea-3bb9af5d5ec9@epam.com>
Date: Fri, 6 Apr 2018 09:55:56 +0300
MIME-Version: 1.0
In-Reply-To: <20180406001117.GD31612@mdroper-desk.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [RfC PATCH] Add udmabuf misc device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matt Roper <matthew.d.roper@intel.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>, dri-devel <dri-devel@lists.freedesktop.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>

On 04/06/2018 03:11 AM, Matt Roper wrote:
> On Thu, Apr 05, 2018 at 10:32:04PM +0200, Daniel Vetter wrote:
>> Pulling this out of the shadows again.
>>
>> We now also have xen-zcopy from Oleksandr and the hyper dmabuf stuff
>> from Matt and Dongwong.
>>
>> At least from the intel side there seems to be the idea to just have 1
>> special device that can handle cross-gues/host sharing for all kinds
>> of hypervisors, so I guess you all need to work together :-)
>>
>> Or we throw out the idea that hyper dmabuf will be cross-hypervisor
>> (not sure how useful/reasonable that is, someone please convince me
>> one way or the other).
>>
>> Cheers, Daniel
> Dongwon (DW) is the one doing all the real work on hyper_dmabuf, but I'm
> familiar with the use cases he's trying to address, and I think there
> are a couple high-level goals of his work that are worth calling out as
> we discuss the various options for sharing buffers produced in one VM
> with a consumer running in another VM:
>
>   * We should try to keep the interface/usage separate from the
>     underlying hypervisor implementation details.  I.e., in DW's design
>     the sink/source drivers that handle the actual buffer passing in the
>     two VM's should provide a generic interface that does not depend on a
>     specific hypervisor.
This is what we did for display, sound and multi-touch on Xen:
we have implemented generic protocols which are OS agnostic.
Have you started prototyping such a protocol for hyper-dmabuf yet?

>   Behind the scenes there could be various
>     implementations for specific hypervisors (Xen, KVM, ACRN, etc.), and
>     some of those backends may have additional restrictions, but it would
>     be best if userspace didn't have to know the specific hypervisor
>     running on the system and could just query the general capabilities
>     available to it.  We've already got projects in flight that are
>     wanting this functionality on Xen and ACRN today.
Should we add corresponding communities into discussion then?

>
>   * The general interface should be able to express sharing from any
>     guest:guest, not just guest:host.  Arbitrary G:G sharing might be
>     something some hypervisors simply aren't able to support, but the
>     userspace API itself shouldn't make assumptions or restrict that.  I
>     think ideally the sharing API would include some kind of
>     query_targets interface that would return a list of VM's that your
>     current OS is allowed to share with; that list would be depend on the
>     policy established by the system integrator, but obviously wouldn't
>     include targets that the hypervisor itself wouldn't be capable of
>     handling.
Can you give a use-case for this? I mean that the system integrator
is the one who defines which guests/hosts talk to each other,
but querying means that it is possible that VMs have some sort
of discovery mechanism, so they can decide on their own whom
to connect to.
>    =20
>   * A lot of the initial use cases are in the realm of graphics, but this
>     shouldn't be a graphics-specific API.  Buffers might contain other
>     types of content as well (e.g., audio).  Really the content producer
>     could potentially be any driver (or userspace) running in the VM that
>     knows how to import/export dma_buf's (or maybe just import given
>     danvet's suggestion that we should make the sink driver do all the
>     actual memory allocation for any buffers that may be shared).
>
>   * We need to be able to handle cross-VM coordination of buffer usage as
>     well, so I think we'd want to include fence forwarding support in the
>     API as well to signal back and forth about production/consumption
>     completion.  And of course document really well what should happen
>     if, for example, the entire VM you're sharing with/from dies.
>
>   * The sharing API could be used to share multiple kinds of content in a
>     single system.  The sharing sink driver running in the content
>     producer's VM should accept some additional metadata that will be
>     passed over to the target VM as well.  The sharing source driver
>     running in the content consumer's VM would then be able to use this
>     metadata to determine the purpose of a new buffer that arrives and
>     filter/dispatch it to the appropriate consumer.
>
>
> For reference, the terminology I'm using is
>
>   /----------\  dma_buf   /------\ HV /--------\  dma_buf   /----------\
>   | Producer |----------->| Sink | HV | Source |----------->| Consumer |
>   \----------/   ioctls   \------/ HV \--------/  uevents   \----------/
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
> I'm not super familiar with xen-zcopy

Let me describe the rationale and some implementation details of the Xen
zero-copy driver I posted recently [1].

The main requirement for us to implement such a helper driver was an abilit=
y
to avoid memory copying for large buffers in display use-cases. This is why
we only focused on DRM use-cases, not trying to implement something
generic. This is why the driver is somewhat coupled with Xen=20
para-virtualized
DRM driver [2] by Xen para-virtual display protocol [3] grant references
sharing mechanism, e.g. backend receives an array of Xen grant references t=
o
frontend's buffer pages. These grant references are then used to construct =
a
PRIME buffer. The same mechanism is used when backend shares a buffer=20
with the
frontend, but in the other direction. More details on UAPI of the driver ar=
e
available at [1].

So, when discussing a possibility to share dma-bufs in a generic way I woul=
d
also like to have the following considered:

1. We are targeting ARM and one of the major requirements for the buffer
sharing is the ability to allocate physically contiguous buffers, which get=
s
even more complicated for systems not backed with an IOMMU. So, for some
use-cases it is enough to make the buffers contiguous in terms of IPA and
sometimes those need to be contiguous in terms of PA.
(The use-case is that you use Wayland-DRM/KMS or share the buffer with
the driver implemented with DRM CMA helpers).

2. For Xen we would love to see UAPI to create a dma-buf from grant=20
references
provided, so we can use this generic solution to implement zero-copying=20
without
breaking the existing Xen protocols. This can probably be extended to other
hypervizors as well.

Thank you,
Oleksandr Andrushchenko


>   and udmabuf, but it sounds like
> they're approaching similar problems from slightly different directions,
> so we should make sure we can come up with something that satisfies
> everyone's requirements.
>
>
> Matt
>
>> On Wed, Mar 14, 2018 at 9:03 AM, Gerd Hoffmann <kraxel@redhat.com> wrote=
:
>>>    Hi,
>>>
>>>> Either mlock account (because it's mlocked defacto), and get_user_page=
s
>>>> won't do that for you.
>>>>
>>>> Or you write the full-blown userptr implementation, including mmu_noti=
fier
>>>> support (see i915 or amdgpu), but that also requires Christian K=C3=B6=
nigs
>>>> latest ->invalidate_mapping RFC for dma-buf (since atm exporting userp=
tr
>>>> buffers is a no-go).
>>> I guess I'll look at mlock accounting for starters then.  Easier for
>>> now, and leaves the door open to switch to userptr later as this should
>>> be transparent to userspace.
>>>
>>>>> Known issue:  Driver API isn't complete yet.  Need add some flags, fo=
r
>>>>> example to support read-only buffers.
>>>> dma-buf has no concept of read-only. I don't think we can even enforce
>>>> that (not many iommus can enforce this iirc), so pretty much need to
>>>> require r/w memory.
>>> Ah, ok.  Just saw the 'write' arg for get_user_pages_fast and figured w=
e
>>> might support that, but if iommus can't handle that anyway it's
>>> pointless indeed.
>>>
>>>>> Cc: David Airlie <airlied@linux.ie>
>>>>> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>>> btw there's also the hyperdmabuf stuff from the xen folks, but imo the=
ir
>>>> solution of forwarding the entire dma-buf api is over the top. This he=
re
>>>> looks _much_ better, pls cc all the hyperdmabuf people on your next
>>>> version.
>>> Fun fact: googling for "hyperdmabuf" found me your mail and nothing els=
e :-o
>>> (Trying "hyper dmabuf" instead worked better then).
>>>
>>> Yes, will cc them on the next version.  Not sure it'll help much on xen
>>> though due to the memory management being very different.  Basically xe=
n
>>> owns the memory, not the kernel of the control domain (dom0), so
>>> creating dmabufs for guest memory chunks isn't that simple ...
>>>
>>> Also it's not clear whenever they really need guest -> guest exports or
>>> guest -> dom0 exports.
>>>
>>>> Overall I like the idea, but too lazy to review.
>>> Cool.  General comments on the idea was all I was looking for for the
>>> moment.  Spare yor review cycles for the next version ;)
>>>
>>>> Oh, some kselftests for this stuff would be lovely.
>>> I'll look into it.
>>>
>>> thanks,
>>>    Gerd
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>>
>> --=20
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
[1] https://patchwork.freedesktop.org/series/40880/
[2]=20
https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3Dc575b7eeb89f94356997=
abd62d6d5a0590e259b7
[3]=20
https://elixir.bootlin.com/linux/v4.16-rc7/source/include/xen/interface/io/=
displif.h
