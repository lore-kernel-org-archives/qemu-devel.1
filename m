Received: from eggs.gnu.org ([2001:4830:134:3::10]:43826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRVeW-000186-Hi
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRVeR-00035Z-Id
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:06:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRVeR-00034o-Bv
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:06:39 -0500
Date: Wed, 20 Dec 2017 06:06:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171220060449-mutt-send-email-mst@kernel.org>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<20171219113505.GA8499@stefanha-x1.localdomain>
	<20171219161754-mutt-send-email-mst@kernel.org>
	<CAJSP0QV80YLwDfKJaXkjepwttsrX1wuH0c_69KTq_mGimYMf1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QV80YLwDfKJaXkjepwttsrX1wuH0c_69KTq_mGimYMf1g@mail.gmail.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, "Avi Cohen (A)" <avi.cohen@huawei.com>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Wei Wang <wei.w.wang@intel.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Dec 19, 2017 at 05:05:59PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 19, 2017 at 2:56 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>  * Please handle short reads/writes and EAGAIN with the UNIX domain socket.  Do
> >>    not use read/write_all() functions because they hang QEMU until I/O
> >>    completes.
> >
> > I'm not sure I agree with this one. vhost-user uses this extensively
> > right now. It might be a worth-while goal to drop this limitation
> > but I don't see why we should start with vhost-pci.
> >
> > And in particular, VCPU can't make progress unless a slave is present.
> 
> Hang on, we're talking about different things:
> 
> The QEMU vhost-user master blocks because vhost_*() functions are
> synchronous (they don't use callbacks or yield).  Fixing that is
> beyond the scope of this patch series and I'm not asking for it.
> 
> This patch series adds a from-scratch vhost-user slave implementation
> which has no good reason to be blocking.  A single malicious or broken
> guest must not be able to hang a vhost-pci network switch.

Hmm that's not an easy change. But I agree, it's more important for
the switch.

> >>  * How can the the guest limit the number of virtqueues?
> >
> > I think it is feasible to pass in host features, # of vqs etc.  Assuming
> > compatibility with existing guests, I don't think you can do anything
> > else really if you assume that vhost guest might boot after the
> > virtio guest.
> >
> > So either you give up on compatibility, or you allow the vhost
> > guest to block the virtio guest.
> >
> > I think compatibility is more important.
> >
> > We can later think about ways to add non-blocking behaviour
> > as a feature.
> 
> I agree it's a separate feature because it will require non-vhost-pci
> related changes.
> 
> I have posted a separate email thread to discuss a solution.
> 
> >>
> >>  * Please include tests.  See tests/virtio-net-test.c and
> >>    tests/vhost-user-test.c for examples.
> >
> > Unit tests are nice but an actual way to test without
> > running a full blown dpdk stack would be nicer.
> > Something along the lines of a port of vhost user bridge
> > to the guest.
> 
> Yes!
