Received: from eggs.gnu.org ([209.51.188.92]:46819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gzKNT-0004ex-Nb
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gzKNJ-0002ZA-VC
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:01:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gzKNJ-0002YW-KY
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:01:17 -0500
Date: Thu, 28 Feb 2019 12:01:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190228120103.GD9217@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190227164900.16378-1-dgilbert@redhat.com>
	<20190228062803.GA7471@xz-x1> <20190228114019.GB4970@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190228114019.GB4970@work-vm>
Subject: Re: [Qemu-devel] [PATCH] migration: Cleanup during exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, alex.bennee@linaro.org, qemu-devel@nongnu.org, quintela@redhat.com

On Thu, Feb 28, 2019 at 11:40:19AM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Wed, Feb 27, 2019 at 04:49:00PM +0000, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > Currently we cleanup the migration object as we exit main after the
> > > main_loop finishes; however if there's a migration running things
> > > get messy and we can end up with the migration thread still trying
> > > to access freed structures.
> > > 
> > > We now take a ref to the object around the migration thread itself,
> > > so the act of dropping the ref during exit doesn't cause us to lose
> > > the state until the thread quits.
> > > 
> > > Cancelling the migration during migration also tries to get the thread
> > > to quit.
> > > 
> > > We do this a bit earlier; so hopefully migration gets out of the way
> > > before all the devices etc are freed.
> > 
> > So does it mean that even with the patch it's still possible the
> > migration thread will be accessing device structs that have already
> > been freed which can still crash QEMU?
> 
> Possibly yes; I'm not sure how to go to the next stage and stop that
> case; the consensus seems to be we don't want to explicitly block
> during the exit process, so doing a join on the migration thread doesn't
> seem to be wanted.

Essentially the many  *_cleanup() calls at the end of main() in vl.c
are only ever safe if all background threads have stopped using the
resources that are being freed. This isn't the case with migration
currently. I also worry about other threads that might be running
in QEMU, SPICE in particular as it touchs many device backends.

Aborting the migration & joining the migration threads is the natural
way to address this. Cancelling appears to require the main loop to
still be running, so would require main_loop_should_exit() to issue
the cancel & return false unless it has completed. This would delay
shutdown for as long as it takes migration to abort.

FWIW, even the bdrv_close_all() call during shutdown can delay things
for a considerable time if draining the backends isn't a quick op,
which could be the case if there are storage problems (blocked local
I/O, or interrupted network - rbd/ceph/nfs clients). So I'm not sure
that stopping migration is inherantly worse than what's already
possible with block cleanup, in terms of delaying things.

A slightly more hacky approach would be to pthread_cancel() all the
migration threads. Normally we'd never use pthread_cancel() as it
is incredibly hard to ensure all memory used by the threads is
freed. Since we're about to exit the process though, this cleanup
does not matter. The risk, however, is that one of the threads is
holding a mutex which then blocks the rest of the *cleanup functions,
so this still feels dangerous.

Overall to me a clean cancel & join of the migration threads feels
like the only safe option, unless we just remove all notion of
cleanup from QEMU & delete all the _cleanup functions in main()
and let the OS free all memory.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
