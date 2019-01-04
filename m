Received: from eggs.gnu.org ([208.118.235.92]:44444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gfFQq-0006fk-97
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 21:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gfFQm-0002GG-A8
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 21:41:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gfFQm-0002Fn-2A
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 21:41:52 -0500
Date: Thu, 3 Jan 2019 21:41:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190103214028-mutt-send-email-mst@kernel.org>
References: <20190103101819.7418-1-xieyongji@baidu.com>
	<20190103101819.7418-3-xieyongji@baidu.com>
	<20190103115512-mutt-send-email-mst@kernel.org>
	<CAONzpcaD6DeDfhjxm_3-ZSrfTXJAenYWN1LC78nU-fovCpuGqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONzpcaD6DeDfhjxm_3-ZSrfTXJAenYWN1LC78nU-fovCpuGqQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 for-4.0 2/7] vhost-user: Support
 providing shared memory to backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Fri, Jan 04, 2019 at 10:31:34AM +0800, Yongji Xie wrote:
> On Fri, 4 Jan 2019 at 01:02, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jan 03, 2019 at 06:18:14PM +0800, elohimes@gmail.com wrote:
> > > From: Xie Yongji <xieyongji@baidu.com>
> > >
> > > This patch introduces two new messages VHOST_USER_GET_SHM_SIZE
> > > and VHOST_USER_SET_SHM_FD to support providing shared
> > > memory to backend.
> >
> > So this seems a bit vague. Since we are going to use it
> > for tracking in-flight I/O I would prefer it that we
> > actually call it that.
> >
> >
> 
> So how about VHOST_USER_GET_INFLIGHT_SIZE and VHOST_USER_SET_INFLIHGT_FD?

Sounds good.

> > >
> > > Firstly, qemu uses VHOST_USER_GET_SHM_SIZE to get the
> > > required size of shared memory from backend. Then, qemu
> > > allocates memory and sends them
> >
> > s/them/it/ ?
> >
> 
> Will fix it in v4.
> 
> > > back to backend through
> > > VHOST_USER_SET_SHM_FD.
> > >
> > > Note that the shared memory should be used to record
> > > inflight I/O by backend. Qemu will clear it when vm reset.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > > Signed-off-by: Chai Wen <chaiwen@baidu.com>
> > > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > > ---
> > >  docs/interop/vhost-user.txt       |  41 +++++++++++
> > >  hw/virtio/vhost-user.c            |  86 ++++++++++++++++++++++
> > >  hw/virtio/vhost.c                 | 117 ++++++++++++++++++++++++++++++
> > >  include/hw/virtio/vhost-backend.h |   9 +++
> > >  include/hw/virtio/vhost.h         |  19 +++++
> > >  5 files changed, 272 insertions(+)
> > >
> > > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> > > index c2194711d9..5ee9c28ab0 100644
> > > --- a/docs/interop/vhost-user.txt
> > > +++ b/docs/interop/vhost-user.txt
> > > @@ -142,6 +142,19 @@ Depending on the request type, payload can be:
> > >     Offset: a 64-bit offset of this area from the start of the
> > >         supplied file descriptor
> > >
> > > + * Shm description
> > > +   -----------------------------------
> > > +   | mmap_size | mmap_offset | dev_size | vq_size | align | version |
> > > +   -----------------------------------
> > > +
> > > +   Mmap_size: a 64-bit size of the shared memory
> > > +   Mmap_offset: a 64-bit offset of the shared memory from the start
> > > +                of the supplied file descriptor
> > > +   Dev_size: a 32-bit size of device region in shared memory
> > > +   Vq_size: a 32-bit size of each virtqueue region in shared memory
> > > +   Align: a 32-bit align of each region in shared memory
> > > +   Version: a 32-bit version of this shared memory
> > > +
> >
> > This is an informal description so please avoid _ in field
> > names, just put a space in there. See e.g. log description.
> >
> >
> Got it!
> 
> > >  In QEMU the vhost-user message is implemented with the following struct:
> > >
> > >  typedef struct VhostUserMsg {
> >
> >
> > For things to work, in-flight format must not change when
> > backend reconnects.
> >
> 
> I'm not sure whether there will be some cases that we want to add some fields to
> the inflight area without stopping vm.

Sorry I'm not sure I understand this comment. All I am saying is that
when one backend disconnects and another reconnects they must agree on
the format, so it's a good idea to document it.

> > To encourage consistency, how about including a recommended format for
> > this buffer in this document?
> >
> >
> 
> Sure. Will add it in v4.
> 
> Thanks,
> Yongji
