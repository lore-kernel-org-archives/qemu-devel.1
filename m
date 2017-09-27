Received: from eggs.gnu.org ([2001:4830:134:3::10]:48286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dx6ru-0005Nk-01
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dx6rq-0006JD-OU
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:34:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dx6rq-0006Ii-Ew
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:34:50 -0400
Date: Wed, 27 Sep 2017 15:34:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170927073441.GD25011@pxdev.xzpeter.org>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-11-git-send-email-peterx@redhat.com>
	<20170921192903.GH3401@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170921192903.GH3401@work-vm>
Subject: Re: [Qemu-devel] [RFC v2 10/33] migration: allow dst vm pause on
 postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Sep 21, 2017 at 08:29:03PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > When there is IO error on the incoming channel (e.g., network down),
> > instead of bailing out immediately, we allow the dst vm to switch to the
> > new POSTCOPY_PAUSE state. Currently it is still simple - it waits the
> > new semaphore, until someone poke it for another attempt.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c  |  1 +
> >  migration/migration.h  |  3 +++
> >  migration/savevm.c     | 60 ++++++++++++++++++++++++++++++++++++++++++++++++--
> >  migration/trace-events |  2 ++
> >  4 files changed, 64 insertions(+), 2 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 8d26ea8..80de212 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -146,6 +146,7 @@ MigrationIncomingState *migration_incoming_get_current(void)
> >          memset(&mis_current, 0, sizeof(MigrationIncomingState));
> >          qemu_mutex_init(&mis_current.rp_mutex);
> >          qemu_event_init(&mis_current.main_thread_load_event, false);
> > +        qemu_sem_init(&mis_current.postcopy_pause_sem_dst, 0);
> >          once = true;
> >      }
> >      return &mis_current;
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 0c957c9..c423682 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -60,6 +60,9 @@ struct MigrationIncomingState {
> >      /* The coroutine we should enter (back) after failover */
> >      Coroutine *migration_incoming_co;
> >      QemuSemaphore colo_incoming_sem;
> > +
> > +    /* notify PAUSED postcopy incoming migrations to try to continue */
> > +    QemuSemaphore postcopy_pause_sem_dst;
> >  };
> >  
> >  MigrationIncomingState *migration_incoming_get_current(void);
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 7172f14..3777124 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1488,8 +1488,8 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
> >   */
> >  static void *postcopy_ram_listen_thread(void *opaque)
> >  {
> > -    QEMUFile *f = opaque;
> >      MigrationIncomingState *mis = migration_incoming_get_current();
> > +    QEMUFile *f = mis->from_src_file;
> >      int load_res;
> >  
> >      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
> > @@ -1503,6 +1503,14 @@ static void *postcopy_ram_listen_thread(void *opaque)
> >       */
> >      qemu_file_set_blocking(f, true);
> >      load_res = qemu_loadvm_state_main(f, mis);
> > +
> > +    /*
> > +     * This is tricky, but, mis->from_src_file can change after it
> > +     * returns, when postcopy recovery happened. In the future, we may
> > +     * want a wrapper for the QEMUFile handle.
> > +     */
> > +    f = mis->from_src_file;
> > +
> >      /* And non-blocking again so we don't block in any cleanup */
> >      qemu_file_set_blocking(f, false);
> >  
> > @@ -1581,7 +1589,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
> >      /* Start up the listening thread and wait for it to signal ready */
> >      qemu_sem_init(&mis->listen_thread_sem, 0);
> >      qemu_thread_create(&mis->listen_thread, "postcopy/listen",
> > -                       postcopy_ram_listen_thread, mis->from_src_file,
> > +                       postcopy_ram_listen_thread, NULL,
> >                         QEMU_THREAD_DETACHED);
> >      qemu_sem_wait(&mis->listen_thread_sem);
> >      qemu_sem_destroy(&mis->listen_thread_sem);
> > @@ -1966,11 +1974,44 @@ void qemu_loadvm_state_cleanup(void)
> >      }
> >  }
> >  
> > +/* Return true if we should continue the migration, or false. */
> > +static bool postcopy_pause_incoming(MigrationIncomingState *mis)
> > +{
> > +    trace_postcopy_pause_incoming();
> > +
> > +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > +                      MIGRATION_STATUS_POSTCOPY_PAUSED);
> > +
> > +    assert(mis->from_src_file);
> > +    qemu_file_shutdown(mis->from_src_file);
> > +    qemu_fclose(mis->from_src_file);
> > +    mis->from_src_file = NULL;
> > +
> > +    assert(mis->to_src_file);
> > +    qemu_mutex_lock(&mis->rp_mutex);
> > +    qemu_file_shutdown(mis->to_src_file);
> 
> Should you not do the shutdown() before the lock?
> For example if the other thread is stuck, with rp_mutex
> held, trying to write to to_src_file, then you'll block
> waiting for the mutex.  If you call shutdown and then take
> the lock, the other thread will error and release the lock.

The problem is that IMHO QEMUFile is not yet thread-safe itself.  So
if we operate on it (even to shut it down) logically we need to have
the lock, right?

Then, IMHO the question would be: when will the send() be stuck in the
other thread?

Normally the only case I can think of is that source didn't recv()
fast enough, and we even consumed all the write buffer in dst side (I
don't really know how kernel manages the buffers though, and e.g. how
the size of buffer is defined...).

But when reach here, the channel (say, from_src_file and to_src_file,
since both of them are using the same channel behind the QEMUFile
interface) should already be broken in some way, then IIUC even there
is a send() in the other thread, it should return at some point with a
failure as well, just like how we reached here (possibly due to a
read() failure).

> 
> I'm not quite sure what will happen if we end up calling this
> before the main thread has been returned from postcopy and the
> device loading is complete.

IIUC you mean the time starts from when we got MIG_CMD_PACKAGED until
main thread finishes handling that package?

Normally I think that should not matter much since during handling the
package it should hardly fail (we were reading from a buffer QIO
channel, no real IOs there)...  But I agree about the reasoning.  How
about one more patch to postpone the "active" to "postcopy-active"
state change after the package is handled correctly?  Like:

--------------
diff --git a/migration/savevm.c b/migration/savevm.c                     
index b5c3214034..8317b2a7e2 100644 
--- a/migration/savevm.c            
+++ b/migration/savevm.c            
@@ -1573,8 +1573,6 @@ static void *postcopy_ram_listen_thread(void *opaque)                                                                       
     QEMUFile *f = mis->from_src_file;                                   
     int load_res;                  
                                    
-    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,             
-                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);   
     qemu_sem_post(&mis->listen_thread_sem);                             
     trace_postcopy_ram_listen_thread_start();                           
                                    
@@ -1817,6 +1815,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)                                                          
     qemu_fclose(packf);            
     object_unref(OBJECT(bioc));    
                                    
+    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,             
+                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);   
+                                   
     return ret;                    
 }                                  
--------------

This function will only be called with "postcopy-active" state.

> 
> Also, at this point have we guaranteed no one else is about
> to do an op on mis->to_src_file and will seg?

I think no?  Since IMHO the main thread is playing with the buffer QIO
channel, rather than the real one?

(btw, could I ask what's "seg"? :)

-- 
Peter Xu
