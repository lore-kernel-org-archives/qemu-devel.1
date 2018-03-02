Received: from eggs.gnu.org ([2001:4830:134:3::10]:44475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erbod-0007C6-KF
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 22:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erboZ-0008Gb-OI
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 22:57:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erboZ-0008GM-Jo
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 22:56:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24C6017CEF6
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 03:56:59 +0000 (UTC)
Date: Fri, 2 Mar 2018 11:56:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180302035652.GW27381@xz-mi>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-5-peterx@redhat.com>
	<20180301160344.GU14643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301160344.GU14643@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/15] migration: let incoming side use
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Thu, Mar 01, 2018 at 04:03:44PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 01, 2018 at 04:44:27PM +0800, Peter Xu wrote:
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
> > RDMA is not considered for now since it's not even using the QIO watc=
h
> > framework at all.
> >=20
> > CC: Juan Quintela <quintela@redhat.com>
> > CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > CC: Laurent Vivier <lvivier@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/exec.c   |  9 ++++-----
> >  migration/fd.c     |  9 ++++-----
> >  migration/socket.c | 10 +++++-----
> >  3 files changed, 13 insertions(+), 15 deletions(-)
>=20
> This should probably just be in a separate series, since it does nothin=
g
> on its own, and nothing following in this series touches migration at a=
ll.

It was trying to solve all problems related to QIO+context, and
migration is just one user of it.  But sure I can postpone this patch
to the postcopy recovery series.

Thanks,

--=20
Peter Xu
