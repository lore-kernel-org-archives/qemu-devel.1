Received: from eggs.gnu.org ([2001:4830:134:3::10]:45251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel.vetter@ffwll.ch>) id 1f4BYI-0006Xk-PK
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 16:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel.vetter@ffwll.ch>) id 1f4BYE-00056U-Mq
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 16:32:10 -0400
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:37640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <daniel.vetter@ffwll.ch>)
	id 1f4BYE-000560-Hi
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 16:32:06 -0400
Received: by mail-it0-x229.google.com with SMTP id 71-v6so5845397ith.2
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 13:32:05 -0700 (PDT)
MIME-Version: 1.0
Sender: daniel.vetter@ffwll.ch
In-Reply-To: <20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
References: <20180313154826.20436-1-kraxel@redhat.com>
	<20180313161035.GL4788@phenom.ffwll.local>
	<20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 5 Apr 2018 22:32:04 +0200
Message-ID: <CAKMK7uGG6Z6XLc6GuKv7-3grCNg+EK2Lh6XWpavjsbZWF_L5Wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Gerd Hoffmann <kraxel@redhat.com>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Dongwon Kim <dongwon.kim@intel.com>, Matthew D Roper <matthew.d.roper@intel.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>

Pulling this out of the shadows again.

We now also have xen-zcopy from Oleksandr and the hyper dmabuf stuff
from Matt and Dongwong.

At least from the intel side there seems to be the idea to just have 1
special device that can handle cross-gues/host sharing for all kinds
of hypervisors, so I guess you all need to work together :-)

Or we throw out the idea that hyper dmabuf will be cross-hypervisor
(not sure how useful/reasonable that is, someone please convince me
one way or the other).

Cheers, Daniel

On Wed, Mar 14, 2018 at 9:03 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
>> Either mlock account (because it's mlocked defacto), and get_user_pages
>> won't do that for you.
>>
>> Or you write the full-blown userptr implementation, including mmu_notifi=
er
>> support (see i915 or amdgpu), but that also requires Christian K=C3=B6ni=
gs
>> latest ->invalidate_mapping RFC for dma-buf (since atm exporting userptr
>> buffers is a no-go).
>
> I guess I'll look at mlock accounting for starters then.  Easier for
> now, and leaves the door open to switch to userptr later as this should
> be transparent to userspace.
>
>> > Known issue:  Driver API isn't complete yet.  Need add some flags, for
>> > example to support read-only buffers.
>>
>> dma-buf has no concept of read-only. I don't think we can even enforce
>> that (not many iommus can enforce this iirc), so pretty much need to
>> require r/w memory.
>
> Ah, ok.  Just saw the 'write' arg for get_user_pages_fast and figured we
> might support that, but if iommus can't handle that anyway it's
> pointless indeed.
>
>> > Cc: David Airlie <airlied@linux.ie>
>> > Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>
>> btw there's also the hyperdmabuf stuff from the xen folks, but imo their
>> solution of forwarding the entire dma-buf api is over the top. This here
>> looks _much_ better, pls cc all the hyperdmabuf people on your next
>> version.
>
> Fun fact: googling for "hyperdmabuf" found me your mail and nothing else =
:-o
> (Trying "hyper dmabuf" instead worked better then).
>
> Yes, will cc them on the next version.  Not sure it'll help much on xen
> though due to the memory management being very different.  Basically xen
> owns the memory, not the kernel of the control domain (dom0), so
> creating dmabufs for guest memory chunks isn't that simple ...
>
> Also it's not clear whenever they really need guest -> guest exports or
> guest -> dom0 exports.
>
>> Overall I like the idea, but too lazy to review.
>
> Cool.  General comments on the idea was all I was looking for for the
> moment.  Spare yor review cycles for the next version ;)
>
>> Oh, some kselftests for this stuff would be lovely.
>
> I'll look into it.
>
> thanks,
>   Gerd
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
