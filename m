Received: from eggs.gnu.org ([2001:4830:134:3::10]:35379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYTeU-000695-Hi
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 03:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYTeR-0003qU-EC
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 03:18:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cYTeR-0003qH-6M
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 03:18:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<20170123105502.GH29186@stefanha-x1.localdomain>
	<10505721.4200193.1485170849535.JavaMail.zimbra@redhat.com>
	<20170124114302.GB17221@stefanha-x1.localdomain>
	<1305616133.813189.1485283397962.JavaMail.zimbra@redhat.com>
	<20170130134332.GB2118@stefanha-x1.localdomain>
	<1327323310.207981.1485800296146.JavaMail.zimbra@redhat.com>
	<1485848580.23903.14.camel@redhat.com>
Date: Tue, 31 Jan 2017 09:18:50 +0100
In-Reply-To: <1485848580.23903.14.camel@redhat.com> (Gerd Hoffmann's message
	of "Tue, 31 Jan 2017 08:43:00 +0100")
Message-ID: <87y3xriqvp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 00/25] qmp: add async command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>

Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>> > It would be nice for this series to evolve to a generic QMP jobs series
>> > so that all background operations are visible to the client and a useful
>> > subset of management primitives can be implemented on a per-command
>> > basis.  Both live migration and existing block jobs could use this code
>> > so that we don't have multiple copies of the same infrastructure.
>> 
>> Indeed, but I would need to know what proposal or requirements the
>> block layer have here, and I would appreciate if they took time to
>> review mine. 
>
> Disclaimer:  Havn't looked into the qmp (especially block jobs) details
> too much.
>
> But I suspect we can have both, sharing most of the infrastructure,
> without too much effort.
>
> We have block jobs today.  Other areas in qemu can use that too.  So
> moving the jobs infrastructure from block to qmp level makes perfect
> sense to me.  Live migration and possibly others can start using it.

Yes.  When everything uses a generic job infrastructure instead of
rolling their own, things get simpler and more regular.  Should take
less code, too, although backward compatibility might thwart that to a
degree.

> And once we have that building async commands on top of that is probably
> easy.  It'll be just a primitive job which typically takes at most a few
> seconds to finish, has no ->cancel() callback and sends a different kind
> of completion notification ...

Plausible.  "Can" doesn't imply "should", of course.

Here's my current thinking:

* "Jobs" are a generalization of the ad hoc ways we do long-running
  activities, including "block jobs" and migration.  Having one general
  way to do a common, non-trivial thing makes sense.

* Block people have wanted "jobs" for quite a while.  The limitations of
  the existing "block jobs" are getting painful.

* Given this "jobs" concept, asynchronous commands are a degenerate case
  of it.  Whether they are a common case, I can't say, yet.  How the
  special case fits into the whole, and whether it's worth having needs
  to be evaluated.

* Like Gerd, I think we should do jobs first.
