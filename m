Received: from eggs.gnu.org ([2001:4830:134:3::10]:45497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gI25X-00015J-QP
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 21:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gI25V-0003oO-Ct
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 21:47:58 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1gI25U-0003nz-T6
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 21:47:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id i17-v6so18453716wre.7
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 18:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181024163529.15665-1-zhangckid@gmail.com>
	<20181030195512.GF2441@work-vm> <20181031164702.GB2403@work-vm>
In-Reply-To: <20181031164702.GB2403@work-vm>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 1 Nov 2018 09:47:42 +0800
Message-ID: <CAK3tnvJxHQmjqkSoA7w+wo0KrAGoTUuW+DSu7j3UPXw2i9s-9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration/colo.c: Fix compilation issue
 when disable replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>, Thomas Huth <thuth@redhat.com>

On Thu, Nov 1, 2018 at 12:47 AM Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> > * Zhang Chen (zhangckid@gmail.com) wrote:
> > > This compilation issue will occur when user use --disable-replication
> > > to config Qemu.
> > >
> > > Reported-by: Thomas Huth <thuth@redhat.com>
> > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >
> > Queued.
>
> Unqueued; this still isn't building for me with replication disabled;
> I'm hitting one problem where the compiler is complaining that
> colo_send_message_value is unused, and then I'm hitting a bunch of link
> time errors.
>
> This needs a few more fixes first.
>

Sorry, my test machine's gcc version(5.4.0) is too old to catch this error.
I will fix it and send the V2 patch.

Thanks
Zhang Chen


>
> Dave
>
> > > ---
> > >  migration/colo.c | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/migration/colo.c b/migration/colo.c
> > > index 956ac236b7..b81e6ec5bb 100644
> > > --- a/migration/colo.c
> > > +++ b/migration/colo.c
> > > @@ -59,6 +59,8 @@ static bool colo_runstate_is_stopped(void)
> > >
> > >  static void secondary_vm_do_failover(void)
> > >  {
> > > +/* COLO needs enable block-replication */
> > > +#ifdef CONFIG_REPLICATION
> > >      int old_state;
> > >      MigrationIncomingState *mis = migration_incoming_get_current();
> > >      Error *local_err = NULL;
> > > @@ -121,10 +123,14 @@ static void secondary_vm_do_failover(void)
> > >      if (mis->migration_incoming_co) {
> > >          qemu_coroutine_enter(mis->migration_incoming_co);
> > >      }
> > > +#else
> > > +    abort();
> > > +#endif
> > >  }
> > >
> > >  static void primary_vm_do_failover(void)
> > >  {
> > > +#ifdef CONFIG_REPLICATION
> > >      MigrationState *s = migrate_get_current();
> > >      int old_state;
> > >      Error *local_err = NULL;
> > > @@ -165,6 +171,9 @@ static void primary_vm_do_failover(void)
> > >
> > >      /* Notify COLO thread that failover work is finished */
> > >      qemu_sem_post(&s->colo_exit_sem);
> > > +#else
> > > +    abort();
> > > +#endif
> > >  }
> > >
> > >  COLOMode get_colo_mode(void)
> > > @@ -373,6 +382,7 @@ static int
> colo_do_checkpoint_transaction(MigrationState *s,
> > >                                            QIOChannelBuffer *bioc,
> > >                                            QEMUFile *fb)
> > >  {
> > > +#ifdef CONFIG_REPLICATION
> > >      Error *local_err = NULL;
> > >      int ret = -1;
> > >
> > > @@ -483,6 +493,9 @@ out:
> > >          error_report_err(local_err);
> > >      }
> > >      return ret;
> > > +#else
> > > +    abort();
> > > +#endif
> > >  }
> > >
> > >  static void colo_compare_notify_checkpoint(Notifier *notifier, void
> *data)
> > > @@ -790,13 +803,16 @@ void *colo_process_incoming_thread(void *opaque)
> > >              qemu_mutex_unlock_iothread();
> > >              goto out;
> > >          }
> > > +#ifdef CONFIG_REPLICATION
> > >          /* discard colo disk buffer */
> > >          replication_do_checkpoint_all(&local_err);
> > >          if (local_err) {
> > >              qemu_mutex_unlock_iothread();
> > >              goto out;
> > >          }
> > > -
> > > +#else
> > > +        abort();
> > > +#endif
> > >          /* Notify all filters of all NIC to do checkpoint */
> > >          colo_notify_filters_event(COLO_EVENT_CHECKPOINT, &local_err);
> > >
> > > --
> > > 2.17.GIT
> > >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
