Received: from eggs.gnu.org ([2001:4830:134:3::10]:39175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dusR6-00070b-DA
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 23:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dusR1-0005DF-EJ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 23:46:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dusR1-0005Cm-56
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 23:45:55 -0400
Date: Thu, 21 Sep 2017 11:45:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170921034545.GC30661@pxdev.xzpeter.org>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-2-git-send-email-peterx@redhat.com>
	<20170920075703.GA4053@redhat.com>
	<20170920090926.GA31306@pxdev.xzpeter.org>
	<20170920091438.GB4053@redhat.com>
	<20170920104958.GA30661@pxdev.xzpeter.org>
	<20170920110309.GF4053@redhat.com>
	<20170920111849.GB30661@pxdev.xzpeter.org>
	<20170920112921.GG4053@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170920112921.GG4053@redhat.com>
Subject: Re: [Qemu-devel] [RFC 01/15] char-io: fix possible race on
 IOWatchPoll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Sep 20, 2017 at 12:29:21PM +0100, Daniel P. Berrange wrote:
> On Wed, Sep 20, 2017 at 07:18:49PM +0800, Peter Xu wrote:
> > On Wed, Sep 20, 2017 at 12:03:09PM +0100, Daniel P. Berrange wrote:
> > > On Wed, Sep 20, 2017 at 06:49:58PM +0800, Peter Xu wrote:
> > > > On Wed, Sep 20, 2017 at 10:14:38AM +0100, Daniel P. Berrange wrote:
> > > > > On Wed, Sep 20, 2017 at 05:09:26PM +0800, Peter Xu wrote:
> > > > > > On Wed, Sep 20, 2017 at 08:57:03AM +0100, Daniel P. Berrange wrote:
> > > > > > > On Thu, Sep 14, 2017 at 03:50:22PM +0800, Peter Xu wrote:
> > > > > > > > This is not a problem if we are only having one single loop thread like
> > > > > > > > before.  However, after per-monitor thread is introduced, this is not
> > > > > > > > true any more, and the race can happen.
> > > > > > > > 
> > > > > > > > The race can be triggered with "make check -j8" sometimes:
> > > > > > > > 
> > > > > > > >   qemu-system-x86_64: /root/git/qemu/chardev/char-io.c:91:
> > > > > > > >   io_watch_poll_finalize: Assertion `iwp->src == NULL' failed.
> > > > > > > > 
> > > > > > > > This patch keeps the reference for the watch object when creating in
> > > > > > > > io_add_watch_poll(), so that the object will never be released in the
> > > > > > > > context main loop, especially when the context loop is running in
> > > > > > > > another standalone thread.  Meanwhile, when we want to remove the watch
> > > > > > > > object, we always first detach the watch object from its owner context,
> > > > > > > > then we continue with the cleanup.
> > > > > > > > 
> > > > > > > > Without this patch, calling io_remove_watch_poll() in main loop thread
> > > > > > > > is not thread-safe, since the other per-monitor thread may be modifying
> > > > > > > > the watch object at the same time.
> > > > > > > 
> > > > > > > This doesn't feel right to me. Why is the main loop thread doing anything
> > > > > > > at all with the Chardev, if there is a per-monitor thread ? The Chardev
> > > > > > > code isn't thread safe so it isn't safe to have two separate threads
> > > > > > > accessing the same Chardev. IOW, if we want a per-monitor thread, then
> > > > > > > we must make sure the main thread never touches that monitor's chardev
> > > > > > > at all.  While your patch here might have avoided the assertion you
> > > > > > > mention above, I fear this is just papering over a fundamental problem
> > > > > > > that still exists, that can only be solved by not letting the mainloop
> > > > > > > touch the chardev at all.
> > > > > > 
> > > > > > The stack I encountered:
> > > > > > 
> > > > > > #0  0x00007f658234c765 in __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:54
> > > > > > #1  0x00007f658234e36a in __GI_abort () at abort.c:89
> > > > > > #2  0x00007f6582344f97 in __assert_fail_base (fmt=<optimized out>, assertion=assertion@entry=0x55c76345fce1 "iwp->src == NULL", file=file@entry=0x55c76345fcc0 "/root/git/qemu/chardev/char-io.c", line=line@entry=91, function=function@entry=0x55c76345fd10 <__PRETTY_FUNCTION__.21863> "io_watch_poll_finalize") at assert.c:92
> > > > > > #3  0x00007f6582345042 in __GI___assert_fail (assertion=0x55c76345fce1 "iwp->src == NULL", file=0x55c76345fcc0 "/root/git/qemu/chardev/char-io.c", line=91, function=0x55c76345fd10 <__PRETTY_FUNCTION__.21863> "io_watch_poll_finalize") at assert.c:101
> > > > > > #4  0x000055c7632c2be5 in io_watch_poll_finalize (source=0x55c7651cd450) at /root/git/qemu/chardev/char-io.c:91
> > > > > > #5  0x00007f65847bb859 in g_source_unref_internal () at /lib64/libglib-2.0.so.0
> > > > > > #6  0x00007f65847bca29 in g_source_destroy_internal () at /lib64/libglib-2.0.so.0
> > > > > > #7  0x000055c7632c2d30 in io_remove_watch_poll (source=0x55c7651cd450) at /root/git/qemu/chardev/char-io.c:139
> > > > > > #8  0x000055c7632c2d5c in remove_fd_in_watch (chr=0x55c7651ccdf0) at /root/git/qemu/chardev/char-io.c:145
> > > > > > #9  0x000055c7632c2368 in qemu_chr_fe_set_handlers (b=0x55c7651f6410, fd_can_read=0x0, fd_read=0x0, fd_event=0x0, be_change=0x0, opaque=0x0, context=0x0, set_open=true)
> > > > > >     at /root/git/qemu/chardev/char-fe.c:267
> > > > > > #10 0x000055c7632c2221 in qemu_chr_fe_deinit (b=0x55c7651f6410, del=false) at /root/git/qemu/chardev/char-fe.c:231
> > > > > > #11 0x000055c762e2b15c in monitor_data_destroy (mon=0x55c7651f6410) at /root/git/qemu/monitor.c:600
> > > > > > #12 0x000055c762e340ec in monitor_cleanup () at /root/git/qemu/monitor.c:4346
> > > > > > #13 0x000055c762f9445d in main (argc=19, argv=0x7ffc6846d0e8, envp=0x7ffc6846d188) at /root/git/qemu/vl.c:4889
> > > > > > 
> > > > > > So it's destroying the CharBackend, but it'll then call
> > > > > > qemu_chr_fe_set_handlers() which finally tries to remove the watch poll.
> > > > > 
> > > > > Ok that code is broken - it must not call monitor_cleanup from the main
> > > > > thread - it needs to be called from the monitor thread, unless it can
> > > > > guarantee that the monitor thread has already exited, which seems unlikely
> > > > 
> > > > The problem is that not all monitors are parsed in the IO thread, but
> > > > only those with use_io_thr=true set.
> > > > 
> > > > How about I move the calls of monitor_data_destroy() into that monitor
> > > > IO thread when use_io_thr=true?  And for the rest, I think they still
> > > > need to be destroyed in the main thread.
> > > 
> > > I think having the monitor sometimes run in the main thread and sometimes
> > > run in a background thread is a recipe for ongoing trouble, of which this
> > > problem is just the first example that will hurt us. People will test
> > > behaviour of a feature with one setup and then users will later run it in
> > > a different setup and potentially experiance obscure bugs as a result.
> > > IOW, use_io_thr flag should not exist, and every monitor should be run
> > > unconditionally in the background thread from the point at which your
> > > patch series merges.
> > 
> > I agree with you that this may bring trouble in some aspect.  I just
> > don't know whether it'll bring more trouble if we move all the
> > monitor-related chardev IO into monitor thread.
> > 
> > The key is the muxed typed chardev.
> > 
> > If we don't have muxed typed chardev, I'll surely consider to use IO
> > thread for all the monitors.
> > 
> > However, the muxed chardevs can support e.g. one monitor plus a serial
> > port. Can we just run the IO stuff in monitor thread even part of its
> > frontend is a serial port?  And also I'm not sure what would happen if
> > it's a monitor plus something else I even don't aware of.
> 
> Urgh, I forgot about the horrible mux chardev concept, that does rather
> complicate life - moving the guest device interaction to the monitor
> thread would be dubious.
> 
> So yeah, given that, it probably is simplest to change monitor_cleanup
> to skip destroy of monitors which have a background thread.

Thanks.  I'll add one more patch to split the cleanups to make sure
they are done in their own thread.

If you won't disagree, I would still prefer to keep this patch -
firstly, it never hurts; secondly, in case one day we would like to
make the whole chardev thread-safe, then we won't need to dig that
hole again.

-- 
Peter Xu
