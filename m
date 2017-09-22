Received: from eggs.gnu.org ([2001:4830:134:3::10]:44843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dvPN4-0005lX-07
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dvPN0-0001x7-Q3
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:56:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dvPN0-0001wi-Fs
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:55:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B307C0578F5
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 14:55:57 +0000 (UTC)
Date: Fri, 22 Sep 2017 15:55:40 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170922145540.GQ12725@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1506070572-7549-1-git-send-email-peterx@redhat.com>
	<1506070572-7549-2-git-send-email-peterx@redhat.com>
	<20170922101652.GF9243@stefanha-x1.localdomain>
	<4bf59c2a-8b21-0613-5575-3dfee2762633@redhat.com>
	<20170922102049.GK12725@redhat.com>
	<e993362e-3f72-add0-bb5e-1e74830dc396@redhat.com>
	<20170922102808.GL12725@redhat.com>
	<20170922143505.GB13709@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170922143505.GB13709@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 1/3] iothread: provide helpers for internal
 use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On Fri, Sep 22, 2017 at 03:35:05PM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 22, 2017 at 11:28:08AM +0100, Daniel P. Berrange wrote:
> > On Fri, Sep 22, 2017 at 12:26:16PM +0200, Paolo Bonzini wrote:
> > > On 22/09/2017 12:20, Daniel P. Berrange wrote:
> > > > On Fri, Sep 22, 2017 at 12:18:44PM +0200, Paolo Bonzini wrote:
> > > >> On 22/09/2017 12:16, Stefan Hajnoczi wrote:
> > > >>> I suggest adding internal IOThreads alongside user-created IOThreads
> > > >>> instead of hiding them.  IOThread also needs a bool user_created field
> > > >>> and a UserCreatableClass->can_be_deleted() function:
> > > >>>
> > > >>>   static bool iothread_can_be_deleted(UserCreatable *uc)
> > > >>>   {
> > > >>>       return IOTHREAD(uc)->user_created;
> > > >>>   }
> > > >>>
> > > >>> This way users cannot delete internal IOThreads.
> > > >>>
> > > >>> But how should object ids be handled?  In theory existing -object
> > > >>> iothread,id=<id> users could use any name.  How can QEMU generate ids
> > > >>> for internal IOThreads without conflicting with existing users's ids?
> > > >>
> > > >> I would add an 'internal' boolean to query-iothreads' response and a new
> > > >> 'show-internal' boolean to the command.  This way, applications that
> > > >> request internal iothreads would know that the "primary key" is
> > > >> (internal, id) rather than just the id.
> > > > 
> > > > What is the app going to do with iothreads if it sees "internal" flag
> > > > set ? They have no way of knowing what part of QEMU internally is using
> > > > this iothread, so I don't see that they can do anything intelligent
> > > > once they find out they exist.
> > > 
> > > The application could apply them default settings for scheduler policy
> > > or CPU affinity.
> > > 
> > > Unlike the main or the I/O thread, the monitor thread doesn't interrupt
> > > the CPU, so it need not run at SCHED_FIFO even in real-time settings.
> > 
> > There's no way for the application to know that. ALl it sees is that there
> > is an extra unexpected IOthread created internally by QEMU. There's no way
> > to decide whether it nedes SCHED_FIFO or not as we've no clue what it is
> > being used for.
> 
> For observability (troubleshooting, debugging, etc) I would like all
> IOThreads to be visible.  That makes it much easier to troubleshoot in a
> unified way rather than having to get at internal IOThreads through
> different means (e.g. gdb).
> 
> If QEMU uses a well-known ID for the internal monitor IOThread then
> libvirt could also interact with it (e.g. CPU affinity).

I don't think we should abuse ID values by turning them into stable
ABI - currently they are opaque tokens whose value has no special
meaning and make change at will over time.

If we need to be able to report the IOthread for the monitor, then it
would have to be done via a formal API, but that turns the use of
IOThreads for the monitor into a feature we have to keep indefinitely,
even if we wanted to re-implement it differently later.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
