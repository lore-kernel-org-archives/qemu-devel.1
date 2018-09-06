Received: from eggs.gnu.org ([2001:4830:134:3::10]:41141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxl7t-00035o-W8
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 23:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxl7q-0006hp-Ls
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 23:38:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36312 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fxl7q-0006fC-EG
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 23:38:34 -0400
Date: Thu, 6 Sep 2018 11:38:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180906033825.GB16937@xz-x1>
References: <20180618140854.17824-1-armbru@redhat.com>
	<20180618140854.17824-7-armbru@redhat.com>
	<20180905150510.wn4cfhj73z7cbtvb@olga.proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180905150510.wn4cfhj73z7cbtvb@olga.proxmox.com>
Subject: Re: [Qemu-devel] [PULL 6/7] monitor: move init global earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Wed, Sep 05, 2018 at 05:05:10PM +0200, Wolfgang Bumiller wrote:
> On Mon, Jun 18, 2018 at 04:08:53PM +0200, Markus Armbruster wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > Before this patch, monitor fd helpers might be called even earlier than
> > monitor_init_globals().  This can be problematic.
> > 
> > After previous work, now monitor_init_globals() does not depend on
> > accelerator initialization any more.  Call it earlier (before CLI
> > parsing; that's where the monitor APIs might be called) to make sure it
> > is called before any of the monitor APIs.
> 
> It looks like this patch moves the creation of the 'IO mon_iothread' to
> before the call to os_daemonize().
> With qemu 3.0 I'm experiencing crashes when shutting down daemonized
> qemu instances, at pthread_join() on the 'IO mon_iothread' thread.
> 
> monitor_init_globals() calls monitor_iothread_init(), which in turn uses
> iothread_create() to create a joinable thread. Then os_daemonize() is
> called after which the thread is no longer "ours".
> Debug-writing the thread IDs at pthread_create() and pthread_join()
> together with the 'detachable' flag revealed that the mon_iothread ID is
> already being reused, in my trace for a detached thread, and the join
> then ends with a coredump and ugly log output.

Indeed.  So we have these ordering constraints:

  init mon locks [1]
  cli parsing
  daemonize
  create mon iothread [2]

I can't figure out a way unless we split the global init routine for
the monitors, possibly (and simply) by postpone creation of the
iothread.  Thoughts?

(Note that AFAICT Markus is on holiday and will be back after two weeks)

Regards,

-- 
Peter Xu
