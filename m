Received: from eggs.gnu.org ([2001:4830:134:3::10]:57116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ercnB-0008FP-Ea
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 23:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ercn8-0008To-Dl
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 23:59:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38762 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ercn8-0008TZ-97
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 23:59:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DB1B4040859
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 04:59:23 +0000 (UTC)
Date: Fri, 2 Mar 2018 12:59:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180302045912.GC27381@xz-mi>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-7-peterx@redhat.com>
	<9d61e6c0-8439-23d6-761b-ef3d993e9ac0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d61e6c0-8439-23d6-761b-ef3d993e9ac0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/15] qio: store gsources for net
 listeners
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Mar 01, 2018 at 06:12:57PM +0100, Paolo Bonzini wrote:
> On 01/03/2018 09:44, Peter Xu wrote:
> > Originally we were storing the GSources tag IDs.  That'll be not enough
> > if we are going to support non-default gcontext for QIO code.  Switch to
> > GSources without changing anything real.  Now we still always pass in
> > NULL, which means the default gcontext.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/io/net-listener.h | 21 ++++++++++++++--
> >  io/net-listener.c         | 62 +++++++++++++++++++++++++++++------------------
> >  2 files changed, 58 insertions(+), 25 deletions(-)
> > 
> > diff --git a/include/io/net-listener.h b/include/io/net-listener.h
> > index 56d6da7a76..566be283b3 100644
> > --- a/include/io/net-listener.h
> > +++ b/include/io/net-listener.h
> > @@ -53,7 +53,7 @@ struct QIONetListener {
> >  
> >      char *name;
> >      QIOChannelSocket **sioc;
> > -    gulong *io_tag;
> > +    GSource **io_source;
> >      size_t nsioc;
> >  
> >      bool connected;
> > @@ -120,17 +120,34 @@ void qio_net_listener_add(QIONetListener *listener,
> >                            QIOChannelSocket *sioc);
> >  
> >  /**
> > - * qio_net_listener_set_client_func:
> > + * qio_net_listener_set_client_func_full:
> >   * @listener: the network listener object
> >   * @func: the callback function
> >   * @data: opaque data to pass to @func
> >   * @notify: callback to free @data
> > + * @context: the context that the sources will be bound to
> 
> Please add a note like "if %NULL, the default context will be used".

Fixed this one too (and for both patches, I kept Dan's r-b).  Thanks,

-- 
Peter Xu
