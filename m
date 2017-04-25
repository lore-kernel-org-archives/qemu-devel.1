Received: from eggs.gnu.org ([2001:4830:134:3::10]:47275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d2xcn-0003Ga-Cb
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d2xck-00026m-1u
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:23:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1d2xcj-00024Q-OO
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:23:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8FEE466C9D
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 10:23:07 +0000 (UTC)
Date: Tue, 25 Apr 2017 12:22:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170425102258.GA4615@noname.redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<87o9yv890z.fsf@dusky.pond.sub.org>
	<87lgqpei5d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lgqpei5d.fsf@dusky.pond.sub.org>
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 24.04.2017 um 21:10 hat Markus Armbruster geschrieben:
> With 2.9 out of the way, how can we make progress on this one?
> 
> I can see two ways to get asynchronous QMP commands accepted:
> 
> 1. We break QMP compatibility in QEMU 3.0 and convert all long-running
>    tasks from "synchronous command + event" to "asynchronous command".
> 
>    This is design option 1 quoted below.  *If* we decide to leave
>    compatibility behind for 3.0, *and* we decide we like the
>    asynchronous sufficiently better to put in the work, we can do it.
> 
>    I guess there's nothing to do here until we decide on breaking
>    compatibility in 3.0.
> 
> 2. We don't break QMP compatibility, but we add asynchronous commands
>    anyway, because we decide that's how we want to do "jobs".
> 
>    This is design option 3 quoted below.  As I said, I dislike its lack
>    of orthogonality.  But if asynchronous commands help us get jobs
>    done, I can bury my dislike.

I don't think async commands are attractive at all for doing jobs. I
feel they bring up more questions that they answer, for example, what
happens if libvirt crashes and then reconnects? Which monitor connection
does get the reply for an async command sent on the now disconnected
one?

We already have a model for doing long-running jobs, and as far as I'm
aware, it's working and we're not fighting limitations of the design. So
what are we even trying to solve here? In the context of jobs, async
commands feel like a solution in need of a problem to me.

Things may look a bit different in typically quick, but potentially
long-running commands. That is, anything that we currently execute
synchronously while holding the BQL, but that involves I/O and could
therefore take a while (impacting the performance of the VM) or even
block indefinitely.

The first problem (we're holding the lock too long) can be addressed by
making things async just inside qemu and we don't need to expose the
change on the QMP level. The second one (blocking indefinitely) requires
being async on the QMP level if we want the monitor to be responsive
even if we're using an image on an NFS server that went down.

On the other hand, using the traditional job infrastructure is way over
the top if all you want to do is 'query-block', so we need something
different for making it async. And if a client disconnects, the
'query-block' result can just be thrown away, it's much simpler than
actual jobs.

So where I can see advantages for a new async command type is not for
converting real long-running commands like block jobs, but only for the
typically, but not necessarily quick operations. At the same time it is
where you're rightfully afraid that the less common case might not
receive much testing in management tools.

In the end, I'm unsure whether async commands are a good idea, I can see
good arguments for both stances. But I'm almost certain that they are
the wrong tool for jobs.

Kevin
