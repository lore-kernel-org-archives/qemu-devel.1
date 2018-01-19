Received: from eggs.gnu.org ([2001:4830:134:3::10]:56387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ecU75-0000lz-7a
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ecU73-0004yv-HV
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:41:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ecU73-0004xz-8p
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:41:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 71CC8780E9
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 10:41:32 +0000 (UTC)
Date: Fri, 19 Jan 2018 10:41:26 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180119104125.GB2430@work-vm>
References: <20180116180408.11279-1-dgilbert@redhat.com>
	<20180118213321-mutt-send-email-mst@kernel.org>
	<20180118195934.GD2660@work-vm>
	<20180118221212-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118221212-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v6 0/7] Rework vhost memory region updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, maxime.coquelin@redhat.com

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Thu, Jan 18, 2018 at 07:59:35PM +0000, Dr. David Alan Gilbert wrote:
> > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > On Tue, Jan 16, 2018 at 06:04:01PM +0000, Dr. David Alan Gilbert (git) wrote:
> > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > 
> > > > Hi,
> > > >   This patch set reworks the way the vhost code handles changes in
> > > > physical address space layout that came from a discussion with Igor.
> > > > 
> > > > Its intention is to simplify a lot of the update code,
> > > > and to make it easier for the postcopy+shared code to
> > > > do the hugepage alignments that are needed.
> > > > 
> > > > Instead of inserting/removing each section during the add/del
> > > > callbacks of the listener, we start afresh and build a list
> > > > from the add and nop callbacks, then at the end compare the list
> > > > we've built with the exisiting list.
> > > > 
> > > > v6
> > > >   Tidy ups from Igor
> > > >   The biggest change is moving the 'Move log_dirty check' to be
> > > >   the last patch in the set.
> > > > 
> > > > Dr. David Alan Gilbert (7):
> > > >   vhost: Build temporary section list and deref after commit
> > > >   vhost: Simplify ring verification checks
> > > >   vhost: Merge sections added to temporary list
> > > >   vhost: Regenerate region list from changed sections list
> > > >   vhost: Clean out old vhost_set_memory and friends
> > > >   vhost: Merge and delete unused callbacks
> > > >   vhost: Move log_dirty check
> > > > 
> > > >  hw/virtio/trace-events    |   6 +
> > > >  hw/virtio/vhost.c         | 497 ++++++++++++++++------------------------------
> > > >  include/hw/virtio/vhost.h |   5 +-
> > > >  3 files changed, 180 insertions(+), 328 deletions(-)
> > > 
> > > 
> > > Seems to trigger errors with clang runtime sanitizer:
> > > 
> > > /scm/qemu/hw/virtio/vhost.c:425:26: runtime error: null pointer passed as argument 1, which is declared to never be null
> > > /usr/include/string.h:64:33: note: nonnull attribute specified here
> > > /scm/qemu/hw/virtio/vhost.c:425:45: runtime error: null pointer passed as argument 2, which is declared to never be null
> > > /usr/include/string.h:64:33: note: nonnull attribute specified here
> > > /scm/qemu/hw/virtio/vhost.c:425:26: runtime error: null pointer passed as argument 1, which is declared to never be null
> > > /usr/include/string.h:64:33: note: nonnull attribute specified here
> > > /scm/qemu/hw/virtio/vhost.c:425:45: runtime error: null pointer passed as argument 2, which is declared to never be null
> > > /usr/include/string.h:64:33: note: nonnull attribute specified here
> > > /scm/qemu/hw/virtio/vhost.c:425:26: runtime error: null pointer passed as argument 1, which is declared to never be null
> > > /usr/include/string.h:64:33: note: nonnull attribute specified here
> > > /scm/qemu/hw/virtio/vhost.c:425:45: runtime error: null pointer passed as argument 2, which is declared to never be null
> > > /usr/include/string.h:64:33: note: nonnull attribute specified here
> > > /scm/qemu/hw/virtio/vhost.c:425:26: runtime error: null pointer passed as argument 1, which is declared to never be null
> > > /usr/include/string.h:64:33: note: nonnull attribute specified here
> > > /scm/qemu/hw/virtio/vhost.c:425:45: runtime error: null pointer passed as argument 2, which is declared to never be null
> > > /usr/include/string.h:64:33: note: nonnull attribute specified here
> > 
> > 
> > How are you running that test?
> 
> One Fedora:
> dnf install clang
> 
> '/scm/qemu-clang/../qemu/configure' '--cc=clang' '--cxx=clang++' '--extra-cflags=-fsanitize=undefined -ferror-limit=10000 -fno-sanitize=shift-base'
> make
> make check.

Thanks.

> > Can you add this printf and tell me what
> > it's seeing?
> > 
> >         /* Same size, lets check the contents */
> >         fprintf(stderr, "%s: %p %p %d\n", __func__, dev->mem_sections, old_sections, n_old_sections);
> >         changed = memcmp(dev->mem_sections, old_sections,
> >                          n_old_sections * sizeof(old_sections[0])) != 0;
> > 
> > I'm seeing a bunch of calls where both pointers are NULL, but
> > n_old_sections is 0, which feels legal to me.
> 
> https://stackoverflow.com/questions/16362925/can-i-pass-a-null-pointer-to-memcmp
> 
> says it's invalid.

Posted v7 with trivial fix for it.
(It seems rather ungenerous of the standard to be fussy about that).

Dave

> > I guess we could make it:
> >    changed = n_old_sections ? memcmp(....) : false;
> > just to shut clang up.
> > 
> > Dave
> > 
> > > 
> > > 
> > > > -- 
> > > > 2.14.3
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
