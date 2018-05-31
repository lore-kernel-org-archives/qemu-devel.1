Received: from eggs.gnu.org ([2001:4830:134:3::10]:42763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fOLFF-0005QG-PQ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fOLFB-0002bX-7A
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:55:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58588 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fOLFB-0002aR-0A
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:55:45 -0400
Date: Thu, 31 May 2018 11:55:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180531105540.GC2755@work-vm>
References: <1527673416-31268-1-git-send-email-lidongchen@tencent.com>
	<1527673416-31268-11-git-send-email-lidongchen@tencent.com>
	<20180530165038.GF2410@work-vm>
	<CAOGPPbfES1YDge-jUOkF0EvporeJvz=hu1qrtyXiiVE-8=ArnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGPPbfES1YDge-jUOkF0EvporeJvz=hu1qrtyXiiVE-8=ArnQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 10/12] migration: create a dedicated
 thread to release rdma resource
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: zhang.zhanghailiang@huawei.com, Juan Quintela <quintela@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Aviad Yehezkel <aviadye@mellanox.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Adi Dotan <adido@mellanox.com>, Lidong Chen <lidongchen@tencent.com>

* 858585 jemmy (jemmy858585@gmail.com) wrote:
> On Thu, May 31, 2018 at 12:50 AM, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> > * Lidong Chen (jemmy858585@gmail.com) wrote:
> >> ibv_dereg_mr wait for a long time for big memory size virtual server.
> >>
> >> The test result is:
> >>   10GB  326ms
> >>   20GB  699ms
> >>   30GB  1021ms
> >>   40GB  1387ms
> >>   50GB  1712ms
> >>   60GB  2034ms
> >>   70GB  2457ms
> >>   80GB  2807ms
> >>   90GB  3107ms
> >>   100GB 3474ms
> >>   110GB 3735ms
> >>   120GB 4064ms
> >>   130GB 4567ms
> >>   140GB 4886ms
> >>
> >> this will cause the guest os hang for a while when migration finished.
> >> So create a dedicated thread to release rdma resource.
> >>
> >> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> >> ---
> >>  migration/rdma.c | 21 +++++++++++++++++----
> >>  1 file changed, 17 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/migration/rdma.c b/migration/rdma.c
> >> index dfa4f77..1b9e261 100644
> >> --- a/migration/rdma.c
> >> +++ b/migration/rdma.c
> >> @@ -2979,12 +2979,12 @@ static void qio_channel_rdma_set_aio_fd_handler(QIOChannel *ioc,
> >>      }
> >>  }
> >>
> >> -static int qio_channel_rdma_close(QIOChannel *ioc,
> >> -                                  Error **errp)
> >> +static void *qio_channel_rdma_close_thread(void *arg)
> >>  {
> >> -    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
> >> +    QIOChannelRDMA *rioc = arg;
> >>      RDMAContext *rdmain, *rdmaout;
> >> -    trace_qemu_rdma_close();
> >> +
> >> +    rcu_register_thread();
> >>
> >>      rdmain = rioc->rdmain;
> >>      if (rdmain) {
> >> @@ -3009,6 +3009,19 @@ static int qio_channel_rdma_close(QIOChannel *ioc,
> >>      g_free(rdmain);
> >>      g_free(rdmaout);
> >>
> >> +    rcu_unregister_thread();
> >> +    return NULL;
> >> +}
> >> +
> >> +static int qio_channel_rdma_close(QIOChannel *ioc,
> >> +                                  Error **errp)
> >> +{
> >> +    QemuThread t;
> >> +    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
> >> +    trace_qemu_rdma_close();
> >> +
> >> +    qemu_thread_create(&t, "rdma cleanup", qio_channel_rdma_close_thread,
> >> +                           rioc, QEMU_THREAD_DETACHED);
> >
> > I don't think this can be this simple; consider the lock in patch 4;
> > now that lock means qui_channel_rdma_close() can't be called in
> > parallel; but with this change it means:
> >
> >
> >      f->lock
> >        qemu_thread_create  (1)
> >     !f->lock
> >      f->lock
> >        qemu_thread_create
> >     !f->lock
> >
> > so we don't really protect the thing you were trying to lock
> 
> yes, I should not use rioc as the thread arg.
> 
> static int qio_channel_rdma_close(QIOChannel *ioc,
>                                   Error **errp)
> {
>     QemuThread t;
>     RDMAContext *rdma[2];
>     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
> 
>     trace_qemu_rdma_close();
>     if (rioc->rdmain || rioc->rdmaout) {
>         rdma[0] =  rioc->rdmain;
>         rdma[1] =  rioc->rdmaout;
>         qemu_thread_create(&t, "rdma cleanup", qio_channel_rdma_close_thread,
>                            rdma, QEMU_THREAD_DETACHED);
>         rioc->rdmain = NULL;
>         rioc->rdmaout = NULL;

Is it safe to close both directions at once?
For example, if you get the close from the return path thread, might the
main thread be still using it's QEMUFile in the opposite direction;
it'll call close a little bit later?

Dave

>     }
>     return 0;
> }
> 
> >
> > Dave
> >
> >>      return 0;
> >>  }
> >>
> >> --
> >> 1.8.3.1
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
