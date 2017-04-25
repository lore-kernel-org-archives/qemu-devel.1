Received: from eggs.gnu.org ([2001:4830:134:3::10]:56987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2wXn-0003w2-5x
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2wXj-0007u1-6V
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:13:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d2wXi-0007tk-Tv
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:13:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DDA2F7F4D2
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 09:13:53 +0000 (UTC)
Date: Tue, 25 Apr 2017 10:13:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170425091342.GC21129@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<87o9yv890z.fsf@dusky.pond.sub.org>
	<87lgqpei5d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

On Mon, Apr 24, 2017 at 09:10:22PM +0200, Markus Armbruster wrote:
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

>From the libvirt POV we'll generally be against QEMU breaking back
compatibility, if there's a viable option which can avoid the back
compat breakage.

Is it possible to do option 1, but have it be an opt-in. ie when
libvirt does the initial QMP greeting, it could issue a command
to active async mode. For simplicity that could be an all-or-nothing
switch - ie makes all commands be async. That way we avoid breaking
any existing libvirt, but give new libvirt the chance to opt-in to
the new way.

Regardless new libvirt will end up having to support both modes of
QMP for 5-10 years...

> 2. We don't break QMP compatibility, but we add asynchronous commands
>    anyway, because we decide that's how we want to do "jobs".
> 
>    This is design option 3 quoted below.  As I said, I dislike its lack
>    of orthogonality.  But if asynchronous commands help us get jobs
>    done, I can bury my dislike.
> 
>    I feel this is something you should investigate with John Snow.
>    Going through a middleman (me) makes no sense.  So I'm going to dump
>    my thoughts, then get out of the way.
> 
>    You need to take care not to get bogged down in the jobs project's
>    complexity.  This is really only how to package up jobs for QMP.
> 
>    With synchronous commands, the job-creating command creates a job,
>    jobs state changes trigger events, and job termination is just
>    another state change.  Job control commands interact with the job.
>  
>    Events obviously need to carry a job ID.  We can either require the
>    user to pass it as argument to the job-creating command (hopefully
>    unique), or have the job-creating command pick one (a unique one) and
>    return it.
> 
>    With asynchronous commands, we could make the asynchronous command
>    the job.  The only difference is that job termination triggers the
>    command response.  When termination is of no interest to anyone but
>    the job's creator, the termination event can be omitted then.
> 
>    Instead of a job ID, we could use the (user-specified and hopefully
>    unique) command ID that ties the command response to the command.
>    Perhaps throw in a monitor ID.
> 
>    To be honest, I'm not sure asynchronous commands buy us much here.
>    But my view is from 10,000 feet, and John might have different ideas.
> 
> Rejecting asynchronous QMP commands is of course design option 2 quoted
> below.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
