Received: from eggs.gnu.org ([2001:4830:134:3::10]:35225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dqN5t-00012Z-8u
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dqN5p-0002vy-8e
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:29:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dqN5o-0002vC-Vg
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:29:25 -0400
Date: Fri, 8 Sep 2017 18:29:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170908172912.GF2836@work-vm>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-3-git-send-email-peterx@redhat.com>
	<20170823173534.GF2648@work-vm>
	<20170825042502.GD14174@pxdev.xzpeter.org>
	<20170825093042.GC2090@work-vm>
	<20170828055325.GJ14174@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828055325.GJ14174@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC v2 2/8] monitor: allow monitor to create
 thread to poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Fri, Aug 25, 2017 at 10:30:42AM +0100, Dr. David Alan Gilbert wrote:
> 
> [...]
> 
> > > >   c) As mentioned on irc there's fun to be had with cur_mon and error
> > > >      handling - in my local world I have cur_mon declared as __thread
> > > >      but never got around to thinking aobut what should set it up.
> > > >      There's also 'wavcapture: Convert to error_report' that I posted
> > > >      in March that got rid of some uses of cur_mon in wavcapture.c
> > > >      for error_report.
> > > 
> > > Yeh.  I at least also see a positive ACK from Markus in the other
> > > thread for per-thread cur_mon, sounds like this is the right way to
> > > go.
> > > 
> > > To setup cur_mon, what I can think of is create wrapper for
> > > pthread_create() in qemu_thread_create().  I see that we have done
> > > similar thing in util/qemu-thread-win32.c for Windows.  With that we
> > > can setup the cur_mon before going into real thread function but in
> > > the right context, though we may need one more parameter for current
> > > qemu_thread_create():
> > > 
> > > void qemu_thread_create(QemuThread *thread, const char *name,
> > >                        void *(*start_routine)(void*),
> > >                        void *arg, int mode, Monitor *mon);
> > > 
> > > Then we can specify monitor for any new thread (default to cur_mon).
> > > For per-monitor threads, I think we need to pass in that specific mon.
> > > 
> > > Is this doable?
> > 
> > That would mean changing all the qemu_thread_create calls, but yes
> > I guess is doable.  I'd thought the other way, perhaps you inherit
> > Monitor except in the case of when the monitor creates threads.
> 
> Do you mean setup cur_mon in monitor threads?
> 
> I'm afraid that may not be enough, since after we mark cur_mon as
> __thread variable, it should be NULL for each newly created threads,
> then we need to init them for every thread.  Or anything I missed?

Right, I thought you'd modify qemu_thread_create to setup cur_mon in
new threads to the same as the parent.

Dave

> [...]
> 
> > > > 
> > > >   d) I wonder if it's better to have thread as a flag, so that you have
> > > >      to explicitly ask for a monitor to have it's own thread.
> > > 
> > > This should be doable.  Would a new parameter for "-qmp" and "-hmp"
> > > suffice?
> > 
> > Yes.
> 
> (I meant "-monitor" when saying "-hmp")
> 
> Hmm, it seems not easy to simply add a new parameter for it, since we
> used "," already to parse the chardev params in monitor codes, like
> the usage of:
> 
>   -qmp telnet::8888,server,nowait
> 
> So I cannot simply do:
> 
>   -qmp telnet::8888,server,nowait,threaded=on
> 
> Or it will be treated for a parameter for chardev type "telnet".
> 
> I can at least add something similar to QEMU_OPTION_qmp_pretty, like:
> QEMU_OPTION_qmp_threaded, and maybe I also need
> QEMU_OPTION_monitor_pretty.  But I am thinking whether there can be
> anything better.  Any suggestion from anyone?
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
