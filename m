Received: from eggs.gnu.org ([2001:4830:134:3::10]:58445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fLAt1-0005oR-LT
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fLAsw-0000Sz-Jo
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:15:47 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fLAsw-0000Sm-F2
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:15:42 -0400
Received: by mail-it0-f45.google.com with SMTP id e20-v6so915199itc.1
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 10:15:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180522110114.GC6233@localhost.localdomain>
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518184151.GA2479@work-vm>
	<20180522110114.GC6233@localhost.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 22 May 2018 19:15:40 +0200
Message-ID: <CAMxuvaxnRF4RJhjr3ZgM=w6EB=1vx_ZyE6BUdNnw=uUAu3bK7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/40] Generic background jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi

On Tue, May 22, 2018 at 1:01 PM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 18.05.2018 um 20:41 hat Dr. David Alan Gilbert geschrieben:
>> * Kevin Wolf (kwolf@redhat.com) wrote:
>> > Before we can make x-blockdev-create a background job, we need to
>> > generalise the job infrastructure so that it can be used without any
>> > associated block node.
>>
>> Is there any relationship between what this does, and what
>> Marc-Andr=C3=A9's 'monitor: add asynchronous command type' tries to do?
>> (See 20180326150916.9602-1-marcandre.lureau@redhat.com 26th March)
>
> Depends on who you ask. :-)
>
> In a way, yes. Marc-Andr=C3=A9's async commands are for long-running
> operations and jobs are for long-running operations. However, they are
> for a different kind of "long-running".
>
> Basically, Marc-Andr=C3=A9's work is for commands that are generally quic=
k,
> but perform some blocking operation. Usually commands that are currently
> implemented synchronously, but always bothered us because they block the
> VM for a while. They take maybe a few seconds at most, but you really
> don't want them to block the guest even for short time.
>
> The important part here is you don't want to modify the operations while
> they're running, they just send their return value when they are done.
> (In the latest version, Marc-Andr=C3=A9 even made sure not to modify the =
wire
> protocol, so IIUC the commands aren't really async any more in the sense
> that you can have multiple commands running, but they are just
> non-blocking in the sense that the guest can keep running while they are
> doing their work.)
>
> In comparison, jobs are typically really long running, like several
> minutes (like copying a whole disk image). Some of them can even run
> indefinitely (like mirroring) until you explicitly tell them to stop.
> You want to continue using the monitor while they are running, and to be
> able to manage them at runtime (pause/resume/set speed/cancel/...).
>
> So I think both address different problems.

I agree with Kevin that both address different needs and complement
each other. Right now, QMP commands are handled synchronous, so they
block the main thread (or the "OOB" thread). I needed a simple way to
handle them asynchronously, *without* breaking or changing an existing
QMP command API. Job, on the other hand, provides a lot of facilities
that are unnecessary for most short living commands, while adding
complexity, at the protocol level (for instance, by using an extra
"job-id" space and not being tied to the qmp session). Depending on
the facilities Job provide, and the guarantee that must hold when
using it, it may make sense or help to transform an existing command
to an asynchronous version, but I doubt many of the existing commands
will need it. However, if there is a need to introduce job-like
facilities to QMP async (such as running concurrent commands, listing
running commands, being able to cancel them, being notified on
progression etc), then I think we should be careful to use Job. For
now, this is unneeded, as QMP async is internal to qemu, the client
can't run anything  to manage an ongoing async command, so I think
both are improvements and will coexist harmoniously.
