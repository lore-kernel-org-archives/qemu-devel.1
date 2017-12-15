Received: from eggs.gnu.org ([2001:4830:134:3::10]:58466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ePkxW-0006IH-Oj
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ePkxR-0008Pe-5p
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:03:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ePkxQ-0008P7-W0
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:03:01 -0500
Date: Fri, 15 Dec 2017 16:02:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171215080243.GM7780@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-7-peterx@redhat.com>
	<20171213154149.GG7173@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171213154149.GG7173@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 06/26] monitor: move the cur_mon hack
 deeper for QMP
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

On Wed, Dec 13, 2017 at 03:41:49PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 01:51:40PM +0800, Peter Xu wrote:
> > In monitor_qmp_read(), we have the hack to temporarily replace the
> > cur_mon pointer.  Now we move this hack deeper inside the QMP dispatcher
> > routine since the Monitor pointer can be passed in to that using the new
> > JSON Parser opaque field now.
> > 
> > This does not make much sense as a single patch.  However, this will be
> > a big step for the next patch, when the QMP dispatcher routine will be
> > split from the QMP parser.
> > 
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Reviewed-by: Fam Zheng <famz@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/monitor.c b/monitor.c
> > index ab80d32c70..322dfb5f31 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -3813,7 +3813,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
> >  {
> >      QObject *req, *rsp = NULL, *id = NULL;
> >      QDict *qdict = NULL;
> > -    Monitor *mon = cur_mon;
> > +    Monitor *mon = opaque, *old_mon;
> 
> Or without the new opaque argument:
> 
> MonitorQMP *mon_qmp = container_of(parser, MonitorQMP, parser);
> Monitor *mon = container_of(mon_qmp, Monitor, qmp);

Please see previous reply.  Please just let me know if you insist on
keeping method #1 then I can drop the other one and rewrite this
patch.  Thanks,

-- 
Peter Xu
