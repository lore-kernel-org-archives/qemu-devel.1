Received: from eggs.gnu.org ([209.51.188.92]:49229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1goL9G-0004ON-Pw
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 23:37:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1goKz3-0005xO-Mb
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 23:26:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1goKz3-0005qe-2X
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 23:26:49 -0500
Date: Mon, 28 Jan 2019 23:26:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190128232025-mutt-send-email-mst@kernel.org>
References: <20190122083152.10705-1-xieyongji@baidu.com>
	<20190122083152.10705-2-xieyongji@baidu.com>
	<20190129041155.GG3264@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129041155.GG3264@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v5 1/6] vhost-user: Support transferring
 inflight buffer between qemu and backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: elohimes@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru, qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Tue, Jan 29, 2019 at 12:11:55PM +0800, Stefan Hajnoczi wrote:
> On Tue, Jan 22, 2019 at 04:31:47PM +0800, elohimes@gmail.com wrote:
> > +typedef struct DescState {
> > +    uint8_t inuse;
> > +    uint8_t version;
> > +    uint16_t used_idx;
> > +    uint16_t avail_idx;
> > +    uint16_t reserved;
> > +} DescState;
> > +
> > +typedef struct QueueRegion {
> > +    uint8_t valid;

what's this?

> > +    uint16_t desc_num;

there's padding before this field. Pls make it explicit.

> > +    DescState desc[0];
> > +} QueueRegion;
> > +
> > +The struct DescState is used to describe one head-descriptor's state. The
> > +fields have following meanings:
> > +
> > +    inuse: Indicate whether the descriptor is inuse or not.

inuse by what?

> > +
> > +    version: Indicate whether we have an atomic update to used ring and
> > +    inflight buffer when slave crash at that point. This field should be
> > +    increased by one before and after this two updates. An odd version
> > +    indicates an in-progress update.

I'm not sure I understand what does the above say. Also does this
require two atomics? Seems pretty expensive. And why is it called
version?

> > +
> > +    used_idx: Store old index of used ring before we update used ring and
> > +    inflight buffer so that slave can know whether an odd version inflight
> > +    head-descriptor in inflight buffer is processed or not.

Here too.

> > +
> > +    avail_idx: Used to preserve the descriptor's order in avail ring so that
> > +    slave can resubmit descriptors in order.

Why would that be necessary?

> 
> Will a completely new "packed vring" inflight shm layout be necessary to
> support the packed vring layout in VIRTIO 1.1?
> 
> https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html#x1-610007

Probably.

-- 
MST
