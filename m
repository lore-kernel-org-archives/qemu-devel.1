Received: from eggs.gnu.org ([2001:4830:134:3::10]:49968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cblia-0004Yk-4m
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbliW-0000aH-3m
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:12:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cbliV-0000aB-UV
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:12:44 -0500
Date: Thu, 9 Feb 2017 18:12:40 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170209101240.GJ22807@lemon.lan>
References: <CAO_EM_m9Z7WcxRZthAGgeDgJ6UuwKXwAOEH7NC2=hL8Cd4jABg@mail.gmail.com>
	<20170209014728.GF22807@lemon.lan>
	<CAO_EM_mJYNoxTLjKmTy18JhrL_zs_VLA32Y=Cw+LYqAGPzLN=w@mail.gmail.com>
	<20170209025212.GG22807@lemon.lan>
	<CAO_EM_kh1mQZNhjRKi458u15kj0G6t=UEFBvM+wWhOX1fyi6VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_EM_kh1mQZNhjRKi458u15kj0G6t=UEFBvM+wWhOX1fyi6VQ@mail.gmail.com>
Subject: Re: [Qemu-devel] virtio-scsi-pci iothread spins at 100%
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, 02/08 19:44, Ed Swierk wrote:
> On Wed, Feb 8, 2017 at 6:52 PM, Fam Zheng <famz@redhat.com> wrote:
> > This means virtio-scsi event vq handler is returning true but actually no
> > progress is made. Can you try the following patch to see if it's because a
> > stalled cache of VQ index?
> >
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 6365706..7f7ab57 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -2126,7 +2126,7 @@ static bool virtio_queue_host_notifier_aio_poll(void *opaque)
> >      EventNotifier *n = opaque;
> >      VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
> >
> > -    if (virtio_queue_empty(vq)) {
> > +    if (vring_avail_idx(vq) == vq->last_avail_idx) {
> >          return false;
> >      }
> 
> I tried this change but the behavior is the same, unfortunately.

This should fix it:

https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01874.html

It would be great if you could help test it.

Fam
