Received: from eggs.gnu.org ([2001:4830:134:3::10]:44673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWeop-0001WW-0Z
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWeok-0007H2-6l
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:54:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWeok-0007Gf-0v
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:54:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C56637EA9A
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 08:54:32 +0000 (UTC)
Date: Wed, 3 Jan 2018 16:54:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180103085421.GC2557@xz-mi>
References: <20171228072945.9573-1-peterx@redhat.com>
	<cd7d1d86-331f-1a0e-2a39-bee1d536157b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd7d1d86-331f-1a0e-2a39-bee1d536157b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] chardev: convert leftover glib APIs to
 use dedicate gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Wed, Jan 03, 2018 at 08:10:58AM +0100, Paolo Bonzini wrote:
> On 28/12/2017 08:29, Peter Xu wrote:
> > There were existing work that tried to allow chardev to be run in a
> > dedicated gcontext rather than the default main context/thread.
> > Basically that work passed in the correct gcontext during
> > g_source_attach().  However, I found something missing along the way,
> > that some legacy glib APIs are used by chardev code which take the
> > main context as default:
> > 
> >    g_timeout_add_seconds
> >    g_timeout_add
> >    g_idle_add
> > 
> > To fully allow the chardevs to be run in dedicated gcontext, we need
> > to convert all these legacy APIs into g_source_attach() calls as well,
> > with the correct gcontext passed in.
> > 
> > This series tries to clean the rest of things up.
> > 
> > I picked up patch 1 from monitor-oob series into this series (which is
> > a missing of chardev frontend call fix for g_source_attach()), so that
> > this series can be a complete fix.
> > 
> > Please review.  Thanks,
> > 
> > Peter Xu (3):
> >   chardev: use backend chr context when watch for fe
> >   chardev: let g_idle_add() be with chardev gcontext
> >   chardev: introduce qemu_chr_timeout_add() and use
> > 
> >  chardev/char-fe.c      |  2 +-
> >  chardev/char-pty.c     | 16 ++++++++--------
> >  chardev/char-socket.c  |  4 ++--
> >  chardev/char.c         | 20 ++++++++++++++++++++
> >  hw/char/terminal3270.c |  7 ++++---
> >  include/chardev/char.h |  2 ++
> >  6 files changed, 37 insertions(+), 14 deletions(-)
> > 
> 
> All queued, thanks!

Paolo,

Would you like to queue V2 of the series which fixed the issue that
Marc-Andre has pointed out (Note that there is a v2.1 for patch 3).

Thanks anyways!

-- 
Peter Xu
