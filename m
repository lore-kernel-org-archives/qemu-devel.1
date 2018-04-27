Received: from eggs.gnu.org ([2001:4830:134:3::10]:57268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBzUG-0005nL-Ts
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBzUD-0006nB-Nb
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:16:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37282 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fBzUD-0006mv-HE
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:16:13 -0400
Date: Fri, 27 Apr 2018 10:16:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180427091603.GD32172@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1524666934-8064-1-git-send-email-lidongchen@tencent.com>
	<1524666934-8064-5-git-send-email-lidongchen@tencent.com>
	<20180426173641.GN2631@work-vm>
	<CAOGPPbcPb4F2m_o4jPn2ELRK19=Yr=P+QRi4r_-eVhzmV0d5kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOGPPbcPb4F2m_o4jPn2ELRK19=Yr=P+QRi4r_-eVhzmV0d5kA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] migration: implement bi-directional
 RDMA QIOChannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Gal Shachaf <galsha@mellanox.com>, Aviad Yehezkel <aviadye@mellanox.com>, licq@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

On Fri, Apr 27, 2018 at 03:56:38PM +0800, 858585 jemmy wrote:
> On Fri, Apr 27, 2018 at 1:36 AM, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> > * Lidong Chen (jemmy858585@gmail.com) wrote:
> >> This patch implements bi-directional RDMA QIOChannel. Because different
> >> threads may access RDMAQIOChannel concurrently, this patch use RCU to protect it.
> >>
> >> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> >
> > I'm a bit confused by this.
> >
> > I can see it's adding RCU to protect the rdma structures against
> > deletion from multiple threads; that I'm OK with in principal; is that
> > the only locking we need? (I guess the two directions are actually
> > separate RDMAContext's so maybe).
> 
> The qio_channel_rdma_close maybe invoked by migration thread and
> return path thread
> concurrently, so I use a mutex to protect it.

Hmm, that is not good - concurrent threads calling close must not be
allowed to happen even with non-RDMA I/O chanels.

For example, with the QIOChannelSocket, one thread can call close
which sets the fd = -1, another thread can race with this and either
end up calling close again on the same FD or calling close on -1.
Either way the second thread will get an error from close() when
it should have skipped the close() and returned success. Perhaps
migration gets lucky and this doesn't result in it being marked
as failed, but it is still not good.

So only one thread should be calling close().

> If one thread invoke qio_channel_rdma_writev, another thread invokes
> qio_channel_rdma_readv,
> two threads will use separate RDMAContext, so it does not need a lock.
> 
> If two threads invoke qio_channel_rdma_writev concurrently, it will
> need a lock to protect.
> but I find source qemu migration thread only invoke
> qio_channel_rdma_writev, the return path
> thread only invokes qio_channel_rdma_readv.

QIOChannel impls are only intended to cope with a single thread doing
I/O in each direction. If you have two threads needing to read, or
two threads needing to write, the layer above should provide locking
to ensure correct ordering  of I/O oprations.

> The destination qemu only invoked qio_channel_rdma_readv by main
> thread before postcopy and or
> listen thread after postcopy.
> 
> The destination qemu have already protected it by using
> qemu_mutex_lock(&mis->rp_mutex) when writing data to
> source qemu.
> 
> But should we use qemu_mutex_lock to protect qio_channel_rdma_writev
> and qio_channel_rdma_readv?
> to avoid some change in future invoke qio_channel_rdma_writev or
> qio_channel_rdma_readv concurrently?

> 
> >
> > But is there nothing else to make the QIOChannel bidirectional?
> >
> > Also, a lot seems dependent on listen_id, can you explain how that's
> > being used.
> 
> The destination qemu is server side, so listen_id is not zero. the
> source qemu is client side,
> the listen_id is zero.
> I use listen_id to determine whether qemu is destination or source.
> 
> for the destination qemu, if write data to source, it need use the
> return_path rdma, like this:
>     if (rdma->listen_id) {
>         rdma = rdma->return_path;
>     }
> 
> for the source qemu, if read data from destination, it also need use
> the return_path rdma.
>     if (!rdma->listen_id) {
>         rdma = rdma->return_path;
>     }

This feels uncessarily complex to me. Why not just change QIOCHannelRMDA
struct, so that it has 2 RDMA context pointers eg

struct QIOChannelRDMA {
    QIOChannel parent;
    RDMAContext *rdmain;
    RDMAContext *rdmaout;
    QEMUFile *file;
    bool blocking; /* XXX we don't actually honour this yet */
};



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
