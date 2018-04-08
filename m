Received: from eggs.gnu.org ([2001:4830:134:3::10]:52180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f53Rk-0000X0-Bn
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 02:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f53Rg-0007Ll-Cd
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 02:05:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37970 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f53Rg-0007Lf-6c
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 02:04:56 -0400
Date: Sun, 8 Apr 2018 14:04:40 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180408060440.GI10540@xz-mi>
References: <20180404065346.3252-1-peterx@redhat.com>
	<20180404145305.GV4467@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180404145305.GV4467@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-2.12] iothread: workaround glib bug
 which hangs qmp-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Apr 04, 2018 at 03:53:05PM +0100, Stefan Hajnoczi wrote:
> On Wed, Apr 04, 2018 at 02:53:46PM +0800, Peter Xu wrote:
> > Free the AIO context earlier than the GMainContext (if we have) to
> > workaround a possible Glib bug.  No functional change at all.
> > 
> > We encountered a qmp-test hang with oob:
> > 
> >   #0  0x00007f35ffe45334 in __lll_lock_wait () from /lib64/libpthread.so.0
> >   #1  0x00007f35ffe405d8 in _L_lock_854 () from /lib64/libpthread.so.0
> >   #2  0x00007f35ffe404a7 in pthread_mutex_lock () from /lib64/libpthread.so.0
> >   #3  0x00007f35fc5b9c9d in g_source_unref_internal (source=0x24f0600, context=0x7f35f0000960, have_lock=0) at gmain.c:1685
> >   #4  0x0000000000aa6672 in aio_context_unref (ctx=0x24f0600) at /root/qemu/util/async.c:497
> >   #5  0x000000000065851c in iothread_instance_finalize (obj=0x24f0380) at /root/qemu/iothread.c:129
> >   #6  0x0000000000962d79 in object_deinit (obj=0x24f0380, type=0x242e960) at /root/qemu/qom/object.c:462
> >   #7  0x0000000000962e0d in object_finalize (data=0x24f0380) at /root/qemu/qom/object.c:476
> >   #8  0x0000000000964146 in object_unref (obj=0x24f0380) at /root/qemu/qom/object.c:924
> >   #9  0x0000000000965880 in object_finalize_child_property (obj=0x24ec640, name=0x24efca0 "mon_iothread", opaque=0x24f0380) at /root/qemu/qom/object.c:1436
> >   #10 0x0000000000962c33 in object_property_del_child (obj=0x24ec640, child=0x24f0380, errp=0x0) at /root/qemu/qom/object.c:436
> >   #11 0x0000000000962d26 in object_unparent (obj=0x24f0380) at /root/qemu/qom/object.c:455
> >   #12 0x0000000000658f00 in iothread_destroy (iothread=0x24f0380) at /root/qemu/iothread.c:365
> >   #13 0x00000000004c67a8 in monitor_cleanup () at /root/qemu/monitor.c:4663
> >   #14 0x0000000000669e27 in main (argc=16, argv=0x7ffc8b1ae2f8, envp=0x7ffc8b1ae380) at /root/qemu/vl.c:4749
> > 
> > With glib version 2.28.8-9 (current default version on centos6) we might
> > encounter above with the old code. It is verified that glib version
> > 2.50.3-3 won't trigger that bug again, but since we are still supporting
> > glib 2.28.8-9, we may want this workaround.
> 
> This patch does not contain enough information to explain what this
> "possible Glib bug" is.  Please provide information on the root cause.
> 
> Without understanding the problem, it's hard for anyone to review this
> patch and for other developers to avoid regressions in the future.

I suspect this can be the fix of the problem (commit ID of glib
repository, https://github.com/GNOME/glib):

    commit 26056558be4656ee6e891a4fae5d4198de7519cf
    Author: Dan Winship <danw@gnome.org>
    Date:   Mon Jul 30 08:06:57 2012 -0400

    gmain: allow g_source_get_context() on destroyed sources

The thing is that before this commit glib won't zero the
source->context fields of bound gsources when a context is
unreferenced, and after this patch it did.  Here I suspect the old
glib will try to take a lock of context which has already freed, hence
hanged death.

The commit is included in glib 2.33.10 or later, which seems
reasonable (the bad version I tried was 2.28.8, and I also verified
one of the good versions is 2.50.3, and 2.33.10 lies in them). I
didn't further verify the commit and rebuild glib/qemu, hopefully this
can be a valid explanation already.

If this is correct, then the rule of thumb would be: let's destroy all
the gsources that bound to the context before destroying the context
itself, until we drop support for glib 2.33.10.

I understand your worry about not having everything clear in the
commit message. Indeed we'd better know why the bug happened and then
we can avoid that and even use that information when we want to
increase the minimum version of glib we support.  However IMHO that's
something extra, it's not a reason to not merge the patch, it's not
the reason to refuse to fix QEMU which can at least let patchew run
nicely with QEMU 2.12 on centos6.

After all, the thing unclear is out of QEMU, we can't force every QEMU
developer to be fluent with internals of every library that QEMU uses
(glib is only one of them)...  And it may take a lot of time to dig
the real thing out for a QEMU developer.  So, if the patch can well
explain itself (IMHO this patch does - it only switches which object
to destroy first, nothing else is changed) and the patch is tested,
and can prove that it fixes something wrong has happened beneath QEMU,
then IMHO we should merge it.

So I would still like that we merge this patch for 2.12 (we can for
sure enhance the commit message a bit, though). In all cases, thanks
for your review.

-- 
Peter Xu
