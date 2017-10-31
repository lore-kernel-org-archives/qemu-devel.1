Received: from eggs.gnu.org ([2001:4830:134:3::10]:35730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9bjC-0006TG-EO
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 14:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9bj9-0003wm-Cv
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 14:57:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e9bj9-0003wV-40
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 14:57:31 -0400
Date: Tue, 31 Oct 2017 18:57:23 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171031185722.GE2191@work-vm>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-11-git-send-email-peterx@redhat.com>
	<20170921192903.GH3401@work-vm>
	<20170927073441.GD25011@pxdev.xzpeter.org>
	<20171009185812.GR2374@work-vm>
	<20171010093801.GC20686@pxdev.xzpeter.org>
	<20171010113154.GF20686@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010113154.GF20686@pxdev.xzpeter.org>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Tue, Oct 10, 2017 at 05:38:01PM +0800, Peter Xu wrote:
> 
> [...]
> 
> > > > But I agree about the reasoning.  How
> > > > about one more patch to postpone the "active" to "postcopy-active"
> > > > state change after the package is handled correctly?  Like:
> > > > 
> > > > --------------
> > > > diff --git a/migration/savevm.c b/migration/savevm.c                     
> > > > index b5c3214034..8317b2a7e2 100644 
> > > > --- a/migration/savevm.c            
> > > > +++ b/migration/savevm.c            
> > > > @@ -1573,8 +1573,6 @@ static void *postcopy_ram_listen_thread(void *opaque)                                                                       
> > > >      QEMUFile *f = mis->from_src_file;                                   
> > > >      int load_res;                  
> > > >                                     
> > > > -    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,             
> > > > -                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);   
> > > >      qemu_sem_post(&mis->listen_thread_sem);                             
> > > >      trace_postcopy_ram_listen_thread_start();                           
> > > >                                     
> > > > @@ -1817,6 +1815,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)                                                          
> > > >      qemu_fclose(packf);            
> > > >      object_unref(OBJECT(bioc));    
> > > >                                     
> > > > +    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,             
> > > > +                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);   
> > > > +                                   
> > > >      return ret;                    
> > > >  }                                  
> > > > --------------
> > > > 
> > > > This function will only be called with "postcopy-active" state.
> > > 
> > > I *think* that's safe; you've got to be careful, but I can't see
> > > anyone on the destination that cares about the destinction.
> > 
> > Indeed, but I'd say that's the best thing I can think of (and the
> > simplest).  Even, not sure whether it'll be more clear if we set
> > postcopy-active state right before starting the VM on destination,
> > say, at the beginning of loadvm_postcopy_handle_run_bh().
> 
> When thinking about this, I had another question.
> 
> How do we handle the case if we failed to send the device states in
> postcopy_start()?  In that, we do qemu_savevm_send_packaged() then we
> assume we are good and return with success. However
> qemu_savevm_send_packaged() only means that the data is queued in
> write buffer of source host, it does not mean that destination has
> loaded the device states correctly.  It's still possible that
> destination VM failed to receive the whole packaged data, but source
> thought it had done so without problem.
> 
> Then source will continue with postcopy-active, destination VM will
> instead fail, then fail the source. VM should be lost then since it's
> postcopy rather than precopy.
> 
> Meanwhile, this cannot be handled by postcopy recovery, since IIUC
> postcopy recovery only works after the states are at least loaded on
> destination VM (I'll avoid going deeper to think a more complex
> protocol for postcopy recovery, please see below).
> 
> I think the best/simplest thing to do when encountering this error is
> that, when this happens we just fail the migration on source and
> continue running on source, which should be the same failure handling
> path with precopy.  But still it seems that we don't have a good
> mechanism to detect the error when sending MIG_CMD_PACKAGED message
> fails in some way (we can add one ACK from dst->src, however it breaks
> old VMs).
> 
> Before going further, would my worry make any sense?

Yes, I think it does; it wouldn't be unusual for a device-load to fail
due to some problem on the destination host or a problem in device
serialisation.
I also think we should be OK to restart on the source; although we
have to be careful - can we really know what the previous devices (that
loaded succesfully) did?  Hopefully they didn't change the state of the
storage/networking because the destination CPUs haven't started.

> (I hope this can be a separate problem from postcopy recovery series,
>  if it is indeed a problem.  For postcopy recovery, I hope the idea of
>  postponing setup POSTCOPY_ACTIVE would suffice)

Sure.

Dave

> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
