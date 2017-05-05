Received: from eggs.gnu.org ([2001:4830:134:3::10]:47935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6cLH-0008Hx-RM
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6cLC-0001qK-Tl
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:28:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1d6cLC-0001pw-L5
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:28:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66B5B2D9FC4
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 12:28:09 +0000 (UTC)
Date: Fri, 5 May 2017 14:27:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170505122735.GA6047@noname.redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<87mvaszbsu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mvaszbsu.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 00/25] qmp: add async command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 04.05.2017 um 21:01 hat Markus Armbruster geschrieben:
> Now let me take a step back: we need to crack the "jobs" problem anyway.
> Merging this series now would in a way add another special case of the
> general case "jobs" before adding the general case.  In other words,
> create more stuff to unify.

It's actually not obvious to me that both cases should be using the same
infrastructure. The primary target for jobs as we discussed them in the
past are true long running operations (and in some common cases even
indefinitely, until the user stops them), whereas for async commands the
primary target are "quick, but not that quick" operations.

Today, all jobs have a unique job ID, all of them can be paused, all of
them send completion/cancellation events, and similar things that make a
lot of sense for true long running operations, but are either useless
overhead or can't even be implemented for quick operations. The
unification would potentially lead to many special cases in the job
infrastructure to allow e.g. anonymous jobs, jobs that aren't listed in
query-jobs, jobs that don't accept basic management commands like pause,
jobs that don't send completion events, etc. Would the (superficially)
unified infrastructure really be worth the special cases?

Just to be clear, I am not necessarily against unifying these two
classes of operations in our infrastructure if it makes sense, but they
seem to be distinct enough that I feel we should have a little more
arguments for it than just "they are the same anyway".

> > The benefits of async commands that can be trade-off depending on the
> > requirements are:
> >
> > 1) allow the command handler to re-enter the main loop if the command
> > cannot be handled synchronously, or if it is long-lasting. This is
> > currently not possible and make some bugs such as rhbz#1230527 tricky
> > (see below) to solve.  Furthermore, many QMP commands do IO and could
> > be considered 'slow' and blocking today.

In any case, I think we can go forward with this one, right? This should
be useful work no matter what we end up doing with the external
interface. I've long wished that QMP handlers could be executed in a
coroutine and yield while they are doing I/O.

> > 2) allow concurrent commands and events. This mainly implies hanlding
> > concurrency in qemu and out-of-order replies for the client. As noted
> > earlier, a good qmp client already has to handle dispatching of
> > received messages (reply and events).

And it's only this one that should wait for generic jobs.

Kevin
