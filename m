Received: from eggs.gnu.org ([2001:4830:134:3::10]:35875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erFuY-0006Gl-1L
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 23:33:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erFuT-0002N4-HS
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 23:33:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erFuT-0002Mg-Cq
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 23:33:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD3028182D2E
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 04:33:33 +0000 (UTC)
Date: Thu, 1 Mar 2018 12:33:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180301043322.GO27381@xz-mi>
References: <20180228050633.7410-1-peterx@redhat.com>
	<20180228050633.7410-5-peterx@redhat.com>
	<20180228091058.GC31550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228091058.GC31550@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/14] migration: let incoming side use
 thread context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Wed, Feb 28, 2018 at 09:10:58AM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Feb 28, 2018 at 01:06:23PM +0800, Peter Xu wrote:
> > The old incoming migration is running in main thread and default
> > gcontext.  With the new qio_channel_add_watch_full() we can now let i=
t
> > run in the thread's own gcontext (if there is one).
> >=20
> > Currently this patch does nothing alone.  But when any of the incomin=
g
> > migration is run in another iothread (e.g., the upcoming migrate-reco=
ver
> > command), this patch will bind the incoming logic to the iothread
> > instead of the main thread (which may already get page faulted and
> > hanged).
> >=20
> > RDMA is not considered for now since it's not even using the QIO APIs=
 at
> > all.
>=20
> Errm, yes, it is.
>=20
>   struct QIOChannelRDMA {
>     QIOChannel parent;
>     RDMAContext *rdma;
>     QEMUFile *file;
>     size_t len;
>     bool blocking; /* XXX we don't actually honour this yet */
>   };
>   ....

Ah, you are right. :)

I should say that "it's not using QIO watch framework" since it's
using qemu_set_fd_handler() so it's always on main thread.

Thanks,

--=20
Peter Xu
