Received: from eggs.gnu.org ([2001:4830:134:3::10]:33742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dtqyk-0007Lm-0h
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dtqyg-0007IX-Vb
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:00:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dtqyg-0007IM-Pv
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:00:26 -0400
Date: Mon, 18 Sep 2017 16:00:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170918080014.GC3617@pxdev.xzpeter.org>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-16-git-send-email-peterx@redhat.com>
	<20170915160927.GT2170@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170915160927.GT2170@work-vm>
Subject: Re: [Qemu-devel] [RFC 15/15] qmp: let migrate-incoming allow
 out-of-band
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Sep 15, 2017 at 05:09:28PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > So it can get rid of being run on main thread.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  qapi/migration.json | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index ee2b3b8..dedc4f8 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -986,7 +986,8 @@
> >  # <- { "return": {} }
> >  #
> >  ##
> > -{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
> > +{ 'command': 'migrate-incoming', 'data': {'uri': 'str' },
> > +  'allow-oob': true }
> 
> Are you completely convinced migrate-incoming is non-blocking?
> What about during the tls handshake if tls is enabled?
> (We only set non-blocking on the fd later)

IIUC after socket_start_incoming_migration() we are done in
qmp_migrate_incoming(), then all the rest of the socket work will all
be done in main thread.

Note: g_source_attach() along the way in the whole
qmp_migrate_incoming() should be using NULL as the second parameter,
which means they'll attach the objects all to the default gcontext,
which targets to the main thread.

> 
> I don't understand in this structure on which thread
> process_incoming_migration_co gets run.

IIUC it should be the main thread as well.

Thanks,

-- 
Peter Xu
