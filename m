Received: from eggs.gnu.org ([2001:4830:134:3::10]:57396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eeeLh-0002SN-IY
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eeeLc-0007f8-Qc
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:01:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eeeLc-0007dS-L2
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:01:32 -0500
Date: Thu, 25 Jan 2018 10:01:13 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180125100112.GA2442@work-vm>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180125023500.GB19899@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180125023500.GB19899@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v7 00/23] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Wed, Jan 24, 2018 at 01:39:34PM +0800, Peter Xu wrote:
> > This version should have addressed all comments in previous one, also
> > fixed another race condition after I addressed all the comments (a new
> > race condition introduced by addressing the comments...).  For some
> > more details of the race condition, please see the last entry of
> > change log, and please refer to patch 9 for the code change.
> > 
> > I removed RFC tag from this version.  Please review.  Thanks.
> > 
> > v7:
> > - add some r-bs, and remove some.
> > - remove the chardev fix since already queued by Paolo
> > - use local var in qemu_chr_fe_add_watch [Stefan]
> > - move doc patch to front, mention it in some patches [Eric]
> > - Quite a few of English fixes [Eric]
> > - fix unlock missing in handle_qmp_command [Stefan]
> > - squash some patches according to the review comments
> > - don't break gdbserver usage on HMP non-interactive mode by fixing up
> >   the suspend/resume logic [Fam, Stefan]
> > - move the qemu_chr_fe_set_handlers() call in monitor_init() into a
> >   bottom half to avoid race between the call itself and
> >   iothread. [Stefan]
> > - spent quite a lot of time debugging another assertion failure in
> >   io_watch_poll_finalize() after above change is made (ouch! I really
> >   hoped we always have the latest glib): when QEMU inits chardevs in
> >   chardev_init_func() it's possible that QEMU registers the chardev
> >   handlers there, even before CharBackend is connected to that chardev
> >   in monitor_init().  Then, when we reach monitor_init() we must make
> >   sure we unregister that old one first, or there can have one orphan
> >   GSource still in default gcontext (note that this can really happen
> >   when we start to use QEMUBH to setup chardev frontends, which is
> >   above change).
> 
> Online repository updated for v7:
> 
>   https://github.com/xzpeter/qemu/tree/monitor-oob

This version seems to have fixed the problem I had where after an error
I couldn't reconnect (the one I mentioned on the 12th).

Dave

> Thanks,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
