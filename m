Received: from eggs.gnu.org ([2001:4830:134:3::10]:40449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d48F7-0000ol-AX
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d48F5-0003sQ-K5
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:55:37 -0400
Received: from mail-lf0-x231.google.com ([2a00:1450:4010:c07::231]:34865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d48F5-0003rV-6V
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:55:35 -0400
Received: by mail-lf0-x231.google.com with SMTP id 75so36211466lfs.2
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 08:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<87o9yv890z.fsf@dusky.pond.sub.org> <87lgqpei5d.fsf@dusky.pond.sub.org>
	<20170425102258.GA4615@noname.redhat.com>
In-Reply-To: <20170425102258.GA4615@noname.redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 28 Apr 2017 15:55:22 +0000
Message-ID: <CAJ+F1CKYUbMo-3TrkNfc+H3tzLUaN00c6sGTxdnPn5qapfA_bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/25] qmp: add async command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Hi

On Tue, Apr 25, 2017 at 2:23 PM Kevin Wolf <kwolf@redhat.com> wrote:

> Am 24.04.2017 um 21:10 hat Markus Armbruster geschrieben:
> > With 2.9 out of the way, how can we make progress on this one?
> >
> > I can see two ways to get asynchronous QMP commands accepted:
> >
> > 1. We break QMP compatibility in QEMU 3.0 and convert all long-running
> >    tasks from "synchronous command + event" to "asynchronous command".
> >
> >    This is design option 1 quoted below.  *If* we decide to leave
> >    compatibility behind for 3.0, *and* we decide we like the
> >    asynchronous sufficiently better to put in the work, we can do it.
> >
> >    I guess there's nothing to do here until we decide on breaking
> >    compatibility in 3.0.
> >
> > 2. We don't break QMP compatibility, but we add asynchronous commands
> >    anyway, because we decide that's how we want to do "jobs".
> >
> >    This is design option 3 quoted below.  As I said, I dislike its lack
> >    of orthogonality.  But if asynchronous commands help us get jobs
> >    done, I can bury my dislike.
>
> I don't think async commands are attractive at all for doing jobs. I
>

It's still a bit obscure to me what we mean by "jobs".

feel they bring up more questions that they answer, for example, what
> happens if libvirt crashes and then reconnects? Which monitor connection
> does get the reply for an async command sent on the now disconnected
> one?
>

The monitor to receive a reply is the one that sent the command (just like
return today)

As explained in the cover letter, an async command may cancel the ongoing
operation on disconnect.

If there is a global state change, a separate event should be broadcasted
(no change proposed here)


> We already have a model for doing long-running jobs, and as far as I'm
> aware, it's working and we're not fighting limitations of the design. So
> what are we even trying to solve here? In the context of jobs, async
> commands feel like a solution in need of a problem to me.
>
>
See the cover letter for the 2 main reasons for this proposal. If your
domain API is fine, you don't have to opt-in and you may continue to use
the current sync model. However, I believe there is benefit in using this
work to have a more consitent async API.

Things may look a bit different in typically quick, but potentially
> long-running commands. That is, anything that we currently execute
> synchronously while holding the BQL, but that involves I/O and could
> therefore take a while (impacting the performance of the VM) or even
> block indefinitely.
>
> The first problem (we're holding the lock too long) can be addressed by
> making things async just inside qemu and we don't need to expose the
> change on the QMP level. The second one (blocking indefinitely) requires
>

That's what I propose as 1)


> being async on the QMP level if we want the monitor to be responsive
> even if we're using an image on an NFS server that went down.
>

That's the 2)


>
> On the other hand, using the traditional job infrastructure is way over
> the top if all you want to do is 'query-block', so we need something
> different for making it async. And if a client disconnects, the
> 'query-block' result can just be thrown away, it's much simpler than
> actual jobs.
>

I agree a fully-featured job infrastructure is way over the top, and I
believe I propose a minimal change to make optionnally some QMP commands
async.

>
> So where I can see advantages for a new async command type is not for
> converting real long-running commands like block jobs, but only for the
> typically, but not necessarily quick operations. At the same time it is
> where you're rightfully afraid that the less common case might not
> receive much testing in management tools.
>

I believe management tools / libvirt will want to use the async variant if
available. (the sync version is a one-command at a time constrained version
of 'async')

>
> In the end, I'm unsure whether async commands are a good idea, I can see
> good arguments for both stances. But I'm almost certain that they are
> the wrong tool for jobs.
>
>
Well, we already have 'async' commands, they are just hidden. They do not
use QAPI/QMP facility and lack consistency.

This series addresses the problem 1), internal to qemu.

And also proposes to replace the idiomatic:

    -> { "execute": "do-foo",  "id": 42
}

    <- { "return": {}, "id": 42 }            (this is a dummy useless
return)
    (foo is in fact async, you may do other commands here)


    <- { "event": "FOO_DONE" }     (this is a broadcasted event that other
monitor may not know how to deal with, lack of consistency with naming for
various async op, "id" field may be lost, no facilities in generated code
etc etc)

with a streamlined:

    -> { "execute": "do-foo", "id": 42 }
    (you may do other commands here)


    <- { "return": {}, "id": 42 }       (returned only to the caller)
    (if there is a global state change, there should also be a FOO_DONE
event)

As pointed out in the cover letter, existing client *have to* deal with
dispatching unrelated messages when sending commands, because events may
come before a return message. So they have facilities to handle async
replies.

But in any case, this streamlined version is behind a "async" QMP
capability.

I have been careful to not expose this change to qemu internal or qemu
client if they don't want or need it.

thanks

I hope reviewing the series can help clarify the intent, and not put
various other ideas/dreams behind the "async" term.
--=20
Marc-Andr=C3=A9 Lureau
