Received: from eggs.gnu.org ([2001:4830:134:3::10]:41886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSGe2-0005EB-LC
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSGdz-0001m3-Jl
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:49:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fSGdz-0001lI-FO
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:49:35 -0400
Date: Mon, 11 Jun 2018 08:49:33 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180611064933.dzppo3sj45cbsjcm@sirius.home.kraxel.org>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-12-marcandre.lureau@redhat.com>
	<20180604093750.mtlx2frtx5mzv5w2@sirius.home.kraxel.org>
	<CAJ+F1C+v0NCX+88=MGW7uM_05tgcB4d7rRC-RC87n0a6gAq4kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+v0NCX+88=MGW7uM_05tgcB4d7rRC-RC87n0a6gAq4kA@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC v2 11/12] Add virtio-gpu vhost-user backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Dave Airlie <airlied@gmail.com>

> >> For now, a socketpair is created for the backend to share the rendering
> >> results with qemu via a simple VHOST_GPU protocol.
> >
> > Why this isn't a separate device, like vhost-user-input-pci?
> 
> Ok, let's have vhost-user-gpu-pci and vhost-user-vga, inheriting from
> existing devices.

I'd tend to create separate devices instead of inheriting from the
existing devices.  Arn't the code paths more or less completely
different?  What code is shared between builtin and vhost-user versions
of the devices?

> >> +typedef struct VhostGpuUpdate {
> >> +    uint32_t scanout_id;
> >> +    uint32_t x;
> >> +    uint32_t y;
> >> +    uint32_t width;
> >> +    uint32_t height;
> >> +    uint8_t data[];
> >> +} QEMU_PACKED VhostGpuUpdate;
> >
> > Hmm, when designing a new protocol I think we can do better than just
> > squeering the pixels into a tcp stream.  Use shared memory instead?  Due
> > to vhost we are limited to linux anyway, so we might even consider stuff
> > like dmabufs here.
> 
> Well, my goal is not to invent a new spice or wayland protocol :) I
> don't care much about 2d performance at this point, more about 3d. Can
> we leave 2d improvements for another day? Beside, what would dmabuf
> bring us for 2d compared to shmem?

Well, you need dma-bufs for 3d anyway, so why not use them for 2d too?
I don't think we need separate code paths for 2d vs. 3d updates.

> There seems to be a lot of overhead with the roundtrip vhost-user ->
> qemu -> spice worker -> spice client -> wayland/x11 -> gpu already
> (but this isn't necessarily so bad at 60fps or less).
> Ideally, I would like to bypass qemu & spice for local rendering, but
> I don't think wayland support that kind of nested window composition
> (at least tracking messages weston --nested doesn't show that kind of
> optimization).

Yep, a direct vhost-user -> wayland path makes sense.  Using dma-bufs
for both 2d and 3d should simplify that too (again: one code path
instead of two).

What do you mean with nested window composition?

cheers,
  Gerd
