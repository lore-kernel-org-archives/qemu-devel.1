Received: from eggs.gnu.org ([209.51.188.92]:45255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyzAr-0008BW-Re
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyzAp-00005e-Sn
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:23:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gyzAn-0008Vy-R3
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:22:58 -0500
Date: Wed, 27 Feb 2019 13:16:22 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190227131622.GH2602@work-vm>
References: <20190227121052.GD2602@work-vm>
 <877edltncj.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877edltncj.fsf@trasno.org>
Subject: Re: [Qemu-devel] possible ahci/migrate fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > Hi Alex,
> >   Can you see if the attached patch fixes the ahci/migrate failure you
> > see;  it won't fail for me however mean I am to it.
> >
> >
> 
> ....
> 
> >  void migration_object_finalize(void)
> >  {
> > +    /*
> > +     * Cancel the current migration - that will (eventually)
> > +     * stop the migration using this structure
> > +     */
> > +    migrate_fd_cancel(current_migration);
> 
> This can only happen during "civilized" exit of qemu, right?
> Otherwise, we are changing the migration status.

I'm hoping that, in an exit where:
  a) there was no migration this does nothing
  b) the migration finished already this does nothing
  c) There's a running migration then this causes a cancel.

So if (a) & (b) do nothing then this should be OK, and
if you're trying to do an exit during (c) then it's going bad anyway.

> >      object_unref(OBJECT(current_migration));
> >  }
> >  
> > @@ -3134,6 +3140,7 @@ static void *migration_thread(void *opaque)
> >  
> >      rcu_register_thread();
> >  
> > +    object_ref(OBJECT(s));
> 
> It is weird that this is not enough :-(

It maybe enough; I was being cautious to add the cancel as well -
I'm pretty sure this series doesn't cover every case, but since these
bugs are hard to reproduce I wanted to try and cover any and all easy
cases.  There was a previous attempt (by Fam) 2 years ago which stalled
because we couldn't figure out how to cover everything.

> >      s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >  
> >      qemu_savevm_state_header(s->to_dst_file);
> > @@ -3230,6 +3237,7 @@ static void *migration_thread(void *opaque)
> >  
> >      trace_migration_thread_after_loop();
> >      migration_iteration_finish(s);
> > +    object_unref(OBJECT(s));
> >      rcu_unregister_thread();
> >      return NULL;
> >  }
> > diff --git a/vl.c b/vl.c
> > index 2f340686a7..c1920165f3 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -4579,6 +4579,12 @@ int main(int argc, char **argv, char **envp)
> >  
> >      gdbserver_cleanup();
> >  
> > +    /*
> > +     * cleaning up the migration object cancels any existing migration
> > +     * try to do this early so that it also stops using devices.
> > +     */
> > +    migration_object_finalize();
> > +
> >      /* No more vcpu or device emulation activity beyond this point */
> >      vm_shutdown();
> >  
> > @@ -4594,7 +4600,6 @@ int main(int argc, char **argv, char **envp)
> >      monitor_cleanup();
> >      qemu_chr_cleanup();
> >      user_creatable_cleanup();
> > -    migration_object_finalize();
> >      /* TODO: unref root container, check all devices are ok */
> >  
> >      return 0;
> 
> Ok, it was happening really late.
> 
> Once that you are at this, can we rename it?
> 
> migration_cleanup()
> 
> looks more consistent with everything else, and makes sure that it does
> "more" than finalize the object, no?

Sure, I'll go with migration_shutdown

> Furthermore, it is enough to "just" cancel the migration?  It is not
> needed that we wait for the migration thread to finish?

I agree, but the problem is I don't want to block in the exit path - so
what are the choices?

> If the problem was that migration_thread() was accessing the object
> after main thread freed it, then just the ref counting should be enough,
> no?  My understanding is that returning from main is the quivalent of
> exit() and kill all threads?  Or are we doing something special for that
> not to happen?

The case Alex saw was gprof having an atexit handler so main hadn't
really exited yet and hadn't killed it's threads; having said that I
can't trigger this even with gprof.

Dave

> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
