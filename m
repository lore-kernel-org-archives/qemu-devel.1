Received: from eggs.gnu.org ([209.51.188.92]:58565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjOvT-0005fB-D7
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 08:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjOvS-0008Ao-5x
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 08:38:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gjOvK-00086X-LE
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 08:38:36 -0500
Date: Tue, 15 Jan 2019 14:38:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190115143822.007b5c63.cohuck@redhat.com>
In-Reply-To: <20190115131119.GA3026@dimastep-nix>
References: <1547546927-18006-1-git-send-email-dimastep@yandex-team.ru>
	<20190115114009.0a09eac1.cohuck@redhat.com>
	<20190115131119.GA3026@dimastep-nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] virtio: add checks for the size of the
 indirect table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dima Stepanov <dimastep@yandex-team.ru>
Cc: mst@redhat.com, qemu-devel@nongnu.org, wrfsh@yandex-team.ru

On Tue, 15 Jan 2019 16:11:19 +0300
Dima Stepanov <dimastep@yandex-team.ru> wrote:

> On Tue, Jan 15, 2019 at 11:40:09AM +0100, Cornelia Huck wrote:
> > On Tue, 15 Jan 2019 13:08:47 +0300
> > Dima Stepanov <dimastep@yandex-team.ru> wrote:
> >   
> > > The virtqueue_pop() and virtqueue_get_avail_bytes() routines can use the
> > > INDIRECT table to get the data. It is possible to create a packet which
> > > will lead to the assert message like:
> > >   include/exec/memory.h:1995: void
> > >   address_space_read_cached(MemoryRegionCache *, hwaddr, void *, int):
> > >   Assertion `addr < cache->len && len <= cache->len - addr' failed.
> > >   Aborted
> > > To do it the first descriptor should have a link to the INDIRECT table
> > > and set the size of it to 0. It doesn't look good that the guest should
> > > be able to trigger the assert in qemu. Add additional check for the size
> > > of the INDIRECT table, which should not be 0.  
> > 
> > Ouch, being able to crash QEMU by a specially crafted descriptor is bad.
> > 
> > Looking at the virtio spec, we don't seem to explicitly disallow
> > indirect descriptors with a zero-length table. So, as an alternative to
> > marking the device broken, we could also skip over such a descriptor.
> > Not sure whether that makes sense, though.  
> 
> Hard to say what is the better option here: mark device with the
> VIRTIO_CONFIG_S_NEEDS_RESET bit or just skip the descriptor. Right now
> all the parsing errors are handled using the virtio_error() call. The
> possible parsing errors are: wrong address, looped descriptors, invalid
> size, incorrect order and so on. Some of those errors are not described
> in the virtio spec. So it looks like that this error should be also
> handled by calling virtio_error().

virtio_error() is certainly the safe option (and easiest to implement),
and handling weird descriptors is probably not worth the time.

FWIW,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Should this be cc:stable, as it is a guest-triggerable crash?

> 
> >   
> > > 
> > > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > > ---
> > >  hw/virtio/virtio.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index 22bd1ac..a1ff647 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -646,7 +646,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
> > >          vring_desc_read(vdev, &desc, desc_cache, i);
> > >  
> > >          if (desc.flags & VRING_DESC_F_INDIRECT) {
> > > -            if (desc.len % sizeof(VRingDesc)) {
> > > +            if (!desc.len || (desc.len % sizeof(VRingDesc))) {
> > >                  virtio_error(vdev, "Invalid size for indirect buffer table");
> > >                  goto err;
> > >              }
> > > @@ -902,7 +902,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
> > >      desc_cache = &caches->desc;
> > >      vring_desc_read(vdev, &desc, desc_cache, i);
> > >      if (desc.flags & VRING_DESC_F_INDIRECT) {
> > > -        if (desc.len % sizeof(VRingDesc)) {
> > > +        if (!desc.len || (desc.len % sizeof(VRingDesc))) {
> > >              virtio_error(vdev, "Invalid size for indirect buffer table");
> > >              goto done;
> > >          }  
> >   
