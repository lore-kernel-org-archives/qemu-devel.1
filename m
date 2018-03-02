Received: from eggs.gnu.org ([2001:4830:134:3::10]:46726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ereQZ-0000RI-FQ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ereQW-0004bK-Cs
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:44:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53276 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ereQW-0004aq-8c
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:44:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2F7117CEF6
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 06:44:09 +0000 (UTC)
Date: Fri, 2 Mar 2018 14:43:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180302064359.GI27381@xz-mi>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-16-peterx@redhat.com>
	<814dcb27-0d79-9193-d6af-332ced804770@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <814dcb27-0d79-9193-d6af-332ced804770@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 15/15] chardev: tcp: postpone TLS work
 until machine done
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

On Thu, Mar 01, 2018 at 06:37:47PM +0100, Paolo Bonzini wrote:
> On 01/03/2018 09:44, Peter Xu wrote:
> > +static bool tcp_chr_machine_done;
> > +
> >  static void tcp_chr_reconn_timer_cancel(SocketChardev *s)
> >  {
> >      if (s->reconnect_timer) {
> > @@ -719,6 +721,11 @@ static void tcp_chr_tls_init(Chardev *chr)
> >      Error *err = NULL;
> >      gchar *name;
> >  
> > +    if (!tcp_chr_machine_done) {
> > +        /* This will be postponed to machine_done notifier */
> > +        return;
> > +    }
> > +
> 
> Can you instead add a global machine_init_done bool to vl.c and
> include/sysemu/sysemu.h (and make it always true in
> stubs/machine-init-done.c)?
> 
> Then muxes_realized can go away too.

Sure!  I'll add a new patch for it.  Thanks,

-- 
Peter Xu
