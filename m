Received: from eggs.gnu.org ([2001:4830:134:3::10]:37396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDlKx-0001fT-PX
	for qemu-devel@nongnu.org; Wed, 02 May 2018 02:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDlKu-0005AX-P1
	for qemu-devel@nongnu.org; Wed, 02 May 2018 02:33:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38050 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDlKu-0005AD-Iz
	for qemu-devel@nongnu.org; Wed, 02 May 2018 02:33:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01CA38DC34
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 06:33:51 +0000 (UTC)
Date: Wed, 2 May 2018 14:33:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180502063335.GB32728@xz-mi>
References: <20180418090239.13090-1-peterx@redhat.com>
	<20180418090239.13090-2-peterx@redhat.com>
	<20180430095649.GC4002@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180430095649.GC4002@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] monitor: rename out_lock to mon_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Apr 30, 2018 at 10:56:49AM +0100, Stefan Hajnoczi wrote:
> On Wed, Apr 18, 2018 at 05:02:37PM +0800, Peter Xu wrote:
> > The out_lock was only protecting out buffers.  In the future the monitor
> > code will start to run in multiple threads.  We turn it into a bigger
> > lock to protect not only the out buffer but also all the rest.  We split
> > this lock until necessary.  So far I don't see a reason to complicate
> > lock usage for monitors.
> > 
> > Since at it, arrange the Monitor struct a bit.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 39 ++++++++++++++++++---------------------
> >  1 file changed, 18 insertions(+), 21 deletions(-)
> > 
> > diff --git a/monitor.c b/monitor.c
> > index 39f8ee17ba..c93aa4e22b 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -202,20 +202,17 @@ typedef struct {
> >  
> >  struct Monitor {
> >      CharBackend chr;
> > +    /* We can't access guest memory when holding the lock */
> > +    QemuMutex mon_lock;
> 
> Please document which field this lock protects.  For example, outbuf and
> out_watch need a comment.

Sure!

-- 
Peter Xu
