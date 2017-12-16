Received: from eggs.gnu.org ([2001:4830:134:3::10]:46876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ5PM-0004U7-Ag
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 00:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ5PL-0004zs-EU
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 00:53:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQ5PL-0004zR-7y
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 00:53:11 -0500
Date: Sat, 16 Dec 2017 13:52:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171216055254.GB22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-15-peterx@redhat.com>
	<20171213173533.GE8317@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171213173533.GE8317@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 14/26] monitor: introduce
 monitor_qmp_respond()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Dec 13, 2017 at 05:35:33PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 01:51:48PM +0800, Peter Xu wrote:
> > A tiny refactoring, preparing to split the QMP dispatcher away.
> > 
> > Reviewed-by: Fam Zheng <famz@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 48 +++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 31 insertions(+), 17 deletions(-)
> > 
> > diff --git a/monitor.c b/monitor.c
> > index 9666115259..35d8925636 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -3877,6 +3877,36 @@ static int monitor_can_read(void *opaque)
> >      return (mon->suspend_cnt == 0) ? 1 : 0;
> >  }
> >  
> > +/*
> > + * When rsp/err/id is passed in, the function will be responsible for
> > + * the cleanup.
> > + */
> 
> Please document this function fully.  I had to look at the
> implementation to learn how the arguments work:
> 
> 1. This function takes ownership of rsp, err, and id.  (Please use this
> exact wording because the function does not perform the "cleanup" when
> refcount > 1.)
> 2. rsp, err, and id may be NULL.
> 3. If err != NULL then rsp must be NULL.

Will steal the lines.  Thanks!

Also, I'll add an assert() to make sure (3) is true, in case any rsp
refcount is leaked when accidentally provided with err.

-- 
Peter Xu
