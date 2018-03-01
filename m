Received: from eggs.gnu.org ([2001:4830:134:3::10]:53587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJug-0003OU-56
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJub-0000Mq-9F
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:50:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erJub-0000Me-3g
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:50:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A556B404084B
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 08:50:00 +0000 (UTC)
Date: Thu, 1 Mar 2018 16:49:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180301084950.GR27381@xz-mi>
References: <20180228050633.7410-1-peterx@redhat.com>
	<20180228050633.7410-14-peterx@redhat.com>
	<20180228092356.GF31550@redhat.com> <20180228130526.GK27381@xz-mi>
	<20180228132024.GJ17774@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228132024.GJ17774@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/14] qio: allow threaded qiotask to
 switch contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Feb 28, 2018 at 01:20:24PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Feb 28, 2018 at 09:05:26PM +0800, Peter Xu wrote:
> > On Wed, Feb 28, 2018 at 09:23:56AM +0000, Daniel P. Berrang=C3=A9 wro=
te:
> > > On Wed, Feb 28, 2018 at 01:06:32PM +0800, Peter Xu wrote:
> > > > This is the part of work to allow the QIOTask to use a different
> > > > gcontext rather than the default main gcontext, by providing
> > > > qio_task_context_set() API.
> > > >=20
> > > > We have done some work before on doing similar things to add non-=
default
> > > > gcontext support.  The general idea is that we delete the old GSo=
urce
> > > > from the main context, then re-add a new one to the new context w=
hen
> > > > context changed to a non-default one.  However this trick won't w=
ork
> > > > easily for threaded QIOTasks since we can't easily stop a real th=
read
> > > > and re-setup the whole thing from the very beginning.
> > >=20
> > > I think this entire usage pattern is really broken. We should not
> > > provide a way to change the GMainContext on an existing task. We
> > > should always just set the correct GMainContxt right from the start=
.
> > > This will avoid much of the complexity you're introducing into this
> > > patch series, and avoid having to expose GTasks to the callers of
> > > the async methods at all.
> >=20
> > Yeah I agree with you that the threaded QIO patches are complicated.
> > Then how about I introduce:
> >=20
> > - qio_task_thread_new(): to create QIO task and its thread (but not
> >                          running)
> > - qio_task_thread_run(): to run the thread
> >=20
> > Then I can setup the context correctly between the two in some way.
> >=20
> > After that, qio_task_run_in_thread() will be two calls of above two
> > APIs.
>=20
> I don't see why it is not enough to just pass the right GMainContext
> into qio_task_run_in_thread() immediately. There should not be any
> need to split this into two parts. ALl that's needed here is for the
> completion callback to rnu in the right context, which just means
> passing the GMainContext from qio_task_run_in_thread, through to
> qio_task_thread_worker via QIOTaskThreadData. Changing the GMainContext
> after the thread is already created/running is not something we should
> try todo.

I dropped patches 9-14 in version two and rewrote as you suggested, by
introducing a chardev machine done notifier.  Please have a looks.  Thank=
s,

--=20
Peter Xu
