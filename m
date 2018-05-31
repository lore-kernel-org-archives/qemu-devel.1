Received: from eggs.gnu.org ([2001:4830:134:3::10]:42036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fOLCP-0003eM-OG
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fOLCL-0008Di-6a
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:52:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41566 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fOLCL-0008DY-0V
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:52:49 -0400
Date: Thu, 31 May 2018 11:52:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180531105243.GB2755@work-vm>
References: <1527673416-31268-1-git-send-email-lidongchen@tencent.com>
	<1527673416-31268-5-git-send-email-lidongchen@tencent.com>
	<20180530144543.GE2410@work-vm>
	<CAOGPPbf9kZOPdotsX7ynUE8XfeVq=vgPJX0AbVUAB4et4T1KKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGPPbf9kZOPdotsX7ynUE8XfeVq=vgPJX0AbVUAB4et4T1KKQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 04/12] migration: avoid concurrent
 invoke channel_close by different threads
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
> On Wed, May 30, 2018 at 10:45 PM, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> > * Lidong Chen (jemmy858585@gmail.com) wrote:
> >> From: Lidong Chen <jemmy858585@gmail.com>
> >>
> >> The channel_close maybe invoked by different threads. For example, source
> >> qemu invokes qemu_fclose in main thread, migration thread and return path
> >> thread. Destination qemu invokes qemu_fclose in main thread, listen thread
> >> and COLO incoming thread.
> >>
> >> Add a mutex in QEMUFile struct to avoid concurrent invoke channel_close.
> >>
> >> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> >> ---
> >>  migration/qemu-file.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> >> index 977b9ae..87d0f05 100644
> >> --- a/migration/qemu-file.c
> >> +++ b/migration/qemu-file.c
> >> @@ -52,6 +52,7 @@ struct QEMUFile {
> >>      unsigned int iovcnt;
> >>
> >>      int last_error;
> >> +    QemuMutex lock;
> >
> > That could do with a comment saying what you're protecting
> >
> >>  };
> >>
> >>  /*
> >> @@ -96,6 +97,7 @@ QEMUFile *qemu_fopen_ops(void *opaque, const QEMUFileOps *ops)
> >>
> >>      f = g_new0(QEMUFile, 1);
> >>
> >> +    qemu_mutex_init(&f->lock);
> >>      f->opaque = opaque;
> >>      f->ops = ops;
> >>      return f;
> >> @@ -328,7 +330,9 @@ int qemu_fclose(QEMUFile *f)
> >>      ret = qemu_file_get_error(f);
> >>
> >>      if (f->ops->close) {
> >> +        qemu_mutex_lock(&f->lock);
> >>          int ret2 = f->ops->close(f->opaque);
> >> +        qemu_mutex_unlock(&f->lock);
> >
> > OK, and at least for the RDMA code, if it calls
> > close a 2nd time, rioc->rdma is checked so it wont actually free stuff a
> > 2nd time.
> >
> >>          if (ret >= 0) {
> >>              ret = ret2;
> >>          }
> >> @@ -339,6 +343,7 @@ int qemu_fclose(QEMUFile *f)
> >>      if (f->last_error) {
> >>          ret = f->last_error;
> >>      }
> >> +    qemu_mutex_destroy(&f->lock);
> >>      g_free(f);
> >
> > Hmm but that's not safe; if two things really do call qemu_fclose()
> > on the same structure they race here and can end up destroying the lock
> > twice, or doing f->lock  after the 1st one has already g_free(f).
> 
> >
> >
> > So lets go back a step.
> > I think:
> >   a) There should always be a separate QEMUFile* for
> >      to_src_file and from_src_file - I don't see where you open
> >      the 2nd one; I don't see your implementation of
> >      f->ops->get_return_path.
> 
> yes, current qemu version use a separate QEMUFile* for to_src_file and
> from_src_file.
> and the two QEMUFile point to one QIOChannelRDMA.
> 
> the f->ops->get_return_path is implemented by channel_output_ops or
> channel_input_ops.

Ah OK, yes that makes sense.

> >   b) I *think* that while the different threads might all call
> >      fclose(), I think there should only ever be one qemu_fclose
> >      call for each direction on the QEMUFile.
> >
> > But now we have two problems:
> >   If (a) is true then f->lock  is separate on each one so
> >    doesn't really protect if the two directions are closed
> >    at once. (Assuming (b) is true)
> 
> yes, you are right.  so I should add a QemuMutex in QIOChannel structure, not
> QEMUFile structure. and qemu_mutex_destroy the QemuMutex in
> qio_channel_finalize.

OK, that sounds better.

Dave

> Thank you.
> 
> >
> >   If (a) is false and we actually share a single QEMUFile then
> >  that race at the end happens.
> >
> > Dave
> >
> >
> >>      trace_qemu_file_fclose();
> >>      return ret;
> >> --
> >> 1.8.3.1
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
