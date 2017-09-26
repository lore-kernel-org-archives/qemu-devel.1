Received: from eggs.gnu.org ([2001:4830:134:3::10]:45528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwlSy-0008MB-Lc
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwlSv-0002Rh-9m
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:43:44 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dwlSu-0002RF-VC
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:43:41 -0400
Received: by mail-wm0-x242.google.com with SMTP id x17so8728806wmd.5
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 01:43:40 -0700 (PDT)
Date: Tue, 26 Sep 2017 09:43:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170926084337.GB16834@stefanha-x1.localdomain>
References: <20170926054439.GB25267@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926054439.GB25267@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] A glib warning encountered with internal iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Sep 26, 2017 at 01:44:39PM +0800, Peter Xu wrote:
> Hi,
> 
> Generally speaking this is a question about glib, but I would like to
> see how the list sees this before throwing this question to glib
> community in case I made severe mistake.
> 
> I encountered one glib warning when start to use internal iothread:
> 
> (qemu-system-x86_64:19925): GLib-CRITICAL **: g_source_remove_poll: assertion '!SOURCE_DESTROYED (source)' failed
> 
> This will be triggered as long as we create one private iothread and
> enables gcontext of it (by calling iothread_get_g_main_context() at
> least once on the private iothread).
> 
> The warning is generated when quitting QEMU in following path (please
> ignore unknown function names, they only appear in a private tree, but
> the logic is the same):
> 
> #0  0x00007ff0c2bb4180 in g_source_remove_poll () at /lib64/libglib-2.0.so.0
> #1  0x00005634b0fe8bc9 in aio_set_fd_handler (ctx=0x5634b365ca90, fd=22, is_external=false, io_read=0x0, io_write=0x0, io_poll=0x0, opaque=0x5634b365cb3c) at /root/git/qemu/util/aio-posix.c:226
> #2  0x00005634b0fe8ebc in aio_set_event_notifier (ctx=0x5634b365ca90, notifier=0x5634b365cb3c, is_external=false, io_read=0x0, io_poll=0x0) at /root/git/qemu/util/aio-posix.c:299
> #3  0x00005634b0fe5174 in aio_ctx_finalize (source=0x5634b365ca90) at /root/git/qemu/util/async.c:296
> #4  0x00007ff0c2bb39a6 in g_source_unref_internal () at /lib64/libglib-2.0.so.0
> #5  0x00005634b0fe5757 in aio_context_unref (ctx=0x5634b365ca90) at /root/git/qemu/util/async.c:484
> #6  0x00005634b0c39642 in iothread_instance_finalize (obj=0x5634b36cfa40) at /root/git/qemu/iothread.c:127
> #7  0x00005634b0ede36e in object_deinit (obj=0x5634b36cfa40, type=0x5634b3543c60) at /root/git/qemu/qom/object.c:453
> #8  0x00005634b0ede3e0 in object_finalize (data=0x5634b36cfa40) at /root/git/qemu/qom/object.c:467
> #9  0x00005634b0edf361 in object_unref (obj=0x5634b36cfa40) at /root/git/qemu/qom/object.c:902
> #10 0x00005634b0ee0607 in object_finalize_child_property (obj=0x5634b369d3b0, name=0x5634b36eb900 "monitor_io_thr", opaque=0x5634b36cfa40) at /root/git/qemu/qom/object.c:1407
> #11 0x00005634b0ede25d in object_property_del_child (obj=0x5634b369d3b0, child=0x5634b36cfa40, errp=0x0) at /root/git/qemu/qom/object.c:427
> #12 0x00005634b0ede33d in object_unparent (obj=0x5634b36cfa40) at /root/git/qemu/qom/object.c:446
> #13 0x00005634b0c39f44 in iothread_destroy (iothread=0x5634b36cfa40) at /root/git/qemu/iothread.c:383
> #14 0x00005634b0ae920f in monitor_io_thread_destroy () at /root/git/qemu/monitor.c:4416
> #15 0x00005634b0ae9302 in monitor_cleanup () at /root/git/qemu/monitor.c:4439
> #16 0x00005634b0c496cb in main (argc=17, argv=0x7ffcc5b88918, envp=0x7ffcc5b889a8) at /root/git/qemu/vl.c:4889
> 
> It's on the path during destruction of AioContext, where we called
> g_source_remove_poll() in the destructor.  When reach here, AioContext
> has been detached from the gcontext already, so the assertion is
> triggered.
> 
> I'll copy some code for easier reference from glib:
> 
> void
> g_source_remove_poll (GSource *source,
> 		      GPollFD *fd)
> {
>   GMainContext *context;
>   
>   g_return_if_fail (source != NULL);
>   g_return_if_fail (fd != NULL);
>   g_return_if_fail (!SOURCE_DESTROYED (source)); <---- this assertion fails
>   
>   context = source->context;
> 
>   if (context)
>     LOCK_CONTEXT (context);
>   
>   source->poll_fds = g_slist_remove (source->poll_fds, fd);
> 
>   if (context)
>     {
>       if (!SOURCE_BLOCKED (source))
> 	g_main_context_remove_poll_unlocked (context, fd);
>       UNLOCK_CONTEXT (context);
>     }
> }
> 
> I'm translating this assertion failure into: "when removing one
> GSource from the polled GSource array, the GSource should still be
> attached to its GMainContext".  But does this really matter?  Why
> can't we remove one GSource from the poll array even if the source is
> detached already?  After all if we see following code in
> g_source_remove_poll() we have already taken special care when
> source->context == NULL happens.
> 
> Any thoughts?  TIA.

It seems glib chose this cleanup order:
GPollFD < GSource < GMainLoop < GMainContext

Even if glib could be modified to allow what you want, QEMU needs to
work with old glib versions.

I suggest modifying iothread.c to implement glib's required cleanup
order in the finalize function:

aio_context_unref();  <-- the GSource
g_main_loop_unref();
g_main_context_unref();

Stefan
